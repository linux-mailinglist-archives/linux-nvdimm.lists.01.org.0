Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED142FEA06
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Jan 2021 13:29:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7ADAB100EB358;
	Thu, 21 Jan 2021 04:29:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7AC8B100EB358
	for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 04:29:10 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F5F223A04;
	Thu, 21 Jan 2021 12:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1611232150;
	bh=HR3TKghucZ11bpxJACXPfexGlGSNBiuPA9J9vXBDKNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGXYup+M8oFWw53bsRjy829mtelBQ5D6L7oDjzoXcg0kc3JFaxBv6u7OXbwROQH26
	 IiSZ/3VeIKv+Y3/K/O2Zhg12Qmf4+VSl7eeq/Hp3DLYXaWOaS6XB4kQ8TzdffledrL
	 IlKg3HpG+JNqtTL5QOG5LXMcTD/YC7bI4uUb9kSw7+xyQt1f4oFUocC7MjPQ2GUEMI
	 goE7w6tF6juPh7mVUEjXVC6GrZdm7nY4olcErC5MVZqYTNew8/b8i7jHiz9WBUX4GN
	 +gGZ2fzeN4apFGsAAFvJLq5dAW55Rc7O74FFoMuPvNkLbhQ8asFZY/AblLspCxa7LG
	 vn8jveUpGkYkw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v16 09/11] PM: hibernate: disable when there are active secretmem users
Date: Thu, 21 Jan 2021 14:27:21 +0200
Message-Id: <20210121122723.3446-10-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210121122723.3446-1-rppt@kernel.org>
References: <20210121122723.3446-1-rppt@kernel.org>
MIME-Version: 1.0
Message-ID-Hash: 62TET7CYO5TJAA7DEN5HE4EQYGWHSMKD
X-Message-ID-Hash: 62TET7CYO5TJAA7DEN5HE4EQYGWHSMKD
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <
 tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/62TET7CYO5TJAA7DEN5HE4EQYGWHSMKD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Mike Rapoport <rppt@linux.ibm.com>

It is unsafe to allow saving of secretmem areas to the hibernation snapshot
as they would be visible after the resume and this essentially will defeat
the purpose of secret memory mappings.

Prevent hibernation whenever there are active secret memory users.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christopher Lameter <cl@linux.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tycho Andersen <tycho@tycho.ws>
Cc: Will Deacon <will@kernel.org>
---
 include/linux/secretmem.h |  6 ++++++
 kernel/power/hibernate.c  |  5 ++++-
 mm/secretmem.c            | 15 +++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index 70e7db9f94fe..907a6734059c 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -6,6 +6,7 @@
 
 bool vma_is_secretmem(struct vm_area_struct *vma);
 bool page_is_secretmem(struct page *page);
+bool secretmem_active(void);
 
 #else
 
@@ -19,6 +20,11 @@ static inline bool page_is_secretmem(struct page *page)
 	return false;
 }
 
+static inline bool secretmem_active(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_SECRETMEM */
 
 #endif /* _LINUX_SECRETMEM_H */
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index da0b41914177..559acef3fddb 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -31,6 +31,7 @@
 #include <linux/genhd.h>
 #include <linux/ktime.h>
 #include <linux/security.h>
+#include <linux/secretmem.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -81,7 +82,9 @@ void hibernate_release(void)
 
 bool hibernation_available(void)
 {
-	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
+	return nohibernate == 0 &&
+		!security_locked_down(LOCKDOWN_HIBERNATION) &&
+		!secretmem_active();
 }
 
 /**
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 05026460e2ee..6ef32ad08184 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -45,6 +45,13 @@ struct secretmem_ctx {
 
 static struct cma *secretmem_cma;
 
+static atomic_t secretmem_users;
+
+bool secretmem_active(void)
+{
+	return !!atomic_read(&secretmem_users);
+}
+
 static int secretmem_account_pages(struct page *page, gfp_t gfp, int order)
 {
 	int err;
@@ -193,6 +200,12 @@ static const struct vm_operations_struct secretmem_vm_ops = {
 	.fault = secretmem_fault,
 };
 
+static int secretmem_release(struct inode *inode, struct file *file)
+{
+	atomic_dec(&secretmem_users);
+	return 0;
+}
+
 static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	unsigned long len = vma->vm_end - vma->vm_start;
@@ -215,6 +228,7 @@ bool vma_is_secretmem(struct vm_area_struct *vma)
 }
 
 static const struct file_operations secretmem_fops = {
+	.release	= secretmem_release,
 	.mmap		= secretmem_mmap,
 };
 
@@ -330,6 +344,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned long, flags)
 	file->f_flags |= O_LARGEFILE;
 
 	fd_install(fd, file);
+	atomic_inc(&secretmem_users);
 	return fd;
 
 err_put_fd:
-- 
2.28.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
