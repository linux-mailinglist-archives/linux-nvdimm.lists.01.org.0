Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542BD374B4C
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 00:36:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CACA9100F225A;
	Wed,  5 May 2021 15:36:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9C51E100F2253
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 15:36:35 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145MXrOu192942;
	Wed, 5 May 2021 22:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XACopG7v3MNrc4PJJp7nX31Iaia7txtUgNHQ2GzPJ0k=;
 b=HAGfg5LaWf1lgVcExiKuwBO8hdi/7YM4+t2KXNGz1s5OOnUVWL+qEdc155d6jkUNZyqy
 IRQLg6jm+YaUfz0QPJPr+FMqXG6debEPRfJ1v/9ZntK8vd1jHFIdYQM4CFUIffTBRtAI
 YBaCjb2EA3i1g9IICu++tZ4XVw4R3HsVlgG+Jw1AVaamswRNVohTeL0hhgPTlf5k54Z5
 ySXxERBt9uuOmzAWAfNyM/iww1bSTR8Kij3k2J9q0Z3iVw8Z+z4JVoiZEqdTU/2izoZQ
 m7alXhRjOlfKdD9+JfSqQvKpJqPabpr88a4t/Dcy6VXGIatQsBeo4CESBHL5AKg0sD7v GA==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 38beetkbfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 May 2021 22:36:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145MZSJd168930;
	Wed, 5 May 2021 22:36:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
	by aserp3030.oracle.com with ESMTP id 38bewrjp58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 May 2021 22:36:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz+Id90PGQ+h1RMDoKoKqiVqpc+cxZDXyKkaU2fKPwSjc/cEcqmnkgdR3ZJhHwuJGK2QbhZhTCj2hk0e/ODie78rxGK+WRTDBqHtW9IbKVTno++YrtVfA59+i5npW1ALqDGxmlSCYOiXOkA9ISumbT0EzC+blNlSh4fK9+drnQ6c3gvMaZyyv7HXKsgm2dHdBpVfe1yHjwZsAFXLa752lCISmxJoD6socrzdPo+VQN1I9H9fg1stwOxioHIgD2B1a1pyuR9L823WeiZVsbY5GHN3C1L+fgsx7+jFYBhZL6P+HLDOS8lNCGEzcrc1WfYmXUXQMt97/82ZNK7QWPli1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XACopG7v3MNrc4PJJp7nX31Iaia7txtUgNHQ2GzPJ0k=;
 b=e80IhFRD9RHMj53jJobKZcR+abe+uIJy65S9wSfhscRvCj4bJZ4XtTuKY9HS6Sw5zG9H0lZuumY7GNN+LBQJ7LUecZCTW20qRnl8lC02c4aEDJ22QpQUkZUN/p1v2pBkANO64Y53tyD46IPXwVH2VTedsXYmrOqhSx+HRWNcMbeVLf7z9oS3diMhgKriQELbqfe3zLcGEhXFqTYU5+Pw5OW6YFl0dems6C/UXBRAq4mGqXlCJX/+rXBYQwLI6ZslD3/AYPusHz1rNfmqXwPjCzJJqeIqEloRG1YLX+qeSVbr1OQCqT4U0AH5Q1IZeQPtOY6/d3dG7A1urblKW43rag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XACopG7v3MNrc4PJJp7nX31Iaia7txtUgNHQ2GzPJ0k=;
 b=n13hRjXKJfuJ83fog9y3rArF91tW1v2EL3ccDohs0QH4B7fBRz9Uv3hJbpV51qs+mkp1ZQzVxlIbY/Myu9kvjX0zTeJX4xS1JTnApqCipkAE0OxvMZDsLBy2y1aIuWdGhyI+1if1HEN71zo7rHbN5MDDSWgC7xxkW7+SMSPEbsU=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3158.namprd10.prod.outlook.com (2603:10b6:a03:15d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Wed, 5 May
 2021 22:36:23 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e%6]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 22:36:23 +0000
Subject: Re: [PATCH v1 04/11] mm/memremap: add ZONE_DEVICE support for
 compound pages
To: Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-5-joao.m.martins@oracle.com>
 <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
 <cd1c9849-8660-dbdc-718a-aa4ba5d48c01@oracle.com>
 <CAPcyv4jG8+S6xJyp=1S2=dpit0Hs2+HgGwpWeRROCRuJnQYAxQ@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <56a3e271-4ef8-ba02-639e-fd7fe7de7e36@oracle.com>
Date: Wed, 5 May 2021 23:36:16 +0100
In-Reply-To: <CAPcyv4jG8+S6xJyp=1S2=dpit0Hs2+HgGwpWeRROCRuJnQYAxQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: PR0P264CA0222.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::18) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by PR0P264CA0222.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 22:36:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b82c3551-4c06-43b5-5eb5-08d91016360e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3158:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB3158AA235F74792A516F3F3FBB599@BYAPR10MB3158.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3yUEJ0xoy1h/hAVNRTnWz+JXIZeRmmribwxY2J6grQY//6Xy3cEHjDZ6cL+Lizda1UJ6XgWUi0C4dOUlmGZ/JA4QRAOXgRElefyS3nUGS8yJ8SJN0Helmc4v6QrGFbL7Vad2U6td8nTrsp63H+GObkAFFHR/ZjB23w43A3biz8ecltafdO9TKhl4y3vYco++HYRRAHA3wFh0Ri2Dvx9ePc86Kj2rgV+H5EBIf8U2yBa2ToSRem+h7XA33EA7P1cZS3EXgBe1AukV6wGxvOdWYoPzTqBqe+pm6mcADy8yIvy1Ug3bTn5bH41uhS25QzNEOM8xCxQvfd72VDMtExDRKm+dv4FGiM5RYVS37Po8TfWGU923ojDGjq45cfw2dZiMMugCmY5m9U3lX4ypi52N18Fm6BYE/qiM1nN77DcsqoARzZQ7MC+Aj0HmPNQ3OiN7Cn8AP7tfDpLcN8ueXSfpTElK3ScdrKEibbmMk4nhmuNOPPV2Xs0sLFNWCHbYwqfWVq1GK6EHht+kZjV5cvAJdwUjhDg+koQJFWpiGy28Nt6lDvjCxQ5gerxfLBo8jT6oBxZ4Wl/AxTzgab6bSHdqaT2yTFK4AuE8Y7a+HMvFo8ktRRpDJr+kQmc4QKUKVFP5faiMftNUSrIrO1G+lTLOzOUAY2UCe/X6SBHd2cUfcB8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(136003)(346002)(66556008)(26005)(66946007)(36756003)(5660300002)(6486002)(86362001)(956004)(478600001)(6916009)(2906002)(53546011)(8936002)(31696002)(8676002)(316002)(16526019)(31686004)(54906003)(83380400001)(6666004)(186003)(38100700002)(4326008)(16576012)(66476007)(2616005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?dUQwSG5seDMzVnIvSHhRSi95cHNVR29rTDRnRGRxbXBwZGwvRVZGeTBheVFq?=
 =?utf-8?B?SURPc0VNWERjSldsQjY2VDhldzd2L2xOQWJsZlhjUk9RL1A3MXYvQmlmYjZL?=
 =?utf-8?B?KzZPWGs1UzhybVVQWTNEY1FRK3VRR08wZmhvbXUwc1EvcjRjcU1EZmRENUZh?=
 =?utf-8?B?WUV0eGFRVVlLTnRRS1BrUW9FYzlTbFk5NnhZc1h5Rk13bFhPS3djZFlaVlFN?=
 =?utf-8?B?WXoxemlGVmJZakhuRk9HbzlZWmdUSmlBZlk5V0dGUEJNaURFVXZzUXNSd0ZO?=
 =?utf-8?B?cHBZaVA2djBhOEQ4c04vZXYrWVVxR00xSm9Md2kyd3VlQmNqdy8rNDVrVVg4?=
 =?utf-8?B?TmFDN0t6YmFwU0E0cTF1LzVudHdsdUhGTFEyaWJ3OUdnL3RkMldsd2ZHdklD?=
 =?utf-8?B?MVNiOWNOYW51UmN4NFRoUGlLZEJGc0pkVnZOb2x2ampqTFVxQW9yYjdwWVdU?=
 =?utf-8?B?NE5rL25vTlRXeTB1SnVmd0ZOL1lUN0tVUkVrNHZYU3RZblBVK0grWjNDbVRi?=
 =?utf-8?B?NXM3T3RGOW9FN0haeDgzTXZLdmkrTE56SXl4N0kyc0tadTBsY3dZVVhhL0lK?=
 =?utf-8?B?amtyeVhxVDc2VDVOVVZndDhiU2ZjQmVBNGZmaDFFTXkvcHJzeDFsanZON1dy?=
 =?utf-8?B?VjJuVW82Z3ZFNmNMeGpQWmx0VzBaQWtZVm93bnppUUJrRXBIalR5SGN4cUFk?=
 =?utf-8?B?eXhNS255MlZGSzFzSTlNa0psUmIrZWhrOHNXbXRjYkxyQXRmb2dlZmhJcklJ?=
 =?utf-8?B?VjYwSDR1NEFBbnVXcXAremhzSHY0N1k3alBSYWZmdjhPUGJreWp3blhxTEFC?=
 =?utf-8?B?ZmgyOWl1bm9vaVZKeXpXRDdGempmOTBRYStMV2h5RmVPcXNnZHdHMXFqZXZk?=
 =?utf-8?B?WHZmZ3RJdnRUNEl3cTZVdk43QUs3ZlNlODlzbEhCeXJ4cDdRNS9DWEJvdm5s?=
 =?utf-8?B?aXNpSitjM0dYcUZEaFlhL25VQ29JWmh2S1E5WjQybTg2UDlIOHdqMUxKeHFW?=
 =?utf-8?B?c052UGxQYk9QbmEwODlwdHp4RE1OalErNFNoUHhPVFlOcFVCRjFMWDhjd3ds?=
 =?utf-8?B?YVV0a0EwaWY4RjRvWDZORDc1OWw4VG1BZnVsWjQ5NEQzdnJML0hJZjZKRitV?=
 =?utf-8?B?WitadzhSOWY2UDc2OFptOXRrbE5kRWVxK3pESi9PdFRRbHpNRE5YRmJ5Mnlp?=
 =?utf-8?B?YnFIMUE2bVBUVHc5MHVjcitWU0RzK2VBWmFGQjl2YkxBZmpMYzZvZDBlR2VD?=
 =?utf-8?B?SXBUMEVOWE43QldKSWlxQlpmcjQzMjV1aHJIdndSOUpOSlEzSitGZ0wvSXVn?=
 =?utf-8?B?SFNkbnRydHFsSUd4RlJsKzR1ekhVSnd1SGRoMFh0NEk2djRKdERweXNZUFNo?=
 =?utf-8?B?OG8rU1g0N1FtdDZ0bDc2UlgxWmJDamRWYzI5dmo4MlYzaDBUU0E2MXlDS0lQ?=
 =?utf-8?B?RDZQU3ZFRzRMNSt4Q3cwbEY0UEFKdlBWcStrVGFUdFlaMG5uejYzUUFUcGJX?=
 =?utf-8?B?aFhrRzVkbXZFZjBjMk1TVzdLZkd6ZnVMTGZiWkNZVkw4cWNYVUlaaG5rTCtT?=
 =?utf-8?B?YUh1dXNQN1hMZzMzRmYzanVkWVZWa1Y1UDR1aDFNVTJvRE5hVWVqVStJcEJS?=
 =?utf-8?B?S2xYcDlRZW1DajFuRDRVWXg5dUJDZ2tPTHhpbGcyeGl6R2ZVZFR5a3NoNCsz?=
 =?utf-8?B?V0I5Q2hOS3NWRXd6dVZEOEdIeEpkWE1Id0hEdGhyaUEvYlFBd014bmREeTFJ?=
 =?utf-8?Q?aVvlOp+b68ASkC2QHtI8TTN16AenxwNdrpsamRJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82c3551-4c06-43b5-5eb5-08d91016360e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 22:36:23.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iib4vT/mktyPKXK7PQr4+iFPbF/NnOx4sFF2gVS/HCm2vTTn0LKXO0LT0/LcbZf2oIq2kgDnc67aREGBrIrEv/HlBNEg5OyFYgMTwyideoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3158
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050155
X-Proofpoint-GUID: UeJMtSxFWvCjtZaBurviXntPrdCMkxtm
X-Proofpoint-ORIG-GUID: UeJMtSxFWvCjtZaBurviXntPrdCMkxtm
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050155
Message-ID-Hash: KN3JHAIHM6MHN6PSXRAZ6PPH2JDPVNMH
X-Message-ID-Hash: KN3JHAIHM6MHN6PSXRAZ6PPH2JDPVNMH
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KN3JHAIHM6MHN6PSXRAZ6PPH2JDPVNMH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/5/21 11:20 PM, Dan Williams wrote:
> On Wed, May 5, 2021 at 12:50 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>> On 5/5/21 7:44 PM, Dan Williams wrote:
>>> On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>>>
>>>> Add a new align property for struct dev_pagemap which specifies that a
>>>> pagemap is composed of a set of compound pages of size @align, instead
>>>> of base pages. When these pages are initialised, most are initialised as
>>>> tail pages instead of order-0 pages.
>>>>
>>>> For certain ZONE_DEVICE users like device-dax which have a fixed page
>>>> size, this creates an opportunity to optimize GUP and GUP-fast walkers,
>>>> treating it the same way as THP or hugetlb pages.
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>>  include/linux/memremap.h | 13 +++++++++++++
>>>>  mm/memremap.c            |  8 ++++++--
>>>>  mm/page_alloc.c          | 24 +++++++++++++++++++++++-
>>>>  3 files changed, 42 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>>>> index b46f63dcaed3..bb28d82dda5e 100644
>>>> --- a/include/linux/memremap.h
>>>> +++ b/include/linux/memremap.h
>>>> @@ -114,6 +114,7 @@ struct dev_pagemap {
>>>>         struct completion done;
>>>>         enum memory_type type;
>>>>         unsigned int flags;
>>>> +       unsigned long align;
>>>
>>> I think this wants some kernel-doc above to indicate that non-zero
>>> means "use compound pages with tail-page dedup" and zero / PAGE_SIZE
>>> means "use non-compound base pages".
>>
>> Got it. Are you thinking a kernel_doc on top of the variable above, or preferably on top
>> of pgmap_align()?
> 
> I was thinking in dev_pagemap because this value is more than just a
> plain alignment its restructuring the layout and construction of the
> memmap(), but when I say it that way it seems much less like a vanilla
> align value compared to a construction / geometry mode setting.
> 
/me nods

>>
>>> The non-zero value must be
>>> PAGE_SIZE, PMD_PAGE_SIZE or PUD_PAGE_SIZE.
>>> Hmm, maybe it should be an
>>> enum:
>>>
>>> enum devmap_geometry {
>>>     DEVMAP_PTE,
>>>     DEVMAP_PMD,
>>>     DEVMAP_PUD,
>>> }
>>>
>> I suppose a converter between devmap_geometry and page_size would be needed too? And maybe
>> the whole dax/nvdimm align values change meanwhile (as a followup improvement)?
> 
> I think it is ok for dax/nvdimm to continue to maintain their align
> value because it should be ok to have 4MB align if the device really
> wanted. However, when it goes to map that alignment with
> memremap_pages() it can pick a mode. For example, it's already the
> case that dax->align == 1GB is mapped with DEVMAP_PTE today, so
> they're already separate concepts that can stay separate.
> 
Gotcha.

>>
>> Although to be fair we only ever care about compound page size in this series (and
>> similarly dax/nvdimm @align properties).
>>
>>> ...because it's more than just an alignment it's a structural
>>> definition of how the memmap is laid out.
>>>

Somehow I missed this other part of your response.

>>>>         const struct dev_pagemap_ops *ops;
>>>>         void *owner;
>>>>         int nr_range;
>>>> @@ -130,6 +131,18 @@ static inline struct vmem_altmap *pgmap_altmap(struct dev_pagemap *pgmap)
>>>>         return NULL;
>>>>  }
>>>>
>>>> +static inline unsigned long pgmap_align(struct dev_pagemap *pgmap)
>>>> +{
>>>> +       if (!pgmap || !pgmap->align)
>>>> +               return PAGE_SIZE;
>>>> +       return pgmap->align;
>>>> +}
>>>> +
>>>> +static inline unsigned long pgmap_pfn_align(struct dev_pagemap *pgmap)
>>>> +{
>>>> +       return PHYS_PFN(pgmap_align(pgmap));
>>>> +}
>>>> +
>>>>  #ifdef CONFIG_ZONE_DEVICE
>>>>  bool pfn_zone_device_reserved(unsigned long pfn);
>>>>  void *memremap_pages(struct dev_pagemap *pgmap, int nid);
>>>> diff --git a/mm/memremap.c b/mm/memremap.c
>>>> index 805d761740c4..d160853670c4 100644
>>>> --- a/mm/memremap.c
>>>> +++ b/mm/memremap.c
>>>> @@ -318,8 +318,12 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>>>>         memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
>>>>                                 PHYS_PFN(range->start),
>>>>                                 PHYS_PFN(range_len(range)), pgmap);
>>>> -       percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
>>>> -                       - pfn_first(pgmap, range_id));
>>>> +       if (pgmap_align(pgmap) > PAGE_SIZE)
>>>> +               percpu_ref_get_many(pgmap->ref, (pfn_end(pgmap, range_id)
>>>> +                       - pfn_first(pgmap, range_id)) / pgmap_pfn_align(pgmap));
>>>> +       else
>>>> +               percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
>>>> +                               - pfn_first(pgmap, range_id));
>>>>         return 0;
>>>>
>>>>  err_add_memory:
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 58974067bbd4..3a77f9e43f3a 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -6285,6 +6285,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>>>         unsigned long pfn, end_pfn = start_pfn + nr_pages;
>>>>         struct pglist_data *pgdat = zone->zone_pgdat;
>>>>         struct vmem_altmap *altmap = pgmap_altmap(pgmap);
>>>> +       unsigned int pfn_align = pgmap_pfn_align(pgmap);
>>>> +       unsigned int order_align = order_base_2(pfn_align);
>>>>         unsigned long zone_idx = zone_idx(zone);
>>>>         unsigned long start = jiffies;
>>>>         int nid = pgdat->node_id;
>>>> @@ -6302,10 +6304,30 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>>>                 nr_pages = end_pfn - start_pfn;
>>>>         }
>>>>
>>>> -       for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>>>> +       for (pfn = start_pfn; pfn < end_pfn; pfn += pfn_align) {
>>>
>>> pfn_align is in bytes and pfn is in pages... is there a "pfn_align >>=
>>> PAGE_SHIFT" I missed somewhere?
>>>
>> @pfn_align is in pages too. It's pgmap_align() which is in bytes:
>>
>> +static inline unsigned long pgmap_pfn_align(struct dev_pagemap *pgmap)
>> +{
>> +       return PHYS_PFN(pgmap_align(pgmap));
>> +}
> 
> Ah yup, my eyes glazed over that. I think this is another place that
> benefits from a more specific name than "align". "pfns_per_compound"
> "compound_pfns"?
> 
We are still describing a page, just not a base page. So perhaps @pfns_per_hpage ?

I am fine with @pfns_per_compound or @compound_pfns as well.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
