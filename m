Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29837387E5D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 May 2021 19:27:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4998E100EBB9C;
	Tue, 18 May 2021 10:27:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A5234100EBB72
	for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 10:27:32 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14IHPKdR133009;
	Tue, 18 May 2021 17:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0KlNmgM0Q45wmRsStaNiYs1mUyY09B+Gcxo0el/I9EI=;
 b=sWlkU6TFmcDTUQ5dzANtkamfq3vfU/2qZ2UE1HlQm8lagHwDrBP1/y7kw25TnY4kaM63
 /zGDwSeghnpN5XZSzX38XEpRDRgR/TcIpD+iBuxJa/UGgHg3xqPZXf/Wuzb/SLJLvVsq
 S4VdnW34LuaSzV5Q+zCDsq2yCj62jFAlm8PiTchCygY0UiwPvMVzN4xzsnaTHeRo2Ttq
 G7XWlACSN5WEI2YdBmPtDE8YekSXQXAEFJx7zeM2OEg7j2eacKe6jlnef/xwzhg8oSux
 AXNbK7aO/JJ5HlvtmjZRZ5tc7w8A+lIF9aOfOVh7jRhu37ufiB/CfO5Q8Mz69pRUx7rr jg==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 38j6xnf3st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 May 2021 17:27:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14IHL20Q138857;
	Tue, 18 May 2021 17:27:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by aserp3030.oracle.com with ESMTP id 38meefdv5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 May 2021 17:27:14 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14IHMPur140717;
	Tue, 18 May 2021 17:27:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 38meefdv4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 May 2021 17:27:13 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14IHRAxg029683;
	Tue, 18 May 2021 17:27:10 GMT
Received: from [10.175.193.212] (/10.175.193.212)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 18 May 2021 10:27:10 -0700
Subject: Re: [PATCH v1 04/11] mm/memremap: add ZONE_DEVICE support for
 compound pages
From: Joao Martins <joao.m.martins@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-5-joao.m.martins@oracle.com>
 <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
 <cd1c9849-8660-dbdc-718a-aa4ba5d48c01@oracle.com>
 <CAPcyv4jG8+S6xJyp=1S2=dpit0Hs2+HgGwpWeRROCRuJnQYAxQ@mail.gmail.com>
 <56a3e271-4ef8-ba02-639e-fd7fe7de7e36@oracle.com>
Message-ID: <8c922a58-c901-1ad9-5d19-1182bd6dea1e@oracle.com>
Date: Tue, 18 May 2021 18:27:06 +0100
MIME-Version: 1.0
In-Reply-To: <56a3e271-4ef8-ba02-639e-fd7fe7de7e36@oracle.com>
Content-Language: en-US
X-Proofpoint-GUID: jI6rP2oZqT1Hel8hHQ5EU9nHK8pbXRv4
X-Proofpoint-ORIG-GUID: jI6rP2oZqT1Hel8hHQ5EU9nHK8pbXRv4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9988 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105180120
Message-ID-Hash: YSJNBMUN6C76EU62KJ7BDDJQGJIEIZ4Y
X-Message-ID-Hash: YSJNBMUN6C76EU62KJ7BDDJQGJIEIZ4Y
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YSJNBMUN6C76EU62KJ7BDDJQGJIEIZ4Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/5/21 11:36 PM, Joao Martins wrote:
> On 5/5/21 11:20 PM, Dan Williams wrote:
>> On Wed, May 5, 2021 at 12:50 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>> On 5/5/21 7:44 PM, Dan Williams wrote:
>>>> On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>>>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>>>>> index b46f63dcaed3..bb28d82dda5e 100644
>>>>> --- a/include/linux/memremap.h
>>>>> +++ b/include/linux/memremap.h
>>>>> @@ -114,6 +114,7 @@ struct dev_pagemap {
>>>>>         struct completion done;
>>>>>         enum memory_type type;
>>>>>         unsigned int flags;
>>>>> +       unsigned long align;
>>>>
>>>> I think this wants some kernel-doc above to indicate that non-zero
>>>> means "use compound pages with tail-page dedup" and zero / PAGE_SIZE
>>>> means "use non-compound base pages".

[...]

>>>> The non-zero value must be
>>>> PAGE_SIZE, PMD_PAGE_SIZE or PUD_PAGE_SIZE.
>>>> Hmm, maybe it should be an
>>>> enum:
>>>>
>>>> enum devmap_geometry {
>>>>     DEVMAP_PTE,
>>>>     DEVMAP_PMD,
>>>>     DEVMAP_PUD,
>>>> }
>>>>
>>> I suppose a converter between devmap_geometry and page_size would be needed too? And maybe
>>> the whole dax/nvdimm align values change meanwhile (as a followup improvement)?
>>
>> I think it is ok for dax/nvdimm to continue to maintain their align
>> value because it should be ok to have 4MB align if the device really
>> wanted. However, when it goes to map that alignment with
>> memremap_pages() it can pick a mode. For example, it's already the
>> case that dax->align == 1GB is mapped with DEVMAP_PTE today, so
>> they're already separate concepts that can stay separate.
>>
> Gotcha.

I am reconsidering part of the above. In general, yes, the meaning of devmap @align
represents a slightly different variation of the device @align i.e. how the metadata is
laid out **but** regardless of what kind of page table entries we use vmemmap.

By using DEVMAP_PTE/PMD/PUD we might end up 1) duplicating what nvdimm/dax already
validates in terms of allowed device @align values (i.e. PAGE_SIZE, PMD_SIZE and PUD_SIZE)
2) the geometry of metadata is very much tied to the value we pick to @align at namespace
provisioning -- not the "align" we might use at mmap() perhaps that's what you referred
above? -- and 3) the value of geometry actually derives from dax device @align because we
will need to create compound pages representing a page size of @align value.

Using your example above: you're saying that dax->align == 1G is mapped with DEVMAP_PTEs,
in reality the vmemmap is populated with PMDs/PUDs page tables (depending on what archs
decide to do at vmemmap_populate()) and uses base pages as its metadata regardless of what
device @align. In reality what we want to convey in @geometry is not page table sizes, but
just the page size used for the vmemmap of the dax device. Additionally, limiting its
value might not be desirable... if tomorrow Linux for some arch supports dax/nvdimm
devices with 4M align or 64K align, the value of @geometry will have to reflect the 4M to
create compound pages of order 10 for the said vmemmap.

I am going to wait until you finish reviewing the remaining four patches of this series,
but maybe this is a simple misnomer (s/align/geometry/) with a comment but without
DEVMAP_{PTE,PMD,PUD} enum part? Or perhaps its own struct with a value and enum a
setter/getter to audit its value? Thoughts?

		Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
