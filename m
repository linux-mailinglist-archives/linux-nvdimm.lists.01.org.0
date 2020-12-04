Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6932CE477
	for <lists+linux-nvdimm@lfdr.de>; Fri,  4 Dec 2020 01:33:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9AB3E100EC1F0;
	Thu,  3 Dec 2020 16:33:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:fcd0:100:8a00::2; helo=bedivere.hansenpartnership.com; envelope-from=james.bottomley@hansenpartnership.com; receiver=<UNKNOWN> 
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B0EC1100EC1EF
	for <linux-nvdimm@lists.01.org>; Thu,  3 Dec 2020 16:33:12 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 71BAD1280B16;
	Thu,  3 Dec 2020 16:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1607041991;
	bh=hJcWfWJUTBo7/PTPqGVoNCucwByYpr0pl4ltez5onkk=;
	h=Message-ID:Subject:From:To:Date:From;
	b=CSFgW4d1X70kdF2brsNqqLXcUxS4rkPpXl0fG35lGg8Er8RLuGkNR7f53VpM6STF+
	 CaBI3xpSYkQpwyvzfojTpkdXl5UFu01ZmFqPYjvYenKuZHPHXr/6MojFZYz/jZ2Wqj
	 tu6JMqZUf8Ir49z9n0V+JKoQTR3PB/fQ7Xgk7sK4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
	by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ea-2EOobf9qW; Thu,  3 Dec 2020 16:33:11 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 090011280AF1;
	Thu,  3 Dec 2020 16:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1607041991;
	bh=hJcWfWJUTBo7/PTPqGVoNCucwByYpr0pl4ltez5onkk=;
	h=Message-ID:Subject:From:To:Date:From;
	b=CSFgW4d1X70kdF2brsNqqLXcUxS4rkPpXl0fG35lGg8Er8RLuGkNR7f53VpM6STF+
	 CaBI3xpSYkQpwyvzfojTpkdXl5UFu01ZmFqPYjvYenKuZHPHXr/6MojFZYz/jZ2Wqj
	 tu6JMqZUf8Ir49z9n0V+JKoQTR3PB/fQ7Xgk7sK4=
Message-ID: <fb91b40d258414b0fdce2c380752e48daa6a70d6.camel@HansenPartnership.com>
Subject: PATCH] fs/dax: fix compile problem on parisc and mips
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Parisc List
	 <linux-parisc@vger.kernel.org>
Date: Thu, 03 Dec 2020 16:33:10 -0800
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Message-ID-Hash: ZRHCETVOZCBQBAMCX5NDC6KNJWUEXE35
X-Message-ID-Hash: ZRHCETVOZCBQBAMCX5NDC6KNJWUEXE35
X-MailFrom: James.Bottomley@HansenPartnership.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Matthew Wilcox <willy@infradead.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZRHCETVOZCBQBAMCX5NDC6KNJWUEXE35/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These platforms define PMD_ORDER in asm/pgtable.h

This means that as soon as dax.c included asm/pgtable.h in commit
11cf9d863dcb ("fs/dax: Deposit pagetable even when installing zero
page") we clash with PMD_ORDER introduced by cfc93c6c6c96 ("dax:
Convert dax_insert_pfn_mkwrite to XArray") and we get this problem:

/home/jejb/git/linux-build/fs/dax.c:53: warning: "PMD_ORDER" redefined
   53 | #define PMD_ORDER (PMD_SHIFT - PAGE_SHIFT)
      |
In file included from /home/jejb/git/linux-build/include/linux/pgtable.h:6,
                 from /home/jejb/git/linux-build/include/linux/mm.h:33,
                 from /home/jejb/git/linux-build/include/linux/bvec.h:14,
                 from /home/jejb/git/linux-build/include/linux/blk_types.h:10,
                 from /home/jejb/git/linux-build/include/linux/genhd.h:19,
                 from /home/jejb/git/linux-build/include/linux/blkdev.h:8,
                 from /home/jejb/git/linux-build/fs/dax.c:10:
/home/jejb/git/linux-build/arch/parisc/include/asm/pgtable.h:124: note: this is the location of the previous definition
  124 | #define PMD_ORDER 1 /* Number of pages per pmd */
      |
make[2]: *** Deleting file 'fs/dax.o'

Fix by renaming dax's PMD_ORDER to DAX_PMD_ORDER

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/dax.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5b47834f2e1b..4d3b0db5c321 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -50,7 +50,7 @@ static inline unsigned int pe_order(enum page_entry_size pe_size)
 #define PG_PMD_NR	(PMD_SIZE >> PAGE_SHIFT)
 
 /* The order of a PMD entry */
-#define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
+#define DAX_PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
 
 static wait_queue_head_t wait_table[DAX_WAIT_TABLE_ENTRIES];
 
@@ -98,7 +98,7 @@ static bool dax_is_locked(void *entry)
 static unsigned int dax_entry_order(void *entry)
 {
 	if (xa_to_value(entry) & DAX_PMD)
-		return PMD_ORDER;
+		return DAX_PMD_ORDER;
 	return 0;
 }
 
@@ -1471,7 +1471,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, PMD_ORDER);
+	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, DAX_PMD_ORDER);
 	unsigned long pmd_addr = vmf->address & PMD_MASK;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool sync;
@@ -1530,7 +1530,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * entry is already in the array, for instance), it will return
 	 * VM_FAULT_FALLBACK.
 	 */
-	entry = grab_mapping_entry(&xas, mapping, PMD_ORDER);
+	entry = grab_mapping_entry(&xas, mapping, DAX_PMD_ORDER);
 	if (xa_is_internal(entry)) {
 		result = xa_to_internal(entry);
 		goto fallback;
@@ -1696,7 +1696,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	if (order == 0)
 		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
 #ifdef CONFIG_FS_DAX_PMD
-	else if (order == PMD_ORDER)
+	else if (order == DAX_PMD_ORDER)
 		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
 #endif
 	else
-- 
2.29.2

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
