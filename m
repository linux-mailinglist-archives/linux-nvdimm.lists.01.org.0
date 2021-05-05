Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FF83748E4
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 May 2021 21:50:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 827F4100EB32D;
	Wed,  5 May 2021 12:50:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C0D0B100EBB62
	for <linux-nvdimm@lists.01.org>; Wed,  5 May 2021 12:50:31 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145JiPYR056287;
	Wed, 5 May 2021 19:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=V8XSY67D1gqb0On4S/uMChCSE2jfLzARvXqlK2B+vV4=;
 b=Hl9IVZp+y7aP4umKTRHIZHIArfzwgl/AEaB3jYBPeuWs/Oaywv+s35v+RszGVEj6Faz5
 wBvcXJXiODMTn4TWknPp8h5pA2eJO74pihiWTzlX2jYADJxDjcMOilAYEM/HZlJeZh9O
 X/DBNZ62lOXeElcc3shz4u2D143u3ysVExdDW+xuht71vVw1OY0FavwjupD6P2BNeKPx
 OQfQX2oOetvp9w6Xv0OMO7ETWppWLwh6OOK5t7CWrP5BImwfOFC9+eLp1tJZf8vAz1Dq
 upAMtYld0q9+0XoFYq20Fk20LcFkRSspQx1hKayV5qrz6hJZxAHIU+BwyWiLMI/YoUv4 2g==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 38bebc30ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 May 2021 19:49:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145JkL1K144489;
	Wed, 5 May 2021 19:49:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
	by aserp3020.oracle.com with ESMTP id 38bebjnqgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 May 2021 19:49:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3emOtUYW2uudWLsmWiHV5oVeZgrpDZwn2KzuYLcIgB1SFZGnadw+Ua1zVw9EnVvu4EFMBMxkBSMvjwXoMWnq1gyvjVWsIGQ1B1cS4cgGrAfFtEW38RJ2htMerQYpCTtjd/cwJjz7sAnPmUptmkk7D3BpQ9U8eAjfbRsyDzOutNeMs5oueL/dOdZAzvlMT5OHhGiQcfxZHOhGqUnl6zbFMyKnWEkUy162dw2n9KU1JjFrz1doRAGYIB0RVmsInyqnCVXOVu0NVLrYVBPlBNTpygddKlcVQvaCowZuxPth2TR/6SwRISN9yv/b/Xvt4EfoSMQQNpp8z0a4FRl+lfcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8XSY67D1gqb0On4S/uMChCSE2jfLzARvXqlK2B+vV4=;
 b=b+gUHmpCssAbjUrAe2e51mDia7rKWO4dJgQ8Tq/l15JqnSO+TKGMoZSrchhuGVSD+h6FA0lhW9j5vkd8G2bJ+YeWHnFYvqOERFJq2mnkmyvzVcmPAMhKKkzeJYEm2UixLYpaDhkl1ZwFZDRQAHUGMJSR9PgYhlbCADFtziKNqf/a2yEZTtX4T4cM281XH8QfPBsS2k/9okV/bGrRD1NaTrvm+aGbfrqkB3ME91SvE9kAEgSN0aSDr2YNGlx3M0HBwLC9NbfEZ7LkQO095KJIU4DBjcSqlDeYk/oG+ge6eGuYjf3UnvLZn1lo2RN58r74slyPuKoLM/0CcE+MP7WOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8XSY67D1gqb0On4S/uMChCSE2jfLzARvXqlK2B+vV4=;
 b=C89funaNshA0fTUZ8Svm9I4X+xGCix5VuGXex0TSMwS1aQ9Py7XDMXEZY6Roo4hvSQBivAHUEN8l0XB2cZqdxJ55gjMnqkPdDaCraG60hT2+Kk+38jKCnqGfZ6UqOXmCv3vQxZl0eV0cPsOqx/lWlFEc7k8b9pEkTsMjHYaRQ28=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2776.namprd10.prod.outlook.com (2603:10b6:a03:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Wed, 5 May
 2021 19:49:55 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e%6]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 19:49:55 +0000
Subject: Re: [PATCH v1 04/11] mm/memremap: add ZONE_DEVICE support for
 compound pages
To: Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-5-joao.m.martins@oracle.com>
 <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <cd1c9849-8660-dbdc-718a-aa4ba5d48c01@oracle.com>
Date: Wed, 5 May 2021 20:49:47 +0100
In-Reply-To: <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: PR3P193CA0008.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::13) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by PR3P193CA0008.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 19:49:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9526db77-798f-4732-033b-08d90ffef4fc
X-MS-TrafficTypeDiagnostic: BYAPR10MB2776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB27769E41A13CC72516C84AEDBB599@BYAPR10MB2776.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	epavCzM5pG/wr1+Vu0jOHbgW7FnaNRSsZat9vK/wlFXEBlj+p/iCd8VvcQ52yR1+4j9YPvtsd4fqinNUVyUz5CzLUUQWiZXEnDwHelJPsWegW9wp1qY7lXKI2ek95ovE+ADBayL2UmwG5pm9IPwLa/NWdvPhXpTdcI9H6TNWb1xb/GmOKRzBizwZGsSvOuaV9f9KjjF4tw2obYV6IqUk5n924JaE8jeSbnJMsy74eX5uijSdH115c0H1JTOUsGsaxSdfNbDdHxaWL5BsY/qnF9wxkk0/DxMgV6UDpzlaBprJ9RWqdTi1n3F9S1VCBzWL7HvRR0MM0O6YupMdYNrP/9hbE7D0PQcwTRosk1FZ/FsU+4voEdjEmEH+wsgfQUQpbK6ExVDqwA6ryIwgVV7F1b/Z5S3bWdlJuxErXZ9KYTB6XwJ/tuNgrMvXeppVwtvrzXx+dDQoGgpN21RsJPOzZhjP8JUf0YL715IEzBYm9oatX/alYHHwtwWOFjpU6Y3zXQ2Xssj/Po9BTwhDwKwKmcOIjfpKtN7qeWbKvMKoDWmjmSO3i0rEuCo1mqUQHbdLzXhRbp4qKqRT3FZO4IyJuaQTMuJh3OZXOZTcKOHr6ZOBgNuJVOUnwAfZ6Bz35TjhZK0zkim06d34eJnAoVAcng==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(39860400002)(346002)(136003)(66556008)(186003)(66476007)(38100700002)(2906002)(5660300002)(16526019)(4326008)(6486002)(6666004)(36756003)(83380400001)(53546011)(66946007)(8936002)(316002)(54906003)(2616005)(31686004)(86362001)(8676002)(16576012)(478600001)(31696002)(956004)(26005)(6916009)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?NzlzcEpYRzZwNGl4M3VnNW54UTBzbkR4RHM0TmlQUWZaZ1A5WEppZ1h0dUpD?=
 =?utf-8?B?UExkYU1kQkdsVmlpQ1FnQzJCWjlXVlJHY1lxL3IvUCtMQkQxQTRCOFh5bmRH?=
 =?utf-8?B?ZkFncjV4a2xQSEIrSmp6ZnN4TDNBUVNwdncveGg3OERqb0RGeVhoc1dBQVVi?=
 =?utf-8?B?YW1FcGc0RmV2YjBhUkVxMDBpTlJpRHU0Vkg2aldLZHQxRmZrOStYUEFXVmhT?=
 =?utf-8?B?dnVHUWMwK3pVaHNlOEJkRm9VaGY2bmtzRzVnTzBPS1l5YktaNzVzck5oYzU0?=
 =?utf-8?B?cHNmRld5cUNFTCtOeGlNTGVQc0FzL3oybXUvOWhrSkRCVTRUODJVT2kyamQ3?=
 =?utf-8?B?eFlobnRxamd2UVZLQ0tJNUVKU2EzWE84WkNTVmxtTW5GOUVrcDVhMjl2OW0r?=
 =?utf-8?B?UG1VWkNUM0RwZzdTdDdrMlpDTEN3NVFsNENDWmdQbFk1V1pBeUpZMWJVTERi?=
 =?utf-8?B?M1dKUGFCSU42K2xPYWFlVEM4bDl1OHdrbjZZV0xIQTFVN0ttUTZZQk55L2hs?=
 =?utf-8?B?SzBKcU5GeXRmck1DaWk0ekRXWEJ6ajI1ZW1CMXYyRG0zeG0yWi82c1N5QWZI?=
 =?utf-8?B?V2FQNVNBR1cxekJDSVNuM044b1U3c1p4ZVZoV3c3TUR3MHZEd0tMV0xIc0pH?=
 =?utf-8?B?bHdGamh3WW1HcHhjYWM5aGNHSytYZERqRU5EcXJoSVVhQ3pWYldxVU5JWmp5?=
 =?utf-8?B?VlFUcDRZd21mWWJzeHQzZU1yWldqSE5hNWxxa2RpV0dXYit5aHBFRlphaDRZ?=
 =?utf-8?B?WlRWSUdJUXV5T2srS0ZPOTFsK20ybnBSa1FhSHlaMzVGVDRpWE9mNW1VZ25R?=
 =?utf-8?B?Zmpjem9yZzk2QW8wb3NmZ2xvMU9CTWlzQlBwZm83OFA4by9PMlZhTzlTc3lU?=
 =?utf-8?B?QVNJSXZDQ3Eva1d3VUxzMXE0Q0RQU2ZEck5oZnJDbE5NWndXOXMxcVZrUEJa?=
 =?utf-8?B?cFZaYUdHUjJlQXF3dldaanl5L1ZJdGhtU3VrYlNlSG05WVBhSEw2VFVFOW9t?=
 =?utf-8?B?OWxsNVJnVFJPcXN0QVZQQTlSSk9NU1BFUHpnQjRMbjlzUHpYdWdsTFJXTUNC?=
 =?utf-8?B?dXdRdFBWVGwyRTNPWHQ3VXJJcnRTb0RjY1VCdnFSSkFkQ2poelg5ZVlPRVZZ?=
 =?utf-8?B?MGVCTHRjTktJdnB5aFJMdHFYZGQ4NHZNdjJSSU1lSXgwaE85bkRaRWwwbkxr?=
 =?utf-8?B?dUJWbzhsUjkxWWdkSjRqZ1JjNW9IVzlaUG1GM1g4dVNiWWRqWXpRc0JpZVpZ?=
 =?utf-8?B?Y0VaR2dWYytpdUxiQ1BvRUhCQ3Fvcm4yUUd5OVYzRFlXeEs5WEIyWEsyMmh4?=
 =?utf-8?B?MS9yM21kRjlHdktrbTQ5SDlCdlY4cFNEN3JKNnhodWs1Qm12OE9ERmhsTnlu?=
 =?utf-8?B?dXNOcWlRNTlQdkJWclRUOEc4dkN0bFRmdHNoSytZdGNwVXRFcG1xVWJmeXRu?=
 =?utf-8?B?aHZCcStZc2doOWgvTFlicHB4ZWVTNTdJZlhRQnJ0NXpMeTYyczd3bkNXaHdu?=
 =?utf-8?B?cm9NMlVQMXkzaERSRTZzcXVoR0d2allyZllWdS81bGUxZ0JLNEJjdGJSc2pv?=
 =?utf-8?B?bXNaZTFUTVUvSWZFVEhNT0dUVmxTRGljZE9RNFV2d3NPblVKdmdYMGttV09J?=
 =?utf-8?B?aXd4alJkTVltWGk5bmxoZVV0NlFIU3FsL0tYM3RiUnpnM3JyWFdJbHYyNlB6?=
 =?utf-8?B?bGdNSnBuSjVWS3VHZVMvZkFvRmVKVVRLaWdZUm10cWJXTy9BZXdsNElUa3Bl?=
 =?utf-8?Q?YyuF8cuAvApd3BthifRsYXtpUk2nHMYAIData9h?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9526db77-798f-4732-033b-08d90ffef4fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 19:49:55.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ow0H66Pp/zcElS6QYDGscWxgT7q2P2fkXzasoRuOvy5F3lYf8Gtv7tmaUiOMt7JnqARdxr5Bm5dPYy3ZQ2s00kH6gJBhH75Q4W3SkE4fsPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2776
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105050135
X-Proofpoint-ORIG-GUID: vp3RxTkXY5GF1L3ybRO84lkiEE9rU1zE
X-Proofpoint-GUID: vp3RxTkXY5GF1L3ybRO84lkiEE9rU1zE
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105050135
Message-ID-Hash: 2BCTARW7JZ55QU4S7A7GZOVRRPRAHDWZ
X-Message-ID-Hash: 2BCTARW7JZ55QU4S7A7GZOVRRPRAHDWZ
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2BCTARW7JZ55QU4S7A7GZOVRRPRAHDWZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 5/5/21 7:44 PM, Dan Williams wrote:
> On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> Add a new align property for struct dev_pagemap which specifies that a
>> pagemap is composed of a set of compound pages of size @align, instead
>> of base pages. When these pages are initialised, most are initialised as
>> tail pages instead of order-0 pages.
>>
>> For certain ZONE_DEVICE users like device-dax which have a fixed page
>> size, this creates an opportunity to optimize GUP and GUP-fast walkers,
>> treating it the same way as THP or hugetlb pages.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  include/linux/memremap.h | 13 +++++++++++++
>>  mm/memremap.c            |  8 ++++++--
>>  mm/page_alloc.c          | 24 +++++++++++++++++++++++-
>>  3 files changed, 42 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>> index b46f63dcaed3..bb28d82dda5e 100644
>> --- a/include/linux/memremap.h
>> +++ b/include/linux/memremap.h
>> @@ -114,6 +114,7 @@ struct dev_pagemap {
>>         struct completion done;
>>         enum memory_type type;
>>         unsigned int flags;
>> +       unsigned long align;
> 
> I think this wants some kernel-doc above to indicate that non-zero
> means "use compound pages with tail-page dedup" and zero / PAGE_SIZE
> means "use non-compound base pages". 

Got it. Are you thinking a kernel_doc on top of the variable above, or preferably on top
of pgmap_align()?

> The non-zero value must be
> PAGE_SIZE, PMD_PAGE_SIZE or PUD_PAGE_SIZE. 
> Hmm, maybe it should be an
> enum:
> 
> enum devmap_geometry {
>     DEVMAP_PTE,
>     DEVMAP_PMD,
>     DEVMAP_PUD,
> }
> 
I suppose a converter between devmap_geometry and page_size would be needed too? And maybe
the whole dax/nvdimm align values change meanwhile (as a followup improvement)?

Although to be fair we only ever care about compound page size in this series (and
similarly dax/nvdimm @align properties).

> ...because it's more than just an alignment it's a structural
> definition of how the memmap is laid out.
> 
>>         const struct dev_pagemap_ops *ops;
>>         void *owner;
>>         int nr_range;
>> @@ -130,6 +131,18 @@ static inline struct vmem_altmap *pgmap_altmap(struct dev_pagemap *pgmap)
>>         return NULL;
>>  }
>>
>> +static inline unsigned long pgmap_align(struct dev_pagemap *pgmap)
>> +{
>> +       if (!pgmap || !pgmap->align)
>> +               return PAGE_SIZE;
>> +       return pgmap->align;
>> +}
>> +
>> +static inline unsigned long pgmap_pfn_align(struct dev_pagemap *pgmap)
>> +{
>> +       return PHYS_PFN(pgmap_align(pgmap));
>> +}
>> +
>>  #ifdef CONFIG_ZONE_DEVICE
>>  bool pfn_zone_device_reserved(unsigned long pfn);
>>  void *memremap_pages(struct dev_pagemap *pgmap, int nid);
>> diff --git a/mm/memremap.c b/mm/memremap.c
>> index 805d761740c4..d160853670c4 100644
>> --- a/mm/memremap.c
>> +++ b/mm/memremap.c
>> @@ -318,8 +318,12 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>>         memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
>>                                 PHYS_PFN(range->start),
>>                                 PHYS_PFN(range_len(range)), pgmap);
>> -       percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
>> -                       - pfn_first(pgmap, range_id));
>> +       if (pgmap_align(pgmap) > PAGE_SIZE)
>> +               percpu_ref_get_many(pgmap->ref, (pfn_end(pgmap, range_id)
>> +                       - pfn_first(pgmap, range_id)) / pgmap_pfn_align(pgmap));
>> +       else
>> +               percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
>> +                               - pfn_first(pgmap, range_id));
>>         return 0;
>>
>>  err_add_memory:
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 58974067bbd4..3a77f9e43f3a 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6285,6 +6285,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>         unsigned long pfn, end_pfn = start_pfn + nr_pages;
>>         struct pglist_data *pgdat = zone->zone_pgdat;
>>         struct vmem_altmap *altmap = pgmap_altmap(pgmap);
>> +       unsigned int pfn_align = pgmap_pfn_align(pgmap);
>> +       unsigned int order_align = order_base_2(pfn_align);
>>         unsigned long zone_idx = zone_idx(zone);
>>         unsigned long start = jiffies;
>>         int nid = pgdat->node_id;
>> @@ -6302,10 +6304,30 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>                 nr_pages = end_pfn - start_pfn;
>>         }
>>
>> -       for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>> +       for (pfn = start_pfn; pfn < end_pfn; pfn += pfn_align) {
> 
> pfn_align is in bytes and pfn is in pages... is there a "pfn_align >>=
> PAGE_SHIFT" I missed somewhere?
> 
@pfn_align is in pages too. It's pgmap_align() which is in bytes:

+static inline unsigned long pgmap_pfn_align(struct dev_pagemap *pgmap)
+{
+       return PHYS_PFN(pgmap_align(pgmap));
+}
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
