Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18138322F76
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Feb 2021 18:18:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 55ED4100EB343;
	Tue, 23 Feb 2021 09:18:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C8ABA100EB342
	for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 09:18:42 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NHISOj145676;
	Tue, 23 Feb 2021 17:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=I9lVtHvbYtRUXaha4g3C66I6Opqy+uIvrUx69stipb8=;
 b=NpZsKno1nAh0xzs+JpfSM1zVVGPwm8Q1gdi5IDIFoh+jv5v26l2Q+9FiJoAUs53RkpBx
 j/mNFERDAc4p69bUVHDhz0SH8on+y4iIf6V3KDaTPExMg9VhcdSuDVgmAlOpMzL0pR0J
 u+oJVWz32YStyITPInb6d1yV48wJAC1ehGKEQKNfYaobcRgFhc0K2rfZFcGIo9TZY/rL
 5J4cyvfpRv9nKEHfe1FUutKsEwqitb2LtIb0BTqVYn+PxeaGYvcwo/z/gneR8xdFljWr
 HcYcDItx5Oz67Ue0n4A0XzDCOdeU1ZMNcRLheK8jnAh0kKTSk7tdadxduZLYC81R11Us mg==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2120.oracle.com with ESMTP id 36ugq3f239-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Feb 2021 17:18:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NHGVSN132787;
	Tue, 23 Feb 2021 17:18:32 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2052.outbound.protection.outlook.com [104.47.36.52])
	by userp3030.oracle.com with ESMTP id 36ucbxrxj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Feb 2021 17:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXY/EoUJAELwsAw5yUDrsV4NVLSuGFYc+gCmz6VJCKi/FPa7r8GwoooiBJ9tk/VDMEMeA/iWUAOKpsnr1rEWkfowzAaKV7HwP9aiAWBWSXQ15kfxIZitOZL3HKi9l+WXGl0f7zRDwN2OckEVg+wMnJ4C7J9F5pcFtexj33HUm2hXCFFv19FMTnuWU6Zi5p1Yl+7onvzHY3VZ2L9IFVNkU3YVTZ+Hq5rIl8dygLZ1ssCPl05cbTyjpfKY8T8uZ1vHTJRvnMcG8FfhEP2YzG7lhFdQSu92xNqGkaQiw8b6v/ewiPmZUENrb4CKQS/0NatL20lEUkdTNFT3swpvQlQyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9lVtHvbYtRUXaha4g3C66I6Opqy+uIvrUx69stipb8=;
 b=CIB8f6hkc2OpQbxI+R5RTLA26B0kNPbwEd248I/haxtTvCjO/Ah7frhUTuo6nDQFQJ3xh5Y7PevJsqtnW1xJMLMk2wX4n1ilejJdiYcWq31lE16zOavnmyUP2BMNZyPaxcLmHvZMBpsEBtkfnEDbTUSVFmMKo9iO9xzChxm6gLrFJWu/vcQwP2n4FU8JkqFTDsJOF/mRGAe8I2fcKO/yuaoQRzyxJq/vgZu3FIPCZ4RBuVZQMBbum31YYmtmbNWIF4QRBmS2nKw+wl4CvLhd2H5dr+/KL6h5w9icMrnEMucMHkMzHUkmbOYol1FFw3au/ZZc11xsp4ytTi+j1eHb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9lVtHvbYtRUXaha4g3C66I6Opqy+uIvrUx69stipb8=;
 b=JsKhSQz9DpaEXOgX7gqKF28wDr3hw6didfXEnUju+TmFF6FxWvwDv8B7y9qzS+soYZpQgDR6kHddmlfFuhIvSE+3O/NKFw6KpDU/lgYzh0K7rAJ+ZEvIAXpQvMhu5LUFAUDL+kSCumMFMoGfnk0IC4YJZGO0GZQc386yfpHHn7k=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB3986.namprd10.prod.outlook.com (2603:10b6:a03:1fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Tue, 23 Feb
 2021 17:18:29 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 17:18:29 +0000
Subject: Re: [PATCH RFC 1/9] memremap: add ZONE_DEVICE support for compound
 pages
To: Dan Williams <dan.j.williams@intel.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-2-joao.m.martins@oracle.com>
 <7249cfd2-c178-2e6a-6b03-307a05f11785@nvidia.com>
 <CAPcyv4iMzaAqKe6C1Q_feHL5SwppPdBem0i6XfYX4sL1U6sHgg@mail.gmail.com>
 <7e8908ca-4d0f-6549-0442-d4b15fbc90ab@oracle.com>
 <CAPcyv4jDk=ppsR2Pvgpb1DqWk5D8bkrNCAtyRU21ShnC3fzdSA@mail.gmail.com>
 <94075df6-ab3b-c6e4-13f1-26dd266dbf82@oracle.com>
 <CAPcyv4gsVWi8j=aZj3n1-O=39gq2jULcpWgiY22U6hpGTpcGzA@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <e9e24d05-79e7-275a-530d-fc3b5041845d@oracle.com>
Date: Tue, 23 Feb 2021 17:18:20 +0000
In-Reply-To: <CAPcyv4gsVWi8j=aZj3n1-O=39gq2jULcpWgiY22U6hpGTpcGzA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0312.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::11) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0312.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:197::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30 via Frontend Transport; Tue, 23 Feb 2021 17:18:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b64fdfa-1b20-4bcc-631e-08d8d81f09ad
X-MS-TrafficTypeDiagnostic: BY5PR10MB3986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB3986CF9CE12037F8A2297D77BB809@BY5PR10MB3986.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	flPElNt0oMpW9IAu1GCX1FMOM1E4qDEq+fHdl8LPunnSAnI9yny+GcScKaSZPZL3tRZzKkDTm7C4ZpCHb8+VdXmtYcYNWRZF9j+nHJhHxUWW+cfIuyeqEFTnhdM3Tuc+I7cdzgwnZE7KCBr8AjaIVgW3R0KVHw4yxAdGNB8PbeD7jsiQoFqd4wsXoC3SFpQuBALsZMi2i9bLAmVi5dxY6dheIC9bLgPy6PyUwEg7ZWfozQxWJIAdxdGv7Tx6L3H0F7L4aHzxWILnvVkxkff4VWuq1W9Vmy2NZX5YsHnn8siHSNglovazsXZvc0Ri9ifSiIwiOoTu8wO4RlxAerKI4R/VrB4X7qwT3oSxSomNyxF2gjNOTmmz850ubiaPe8la1vEtweSfHAxE0HLO010Ri31VEitVLuS9FybH3qTXMrKZXtKlOCbgVaQieqVa3Gdn6ZK+lYcp2nIhIfMhdf86kcALUQ92SkIHmMm7mg3xy6yOiDZ2nmOqjrCV1v7dkS1YOMOyvhWfb9EbDAvam3BoPHIf5PTRHOvPd3dYizrCjMCwdj6sfO70P74nChAZrN+FAmHRkhavI57lNXOHXzw6OA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(376002)(346002)(6486002)(86362001)(316002)(54906003)(53546011)(66946007)(66476007)(31696002)(66556008)(478600001)(4326008)(956004)(83380400001)(6916009)(5660300002)(16576012)(36756003)(31686004)(8676002)(8936002)(186003)(16526019)(2906002)(2616005)(26005)(6666004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?ZlBqcHBqRlNVZGREMzhIL2VlYjBob0V6bVY1b0ltQjhCc21aSm9rRlZYTFNt?=
 =?utf-8?B?Smt0cWQ5dEIzRThONEhSd2N2OW85L3RHcEdDZmFkOGRnK1NIMXRMZEpmOXB2?=
 =?utf-8?B?RG9lcnYyc2hOM01XYUQya2E0RldZN1dtbXhXSmRzOHpHT09JWktWc0lSU0xS?=
 =?utf-8?B?Y29tV2xNYU1TVFN1UyswMUN2d0JvS0UzeFM0MVRJaitvUUlSVGFxMEFLMTBF?=
 =?utf-8?B?cXFWaEJBTE51cllVb1VvUEVxam50dW5wdWJzait1UVhrS2haYnU2ZHNEL1R1?=
 =?utf-8?B?OXVZeXFVVEYxbXFBZGNHdE5XTXNFMHlpc2JqUEdqc0pSb1dhWWZVeTZpR2Rq?=
 =?utf-8?B?eVdnMVRpTDkwMSsvZUlNcVk4bmwvRWpVY1U0cjdQUjl3L2Npa3UyK050U0lr?=
 =?utf-8?B?RUVMS1I3aVVkc1VRTGpPNHpZYi85V2ZWcCtCUERaUEpUcUJGMnlseWtrazkv?=
 =?utf-8?B?Wkl5TkczSjhGSkFXNG5xWFVEWlhKNnBPeHNROENmZ21FMHN0N3pkR2ppT21S?=
 =?utf-8?B?QXJkaHlEOHl0d1ZWVDh5ZzNpM0tnaCtsVXRFZ09MbjBjMmFaTUd1UVBWTHBE?=
 =?utf-8?B?RzNuMTlTM0VuVUY1Z2hFTkNhanBwRzErbGhwbDUzY2NHY0JhUHJQR3o2SWI0?=
 =?utf-8?B?MktZaHQ0VWRpc3gyQ1p0U3dPVHRHSXYyeVFHTThpQWxYMVZqYTFPZ3U4b3Jt?=
 =?utf-8?B?U0ZvQVFYVTlMK21oNE5iNXJHamxkMWg2a3BGNlVnQ2UzZUFNRmVsaFBncHZI?=
 =?utf-8?B?NEpuTHJ0eFJ6OGZmcjJTWVRMUlhZa25NSzlMamtJT2NtR0hzWm9qbnRPZnFh?=
 =?utf-8?B?b1phWDQxdGkzSVRhTDNlc1lraXVhd2tSa2tCUGl3cWRUQWY5d2EweEtWNU1B?=
 =?utf-8?B?ZEN2TkJvR0pJRUtNWWZKMVJ5MElkcDYzYjZ1SEg1WCtrdjVMU0s4aGFVMWxx?=
 =?utf-8?B?NmJ6MmpsRmxRQkN4Y1pjUzJuV3JuSm1MZjM3Y1podnliYnJsWjFaV1hGSzBu?=
 =?utf-8?B?azIwZ3ZCVWlLOWdzc2cyRlZ3cHRVemVRWUpVYkxNWEdNSUZSUHd5OXp6RXpE?=
 =?utf-8?B?dDV2c2xRRHk3ekFxT05peWRPaEt1eW12bTNNQmNvZ2VkTCtUcEZka0orS0E2?=
 =?utf-8?B?Rk12U0hrQUtDV1pxZHg2WnhlQWNNeVJ1anJvM1lISUZPT1dkblRqOWFjM1dF?=
 =?utf-8?B?bjRFb1ExTTltbU9LRXlIaWpUeHJmTDZwQmM0YXRsTUZXUFd5bTByNGtwYW9h?=
 =?utf-8?B?RVJtRkt0YWZ6V0NhTmFRLzZ4VFVlamwwMnFsMXFNemp3RFA1ZFpqZFNZWlcy?=
 =?utf-8?B?SkUvT21sblB4Q29ndmJ1cjd2dWVpUmhZVUtUQU5sMElNcHU5dmV5KzFleE5a?=
 =?utf-8?B?YXlIejR5S3U3QlF5bkgvOStmTkd2VEIwMHZVZVk0K2pYNjVJSTVmNU9FVG5W?=
 =?utf-8?B?TExOejY2RjR5b0cxbVppSmZHczU4WTlsNWY5K3JvS3hjTFpDRkVJNmJIMWZr?=
 =?utf-8?B?aDYrYWFLbEhud2ExRlN6bWN5ajdYR2gybDZXZ2NTbWVlcTkzU2JhdTdycWRG?=
 =?utf-8?B?a1NUNjRFTm02cVhsWEVWSUJuNnNPVmIxbUhkbysvYWtLL0tsOEhCeElDcXEz?=
 =?utf-8?B?a3NScEgvM1lGay80cUpmcWoyeXlpdGxKbWZFb1NVamRXVGIwUnFkQ09obFVQ?=
 =?utf-8?B?cmtQMjNhckZtTlk3aUpWUVJHVGJJWWtUZmE0STVCUy9zQ3FQellETE92ZHFm?=
 =?utf-8?Q?t7GP6ZVUAjkkmftmAxAttgOaTjis5/1m8KnFvUy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b64fdfa-1b20-4bcc-631e-08d8d81f09ad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 17:18:29.2508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3eRthoGHchRzwRfYltdr9SNsD0BULMNQ1MoccY2KTjhm7sSFCgovL5JxYwVaGvAqU6KIV2nvY8FiQDzKnpyamBYEazsjj/XA34ejPrgprg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3986
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230144
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230144
Message-ID-Hash: RY54HZ4DJWR5ZGBFFOQ2ZCGEI6FUXSDA
X-Message-ID-Hash: RY54HZ4DJWR5ZGBFFOQ2ZCGEI6FUXSDA
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RY54HZ4DJWR5ZGBFFOQ2ZCGEI6FUXSDA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/23/21 4:50 PM, Dan Williams wrote:
> On Tue, Feb 23, 2021 at 7:46 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>> On 2/22/21 8:37 PM, Dan Williams wrote:
>>> On Mon, Feb 22, 2021 at 3:24 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>>> On 2/20/21 1:43 AM, Dan Williams wrote:
>>>>> On Tue, Dec 8, 2020 at 9:59 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>>>>> On 12/8/20 9:28 AM, Joao Martins wrote:

[...]

>>> Don't get me wrong the
>>> capability is still needed for filesystem-dax, but the distinction is
>>> that vmemmap_populate_compound_pages() need never worry about an
>>> altmap.
>>>
>> IMO there's not much added complexity strictly speaking about altmap. We still use the
>> same vmemmap_{pmd,pte,pgd}_populate helpers which just pass an altmap. So whatever it is
>> being maintained for fsdax or other altmap consumers (e.g. we seem to be working towards
>> hotplug making use of it) we are using it in the exact same way.
>>
>> The complexity of the future vmemmap_populate_compound_pages() has more to do with reusing
>> vmemmap blocks allocated in previous vmemmap pages, and preserving that across section
>> onlining (for 1G pages).
> 
> True, I'm less worried about the complexity as much as
> opportunistically converting configurations to RAM backed pages. It's
> already the case that poison handling is page mapping size aligned for
> device-dax, and filesystem-dax needs to stick with non-compound-pages
> for the foreseeable future.
> 
Hmm, I was sort off wondering that fsdax could move to compound pages too as
opposed to base pages, albeit not necessarily using the vmemmap page reuse
as it splits pages IIUC.

> Ok, let's try to keep altmap in vmemmap_populate_compound_pages() and
> see how it looks.
> 
OK, will do.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
