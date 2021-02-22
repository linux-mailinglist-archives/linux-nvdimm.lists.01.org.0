Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43D6321A60
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 15:32:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1FF92100EB82B;
	Mon, 22 Feb 2021 06:32:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0E58B100EBB62
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 06:32:24 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MEOrhM169678;
	Mon, 22 Feb 2021 14:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=2wEpOLBLEvqyWBLRlyo2oyjO8rpsGnpavVUMVu9O5jU=;
 b=PbJVQuI9Spl8Zg5ReN4mTdiPcgLixoc/ZSFknmtrs1xSpAUY+1u7Y/VwnJFRAMKWMIy6
 mahIk5vG86gGArnGvoJB9z9dVH8ntpq90cngPvxq/CE/FrThOQ7UuvOAe54DW/u/nQ06
 S1AD50rSyfIDoFH90vF1/9tZWogTKBfvMhaElA0x4iTRLZQaTU0xfbeAF8L1W6HYS3IG
 bqpDKedl3S+bueJYAnbh1LfbByMxdO1CneRn77bj8TJ7ikQsGG0cJCYNiJS2QlF/2ErK
 c0AbWxXeHupzv6hUC4lVDoLI1NJ3cuIiuJsqbUJX6A5yhgaVhBCmFeUijVZ6KCJ/0Bza vg==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2130.oracle.com with ESMTP id 36tqxbbwmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 14:32:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MEQPoQ189482;
	Mon, 22 Feb 2021 14:32:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 36ucbw5mep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 14:32:13 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11MEW80c028890;
	Mon, 22 Feb 2021 14:32:09 GMT
Received: from [10.175.205.179] (/10.175.205.179)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 22 Feb 2021 06:32:08 -0800
Subject: Re: [PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps
From: Joao Martins <joao.m.martins@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <CAPcyv4gQQ03-nhBNwLK6KDc953SVD1rOs7HFBo_Mu9LFTkXRgw@mail.gmail.com>
 <ca888299-c576-567b-e6c3-5df3bcd8ca51@oracle.com>
Message-ID: <872eec38-3c18-72dd-c5c6-147c02ae33d1@oracle.com>
Date: Mon, 22 Feb 2021 14:32:04 +0000
MIME-Version: 1.0
In-Reply-To: <ca888299-c576-567b-e6c3-5df3bcd8ca51@oracle.com>
Content-Language: en-US
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220134
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220134
Message-ID-Hash: JIHA5YBI3KWTQUO5WQALUK4M4VLHEX73
X-Message-ID-Hash: JIHA5YBI3KWTQUO5WQALUK4M4VLHEX73
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JIHA5YBI3KWTQUO5WQALUK4M4VLHEX73/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 2/22/21 11:06 AM, Joao Martins wrote:
> On 2/20/21 1:18 AM, Dan Williams wrote:
>> On Tue, Dec 8, 2020 at 9:32 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>>
>>> The link above describes it quite nicely, but the idea is to reuse tail
>>> page vmemmap areas, particular the area which only describes tail pages.
>>> So a vmemmap page describes 64 struct pages, and the first page for a given
>>> ZONE_DEVICE vmemmap would contain the head page and 63 tail pages. The second
>>> vmemmap page would contain only tail pages, and that's what gets reused across
>>> the rest of the subsection/section. The bigger the page size, the bigger the
>>> savings (2M hpage -> save 6 vmemmap pages; 1G hpage -> save 4094 vmemmap pages).
>>>
>>> In terms of savings, per 1Tb of memory, the struct page cost would go down
>>> with compound pagemap:
>>>
>>> * with 2M pages we lose 4G instead of 16G (0.39% instead of 1.5% of total memory)
>>> * with 1G pages we lose 8MB instead of 16G (0.0007% instead of 1.5% of total memory)
>>
>> Nice!
>>
> 
> I failed to mention this in the cover letter but I should say that with this trick we will
> need to build the vmemmap page tables with basepages for 2M align, as opposed to hugepages
> in the vmemmap page tables (as you probably could tell from the patches). 

Also to be clear: by "we will need to build the vmemmap page tables with basepages for 2M
align" I strictly refer to the ZONE_DEVICE range we are mapping the struct pages. It's not
the enterity of the vmemmap!

> This means that
> we have to allocate a PMD page, and that costs 2GB per 1Tb (as opposed to 4M). This is
> fixable for 1G align by reusing PMD pages (albeit I haven't done that in this RFC series).
> 
> The footprint reduction is still big, so to iterate the numbers above (and I will fix this
> in the v2 cover letter):
> 
> * with 2M pages we lose 4G instead of 16G (0.39% instead of 1.5% of total memory)
> * with 1G pages we lose 8MB instead of 16G (0.0007% instead of 1.5% of total memory)
> 
> For vmemmap page tables, we need to use base pages for 2M pages. So taking that into
> account, in this RFC series:
> 
> * with 2M pages we lose 6G instead of 16G (0.586% instead of 1.5% of total memory)
> * with 1G pages we lose ~2GB instead of 16G (0.19% instead of 1.5% of total memory)
> 
> For 1G align, we are able to reuse vmemmap PMDs that only point to tail pages, so
> ultimately we can get the page table overhead from 2GB to 12MB:
> 
> * with 1G pages we lose 20MB instead of 16G (0.0019% instead of 1.5% of total memory)
> 
>>>
>>> The RDMA patch (patch 8/9) is to demonstrate the improvement for an existing
>>> user. For unpin_user_pages() we have an additional test to demonstrate the
>>> improvement.  The test performs MR reg/unreg continuously and measuring its
>>> rate for a given period. So essentially ib_mem_get and ib_mem_release being
>>> stress tested which at the end of day means: pin_user_pages_longterm() and
>>> unpin_user_pages() for a scatterlist:
>>>
>>>     Before:
>>>     159 rounds in 5.027 sec: 31617.923 usec / round (device-dax)
>>>     466 rounds in 5.009 sec: 10748.456 usec / round (hugetlbfs)
>>>
>>>     After:
>>>     305 rounds in 5.010 sec: 16426.047 usec / round (device-dax)
>>>     1073 rounds in 5.004 sec: 4663.622 usec / round (hugetlbfs)
>>
>> Why does hugetlbfs get faster for a ZONE_DEVICE change? Might answer
>> that question myself when I get to patch 8.
>>
> Because the unpinning improvements aren't ZONE_DEVICE specific.
> 
> FWIW, I moved those two offending patches outside of this series:
> 
>   https://lore.kernel.org/linux-mm/20210212130843.13865-1-joao.m.martins@oracle.com/
> 
>>>
>>> Patch 9: Improves {pin,get}_user_pages() and its longterm counterpart. It
>>> is very experimental, and I imported most of follow_hugetlb_page(), except
>>> that we do the same trick as gup-fast. In doing the patch I feel this batching
>>> should live in follow_page_mask() and having that being changed to return a set
>>> of pages/something-else when walking over PMD/PUDs for THP / devmap pages. This
>>> patch then brings the previous test of mr reg/unreg (above) on parity
>>> between device-dax and hugetlbfs.
>>>
>>> Some of the patches are a little fresh/WIP (specially patch 3 and 9) and we are
>>> still running tests. Hence the RFC, asking for comments and general direction
>>> of the work before continuing.
>>
>> Will go look at the code, but I don't see anything scary conceptually
>> here. The fact that pfn_to_page() does not need to change is among the
>> most compelling features of this approach.
>>
> Glad to hear that :D
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
