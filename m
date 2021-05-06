Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BC2375241
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 May 2021 12:24:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 48F2B100EB34D;
	Thu,  6 May 2021 03:24:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0D520100EB345
	for <linux-nvdimm@lists.01.org>; Thu,  6 May 2021 03:24:41 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146AISth113473;
	Thu, 6 May 2021 10:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MFNLwwuDedNy7yIyc3PQ2xJZwF14SqwhoKDGXmFuh8o=;
 b=k3Hi1ob8Ty2cFk4JP2b7fFSGyoh9o49+WLgg97MUglO+n9XSZHWSx46fGQgUiNY993hV
 QbkZHjKG3ZZX+6lJoMEfdUe5ay6xgWR0CciVSo5XHCJYdRK1/fJgumbbHGu9/Ebb4AkR
 +PufyuivDHD1ODtgYDHHq0eWkgRtu1IBgQyZ2ZzHSaHmtjA1hVnWIgOUqSEtX1LO4GFc
 Dg/r1AoWrCK/9KiRrRkbBz1grtmz8YL4sDxyrKG0qjejPC5RI6106uLEWBZjoLybZ+0r
 F1O3Za/r95AoPLZxl4bR8S98qDeQoeMU4GNInod/8qJ7jiexm3Ae3eOtfocvrdKjgU1P KQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 38bebc4he7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 10:24:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146ALVav003103;
	Thu, 6 May 2021 10:24:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by aserp3030.oracle.com with ESMTP id 38bewsj0xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 May 2021 10:24:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNW5auTDj+Lg4nh2F1B521vBejPkQ5RWbKZXjcnSPJrWaD9S8Ajdjv7dsSy9wsl+UnpzcZ0+M4jH0/zegbaiG9dgra/ozDB6DSULu3JurqoZSvCnsNSdRa8BRwhBa62YKuTHYlrj7MDx3G3fs6xonjb2kBBkboOoLBX5oOf3uGpwNfVR13mu7jJA3kLrZ8txALPBuuuxlkYHxerpIiD8nKPB3qejnGgUk8E7SYeWIJexoAS0y0ywQbtwSiHLHWFS+H9PcUaU1LJOrrdmbuY+ahh701znKqymMEzWC+TslWqty22+3/5VplKfupGF+3d4LD55MPrLCRDTby09TVjz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFNLwwuDedNy7yIyc3PQ2xJZwF14SqwhoKDGXmFuh8o=;
 b=VCru+WQ6Ti4eNF1ICV/Lum/KIMHeRoYKsM/wy4n/kxFC273btFZd6evkFFuFVw9SGMn5S0z+0r7A1bVfyT25gv365E3Wakl2fDFuCw9bTzxqkZpDGsFivwtTaTnNlKzdiPDzulHGmoayQMpdDYoKwgCI4YyhYXZu++1B97e580Qs/K9kB9VXAao0kgbA2p8G1hUVOIDfFg3RupLO1c2aVHeIUxYH4Yln5ZmbxfkmXTSyepA1Snr0NlgUUNvzBrf2Q/ocHBcwz831F2/oFkZZkLXpUF9I2y+uTRgAHJsseMPQ/5SbkfTYhsis/58g/GkbRfR5YU0kNLyx1cqdSbcgWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFNLwwuDedNy7yIyc3PQ2xJZwF14SqwhoKDGXmFuh8o=;
 b=sEeRU/k/TOHQ/VRnWDx9Xxa3T/r1ZX/O09qOLXXksesrHpEQ+RBEApjjUn00wBh3l8FaqWNyuvKGCODdNbwwj/v3mwIb/oP7McSi0E07tHP3C85DNrzKW7Rxz5nv6FB2/JYUwnKJUZ38yQxHm6DYnDAOWMZca0bFjRvyEsTADPc=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Thu, 6 May
 2021 10:24:30 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::fdc1:840e:3540:422e%6]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 10:24:30 +0000
Subject: Re: [PATCH v1 05/11] mm/sparse-vmemmap: add a pgmap argument to
 section activation
To: Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-6-joao.m.martins@oracle.com>
 <CAPcyv4iOh5wS04F=hftcwN1e3DJTg-qUhw8KHR=+wncqJ2KZsg@mail.gmail.com>
 <52195943-3344-ec9b-3c7f-1e6d415c390e@oracle.com>
 <CAPcyv4jReFgPABenyQvA34Oif_bFAVZS++O+waoQtg=WsC-9_g@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <753a2e01-8e17-7279-0f36-555606b6e487@oracle.com>
Date: Thu, 6 May 2021 11:24:22 +0100
In-Reply-To: <CAPcyv4jReFgPABenyQvA34Oif_bFAVZS++O+waoQtg=WsC-9_g@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0364.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::9) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0364.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18e::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 10:24:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b1dee5f-e6db-4cf7-dcf2-08d910792251
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB3735BCA6A722FB6E9AAA3E79BB589@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EkuSYR1AtSkyfSq1KTJ2RKiALQfVF/31blhG26qu809aCk2AiE9ZZuGGOaof+glMXSP2kdsrsZJplETCAFEApBGT5sfg+XSXyedNH9cutwwjLa6S7gUJIc/1tnP+W2dmrNxBHRn+hHFkzu7nt5W84y3j32OS+sUGcZ/FgLLNJqU9giugRwyu1MY/g+pE8PijatfpR0koVt/WLzPLS/7QwTo1MzReLiFYpZTE/qXfPj4b5thaLsVEy9Chk/nv9uj7H8bJY2v8u8GdTg/p5eESRyb2kx02oUbapH/lcKZMjeeGP/l9JIWiieTwMK1tgDCQ6vmiUm3WzmSvTqOlwSyalfrwIX/xcVJ0hfZNUzEdLEomztV872/bDfJGS4ZlEY5ad2HCuFvA4ZOq9J0GuErea9U7Y5Nkij4fGZY5NaiTZ1eZWmb3Zy9JRQWYdAl33sMuPzX+PsUoZiuyI71/bhrHnRMRWDr0db3M62dY/X82O2X0Ps/rrIViLL4dSJskWi47pRMD/mzDjb/4VmM45qWkPd+TfHoBTvnYfelETMz9JocZ5WByqyVhS25Hu2LJAElMyVSIQEsFFfASg57Nn8y/PyN68F8Nkl7p7IzbGxX2PvTb6YbAAn02w479l12QyDR7vB101ziFZSNNMr7V2FMGY9yOLGhPKeqm+MYECk4YIdw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(376002)(136003)(346002)(16576012)(86362001)(54906003)(8936002)(4326008)(478600001)(66556008)(66946007)(53546011)(83380400001)(31696002)(36756003)(8676002)(316002)(66476007)(5660300002)(6486002)(38100700002)(6916009)(2906002)(31686004)(16526019)(26005)(956004)(2616005)(186003)(6666004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?b1Q0azZtYldqZWpDNG9nQld2Y2xrcXdYN3pYcWhKQ0ZKNS9yQllNcVpuWnUx?=
 =?utf-8?B?dXEyWXk2RzhRbityNG1TY3hkR050bUlxUzUrbWhVZDV5K1hpV2NwbUJRVEJH?=
 =?utf-8?B?dUYwWmpieDVST2JIcWJQdzFzbHI1d0RXaytTMnI1d1NuQjEyUHVxM29sUmFG?=
 =?utf-8?B?RnQ5cFNyRTlDWDlnZ0xmdDhZdFZubzlKeFRIWnlYZUZmb3JYTWdQek40MHZw?=
 =?utf-8?B?VFNubGhaSHZPeXNmY3JWaW0wOWZEQ0NmRjhHaFFYdkxvTzJ5Zzg5VEJNdTN2?=
 =?utf-8?B?NVpaYnByelVwQUZlQ2RZMTVFTDhKNDV5VCs0dEwxU1JJQXV0bVV6MGxycTQz?=
 =?utf-8?B?TkZkczZHVGM2RXpkUEQ5RktWOTlncG9mUUNYUGZHb1lES1V2Q0Nna0pLK2Yv?=
 =?utf-8?B?YUQ3bDc3cy9FRUpxdVYySkZwdmREZHJ0MW9Ra3lQejFiaE9oUTZQbEh0eEoy?=
 =?utf-8?B?bEdvaExwUm1VSWdaWHNqQ0NSOVdHYkhpbkZ3MzhyL1ZzTXNGR2ViLzhBMU0x?=
 =?utf-8?B?dlArVkp4eVpBejNFN2tkZERxcUlwTVhPTXNjcVllKzNDb2VzZWdIT2dWcjVP?=
 =?utf-8?B?bUEwdC9QejVRZnl1dVVxbHZUdjcwQXdCQWNHNEZLazY4MUZraC9pWTE3Z1o4?=
 =?utf-8?B?dWkvQ1dhbmhGRUxkbXVzZDFUeVRDRStZNjk5VXNXNStxT1VDMnB5bU5zREdQ?=
 =?utf-8?B?UE9SNEJkMHdaMFpySTF5MVdFaTY5YzAwL0ZpbUFUSVgvSjF0VEVJSnM2bTJP?=
 =?utf-8?B?SnFVQWxNNjRqbjVxV3krQVF6MVN0RjJkc09BQTYzWGR0cW1vWGZHczFhSmdV?=
 =?utf-8?B?SmlpdlV2S2N4WVNXd3I5czdjeDZqWCsydEpNcTZoZnNLb1NXcnZxMTIzN0J5?=
 =?utf-8?B?RDVEZVBPNHFBSFdjOWJZUUJPYnBKVUdsajN6MitIbmx6YW0rRVNhOEYxRDAw?=
 =?utf-8?B?NTBZTHdQMVlxd0NueGxUYktOdmltMlpVQUtUTVdBR2VPT1RjWWc4THM3WjJB?=
 =?utf-8?B?ZDlKeHFGVkwwZXEvUGhZNWd6dmh4bXdSU0NnamV0SWRUTW5OSmp3cGxTdWJn?=
 =?utf-8?B?TlJrN0trb2JqNWJsekIvRGZXcHI3RW9IV0NMVG80Vm93aU8xdjJhRFZaRnAx?=
 =?utf-8?B?Y3ZBQTF2eDE4cTVUSTRyZ3MydmVTVDVJWFVsYTFJSTh4LzAwQ1Q5VTkxWmNv?=
 =?utf-8?B?YXUzUDJPWCthN2JQbDZqUm1DQUR2NndPT1p0OXhKRVlsdXpXeDYvemRPNTlE?=
 =?utf-8?B?UXg3QnlOc0I1T1FGcW9IeUkyeDI1bjFEL1dReFdMcXlnNEFpaVRYWlpPVVMw?=
 =?utf-8?B?ZWNQSzdHT25IVm5EUU1Zd2ZOMEJOWkFVWks5cFlrTU9QY1hHN242NWhFaEJz?=
 =?utf-8?B?VDVEWXl2M1V0VG1CeG5tNmE0YnVoY0NVQXFPYlBXTUJlbGE5d3EyUXlybVor?=
 =?utf-8?B?ZXNpL3BIM2FBZmtZUjR6T3VDUmtEbHU0ZUJ3ZVI1TlhZcEJLRGhTZzhoRUpw?=
 =?utf-8?B?WFhldk1GeEV3QlpSUHcvQmp5bElHejlLYks2ZTdaTFFveXhVQkM0a3Q3L0dD?=
 =?utf-8?B?RWpTcXhOSU14TnNYTVlHU2VoaVU3bzJ4SVJJSFFCTU1sbnZwV3MwQk80ZFV2?=
 =?utf-8?B?SWlsYVJvQ2plbWYzcHZ4UXZQcHMzSjJtNEtOY1drNUd3TFYyWUgxV3ptNTdI?=
 =?utf-8?B?Qlpmd0NrZE1ocGNWaVBQQ21wOEFneHBOTlJ2MlBuQTZ6WXh5Q0NCS0RKM2N3?=
 =?utf-8?Q?PgbmTSIeNwy1m83D+Or7ytrHYSTO+p3M5FRTY/8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1dee5f-e6db-4cf7-dcf2-08d910792251
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 10:24:30.3802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+e0x0yDmSGLWd/rLyWl/b5h7Yj+nSpSkd/TVRa7WEN9y1IasgaJSgkHfatUyUtmPs/ps98DN8u+jrv/yl6ev2ve/o094kDm+9PVclIcsBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060071
X-Proofpoint-ORIG-GUID: wD5BHIT6IpT-t8eqDPu-HF0SKH_0cH86
X-Proofpoint-GUID: wD5BHIT6IpT-t8eqDPu-HF0SKH_0cH86
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060071
Message-ID-Hash: XWM4DMDDS5Y5D3ZEFPX3A7IXFCOEHHJH
X-Message-ID-Hash: XWM4DMDDS5Y5D3ZEFPX3A7IXFCOEHHJH
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XWM4DMDDS5Y5D3ZEFPX3A7IXFCOEHHJH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 5/6/21 12:14 AM, Dan Williams wrote:
> On Wed, May 5, 2021 at 3:38 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>>
>>
>> On 5/5/21 11:34 PM, Dan Williams wrote:
>>> On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>>>
>>>> @altmap is stored in a dev_pagemap, but it will be repurposed for
>>>> hotplug memory for storing the memmap in the hotplugged memory[*] and
>>>> reusing the altmap infrastructure to that end. This is to say that
>>>> altmap can't be replaced with a @pgmap as it is going to cover more than
>>>> dev_pagemap backend altmaps.
>>>
>>> I was going to say, just pass the pgmap and lookup the altmap from
>>> pgmap, but Oscar added a use case for altmap independent of pgmap. So
>>> you might refresh this commit message to clarify why passing pgmap by
>>> itself is not sufficient.
>>>
>> Isn't that what I am doing above with that exact paragraph? I even
>> reference his series at the end of commit description :) in [*]
> 
> Oh, sorry, it didn't hit me explicitly that you were talking about
> Oscar's work I thought you were referring to your own changes in this
> set. I see it now... at a minimum the tense needs updating since
> Oscar's changes are in the past not the future anymore. 

/me nods

> If it helps,
> the following reads more direct to me: "In support of using compound
> pages for devmap mappings, plumb the pgmap down to the
> vmemmap_populate* implementation. Note that while altmap is
> retrievable from pgmap the memory hotplug codes passes altmap without
> pgmap, so both need to be independently plumbed."
> 
Let me use this one instead, definitely better than my strange english :)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
