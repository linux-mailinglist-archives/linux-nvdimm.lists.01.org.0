Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E892D4396
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 14:54:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BBE1D100EBBB0;
	Wed,  9 Dec 2020 05:54:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2AC0D100EC1E9
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 05:53:58 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9Di2Po145340;
	Wed, 9 Dec 2020 13:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=P53F09tlH8pOIMJH7430elatYdfLt71vgO4lAhbol3s=;
 b=NvGeZeqILL5FJQbSC/IwlgPb9H2dPGMwdb0jozKHp+Nv6y222U79f6xYT/PI7VDcW/8t
 7bWak4GyjcYwYRUYgWDUdcj/WIsorVYkFxEZhR33vkxy/cImEuTbM5VDPbXrGaNyORK5
 ay2lrPUIIerISTM5BM8J1gKUO7+GGkADkvRVqbG1ef3F4CQN63Mf57b2R7gBrzlU0U2M
 CEakZ6kgCrr2r6nwlyWE9we7x1UESKQ/iD2g0eAAkUHN5LwxopgSql2mm/an+Vh0gWQk
 WkFJjI3PZAMDNmhYZw2+lAk5UVuVhbhZZAU1plBPs+SDLXn7W0kLz143rD4U4yg55UhF VQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 3581mr04p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 09 Dec 2020 13:53:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9DohR8052362;
	Wed, 9 Dec 2020 13:51:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3020.oracle.com with ESMTP id 358kyupxn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Dec 2020 13:51:49 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B9Dpl2W020178;
	Wed, 9 Dec 2020 13:51:47 GMT
Received: from [10.175.160.66] (/10.175.160.66)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 09 Dec 2020 05:51:46 -0800
Subject: Re: [PATCH RFC 2/9] sparse-vmemmap: Consolidate arguments in vmemmap
 section populate
To: John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-3-joao.m.martins@oracle.com>
 <0faea767-7af0-6188-5a4e-3d5dd3c4bde9@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <cc7e22b3-f03e-2c6f-e200-c982b1b27432@oracle.com>
Date: Wed, 9 Dec 2020 13:51:42 +0000
MIME-Version: 1.0
In-Reply-To: <0faea767-7af0-6188-5a4e-3d5dd3c4bde9@nvidia.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=1 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090098
Message-ID-Hash: 2WYNPN7VTNLZJ7BHH7NFMYQUMWAZZ6KW
X-Message-ID-Hash: 2WYNPN7VTNLZJ7BHH7NFMYQUMWAZZ6KW
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2WYNPN7VTNLZJ7BHH7NFMYQUMWAZZ6KW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 12/9/20 6:16 AM, John Hubbard wrote:
> On 12/8/20 9:28 AM, Joao Martins wrote:
>> Replace vmem_altmap with an vmem_context argument. That let us
>> express how the vmemmap is gonna be initialized e.g. passing
>> flags and a page size for reusing pages upon initializing the
>> vmemmap.
> 
> How about this instead:
> 
> Replace the vmem_altmap argument with a vmem_context argument that
> contains vmem_altmap for now. Subsequent patches will add additional
> member elements to vmem_context, such as flags and page size.
> 
> No behavior changes are intended.
> 
> ?
> 
Yeap, it's better than way. Thanks.

>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   include/linux/memory_hotplug.h |  6 +++++-
>>   include/linux/mm.h             |  2 +-
>>   mm/memory_hotplug.c            |  3 ++-
>>   mm/sparse-vmemmap.c            |  6 +++++-
>>   mm/sparse.c                    | 16 ++++++++--------
>>   5 files changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>> index 551093b74596..73f8bcbb58a4 100644
>> --- a/include/linux/memory_hotplug.h
>> +++ b/include/linux/memory_hotplug.h
>> @@ -81,6 +81,10 @@ struct mhp_params {
>>   	pgprot_t pgprot;
>>   };
>>   
>> +struct vmem_context {
>> +	struct vmem_altmap *altmap;
>> +};
>> +
>>   /*
>>    * Zone resizing functions
>>    *
>> @@ -353,7 +357,7 @@ extern void remove_pfn_range_from_zone(struct zone *zone,
>>   				       unsigned long nr_pages);
>>   extern bool is_memblock_offlined(struct memory_block *mem);
>>   extern int sparse_add_section(int nid, unsigned long pfn,
>> -		unsigned long nr_pages, struct vmem_altmap *altmap);
>> +		unsigned long nr_pages, struct vmem_context *ctx);
>>   extern void sparse_remove_section(struct mem_section *ms,
>>   		unsigned long pfn, unsigned long nr_pages,
>>   		unsigned long map_offset, struct vmem_altmap *altmap);
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index db6ae4d3fb4e..2eb44318bb2d 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3000,7 +3000,7 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
>>   
>>   void *sparse_buffer_alloc(unsigned long size);
>>   struct page * __populate_section_memmap(unsigned long pfn,
>> -		unsigned long nr_pages, int nid, struct vmem_altmap *altmap);
>> +		unsigned long nr_pages, int nid, struct vmem_context *ctx);
>>   pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
>>   p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
>>   pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 63b2e46b6555..f8870c53fe5e 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -313,6 +313,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>>   	unsigned long cur_nr_pages;
>>   	int err;
>>   	struct vmem_altmap *altmap = params->altmap;
>> +	struct vmem_context ctx = { .altmap = params->altmap };
> 
> OK, so this is the one place I can see where ctx is set up. And it's never null.
> Let's remember that point...
> 

(...)

>>   
>>   	if (WARN_ON_ONCE(!params->pgprot.pgprot))
>>   		return -EINVAL;
>> @@ -341,7 +342,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>>   		/* Select all remaining pages up to the next section boundary */
>>   		cur_nr_pages = min(end_pfn - pfn,
>>   				   SECTION_ALIGN_UP(pfn + 1) - pfn);
>> -		err = sparse_add_section(nid, pfn, cur_nr_pages, altmap);
>> +		err = sparse_add_section(nid, pfn, cur_nr_pages, &ctx);
>>   		if (err)
>>   			break;
>>   		cond_resched();
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 16183d85a7d5..bcda68ba1381 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -249,15 +249,19 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
>>   }
>>   
>>   struct page * __meminit __populate_section_memmap(unsigned long pfn,
>> -		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>> +		unsigned long nr_pages, int nid, struct vmem_context *ctx)
>>   {
>>   	unsigned long start = (unsigned long) pfn_to_page(pfn);
>>   	unsigned long end = start + nr_pages * sizeof(struct page);
>> +	struct vmem_altmap *altmap = NULL;
>>   
>>   	if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
>>   		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
>>   		return NULL;
>>   
>> +	if (ctx)
> 
> But...ctx can never be null, right?
> 
Indeed.

This is an artifact of an old version of this where the passed parameter
could be null.

> I didn't spot any other issues, though.
> 
> thanks,
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
