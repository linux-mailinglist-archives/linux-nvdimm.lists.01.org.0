Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D093214CC
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 12:10:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E66D3100EBB90;
	Mon, 22 Feb 2021 03:10:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A5D9C100EBB82
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 03:09:57 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MB8l4v079208;
	Mon, 22 Feb 2021 11:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=95gCjfNpwqR5aIMHr9lPdi32J4FG0xXXd5TSIq3v0oI=;
 b=nvAiWlUNixs5m0M4UsOkYyKBVZMONxmbj8CDRbpUxyI6CGhZyADd6SpdLKY7vQ0kaTI+
 hqFlWWz2Uuz69tN3G6GFbBsUGtkj91/I6amjdr98pAqPJLwRCJUtWFEuM7ayylshpMbi
 raKSjHjAxfImyNN1hmh8TWdBk6s/FjtiQAxxlG1yyUxzePy+KctCHA7Iqzr495TmLo6Q
 hDDJyzaVdEWp3Lo9cwNsf76tuFQxtWDt+pQ9RuDxE3hWXcsHMv9OE6BaPfhTVKrMUjY1
 wXfet/WSDIlBs+4R1Hr/0GzUdcopnTiSA55lfEiGhB9vJf5BUhE9b3cSTBDcWPVwK1f1 kg==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 36tqxbbc5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 11:09:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MB04Z4082285;
	Mon, 22 Feb 2021 11:09:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by userp3020.oracle.com with ESMTP id 36uc6q6x8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 11:09:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWqBdgKG6iCTHsWy2Hv2JHxnLYwzEVGs9knAebyq5/Va5wnb6E9ry7065RJNtshZjYyGGn+hfRqQ+N8TVaaUpNj8qVWHOg3cUFrU6eiKrHGk5Abl78n9bCyWBnbbMo8mNPkWawsxt4nHkwSwnIehwFeGcdoOmQspYcDG/rou5/xi8/CROWCtLoCRGdsX7cX3U92Hk/yxr7gO5kngzM8QY4y5gkrbl0MCGYlLvzclZc9Vj1jrZyBRZ0USi3nnXKQXuY3PiTc2y94Dr2KxaLSN+G+zf2uYJt6iuzr9QNcGtSJuZCJxWTDJgcO8+HzKhPw/EI6oWj5QdpG2QX+BACGMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95gCjfNpwqR5aIMHr9lPdi32J4FG0xXXd5TSIq3v0oI=;
 b=mafOLOzAfDX8o36PVLCa1qc6grQS/kL4FQBsGDF0rK8XccmG2cA1o4q7kfYYu1KX4KclTAlK3hPCuHcFoKRNQCCJlZZF91v0X/IFVsBKgerRgcSDRfEs7AHGj7ZVbdWzvnmUuOF1Ettup6xiSzO1Xrv+bX3c7+5LqwEK5pR5wKmfFQjPNYRx7P01JrXEybo7cvdKqAS1EvOLoj5hcYzl4Oyu27onnSqhhE/C5vrwjqNcelm12/467ZPviFYey6DTUrDkXkXEcKuU+e1WmABzhCTlEe88WUn9roLXSED65ZTp95Nv2QmzPSWHqLep36y76THsVV+1sDq4gheOc6E57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95gCjfNpwqR5aIMHr9lPdi32J4FG0xXXd5TSIq3v0oI=;
 b=HafPyY+15YQG+LntGlazw2rokzvKtzp5dr6AzIMZkSrxpS0WFd/OjBEU2p9UwsUySnxEPzvEvfr++oVyLvYqESRLTESHdGf2UEDNv48+S2pyMs3+/dJPWjoBEy6bBD2OA3W4ZVfqeyciF9ceJTqCWcJ8ORl7qQI5QMmeziD104A=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4592.namprd10.prod.outlook.com (2603:10b6:a03:2d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Mon, 22 Feb
 2021 11:09:45 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 11:09:45 +0000
Subject: Re: [PATCH RFC 1/9] memremap: add ZONE_DEVICE support for compound
 pages
To: Dan Williams <dan.j.williams@intel.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-2-joao.m.martins@oracle.com>
 <CAPcyv4g8AEaxOcPHQNG7pgaYJHOtthcFogroGoPg2f8Fu6SN=g@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <27868b50-0a14-8ee1-c4e6-efb50c1d59e3@oracle.com>
Date: Mon, 22 Feb 2021 11:09:37 +0000
In-Reply-To: <CAPcyv4g8AEaxOcPHQNG7pgaYJHOtthcFogroGoPg2f8Fu6SN=g@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::20) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO2P265CA0224.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:b::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29 via Frontend Transport; Mon, 22 Feb 2021 11:09:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03e65c42-c465-4544-5abe-08d8d7225c4e
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<SJ0PR10MB4592EB9890CA3732325E25E5BB819@SJ0PR10MB4592.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Jx1cMRKspLCeFNf2SKDs9sDRzf/4rMYmDQivHhgu3C+QLg1AtFrnR67HcgISMj1jOCRCDB9Ec/02UFXJPYkMBWzQFN0Sc+sjV0y78gkKI7N2FQqUQJcOvYrGTPZgvUwHAZsxm4TfIw2gdhgzpzKe68ayy9sLBfNdnhltFImmeG6U3NhKPu7+WF2yNnFRXO6ztxu/Iv04X2QIOGtfDLIbNo5JIqUotMBejNoS1LI8S1Fx7V+77HfyqvGMnHqlqhAoNo6k7m3DQDnJjh41TqmoXghnx99Y2Dyj8F8VMW3OaguzzLVh786j3XZmgBGjFUhuKadd6oeAR0KeKczLAqj0ruXJ8KCTAyUHxu09+ikFkRUm4bBrk0dFeJ4nZ8mdFv0EY6kYseelxj7Y7TegE4CxIm9xzgSQE7HydfbxbdvhPFqYkNvwW8LIVepPwy7HPEbJIS/Sk9s8wZ9aF0QkxARUmKeWlQsSUz6bWophV75XqORzuSFLqnyS5+d4/+C9wI7xHlDzw6KY0cqlkx3o+KldT5e1T9s9AZLJ38cP57DNu6eOT/NWLLf+s1nMr4A9sM9n
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(366004)(39860400002)(16576012)(316002)(478600001)(54906003)(16526019)(8936002)(2906002)(186003)(31686004)(4326008)(31696002)(83380400001)(6666004)(36756003)(8676002)(6486002)(26005)(53546011)(6916009)(956004)(2616005)(86362001)(66556008)(5660300002)(66476007)(66946007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?eklXeWRkVzM2eFRVTzRSMklIMGwxZHVmRnErNzhZMGRzTC9HRmErNEJPdzRn?=
 =?utf-8?B?ME5nWTl1NU5iZExUbGU0Zndaem4xWXpxTFUxZHNPNSt4TWdxMG9CeU8yc0Nq?=
 =?utf-8?B?Z3ArRXlxRlVpTEVBMHd2WVNiSG9ROTRValJXc2dCR2JyNnY1YVAwRWdWUnh6?=
 =?utf-8?B?Y2xPaEdYZzA1U0hDSjYyZi9YMGhRTEhrdDVhRjRqbmpxRzlpMjV5dUhRUGx6?=
 =?utf-8?B?ZlNNblQ1eWRSa0dhL3kyU04yL0Q2d1dhTWhQLzBVTzF6alFZUmhjUUlQK2JY?=
 =?utf-8?B?N082NENaRmc5VlgxemlZV1RGeUIvUG8rSE9yd3Ftb2lCNmswMXVHK1BPWm5M?=
 =?utf-8?B?KzZFYTNiUm9YQm1oVlpuUFhheU4vNlRicGdJSi9uN0N4eS9Va3lzeHdmNkNL?=
 =?utf-8?B?ZnNEV1lIKzdGZlhpQjI1VXhneURGRnJPWGRRZ1NXMjEvajlaTlR5aUEva2My?=
 =?utf-8?B?ZEhXNTZlN2lkYXkwTkFiV083c1daUW1TcFh5cStCbU1FWWRrYWJ6YlNlcFhl?=
 =?utf-8?B?Y0JUandvUzFpVUdpdFJaVmZBd25CZFF3QmtzVGU2YVg2NVRVNzc3Z0NnNThQ?=
 =?utf-8?B?VkdLVkpQTnRqZWVEaUtsbkxlWm4rQWhBdGxJM3lGNGpyQVhnRmMwTlExdUFB?=
 =?utf-8?B?V3ZOcHpzNmQyM3B3dzAyV2plZDl4K2FPdHBySjczeVN2dnJJWC80ZktBVStk?=
 =?utf-8?B?c293SjJlOVk1VG5UZkZGVUxRU3c0SXJ2aHFudm9ZTVZSZEhjQ3JLRlcwZ0Nq?=
 =?utf-8?B?VkxCUlpKUjlMOXM4OENBOU1oRXZhT3FlaDZJNzFUek4wN3haM2VBeUJCQ3hJ?=
 =?utf-8?B?ZzB4NVh1NlFFYXJabCtXcGpkU05EdHFzaFBVaEJmYXRZMkF1citxRmxrNktJ?=
 =?utf-8?B?S3dFVUlzN2hLd05tNlJSNkRPQzJkall2UmJGcGpTbFl1NHd3NlFTVkpHOTdz?=
 =?utf-8?B?YkJXb0J3SmkzYlpqNUI3aVV0Y1liVm9KK2o4S0RWc1NvME4vQnFnU0pGWFIw?=
 =?utf-8?B?UXRZZEZ4S2tFMXhiajFsRTM0RGRGNjloaGFnSGYvcFNLUkcwalc5Qks5YmtT?=
 =?utf-8?B?NXc1aGpySjZiR1laRTduRDBnSjM2R3BXR3Ezc1Q5K2h5MEsyRXo2RUpJVG5n?=
 =?utf-8?B?Mzgra0QzWEo5OXBXWS85empWRGxZakM3NXdlN25JMzJJSGI4S3dqYnpKZEdk?=
 =?utf-8?B?dERhbDUvU1ZmVFFIeXE2bFFyODE3UUxxSUt0QnVHbE03VjhWYkZmanNGclhO?=
 =?utf-8?B?VXFCUFZJaHVIQmpieFg2MzdCRnVYeWlMait3N1BJM3RVdVdjd2M5QVlRa1A0?=
 =?utf-8?B?OXhINTRPUFFnVzlkVHZtOTM4QjdmZGJlbkwwaHBHL2JxWkl6M2VsbWtLNUls?=
 =?utf-8?B?ZmpoMmtkUnJQdUo4WXk0a01nblBWQVJ1Y2RUQnZyVTFlNGR4ZHdRam4wNjZZ?=
 =?utf-8?B?NkppTVpPWUxyL1Z0b3pveHlrL0dNRmdPWFRXL0FtZ1RXbHBEb3ZidEJrWnlN?=
 =?utf-8?B?ZTVSZUIrUGJlS09SdTRicnp3a25OdlRIWTZoTEYzRHFwYXdwU0luUVAxMnk1?=
 =?utf-8?B?aVJoUkJ0eTRSZ21peUpaOVZCRloycUZZS25zK1hqZk85QzA1ZnQ2QUd3RUN2?=
 =?utf-8?B?NncycUJScjc0OXZIaU41OUtEREFjUmhTd2g4ZWJ3Q2sxNnNYVUphdXF2VzlO?=
 =?utf-8?B?S3o1TUYzbW55eFRyN210Ym1ndklCMnNzK2ZKa2ZLN2JYOStrQm52Tlk3eTE0?=
 =?utf-8?Q?MLmoKo/FLqBR70UcxuRNqP1Viu4NSuOMgqYL/3S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e65c42-c465-4544-5abe-08d8d7225c4e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 11:09:45.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNgoFC/4Haw1+0NATYoomcW4clJ5Mf/CfaGwz3GWh6kQhEiLuK5t6XBobGdM6PKGSy/O5irynCFSW2S9ooswMBEPIsONdte4HSDEqTzGUB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4592
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220102
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220103
Message-ID-Hash: MYGUC36MX56W2HMDGIYFDJHTPL65CUZA
X-Message-ID-Hash: MYGUC36MX56W2HMDGIYFDJHTPL65CUZA
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MYGUC36MX56W2HMDGIYFDJHTPL65CUZA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/20/21 1:24 AM, Dan Williams wrote:
> On Tue, Dec 8, 2020 at 9:32 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> Add a new flag for struct dev_pagemap which designates that a a pagemap
>> is described as a set of compound pages or in other words, that how
>> pages are grouped together in the page tables are reflected in how we
>> describe struct pages. This means that rather than initializing
>> individual struct pages, we also initialize these struct pages, as
>> compound pages (on x86: 2M or 1G compound pages)
>>
>> For certain ZONE_DEVICE users, like device-dax, which have a fixed page
>> size, this creates an opportunity to optimize GUP and GUP-fast walkers,
>> thus playing the same tricks as hugetlb pages.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  include/linux/memremap.h | 2 ++
>>  mm/memremap.c            | 8 ++++++--
>>  mm/page_alloc.c          | 7 +++++++
>>  3 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>> index 79c49e7f5c30..f8f26b2cc3da 100644
>> --- a/include/linux/memremap.h
>> +++ b/include/linux/memremap.h
>> @@ -90,6 +90,7 @@ struct dev_pagemap_ops {
>>  };
>>
>>  #define PGMAP_ALTMAP_VALID     (1 << 0)
>> +#define PGMAP_COMPOUND         (1 << 1)
> 
> Why is a new flag needed versus just the align attribute? In other
> words there should be no need to go back to the old/slow days of
> 'struct page' per pfn after compound support is added.
> 
Ack, I suppose I could just use pgmap @align attribute as you mentioned.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
