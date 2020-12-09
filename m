Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D164D2D463F
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 17:02:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 861A1100EBBDB;
	Wed,  9 Dec 2020 08:02:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 95AC8100EBBD8
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 08:02:26 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9FtQhq100418;
	Wed, 9 Dec 2020 16:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fYxco1mSnDHtBnPleVaP+ktR4b1wmpey+bVDVZWN7Uw=;
 b=VPIKKy2Lus7j8JfXPdWKKWo05XqjoJDTBM9TQCuTta60Aox2G1aSkOu62NbPqboHnHoR
 uB/GDcnRqFMfjRcJD04R6pTyaEtlq0dCXwMUEKY9IUZBzjFQSrvvoKLZdv7f/Zpv1ttU
 ZQ8Yk2aTR5PJ50mN6GzEt3nWjs/YOX3GcrHyhW96QkrnsBCe78NoQY5COwhhZf+cX6EE
 lICaNjaf1KFGhzrkbN35x5ohNDJsIkTt65O92GWDg1jiN8x0Gvg9BLrh49XO3uZhi0x0
 llqq2zR4zqnit0dKzY7yERuyV8mIlHVmayr78N14P1dDvgOUrLEALkaUj/rkj7r1Yv5Q Pw==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 35825m8xmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 09 Dec 2020 16:02:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9G0riM032019;
	Wed, 9 Dec 2020 16:02:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3030.oracle.com with ESMTP id 358ksqa5sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Dec 2020 16:02:12 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B9G29kO029619;
	Wed, 9 Dec 2020 16:02:10 GMT
Received: from [10.175.160.66] (/10.175.160.66)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 09 Dec 2020 08:02:08 -0800
Subject: Re: [PATCH RFC 6/9] mm/gup: Grab head page refcount once for group of
 subpages
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-8-joao.m.martins@oracle.com>
 <20201208194905.GQ5487@ziepe.ca>
 <b7f5fe44-f2f5-aea6-57b3-7e14a9ef624d@oracle.com>
 <20201209151505.GV5487@ziepe.ca>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <a035661f-a979-c68b-d149-ef3892a5a1ea@oracle.com>
Date: Wed, 9 Dec 2020 16:02:05 +0000
MIME-Version: 1.0
In-Reply-To: <20201209151505.GV5487@ziepe.ca>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090111
Message-ID-Hash: JXGHF2UUIU7MI3JCIJ5F2MPMVMWBOOS4
X-Message-ID-Hash: JXGHF2UUIU7MI3JCIJ5F2MPMVMWBOOS4
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JXGHF2UUIU7MI3JCIJ5F2MPMVMWBOOS4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/9/20 3:15 PM, Jason Gunthorpe wrote:
> On Wed, Dec 09, 2020 at 11:05:39AM +0000, Joao Martins wrote:
>>> Why is all of this special? Any time we see a PMD/PGD/etc pointing to
>>> PFN we can apply this optimization. How come device has its own
>>> special path to do this?? 
>>
>> I think the reason is that zone_device struct pages have no
>> relationship to one other. So you anyways need to change individual
>> pages, as opposed to just the head page.
> 
> Huh? That can't be, unpin doesn't know the memory type when it unpins
> it, and as your series shows unpin always operates on the compound
> head. Thus pinning must also operate on compound heads
> 
I was referring to the code without this series, in the paragraph above.
Meaning today zone_device pages are *not* represented compound pages. And so
compound_head(page) on a non compound page just returns the page itself.

Otherwise, try_grab_page() (e.g. when pinning pages) would be broken.

>> I made it special to avoid breaking other ZONE_DEVICE users (and
>> gating that with PGMAP_COMPOUND). But if there's no concerns with
>> that, I can unilaterally enable it.
> 
> I didn't understand what PGMAP_COMPOUND was supposed to be for..
>  
PGMAP_COMPOUND purpose is to online these pages as compound pages (so head
and tails).

Today (without the series) struct pages are not represented the way they
are expressed in the page tables, which is what I am hoping to fix in this
series thus initializing these as compound pages of a given order. But me
introducing PGMAP_COMPOUND was to conservatively keep both old (non-compound)
and new (compound pages) co-exist.

I wasn't sure I could just enable regardless, worried that I would be breaking
other ZONE_DEVICE/memremap_pages users.

>>> Why do we need to check PGMAP_COMPOUND? Why do we need to get pgmap?
>>> (We already removed that from the hmm version of this, was that wrong?
>>> Is this different?) Dan?
> 
> And this is the key question - why do we need to get a pgmap here?
> 
> I'm going to assert that a pgmap cannot be destroyed concurrently with
> fast gup running. This is surely true on x86 as the TLB flush that
> must have preceeded a pgmap destroy excludes fast gup. Other arches
> must emulate this in their pgmap implementations.
> 
> So, why do we need pgmap here? Hoping Dan might know
> 
> If we delete the pgmap then the devmap stop being special.
>
I will let Dan chip in.

> CH and I looked at this and deleted it from the hmm side:
> 
> commit 068354ade5dd9e2b07d9b0c57055a681db6f4e37
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> Date:   Fri Mar 27 17:00:13 2020 -0300
> 
>     mm/hmm: remove pgmap checking for devmap pages
>     
>     The checking boils down to some racy check if the pagemap is still
>     available or not. Instead of checking this, rely entirely on the
>     notifiers, if a pagemap is destroyed then all pages that belong to it must
>     be removed from the tables and the notifiers triggered.
>     
>     Link: https://lore.kernel.org/r/20200327200021.29372-2-jgg@ziepe.ca
> 
> Though I am wondering if this whole hmm thing is racy with memory
> unplug. Hmm.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
