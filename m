Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A009435127A
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Apr 2021 11:38:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E2DB7100F225A;
	Thu,  1 Apr 2021 02:38:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D34E7100F2257
	for <linux-nvdimm@lists.01.org>; Thu,  1 Apr 2021 02:38:52 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1319O0rP180055;
	Thu, 1 Apr 2021 09:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lAiNRusdnNB5lzKYgehVZ9jhX0/5oAv9OVSs0oicKg0=;
 b=ubmh55AqpiIijxZadVI8cp2MEkqsqilXBy+Ej1KDTYcDAGaFZWyL3+lkD2kCp4Yt+Pwq
 nI5ow2wa7TnRDYiRgcz/1kKYfULf6o+r+gIvsrt8INZaqwuX3kMUCpFQO4sQivBKlzRY
 jEtVH5CqZuBc0rTZNmVrblgsOEROjgWLTv6sO5NQUbcy5GlqrrVxNWnX3jizS+cBfwpo
 cfZMe/RG3WE+I5fkcbwL1vRNS9e1ZTF2tJgC7rTKAmO71S6/R2adrfBB4M85sdzfebAO
 sw+PqDzvT8qBCuvRkBlCgtLKVdgVVkAUYsbtXMRWp1dfgERth2zD326OFPPEYXN8Spqq xw==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2120.oracle.com with ESMTP id 37n2akh6vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Apr 2021 09:38:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1319Oto4048617;
	Thu, 1 Apr 2021 09:38:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
	by aserp3020.oracle.com with ESMTP id 37n2ab0pq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Apr 2021 09:38:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRET/oHq+hEqTSHI0nLAHHnHDhV91fq4XDsnJdl+41tc3X6vh4JVlpJg4JGSmpfGzDK4p/9XhwwebNgO+xSNQ8KkXMCv05duZTvUjYtccO4Z1k19/dC/6oER2Pe1i5ztDj2osZhEDx6MOyxD2j0eqxwb1O/oGzA56Mu6s8un6VITHEUVKI0ye1hAeqLdO+S/nfXUv+/GICgq5amnrmeG9otJUd6j2qNA0tkyIOCaNL2lJEp/E1ytFxgIfZe+hCCN8GJZkVzf2zv90g4NqXU5mlA3giXFwqbOWMGDkBKGe8e0/4GXWLlv8vpmwHzIJm4ZLZfrWGte5ueYjuN2nhjdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAiNRusdnNB5lzKYgehVZ9jhX0/5oAv9OVSs0oicKg0=;
 b=S3FBWgmNQEz8OHAt6YMFZb2QsAYzwHONt1qOyYfX/8Qs1fBC5LbDTYxWwBKE+P+Oc3m59ey4+c6+h2XjZBRfpWlEbHqJIAWbgRpVwUqviKG9yXvXnWN9hii/BfgeXqu+wzzPphlqANxeVIc2HpsujDSBszQMSgOQ1AjL4sJc2mFIxKADOCUhUDHSjuMhsfZ+zwmTWPzN9uRKewyAUg+u+hjtwoMjKqOajEypiJThpkB29QrwDaKiIHNHzjVeM/BvWHTwcPnZa+vRb9qwtDIwj9PNk4rm9hP8WC+xSMRqN5HIKQzT1Ft2eKNh2DLVhFNy7CVZxSaMyJajcqVbIXyLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAiNRusdnNB5lzKYgehVZ9jhX0/5oAv9OVSs0oicKg0=;
 b=K2qOddZCFZFdAyrd2bwKtRDCq5axqU0rnd0TrBFmEXZIy2rGpOErtJGABSNduWQ5rhUih+5bzoDG4jyHo77NOks5MV+5/1RSxduK5lPTwhG9kLg2mYiaSWcdo4YHNTV60SC5uYOMiIs+Jwq6MtCwY7TcP+Epv2o4b3hg4vGncOk=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB4355.namprd10.prod.outlook.com (2603:10b6:a03:20a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 1 Apr
 2021 09:38:12 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.3999.026; Thu, 1 Apr 2021
 09:38:12 +0000
Subject: Re: [PATCH v1 00/11] mm, sparse-vmemmap: Introduce compound pagemaps
To: linux-mm@kvack.org
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <a2b7dc3a-3f1d-b8e1-4770-e261055f2b17@oracle.com>
Date: Thu, 1 Apr 2021 10:38:04 +0100
In-Reply-To: <20210325230938.30752-1-joao.m.martins@oracle.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0115.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::12) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0115.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:192::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31 via Frontend Transport; Thu, 1 Apr 2021 09:38:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6599921b-77de-4507-fcd9-08d8f4f1dde9
X-MS-TrafficTypeDiagnostic: BY5PR10MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB435522A45E8588F908348889BB7B9@BY5PR10MB4355.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S8TaQztkaa+/rUn92asiEHp0MQ+6R+MidC8liTnME8LQwc2N/jhCbeOuaLytq/uJXJPdVUQOYGUNsnMCJot+8VzkJBk+7beOsnaf+oekZms2C4y9vubrDEkr7fJzF8WqcBRtno9KBab7OTES5lWMjuY/GW0UllBQKyff8tteDLqzJ1iOYVAqddjGG1hYUP4aHOh0qWDgOvGXqBncy+vgTfkKRJnrzIXGoS0w2slA5z7Db0/Xfbu+Pjv5SL58864thEyKrIFpwT+jsp8SEK7t7eZRkXotBPueRTVqtwgJIrKtiLF/EwoXJxwzHki4oaUsUdbPo2QMzA/c4oS/5jz2nyas0AUlY9NNoBTCwTT1+N0dk2WeOSsoaTlVz99/4AAHmuQFByvYgRqANZRzz7BE9XJYLFPGirB1BzIjmdqBPu61hYFOayhGd1A8cztvXwzNuGkJOp8B7qX1MMxpRAztLZPWT3fBPv17oRYjOL63GptfB9cOgYJL9kTuWxe8ybB30nsuT8txQ/B+732BYV1JRQ0ymQ4wn5xqkTNuxpMtdfF8YOCagOPHesOtP8Y8Dz9CtAbDAKQnTQWPkB6+n3flcuHRQL+wMXG/WWMNnRNKueVMN/431NfXKRzTBdffbXRMc0wFz4z4qJClHuYKwJizGhf6KFupHVJ4x5EqpH3TLlhYC70cAWLexBBDGcaBD4HL4aBlA2lVPzw7NKU1GaZneWEn218wcErcKYnq9EkWUIXO/WEKvbspUptbsErZK5XBKeA+8zSWEtE0qvwN0nk1Tg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39860400002)(346002)(396003)(316002)(6666004)(186003)(5660300002)(16576012)(66556008)(66476007)(36756003)(54906003)(53546011)(6486002)(956004)(16526019)(26005)(2616005)(31686004)(66946007)(31696002)(8676002)(6916009)(86362001)(83380400001)(38100700001)(2906002)(4326008)(8936002)(478600001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?UDlwb1hRWURoaWcxVklNcXlOU2VDdkFLVUJUTzZNYXhmallIU2lLZ3piTWww?=
 =?utf-8?B?L0RCTUZBOHZHbjJEblpuaE9GeTF2TWczYVBPdTFPbmVrdTBhUnY4WjgxbkN5?=
 =?utf-8?B?MExXQi9tUnkwSnFBNmM4L1ZuaXBpK2pYNE1ZUVVGMnpTbUxFaU1xSTBoelVU?=
 =?utf-8?B?cDZHUFVYdGdldDJGSkVha0lNcGpUSHVVczF5R3JFYmRIaDE3ZVdhU0piUXln?=
 =?utf-8?B?VzdKaWJYRW80eXJmL0VzME9rc0NmdHNEOFVSNWpDbjJyMFZkam5ZQUZuSWtQ?=
 =?utf-8?B?RGJnTkpCeXdWamVobHMxNWMrSzBpQXF0ci9FWW5IbHVmQm5hL0pub3NSNzZa?=
 =?utf-8?B?TDc2bHh6NzRKa1RPWlhGUE1JMjVRTUxsRk5ObXN3MjlWZG5qU0VWSnJockxk?=
 =?utf-8?B?MmtxQ3FVRHBmQWNYS1h4VlNSZEYyTU5kRGt6TWpNOVM4SDJIVytIVFI2dUlT?=
 =?utf-8?B?dTY1c3dBUEhsUWc4WmZVL3IrcTZqWEdhT1VmazdUcTVzR001TE9VUlZUSjhU?=
 =?utf-8?B?N0YwOVlXejRYbWRsWnUyVGxrS1pPMzFPeW92TWl5Zk1Rb3V5bWxLb0dTUmYx?=
 =?utf-8?B?ckljSG51YmI1UkdFWEFkRStzRW9EM1FuR1VkZDUvaEk5K0wrdUZtZXRpTFhH?=
 =?utf-8?B?Yzk4TUhpNkZnanFiQnBlVEprZnBQUTBjeGM2enR6NUNycERVTXpMNHJJOVV4?=
 =?utf-8?B?bE5WRitrenB0d3ljdUFnVzZoTjg5a0EraE1QTDR5RG9KVTBLNXBjWm45K2Fw?=
 =?utf-8?B?UER6Q1JiYUFCaUlqSzdyUzE5dGU2VjZpcVZPVWNsaTc4MEdlSlhaSGRicFBl?=
 =?utf-8?B?eVRnR0ZFdWhYRFEzL0NleDNPNnpQSW9NR2lJeTRQYnJUQm03YnFnbVNrcGth?=
 =?utf-8?B?YWZLSC9CMjRHWDAvY3QwcWZoQlMyb0VjQVVhQVJ6cDlVZVZIdmEvcm1mQ3R6?=
 =?utf-8?B?WXkwaHBIa2tNVCtBa1Q4OHFaYTR6ZFFrQjhsMVJWNFJ5YU0yaVhEUzJ6bjd0?=
 =?utf-8?B?WDNvK3pTRU5MZnRLeVBaWUJ4akw1SHl3SVprY3B6cWZSU3Z4NkxydzgzSXdP?=
 =?utf-8?B?ZVltMWpNenk3WVJOYlVmWW9JV2NKK1JxUjZ5OXMyTG1zM0FSRFBzYU1HNTE1?=
 =?utf-8?B?cy91SHI3WjBEMy9Pc1ZuSHkzL1g5eTBYL1gwUGhTbFFlT2VDZ0lPTDhnVjkr?=
 =?utf-8?B?TnhtbVJhMHRJTitaKzJiWG5CZmZYclVDcHRkU1JBZXlRRGxjQ0c2R1pwKytq?=
 =?utf-8?B?SnpjS0FEb09BY1BlNzdnZGl2d1hYK1ZSOXFIWVQzQlhMSVpXTE91WTcxM3p1?=
 =?utf-8?B?eDBSSHBuQUdQNTFJRW5VbDR6UmxCdkRnZUNxZkpPQmNiTlRHM2dDUDBTVENn?=
 =?utf-8?B?c0FPeXBKWDlnOGpBT29xOHNFM085TmljS1YwdVBKdGVGaGp5WjNsWU9HT0hG?=
 =?utf-8?B?YXl4YmVmMVV3MXFkdDU1NFJjSnk4citYQk81a3hEdUh6dFdIdVhMY3JZNDVM?=
 =?utf-8?B?TlRRL2JYRUo1VTQrRVhneU9KMm9WNjNYVUUzakthc1doY3Q3bkJxNVNHZndo?=
 =?utf-8?B?V3BUcEZaM2dFUHhNT3lUUXNQV1JyNjQwM0EzK1BRcWo2aFFLU3oxUzIybW1X?=
 =?utf-8?B?dnliVGtYejhqcE5OSUROK0taby9rdXJxVkVkMnZvNmRtUk5LaTd0SjNpbTBC?=
 =?utf-8?B?NkpyOGhDR2NlYmNYVXRBNllkbXc4MllLZWtOMWZoQzZrZmtDa0pRQnZGSU5C?=
 =?utf-8?Q?1DNoe1O1OhkYbvD3MIq5qIsSYIhNfn8uUlKBrlh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6599921b-77de-4507-fcd9-08d8f4f1dde9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 09:38:12.1999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5j2mUUcHsg9hLU3Ybs2jPaV6amu8j6WmmosC01euzX48gBgp6Uo7IB2/HlMTImLwsXRMmM/luqFSDL+ZpJNfV7GcTcVcAxMBPgsbvJePg7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4355
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010066
X-Proofpoint-ORIG-GUID: TSjTtvrHyGvoaR7gxNvE2ItuYwr-Cugh
X-Proofpoint-GUID: TSjTtvrHyGvoaR7gxNvE2ItuYwr-Cugh
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010066
Message-ID-Hash: YAFHLC2ZE5UJY6RR56FGLZB7ML3E472B
X-Message-ID-Hash: YAFHLC2ZE5UJY6RR56FGLZB7ML3E472B
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YAFHLC2ZE5UJY6RR56FGLZB7ML3E472B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/25/21 11:09 PM, Joao Martins wrote:

[...]

> Patch 11: Optimize grabbing page refcount changes given that we
> are working with compound pages i.e. we do 1 increment to the head
> page for a given set of N subpages compared as opposed to N individual writes.
> {get,pin}_user_pages_fast() for zone_device with compound pagemap consequently
> improves considerably with DRAM stored struct pages. It also *greatly*
> improves pinning with altmap. Results with gup_test:
> 
>                                                    before     after
>     (16G get_user_pages_fast 2M page size)         ~59 ms -> ~6.1 ms
>     (16G pin_user_pages_fast 2M page size)         ~87 ms -> ~6.2 ms
>     (16G get_user_pages_fast altmap 2M page size) ~494 ms -> ~9 ms
>     (16G pin_user_pages_fast altmap 2M page size) ~494 ms -> ~10 ms
> 
>     altmap performance gets specially interesting when pinning a pmem dimm:
> 
>                                                    before     after
>     (128G get_user_pages_fast 2M page size)         ~492 ms -> ~49 ms
>     (128G pin_user_pages_fast 2M page size)         ~493 ms -> ~50 ms
>     (128G get_user_pages_fast altmap 2M page size)  ~3.91 ms -> ~70 ms
>     (128G pin_user_pages_fast altmap 2M page size)  ~3.97 ms -> ~74 ms
> 

Quick correction: These last two 3.91 and 3.97 on the left column are in *seconds* not
milliseconds. By mistake I added an extra 'm'. Sorry about that.

> The unpinning improvement patches are in mmotm/linux-next so removed from this
> series.
> 
> I have deferred the __get_user_pages() patch to outside this series
> (https://lore.kernel.org/linux-mm/20201208172901.17384-11-joao.m.martins@oracle.com/),
> as I found an simpler way to address it and that is also applicable to
> THP. But will submit that as a follow up of this.
> 
> Patches apply on top of linux-next tag next-20210325 (commit b4f20b70784a).
> 
> Comments and suggestions very much appreciated!
> 
> Changelog,
> 
>  RFC -> v1:
>  (New patches 1-3, 5-8 but the diffstat is that different)
>  * Fix hwpoisoning of devmap pages reported by Jane (Patch 1 is new in v1)
>  * Fix/Massage commit messages to be more clear and remove the 'we' occurences (Dan, John, Matthew)

I just noticed that I haven't fully removed the 'we' occurrences. Patches 7 and 8 had
their commit messages rewritten and I mistakenly re-introduced remnants of 'we'. I will
have it fixed for (v2) albeit I'll still wait for comments on this series before following up.

>  * Use pfn_align to be clear it's nr of pages for @align value (John, Dan)
>  * Add two helpers pgmap_align() and pgmap_pfn_align() as accessors of pgmap->align;
>  * Remove the gup_device_compound_huge special path and have the same code
>    work both ways while special casing when devmap page is compound (Jason, John)
>  * Avoid usage of vmemmap_populate_basepages() and introduce a first class
>    loop that doesn't care about passing an altmap for memmap reuse. (Dan)
>  * Completely rework the vmemmap_populate_compound() to avoid the sparse_add_section
>    hack into passing block across sparse_add_section calls. It's a lot easier to
>    follow and more explicit in what it does.
>  * Replace the vmemmap refactoring with adding a @pgmap argument and moving
>    parts of the vmemmap_populate_base_pages(). (Patch 5 and 6 are new as a result)
>  * Add PMD tail page vmemmap area reuse for 1GB pages. (Patch 8 is new)
>  * Improve memmap_init_zone_device() to initialize compound pages when
>    struct pages are cache warm. That lead to a even further speed up further
>    from RFC series from 190ms -> 80-120ms. Patches 2 and 3 are the new ones
>    as a result (Dan)
>  * Remove PGMAP_COMPOUND and use @align as the property to detect whether
>    or not to reuse vmemmap areas (Dan)
> 
> Thanks,
> 	Joao
> 
> Joao Martins (11):
>   memory-failure: fetch compound_head after pgmap_pfn_valid()
>   mm/page_alloc: split prep_compound_page into head and tail subparts
>   mm/page_alloc: refactor memmap_init_zone_device() page init
>   mm/memremap: add ZONE_DEVICE support for compound pages
>   mm/sparse-vmemmap: add a pgmap argument to section activation
>   mm/sparse-vmemmap: refactor vmemmap_populate_basepages()
>   mm/sparse-vmemmap: populate compound pagemaps
>   mm/sparse-vmemmap: use hugepages for PUD compound pagemaps
>   mm/page_alloc: reuse tail struct pages for compound pagemaps
>   device-dax: compound pagemap support
>   mm/gup: grab head page refcount once for group of subpages
> 
>  drivers/dax/device.c           |  58 +++++++--
>  include/linux/memory_hotplug.h |   5 +-
>  include/linux/memremap.h       |  13 ++
>  include/linux/mm.h             |   8 +-
>  mm/gup.c                       |  52 +++++---
>  mm/memory-failure.c            |   2 +
>  mm/memory_hotplug.c            |   3 +-
>  mm/memremap.c                  |   9 +-
>  mm/page_alloc.c                | 126 +++++++++++++------
>  mm/sparse-vmemmap.c            | 221 +++++++++++++++++++++++++++++----
>  mm/sparse.c                    |  24 ++--
>  11 files changed, 406 insertions(+), 115 deletions(-)
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
