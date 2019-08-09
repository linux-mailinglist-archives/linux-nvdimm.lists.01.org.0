Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712B888658
	for <lists+linux-nvdimm@lfdr.de>; Sat, 10 Aug 2019 00:59:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 582D92131EC6B;
	Fri,  9 Aug 2019 16:01:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A694C21309DCA
 for <linux-nvdimm@lists.01.org>; Fri,  9 Aug 2019 16:01:44 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Aug 2019 15:59:03 -0700
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; d="scan'208";a="259172583"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Aug 2019 15:59:01 -0700
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH v2 13/19] {mm,file}: Add file_pins objects
Date: Fri,  9 Aug 2019 15:58:27 -0700
Message-Id: <20190809225833.6657-14-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809225833.6657-1-ira.weiny@intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Dave Chinner <david@fromorbit.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Ira Weiny <ira.weiny@intel.com>

User page pins (aka GUP) needs to track file information of files being
pinned by those calls.  Depending on the needs of the caller this
information is stored in 1 of 2 ways.

1) Some subsystems like RDMA associate GUP pins with file descriptors
   which can be passed around to other process'.  In this case a file
   being pined must be associated with an owning file object (which can
   then be resolved back to any of the processes which have a file
   descriptor 'pointing' to that file object).

2) Other subsystems do not have an owning file and can therefore
   associate the file pin directly to the mm of the process which
   created them.

This patch introduces the new file pin structures and ensures struct
file and struct mm_struct are prepared to store them.

In subsequent patches the required information will be passed into new
pin page calls and procfs is enhanced to show this information to the user.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/file_table.c          |  4 ++++
 include/linux/file.h     | 49 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h       |  2 ++
 include/linux/mm_types.h |  2 ++
 kernel/fork.c            |  3 +++
 5 files changed, 60 insertions(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index b07b53f24ff5..38947b9a4769 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -46,6 +46,7 @@ static void file_free_rcu(struct rcu_head *head)
 {
 	struct file *f = container_of(head, struct file, f_u.fu_rcuhead);
 
+	WARN_ON(!list_empty(&f->file_pins));
 	put_cred(f->f_cred);
 	kmem_cache_free(filp_cachep, f);
 }
@@ -118,6 +119,9 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
 	f->f_mode = OPEN_FMODE(flags);
 	/* f->f_version: 0 */
 
+	INIT_LIST_HEAD(&f->file_pins);
+	spin_lock_init(&f->fp_lock);
+
 	return f;
 }
 
diff --git a/include/linux/file.h b/include/linux/file.h
index 3fcddff56bc4..cd79adad5b23 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/posix_types.h>
+#include <linux/kref.h>
 
 struct file;
 
@@ -91,4 +92,52 @@ extern void fd_install(unsigned int fd, struct file *file);
 extern void flush_delayed_fput(void);
 extern void __fput_sync(struct file *);
 
+/**
+ * struct file_file_pin
+ *
+ * Associate a pin'ed file with another file owner.
+ *
+ * Subsystems such as RDMA have the ability to pin memory which is associated
+ * with a file descriptor which can be passed to other processes without
+ * necessarily having that memory accessed in the remote processes address
+ * space.
+ *
+ * @file file backing memory which was pined by a GUP caller
+ * @f_owner the file representing the GUP owner
+ * @list of all file pins this owner has
+ *       (struct file *)->file_pins
+ * @ref number of times this pin was taken (roughly the number of pages pinned
+ *      in the file)
+ */
+struct file_file_pin {
+	struct file *file;
+	struct file *f_owner;
+	struct list_head list;
+	struct kref ref;
+};
+
+/*
+ * struct mm_file_pin
+ *
+ * Some GUP callers do not have an "owning" file.  Those pins are accounted for
+ * in the mm of the process that called GUP.
+ *
+ * The tuple {file, inode} is used to track this as a unique file pin and to
+ * track when this pin has been removed.
+ *
+ * @file file backing memory which was pined by a GUP caller
+ * @mm back point to owning mm
+ * @inode backing the file
+ * @list of all file pins this owner has
+ *       (struct mm_struct *)->file_pins
+ * @ref number of times this pin was taken
+ */
+struct mm_file_pin {
+	struct file *file;
+	struct mm_struct *mm;
+	struct inode *inode;
+	struct list_head list;
+	struct kref ref;
+};
+
 #endif /* __LINUX_FILE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2e41ce547913..d2e08feb9737 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -963,6 +963,8 @@ struct file {
 #endif /* #ifdef CONFIG_EPOLL */
 	struct address_space	*f_mapping;
 	errseq_t		f_wb_err;
+	struct list_head        file_pins;
+	spinlock_t              fp_lock;
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6a7a1083b6fb..4f6ea4acddbd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -516,6 +516,8 @@ struct mm_struct {
 		/* HMM needs to track a few things per mm */
 		struct hmm *hmm;
 #endif
+		struct list_head file_pins;
+		spinlock_t fp_lock; /* lock file_pins */
 	} __randomize_layout;
 
 	/*
diff --git a/kernel/fork.c b/kernel/fork.c
index 0e2f9a2c132c..093f2f2fce1a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -675,6 +675,7 @@ void __mmdrop(struct mm_struct *mm)
 	BUG_ON(mm == &init_mm);
 	WARN_ON_ONCE(mm == current->mm);
 	WARN_ON_ONCE(mm == current->active_mm);
+	WARN_ON(!list_empty(&mm->file_pins));
 	mm_free_pgd(mm);
 	destroy_context(mm);
 	mmu_notifier_mm_destroy(mm);
@@ -1013,6 +1014,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm->pmd_huge_pte = NULL;
 #endif
 	mm_init_uprobes_state(mm);
+	INIT_LIST_HEAD(&mm->file_pins);
+	spin_lock_init(&mm->fp_lock);
 
 	if (current->mm) {
 		mm->flags = current->mm->flags & MMF_INIT_MASK;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
