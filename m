Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1AF321549
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 12:42:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C0598100EBB9E;
	Mon, 22 Feb 2021 03:42:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4499C100EBB7C
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 03:42:46 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MBcv80122573;
	Mon, 22 Feb 2021 11:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9Tm3sEeiCdPLGBUqQfqYQRRadqpCGBNc2ad/7R8T900=;
 b=wvx+2nLrHpPUrr2hqlipwOACE8UbeD1D6t45pjqlsFbSOvOUviOYyrLaE1wM464oOFdB
 F5GFfeEoAmkVwtRErghB5RZG6aTAZfpUra2LL+UvuYcVHSDjp3KFukaTziAAGpWZkMOM
 HUzd9LttUSn9XChUk306i2RHd1/MJYuWM17+UZy0jyVxwWP9fdEl37cicfroZmqwtGtC
 iVdUofsUdhyEm1klqd6h14Wubu6mT2Upw4DuKGZq5MomtXSHbZL8mSWY31LIV+mw2/wq
 A6WMWcvkg8BxUOaD18Xt0qJAuNjKcTWQ9SIJfLUZPE8k1Es3ReCEQos/EorFeul8erU9 0w==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2130.oracle.com with ESMTP id 36tqxbberc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 11:42:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MBeG5w073496;
	Mon, 22 Feb 2021 11:42:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by aserp3030.oracle.com with ESMTP id 36v9m354ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 11:42:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PThlc2pCb1AF//dwCB4qfdZqp5+OAAZ1hAFoJMgQlpEgDsFzVrFgLKPGL8lXqpJAcwnF1j4gchfWDTwdMbBQQ4IC32BISea+1JWaYn2g9mfcL82c6AT1FUx6W1PA/rxOk1+unp44nrLaHXGDoUkUVFiXj23OFmJm+FG22w1at6VSBO7Rn+3MK5KeRdWbrL6KMK6jmdY9THr2s1Mxra+QtEgg8QsiJN7CAX0+Tu+21An6gPdQzu0OBZ6OU6FBiffLBjXG03B0aSx6hSmmX6YhQkdZdLg6mKDgib6A3ibGxoS3qd5CCDeLBrpt4+pr/beC00QRjlqwm2dr0pCw3ENGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Tm3sEeiCdPLGBUqQfqYQRRadqpCGBNc2ad/7R8T900=;
 b=DJy3hGLZXMJRmeU4M9tIJnAwqkaWhmg4ji0ykJCh5Ip+99oI8b3DF+2paggXblwJUWuRgZVFDI03cJ21z6GJ3YFoaaRnU5ICGuSO04SgheEnbQlMy/wzlYFYR0RZXJcQIlweROEsXKTbs23shSNFdFRNQZNCsGhPDTqa+PTDaLITmm0dNKpjvOl8Y03KjrqKqe6cj2aE5fmPcg3Ok7/CgZEZ22yB7twLjqNaKIbaEnG3MAz1na1KykPnGrMRMJ/Td6mpC5gXyAIpiuJIVy7s5eerV5xlzgLxY6dOhui/QCs3aNjumf2EKSBKv5LaqwXhC0R80BaY9TsR/IpW7QqH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Tm3sEeiCdPLGBUqQfqYQRRadqpCGBNc2ad/7R8T900=;
 b=i6o0cK8uZrfxgfKAMKXNsRzJTLylsKDhs+aAFjsfuiX4pHdhUPyk3hc0w7sLqo/jjF5iQwj4fxa+D0ApRJvlQHUepTUnsIXFv05rPwV85Iaw4ef+VUty/j1RoDjRGrjzXFmvOIY/WlW74VNetPyj16La7zRzHwq0y13tTOvMkm0=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB4114.namprd10.prod.outlook.com (2603:10b6:a03:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Mon, 22 Feb
 2021 11:42:35 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 11:42:35 +0000
Subject: Re: [PATCH RFC 3/9] sparse-vmemmap: Reuse vmemmap areas for a given
 page size
To: Dan Williams <dan.j.williams@intel.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-5-joao.m.martins@oracle.com>
 <CAPcyv4ixD6_KEpuXkpeH6JNLvoahch8rm8J55o1B97ghrtcbjQ@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <621ff98b-cb75-e4d7-8f09-882cb2b984d2@oracle.com>
Date: Mon, 22 Feb 2021 11:42:28 +0000
In-Reply-To: <CAPcyv4ixD6_KEpuXkpeH6JNLvoahch8rm8J55o1B97ghrtcbjQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0302.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::26) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO2P265CA0302.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a5::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31 via Frontend Transport; Mon, 22 Feb 2021 11:42:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e4c9249-9774-438f-53fe-08d8d726f2d7
X-MS-TrafficTypeDiagnostic: BY5PR10MB4114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB41144F447739B97D91094BFABB819@BY5PR10MB4114.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hwzjFjfj/yE12WQ5iTuna6nh5guxhcZAjtjyiQo5HZ7QvY8upD3VwZ2SFAuuJvWjn3Vn8pWHopdgFSrMN9h7tBQAymzPzn7PL2l4Zdhq0+5gBy/yxlDzsSlcOaY3OymnqYlrnOHaTyS/5Z5PThgWKAChI/2ZvqVprQ3xvCLDX1d7AAXYSLOFtmQ9fAQWd6iQabqFhQQR+94p3Lwx0ug65ZLEhMgBXXZ5g583dCdE+PszgvYLpFDWVoOjqjpti5upDlZTl5/sQ2Nut9mH29qKmVTBqrorFklhP9OXi2RlAu6DyBMWYJW1WKO+fX5Zy0ufLMOm1L/K3LiCpyBEKLX6JQmHjUeUeTBQ60DwjCELgakUdoAyY6uItqzrL3F+8rCxgRkqZ+Oka03le7oZpypGsgBosFoo4FUtNTFQQlGuaYipdbI69mSiJm2VONKAgK3kvotrf8i/2OJhcDgziaXgHl9pliE0Io5MIlRUFoN9oWOf/OTxpRj9mI+EW4vsKyAly44aBjAwcaFmHjmwnEkXTz9lWKb3cJmJkHIcNjB0aFlXZE62HquUMMsTO44P9gmqCkx8dshBm37LuP6Nlhc/2A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(39860400002)(376002)(316002)(16526019)(26005)(186003)(16576012)(54906003)(5660300002)(8936002)(8676002)(4326008)(6486002)(2906002)(6916009)(956004)(478600001)(36756003)(66476007)(2616005)(6666004)(66946007)(31686004)(86362001)(53546011)(83380400001)(31696002)(66556008)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?dm16Y1ZTL2F1Wng0WmpXM2p5QVJjc0RYTzVBUUFveGNJcXl6YjVvWWZZZ0Fy?=
 =?utf-8?B?VG5DRGtaanVMRnFFYzdlWE03UjZudi85N1Y0UnhGSmVCKzgwM3NNR250UldH?=
 =?utf-8?B?STJBMkdyWWc5eU5sS2xRY2QvdGlreTJiOHpaQlAyZmZVQUs4RXVzbWorM2dJ?=
 =?utf-8?B?ckVXQ09yb1hCb2JReUFTc2s2Q04ydEZ1aUFSZG5kRzB0ZFlOcGIvUmhNOEo3?=
 =?utf-8?B?cHIxV0IvWkFmcDV3UWZ2YVlMNlFDdEhkbS8rcjgzV3ZqZzdtdWpmNVNMeFlr?=
 =?utf-8?B?Yk04ei9vTklCbk9BeE8ydFd3elYxOU1RQ05kMGFwTm9YcEo2WFg4NSsrVzN1?=
 =?utf-8?B?MkhZYy82dTVINVFMaWZWeEdNUnVEcWFVY2Rnejlac3ptTjVqTWYvbzdVcURs?=
 =?utf-8?B?VjlTSHNsWHNKRFpqNlo5a0p0VCs5dE9tRUU3alBPV1VLU3FJWUQ2a2Nyd3dE?=
 =?utf-8?B?OE1iUmhlbXBhNkV3SzlmVkxUNmhqRERGUUViRVdHdEppVWFJRnlNL0lZVDAr?=
 =?utf-8?B?MW91QkFPeUNoRk95ZldzUUhJZkpGbmU0WGtZalV5NTRHRWVoN2Q0bTQwaHpa?=
 =?utf-8?B?YXUrM25TVkcwU2RtWnZBd2pIMnB5aldtKzdWZ25mT2dBRC9uZVdwQVJ0MnRO?=
 =?utf-8?B?dENycHdSbHl5VzJNWWNqcXJ3KzQ0VVVNVFc0S2NzODU3b1R2SnBuazBwSjFF?=
 =?utf-8?B?RHhqdHM2SU5UVzVEWElteVBoTGU4eENlRXpuWG51YWtmTnRlZElkVXIzVTdj?=
 =?utf-8?B?UkQzOXY1OHRVckw1cFlJSUcwWkt3LzVrQm1NM3lyTGE5Y1hXRjBodlN6dU5n?=
 =?utf-8?B?YnMvNWRLY2pXUmlWZnBkVWlmYUJCTWNtTmpleWdlbGY1WjEvb3E1aXdmczZW?=
 =?utf-8?B?OW1udUR4Y2owOEpkdkpNMU9XVDZmMWg1d1hlZ0FzdjBVMDFCUFBsWmhNWVho?=
 =?utf-8?B?OE9DQWFtSk01T1FGcml3VjB1N3R2aGw3bXVCU2lUZTJiM01iZmRTSU5HdVhX?=
 =?utf-8?B?cnppZU85ZjZKUG1WcURGRG10MVc4MmdpbGNsSkxpc1hYSXJHT0NRRW9PNm43?=
 =?utf-8?B?eEVGYUNsU0F5Y2JpY0NJYUtVWUo5OCtvQmhhNGJ2ZVJmSi9rN1RXVXhoT1lD?=
 =?utf-8?B?QW5UQW1PcmczaTRlTVZNTlRXa3dpeWRTbVdzUHJua1h1T3Zid2xwSHpGcXNR?=
 =?utf-8?B?NTR3L0d0YmNqVUtVTTRHZ2NSenhoVkJtUU9qL01ENFBhV1lxdzFvdE9ZbDM1?=
 =?utf-8?B?THBlMlh0a3l5ZHUrdGl0V01HZkVhRXRIQWZSRnFoVi9iN25yZnN1NUJPSG44?=
 =?utf-8?B?ZHFRY21hVGp0VzdCenBnZDBoVGpiUHZYaDk4TUtaSXpJbUlqTEJwK2VVc1JD?=
 =?utf-8?B?QUVmUDk3ZVhiajNDQXNneXBpWG1HYWwzWE5BV3FGbm1La2pyZlBKc1MvZFVJ?=
 =?utf-8?B?dU9waS83c1hFbzJCT3NhQ1hLZE1NSlU3cVpqRUZYOVNReXhJbDlWMndFRFNm?=
 =?utf-8?B?cGFtV1pxMjZsVUVlNVEwTENCSnF3MUIwRnFvYzNqa2NJSEJwaFdCKzVoMGpD?=
 =?utf-8?B?Mm1PbHE2dUYrSkdSYS9oUGl3aTVoL3VGS2sxT1NTYkl1akp1dUVrdklmdy94?=
 =?utf-8?B?WnlqQ2tKR3pVZzM1NTRCUjR3MngrNGhnR1ZEbVE0QVIyRHg2TEE0ZlZjUXd1?=
 =?utf-8?B?bDBncFFqMXVNSm84SnFRdFhFSTJXTFFSbFppNEVkSCs0MzBDT1FGeFBzejZJ?=
 =?utf-8?Q?iW3p1gPquaEkS1TNm1O2Xsf9KmjqqeBXBjfoDU6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4c9249-9774-438f-53fe-08d8d726f2d7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 11:42:35.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5ZGNOjyR01rsTjCMN00rWs5GoIjN1BQkoFhIKLN6aGA2x8sMpebLTTJ9Jkz5Ai6ivLRePDczIWvoT0+EvP8/LUQ+HVnajdx+k/NKb8wAfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220109
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220109
Message-ID-Hash: D63BCHETYLV6BSZLBYGJYOYM33X6VATG
X-Message-ID-Hash: D63BCHETYLV6BSZLBYGJYOYM33X6VATG
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D63BCHETYLV6BSZLBYGJYOYM33X6VATG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 2/20/21 3:34 AM, Dan Williams wrote:
> On Tue, Dec 8, 2020 at 9:32 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> Introduce a new flag, MEMHP_REUSE_VMEMMAP, which signals that
>> struct pages are onlined with a given alignment, and should reuse the
>> tail pages vmemmap areas. On that circunstamce we reuse the PFN backing
> 
> s/On that circunstamce we reuse/Reuse/
> 
> Kills a "we" and switches to imperative tense. I noticed a couple
> other "we"s in the previous patches, but this crossed my threshold to
> make a comment.
> 
/me nods. Will fix.

>> only the tail pages subsections, while letting the head page PFN remain
>> different. This presumes that the backing page structs are compound
>> pages, such as the case for compound pagemaps (i.e. ZONE_DEVICE with
>> PGMAP_COMPOUND set)
>>
>> On 2M compound pagemaps, it lets us save 6 pages out of the 8 necessary
> 
> s/lets us save/saves/
> 
Will fix.

>> PFNs necessary
> 
> s/8 necessary PFNs necessary/8 PFNs necessary/

Will fix.

> 
>> to describe the subsection's 32K struct pages we are
>> onlining.
> 
> s/we are onlining/being mapped/
> 
> ...because ZONE_DEVICE pages are never "onlined".
> 
>> On a 1G compound pagemap it let us save 4096 pages.
> 
> s/lets us save/saves/
> 

Will fix both.

>>
>> Sections are 128M (or bigger/smaller),
> 
> Huh?
> 

Section size is arch-dependent if we are being hollistic.
On x86 it's 64M, 128M or 512M right?

 #ifdef CONFIG_X86_32
 # ifdef CONFIG_X86_PAE
 #  define SECTION_SIZE_BITS     29
 #  define MAX_PHYSMEM_BITS      36
 # else
 #  define SECTION_SIZE_BITS     26
 #  define MAX_PHYSMEM_BITS      32
 # endif
 #else /* CONFIG_X86_32 */
 # define SECTION_SIZE_BITS      27 /* matt - 128 is convenient right now */
 # define MAX_PHYSMEM_BITS       (pgtable_l5_enabled() ? 52 : 46)
 #endif

Also, me pointing about section sizes, is because a 1GB+ page vmemmap population will
cross sections in how sparsemem populates the vmemmap. And on that case we gotta reuse the
the PTE/PMD pages across multiple invocations of vmemmap_populate_basepages(). Either
that, or looking at the previous page PTE, but that might be ineficient.

>> @@ -229,38 +235,95 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
>>         for (; addr < end; addr += PAGE_SIZE) {
>>                 pgd = vmemmap_pgd_populate(addr, node);
>>                 if (!pgd)
>> -                       return -ENOMEM;
>> +                       return NULL;
>>                 p4d = vmemmap_p4d_populate(pgd, addr, node);
>>                 if (!p4d)
>> -                       return -ENOMEM;
>> +                       return NULL;
>>                 pud = vmemmap_pud_populate(p4d, addr, node);
>>                 if (!pud)
>> -                       return -ENOMEM;
>> +                       return NULL;
>>                 pmd = vmemmap_pmd_populate(pud, addr, node);
>>                 if (!pmd)
>> -                       return -ENOMEM;
>> -               pte = vmemmap_pte_populate(pmd, addr, node, altmap);
>> +                       return NULL;
>> +               pte = vmemmap_pte_populate(pmd, addr, node, altmap, block);
>>                 if (!pte)
>> -                       return -ENOMEM;
>> +                       return NULL;
>>                 vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
>>         }
>>
>> +       return __va(__pfn_to_phys(pte_pfn(*pte)));
>> +}
>> +
>> +int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
>> +                                        int node, struct vmem_altmap *altmap)
>> +{
>> +       if (!__vmemmap_populate_basepages(start, end, node, altmap, NULL))
>> +               return -ENOMEM;
>>         return 0;
>>  }
>>
>> +static struct page * __meminit vmemmap_populate_reuse(unsigned long start,
>> +                                       unsigned long end, int node,
>> +                                       struct vmem_context *ctx)
>> +{
>> +       unsigned long size, addr = start;
>> +       unsigned long psize = PHYS_PFN(ctx->align) * sizeof(struct page);
>> +
>> +       size = min(psize, end - start);
>> +
>> +       for (; addr < end; addr += size) {
>> +               unsigned long head = addr + PAGE_SIZE;
>> +               unsigned long tail = addr;
>> +               unsigned long last = addr + size;
>> +               void *area;
>> +
>> +               if (ctx->block_page &&
>> +                   IS_ALIGNED((addr - ctx->block_page), psize))
>> +                       ctx->block = NULL;
>> +
>> +               area  = ctx->block;
>> +               if (!area) {
>> +                       if (!__vmemmap_populate_basepages(addr, head, node,
>> +                                                         ctx->altmap, NULL))
>> +                               return NULL;
>> +
>> +                       tail = head + PAGE_SIZE;
>> +                       area = __vmemmap_populate_basepages(head, tail, node,
>> +                                                           ctx->altmap, NULL);
>> +                       if (!area)
>> +                               return NULL;
>> +
>> +                       ctx->block = area;
>> +                       ctx->block_page = addr;
>> +               }
>> +
>> +               if (!__vmemmap_populate_basepages(tail, last, node,
>> +                                                 ctx->altmap, area))
>> +                       return NULL;
>> +       }
> 
> I think that compound page accounting and combined altmap accounting
> makes this difficult to read, and I think the compound page case
> deserves it's own first class loop rather than reusing
> vmemmap_populate_basepages(). With the suggestion to drop altmap
> support I'd expect a vmmemap_populate_compound that takes a compound
> page size and goes the right think with respect to mapping all the
> tail pages to the same pfn.
> 
I can move this to a separate loop as suggested.

But to be able to map all tail pages in one call of vmemmap_populate_compound()
this might requires changes in sparsemem generic code that I am not so sure
they are warranted the added complexity. Otherwise I'll have to probably keep
this logic of @ctx to be able to pass the page to be reused (i.e. @block and
@block_page). That's actually the main reason that made me introduce
a struct vmem_context.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
