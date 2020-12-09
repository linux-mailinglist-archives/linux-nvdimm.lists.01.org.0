Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C422D42F5
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 14:15:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1FD8E100ED48A;
	Wed,  9 Dec 2020 05:15:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B6B54100EF267
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 05:15:15 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9D5oc2114034;
	Wed, 9 Dec 2020 13:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=NWaom0xZP/1UFy9l2mi3VdX5cDPSEsodfhXlxrxIV0Y=;
 b=GL7Zhtnttflz1wF8gKT5nTq8T62Ha5HljH7v/IliPR2yDWqUnNQ/r6/LwlpiqoKZgnMt
 4yt7JSRLG5gXLS3Vxy21HkziiNuaP3h36xEK5Hnm+9jLwbAhlzYrWE3Lw1H64d5udxcF
 ofohYK2tw6ceiAgjgSjmtGX02cQmnifjvLxHPcKTu9ABA+aY+UZcvglsbnvXOcrM7ZJ1
 OF+4te4/wWc5Hf3bSNyp5C0jZAEJ5aQdAvHwbDM8JUyLeFujE4scUYQ8lxifQIpuFamn
 lqRtvZTRfuZsEb0JfFD/YGP1RgGUYTQYtaI3xaFxPFtga8lk/oLo6zMvHiAjPgnnH35I 7g==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 35825m82aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 09 Dec 2020 13:15:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9D4pnK071484;
	Wed, 9 Dec 2020 13:13:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 358ksq36p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Dec 2020 13:13:05 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B9DD1nf022654;
	Wed, 9 Dec 2020 13:13:02 GMT
Received: from [10.175.160.66] (/10.175.160.66)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 09 Dec 2020 05:13:01 -0800
Subject: Re: [PATCH RFC 1/9] memremap: add ZONE_DEVICE support for compound
 pages
To: Matthew Wilcox <willy@infradead.org>, John Hubbard <jhubbard@nvidia.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-2-joao.m.martins@oracle.com>
 <7249cfd2-c178-2e6a-6b03-307a05f11785@nvidia.com>
 <20201209063350.GO7338@casper.infradead.org>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <8df7f242-9044-a3a2-0788-69328d5909a1@oracle.com>
Date: Wed, 9 Dec 2020 13:12:57 +0000
MIME-Version: 1.0
In-Reply-To: <20201209063350.GO7338@casper.infradead.org>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090093
Message-ID-Hash: FWXARRCKHK5K2EZM6ME5KBTTQJTRZWQV
X-Message-ID-Hash: FWXARRCKHK5K2EZM6ME5KBTTQJTRZWQV
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FWXARRCKHK5K2EZM6ME5KBTTQJTRZWQV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/9/20 6:33 AM, Matthew Wilcox wrote:
> On Tue, Dec 08, 2020 at 09:59:19PM -0800, John Hubbard wrote:
>> On 12/8/20 9:28 AM, Joao Martins wrote:
>>> Add a new flag for struct dev_pagemap which designates that a a pagemap
>>
>> a a
>>
Ugh. Yeah will fix.

>>> is described as a set of compound pages or in other words, that how
>>> pages are grouped together in the page tables are reflected in how we
>>> describe struct pages. This means that rather than initializing
>>> individual struct pages, we also initialize these struct pages, as
>>
>> Let's not say "rather than x, we also do y", because it's self-contradictory.
>> I think you want to just leave out the "also", like this:
>>
>> "This means that rather than initializing> individual struct pages, we
>> initialize these struct pages ..."
>>
>> Is that right?
> 
Nop, my previous text was broken.

> I'd phrase it as:
> 
> Add a new flag for struct dev_pagemap which specifies that a pagemap is
> composed of a set of compound pages instead of individual pages.  When
> these pages are initialised, most are initialised as tail pages
> instead of order-0 pages.
> 
Thanks, I will use this instead.

>>> For certain ZONE_DEVICE users, like device-dax, which have a fixed page
>>> size, this creates an opportunity to optimize GUP and GUP-fast walkers,
>>> thus playing the same tricks as hugetlb pages.
> 
> Rather than "playing the same tricks", how about "are treated the same
> way as THP or hugetlb pages"?
> 
>>> +	if (pgmap->flags & PGMAP_COMPOUND)
>>> +		percpu_ref_get_many(pgmap->ref, (pfn_end(pgmap, range_id)
>>> +			- pfn_first(pgmap, range_id)) / PHYS_PFN(pgmap->align));
>>
>> Is there some reason that we cannot use range_len(), instead of pfn_end() minus
>> pfn_first()? (Yes, this more about the pre-existing code than about your change.)
>>
Indeed one could use range_len() / pgmap->align and it would work. But (...)

>> And if not, then why are the nearby range_len() uses OK? I realize that range_len()
>> is simpler and skips a case, but it's not clear that it's required here. But I'm
>> new to this area so be warned. :)
>>
My use of pfns to calculate the nr of pages was to remain consistent with the rest of the
code in the function taking references in the pgmap->ref. The usages one sees ofrange_len
are are when the hotplug takes place which work at addresses and not PFNs.

>> Also, dividing by PHYS_PFN() feels quite misleading: that function does what you
>> happen to want, but is not named accordingly. Can you use or create something
>> more accurately named? Like "number of pages in this large page"?
> 
> We have compound_nr(), but that takes a struct page as an argument.
> We also have HPAGE_NR_PAGES.  I'm not quite clear what you want.
> 
If possible I would rather keep the pfns as with the rest of the code. Another alternative
is like a range_nr_pages helper but I am not sure it's worth the trouble for one caller.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
