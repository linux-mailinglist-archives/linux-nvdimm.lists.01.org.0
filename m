Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB812DEFC3
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Dec 2020 14:10:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 44282100EF278;
	Sat, 19 Dec 2020 05:10:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C218E100EF26D
	for <linux-nvdimm@lists.01.org>; Sat, 19 Dec 2020 05:10:44 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BJD9v3X157261;
	Sat, 19 Dec 2020 13:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=XHy8aNiAYN+DfGyvghFBhWP59EvHDoll+hXA4gFmEZs=;
 b=a0iMAxiflpaHkrKjZTlTUEptcoyDKntF6lQHgxbUAs8lwbevcr+QjLvWuaQLjIdIotYf
 D9cB8MbwMntYSKLtQS3lrJ0Uym8+MuiBwSGR133ni6x3Evh8j4jrMSr09Jfj8j2zFVEe
 B2BnDsExg+ZkrsV/v0sD2vm+wMKA6fD/zZeHKy/6QJF1JgDhWkbQ8tj92EJ8fraiBbrh
 IE3Zr10sDILsQ2qSqs/Op4uuqKjjVxtBj+0I+0/PSmrUiGEvVkd+YvHyWYIf8M+bFklH
 JJ+WCOVJ9J29ielSBomFeS7rzutGAAbfwSJXTbIaa6yBheqDf//FpmrhNlRAimfuIV+A jw==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2120.oracle.com with ESMTP id 35h9fkrsqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 19 Dec 2020 13:10:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BJDALB6027036;
	Sat, 19 Dec 2020 13:10:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3030.oracle.com with ESMTP id 35h6mrwbbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Dec 2020 13:10:29 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BJDAKCb013132;
	Sat, 19 Dec 2020 13:10:20 GMT
Received: from [192.168.1.188] (/89.180.84.11)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sat, 19 Dec 2020 05:10:19 -0800
Subject: Re: [PATCH RFC 7/9] mm/gup: Decrement head page once for group of
 subpages
To: John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-9-joao.m.martins@oracle.com>
 <20201208193446.GP5487@ziepe.ca>
 <cf5585f0-1352-e3ab-9dbf-0185ad0a1b31@oracle.com>
 <20201217200530.GK5487@ziepe.ca>
 <604ac536-a829-4ae6-e0c8-291ab9e0138e@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <0d482c9c-4880-bd31-5631-59c15ef0e5c5@oracle.com>
Date: Sat, 19 Dec 2020 13:10:14 +0000
MIME-Version: 1.0
In-Reply-To: <604ac536-a829-4ae6-e0c8-291ab9e0138e@nvidia.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012190097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9839 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012190097
Message-ID-Hash: QFKP63UKLYW3J6NXNUSKNRKWNUBSTINX
X-Message-ID-Hash: QFKP63UKLYW3J6NXNUSKNRKWNUBSTINX
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Daniel Jordan <daniel.m.jordan@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QFKP63UKLYW3J6NXNUSKNRKWNUBSTINX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/19/20 2:06 AM, John Hubbard wrote:
> On 12/17/20 12:05 PM, Jason Gunthorpe wrote:
>> On Thu, Dec 17, 2020 at 07:05:37PM +0000, Joao Martins wrote:
>>>> No reason not to fix set_page_dirty_lock() too while you are here.
>>>
>>> The wack of atomics you mentioned earlier you referred to, I suppose it
>>> ends being account_page_dirtied(). See partial diff at the end.
>>
>> Well, even just eliminating the lock_page, page_mapping, PageDirty,
>> etc is already a big win.
>>
>> If mapping->a_ops->set_page_dirty() needs to be called multiple times
>> on the head page I'd probably just suggest:
>>
>>    while (ntails--)
>>          rc |= (*spd)(head);
> 
> I think once should be enough. There is no counter for page dirtiness,
> and this kind of accounting is always tracked in the head page, so there
> is no reason to repeatedly call set_page_dirty() from the same
> spot.
> 
I think that's what we do even today, considering the Dirty bit is only set on the
compound head (regardless of accounting). Even without this patch,
IIUC we don't call a second set_page_dirty(head) after the first time
we dirty it. So probably there's no optimization to do here, as you say.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
