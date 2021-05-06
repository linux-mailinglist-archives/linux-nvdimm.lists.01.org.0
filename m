Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCAC37523E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 12:23:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 11CD8100EB345;
	Thu,  6 May 2021 03:23:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CC78A100EBBD9
	for <linux-nvdimm@lists.01.org>; Thu,  6 May 2021 03:23:48 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146AKPsD189147;
	Thu, 6 May 2021 10:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XFEb57YFMo7XgPzde3eJ28ZqRz7DVJ3UBY/dPMaXFPQ=;
 b=DnhkFD9qfv8/TRIGkTz5BMR+0sEuBjZJEXA6KAc4p04uUeF01/sKD5n9lowXOK/0cXy8
 V3b2yvpFBikAHAM6H+zX0H4lu08/wcexq7BW9jzXPgRVWjy5qBVIbsBhYuZLjUY9J6aQ
 FjtwQ989cPbvMhsTOinbWpOh+CHfcJ3uFo1ouH9VjdIzu3QoVuy1z1nqbU6eUUNN8OEA
 z3+rlxT2eDxjqs9iFRCJ0u0Ux+dfpEdaZI7EWhx3A3YVeD9BDu1JqK0nVbstamBiPoqR
 9fZZ7116MYtjlR1OXPw2C4ywCJQprHj8S0lwNrMPCb9W8b/1RRRkwWQP3cM9SUsoRC+P cA==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 38beetmgtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 10:23:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146ALKkB137019;
	Thu, 6 May 2021 10:23:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by userp3030.oracle.com with ESMTP id 38bebv40ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 10:23:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmquZXE/jwDfFMxKyERtIK8mQVX28Zs2v+G+PkckU2cvDxXPWR5QPF90argthtCWEsUGsSz5OMaUTY1nxUCnLQNl6qc+pKuRU854XEXzkCqHDkE5yerg2xZVoRpFJ2N3paVN4gZcL9uYUDm6aLJaVLHJ+QX3X26ccqddTfZsGO00LLENDhu71/c/iXI12sdTCsxaqCz2vmKdUgcGaI0X5znIz4l+Qy1oKRYTXjMi39j32Auq1L7my9gS2+4HUHmZaVtGBqrSb77Td/4Ee5r4pFV0U6n+eCjafcrv1eim16O2svItop0OsK2HOs+5qKS6eHl915s9I20SqEi04d4Q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFEb57YFMo7XgPzde3eJ28ZqRz7DVJ3UBY/dPMaXFPQ=;
 b=a7PXBuIB/E9LyC0GJQYFA8okCLgn+m8Ap6//mxEN9FKlpCJbm7BnYXCgR9kUFZ61YTiD/GEEbTXVyIW78FsVd75yrrWskxUTam3wXHrjbNS/TBB26wEWa9jn1YeofS358QQFk9DKMRAvJZFWex+/m2VlSVHb817oKm0vsA/K3wV/M69s6K6+aTYT8j7dCXeJvEcGE8Lqz76ve6uLe9V+FQd6Pvvvk2Xj0BmGAiG6mR7R+WwM+MsOEj7Zped0nUEJSnsitNE2QzqnA3TvVldI/SLpPwTfofiBTisBh5M0HkOKECA6U0YF7XiBKBmNAiJOrgUpph3Vu6ZjmQLtvz+s7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFEb57YFMo7XgPzde3eJ28ZqRz7DVJ3UBY/dPMaXFPQ=;
 b=kBcYQgMGBvjvG1HrHqvuBKMYE1OkJ00XY/VcyqSok4yngEHWyna0xxaAqgkstnLs6wm7D/hNDJRUrNR2o4l6aLlzaDYc7OKUniaQMVF2JtYDJIfaXp0KTOH5oFK4v/oQRQBrr10l8yBb05F4WBvgENfXIslMZqcXyFGOg3dCJag=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 10:23:34 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e%6]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 10:23:34 +0000
Subject: Re: [PATCH v1 04/11] mm/memremap: add ZONE_DEVICE support for
 compound pages
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-5-joao.m.martins@oracle.com>
 <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
 <cd1c9849-8660-dbdc-718a-aa4ba5d48c01@oracle.com>
 <CAPcyv4jG8+S6xJyp=1S2=dpit0Hs2+HgGwpWeRROCRuJnQYAxQ@mail.gmail.com>
 <87zgx85ltc.fsf@linux.ibm.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <31563092-a7b8-e6e1-f5ad-a66c02243a9d@oracle.com>
Date: Thu, 6 May 2021 11:23:25 +0100
In-Reply-To: <87zgx85ltc.fsf@linux.ibm.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0365.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::10) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0365.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18e::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 10:23:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2beb1a6-7271-4a4a-8951-08d9107900c5
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<SJ0PR10MB4512A47EEA2058E92395C761BB589@SJ0PR10MB4512.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5AWtkSc2xKRZbjhrk38oE5Ofkd0rox04rmWwne1TvzcjQC1dxJbmu37sDozeWsJm7TjrbUfafVcIn759CvjTeSRVLK5ZXDZ93ncZpylSGA7ZsgMY19QGXGTPtkvDu/fOLuVUvKNWwwP5OBSR9ap3ZhwTrmXa6i/HE+b5e19f8koQnRrZmn0HN3Ujz+VPff9giU4ZQMwwbql/PtqjppBp1kV83SZbGJA0q5r49fPnEm4TNmjcbLHtYTg3XEnwmj3y3Iz4PmA70D/E0V4bqy3O0v5ADuizeRNkVznCGTjx5bY1oHb9LZQ6A9ew05rVapZPCB2uYz7YogCZl6ah8Y1xmw8MAZ/rjYwiXBMX6EGKmJZfrq5kMd7vJ9U2Aw2XEkCMNhT5oz96GDPtTUNOV89kmNdCfZEBor6Zuf3Xwr3BhrKq/33prcS9QpeRD9o3GiIdOHgaXx+yq4k4s9//s0Yo6DOp8KFyrEpRgkumbBB/AYOXA0tic7XjhEelZsmRSV5bMDTZHM5PxNZh+sgpKF7BmjHj5h4UrDwrhO472hg4mIA6jN5hHU0iEBgGNhiCE684/hrvw4TOoklm3uDjCoxM9SI3JLa+WvhvYY/DVNEKZlroJtzvFAGhheIPQWEc//kQTolJgjw0OQB1s30oIZSKzsEAEVKOMh091Z8xGxQVywI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(39860400002)(346002)(6666004)(54906003)(16576012)(316002)(66476007)(31686004)(38100700002)(53546011)(6486002)(66556008)(478600001)(16526019)(110136005)(956004)(4326008)(36756003)(2616005)(186003)(2906002)(66946007)(26005)(5660300002)(31696002)(8676002)(83380400001)(8936002)(86362001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?ZWNWUG1YYWh1a1gwQVo1amxiZi90ZXU3bCtpaTFBNkUwVGJyR0xQc1ZqY1cx?=
 =?utf-8?B?SkN5bUZKRVNHMFRTMzB6QmNTOGw1ZURWQXV5NVFXZ3pOSVBoZjBSSksyOG1a?=
 =?utf-8?B?b2cremw4WnVnMDMxcFZaZkFRQ3BGNUF0S1NmalBlblduRWZ6MEM0b2RHc0Za?=
 =?utf-8?B?TnV5dVEzRzhjU1FlbW9jbnJ6Uk9YUGZjYXVWcVJKeXcvNHl6d2M2dUsvQ1dT?=
 =?utf-8?B?eHpkSFZ3TC9BS0VDc0ZJdWw3alh3RnNXWHMzZWF2RmVqNnFhanI4aUVZVzdP?=
 =?utf-8?B?N2hjK2NGS2JJTU1Cay9kcTVtaE1HbXRHeCtOMlRhU1JxM3JHcXJWVVBmaVRZ?=
 =?utf-8?B?Q3ZValU2ZFdnU2FVOTd2ajBxUk1OTkREc2k0cWFkWFdIOXFxZGhqVW1SN1Rj?=
 =?utf-8?B?WGNPeGlXRi9RT29LRnZIZVJqb1VUM01MOVFaeERmb25VakI3M2ovcGZ0TE9x?=
 =?utf-8?B?UTVzOGd1NTN4dnNQNituTEw0Nmt6NStrdVNSR25ZbGlvNGVyWng4NmZ6K2xE?=
 =?utf-8?B?WEphQUhFZ1V6UCtWMWhFRG1nSXo0NisyWDAvbzgxY2tsOGVhV2E5MGRacmpN?=
 =?utf-8?B?c085UHlVbDR5MWRlWkVaM3pEQmlGRzhyRkxzV05rck0zWWlHK0xjZDNHZ0Js?=
 =?utf-8?B?WldaTFlWK2JjcW9MSEhleEV6eW5keE4wbjdYL0krcVB6NUR2RXNuZU1XNXgv?=
 =?utf-8?B?VWZDNnlnWUNsSlZHT0UzVjFzb3NZUytMZEhpTXZQdXZJT2R6bnVPN2Y4OXZ1?=
 =?utf-8?B?NXVja0R3RHZXWWx3QndiUVZEazk4K0UxVHpqU3J6eDJOenlqWjN6QzZhNXRO?=
 =?utf-8?B?dUZpblZXckVKeForc0svM2Vha1gya2VoNzNEMXBJeEl0VzhzUC9NT2xaOVFr?=
 =?utf-8?B?aTdnS2VKSkJvQ1d0TEllZ3gvOXcxeEFyV2R3LzdqakdVZ3FkZ1g4Z0hMTCti?=
 =?utf-8?B?cTBkZjhJK25wYlJ3L3Z0bU1QU3FqczlDM05LNlZ5clVOSWdOdTA0WnQ2azJ0?=
 =?utf-8?B?emNoMVhkUnMvZlc0QkVrejdpK1Jtb2k5ZHRsNzFmYjNzYzJqTTJJSERaN1dY?=
 =?utf-8?B?cXlNR1JpNFF2VG56TURkS3BLREUrQUlPOGI4WU04bWtNN3ExaUExZ3RGTWZP?=
 =?utf-8?B?Y3hYdDlNZ2I1aDBCYy8vMTlTRkIvLzU5VXRpMEdXMTJPckdrT2twdUFEdkVV?=
 =?utf-8?B?MUpzSDc3RG9icFVVMSsyTk1CVFRUNFFPdFpMZm45eHhNdVlCRlJKYnVWSkVM?=
 =?utf-8?B?MnZtSDhZOG43TjJZZGVEaVo2bnR6MmtscHFzbVpvT2tyUzVpNVRaUWwzdDFO?=
 =?utf-8?B?blhCSHEwc2h4OTkvemdmUGRxTVM4SXYrWWFHbFZJV29RMlRpYjg1VUlqblNX?=
 =?utf-8?B?S1BVbUluQ3VTUXI3TW10RGRWMTlaa3orbWxtU2VEWjIvbGN3eVA4N2FZd3Vk?=
 =?utf-8?B?NHRZMi8zLytoOTFiNHd1eHd4emhWR1ZKa3cwSFdvUDlUM3padFpIUzJaM3ZE?=
 =?utf-8?B?eGdjQ2dzMDFrUzREb2wrTjlLR3FPMWJ5emNlRHlpekhpYnNxdVlOam5zcjFn?=
 =?utf-8?B?MXdIWHc5TU5FMG9Xa0VURytvc2RMMFlqOXk4N1gwN0ljeDBwK3BZaFFpNDI0?=
 =?utf-8?B?aFpQd2VWRFFhUkFOYXZQWkVkc09TL1RuVld3eGpwc1NPTTM0SUhzdXNPYmU2?=
 =?utf-8?B?NjNJN2tjV05OYitRV0IzZTdYUUU1N0pBb3V4TlhnNVg2aUpSZkRXQmc1SWF6?=
 =?utf-8?Q?7CVpYVlzueWHzWDy3016ygD+PjrOSQrc3ABsjqR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2beb1a6-7271-4a4a-8951-08d9107900c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 10:23:34.1617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7BUTaCEyeg9cna1dgKPzFmbYOK46H9dnhC34m9jJ4pBd7gtwWS7FeSelVNzKzCdG5x4nWnwEavbPxIKRe2sClAZSSS9/Vti1scB0w+D5yM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060071
X-Proofpoint-GUID: wx64jQU39fd05VlE2HM5bF1p4vw-eRoI
X-Proofpoint-ORIG-GUID: wx64jQU39fd05VlE2HM5bF1p4vw-eRoI
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060071
Message-ID-Hash: 43VY3NDULM5UXJZKZ2WYDRELOW3XTSKC
X-Message-ID-Hash: 43VY3NDULM5UXJZKZ2WYDRELOW3XTSKC
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/43VY3NDULM5UXJZKZ2WYDRELOW3XTSKC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 5/6/21 9:05 AM, Aneesh Kumar K.V wrote:
> 
> 
> IIUC this series is about devdax namespace with aligh of 1G or 2M where we can
> save the vmmemap space by not allocating memory for tail struct pages? 
> 
Right.

It reuses base pages across the vmemmap, but for the base pages containing
only the tail struct pages.

> Dan Williams <dan.j.williams@intel.com> writes:
> 
>>> enum:
>>>>
>>>> enum devmap_geometry {
>>>>     DEVMAP_PTE,
>>>>     DEVMAP_PMD,
>>>>     DEVMAP_PUD,
>>>> }
>>>>
>>> I suppose a converter between devmap_geometry and page_size would be needed too? And maybe
>>> the whole dax/nvdimm align values change meanwhile (as a followup improvement)?
>>
>> I think it is ok for dax/nvdimm to continue to maintain their align
>> value because it should be ok to have 4MB align if the device really
>> wanted. However, when it goes to map that alignment with
>> memremap_pages() it can pick a mode. For example, it's already the
>> case that dax->align == 1GB is mapped with DEVMAP_PTE today, so
>> they're already separate concepts that can stay separate.
> 
> devdax namespace with align of 1G implies we expect to map them with 1G
> pte entries? I didn't follow when you say we map them today with
> DEVMAP_PTE entries.
> 
This sort of confusion is largelly why Dan is suggesting a @geometry for naming rather
than @align (which traditionally refers to page tables entry sizes in pagemap-related stuff).

DEVMAP_{PTE,PMD,PUD} refers to the representation of metadata in base pages (DEVMAP_PTE),
compound pages of PMD order (DEVMAP_PMD) or compound pages of PUD order (DEVMAP_PUD).

So, today:

* namespaces with align of 1G would use *struct pages of order-0* (DEVMAP_PTE) backed with
PMD entries in the direct map.
* namespaces with align of 2M would use *struct pages of order-0* (DEVMAP_PTE) backed with
PMD entries in the direct map.

After this series:

* namespaces with align of 1G would use *compound struct pages of order-30* (DEVMAP_PUD)
backed with PMD entries in the direct map.
* namespaces with align of 1G would use *compound struct pages of order-21* (DEVMAP_PMD)
backed with PTE entries in the direct map.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
