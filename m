Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6897836A2C0
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Apr 2021 21:05:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 80C56100EC1D7;
	Sat, 24 Apr 2021 12:05:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4590C100ED4BB
	for <linux-nvdimm@lists.01.org>; Sat, 24 Apr 2021 12:05:46 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13OJ5bI5173093;
	Sat, 24 Apr 2021 19:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6nKr4Ufk+xeUs6pTH+TN9u869KzU0eVkZFJaQJf3q/s=;
 b=uYcv0EDburIJFlbkvkfJzaKZ4uI5ynSr0hHAIKu2yXUSxawkirLWFVlXyp5BjCZE+MDZ
 456PHgh+YygiJWBu5CrnNdRjVZTDnhzXvvY85sWmG7Q90UH7epMaCiaC/CIrezFMDSQv
 BoSeSNETE6IRVTcxsAhHDlVIuitpaGeyP0Hbo/o/36aKXZLKgMhOnQ3b9TwSOxzHwddR
 ZgHF5bBERbY2Q+SpX71WCL8ep0pItsweb8CFnYnIm8iCOZJds0Bvr/CK7z7SyIUI1oG1
 U9cSxNJ8PmJpmfQwdJ/VhFVmjabQpLi9ErtLH3PifBpkTwtdEoiq3RiF1JH9oAKw3coO uA==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 384byp0pd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Apr 2021 19:05:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13OJ05TJ032564;
	Sat, 24 Apr 2021 19:05:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
	by aserp3030.oracle.com with ESMTP id 3849cafpdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Apr 2021 19:05:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5YRMRuxJuOqsJHnezHe6ka54BEtzKY+92p/Hy7t3cIGt8v+0YVDC9l5U3/zCVcmg+adLrX1Zvw4rky1sC022tWHqcZaXYrm1qdHgzVqy6f4wqIRGij2B3NTqwawYZv0rIUgzvmTA1DLML3N+hv8ha7/VNEv8E7eDtLNj21Xb6chn7nXEqyJ+gmon9GAAlLKJelEU7fL7me7PfYcOiLwRvwVKH8WZFBVRXUltTMpTEflG4ed3qbmPrpJFEiAT8hMe5VEfklBEPmY7djmaMnRPeRmZSbYXcIEAePzFoq/AD8ZHQDvm8hX269RuF+dqbztEOVKklYHMoN5okNATJv5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nKr4Ufk+xeUs6pTH+TN9u869KzU0eVkZFJaQJf3q/s=;
 b=oU67KIo40jNo9LRitAkRmHclDWuaAeMTUZL1AvB+lYRN8Hv39AXg8nv3C1/Xd9L9sKWT9wxjoBBwU1m6obdsW8vEuO9sp5vlaBSExXqEieG41EXfNW6c0zhiuf0SEzsxTlUTc64BVPa0Ey0QkdNb80Q8Y2y3MAioOtMIGUn0Le/QH4oig+l/26YtlLE21FXoLcgabJ0a/o1az7rWCZPf/PmU1xxeTtRE5+uWeDUutmTJxbTaKgMdfIpKzuOYqTXmiPCwJubcize/UBPg0OlRphfER/knv53lYXiqPpvnEEtVHkpcX2szTTtVobDQOQHgtl10yPccxhfg/lLQi6gAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nKr4Ufk+xeUs6pTH+TN9u869KzU0eVkZFJaQJf3q/s=;
 b=jcVJlvIT86hTME18tDjPXChgg5LDVKzFfXMX6R6pCPDfBHuVmbSGa4XHE2VQ6+vDpi0sUfYCt5ePH14yBHoNNe5KjaPfQABZgOkymYlgkzyBk2eXaV5ytm8K//G1SgpDTkn7h0VpmnF0UkQvlKSJAgIFxe29AK9Y+ymCcpLne5E=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB3875.namprd10.prod.outlook.com (2603:10b6:a03:1f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Sat, 24 Apr
 2021 19:05:32 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.4042.026; Sat, 24 Apr 2021
 19:05:32 +0000
Subject: Re: [PATCH v1 02/11] mm/page_alloc: split prep_compound_page into
 head and tail subparts
To: Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-3-joao.m.martins@oracle.com>
 <CAPcyv4jrdrKXhnoWKPRUE+McjP_7BOrG8GYBoeGP1s9-aF5FxQ@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <758d8eb0-3b39-49fe-a46f-6f62a09c2a87@oracle.com>
Date: Sat, 24 Apr 2021 20:05:22 +0100
In-Reply-To: <CAPcyv4jrdrKXhnoWKPRUE+McjP_7BOrG8GYBoeGP1s9-aF5FxQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.63.165.137]
X-ClientProxiedBy: LO2P265CA0491.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::16) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.85] (94.63.165.137) by LO2P265CA0491.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Sat, 24 Apr 2021 19:05:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5c7f15a-7f77-4d3a-93aa-08d90753ef04
X-MS-TrafficTypeDiagnostic: BY5PR10MB3875:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB38750181446C4350E00B95CFBB449@BY5PR10MB3875.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YYcpAdeaTq/WoOMvXMxRytyRJ6aNn6Lw2zV43jWcol4gSP01MXGIyVGiY+CGfszDi3NZbHZqTwDrnxGu+3nMQ/W1Bi8Zq/cNoEbW3EOCah9iP7hH8CfYAi/HZZCK8R9TX6neKO6eg14Qq6889JqPVtyRx2+3oyGlgus2gOP10hIdhDW7jFPgZD4rN13NP5VJNGvDPxpcYdiI6Wwvm6QDwITQbwMqN1ICSme2s/hCrAxfRTQDaVuACJBqbAOMj1QjBO/RDz5YlxnfEUdNmgYWPbwHTu18cPE7XXQAniEBANqfWuEBkqES/29xEbfRn5tFphpymu8ufGebQRJJk1ugLM7IqSNx26GYNri/KDnVuccO82IbmREuWe71Rt7zOAenNcpRRiHSojL0Qab2Zf3nZf98gO4TUft/Xf9bq41i+9izp/7xJt3tZdWkYb630S9GG8vzWJltTP7EG2HCYslOad8DkS8/5gBkiGDQiExZwPTc9pOGAB196qOClLLYMEcPv0x+efqB/LIl6luCjs3Z7H/eNENmHCqMNzMTj0Hjy6ZUwBslyKbjixPP3MM8nf8QW0BEH2stWqzHiV4oZ40V7wB29ql0zK1DYNSdmHT1oD95H1H1SLLnF7ol2L5T17OmCm/1rRmlF6AgkIq+XYA3RoXXSxIK1gXO8I9fhh8OAEw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(346002)(136003)(39860400002)(956004)(38100700002)(2616005)(6486002)(31696002)(31686004)(6916009)(5660300002)(2906002)(8676002)(8936002)(86362001)(478600001)(16576012)(26005)(36756003)(186003)(16526019)(54906003)(66556008)(66476007)(4326008)(66946007)(83380400001)(316002)(6666004)(53546011)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?WFdIczI5VTFnZEppSXdUcE93Y0hwQUp3cU5ZZHVRbUk5amtXa1Vkd3BkYXBW?=
 =?utf-8?B?TVNUaCs1a3RsYUptbkdwMXNtS0p3bDBWbG9QOFo5VmRLYWtTYTh2OW9YQmEy?=
 =?utf-8?B?eW93cHpiUHdkckhjcThMMGU2QklvRlpEZkd0b3BWYm5tb0xKWktSZGVITzZ1?=
 =?utf-8?B?bW5jRU45cDh5N3RqWTJZS252alpkS1RMSDRyK2dxZzFNeFNXUnJtT0djVmdH?=
 =?utf-8?B?OXlkbFQydndmL2Flams5b202U1d4aU8vek5OQjhaQm9RREtOc3VVQlJPazYv?=
 =?utf-8?B?ejlBZlBHRGVpRnZ1L0QrYTN2OG5vanJpWlhkcjVmQ2E3UndJKzc5aWFEVjRv?=
 =?utf-8?B?ZEk0YU1uWW5FQ1psUHNuMVI5MHhYQ3FPWkY3UzlYdkI3QUYzOTdzTm5uREdn?=
 =?utf-8?B?R3hjcHVpazFoQ2NBTWtIYWNYdi9CUUxoUUJYNHpLUncwU0FpWnMrOGFzdEVT?=
 =?utf-8?B?eVBtclFaaEo4aG55YTVjUFBIMFYvdkVyRmdwVzNCcSsxZWd6RWpWeVMwc1ZQ?=
 =?utf-8?B?U1A4ekhHMXNEMnN4dDRXc0MvSHhmREdlK0phRnBZQzRBK2FoNVZZWEM3djdT?=
 =?utf-8?B?bkJjVzlBMk1Cekc5RTMzZlRVWFBQeTdiaEdXOERTQ1lPdGRWTHZpSUZsZG5V?=
 =?utf-8?B?bnBGdFAwMjZTVkRLRklNaUhLK0tlZkt3aGxnY09JOVJsSEJCL2s0Qlh4cjhH?=
 =?utf-8?B?V1h2d2pDbHQyZ0sxUU00TlpiSkJFTkxwVGd4YTZWRWM2RjhYZHJQUkx1TkJj?=
 =?utf-8?B?T1FpVWxlbkVlU0FnM1JucGRFMUI5NlFValR2dFRjcFZwZjVoa0hRZkd1MzFx?=
 =?utf-8?B?RjZLb25WenJUb0hrWTVXdXNCaU5DeXJIemVsSTBoQTBrdlNPeVNrNDRBc0dw?=
 =?utf-8?B?TzBVa0x1RGtvS29xa2lZL2x2b20rdHJaem0xSTFsT1pBWXBJZXorYWcyREgv?=
 =?utf-8?B?OXlTVkZMZXBjcGZzVmVYQkFmZFozODY4RzMwV2lTRDB5RzBPb2pIcVVaVlF0?=
 =?utf-8?B?bUhSUXFiSFN6dXoxell0YytGa3JrZlUybUdPLzBEQmRIbS9UWHE2bjVkSmVl?=
 =?utf-8?B?b00rd3RhNTFtcHVQeEIwM2tUa0o0WEo4aWJudGd2bGlEMmx2SVVld0FiTEVo?=
 =?utf-8?B?TFRDVFJXVGRrRk11N0ZvVXZ3aEF6WUcvQ0tsalJSaFBCWDZIbVBobmZtZkhk?=
 =?utf-8?B?SzJSSlhhNVdHbkdMdmQyQTlyR3hmbXhNaFU2U0NKelZuVDRUL1drQ2pNTmYr?=
 =?utf-8?B?Q1pacStzMU1LTW9QRC9oSU5PMzZid05BUVZIRDV2dWdHRDFZYnVPQ3FmOWN6?=
 =?utf-8?B?SEZNSWFOeUFPaEplbm5nckswdzAxWTZrTVFVZVliODI2L01OUUJxM083b1dY?=
 =?utf-8?B?Um82QWxhZTdXNXVqNmJOSytmdEsyYzRGZStoTzBESUg1UGd0YWlQUUl4U01F?=
 =?utf-8?B?NW9TSmNkejRVbVc0Rm9EVWVwVFJJbDBubVNPUVRDUExvaWZSdjlpNnJ4dW5N?=
 =?utf-8?B?cENZUU9vWFZVKzNVR3ROeWFld0FOenQvQVQrd1Bkb0tCeGk4Q2g4TWJ0UTZa?=
 =?utf-8?B?aTd4ZVQzcjFwY2cwYVhNaFJNcTQvcmlpbEFOYTZYSzJKRTQwSzNTQXFhdDdV?=
 =?utf-8?B?WVhZcHR0SEM5U1lkR3ZiUUg0UWhvWEdzckU2V2JNUEpaTmdEbnpzRW8vbnpT?=
 =?utf-8?B?Tm8wZ2JDNDhTakNCbTB0N1FOalg1ZllkOXk3bGVrR1MrREl3T2hwbThvS2lN?=
 =?utf-8?Q?5AETi4rx1oQ3V661AoLKL13v0ZFqFIM7amPXIgg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c7f15a-7f77-4d3a-93aa-08d90753ef04
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2021 19:05:32.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TF643a1+QSq9mpETANSOtbvEDCYziK831PUVPSe6ceTkFxYa7idvLI+FfHqeOMfgSKr1lTknCAd0wxE94WtAfDFCEyBPVcIq8fhcHEyU3ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3875
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9964 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104240143
X-Proofpoint-ORIG-GUID: 2XKbazEyCK1eWBLo7tp0tjYNeAt0ep1w
X-Proofpoint-GUID: 2XKbazEyCK1eWBLo7tp0tjYNeAt0ep1w
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9964 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104240143
Message-ID-Hash: U4POO6LTZWEZLGEEEWNTNDXQ4KG63LSW
X-Message-ID-Hash: U4POO6LTZWEZLGEEEWNTNDXQ4KG63LSW
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U4POO6LTZWEZLGEEEWNTNDXQ4KG63LSW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 4/24/21 1:16 AM, Dan Williams wrote:
> On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> Split the utility function prep_compound_page() into head and tail
>> counterparts, and use them accordingly.
> 
> To make this patch stand alone better lets add another sentence:
> 
> "This is in preparation for sharing the storage for / deduplicating
> compound page metadata."
> 
Yeap, I've fixed it up.

> Other than that, looks good to me.
> 
/me nods

>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  mm/page_alloc.c | 32 +++++++++++++++++++++-----------
>>  1 file changed, 21 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index c53fe4fa10bf..43dd98446b0b 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -692,24 +692,34 @@ void free_compound_page(struct page *page)
>>         __free_pages_ok(page, compound_order(page), FPI_NONE);
>>  }
>>
>> +static void prep_compound_head(struct page *page, unsigned int order)
>> +{
>> +       set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
>> +       set_compound_order(page, order);
>> +       atomic_set(compound_mapcount_ptr(page), -1);
>> +       if (hpage_pincount_available(page))
>> +               atomic_set(compound_pincount_ptr(page), 0);
>> +}
>> +
>> +static void prep_compound_tail(struct page *head, int tail_idx)
>> +{
>> +       struct page *p = head + tail_idx;
>> +
>> +       set_page_count(p, 0);
>> +       p->mapping = TAIL_MAPPING;
>> +       set_compound_head(p, head);
>> +}
>> +
>>  void prep_compound_page(struct page *page, unsigned int order)
>>  {
>>         int i;
>>         int nr_pages = 1 << order;
>>
>>         __SetPageHead(page);
>> -       for (i = 1; i < nr_pages; i++) {
>> -               struct page *p = page + i;
>> -               set_page_count(p, 0);
>> -               p->mapping = TAIL_MAPPING;
>> -               set_compound_head(p, page);
>> -       }
>> +       for (i = 1; i < nr_pages; i++)
>> +               prep_compound_tail(page, i);
>>
>> -       set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
>> -       set_compound_order(page, order);
>> -       atomic_set(compound_mapcount_ptr(page), -1);
>> -       if (hpage_pincount_available(page))
>> -               atomic_set(compound_pincount_ptr(page), 0);
>> +       prep_compound_head(page, order);
>>  }
>>
>>  #ifdef CONFIG_DEBUG_PAGEALLOC
>> --
>> 2.17.1
>>
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
