Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AAD2D437D
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 14:44:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 84A1D100ED48A;
	Wed,  9 Dec 2020 05:44:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1BA12100EF25B
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 05:44:21 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9DZQL0133650;
	Wed, 9 Dec 2020 13:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=FKPr7xuS/aXGQgwrrFvvv6kJwDeAGSzRoMLdp5F6FuA=;
 b=dsBJsw/etrVgPA5bQr+RWQmkzfMS/3Y/vA4ax120m8+J6/vlOltYA0IpTQCMRgtvHBct
 Lq7EYJZ4n9svk3QvnJPOoP9bkoHf78rJX7/U2/kHzDOFRpoIAs/tWe69uMuuFAkrk8Nc
 MgQIEXAzp/5iEah74bWyQuGie8X0QZiI8k3BGW3jCHljQ9Gw4BjTKOmx2tZO6jPP10qp
 XBiNGHZTaueP79Ia6Z9Gtst86fURwBO4M5eVxC92MpywwZrE7JO3iJ2Pw9n/XeUCI9//
 wvB0s7PSvm/yLc/8fLq3GPah0m4dHO243DWVtTtR59mj7QIe5vAeX7t5zQcmNZcGlInb rQ==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2130.oracle.com with ESMTP id 357yqc0930-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 09 Dec 2020 13:44:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9DaXOJ074275;
	Wed, 9 Dec 2020 13:44:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 358m409xra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Dec 2020 13:44:12 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B9DiBdh016104;
	Wed, 9 Dec 2020 13:44:11 GMT
Received: from [10.175.160.66] (/10.175.160.66)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 09 Dec 2020 05:44:11 -0800
Subject: Re: [PATCH RFC 6/9] mm/gup: Grab head page refcount once for group of
 subpages
To: John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-8-joao.m.martins@oracle.com>
 <6f729802-1e93-3036-3dba-be35e06af579@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <f7c315ce-4636-69ed-d897-6ef2e612b8ae@oracle.com>
Date: Wed, 9 Dec 2020 13:44:06 +0000
MIME-Version: 1.0
In-Reply-To: <6f729802-1e93-3036-3dba-be35e06af579@nvidia.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=1 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090097
Message-ID-Hash: JCYLV45KIG3ARAKNHX4UDMSEWKXLPK7M
X-Message-ID-Hash: JCYLV45KIG3ARAKNHX4UDMSEWKXLPK7M
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JCYLV45KIG3ARAKNHX4UDMSEWKXLPK7M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/9/20 4:40 AM, John Hubbard wrote:
> On 12/8/20 9:28 AM, Joao Martins wrote:
>> Much like hugetlbfs or THPs, we treat device pagemaps with
>> compound pages like the rest of GUP handling of compound pages.
>>
>> Rather than incrementing the refcount every 4K, we record
>> all sub pages and increment by @refs amount *once*.
>>
>> Performance measured by gup_benchmark improves considerably
>> get_user_pages_fast() and pin_user_pages_fast():
>>
>>   $ gup_benchmark -f /dev/dax0.2 -m 16384 -r 10 -S [-u,-a] -n 512 -w
> 
> "gup_test", now that you're in linux-next, actually.
> 
> (Maybe I'll retrofit that test with getopt_long(), those options are
> getting more elaborate.)
> 
:)

>>
>> (get_user_pages_fast 2M pages) ~75k us -> ~3.6k us
>> (pin_user_pages_fast 2M pages) ~125k us -> ~3.8k us
> 
> That is a beautiful result! I'm very motivated to see if this patchset
> can make it in, in some form.
> 
Cool!

>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   mm/gup.c | 67 ++++++++++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 51 insertions(+), 16 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 98eb8e6d2609..194e6981eb03 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2250,22 +2250,68 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>>   }
>>   #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
>>   
>> +
>> +static int record_subpages(struct page *page, unsigned long addr,
>> +			   unsigned long end, struct page **pages)
>> +{
>> +	int nr;
>> +
>> +	for (nr = 0; addr != end; addr += PAGE_SIZE)
>> +		pages[nr++] = page++;
>> +
>> +	return nr;
>> +}
>> +
>>   #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
>> -static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>> -			     unsigned long end, unsigned int flags,
>> -			     struct page **pages, int *nr)
>> +static int __gup_device_compound_huge(struct dev_pagemap *pgmap,
>> +				      struct page *head, unsigned long sz,
> 
> If this variable survives (I see Jason requested a reorg of this math stuff,
> and I also like that idea), then I'd like a slightly better name for "sz".
> 
Yeap.

> I was going to suggest one, but then realized that I can't understand how this
> works. See below...
> 
>> +				      unsigned long addr, unsigned long end,
>> +				      unsigned int flags, struct page **pages)
>> +{
>> +	struct page *page;
>> +	int refs;
>> +
>> +	if (!(pgmap->flags & PGMAP_COMPOUND))
>> +		return -1;
> 
> btw, I'm unhappy with returning -1 here and assigning it later to a refs variable.
> (And that will show up even more clearly as an issue if you attempt to make
> refs unsigned everywhere!)
> 
Yes true.

The usage of @refs = -1 (therefore an int) was to differentiate when we are not in a
PGMAP_COMPOUND pgmap (and so for logic to keep as today).

Notice that in the PGMAP_COMPOUND case if we fail to grab the head compound page we return 0.

> I'm not going to suggest anything because there are a lot of ways to structure
> these routines, and I don't want to overly constrain you. Just please don't assign
> negative values to any refs variables.
> 
OK.

TBH I'm a little afraid this can turn into further complexity if I have to keep the
non-compound pgmap around. But I will see how I can adjust this.

>> +
>> +	page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
> 
> If you pass in PMD_SHIFT or PUD_SHIFT for, that's a number-of-bits, isn't it?
> Not a size. And if it's not a size, then sz - 1 doesn't work, does it? If it
> does work, then better naming might help. I'm probably missing a really
> obvious math trick here.

You're right. That was a mistake on my end, indeed. But the mistake wouldn't change the
logic, as the PageReference bit only applies to the head page.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
