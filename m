Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA91037532D
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 13:46:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2F662100EB85C;
	Thu,  6 May 2021 04:46:15 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BCD7B100EBB63
	for <linux-nvdimm@lists.01.org>; Thu,  6 May 2021 04:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mifLY5I1ASqvyJ61ckft/moipD7muFgUKiocPLAZXfE=; b=h5l6+Feu+l7JPwj29W670YStho
	xJ6ZccudxiObN9FbvMgKp/cESCCB3TvmFBS3p3yK/DsS4qCu/JhCepb9wFu8J3ktnpfE5uBS6lT7C
	IVe8OHQT20/w3WKukaB+e1Av7wdNjRvynIuflnageJIC46x+9i7GPqw8gmeFa1cL/dfj133BqJf0F
	sl5wdyYpZGYURuFuls8V55M03XR4vs73ANpvzpOTiDN0jd3/2QaBzOfKtWKKvRoavnW3n1z6pHSza
	T0RxTCE1XDopcmG+es1O+Fb+9q4GKfrtqA6t5XGah8eTFdCan40O0DvjybojOy3y4fIRZ1301Qnpu
	HFeUqkvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lecQ9-001edk-8Q; Thu, 06 May 2021 11:44:12 +0000
Date: Thu, 6 May 2021 12:43:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v1 04/11] mm/memremap: add ZONE_DEVICE support for
 compound pages
Message-ID: <20210506114357.GA388843@casper.infradead.org>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-5-joao.m.martins@oracle.com>
 <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
 <cd1c9849-8660-dbdc-718a-aa4ba5d48c01@oracle.com>
 <CAPcyv4jG8+S6xJyp=1S2=dpit0Hs2+HgGwpWeRROCRuJnQYAxQ@mail.gmail.com>
 <87zgx85ltc.fsf@linux.ibm.com>
 <31563092-a7b8-e6e1-f5ad-a66c02243a9d@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <31563092-a7b8-e6e1-f5ad-a66c02243a9d@oracle.com>
Message-ID-Hash: SCVN2F6V37HKF7NNJKIK7S7YZ6CKHWEJ
X-Message-ID-Hash: SCVN2F6V37HKF7NNJKIK7S7YZ6CKHWEJ
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SCVN2F6V37HKF7NNJKIK7S7YZ6CKHWEJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 06, 2021 at 11:23:25AM +0100, Joao Martins wrote:
> >> I think it is ok for dax/nvdimm to continue to maintain their align
> >> value because it should be ok to have 4MB align if the device really
> >> wanted. However, when it goes to map that alignment with
> >> memremap_pages() it can pick a mode. For example, it's already the
> >> case that dax->align == 1GB is mapped with DEVMAP_PTE today, so
> >> they're already separate concepts that can stay separate.
> > 
> > devdax namespace with align of 1G implies we expect to map them with 1G
> > pte entries? I didn't follow when you say we map them today with
> > DEVMAP_PTE entries.
> 
> This sort of confusion is largelly why Dan is suggesting a @geometry for naming rather
> than @align (which traditionally refers to page tables entry sizes in pagemap-related stuff).
> 
> DEVMAP_{PTE,PMD,PUD} refers to the representation of metadata in base pages (DEVMAP_PTE),
> compound pages of PMD order (DEVMAP_PMD) or compound pages of PUD order (DEVMAP_PUD).
> 
> So, today:
> 
> * namespaces with align of 1G would use *struct pages of order-0* (DEVMAP_PTE) backed with
> PMD entries in the direct map.
> * namespaces with align of 2M would use *struct pages of order-0* (DEVMAP_PTE) backed with
> PMD entries in the direct map.
> 
> After this series:
> 
> * namespaces with align of 1G would use *compound struct pages of order-30* (DEVMAP_PUD)
> backed with PMD entries in the direct map.

order-18

> * namespaces with align of 1G would use *compound struct pages of order-21* (DEVMAP_PMD)
> backed with PTE entries in the direct map.

i think you mean "align of 2M", and order-9.

(note that these numbers are/can be different for powerpc since it
supports different TLB page sizes.  please don't get locked into x86
sizes, and don't ignore the benefits *to software* of managing memory
in sizes other than just those supported by the hardware).
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
