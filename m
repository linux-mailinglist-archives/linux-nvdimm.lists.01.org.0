Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4947A2D6027
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Dec 2020 16:43:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 61427100EB84D;
	Thu, 10 Dec 2020 07:43:50 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 58DB3100EC1D6
	for <linux-nvdimm@lists.01.org>; Thu, 10 Dec 2020 07:43:47 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAFZOwP169583;
	Thu, 10 Dec 2020 15:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kVIKnPtJaLqjBpJs3IPG0Ef+Ab1GmoQambLDfBkb+QM=;
 b=OWojDtxhMF4ArgnCZq83u0+Fcl/BmmwTJvrCen4fgko1CC/5y0smRSG+ktrW2cSdhA5v
 FMaFOtSh0dVyWvWvnmE/ICCoCHXfBudU6JY2BPuss4TVkNyPzCoLPvqdnZ2ZOc+W1vaL
 QZvjIlDhbpu2u4HLTWX9d0/DQb/Su0ZzhzEhMSSlNQqXlQf1rNlO++5IL4xe+sgVLBS5
 SwmXLB1bQCXFIhSwKFs7i4xc3Q3oQ8A9XBZ5HaTWfZucN2IHv4jWfoyp/slqJdxM80dJ
 Mf+un8k3PA4NkYkBh144sZjlLvCGVtrZDH90mSgPDDmfjqzwaNB+mttLvl+LdlIu1eTx EQ==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2130.oracle.com with ESMTP id 357yqc64w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Dec 2020 15:43:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAFacEV142085;
	Thu, 10 Dec 2020 15:43:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3020.oracle.com with ESMTP id 358m41u3mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Dec 2020 15:43:33 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BAFhQLL016251;
	Thu, 10 Dec 2020 15:43:26 GMT
Received: from [10.175.193.63] (/10.175.193.63)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 10 Dec 2020 07:43:26 -0800
Subject: Re: [PATCH RFC 6/9] mm/gup: Grab head page refcount once for group of
 subpages
To: Matthew Wilcox <willy@infradead.org>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-8-joao.m.martins@oracle.com>
 <20201208194905.GQ5487@ziepe.ca>
 <b7f5fe44-f2f5-aea6-57b3-7e14a9ef624d@oracle.com>
 <20201209151505.GV5487@ziepe.ca>
 <a035661f-a979-c68b-d149-ef3892a5a1ea@oracle.com>
 <20201209162438.GW5487@ziepe.ca> <20201209181406.GQ7338@casper.infradead.org>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <996c74e8-fa86-bb91-6e95-b4b7efac7c05@oracle.com>
Date: Thu, 10 Dec 2020 15:43:22 +0000
MIME-Version: 1.0
In-Reply-To: <20201209181406.GQ7338@casper.infradead.org>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=1 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100099
Message-ID-Hash: QGMWCDOZXPP54ZIUQVITZH3HY2EF3NBW
X-Message-ID-Hash: QGMWCDOZXPP54ZIUQVITZH3HY2EF3NBW
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QGMWCDOZXPP54ZIUQVITZH3HY2EF3NBW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 12/9/20 6:14 PM, Matthew Wilcox wrote:
> On Wed, Dec 09, 2020 at 12:24:38PM -0400, Jason Gunthorpe wrote:
>> On Wed, Dec 09, 2020 at 04:02:05PM +0000, Joao Martins wrote:
>>
>>> Today (without the series) struct pages are not represented the way they
>>> are expressed in the page tables, which is what I am hoping to fix in this
>>> series thus initializing these as compound pages of a given order. But me
>>> introducing PGMAP_COMPOUND was to conservatively keep both old (non-compound)
>>> and new (compound pages) co-exist.
>>
>> Oooh, that I didn't know.. That is kind of horrible to have a PMD
>> pointing at an order 0 page only in this one special case.
> 
> Uh, yes.  I'm surprised it hasn't caused more problems.
> 
There was 1 or 2 problems in the KVM MMU related to zone device pages.

See commit e851265a816f ("KVM: x86/mmu: Use huge pages for DAX-backed files")
which eventually lead to commit db5432165e9b5 ("KVM: x86/mmu: Walk host page
tables to find THP mappings") to be less amenable to metadata changes.

>> Still, I think it would be easier to teach record_subpages() that a
>> PMD doesn't necessarily point to a high order page, eg do something
>> like I suggested for the SGL where it extracts the page order and
>> iterates over the contiguous range of pfns.
> 
> But we also see good performance improvements from doing all reference
> counts on the head page instead of spread throughout the pages, so we
> really want compound pages.

Going further than just refcounts and borrowing your (or someone else?)
idea, perhaps also a FOLL_HEAD gup flag that would let us only work with
head pages (or folios). Which would consequently let us pin/grab bigger
swathes of memory e.g. 1G (in 2M head pages) or 512G (in 1G head pages)
with just 1 page for storing the struct pages[*]. Albeit I suspect the
numbers would have to justify it.

	Joao

[*] One page happens to be what's used for RDMA/umem and vdpa as callers
of pin_user_pages*()
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
