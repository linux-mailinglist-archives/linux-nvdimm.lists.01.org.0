Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E24425E8BC
	for <lists+linux-nvdimm@lfdr.de>; Sat,  5 Sep 2020 17:37:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5109D13D73CD3;
	Sat,  5 Sep 2020 08:37:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C401913D73CCE
	for <linux-nvdimm@lists.01.org>; Sat,  5 Sep 2020 08:37:18 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 085FUIW0097218;
	Sat, 5 Sep 2020 15:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vD/AOAr0WrELqvXdX96uBWr/OfEgaHB8gYfku2p5lG8=;
 b=A9z6nKTE2U3JnSRnGJ5GAezCjU18vJCB6Cqj8K0YYYwtA5Od/ljur95RwdJBgLrpP8PG
 wq7LYBbu90KRTr30uy7kvz457HEszYv5bPvquGTVDSuWtxAb+Ggy+PTLNrJVWNHvERBi
 KQt59h6ECpthJ23tXtlNFEC19keLSUL9DDvdEayeDtOaW7sVUnjcVWf3ChIlcwE1Rwu4
 lVVHUcdSuc4KMeZ+DgnVlBpvsxf+iF6kfDJ2iuK/BMWclr/sodLrVMGZ/k9+jUvZVnHi
 Be+9lPsx0JAsLWlVgi/lrxlLUypVKbHi0BnNB4X1/yyP39DEXntu/iCeMkO6UfU6gQ2L dg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2120.oracle.com with ESMTP id 33c2mkhd8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 05 Sep 2020 15:37:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 085FYoVF123563;
	Sat, 5 Sep 2020 15:37:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 33c2g0p3dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Sep 2020 15:37:06 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 085Fas0R013808;
	Sat, 5 Sep 2020 15:36:54 GMT
Received: from localhost (/67.169.218.210)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sat, 05 Sep 2020 08:36:54 -0700
Date: Sat, 5 Sep 2020 08:36:52 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH 2/2] xfs: don't update mtime on COW faults
Message-ID: <20200905153652.GA7955@magnolia>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9735 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009050151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9735 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 suspectscore=1 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009050150
Message-ID-Hash: OVGPEAWJNS2A66TO5SZZQS6JLENVE6C3
X-Message-ID-Hash: OVGPEAWJNS2A66TO5SZZQS6JLENVE6C3
X-MailFrom: darrick.wong@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>, Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>, Kirill Shutemov <kirill@shutemov.name>, Theodore Ts'o <tytso@mit.edu>, Andrea Arcangeli <aarcange@redhat.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OVGPEAWJNS2A66TO5SZZQS6JLENVE6C3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Sep 05, 2020 at 08:13:02AM -0400, Mikulas Patocka wrote:
> When running in a dax mode, if the user maps a page with MAP_PRIVATE and
> PROT_WRITE, the xfs filesystem would incorrectly update ctime and mtime
> when the user hits a COW fault.
> 
> This breaks building of the Linux kernel.
> How to reproduce:
> 1. extract the Linux kernel tree on dax-mounted xfs filesystem
> 2. run make clean
> 3. run make -j12
> 4. run make -j12
> - at step 4, make would incorrectly rebuild the whole kernel (although it
>   was already built in step 3).
> 
> The reason for the breakage is that almost all object files depend on
> objtool. When we run objtool, it takes COW page fault on its .data
> section, and these faults will incorrectly update the timestamp of the
> objtool binary. The updated timestamp causes make to rebuild the whole
> tree.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> 
> ---
>  fs/xfs/xfs_file.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/fs/xfs/xfs_file.c
> ===================================================================
> --- linux-2.6.orig/fs/xfs/xfs_file.c	2020-09-05 10:01:42.000000000 +0200
> +++ linux-2.6/fs/xfs/xfs_file.c	2020-09-05 13:59:12.000000000 +0200
> @@ -1223,6 +1223,13 @@ __xfs_filemap_fault(
>  	return ret;
>  }
>  
> +static bool
> +xfs_is_write_fault(

Call this xfs_is_shared_dax_write_fault, and throw in the IS_DAX() test?

You might as well make it a static inline.

> +	struct vm_fault		*vmf)
> +{
> +	return vmf->flags & FAULT_FLAG_WRITE && vmf->vma->vm_flags & VM_SHARED;

Also, is "shortcutting the normal fault path" the reason for ext2 and
xfs both being broken?

/me puzzles over why write_fault is always true for page_mkwrite and
pfn_mkwrite, but not for fault and huge_fault...

Also: Can you please turn this (checking for timestamp update behavior
wrt shared and private mapping write faults) into an fstest so we don't
mess this up again?

--D

> +}
> +
>  static vm_fault_t
>  xfs_filemap_fault(
>  	struct vm_fault		*vmf)
> @@ -1230,7 +1237,7 @@ xfs_filemap_fault(
>  	/* DAX can shortcut the normal fault path on write faults! */
>  	return __xfs_filemap_fault(vmf, PE_SIZE_PTE,
>  			IS_DAX(file_inode(vmf->vma->vm_file)) &&
> -			(vmf->flags & FAULT_FLAG_WRITE));
> +			xfs_is_write_fault(vmf));
>  }
>  
>  static vm_fault_t
> @@ -1243,7 +1250,7 @@ xfs_filemap_huge_fault(
>  
>  	/* DAX can shortcut the normal fault path on write faults! */
>  	return __xfs_filemap_fault(vmf, pe_size,
> -			(vmf->flags & FAULT_FLAG_WRITE));
> +			xfs_is_write_fault(vmf));
>  }
>  
>  static vm_fault_t
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
