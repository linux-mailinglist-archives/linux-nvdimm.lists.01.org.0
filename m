Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F217136962
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Jun 2019 03:45:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DDE0F212909FB;
	Wed,  5 Jun 2019 18:45:11 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 073B521A00AE6
 for <linux-nvdimm@lists.01.org>; Wed,  5 Jun 2019 18:45:09 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jun 2019 18:45:09 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga002.jf.intel.com with ESMTP; 05 Jun 2019 18:45:09 -0700
From: ira.weiny@intel.com
To: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
 "Theodore Ts'o" <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
 Dave Chinner <david@fromorbit.com>
Subject: [PATCH RFC 01/10] fs/locks: Add trace_leases_conflict
Date: Wed,  5 Jun 2019 18:45:34 -0700
Message-Id: <20190606014544.8339-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606014544.8339-1-ira.weiny@intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
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
Cc: linux-nvdimm@lists.01.org, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Ira Weiny <ira.weiny@intel.com>

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/locks.c                      | 20 ++++++++++++++-----
 include/trace/events/filelock.h | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index ec1e4a5df629..0cc2b9f30e22 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1534,11 +1534,21 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 
 static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
 {
-	if ((breaker->fl_flags & FL_LAYOUT) != (lease->fl_flags & FL_LAYOUT))
-		return false;
-	if ((breaker->fl_flags & FL_DELEG) && (lease->fl_flags & FL_LEASE))
-		return false;
-	return locks_conflict(breaker, lease);
+	bool rc;
+
+	if ((breaker->fl_flags & FL_LAYOUT) != (lease->fl_flags & FL_LAYOUT)) {
+		rc = false;
+		goto trace;
+	}
+	if ((breaker->fl_flags & FL_DELEG) && (lease->fl_flags & FL_LEASE)) {
+		rc = false;
+		goto trace;
+	}
+
+	rc = locks_conflict(breaker, lease);
+trace:
+	trace_leases_conflict(rc, lease, breaker);
+	return rc;
 }
 
 static bool
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index fad7befa612d..4b735923f2ff 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -203,6 +203,41 @@ TRACE_EVENT(generic_add_lease,
 		show_fl_type(__entry->fl_type))
 );
 
+TRACE_EVENT(leases_conflict,
+	TP_PROTO(bool conflict, struct file_lock *lease, struct file_lock *breaker),
+
+	TP_ARGS(conflict, lease, breaker),
+
+	TP_STRUCT__entry(
+		__field(void *, lease)
+		__field(void *, breaker)
+		__field(unsigned int, l_fl_flags)
+		__field(unsigned int, b_fl_flags)
+		__field(unsigned char, l_fl_type)
+		__field(unsigned char, b_fl_type)
+		__field(bool, conflict)
+	),
+
+	TP_fast_assign(
+		__entry->lease = lease;
+		__entry->l_fl_flags = lease->fl_flags;
+		__entry->l_fl_type = lease->fl_type;
+		__entry->breaker = breaker;
+		__entry->b_fl_flags = breaker->fl_flags;
+		__entry->b_fl_type = breaker->fl_type;
+		__entry->conflict = conflict;
+	),
+
+	TP_printk("conflict %d: lease=0x%p fl_flags=%s fl_type=%s; breaker=0x%p fl_flags=%s fl_type=%s",
+		__entry->conflict,
+		__entry->lease,
+		show_fl_flags(__entry->l_fl_flags),
+		show_fl_type(__entry->l_fl_type),
+		__entry->breaker,
+		show_fl_flags(__entry->b_fl_flags),
+		show_fl_type(__entry->b_fl_type))
+);
+
 #endif /* _TRACE_FILELOCK_H */
 
 /* This part must be outside protection */
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
