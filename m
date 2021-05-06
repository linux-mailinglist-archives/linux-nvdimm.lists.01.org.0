Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6497F3752C0
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 13:02:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D1169100EB348;
	Thu,  6 May 2021 04:02:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B8F94100EB328
	for <linux-nvdimm@lists.01.org>; Thu,  6 May 2021 04:02:10 -0700 (PDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146AxYrf095049;
	Thu, 6 May 2021 11:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=G1P5SRN0hIG09piN4NEY8DgvVI9Pt90FgRA6h1waatI=;
 b=N3oKu4AX+1f+wO8FIVczHHYOOAyj8cMZeBkVPb7PzVs4YDy7+N22GZHWfh3yGeVfM3dT
 GdB0+MuWc7gtMjmsGGub6ls5s1Zw3Q8YGzA+2NhpZgUH3H0tiSu+pnFK6vLBLLlEyjcB
 RVIW+eLFYfI8DzMqz5rSRbnIGhjP4+fU0Y/q08I0NgKaO2P6vzKbVmONjiumzeqKa+pE
 r3ddCiFXZfLhIAIt10U1nDY899cV8Bm39xIX97F8qLT6LSyCvMurlZv8UQaLW4zD1J2J
 2PYQ758G6ZtfX5LlgoVRiS8GxparhPDKca5G3cg+IHncVtDHF+wIuEsXAnOpWRDNb4xg ZA==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 38begjcje7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 11:02:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146B1dhB189537;
	Thu, 6 May 2021 11:01:59 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2051.outbound.protection.outlook.com [104.47.38.51])
	by userp3020.oracle.com with ESMTP id 38bfutd6av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 11:01:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPg3QS7/47MMieKfGPn+oX7ATsxy0oyrCxuZqURUpmYkD+N+JiDPuZqPCgP5U0WwuBCorLhKeCotmRba53rTTyLgRUpuiie+KxpLKjsQON9tgPPUQj2SPv8Vq23940V+5+KOqCqu1taFs2lascyGsZFl4xlvZ4v3Am2pnv+uFFUia/quU9aYixl4lbv30Rt3JeV1p/hcfBxYL04FhCeT2bl2eNWECdaQDMirpFauGsJUHagjOc5y+v4NE6fnroDK7FwHnpicbnXRJ+XOctx2gvAKCCPxJIfT70HJZtkCLd3B6dewwi7r0b6fz+UNYubFlR4MKYtSNiZZzWL1GWqwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1P5SRN0hIG09piN4NEY8DgvVI9Pt90FgRA6h1waatI=;
 b=DIuR78koUrygWkvyuFA++36IMIOj4De7gag0RUl04edpi38Ky2zipXx7mFu5h79A4VYjXT97DDmMwQD8cyL2nxhSJqS/RvnwaU5ZXXDZzsBWtb5qUMCJ7bUf2rup4+LR26pD+mCmBldt8gbbLBLQrdULdxukggGDmnRsXbQJcuXtI0YKqWddilfLg5eKcOVUgH1PYfbfQUIAI9hnM57yvOq7HSQcf57FQMbjUm2hTsroVxPOTrcwzprZqdjkn8o72QSwZdKnmst35oJnyLSi+y8wx2+kvfo4Rpye3tdsjCtazRc/4oCeiiliQDM/dnTeYms22gsHQuj6pLyXUfarAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1P5SRN0hIG09piN4NEY8DgvVI9Pt90FgRA6h1waatI=;
 b=v9S04sGyrxJLdEj0xvSb1jz9AKjSDGf0rFGduC9ITYok+xFbC4XaldItH9pwbuQoyuoBAnPgAV8GbZG4TeB+mCpUwlOUT1PDhXb1PI5zTnS2+t/dlcMJyU9CpK2+tV0ui8IIsiEgsRy/F4ExyYYSCtxXwSb7f31RhMaFE/BEBkE=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3352.namprd10.prod.outlook.com (2603:10b6:a03:159::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 11:01:55 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e%6]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 11:01:55 +0000
Subject: Re: [PATCH v1 07/11] mm/sparse-vmemmap: populate compound pagemaps
To: Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-8-joao.m.martins@oracle.com>
 <CAPcyv4hcMg6cJctnY6V=ngL9GoPVvd3sSYRbS-WZoTg=SnrhEw@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <63ce653d-4d21-c955-7b81-abba25b9e4b6@oracle.com>
Date: Thu, 6 May 2021 12:01:47 +0100
In-Reply-To: <CAPcyv4hcMg6cJctnY6V=ngL9GoPVvd3sSYRbS-WZoTg=SnrhEw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::15) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO2P265CA0051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 11:01:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e51dbe9-797d-436c-962a-08d9107e5c42
X-MS-TrafficTypeDiagnostic: BYAPR10MB3352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB33526EE07F504EE7354D34E0BB589@BYAPR10MB3352.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q3Peqzd4EQoGS9j5NQHTbL48ajgp5FfLJvh/4iV2bVoXrUmiSCRxm2tVl/+w/eEwaJHbKSvGiNwhKEjfc2fXSAQ7x8peLr/mEsADANbRx6cHQRI3Hc3cQryjcCk/da8UXIHkI1Gn0DEE4phaAkDJuKYrJZnK0xGcxi8qxw/fbtY+oIN57y4uZgWktSDcH3m7SjrmgAVJDLumpPiHBDWz7HB8rwl4YLWsd1Q+deawpRC+cFWgYVs7z8w09BPwtiV14oOr3Zr7Cim7BrRS0E7De47gDw5AYuj1+LL6/bOSQ5cDahrQ4m4GWFgQkd3lI4C5sLwyXg/ehSx63EODnTTladh9g+H+TLSXnhWOuIXs5yiqb0Ap5hwZnaYTdTdO6jAaYGLVd+L0Df1O2myuxYLxQbnfdDNockwM214OGGmq6/6Xyj2FtY1VvuVlbd0WeQVIyyktFWyo8PlRWpaYkYE4MUv8zpSp9A3XBGXSBqpGO2mPeL+KcWmDIYsqkfWUxVkCZpTLekNphGXR1xAKyHIJFyySn2/tU9OAdCotmmrsP/j1cEDn1VYI2LBk6Gc9Y8PWMOI5nRnPJHpZwfvwK/+l0r7BnrDYoyyeI7skcBPTiI+Yu42bK2Rzo+MAttC80wvGJ3ZFprBgA9bTgM6SwXutaRFudRhrvUdpG+h4LYkcUQhZU8TMk1+sqC4CYMN44jesGvL6FLtuSSBWi9QoGS4gLJVeUwAvFyRr8fAgl5MAshk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39860400002)(396003)(346002)(186003)(53546011)(16526019)(86362001)(30864003)(36756003)(66946007)(31696002)(66476007)(2616005)(66556008)(6486002)(26005)(966005)(4326008)(478600001)(8676002)(31686004)(83380400001)(38100700002)(5660300002)(16576012)(2906002)(316002)(8936002)(956004)(6916009)(6666004)(54906003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?bUQvS0dxUHBkZndBVENVeWljZmtYYWFoYU80TndXbmY3bzJ3d0wrUFRqd3JS?=
 =?utf-8?B?bGo4WWNjM1lVTnkxOVZHQWY4VkpYbHFFUmY5bm1YcHNwZnRmRXl5U0tKaEdy?=
 =?utf-8?B?Y2lFYkw5elB1MDZJVU9wQ3FFMnpXb2FjWU4vLzc2dXlGNUtXa3VmS2JYRTdM?=
 =?utf-8?B?bDdrSWJsTzRBakxYYnhFVitUQnZkYjlKOS9ZcjBaVzdkYlA0MmJ2Y1hxSDVX?=
 =?utf-8?B?cUdSTForL3cwQ0N2OTBvSGdLZTdEZXkzNmI4MVJxS0NSd2RpUjBhREEzRnc5?=
 =?utf-8?B?VGsrVFRrc1puNGtNUjNMWkhwL1ZXWHZsamVESm8xRVJUQWc1bUgxMWx0U0h3?=
 =?utf-8?B?dllFeTY3czJCTEpneFF6QjVxcm10VVZ2Nmg1ekk4ejFhNDV5YlVXd2Nsc21W?=
 =?utf-8?B?YytZVC9PTndDUjFjZnBMYU9XdW1xQzh3cXhqZStBekVLb3dENWxQYlRHTnM4?=
 =?utf-8?B?ZE1nREFlNzY3WW5mbkE0SkVLeUtKTmh3dWNTclJ2ajdvMzY5SWg3TGF1UVhv?=
 =?utf-8?B?dEh5NzltQmNvZEJLeFloVUh5bnNDWm5wZkFYYVBFRWIwYmZycTlwNEdZVWZu?=
 =?utf-8?B?OEJSY05mdkJLeTEzK0psdUVWM2lOZEJWQlNiZnp6cVdKVU9lNjFlUmErOTVk?=
 =?utf-8?B?ZXEwdy9BM1Y2bXV1bHV4akcxMk1rOWRZTUpsazVVWVdrSWtxK2d2S3pHRkhM?=
 =?utf-8?B?cnpiNE9kRzJxbEduUHFWSXFsVlh1THg4Z2tuZXJncjVvampDd3hCM3ArR3FY?=
 =?utf-8?B?S3YydzNnUnkvSGR6bHFWcEZqNTY4cVQ3SU5mblJQUy9uMUlGYThqQnF5OGVn?=
 =?utf-8?B?eElRaVNVZ0tSbm15ZlhvM2FjeUU2ZDRoWU1PcnNYL2JIUVBFd0N6THVIeGdN?=
 =?utf-8?B?dU5VcjFpT25keGVVSjZMQVRkbVlyNTQxUnpjYTlselVYZTdzcVpjeVh2RGtL?=
 =?utf-8?B?Q0ZlcEMzeDNack03RjhmQ0xoekkxUGEvbExTVmtqT281TExnaHVXbm1VYThm?=
 =?utf-8?B?cW1yeTlCVDJFVkQ4cHVYTmw3cERiUUd5SEM5N3R0UnNqOXIvY3YwMU5EbmZ3?=
 =?utf-8?B?ZjNOQzV2Y1ZlMlFIRlZ0OHhIQVltMENiR2ljd0VmMEd0YUpvVXVndW4zbWJi?=
 =?utf-8?B?TXhkdnN1K1JyM1N6Ym9xQmdOaTVpMndld1V1U2FBcVFuYmxDNHlRV2N2THdX?=
 =?utf-8?B?QUtiRmxtK1hnblZqS2RkbjR1aDcxQlhBSDFWODRyM2J0TitTUXZ3QTcxY0Vh?=
 =?utf-8?B?cCtpVmplaHl2YnZ4d1EwaXlnWTY0MFpQUXJTRlJYVFhjNlUzSXZZL3Rhd0xV?=
 =?utf-8?B?b2dieUJaZ2hKeHhuSGFKMHVrei9QdUdjZE9vcFNHd1poWEg0c3dydmNTZmFR?=
 =?utf-8?B?Qkt4ck9nZkhBc2hVOEpEem9KT3NLL3NzaFphRTBPeC9JQzNtVFFoVUhrMDJv?=
 =?utf-8?B?SzBScTdMRmtSdmZwS05MbDlyTWl1cGxWTFJORDlvMmlmM1JKd21MZzBGVGJI?=
 =?utf-8?B?UnNYeVE2dzdJdFpLRzZ5OWY0RkRpUU1sdlc1bXRzc010Nm4xZUdiTDlUalFJ?=
 =?utf-8?B?R2x6dHZUa1U0RjZPdzJnMkVYSGUvcEkwcmZ1cnF0RFN5U3ZmQjREb1ViL0JJ?=
 =?utf-8?B?UDhtb1d3eTUzVXhqRlovTklyUk9VVHJOSlJnWHphRG1DUkt0Zk9nL3lWMnNm?=
 =?utf-8?B?TGJIajh5UVVJc042ZUtEcFA2TUxxYkNCZENnNmxlNEdHWG9IdjkvSWxjbnMz?=
 =?utf-8?Q?xK4OlCMMEwxZQK3EMcsg+GMEXzHfiVZ/oLl2TxU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e51dbe9-797d-436c-962a-08d9107e5c42
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 11:01:55.1256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erXC0oFj/76Tw4rhJbmp+0rM+fzHC6uYIbvQdpM77lASg5gu4yQlmqSo+hhF4s0pzQl1hyYhl69kKOZcn/1Sg2VDQjZaTxePfmhkRUPX3TQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3352
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060075
X-Proofpoint-GUID: K2NcGHoShoc4NJgyUC1IUMeOLhytNKDu
X-Proofpoint-ORIG-GUID: K2NcGHoShoc4NJgyUC1IUMeOLhytNKDu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060075
Message-ID-Hash: K2TQZR7TGV33Q6ZPXITBM6PCT4JHCTFT
X-Message-ID-Hash: K2TQZR7TGV33Q6ZPXITBM6PCT4JHCTFT
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K2TQZR7TGV33Q6ZPXITBM6PCT4JHCTFT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/6/21 2:18 AM, Dan Williams wrote:
> On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> A compound pagemap is a dev_pagemap with @align > PAGE_SIZE and it
>> means that pages are mapped at a given huge page alignment and utilize
>> uses compound pages as opposed to order-0 pages.
>>
>> To minimize struct page overhead we take advantage of the fact that
> 
> I'm not sure if Andrew is a member of the "we" police, but I am on
> team "imperative tense".
> 
That was my mistake once again. You did mentioned it over the RFC.
A few days after submitting the series I noticed[0] this patch and the
next one had still a few instances of misplaced usage of 'we', in addition
to a little unit mistake I made over the cover-letter.

[0] https://lore.kernel.org/linux-mm/a2b7dc3a-3f1d-b8e1-4770-e261055f2b17@oracle.com/

> "Take advantage of the fact that most tail pages look the same (except
> the first two) to minimize struct page overhead."
> 
> ...I think all the other "we"s below can be dropped without losing any meaning.
> 
Indeed.

>> most tail pages look the same (except the first two). We allocate a
>> separate page for the vmemmap area which contains the head page and
>> separate for the next 64 pages. The rest of the subsections then reuse
>> this tail vmemmap page to initialize the rest of the tail pages.
>>
>> Sections are arch-dependent (e.g. on x86 it's 64M, 128M or 512M) and
>> when initializing compound pagemap with big enough @align (e.g. 1G
>> PUD) it  will cross various sections. To be able to reuse tail pages
>> across sections belonging to the same gigantic page we fetch the
>> @range being mapped (nr_ranges + 1).  If the section being mapped is
>> not offset 0 of the @align, then lookup the PFN of the struct page
>> address that preceeds it and use that to populate the entire
> 
> s/preceeds/precedes/
> 
/me nods

>> section.
>>
>> On compound pagemaps with 2M align, this lets mechanism saves 6 pages
> 
> s/lets mechanism saves 6 pages/this mechanism lets 6 pages be saved/
> 
Will fix.

>> out of the 8 necessary PFNs necessary to set the subsection's 512
>> struct pages being mapped. On a 1G compound pagemap it saves
>> 4094 pages.
>>
>> Altmap isn't supported yet, given various restrictions in altmap pfn
>> allocator, thus fallback to the already in use vmemmap_populate().
> 
> Perhaps also note that altmap for devmap mappings was there to relieve
> the pressure of inordinate amounts of memmap space to map terabytes of
> PMEM. With compound pages the motivation for altmaps for PMEM is
> reduced.
> 
OK, I suppose it's worth highlighting it.

But perhaps how 'reduced' this motivation is still not 100% clear to me.

Like we discussed over the RFC, the DEVMAP_PMD geometry we still take a
non-trivial hit of ~4G per Tb. And altmap is a rather quick way of having
heavily disproportioned RAM to PMEM ratios working without pay the RAM
penalty. Specially with the pinning numbers so heavily reduced.

>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  include/linux/mm.h  |   2 +-
>>  mm/memremap.c       |   1 +
>>  mm/sparse-vmemmap.c | 139 ++++++++++++++++++++++++++++++++++++++++----
>>  3 files changed, 131 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 61474602c2b1..49d717ae40ae 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3040,7 +3040,7 @@ p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
>>  pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
>>  pmd_t *vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node);
>>  pte_t *vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
>> -                           struct vmem_altmap *altmap);
>> +                           struct vmem_altmap *altmap, void *block);
>>  void *vmemmap_alloc_block(unsigned long size, int node);
>>  struct vmem_altmap;
>>  void *vmemmap_alloc_block_buf(unsigned long size, int node,
>> diff --git a/mm/memremap.c b/mm/memremap.c
>> index d160853670c4..2e6bc0b1ff00 100644
>> --- a/mm/memremap.c
>> +++ b/mm/memremap.c
>> @@ -345,6 +345,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>>  {
>>         struct mhp_params params = {
>>                 .altmap = pgmap_altmap(pgmap),
>> +               .pgmap = pgmap,
>>                 .pgprot = PAGE_KERNEL,
>>         };
>>         const int nr_range = pgmap->nr_range;
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 8814876edcfa..f57c5eada099 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -141,16 +141,20 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
>>  }
>>
>>  pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
>> -                                      struct vmem_altmap *altmap)
>> +                                      struct vmem_altmap *altmap, void *block)
> 
> For type-safety I would make this argument a 'struct page *' and drop
> the virt_to_page().
> 
Will do.

>>  {
>>         pte_t *pte = pte_offset_kernel(pmd, addr);
>>         if (pte_none(*pte)) {
>>                 pte_t entry;
>> -               void *p;
>> -
>> -               p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
>> -               if (!p)
>> -                       return NULL;
>> +               void *p = block;
>> +
>> +               if (!block) {
>> +                       p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
>> +                       if (!p)
>> +                               return NULL;
>> +               } else if (!altmap) {
>> +                       get_page(virt_to_page(block));
> 
> This is either super subtle, or there is a missing put_page(). I'm
> assuming that in the shutdown path the same page will be freed
> multiple times because the same page is mapped multiple times.
> 

It's the former (subtlety):

1) When a PTE/PMD entry is freed from the init_mm there's a a free_pages() call to
this page allocated above. free_pages() at the top does a put_page_testzero() prior to
freeing the actual page.

2) Given this codepath is solely used by pgmap infra, we already have the page allocator
is available (i.e. slab_is_available()), hence we will always go towards the
alloc_pages_node() codepath.

> Have you validated that the accounting is correct and all allocated
> pages get freed? I feel this needs more than a comment, it needs a
> test to validate that the accounting continues to happen correctly as
> future vmemmap changes land.
> 

I can add a comment *at least*.

I checked the accounting. But let me be extra pedantic on this part and recheck
this once again as I settled with this part some time ago. I will followup on this
chunk, should this part be broken in some way.

>> +               }
>>                 entry = pfn_pte(__pa(p) >> PAGE_SHIFT, PAGE_KERNEL);
>>                 set_pte_at(&init_mm, addr, pte, entry);
>>         }
>> @@ -217,7 +221,8 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
>>  }
>>
>>  static int __meminit vmemmap_populate_address(unsigned long addr, int node,
>> -                                             struct vmem_altmap *altmap)
>> +                                             struct vmem_altmap *altmap,
>> +                                             void *page, void **ptr)
>>  {
>>         pgd_t *pgd;
>>         p4d_t *p4d;
>> @@ -237,10 +242,14 @@ static int __meminit vmemmap_populate_address(unsigned long addr, int node,
>>         pmd = vmemmap_pmd_populate(pud, addr, node);
>>         if (!pmd)
>>                 return -ENOMEM;
>> -       pte = vmemmap_pte_populate(pmd, addr, node, altmap);
>> +       pte = vmemmap_pte_populate(pmd, addr, node, altmap, page);
>>         if (!pte)
>>                 return -ENOMEM;
>>         vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
>> +
>> +       if (ptr)
>> +               *ptr = __va(__pfn_to_phys(pte_pfn(*pte)));
>> +       return 0;
>>  }
>>
>>  int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
>> @@ -249,7 +258,110 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
>>         unsigned long addr = start;
>>
>>         for (; addr < end; addr += PAGE_SIZE) {
>> -               if (vmemmap_populate_address(addr, node, altmap))
>> +               if (vmemmap_populate_address(addr, node, altmap, NULL, NULL))
>> +                       return -ENOMEM;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int __meminit vmemmap_populate_range(unsigned long start,
>> +                                           unsigned long end,
>> +                                           int node, void *page)
>> +{
>> +       unsigned long addr = start;
>> +
>> +       for (; addr < end; addr += PAGE_SIZE) {
>> +               if (vmemmap_populate_address(addr, node, NULL, page, NULL))
>> +                       return -ENOMEM;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static inline int __meminit vmemmap_populate_page(unsigned long addr, int node,
>> +                                                 void **ptr)
>> +{
>> +       return vmemmap_populate_address(addr, node, NULL, NULL, ptr);
>> +}
>> +
>> +static pte_t * __meminit vmemmap_lookup_address(unsigned long addr)
> 
> I think this can be replaced with a call to follow_pte(&init_mm...).
> 

Ah, of course! That would shorten things up too.

>> +{
>> +       pgd_t *pgd;
>> +       p4d_t *p4d;
>> +       pud_t *pud;
>> +       pmd_t *pmd;
>> +       pte_t *pte;
>> +
>> +       pgd = pgd_offset_k(addr);
>> +       if (pgd_none(*pgd))
>> +               return NULL;
>> +
>> +       p4d = p4d_offset(pgd, addr);
>> +       if (p4d_none(*p4d))
>> +               return NULL;
>> +
>> +       pud = pud_offset(p4d, addr);
>> +       if (pud_none(*pud))
>> +               return NULL;
>> +
>> +       pmd = pmd_offset(pud, addr);
>> +       if (pmd_none(*pmd))
>> +               return NULL;
>> +
>> +       pte = pte_offset_kernel(pmd, addr);
>> +       if (pte_none(*pte))
>> +               return NULL;
>> +
>> +       return pte;
>> +}
>> +
>> +static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
>> +                                                    unsigned long start,
>> +                                                    unsigned long end, int node,
>> +                                                    struct dev_pagemap *pgmap)
>> +{
>> +       unsigned long offset, size, addr;
>> +
>> +       /*
>> +        * For compound pages bigger than section size (e.g. 1G) fill the rest
> 
> Oh, I had to read this a couple times because I thought the "e.g." was
> referring to section size. How about:
> 
> s/(e.g. 1G)/(e.g. x86 1G compound pages with 2M subsection size)/
> 
Will fix. But instead I'll fix to:

e.g. x86 1G compound pages with 128M section size

Because vmemmap_populate_compound_pages() is called per section, while being
subsection-aligned.

>> +        * of sections as tail pages.
>> +        *
>> +        * Note that memremap_pages() resets @nr_range value and will increment
>> +        * it after each range successful onlining. Thus the value or @nr_range
>> +        * at section memmap populate corresponds to the in-progress range
>> +        * being onlined that we care about.
>> +        */
>> +       offset = PFN_PHYS(start_pfn) - pgmap->ranges[pgmap->nr_range].start;
>> +       if (!IS_ALIGNED(offset, pgmap_align(pgmap)) &&
>> +           pgmap_align(pgmap) > SUBSECTION_SIZE) {
>> +               pte_t *ptep = vmemmap_lookup_address(start - PAGE_SIZE);
>> +
>> +               if (!ptep)
>> +                       return -ENOMEM;
> 
> Side note: I had been resistant to adding 'struct page' for altmap
> pages, but that would be a requirement to enable compound pages +
> altmap.
> 
Fair enough.

I was thinking about something a little simpler like adding a refcount to
altmap pfn allocator, to avoid arch changes and be a little more tidy
on space (16bytes rather than 64bytes). But I suspect I can avoid the said
arch changes even with a backend struct page.

>> +
> 
> Perhaps a comment here to the effect "recall the page that was
> allocated in a prior iteration and fill it in with tail pages".
> 
Will add.

>> +               return vmemmap_populate_range(start, end, node,
>> +                                             page_to_virt(pte_page(*ptep)));
> 
> If the @block parameter changes to a 'struct page *' it also saves
> some typing here.
> 
Indeed.

>> +       }
>> +
>> +       size = min(end - start, pgmap_pfn_align(pgmap) * sizeof(struct page));
>> +       for (addr = start; addr < end; addr += size) {
>> +               unsigned long next = addr, last = addr + size;
>> +               void *block;
>> +
>> +               /* Populate the head page vmemmap page */
>> +               if (vmemmap_populate_page(addr, node, NULL))
>> +                       return -ENOMEM;
>> +
>> +               /* Populate the tail pages vmemmap page */
>> +               block = NULL;
>> +               next = addr + PAGE_SIZE;
>> +               if (vmemmap_populate_page(next, node, &block))
>> +                       return -ENOMEM;
>> +
>> +               /* Reuse the previous page for the rest of tail pages */
>> +               next += PAGE_SIZE;
>> +               if (vmemmap_populate_range(next, last, node, block))
>>                         return -ENOMEM;
>>         }
>>
>> @@ -262,12 +374,19 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
>>  {
>>         unsigned long start = (unsigned long) pfn_to_page(pfn);
>>         unsigned long end = start + nr_pages * sizeof(struct page);
>> +       unsigned int align = pgmap_align(pgmap);
>> +       int r;
>>
>>         if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
>>                 !IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
>>                 return NULL;
>>
>> -       if (vmemmap_populate(start, end, nid, altmap))
>> +       if (align > PAGE_SIZE && !altmap)
> 
> I also think this code will read better the devmap_geometry enum.
> 
True.

I am starting to like the ring of it with @geometry rather than @align to represent
how metadata is used. Should avoid confusion between device-dax @align and pagemap
@align.

>> +               r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
>> +       else
>> +               r = vmemmap_populate(start, end, nid, altmap);
>> +
>> +       if (r < 0)
>>                 return NULL;
>>
>>         return pfn_to_page(pfn);
>> --
>> 2.17.1
>>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
