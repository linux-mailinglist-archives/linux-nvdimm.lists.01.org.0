Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743FA25E935
	for <lists+linux-nvdimm@lfdr.de>; Sat,  5 Sep 2020 19:04:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4ACE413A2317C;
	Sat,  5 Sep 2020 10:04:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mpatocka@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0732B13A2317B
	for <linux-nvdimm@lists.01.org>; Sat,  5 Sep 2020 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1599325493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bBI7if0KCVvWvaBOwMDsnEtZiJjjihsjAtqSgtT6RaA=;
	b=NFbwmKVH3vZGkrcPEeNcGfc0xURcGIWV0gwG5koE+UzlVLPKCRuE9J5BDCjhbWFcVvQYTj
	ixnNLhuqIlL/2ZCA1yAyiwTKUdyDsUJBrcoMwybQXHfii/Se5BaRjILVxW5ESSASENjFsi
	roFkSc75VKXV3BZsuroJ1MTgyVrFsfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-mgO_poxTNXWtVk_hTdv0qg-1; Sat, 05 Sep 2020 13:04:51 -0400
X-MC-Unique: mgO_poxTNXWtVk_hTdv0qg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82964185A0F8;
	Sat,  5 Sep 2020 17:04:49 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5831F7ED60;
	Sat,  5 Sep 2020 17:04:46 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 085H4jOV003056;
	Sat, 5 Sep 2020 13:04:45 -0400
Received: from localhost (mpatocka@localhost)
	by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 085H4jxR003052;
	Sat, 5 Sep 2020 13:04:45 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date: Sat, 5 Sep 2020 13:04:45 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 2/2 v2] xfs: don't update mtime on COW faults
In-Reply-To: <CAHk-=wh=0V27kdRkBAOkCDXSeFYmB=VzC0hMQVbmaiFV_1ZaCA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2009051302400.542@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh=0V27kdRkBAOkCDXSeFYmB=VzC0hMQVbmaiFV_1ZaCA@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: X2BR5HG7LDNIAI4BNXWAXPKCOOFDTVNW
X-Message-ID-Hash: X2BR5HG7LDNIAI4BNXWAXPKCOOFDTVNW
X-MailFrom: mpatocka@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>, Kirill Shutemov <kirill@shutemov.name>, Theodore Ts'o <tytso@mit.edu>, Andrea Arcangeli <aarcange@redhat.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X2BR5HG7LDNIAI4BNXWAXPKCOOFDTVNW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When running in a dax mode, if the user maps a page with MAP_PRIVATE and
PROT_WRITE, the xfs filesystem would incorrectly update ctime and mtime
when the user hits a COW fault.

This breaks building of the Linux kernel.
How to reproduce:
1. extract the Linux kernel tree on dax-mounted xfs filesystem
2. run make clean
3. run make -j12
4. run make -j12
- at step 4, make would incorrectly rebuild the whole kernel (although it
  was already built in step 3).

The reason for the breakage is that almost all object files depend on
objtool. When we run objtool, it takes COW page fault on its .data
section, and these faults will incorrectly update the timestamp of the
objtool binary. The updated timestamp causes make to rebuild the whole
tree.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 fs/xfs/xfs_file.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

Index: linux-2.6/fs/xfs/xfs_file.c
===================================================================
--- linux-2.6.orig/fs/xfs/xfs_file.c	2020-09-05 18:48:54.000000000 +0200
+++ linux-2.6/fs/xfs/xfs_file.c	2020-09-05 18:56:48.000000000 +0200
@@ -1223,14 +1223,21 @@ __xfs_filemap_fault(
 	return ret;
 }
 
+static inline bool
+xfs_is_shared_dax_write_fault(
+	struct vm_fault		*vmf)
+{
+	return IS_DAX(file_inode(vmf->vma->vm_file)) &&
+	       vmf->flags & FAULT_FLAG_WRITE && vmf->vma->vm_flags & VM_SHARED;
+}
+
 static vm_fault_t
 xfs_filemap_fault(
 	struct vm_fault		*vmf)
 {
 	/* DAX can shortcut the normal fault path on write faults! */
 	return __xfs_filemap_fault(vmf, PE_SIZE_PTE,
-			IS_DAX(file_inode(vmf->vma->vm_file)) &&
-			(vmf->flags & FAULT_FLAG_WRITE));
+			xfs_is_shared_dax_write_fault(vmf));
 }
 
 static vm_fault_t
@@ -1243,7 +1250,7 @@ xfs_filemap_huge_fault(
 
 	/* DAX can shortcut the normal fault path on write faults! */
 	return __xfs_filemap_fault(vmf, pe_size,
-			(vmf->flags & FAULT_FLAG_WRITE));
+			xfs_is_shared_dax_write_fault(vmf));
 }
 
 static vm_fault_t
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
