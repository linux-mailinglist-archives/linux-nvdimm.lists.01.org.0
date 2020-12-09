Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAEB2D3A13
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 06:06:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 98493100EB849;
	Tue,  8 Dec 2020 21:06:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.65; helo=hqnvemgate26.nvidia.com; envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN> 
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com [216.228.121.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 45FA2100EB845
	for <linux-nvdimm@lists.01.org>; Tue,  8 Dec 2020 21:06:53 -0800 (PST)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
	id <B5fd05b6c0000>; Tue, 08 Dec 2020 21:06:52 -0800
Received: from [10.2.60.96] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 05:06:51 +0000
Subject: Re: [PATCH RFC 7/9] mm/gup: Decrement head page once for group of
 subpages
To: Jason Gunthorpe <jgg@ziepe.ca>, Joao Martins <joao.m.martins@oracle.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-9-joao.m.martins@oracle.com>
 <20201208193446.GP5487@ziepe.ca>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <08d33a4e-5722-6a0a-cca4-9c476afcc228@nvidia.com>
Date: Tue, 8 Dec 2020 21:06:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201208193446.GP5487@ziepe.ca>
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1607490412; bh=fIDknUUudGSVbW2H+BlrofsyqRmzGu1N36B+onQkKnk=;
	h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
	 MIME-Version:In-Reply-To:Content-Type:Content-Language:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	b=j4qEA+ZWLpk/UQ0qOcDL05DjJ5CIZmPgZ92i3SdY3xE+2ktKJZchsQwEeIn1xxAhY
	 JJ9UfrA3XNHDpEveBVF3HigkA2RjcFW4NjjuMiob7njZOHqA3oRFDv1/M9ojkDx+nn
	 6SeJL9XPkuzFSL7peB7vHN/hIWf9dEr8EQA7XPXb+xLgEEyoe0I7Q1mz6IhpuIwizG
	 i84+WQja6hG13koHtBHZcR9yQrV2WMoowVI5xeTPcRuXihxQy0cbIHOJ7F2/6PEDbE
	 kErkA5frRs+RBMlaWRipAsQ52dbMauKMju84XVzAsnWspwUfnbpdkK5zSWIl4OOi/o
	 YN9XjJbMVqQXg==
Message-ID-Hash: EIQ4B7ZWZDDELFHODMZRBF3WNW34JZGY
X-Message-ID-Hash: EIQ4B7ZWZDDELFHODMZRBF3WNW34JZGY
X-MailFrom: jhubbard@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org,
	Matthew Wilcox <willy@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Mike Kravetz <mike.kravetz@oracle.com>, Andrew@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EIQ4B7ZWZDDELFHODMZRBF3WNW34JZGY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12/8/20 11:34 AM, Jason Gunthorpe wrote:
> On Tue, Dec 08, 2020 at 05:28:59PM +0000, Joao Martins wrote:
>> Rather than decrementing the ref count one by one, we
>> walk the page array and checking which belong to the same
>> compound_head. Later on we decrement the calculated amount
>> of references in a single write to the head page.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>   mm/gup.c | 41 ++++++++++++++++++++++++++++++++---------
>>   1 file changed, 32 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 194e6981eb03..3a9a7229f418 100644
>> +++ b/mm/gup.c
>> @@ -212,6 +212,18 @@ static bool __unpin_devmap_managed_user_page(struct page *page)
>>   }
>>   #endif /* CONFIG_DEV_PAGEMAP_OPS */
>>   
>> +static int record_refs(struct page **pages, int npages)
>> +{
>> +	struct page *head = compound_head(pages[0]);
>> +	int refs = 1, index;
>> +
>> +	for (index = 1; index < npages; index++, refs++)
>> +		if (compound_head(pages[index]) != head)
>> +			break;
>> +
>> +	return refs;
>> +}
>> +
>>   /**
>>    * unpin_user_page() - release a dma-pinned page
>>    * @page:            pointer to page to be released
>> @@ -221,9 +233,9 @@ static bool __unpin_devmap_managed_user_page(struct page *page)
>>    * that such pages can be separately tracked and uniquely handled. In
>>    * particular, interactions with RDMA and filesystems need special handling.
>>    */
>> -void unpin_user_page(struct page *page)
>> +static void __unpin_user_page(struct page *page, int refs)
> 
> Refs should be unsigned everywhere.

That's fine (although, see my comments in the previous patch for
pitfalls). But it should be a preparatory patch, in order to avoid
clouding up this one and your others as well.


> 
> I suggest using clear language 'page' here should always be a compound
> head called 'head' (or do we have another common variable name for
> this?)
> 

Agreed. Matthew's struct folio upgrade will allow us to really make
things clear in a typesafe way, but meanwhile, it's probably good to use
one of the following patterns:

page = compound_head(page); // at the very beginning of a routine

or

do_things_to_this_single_page(page);

head = compound_head(page);
do_things_to_this_compound_page(head);


> 'refs' is number of tail pages within the compound, so 'ntails' or
> something
> 

I think it's OK to leave it as "refs", because within gup.c, refs has
a very particular meaning. But if you change to ntails or something, I'd
want to see a complete change: no leftovers of refs that are really ntails.

So far I'd rather leave it as refs, but it's not a big deal either way.

>>   {
>> -	int refs = 1;
>> +	int orig_refs = refs;
>>   
>>   	page = compound_head(page);
> 
> Caller should always do this
> 
>> @@ -237,14 +249,19 @@ void unpin_user_page(struct page *page)
>>   		return;
>>   
>>   	if (hpage_pincount_available(page))
>> -		hpage_pincount_sub(page, 1);
>> +		hpage_pincount_sub(page, refs);

Maybe a nice touch would be to pass in orig_refs, because there
is no intention to use a possibly modified refs. So:

		hpage_pincount_sub(page, orig_refs);

...obviously a fine point, I realize. :)

>>   	else
>> -		refs = GUP_PIN_COUNTING_BIAS;
>> +		refs *= GUP_PIN_COUNTING_BIAS;
>>   
>>   	if (page_ref_sub_and_test(page, refs))
>>   		__put_page(page);
>>   
>> -	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, 1);
>> +	mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED, orig_refs);
>> +}
> 
> And really this should be placed directly after
> try_grab_compound_head() and be given a similar name
> 'unpin_compound_head()'. Even better would be to split the FOLL_PIN
> part into a function so there was a clear logical pairing.
> 
> And reviewing it like that I want to ask if this unpin sequence is in
> the right order.. I would expect it to be the reverse order of the get
> 
> John?
> 
> Is it safe to call mod_node_page_state() after releasing the refcount?
> This could race with hot-unplugging the struct pages so I think it is
> wrong.

Yes, I think you are right! I wasn't in a hot unplug state of mind when I
thought about the ordering there, but I should have been. :)

> 
>> +void unpin_user_page(struct page *page)
>> +{
>> +	__unpin_user_page(page, 1);
> 
> Thus this is
> 
> 	__unpin_user_page(compound_head(page), 1);
> 
>> @@ -274,6 +291,7 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>>   				 bool make_dirty)
>>   {
>>   	unsigned long index;
>> +	int refs = 1;
>>   
>>   	/*
>>   	 * TODO: this can be optimized for huge pages: if a series of pages is

I think you can delete this TODO block now, and the one in unpin_user_pages_dirty_lock(),
as a result of these changes.

>> @@ -286,8 +304,9 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>>   		return;
>>   	}
>>   
>> -	for (index = 0; index < npages; index++) {
>> +	for (index = 0; index < npages; index += refs) {
>>   		struct page *page = compound_head(pages[index]);
>> +
> 
> I think this is really hard to read, it should end up as some:
> 
> for_each_compond_head(page_list, page_list_len, &head, &ntails) {
>         		if (!PageDirty(head))
> 			set_page_dirty_lock(head, ntails);
> 		unpin_user_page(head, ntails);
> }
> 
> And maybe you open code that iteration, but that basic idea to find a
> compound_head and ntails should be computational work performed.
> 
> No reason not to fix set_page_dirty_lock() too while you are here.

Eh? What's wrong with set_page_dirty_lock() ?

> 
> Also, this patch and the next can be completely independent of the
> rest of the series, it is valuable regardless of the other tricks. You
> can split them and progress them independently.
> 
> .. and I was just talking about this with Daniel Jordan and some other
> people at your company :)
> 
> Thanks,
> Jason
> 

thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
