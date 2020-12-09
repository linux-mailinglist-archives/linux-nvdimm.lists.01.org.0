Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9662D41E5
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 13:17:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C50CB100EBBB7;
	Wed,  9 Dec 2020 04:17:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 83189100ED49C
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 04:17:54 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9CBPga143940;
	Wed, 9 Dec 2020 12:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/m4dJKWiD4sMI2KzzQH08p1SLX5nGvJ9gvPRy/2am+8=;
 b=vybR4PhXEX851Yj/C+XHxccRMuI9W02m9Y2bj0TRFZ+Kjkjm1b6qO4+49id2YHgRRAIK
 ouxaW8rJ9N5Ye5moI/d8D1odS7PraOqez/lQsFQUNmMo480kY5VREDAbyg160xTVzsPE
 1T1hRnbCd1ueiOPzYKjisdAM5f5GmkjslWHLLKjf2fxiFBUdNwlccmK/Rxm8y0Zjz1l8
 wfwlTZbhTRT27c0gIfWgWGVRg8XMmXLC5nzI+3FsD2L0sx+puHrEA09deoyFQNx/I/FF
 Xxx8cSJUUqWEAWSo3rneyJNwqO2JPCSSlBxv7sVP+s8AXjakjaULaTP7mRR2OTL/BzW+ Mg==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 3581mqys3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 09 Dec 2020 12:17:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9CAhje169612;
	Wed, 9 Dec 2020 12:17:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 358kyuk0ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Dec 2020 12:17:40 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B9CHcWn001788;
	Wed, 9 Dec 2020 12:17:38 GMT
Received: from [10.175.160.66] (/10.175.160.66)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 09 Dec 2020 04:17:38 -0800
Subject: Re: [PATCH RFC 7/9] mm/gup: Decrement head page once for group of
 subpages
To: Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-9-joao.m.martins@oracle.com>
 <20201208193446.GP5487@ziepe.ca>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <f9cb2a75-6954-5afa-42b3-de24462d5585@oracle.com>
Date: Wed, 9 Dec 2020 12:17:34 +0000
MIME-Version: 1.0
In-Reply-To: <20201208193446.GP5487@ziepe.ca>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=1 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090086
Message-ID-Hash: QHQQEX226HIZ3HMYD5UETDPKI3VWWSBI
X-Message-ID-Hash: QHQQEX226HIZ3HMYD5UETDPKI3VWWSBI
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QHQQEX226HIZ3HMYD5UETDPKI3VWWSBI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/8/20 7:34 PM, Jason Gunthorpe wrote:
> On Tue, Dec 08, 2020 at 05:28:59PM +0000, Joao Martins wrote:
>> Rather than decrementing the ref count one by one, we
>> walk the page array and checking which belong to the same
>> compound_head. Later on we decrement the calculated amount
>> of references in a single write to the head page.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>  mm/gup.c | 41 ++++++++++++++++++++++++++++++++---------
>>  1 file changed, 32 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 194e6981eb03..3a9a7229f418 100644
>> +++ b/mm/gup.c
>> @@ -212,6 +212,18 @@ static bool __unpin_devmap_managed_user_page(struct page *page)
>>  }
>>  #endif /* CONFIG_DEV_PAGEMAP_OPS */
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
>>  /**
>>   * unpin_user_page() - release a dma-pinned page
>>   * @page:            pointer to page to be released
>> @@ -221,9 +233,9 @@ static bool __unpin_devmap_managed_user_page(struct page *page)
>>   * that such pages can be separately tracked and uniquely handled. In
>>   * particular, interactions with RDMA and filesystems need special handling.
>>   */
>> -void unpin_user_page(struct page *page)
>> +static void __unpin_user_page(struct page *page, int refs)
> 
> Refs should be unsigned everywhere.
> 
/me nods

> I suggest using clear language 'page' here should always be a compound
> head called 'head' (or do we have another common variable name for
> this?)
> 
> 'refs' is number of tail pages within the compound, so 'ntails' or
> something
> 
The usage of 'refs' seems to align with the rest of the GUP code. It's always referring to
tail pages and unpin case isn't any different IIUC.

I suppose we can always change that, but maybe better do that renaming in one shot as a
post cleanup?

>>  {
>> -	int refs = 1;
>> +	int orig_refs = refs;
>>  
>>  	page = compound_head(page);
> 
> Caller should always do this
> 
/me nods

>> @@ -237,14 +249,19 @@ void unpin_user_page(struct page *page)
>>  		return;
>>  
>>  	if (hpage_pincount_available(page))
>> -		hpage_pincount_sub(page, 1);
>> +		hpage_pincount_sub(page, refs);
>>  	else
>> -		refs = GUP_PIN_COUNTING_BIAS;
>> +		refs *= GUP_PIN_COUNTING_BIAS;
>>  
>>  	if (page_ref_sub_and_test(page, refs))
>>  		__put_page(page);
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
> 
It appears to be case based on John's follow up comment.

>> +void unpin_user_page(struct page *page)
>> +{
>> +	__unpin_user_page(page, 1);
> 
> Thus this is
> 
> 	__unpin_user_page(compound_head(page), 1);
> 
Got it.

>> @@ -274,6 +291,7 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>>  				 bool make_dirty)
>>  {
>>  	unsigned long index;
>> +	int refs = 1;
>>  
>>  	/*
>>  	 * TODO: this can be optimized for huge pages: if a series of pages is
>> @@ -286,8 +304,9 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>>  		return;
>>  	}
>>  
>> -	for (index = 0; index < npages; index++) {
>> +	for (index = 0; index < npages; index += refs) {
>>  		struct page *page = compound_head(pages[index]);
>> +
> 
> I think this is really hard to read, it should end up as some:
> 
> for_each_compond_head(page_list, page_list_len, &head, &ntails) {
>        		if (!PageDirty(head))
> 			set_page_dirty_lock(head, ntails);
> 		unpin_user_page(head, ntails);
> }
> 
/me nods Let me attempt at that.

> And maybe you open code that iteration, but that basic idea to find a
> compound_head and ntails should be computational work performed.
> 
I like the idea of a page range API alternative to unpin_user_pages(), but
improving current unpin_user_pages() would improve other unpin users too.

Perhaps the logic can be common, and the current unpin_user_pages() would have
the second iteration part, while the new (faster) API be based on computation.

> No reason not to fix set_page_dirty_lock() too while you are here.
> 
OK.

> Also, this patch and the next can be completely independent of the
> rest of the series, it is valuable regardless of the other tricks. You
> can split them and progress them independently.
> 
Yeap, let me do that.

> .. and I was just talking about this with Daniel Jordan and some other
> people at your company :)
> 

:)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
