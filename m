Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15A2D40E8
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Dec 2020 12:21:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 07115100EBBB7;
	Wed,  9 Dec 2020 03:21:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 11FB5100EBBB1
	for <linux-nvdimm@lists.01.org>; Wed,  9 Dec 2020 03:21:21 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9BJdnN046968;
	Wed, 9 Dec 2020 11:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=z6hAobMv7KYlHFS23DvWxhWf+Qx1Airt1t0G7t8eIe4=;
 b=QC6y9gEPnLLR5RyMBKsPmYlKJ2r+ktJ1u7fiFl6GJoZWzMPnpYoz3cqG7kbY/B+FZMHq
 TBWB+GeiEcziNLjmcMRQ2rm2QqIcyy3IrYRZTTUDOsNKgwUWTKa/XDUFKEy4brRjyKnZ
 Y38UKfC4gXBKtgtpnSWc9Iy4y4qNz4ien2tTxr5BgMT/VcAV/XpNupO04N1H1dAnHsTr
 YanVzT789Jo1inUmXNq60EkTvqgOujXJbNA05/QXr/5a911owWimjCHoC94MkQSTqLf1
 rSphq8iNBYACgkHLDwWC1sjRa4SiDkBeRw4/CgbzCQl3ZcWCHs1y71lbkCACRbQEmHTw 8g==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2130.oracle.com with ESMTP id 357yqbyqdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 09 Dec 2020 11:21:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9BBmTx147645;
	Wed, 9 Dec 2020 11:19:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 358m50d5re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Dec 2020 11:19:12 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B9BJARk009711;
	Wed, 9 Dec 2020 11:19:11 GMT
Received: from [10.175.160.66] (/10.175.160.66)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 09 Dec 2020 03:19:10 -0800
Subject: Re: [PATCH RFC 9/9] mm: Add follow_devmap_page() for devdax vmas
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-11-joao.m.martins@oracle.com>
 <20201208195754.GR5487@ziepe.ca>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <7cf4de6b-5377-394b-d95a-586e6422b9cd@oracle.com>
Date: Wed, 9 Dec 2020 11:19:04 +0000
MIME-Version: 1.0
In-Reply-To: <20201208195754.GR5487@ziepe.ca>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090079
Message-ID-Hash: C5GRQHZZ4ADE5FMTF6YXV6WAKHL53HOK
X-Message-ID-Hash: C5GRQHZZ4ADE5FMTF6YXV6WAKHL53HOK
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C5GRQHZZ4ADE5FMTF6YXV6WAKHL53HOK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/8/20 7:57 PM, Jason Gunthorpe wrote:
> On Tue, Dec 08, 2020 at 05:29:01PM +0000, Joao Martins wrote:
>> Similar to follow_hugetlb_page() add a follow_devmap_page which rather
>> than calling follow_page() per 4K page in a PMD/PUD it does so for the
>> entire PMD, where we lock the pmd/pud, get all pages , unlock.
>>
>> While doing so, we only change the refcount once when PGMAP_COMPOUND is
>> passed in.
>>
>> This let us improve {pin,get}_user_pages{,_longterm}() considerably:
>>
>> $ gup_benchmark -f /dev/dax0.2 -m 16384 -r 10 -S [-U,-b,-L] -n 512 -w
>>
>> (<test>) [before] -> [after]
>> (get_user_pages 2M pages) ~150k us -> ~8.9k us
>> (pin_user_pages 2M pages) ~192k us -> ~9k us
>> (pin_user_pages_longterm 2M pages) ~200k us -> ~19k us
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> I've special-cased this to device-dax vmas given its similar page size
>> guarantees as hugetlbfs, but I feel this is a bit wrong. I am
>> replicating follow_hugetlb_page() as RFC ought to seek feedback whether
>> this should be generalized if no fundamental issues exist. In such case,
>> should I be changing follow_page_mask() to take either an array of pages
>> or a function pointer and opaque arguments which would let caller pick
>> its structure?
> 
> I would be extremely sad if this was the only way to do this :(
> 
> We should be trying to make things more general. 

Yeap, indeed.

Specially, when similar problem is observed for THP, at least from the
measurements I saw. It is all slow, except for hugetlbfs.

> The
> hmm_range_fault_path() doesn't have major special cases for device, I
> am struggling to understand why gup fast and slow do.
> 
> What we've talked about is changing the calling convention across all
> of this to something like:
> 
> struct gup_output {
>    struct page **cur;
>    struct page **end;
>    unsigned long vaddr;
>    [..]
> }
> 
> And making the manipulator like you saw for GUP common:
> 
> gup_output_single_page()
> gup_output_pages()
> 
> Then putting this eveywhere. This is the pattern that we ended up with
> in hmm_range_fault, and it seems to be working quite well.
> 
> fast/slow should be much more symmetric in code than they are today,
> IMHO.. 

Thanks for the suggestions above.

I think those differences mainly exist because it used to be
> siloed in arch code. Some of the differences might be bugs, we've seen
> that a few times at least..
Interesting, wasn't aware of the siloing.

I'll go investigate how this all refactoring goes together, at the point
of which a future iteration of this particular patch probably needs to
move independently from this series.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
