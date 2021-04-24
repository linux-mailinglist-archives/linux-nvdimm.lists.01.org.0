Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB7D36A2C1
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Apr 2021 21:06:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B9E65100EBBB3;
	Sat, 24 Apr 2021 12:06:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C4C4B100EC1D7
	for <linux-nvdimm@lists.01.org>; Sat, 24 Apr 2021 12:06:14 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13OJ67dT097076;
	Sat, 24 Apr 2021 19:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9m9uwB+GX+SNXyV+RpZIqwH2T5NVwG1l7KZ86WqGf2k=;
 b=Z7w2lD5Mz9j9ssiYa1/IgBHmknjY6iq2b82BRaTHTa8/ffYD1zz3OrxaBf1mmlyEaisi
 zAH2fQoRL2fQKmFwULw1PUlb6Ja8VbepctQ7phe3KbOmQX/6mrJEIe4HtrO+YHCcZCbU
 aVYimdlEdqoo4yfVcpbIFjlhghgufaQRNEw1+MRRH4xbzwjEdr9pWZna+eNgklldXiWS
 YcTze7sZ7lwJJvnYSzMjT3SzNoCHd0NteMDvNrj31N+nCWuO4PxcV/WgbR5abMHqKP6h
 wBtPyUJnk+mH72eb4uX1Ku+oP+mKLBjPkmUYkkQdXrpm4hj+eTyXmXsUtMlszWoyPzs9 Qw==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2120.oracle.com with ESMTP id 384b9n0qa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Apr 2021 19:06:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13OJ1XlT075506;
	Sat, 24 Apr 2021 19:06:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by aserp3020.oracle.com with ESMTP id 384b51qf9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Apr 2021 19:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOP7nHeJH993Sl4Sr/HWJvMnyTIrMbOBIxpddv/739bzSMVXGqokV10SDczX1uADlggkkH4gLV26CkVNv61z3wvVPDmAnyDLM26ilchCB9JT3M+F8QNzAGpK1U+GXd83VQc/K4qSL7bfvMTCWuTUVoPnCzV6XCeIILab6SKTvZCmBA4vNA0NmltQxDqKaBD9sQbKTblVhgNeD58ztDuU0Ze5HUCVMSha+JZp21NE4BV2zoL1P2q/MV5yGhwC0zqO1z4EyeOrcSp2toeeUqGF+c9uPiJiybiwD/xD2ncXkF65zPCQKl/kYyKXCtdsyqxVrI31CnY8xbhmvhqdGhvsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m9uwB+GX+SNXyV+RpZIqwH2T5NVwG1l7KZ86WqGf2k=;
 b=dVPx0SFuCFnRm8alXL2sIpxN2MNr6ZgkyuvXFN1gccoBJdFBoTHV6EMXpxwFE7mxgVii3Gdt51y0gMMeSpgg9QA9uptD+GvLWPatt3Z/xXo50r2wA5l0iL7upnqUFhOQg42RVWtV6G/WN3AfyJineH0RcLJ2FZ4lUDRGB+1xjsr+nwx12vHDm7o2urZDrmI8hvfGRnkBIzqOvh4R7CmGprRWTxyOAIYlwnBE3VC4KPGSzems72EkZkKDgby8sbgkt8XswcW4YbO4fP8YH1065WpqouHVBe+Zs/1i35rEBjnF4wiwnQpT0ZjnV3+8F1kBzbTR6uHgw0oNYvDFS1bTDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m9uwB+GX+SNXyV+RpZIqwH2T5NVwG1l7KZ86WqGf2k=;
 b=W4pzD8kor/TbiA+F7r2FG28XZnfkHxYNo3cOTAgN7y8I3Ea0sMlHeQ3otpsip9wsjEhaZ0yTIBgVqSUBhZboHDdVPkjwgu4GB5mwJgY0v62T5pVF5Msvk91M5dhxBpkoGSkwk5RAj8vhXSNELoc7+BLSnMA+nn+UOBIrYkvLTbY=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2743.namprd10.prod.outlook.com (2603:10b6:a02:ad::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Sat, 24 Apr
 2021 19:06:04 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.4042.026; Sat, 24 Apr 2021
 19:06:04 +0000
Subject: Re: [PATCH v1 03/11] mm/page_alloc: refactor
 memmap_init_zone_device() page init
To: Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-4-joao.m.martins@oracle.com>
 <CAPcyv4h4TrHWzrpQQHsO4FnTJcZvhw25LJSe5GZ-7ojTu=kL_A@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <53b690f6-cfdd-df95-17af-8df7ccf4e9f9@oracle.com>
Date: Sat, 24 Apr 2021 20:05:57 +0100
In-Reply-To: <CAPcyv4h4TrHWzrpQQHsO4FnTJcZvhw25LJSe5GZ-7ojTu=kL_A@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.63.165.137]
X-ClientProxiedBy: LO2P265CA0482.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::7) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.85] (94.63.165.137) by LO2P265CA0482.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Sat, 24 Apr 2021 19:06:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c6030bc-1213-4ccf-5b32-08d90754022c
X-MS-TrafficTypeDiagnostic: BYAPR10MB2743:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB2743D02FF010DBCB3C95570DBB449@BYAPR10MB2743.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JkostcCVh9N9ywKD7xyyA+x8hG4+NDrQMMEH2PoAxGLthfX3MWS4CpkglVjwLCiXfASAcC5hjdX2Qm/dOEOJ/Q9U7yhLyq9BA/yyrhIuMe/OzRCIW4KHcNQ/F8ms37ofr5F1kxpAqhAOcTpcETR3DbHs/Lud48Ch+8Rhej8Bx3ToFrkPpmTtRKUX71ngiEsXQ3uXwa+4BXykuCy3of4xKsKker34Ra+7eVDiYTih8RkFMxbMSpqLuPi22M9LBf/6HsA7ieAeclxUnrw//xa1DjPBlL2fDcE430bHU//BjSMcE2IbgGMXYUdFmXQgF7lr29/UBm2UN53I4sBG6WEehDE9H3tVCnNJ30HfX8DQ6k+XwNf+c7zH+lBiuWxW2nYoVDoAUULiY6PbFLCwcprXi++EhE2dsFyCox7lERrv/whRRj3PYotzlk2ecKkC0o6xJbCptAuoK+d7bDtucpiV0waKS2NWqkrIl/4cw0tr8yz8udLTDDUXpjv8e7F8QKG6WHlb2iVUcy+EhdkheaCZcJ+04m2snZpJ+RmbodvFRZwqz4HMJaZBUWkeJLenClGG5ElySy0TT+YAKwgCj2+lVaq71rzyfN6IS4gQNKjPf+1h89nWWHOXPKvxyUMQ0rlkRf1OWEASYZqzIEHgBWrZZw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(376002)(136003)(6666004)(36756003)(26005)(66946007)(53546011)(956004)(5660300002)(31686004)(2906002)(31696002)(86362001)(83380400001)(6486002)(16526019)(186003)(4326008)(2616005)(478600001)(316002)(8676002)(8936002)(6916009)(16576012)(66476007)(54906003)(38100700002)(66556008)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?bHJzbHVrTk1ydEladjQzTDVOMWFGdW9PSjhoSFZ3TXp2eWx0UjdFblE1VzhX?=
 =?utf-8?B?UXRwOFJkdzE5M3lvZjZOV3pZZ2VaMGoxUmcxRWxSNFFoMEY4VE41d3VaQUNr?=
 =?utf-8?B?bVNLV1VJRGEralZmSWdIOEZwekxIZlNiRWR6RUVZSlJ2TXFDZ2tJYVo4azl5?=
 =?utf-8?B?SEJQOGl0QXlUanVxRkI1Ry9KNS9IeDBodXdWbUc1SzBmTUdWSklzcWRleWdY?=
 =?utf-8?B?KzdVTjVJNmFRUWV6VGRBSkt1b1o1NXg1L1J3dEo2dE52UytSN0VYczk5VjNo?=
 =?utf-8?B?NmZUalJMR05HMzRhUEJ5ZmcvaC9HUjkwdkc3cWVFRExjZGpPRWFIaUljZG1y?=
 =?utf-8?B?eU5zbitNalZuenNwQjJSbHBvMFlNb0pOUDhUd2VlSUtkdkJiMXJsRGg4OHhV?=
 =?utf-8?B?N1YyOWpYeHBYbys3SUZ5SjVzZ0Jmb2diVDBQQ3lvdmNYQzROWHlXUzczc212?=
 =?utf-8?B?WHd0U20wODRKYlV2K1BuU3NodWV3NVV3bWVLSGFtTTZkNW9VUFIwQjBBNDNY?=
 =?utf-8?B?YnR4NEJIMWhyc3M5UXlnbFNVb3Z3Q0NTTUxFdWRVb2poU3U5NDlPQnhCeWJp?=
 =?utf-8?B?MGVLaEFZU3dnOUx6MXJWYkFBL29kSTZMUy9nRlk2ZEl1N29aZHpPTmR6Sk9a?=
 =?utf-8?B?TG1xQ3dFc0V6UGwwOGZTRFh5emxwcnR1SFJBWWNuUlllczF2MWlFZnR2ZWlt?=
 =?utf-8?B?WFZXZ0lLUzRIWjVaUlFjRWYwdGFXT0k2R2RFN1YzSS91SERiV0xZNnFYNHNp?=
 =?utf-8?B?ZnlZMHFRZWlVRjYwWis2U0g1aC82Wnhvc2Z0TWxaTHBIWHpNWnpmS0hXSmJv?=
 =?utf-8?B?b1BOdzd5WmpmRWdraWY2L3JUOTE3UUlKb29hUGRnbnJ1SzVtbkd4R2lXUWMx?=
 =?utf-8?B?UTlpc1Rkd3pnUlpMOStNbHV3N1hjUkF0d0ZiQ1ZwZG80YkJKSWlsbEVkV3Fa?=
 =?utf-8?B?elFjRDhJeWxSaVU3cVI3NzVkYTZTL1YrR2RIRVZnc1AzYlJBYS9YODZ4dnY5?=
 =?utf-8?B?VkpHOTFMSC9zcWZmS25mTGJlVXUyYWduNGZGWUxGL0R3WWlyNFJIZnBialU5?=
 =?utf-8?B?QzkwWjVBOUlRVFpRQUlsTXpIQ3REMWxNY04vK2pGV0RzTHVrVllqVGpUdWo4?=
 =?utf-8?B?Rjh3R01QTWV2bE9xNnZWeWxOMHhMaG5EZzBwTWRabDBlakFBNDZkRXNueXRB?=
 =?utf-8?B?NjJINmhPaGJFTm5SK0w2ZWdNcjhtT1hTUUFPQmt0VDJiV2F6c3dXRnBTZHVw?=
 =?utf-8?B?ZS83L3cvWkE1NXJ4THNyUUljSVNmc3hLN3VVSmh6N3VMTHBPOXFMZUxnWnVF?=
 =?utf-8?B?czBSajl1eGxkQlo3T0hSWG5LR2tWWE5JVEVzeVhLUktTRXkzWlBxVFZZVXpa?=
 =?utf-8?B?M1dKdE1tTzcxUlpoN1VkL1lTUUpyaDJTYXRDcjFvc0Z4S3JZTnFJbG9jRGdX?=
 =?utf-8?B?QXVPdkcrSlJqKyt1SmhrSGdtVXYxeXdBMWNqWGpPa1FkR3l6VGdGOW4wTG5N?=
 =?utf-8?B?S1VTUFFGd0ZMSHUvTTdBQUhTclZ0M2VOMUoyMGJSWDdRN1pETHloVUNISlVo?=
 =?utf-8?B?V0JJNjhqTUF0Mk4wYmZyNWlJeHJER1ZobFV1VDhuOHJTZmtzM1J0NWR2aHRU?=
 =?utf-8?B?YUE2QzJXQ1ovVnUwK1ZwZWJ0OEwxeEE0Z2p5Vlp6VXlzMjhzSzZIZUp3K2ZW?=
 =?utf-8?B?UUFCaXR3c3ozVGswcWRVUkdENkVhYnlQZVV5QjJDMy9qSzlLZFVETDR6V2FY?=
 =?utf-8?Q?8hafgJmXFMK1iBl+uIchMIKAN3teBUUVOwHc7U3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6030bc-1213-4ccf-5b32-08d90754022c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2021 19:06:04.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sl+U2GrThLPSSSVKr0dcEtxoYmfaR/BG7BIozaUa6WcVxxfV2qTAXY5NJBoRPig7kyzyUSlAOukZzWbxFhNKQh97U4bI2nXfxgqhdDOjRyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2743
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9964 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104240143
X-Proofpoint-ORIG-GUID: T4vqiSMH9zV9xxBvYyTKJ4RbkUXOhAl_
X-Proofpoint-GUID: T4vqiSMH9zV9xxBvYyTKJ4RbkUXOhAl_
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9964 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104240143
Message-ID-Hash: BJ2JKROP7R4SKNPPYKX5D5Z37SXMZMKC
X-Message-ID-Hash: BJ2JKROP7R4SKNPPYKX5D5Z37SXMZMKC
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BJ2JKROP7R4SKNPPYKX5D5Z37SXMZMKC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 4/24/21 1:18 AM, Dan Williams wrote:
> On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> Move struct page init to an helper function __init_zone_device_page().
> 
> Same sentence addition suggestion from the last patch to make this
> patch have some rationale for existing.
> 
I have fixed this too, with the same message as the previous patch.

>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  mm/page_alloc.c | 74 +++++++++++++++++++++++++++----------------------
>>  1 file changed, 41 insertions(+), 33 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 43dd98446b0b..58974067bbd4 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6237,6 +6237,46 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
>>  }
>>
>>  #ifdef CONFIG_ZONE_DEVICE
>> +static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>> +                                         unsigned long zone_idx, int nid,
>> +                                         struct dev_pagemap *pgmap)
>> +{
>> +
>> +       __init_single_page(page, pfn, zone_idx, nid);
>> +
>> +       /*
>> +        * Mark page reserved as it will need to wait for onlining
>> +        * phase for it to be fully associated with a zone.
>> +        *
>> +        * We can use the non-atomic __set_bit operation for setting
>> +        * the flag as we are still initializing the pages.
>> +        */
>> +       __SetPageReserved(page);
>> +
>> +       /*
>> +        * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
>> +        * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
>> +        * ever freed or placed on a driver-private list.
>> +        */
>> +       page->pgmap = pgmap;
>> +       page->zone_device_data = NULL;
>> +
>> +       /*
>> +        * Mark the block movable so that blocks are reserved for
>> +        * movable at startup. This will force kernel allocations
>> +        * to reserve their blocks rather than leaking throughout
>> +        * the address space during boot when many long-lived
>> +        * kernel allocations are made.
>> +        *
>> +        * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
>> +        * because this is done early in section_activate()
>> +        */
>> +       if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
>> +               set_pageblock_migratetype(page, MIGRATE_MOVABLE);
>> +               cond_resched();
>> +       }
>> +}
>> +
>>  void __ref memmap_init_zone_device(struct zone *zone,
>>                                    unsigned long start_pfn,
>>                                    unsigned long nr_pages,
>> @@ -6265,39 +6305,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>         for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>>                 struct page *page = pfn_to_page(pfn);
>>
>> -               __init_single_page(page, pfn, zone_idx, nid);
>> -
>> -               /*
>> -                * Mark page reserved as it will need to wait for onlining
>> -                * phase for it to be fully associated with a zone.
>> -                *
>> -                * We can use the non-atomic __set_bit operation for setting
>> -                * the flag as we are still initializing the pages.
>> -                */
>> -               __SetPageReserved(page);
>> -
>> -               /*
>> -                * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
>> -                * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
>> -                * ever freed or placed on a driver-private list.
>> -                */
>> -               page->pgmap = pgmap;
>> -               page->zone_device_data = NULL;
>> -
>> -               /*
>> -                * Mark the block movable so that blocks are reserved for
>> -                * movable at startup. This will force kernel allocations
>> -                * to reserve their blocks rather than leaking throughout
>> -                * the address space during boot when many long-lived
>> -                * kernel allocations are made.
>> -                *
>> -                * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
>> -                * because this is done early in section_activate()
>> -                */
>> -               if (IS_ALIGNED(pfn, pageblock_nr_pages)) {
>> -                       set_pageblock_migratetype(page, MIGRATE_MOVABLE);
>> -                       cond_resched();
>> -               }
>> +               __init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>>         }
>>
>>         pr_info("%s initialised %lu pages in %ums\n", __func__,
>> --
>> 2.17.1
>>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
