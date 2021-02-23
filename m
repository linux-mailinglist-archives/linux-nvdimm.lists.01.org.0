Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A31F1322F69
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Feb 2021 18:15:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B983100EB340;
	Tue, 23 Feb 2021 09:15:36 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 59597100EB33F
	for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 09:15:33 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NHAYQs126394;
	Tue, 23 Feb 2021 17:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mQznguCfYmtIHJkgB6hjxAimopF1tIyEkr25AN3HXMU=;
 b=zAVm+v1o7gAFCgAmI00nHfdD4WdlMUC0qtX2Sm6FP4Wp/sEy7wG7+ZvK+RCrgeegBego
 m2rF9njaCCze420qRQ/c5y4LVb3m8QeWIbZPRZ1KDH0PlcPufcOZRQPfu/VmHPLHtUtl
 iz3Q6MxF35+8PLFpDp0rHLG9E6dPsP/xo8J9a56xnuSUKOh5iM8+O7zSrpGO9qJJ3mb4
 F/CdrbIZEhlnAWIAy9CqWHGqGXYUQpI9A9qXd9dx8aaRgG1nlBnTsa/bY437lOD045G7
 1+gc0YYx4owrdfeL0yFK/cLl8sIeYBbTpyvk4LOPNNB/xZ8nau2Ld+KfXvY539frOxbr /Q==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2120.oracle.com with ESMTP id 36ugq3f1n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Feb 2021 17:15:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NHAV6Y088185;
	Tue, 23 Feb 2021 17:15:15 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
	by userp3030.oracle.com with ESMTP id 36ucbxrt6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Feb 2021 17:15:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEcozxQY+hvlP30N7E+3X6BYTTuxaF/Q7YMhBqFSlaKVEubzq4j4ZyPKkFWbpoukhpaUG4hv/SL5lYqQEgz9PN48htglt/KvSsT0Z5ZKtX/dd2GYNqjvKGn3jyIN3f5af+BNJNXNBKym/IjDtPSBWW6tvU/YDaatAUNpVZXBjiIgPBu2tSvcbwsa5i0O2eqQQq6x0B1JODmnSqqU8P6BPRPWeQmj6DIc0JCCIAq6hGtWzMPfLRCw5fBk8cQWgyyyTZPa1jvg/rh1+8TIzaUt58+GgR+xVY4Q85b4xHTzf7JFXmgdF4jOQHFGbqokCSA+wbpDnzgCDjZyc2rZJHcEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQznguCfYmtIHJkgB6hjxAimopF1tIyEkr25AN3HXMU=;
 b=nWuEU93SN4ciwVpIdDl8NYd9o13Alold3f4H2WmTNfwPic2WlLJ9yT1PUnk1OhjiYKXmCB/+XUNy80ps86A1ZOmL0ptGP4toNBc+CaFIsM82oSDOS1xHcc6+8tE16QoIpb1JEVH2rdOnlpo1w8J4ZLXgqBWx5l4/QaEub8oDLNqZxK16csJEvzdaj6hFEq5YLjXYSV5ZPWGvoGcCyUZNKr7BMut69/zEK2a5i+E4HdlWAoLC6rWeeXAEZP6uZBCCt1pL/LJ29K+lA9ibZEVhJV/huYs0PqHTk36hA7u8n8+hZmacBXBnXdi3xaMpQt5UctjZXXVmw+kaF9ng6s5ADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQznguCfYmtIHJkgB6hjxAimopF1tIyEkr25AN3HXMU=;
 b=HfTcT3D9zZKoAlF6ISs925l1ApEBKylj+xPy66wHaO2tTq0BZ8X+Z/nn9CW/AYj1uYUuWCd8eG8sXLj/L1ty4i5GcDSBfeNha+K9A0KKjaKwezv4/hsfCjTcfqBbvvtmS7AlF802kkSCVcfgQG1845YGSxBVlPqGh1y2eZsIAmE=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4671.namprd10.prod.outlook.com (2603:10b6:a03:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Tue, 23 Feb
 2021 17:15:13 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 17:15:13 +0000
Subject: Re: [PATCH RFC 0/9] mm, sparse-vmemmap: Introduce compound pagemaps
To: Dan Williams <dan.j.williams@intel.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <CAPcyv4gQQ03-nhBNwLK6KDc953SVD1rOs7HFBo_Mu9LFTkXRgw@mail.gmail.com>
 <6a18179e-65f7-367d-89a9-d5162f10fef0@oracle.com>
 <CAPcyv4joomjhZYaCBNrYjvATSYgECfHYOZy=n_QVKqX7D_ReZQ@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <1cf0adb0-9692-bcb2-4d3d-374ba3164994@oracle.com>
Date: Tue, 23 Feb 2021 17:15:04 +0000
In-Reply-To: <CAPcyv4joomjhZYaCBNrYjvATSYgECfHYOZy=n_QVKqX7D_ReZQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0408.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::36) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO2P265CA0408.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:f::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31 via Frontend Transport; Tue, 23 Feb 2021 17:15:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb4b6614-0576-46f1-5364-08d8d81e94a2
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4671:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<SJ0PR10MB467167D3F55B2459C722A389BB809@SJ0PR10MB4671.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	M2y7Pjbn7AhzTpk7MAgnOYH/WCyUTgZlXq7UQxdXlVf0Ipl9XThDF1SfypJgQfa5CMwEYFq6WFG4FO+y0jKqK+06gpT2JCZU9kRERg/rGvqUeEB/B4qr9CNqciyNS/6IOMjSoys2+4qz8cZJUqmY6FJYhgqoGtefsVtDR34K1DQ/ViXq8pedemOdygkhMH2xOS29DsdvhfnPf0efAH8QTMG49tTVLGrTnpoWlWpteBCj3B4Radn9yfLsBQcXzDFOpRzxqq/TCJeMKwls9mjZPvxrAKOe+wO/Kt0nFR9lkxQfcctTTPn7ZfGMw/dwEKN1fmBC/iC1yoHDZ2HEs5x+GVrbg6BehDDPZBJiifzET0fk7fP2Kc7A60vWeXV628aNhWDj7EoS/JRUiMa/61FNzixhyeG/RNYJWENr41vD0mQKtLkgTtPCNIj8fr+6nXh/Bi0O4YCrfWPpfQ2cuZgo79Xc/EbjAt90acq0e1X4GqkP9eHYLggKL8zlA60SrKKg30q4FM4rp+vLu/pWMz/4OiVlhdAHZGljTXln9zYM77GSiO9DU5okJ3/BgqjFnGTyl99pzj5no2RISE6aC6XsYg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(366004)(346002)(36756003)(54906003)(83380400001)(2906002)(53546011)(186003)(16526019)(26005)(5660300002)(6666004)(31696002)(66476007)(956004)(478600001)(4326008)(8676002)(86362001)(6916009)(8936002)(16576012)(316002)(66946007)(2616005)(66556008)(31686004)(6486002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?b3NIY25uR29oeVduYk1lOHJlZUZDUTNJWU00V0Uza05jTkdqZ1A2YkdZMXNy?=
 =?utf-8?B?cWs0S25JWkV4WTQ5aVlDanpYMHdzYVlBUnh0WkxueWZQZ0pWRkhEaFg2OWtR?=
 =?utf-8?B?clI5YWZjMmpWak9yU1I3bGJHTUxnVTBhVlo4b1kyM2oxUE5tWUZ6cmhnN0Jt?=
 =?utf-8?B?djdkOVZyR1NkNGhsbmJTNWhib0ZPaCtzcUpZNG54K2o3aUxSYW4xcVNnckU5?=
 =?utf-8?B?QmdYM0hNeGE4Uk5CRll1eHVTaWFvNTZJSlBEOTZDSUQ3b2REUjJaRldURllx?=
 =?utf-8?B?ZlQzUmdkbGFkbEpnb3JmMjhSYm1nbXFXQTZ5bG14L3kvVHVBdWxZTWNqK3NR?=
 =?utf-8?B?OHpxdjMwbmY5UjNnR2ZENTdIek9BZ214SWtjRmNQZ2tmaDUrQTdLaUJSWXNy?=
 =?utf-8?B?Mm81azRFZ1RWKytzUWI5NXJjYnM1UHZkaWQ1Um5QWkYzOXdmMlJTRVU3M01B?=
 =?utf-8?B?UDBMUDFrSnU3RDZaZmpEQlRESFVONCtYeFo5YVJ4RXhUd3I4OW00WmkrVDhZ?=
 =?utf-8?B?a1VrVHBKclNEdjRFVDUwbVRTTmJHV1VaUXY0WW5ibjMwVFdOaFdybStTRExw?=
 =?utf-8?B?MGtlMlFQTE1JZzA5cDZIS1JrZk00OHdDU1ZWOGFiZk5qSStpL0xNbUV0UEt4?=
 =?utf-8?B?T1I0OXN1VWNhZG9JSy9FWkJpMGFHS3ZSeFo5YUpDNGVMWXJqc204QkRYeStF?=
 =?utf-8?B?YVIxOW05WDc0QjBCNFU0dnJvY3RZODlnV3lzSzQ5UDVjanVxV1FhenpUaCtG?=
 =?utf-8?B?Q0pEWjJTVGZHYVk0T1VmY2tPemk4RlhnNTlRb3BudnFkelRYWS81SjgraUdy?=
 =?utf-8?B?YjgrYzlEQzhzVGt1KzhVZzBWaGlFbGtVd0R5WlNQUVBWWS9HUlRiY1F6UVFk?=
 =?utf-8?B?c25YV2VRRDFDYkxONG9UT29VN1B6Z2tPUUtyUCsxWkM1blhSbXJNOVRWL0NY?=
 =?utf-8?B?eGk2bUtiRzR1MXJIbER2a201aHUyT3lsazdOSUE5ak05TldvS01kcEhGZExQ?=
 =?utf-8?B?QkdsMjdQTEhUMUp2b1ZrdFN5MTF1d21pOUllZUZCeG8vWS8rSk5UWDVSZUVl?=
 =?utf-8?B?VW9vNmdtMzhMcDVpSnRHOTBwZmE5MmI4UE03dE8xa0EvWlkyR0FTYVYrN0w4?=
 =?utf-8?B?Ym1xWHNMbWxldGZvaGhaZTM2YVJVRno1eklMa2JNdzNteHBnWnIyRXRMb3BI?=
 =?utf-8?B?ekNTTldjcjRSQUUzNitHRnBTaEFiK1ZVQTFXNnFack0vMGc3QXRlQnRzbW41?=
 =?utf-8?B?L3cvMDBVQVBXOXlBWndKbmZjTytycjd4dFI5RHlsS3VsZE5EZndTUS9lM2I2?=
 =?utf-8?B?V3pLK3Z0MnJpT1E1S3pHdmtuSmJYSDNXRy9DOFF1a1NDb3lFY1ZEbkFZaldk?=
 =?utf-8?B?Y2RSWDRZc0p0eXQyWU56MHNiYVFYTXo0TDZCRTBEM0ZGa1d2VlU1cDFNcHQ3?=
 =?utf-8?B?YWFvK3VacUNrUytYNXlUV2dyWDJ1anNJYjJlVHR5RDNZQjdQRzlFSVlwUkdF?=
 =?utf-8?B?Y1hXUnZUaWxEYkQyZVFLYm5zRlg4a3NqOFlGNnNwTTZOU0c4NnhQaHZ0dm9C?=
 =?utf-8?B?bmZ5Rk1jQWJ4VFlmQjZjR0dtaEZmQ2dtajRPOHpjeTB4b2JTa1JWbzZyVnIy?=
 =?utf-8?B?ejF2UUkvbUdvTFIwOHEyd3lUcllnN0lDektYd3F2VXo4VTI1T3BYajUvWTFO?=
 =?utf-8?B?cEZQdThPcUZKTG0vMVpPaDRYTUlIRVR3TmlwNDU0MFV4b0dXOUZ6T1hDeStp?=
 =?utf-8?Q?yDVn0ueG8+JCpS+3YwdJLdsINiyQldn1SvAGuuI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4b6614-0576-46f1-5364-08d8d81e94a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 17:15:12.9158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klm4DjNamu9wuiesdiMoOjLBs+c4SAfxj/TyQ9CgC3ej4T4ZCUPyAZsZWmMBZmxDOq1V43u0/de8ox1mgCcp1gl1od3uMd9ohpUhG5zYyeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4671
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230143
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230143
Message-ID-Hash: XQXHYJAFGR2M5OS3CRIIKS6CA753MUFQ
X-Message-ID-Hash: XQXHYJAFGR2M5OS3CRIIKS6CA753MUFQ
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XQXHYJAFGR2M5OS3CRIIKS6CA753MUFQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/23/21 4:44 PM, Dan Williams wrote:
> On Tue, Feb 23, 2021 at 8:30 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> On 2/20/21 1:18 AM, Dan Williams wrote:
>>> On Tue, Dec 8, 2020 at 9:32 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>>> Patch 6 - 8: Optimize grabbing/release a page refcount changes given that we
>>>> are working with compound pages i.e. we do 1 increment/decrement to the head
>>>> page for a given set of N subpages compared as opposed to N individual writes.
>>>> {get,pin}_user_pages_fast() for zone_device with compound pagemap consequently
>>>> improves considerably, and unpin_user_pages() improves as well when passed a
>>>> set of consecutive pages:
>>>>
>>>>                                            before          after
>>>>     (get_user_pages_fast 1G;2M page size) ~75k  us -> ~3.2k ; ~5.2k us
>>>>     (pin_user_pages_fast 1G;2M page size) ~125k us -> ~3.4k ; ~5.5k us
>>>
>>> Compelling!
>>>
>>
>> BTW is there any reason why we don't support pin_user_pages_fast() with FOLL_LONGTERM for
>> device-dax?
>>
> 
> Good catch.
> 
> Must have been an oversight of the conversion. FOLL_LONGTERM collides
> with filesystem operations, but not device-dax. 

hmmmm, fwiw, it was unilaterally disabled for any devmap pmd/pud in commit 7af75561e171
("mm/gup: add FOLL_LONGTERM capability to GUP fast") and I must only assume that
by "DAX pages" the submitter was only referring to fs-dax pages.

> In fact that's the
> motivation for device-dax in the first instance, no need to coordinate
> runtime physical address layout changes because the device is
> statically allocated.
> 
/me nods

>> Looking at the history, I understand that fsdax can't support it atm, but I am not sure
>> that the same holds for device-dax. I have this small chunk (see below the scissors mark)
>> which relaxes this for a pgmap of type MEMORY_DEVICE_GENERIC, albeit not sure if there is
>> a fundamental issue for the other types that makes this an unwelcoming change.
>>
>>         Joao
>>
>> --------------------->8---------------------
>>
>> Subject: [PATCH] mm/gup: allow FOLL_LONGTERM pin-fast for
>>  MEMORY_DEVICE_GENERIC
>>
>> The downside would be one extra lookup in dev_pagemap tree
>> for other pgmap->types (P2P, FSDAX, PRIVATE). But just one
>> per gup-fast() call.
> 
> I'd guess a dev_pagemap lookup is faster than a get_user_pages slow
> path. It should be measurable that this change is at least as fast or
> faster than falling back to the slow path, but it would be good to
> measure.
> 
But with the changes I am/will-be making I hope gup-fast and gup-slow
will be as fast (for present pmd/puds ofc, as the fault makes it slower).

I'll formally submit below patch, once I ran over the numbers.

> Code changes look good to me.
> 
Cool! Will add in the suggested change below.

>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  include/linux/mm.h |  5 +++++
>>  mm/gup.c           | 24 +++++++++++++-----------
>>  2 files changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 32f0c3986d4f..c89a049bbd7a 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1171,6 +1171,11 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
>>                 page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
>>  }
>>
>> +static inline bool devmap_longterm_available(const struct dev_pagemap *pgmap)
>> +{
> 
> I'd call this devmap_can_longterm().
> 
Ack.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
