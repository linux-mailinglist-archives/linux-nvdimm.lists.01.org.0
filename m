Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDAD37FD5E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 May 2021 20:46:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 96B8F100EB353;
	Thu, 13 May 2021 11:46:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 34B85100EBB96
	for <linux-nvdimm@lists.01.org>; Thu, 13 May 2021 11:46:40 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DISnQT185340;
	Thu, 13 May 2021 18:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WQ5k6McrbLScSLFG+AdwUpXM0w1+eo+BI/bvEMOs/EA=;
 b=MyMN/VObnby9KO6JLJk4xseeIrVYeynb+apYRhN3W9LRCFunwo4cNNn8VamXjIRzQzY2
 KgvnjerFV+axgxR0WmbyDqvE97v0n/aZF3TKLOX29Gf3UgGZss3ogD/s1Yd4xwvdK/Dj
 A0X5vRyRzA5r4jlJpu3M8cc6hdkxUQ9v4aoujp5A5gOJNpN5d3FnEhRyAexV+OWf+k9z
 H75tgUvkx6jR0Do56+jQ4AEBteVsWxJs5E49PcSedCfEf5Ovb6LR4P7dMM4NhiggHcJD
 ecSsxIE/JZnrlEijEOXkS8DyTMEvLf3vtlRN1JDcx5UgvwKMYSOwyMM4UMZDzj21rD9m ZQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 38gpnujh9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 May 2021 18:45:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14DITuf8047056;
	Thu, 13 May 2021 18:45:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
	by aserp3030.oracle.com with ESMTP id 38gpppd3p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 May 2021 18:45:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wts/y8v5m9USpcHxweOLxTlQs9YWSywi1OPon/wE/2dJb2UcLWui/1MIXHI2h0Ru1opz0nn8k6Y9MX/WjayoD6khszAtQnhVhSEawQ6O+GNctDlbApm4Y6jrqAIioF/7WHtVfXF69CnQyFq39zQ30+ePHTjwbxSbfRkzuw6D29WdbLn81Z3s6N7D2QQoZ6NbGNYi0n3bSTnQTuFfVqTk4P44gwqBkj0tFM1P7WbXWvNexzFdukPiURIMnFAe2WJrTt0gISGlNq70yPRDFmJeQx1Pqo4HpfaZgj/el/PhT8Mmpgw9jHp2jb/bSab+swD2uBbkiXr64iC8C+Pa8NgXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ5k6McrbLScSLFG+AdwUpXM0w1+eo+BI/bvEMOs/EA=;
 b=YXrDxuH3CmAaFu658odELCzAnm9BwGOWspEGxbWiIUMdvv8yVuriWCZgm6xTW7SDNAGN5sJM3J+skux30JKBIWZVgXmrV9/Zf/OPZc3uFQq70hpgyCkRutgw6TreRM7/bAqqGWgAv6RQduzsXQgPu4O1iQeocp6YGoJYKATqFCn8POtfF4CgjTCOFr/9BgvbReN9146dts2Jz6/Kf38SyO5RlYD9hWXiP41epqSjlvTXpjnQJTRt5HgtPOHC5bUsDlz9OfGFMRCLw4PSqjgqtKECx56/9eiXMSP29LVqZihKrWhCLh9Es4pSAJFQY9lDqmMBhqEJUbTWjxZuy/4WgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ5k6McrbLScSLFG+AdwUpXM0w1+eo+BI/bvEMOs/EA=;
 b=ufX7qVWI1qMRiADk7x4fWqR4AxjDjZNagnkZNlKg/z2MhLXE+Lqsl9PgPSEDbhliZbO4aRb+RyNa3dhOJ61R93cBjvbHCXeF1YC1zT60FjlRl6lWSuRrvpH4m75hSFuP+DpnJowkx9YHCsKnvIneG/Yx/fjep025XH2wDJFe+kw=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Thu, 13 May
 2021 18:45:56 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e%7]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 18:45:56 +0000
From: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v1 07/11] mm/sparse-vmemmap: populate compound pagemaps
To: Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-8-joao.m.martins@oracle.com>
 <CAPcyv4hcMg6cJctnY6V=ngL9GoPVvd3sSYRbS-WZoTg=SnrhEw@mail.gmail.com>
 <63ce653d-4d21-c955-7b81-abba25b9e4b6@oracle.com>
 <CAPcyv4guVWx0TdEe_Z+CQEbRPDk9LGcgb87pb=g8XdRyeUaPcQ@mail.gmail.com>
Message-ID: <bbc5a003-5a8f-45ed-5445-a7794ea532fe@oracle.com>
Date: Thu, 13 May 2021 19:45:49 +0100
In-Reply-To: <CAPcyv4guVWx0TdEe_Z+CQEbRPDk9LGcgb87pb=g8XdRyeUaPcQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0239.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::10) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0239.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a7::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.28 via Frontend Transport; Thu, 13 May 2021 18:45:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e15eab4e-7f10-4a31-8b24-08d9163f57ae
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB37350734A61CA3DB6B2687A0BB519@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	blyK2QzGJSCUig/ROID3ERuqAIGqkwEMmLrZ9plrLtZzOIRQmf9jw0bnv8LtvUhxjh77n2zMiXVEPQWPka2cg7NLigzeTqC70E8XQ41zlwdRaY83ezcR+91hKeAVhubpbjYq1vYFrgaaBBOtXH+NLiEVAlY5wGY9mtBWiVBhHxBFNbXXcgtB36JQLpO7LA34qfln78rDdTzSwpy5wy63onKxuXqW3BZDyrv1d5E328qts7NS3j1823Ss0pNBdqeEsrBAUN4U/P5gVvrrtGc2fhhGwztQEDX0qHD7w+Ztq/BeUv/3oQq+t9aj2KaAmQi3A7QVTXNC41WIgCya3mmPtfM9OzQrGMhQUFOWRkdx+Yo17OIqIk4TmhrydvYpDbK067kqVqCS1BFDhmh/ksRbDL85+yWihYYCduRTXK3ilwCXucel2ga0esBPZyHj2IqS0m1HlfgFwb2IM21CN6hPClVynDOlZijUzmvPK3qSgmvGA+QBjo2tZJJKcP9wlBZSzPfys7dJfCh+c876AI3J0lVJ/ooRDi/DpjUzM8CmVj3wYanKwHOD/xsOPNhP+IVA1osVhGgr4Ae9EYJMcpO8Q5Hb+KqN0ApRWUv5PDiZgWQA9bCIXx09y4jUjhcdSpgRaYZ8Gw0bwSkYKGxcfDtbsyvtaDOhqjoIn7ljbY2k4J8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(366004)(346002)(54906003)(5660300002)(16576012)(83380400001)(31696002)(316002)(956004)(6486002)(31686004)(2616005)(26005)(2906002)(86362001)(4744005)(38100700002)(53546011)(186003)(16526019)(4326008)(6916009)(8676002)(8936002)(6666004)(66476007)(66556008)(478600001)(66946007)(36756003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?c3lXeTIzRUI4VGZFNGxsd1UrWXNBTDdZQjMyWDFiQ2tZNUJGUUd1dElVNk1H?=
 =?utf-8?B?MlBsM3pQMFBHWWpibi85b1F0SXZSY1o0STN6WFJteS9pUWJDUVg4dzdxZzd0?=
 =?utf-8?B?V2syS1I2OUFtQ1cxUEUvRWpqVDRqRmdBRFJWcUw2R25HWkFEZGF0N2NoMkRJ?=
 =?utf-8?B?Ry84Yll0Qk1KNkZnc0hFUFNUZk5lNHRkYWlidGlVelZTRUxCSkV1NzY3TUtr?=
 =?utf-8?B?NkplZ3l1TFJYWCs3L1p0U3lsQTQxb3NBNGJVeXB0VDV3TENST2U5U3crbXRS?=
 =?utf-8?B?bW5raDFQazQvcU1SbDE4Y3VhZXpEUmI1ejFDeFRVYXpGelpENFlIeFhRbVBM?=
 =?utf-8?B?TmlpcW1iUjhnL0NHUEhyZlMrVjRKYXdIRTUxSVFzWERkQUQrQmlZUWZUODJN?=
 =?utf-8?B?WGpUa1V5S1BMY0RqWjdud3FQT0pOcEhjSU0rNDJmQWxxRXROV2E2VTlPU2pq?=
 =?utf-8?B?UWpyNWk1YU9qSFlxWjMvaGxCSGE2VFlPZHUxTmV4emJyQnJuNGRJbk1yNmxS?=
 =?utf-8?B?Y1NNSzFSUUNRc1pXd2ZvK3RUL0lKODcyazl2OFRVelRUeEsyb1d6T1M1NEU1?=
 =?utf-8?B?WWVLclZ4L0lDMXRZT2VzY1BmaWJLYjVzTUxsMVNyQklBK1VXU1hkdDZ6SjJw?=
 =?utf-8?B?SXo4blEvMmNDQ3JFcG11cEhSQUhqbElHK3p3d2FCSHNsOFF0cUcyeStIUW43?=
 =?utf-8?B?ZTBNemwzb01UaWN4VkhkTmpDSWhUcGx4ODRuN210S2thMTZGQ2xqbmw4Z0Vi?=
 =?utf-8?B?Wm5FdWI2c0lDSldEbFRkbmRDbS9mLzdxTEMrQUZzZUp4TEFDWGhQNDFCNWlE?=
 =?utf-8?B?QjJBcVhodnRWYXNCczNnV1ZZL1Z6TzJXcnRRUHo2NWpaaFJ0SjBjQld5QkpX?=
 =?utf-8?B?TkVKUkM4bkJuUFQzaVphZUpEZUZFYkExNWRRMFpSYUQyeGJ1K3lXYzlSQ1J4?=
 =?utf-8?B?RU52QXV0NXRRUWJMNlhtQ2VCR1VMbFY4QWNBM0hoNkZSM0pJL3ZNaHJ3QjV5?=
 =?utf-8?B?Wm5UdlhCNlhTSUt2Z2dXaHRDa2Z0clVEZThKUSthWVBoRHNiR1ArWE5BQm5k?=
 =?utf-8?B?SGFDK3hQaVl4MEtyeWEwNUg1U2lyejVLNFJnR01FU3ZPTUNrMFpBNGdhYXJZ?=
 =?utf-8?B?MWNhVHdEUGIxTTZidE5Ua3RCa0hQcXg2T3MrK01sdHpVUXZMeVdVSWhUU2J2?=
 =?utf-8?B?TmFJMkFvaVcvalVLaFl1VS9BOGF6NWd4VjBackdaenAvbjBIZnRsNGdINzVI?=
 =?utf-8?B?NnZ3UzFlKzJVZGk1cXhoSkVIT3E4MzRFWksyS1VQRlFyOUFuZXhyTllvTzVl?=
 =?utf-8?B?WXlNOEh2Tk9GUGdVeEtDYXhvcE0rRm9PRG1tK1czZkp4ZDYybEVnV3RQb3p2?=
 =?utf-8?B?ekx2V1FqdEsvQzh6YVdPQXo3L2d1OWlxdHdWdTlvWU5qUWNiS1lDQnhZUWdY?=
 =?utf-8?B?dDV4aEhLRFl1Rkk2a2lUWkNack01cDNqd0VFcy9oWWJuNzdsUFBlNmNLc29i?=
 =?utf-8?B?UU9XbFZzSzQ1eFJVaEZGSkswcFZ5dmYrUEhhNnFRUi80YmNoaWd4eCtjUE4x?=
 =?utf-8?B?ZG5pVGdMTXJGZzVsZzJLR2R4cGUxeVFyZE1SYlRuWFQ4NHIxa3RDOXNTa2h3?=
 =?utf-8?B?WFBucWtqblI0Uks5dWlTOHFjYTFzRnlNcXBjRUUwQjRweEZ1NjlFSmNENFhZ?=
 =?utf-8?B?clhlR3hqb1FRSmJhbmc4L2ZMTnc5dVFxcEVlaVdyMU01MFFTVFJNM2xncEFK?=
 =?utf-8?Q?rHyzm7h/IbtCSs2UdzhXAImUPwEm6jzzsSk+PU8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15eab4e-7f10-4a31-8b24-08d9163f57ae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 18:45:56.0322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtYWbWtEupNBfFLwOKKzLeNSI3sqI613h1kPr+8kKoHnMUY0Zp8QJMFjfJpYl72PLXwdXRlyjWnE8cLqP8WyZtTditbzf5XzL0wC8Fg2bIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130129
X-Proofpoint-ORIG-GUID: Q6FnUsAdBzWkf7Pm9KSQ5hyvgAlagyij
X-Proofpoint-GUID: Q6FnUsAdBzWkf7Pm9KSQ5hyvgAlagyij
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9983 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130129
Message-ID-Hash: OA4ONBTOZ4ARUU4LIZFXGDCNEPDPJ3TO
X-Message-ID-Hash: OA4ONBTOZ4ARUU4LIZFXGDCNEPDPJ3TO
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OA4ONBTOZ4ARUU4LIZFXGDCNEPDPJ3TO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/10/21 8:19 PM, Dan Williams wrote:
> On Thu, May 6, 2021 at 4:02 AM Joao Martins <joao.m.martins@oracle.com> wrote:
> [..]
>>>> +static pte_t * __meminit vmemmap_lookup_address(unsigned long addr)
>>>
>>> I think this can be replaced with a call to follow_pte(&init_mm...).
>>>
>>
>> Ah, of course! That would shorten things up too.
> 
> Now that I look closely, I notice that function disclaims being
> suitable as a general purpose pte lookup utility. 
> If it works for you,
> great, but if not I think it's past time to create such a helper. I
> know Ira is looking for one, and I contributed to the proliferation
> when I added dev_pagemap_mapping_shift().
> 
There's also x86 equivalents, like lookup_address() and lookup_address_in_pgd().
These two don't differ that much from vmemmap_lookup_address().

I can move this to an internal place e.g. mm/internal.h

The patch after this one, changes vmemmap_lookup_address() to stop at the PMD (to reuse
that across the next sections).
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
