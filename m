Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B8D205D9E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Jun 2020 22:18:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 07FDC10FC38BC;
	Tue, 23 Jun 2020 13:18:16 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 180F710FC3777
	for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 13:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=VIdBkQ30OpCDFNPzKi0j+8kvvZep5eO/HQpin6mUjCQ=; b=E58Tf+iew5tgAJd7QhwQ4EizCT
	pHq+L0Zjt915GoeZuZhMHkvSR95EBiEoElAkRN7nwwIi3ZVpZfeGZHUKGe4RIpN8XQsqT6rDjA9Or
	55SfjDRSiN5oulM/Fqyk6lNYNN2BPRHPOuwZPt+V46/ZCPGasbjb+8l0OEiNGDZGSA0Yb9rv32aFo
	bJCPaIxs0eQXJtB77h+Ku3nSbHg21n2uhr7O5AeJMeAKGtfUIePwzu3UtZEvqiZunEg/SiFORcTR6
	rgs8tB81U9hIIyPs8wVRU6/gQd39SQzUM29Z3PbIEXomMTNt0CJRL+7hFaAXSOXanuH6OZvGewl6B
	4LYkj2nA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnpMX-0002oS-Tu; Tue, 23 Jun 2020 20:17:46 +0000
Date: Tue, 23 Jun 2020 21:17:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	linux-edac@vger.kernel.org, linux-mm@kvack.org,
	linux-nvdimm@lists.01.org,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Jane Chu <jane.chu@oracle.com>
Subject: [RFC] Make the memory failure blast radius more precise
Message-ID: <20200623201745.GG21350@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-ID-Hash: JOO4VWWNLBA64INF52KQC2SFPV7YJQVD
X-Message-ID-Hash: JOO4VWWNLBA64INF52KQC2SFPV7YJQVD
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JOO4VWWNLBA64INF52KQC2SFPV7YJQVD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hardware actually tells us the blast radius of the error, but we ignore
it and take out the entire page.  We've had a customer request to know
exactly how much of the page is damaged so they can avoid reconstructing
an entire 2MB page if only a single cacheline is damaged.

This is only a strawman that I did in an hour or two; I'd appreciate
architectural-level feedback.  Should I just convert memory_failure() to
always take an address & granularity?  Should I create a struct to pass
around (page, phys, granularity) instead of reconstructing the missing
pieces in half a dozen functions?  Is this functionality welcome at all,
or is the risk of upsetting applications which expect at least a page
of granularity too high?

I can see places where I've specified a plain PAGE_SHIFT insted of
interrogating a compound page for its size.  I'd probably split this
patch up into two or three pieces for applying.

I've also blindly taken out the call to unmap_mapping_range().  Again,
the customer requested that we not do this.  That deserves to be in its
own patch and properly justified.

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ce9120c4f740..09978c5b9493 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -463,7 +463,7 @@ static void mce_irq_work_cb(struct irq_work *entry)
  * Check if the address reported by the CPU is in a format we can parse.
  * It would be possible to add code for most other cases, but all would
  * be somewhat complicated (e.g. segment offset would require an instruction
- * parser). So only support physical addresses up to page granuality for now.
+ * parser). So only support physical addresses up to page granularity for now.
  */
 int mce_usable_address(struct mce *m)
 {
@@ -570,7 +570,6 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
 	struct mce *mce = (struct mce *)data;
-	unsigned long pfn;
 
 	if (!mce || !mce_usable_address(mce))
 		return NOTIFY_DONE;
@@ -579,9 +578,8 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 	    mce->severity != MCE_DEFERRED_SEVERITY)
 		return NOTIFY_DONE;
 
-	pfn = mce->addr >> PAGE_SHIFT;
-	if (!memory_failure(pfn, 0)) {
-		set_mce_nospec(pfn, whole_page(mce));
+	if (!__memory_failure(mce->addr, MCI_MISC_ADDR_LSB(mce->misc), 0)) {
+		set_mce_nospec(mce->addr >> PAGE_SHIFT, whole_page(mce));
 		mce->kflags |= MCE_HANDLED_UC;
 	}
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc7b87310c10..f2ea6491df28 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3035,7 +3035,14 @@ enum mf_flags {
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
 };
-extern int memory_failure(unsigned long pfn, int flags);
+
+int __memory_failure(unsigned long addr, unsigned int granularity, int flags);
+
+static inline int memory_failure(unsigned long pfn, int flags)
+{
+	return __memory_failure(pfn << PAGE_SHIFT, PAGE_SHIFT, flags);
+}
+
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 47b8ccb1fb9b..775b053dcd98 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -198,7 +198,7 @@ struct to_kill {
 	struct list_head nd;
 	struct task_struct *tsk;
 	unsigned long addr;
-	short size_shift;
+	short granularity;
 };
 
 /*
@@ -209,7 +209,7 @@ struct to_kill {
 static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 {
 	struct task_struct *t = tk->tsk;
-	short addr_lsb = tk->size_shift;
+	short addr_lsb = tk->granularity;
 	int ret = 0;
 
 	pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
@@ -262,40 +262,6 @@ void shake_page(struct page *p, int access)
 }
 EXPORT_SYMBOL_GPL(shake_page);
 
-static unsigned long dev_pagemap_mapping_shift(struct page *page,
-		struct vm_area_struct *vma)
-{
-	unsigned long address = vma_address(page, vma);
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	pgd = pgd_offset(vma->vm_mm, address);
-	if (!pgd_present(*pgd))
-		return 0;
-	p4d = p4d_offset(pgd, address);
-	if (!p4d_present(*p4d))
-		return 0;
-	pud = pud_offset(p4d, address);
-	if (!pud_present(*pud))
-		return 0;
-	if (pud_devmap(*pud))
-		return PUD_SHIFT;
-	pmd = pmd_offset(pud, address);
-	if (!pmd_present(*pmd))
-		return 0;
-	if (pmd_devmap(*pmd))
-		return PMD_SHIFT;
-	pte = pte_offset_map(pmd, address);
-	if (!pte_present(*pte))
-		return 0;
-	if (pte_devmap(*pte))
-		return PAGE_SHIFT;
-	return 0;
-}
-
 /*
  * Failure handling: if we can't find or can't kill a process there's
  * not much we can do.	We just print a message and ignore otherwise.
@@ -306,8 +272,8 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
  */
 static void add_to_kill(struct task_struct *tsk, struct page *p,
-		       struct vm_area_struct *vma,
-		       struct list_head *to_kill)
+			unsigned int offset, unsigned int granularity,
+			struct vm_area_struct *vma, struct list_head *to_kill)
 {
 	struct to_kill *tk;
 
@@ -318,27 +284,14 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 	}
 
 	tk->addr = page_address_in_vma(p, vma);
-	if (is_zone_device_page(p))
-		tk->size_shift = dev_pagemap_mapping_shift(p, vma);
-	else
-		tk->size_shift = page_shift(compound_head(p));
+	tk->granularity = granularity;
 
-	/*
-	 * Send SIGKILL if "tk->addr == -EFAULT". Also, as
-	 * "tk->size_shift" is always non-zero for !is_zone_device_page(),
-	 * so "tk->size_shift == 0" effectively checks no mapping on
-	 * ZONE_DEVICE. Indeed, when a devdax page is mmapped N times
-	 * to a process' address space, it's possible not all N VMAs
-	 * contain mappings for the page, but at least one VMA does.
-	 * Only deliver SIGBUS with payload derived from the VMA that
-	 * has a mapping for the page.
-	 */
+	/* Send SIGKILL if "tk->addr == -EFAULT". */
 	if (tk->addr == -EFAULT) {
 		pr_info("Memory failure: Unable to find user space address %lx in %s\n",
 			page_to_pfn(p), tsk->comm);
-	} else if (tk->size_shift == 0) {
-		kfree(tk);
-		return;
+	} else {
+		tk->addr += offset;
 	}
 
 	get_task_struct(tsk);
@@ -468,7 +421,8 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, 0, PAGE_SHIFT, vma,
+						to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -478,8 +432,8 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 /*
  * Collect processes when the error hit a file mapped page.
  */
-static void collect_procs_file(struct page *page, struct list_head *to_kill,
-				int force_early)
+static void collect_procs_file(struct page *page, unsigned int offset,
+		short granularity, struct list_head *to_kill, int force_early)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
@@ -503,7 +457,8 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			 * to be informed of all such data corruptions.
 			 */
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill);
+				add_to_kill(t, page, 0, PAGE_SHIFT, vma,
+						to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -513,8 +468,8 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 /*
  * Collect the processes who have the corrupted page mapped to kill.
  */
-static void collect_procs(struct page *page, struct list_head *tokill,
-				int force_early)
+static void collect_procs(struct page *page, unsigned int offset,
+		short granularity, struct list_head *tokill, int force_early)
 {
 	if (!page->mapping)
 		return;
@@ -522,7 +477,8 @@ static void collect_procs(struct page *page, struct list_head *tokill,
 	if (PageAnon(page))
 		collect_procs_anon(page, tokill, force_early);
 	else
-		collect_procs_file(page, tokill, force_early);
+		collect_procs_file(page, offset, granularity, tokill,
+				force_early);
 }
 
 static const char *action_name[] = {
@@ -1026,7 +982,8 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * there's nothing that can be done.
 	 */
 	if (kill)
-		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
+		collect_procs(hpage, 0, PAGE_SHIFT, &tokill,
+				flags & MF_ACTION_REQUIRED);
 
 	if (!PageHuge(hpage)) {
 		unmap_success = try_to_unmap(hpage, ttu);
@@ -1176,16 +1133,14 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	return res;
 }
 
-static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
-		struct dev_pagemap *pgmap)
+static int memory_failure_dev_pagemap(unsigned long addr, short granularity,
+		int flags, struct dev_pagemap *pgmap)
 {
+	unsigned long pfn = addr >> PAGE_SHIFT;
 	struct page *page = pfn_to_page(pfn);
 	const bool unmap_success = true;
-	unsigned long size = 0;
-	struct to_kill *tk;
 	LIST_HEAD(tokill);
 	int rc = -EBUSY;
-	loff_t start;
 	dax_entry_t cookie;
 
 	/*
@@ -1225,21 +1180,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	 * SIGBUS (i.e. MF_MUST_KILL)
 	 */
 	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
-	collect_procs(page, &tokill, flags & MF_ACTION_REQUIRED);
-
-	list_for_each_entry(tk, &tokill, nd)
-		if (tk->size_shift)
-			size = max(size, 1UL << tk->size_shift);
-	if (size) {
-		/*
-		 * Unmap the largest mapping to avoid breaking up
-		 * device-dax mappings which are constant size. The
-		 * actual size of the mapping being torn down is
-		 * communicated in siginfo, see kill_proc()
-		 */
-		start = (page->index << PAGE_SHIFT) & ~(size - 1);
-		unmap_mapping_range(page->mapping, start, start + size, 0);
-	}
+	collect_procs(page, offset_in_page(addr), granularity, &tokill,
+			flags & MF_ACTION_REQUIRED);
 	kill_procs(&tokill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
 	rc = 0;
 unlock:
@@ -1252,8 +1194,9 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 }
 
 /**
- * memory_failure - Handle memory failure of a page.
- * @pfn: Page Number of the corrupted page
+ * __memory_failure - Handle memory failure.
+ * @addr: Physical address of the error.
+ * @granularity: Number of bits in the address which are bad.
  * @flags: fine tune action taken
  *
  * This function is called by the low level machine check code
@@ -1268,8 +1211,9 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
  * Must run in process context (e.g. a work queue) with interrupts
  * enabled and no spinlocks hold.
  */
-int memory_failure(unsigned long pfn, int flags)
+int __memory_failure(unsigned long addr, unsigned int granularity, int flags)
 {
+	unsigned long pfn = addr >> PAGE_SHIFT;
 	struct page *p;
 	struct page *hpage;
 	struct page *orig_head;
@@ -1285,8 +1229,8 @@ int memory_failure(unsigned long pfn, int flags)
 		if (pfn_valid(pfn)) {
 			pgmap = get_dev_pagemap(pfn, NULL);
 			if (pgmap)
-				return memory_failure_dev_pagemap(pfn, flags,
-								  pgmap);
+				return memory_failure_dev_pagemap(addr,
+						granularity, flags, pgmap);
 		}
 		pr_err("Memory failure: %#lx: memory outside kernel control\n",
 			pfn);
@@ -1442,7 +1386,7 @@ int memory_failure(unsigned long pfn, int flags)
 	unlock_page(p);
 	return res;
 }
-EXPORT_SYMBOL_GPL(memory_failure);
+EXPORT_SYMBOL_GPL(__memory_failure);
 
 #define MEMORY_FAILURE_FIFO_ORDER	4
 #define MEMORY_FAILURE_FIFO_SIZE	(1 << MEMORY_FAILURE_FIFO_ORDER)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
