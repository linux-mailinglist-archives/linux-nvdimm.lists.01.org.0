Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2373215A4
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 13:01:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 336A8100EBB9E;
	Mon, 22 Feb 2021 04:01:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DCA4B100EBB7F
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 04:01:53 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MBwcsU147724;
	Mon, 22 Feb 2021 12:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=P3kV0eJbWojf3ZjKTAv78JYO1pgC/YrU0Iyqu+WT1HI=;
 b=zWG7lbmdwsI2nMkVH5N1nXOy4ojpk1F8QTzr9UmPckWteSVW2mYbbpL9ndqWxJ3CAtQX
 15zVheByw16ZgfEZZP8a/a1KCK1ZRkNM5jH7Zlo6X1OULCJQLcsXa162V4lo2J37jDez
 tk1d6Asrdze7KqG095F527dp2nsa/4Fx0MvhNlNiNqZlIwwjuslsKetp2rjX+gfxqvlG
 eN+Wur/tBDje5iHUZGX5z8AHJP8dsX7q0Tv2DctgdaVgBXgXMM/iFhMxlb40z3SLbvzs
 qNDWVryGmZ0f6aCUdHOEUi3NsXn08C5Dt1Yvpr+eSk95ZS78VJtpHCO5HWfgzpPUx6ic Mg==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 36tqxbbg9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 12:01:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MC01ZJ140723;
	Mon, 22 Feb 2021 12:01:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by userp3020.oracle.com with ESMTP id 36uc6q8tyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 12:01:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDEHxppxtWHA+S9Y8N3cWm/q2PPcyxfRcym/NOfrtxwUzd4Dv02JW8VDo/H8Nq+ZKiUMhZp1hQrOvOgIO2/JLiZpCkTLwf2IkJPvPofP6pyXv0F47ZnnpVB3ctSvqjM8QrMXf/y2ATHOZZux1wWYCHUNzSoRg3USq5iF4frsfSv+u24efJWsKecD+n7DrbNJBUDsdOFphQMyO+Pz+zw4HQzk4IIhGx59rT854MP02OVf2W0Fe0RtBmQHIjimPJOeP9kaujrrD6/vKV7fYGtmD7l421YWA3JuqQJj8KZApNrbNfmn4SIQh+mpgoOfyah0HbsiGIs331e5k36Qy1ntYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3kV0eJbWojf3ZjKTAv78JYO1pgC/YrU0Iyqu+WT1HI=;
 b=dU8AOmxMXd5gcpPm2Xg93/+zJT9ztLUepPBOKHaqu/sXx5X0HuH2LFU7HdZGieC99cwpImw/VJklg3Tppwkuo6a5/WnHROiSm0KeNRRewrZtp9ovNrkZWZP85A+Ad+QeriahsKpTwMcj9NXAlqwKikgda/WtrMaZkHlNmlB904qK21rOoieEPO94OQ8RKV+PrIHB6DRVfO1+U2wO3A61qufIUx/Q5YbBi1BKitKrZkKsFmSkRsb3XTGViFCLd80BabSRqQCYtMC4rw9ySFST8VYkAJ6w74wi+JKAXAXT8XmdtZ5xEFxa56iWaTd/5qe5yhKLQDPDGYZ5LYTNP0d6zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3kV0eJbWojf3ZjKTAv78JYO1pgC/YrU0Iyqu+WT1HI=;
 b=UodB8ZjVgGkPCcGYU5rOfu44uRNGiLqDqf8GBgd1xGzHXAVjGdh+/FM5Jt+t/6WnRRqTTZv9ZRsKkwNLO8p5Vb0nureXo8/h+x6nkWjR64s+r442mYv54uCaZMlvCQjz7GAx/uV5nPAmDBRjWimOo8QGdhThBE94LKAZ9DUQuYc=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4413.namprd10.prod.outlook.com (2603:10b6:a03:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Mon, 22 Feb
 2021 12:01:39 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 12:01:39 +0000
Subject: Re: [PATCH RFC 4/9] mm/page_alloc: Reuse tail struct pages for
 compound pagemaps
To: Dan Williams <dan.j.williams@intel.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-6-joao.m.martins@oracle.com>
 <CAPcyv4hw574wYUa0qzz+pQrB4K11R618Moh30mvLz8GLNDw=5w@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <50b76256-c1b5-0f88-f9cc-1cdce45c6ce1@oracle.com>
Date: Mon, 22 Feb 2021 12:01:29 +0000
In-Reply-To: <CAPcyv4hw574wYUa0qzz+pQrB4K11R618Moh30mvLz8GLNDw=5w@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::20) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO2P265CA0296.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32 via Frontend Transport; Mon, 22 Feb 2021 12:01:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94e1b75b-114c-43a8-1733-08d8d7299b3e
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<SJ0PR10MB441318355EFBC8A6C4D071CFBB819@SJ0PR10MB4413.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	t0uhUuMylcBXCyKTjK3CQm3XqnHbEYib0nobXn92muFkkXv6HiLo2yNY3R3hGxooBqlMPnsBoC6nxmdOBuNgFbhNaqZXubOJSokzROvidLlWPx6XHrOpEkiIcfRdFn0vnvyU8wb3CHsiQrcePXNbHW/47VxR1N31wOaiDpmQlQB77hweRZcKQdduLKlNkK5g8N7TG4veQZ6yZGqn2fKVp37iq3QYChxbErsZvGYdAbH1KFuunh7AmKBIgkr5mOvUhiD0UR1iWq9p5HeRyLZkahj1KJTOpyPP2b50M/DIU7YBa4TGnTknJ7DsvboT1ynvoFdtFtfWMPqeU5pvwzhzeRevT6H/1TwRwu7y3I4Eb987u/rx4i320d1+hbP/uiTgjnZUEmG65ebmxVVsUTYqe+kx0JlIChxUQ5kDuxlvkgY2I5vXsLu6L67j9lNuO0IVMd1Kxo7QoaUMs6oQQyps0yEfaDkSJocvRG3fica0weqRquULOpV5oEU8aGL3IuJXG8pzyeRcbpt6wOnaolS2ZmbYJZCQD91B+1wAbup/91GIokEp6JXWki9pI3K5nmaKmO3DvjIRxIi6//DwWovI4A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(66946007)(66476007)(26005)(6486002)(186003)(4326008)(2616005)(66556008)(478600001)(83380400001)(86362001)(956004)(16526019)(31696002)(8936002)(54906003)(53546011)(36756003)(2906002)(6666004)(5660300002)(6916009)(8676002)(316002)(16576012)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?NGgxM1FrN01IczMyQllBL3pVaGlva1dLcSswSDZDdG5wLzd2V1JKdTNqWnVy?=
 =?utf-8?B?Kzl4TzN6eVR5VWVIU1dtR3pjeUh1ZXRmcTJEbzZUWDY1REovQjRoMTVwcU9t?=
 =?utf-8?B?L3FRTVRJL2c2YURtei91RFRqYm9pQVdBZFFQRjZFRDYrWW0xb2N6OWlVcFYv?=
 =?utf-8?B?WTN6eldBb2dhTTM2TVFVZmVCZ0tJNVgrU0ppNFpSbm9TMExSa3ljU3h6VUpS?=
 =?utf-8?B?MEZ6STdITjVaU0xLSDZvQmkxQzJPRnhUZG54a2dWM3FoVklHSUcyN2tkOHpR?=
 =?utf-8?B?VEpoRzhCOE9BM0NwU3FRVDFUM1VJUSswR3cwckFwWEFEczlXdmROTWhvMDFX?=
 =?utf-8?B?Yk1ya2dpQzR0WE1BL0dkd1c1Q2RqQlFScGFUNmNWY0pwcUhEREU3RTlidm1z?=
 =?utf-8?B?UUFWNHRyaHB3V2RmNkdKZkhQVGhxWStiWjg1L0Q2QzE1Z2VhQ2JhbmJtRlMw?=
 =?utf-8?B?ZWdOVVo0WmQyRFRCL3l2TXhnRUFxOU9vNEVlT2ZsLy84RUhreFk1ZnhOa1Ax?=
 =?utf-8?B?V0FyVGd3aDVxaG5XT1BXMXNTZklXazhSclJYVU83TG1kTGp2alB6UGxsMzZI?=
 =?utf-8?B?UmN5THNiZVk5bUhBQmpPeVh0WE4xNjlvbm5kRUdWd0x1RTlsdlJaOWEvdnp3?=
 =?utf-8?B?blZZS0Q1WTk2NlEzNzRmUXArMmR0bWY2NjhBRzNMZWtValRYWEN6QXoxR1Bm?=
 =?utf-8?B?Q1RYeVhTTVdFUi9pNXBZWnA3ZFMvS1RERElZbCs1eDhGa29Ib3JoSEVtcWl6?=
 =?utf-8?B?ZVNqRENhZWk0bENGU2NOTVBhSVk5MjVPRDlaeSt1MVF5TllnSWI1eDhRWmdy?=
 =?utf-8?B?UHNVTUpIVlRFS3BEci9rU1pjMVZFNkJldFJYVHBrRkR6SytrSWw0OU9mamRi?=
 =?utf-8?B?eVRwbS95RjJ0SVVUdXZRd3JMTE11d0s5TXFqQjFLcHBtWVI5UkcvVkgyT1Vv?=
 =?utf-8?B?Y0tYdHRTSlptTjIvaWpDQm9JeDM3aUswa3N6eUlrMFNrZHJJUjBpZVZrSW00?=
 =?utf-8?B?aitEVTMyNER4a1pPQ3hkUUN5Nzk0eXlNdkptSWpQdzBrODlWVjlUc1A1Y3Bk?=
 =?utf-8?B?MXh2TUlEZ0RGNVFDcnV5T2w5ai9ER0xFNTltVHBQVlVTQ2VBZ1NWVE9OS0FX?=
 =?utf-8?B?SzBReWhXRlljYnJVUUZVOUVhL2krTE01eHZtcXJOMWhqWU8zejkybmR2cGhj?=
 =?utf-8?B?RkxUNTk3TDNqcmFyQzVvOFBHWHc1bzh0VDZnbHV0cmVKWXd6azhEZC9mYThs?=
 =?utf-8?B?T0xQOW1vazV4TUM5RFlZQitQdE4rMFJhN2hmcGM0ZFJCZ0MvYi8rWko1WVZl?=
 =?utf-8?B?eHhYZGFEaTlhQW4rMEFMVW1ieXNVNjRQdCt1aVlyaW9iR3lSYnFSRk1UYUM4?=
 =?utf-8?B?V01ZNENRWUZDS0s2Smg2MURENWZ0Q2ltU2ZDTU0yVVdqNTNGSXlEaEtyeUhD?=
 =?utf-8?B?RzdCejhFU09UYzRnTTFWeHZtRlhFU3hxSHdZQjY3TkZoMWVKYklEbGQ0Skd5?=
 =?utf-8?B?d3JyWDVtVUN4V3huNGpmQ1FZM251dFpDSUdra3ZnNWw5V0hiRzh0SWVFSUpI?=
 =?utf-8?B?dTF5K3NaR3cvL28vcXdjNzE5bnJDUG1VTnFyd29JSVhHL3owUm5nMkFHcHJr?=
 =?utf-8?B?WWFwaFVPbnl5YU1JREthL0Rwa3I4TU5pRDF6eHJocEowSDhNMkNQUWpoNWFI?=
 =?utf-8?B?K0VyMXFIMlVDSDZPczl1MjFmUXBDamMxbG04U21tVStFOGQvZ2g3a0t2cTVj?=
 =?utf-8?Q?ucHFGkV/sBXO1Vpj0UGs5z3wqUO8VpbGb+bR4Ey?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e1b75b-114c-43a8-1733-08d8d7299b3e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 12:01:38.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMJCW1S8cRUzsCfrnn0qHn5QMaYmsnORC1BBcO5TvHpYuz2uV5Qc83Qzfub1X5Xceu3wX94graUgvxdOorrJyk0VZilaY8BaVBNCqQ+LwQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4413
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220112
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220112
Message-ID-Hash: YEXWVJOQS3PALP3WNLPVUO6JEO24ZIYH
X-Message-ID-Hash: YEXWVJOQS3PALP3WNLPVUO6JEO24ZIYH
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YEXWVJOQS3PALP3WNLPVUO6JEO24ZIYH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 2/20/21 6:17 AM, Dan Williams wrote:
> On Tue, Dec 8, 2020 at 9:31 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> When PGMAP_COMPOUND is set, all pages are onlined at a given huge page
>> alignment and using compound pages to describe them as opposed to a
>> struct per 4K.
>>
> 
> Same s/online/mapped/ comment as other changelogs.
> 
Ack.

>> To minimize struct page overhead and given the usage of compound pages we
>> utilize the fact that most tail pages look the same, we online the
>> subsection while pointing to the same pages. Thus request VMEMMAP_REUSE
>> in add_pages.
>>
>> With VMEMMAP_REUSE, provided we reuse most tail pages the amount of
>> struct pages we need to initialize is a lot smaller that the total
>> amount of structs we would normnally online. Thus allow an @init_order
>> to be passed to specify how much pages we want to prep upon creating a
>> compound page.
>>
>> Finally when onlining all struct pages in memmap_init_zone_device, make
>> sure that we only initialize the unique struct pages i.e. the first 2
>> 4K pages from @align which means 128 struct pages out of 32768 for 2M
>> @align or 262144 for a 1G @align.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  mm/memremap.c   |  4 +++-
>>  mm/page_alloc.c | 23 ++++++++++++++++++++---
>>  2 files changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memremap.c b/mm/memremap.c
>> index ecfa74848ac6..3eca07916b9d 100644
>> --- a/mm/memremap.c
>> +++ b/mm/memremap.c
>> @@ -253,8 +253,10 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>>                         goto err_kasan;
>>                 }
>>
>> -               if (pgmap->flags & PGMAP_COMPOUND)
>> +               if (pgmap->flags & PGMAP_COMPOUND) {
>>                         params->align = pgmap->align;
>> +                       params->flags = MEMHP_REUSE_VMEMMAP;
> 
> The "reuse" naming is not my favorite. 

I also dislike it, but couldn't come up with a better one :(

> Yes, page reuse is happening,
> but what is more relevant is that the vmemmap is in a given minimum
> page size mode. So it's less of a flag and more of enum that selects
> between PAGE_SIZE, HPAGE_SIZE, and PUD_PAGE_SIZE (GPAGE_SIZE?).
> 
That does sound cleaner, but at the same time, won't we get confused
with pgmap @align and the vmemmap/memhp @align ?

Hmm, I also I think there's value in having two different attributes as
they have two different intents. A pgmap @align means is 'represent its
metadata as a huge page of a given size' and the vmemmap/memhp @align
lets tell the sparsemem that we are mapping metadata of a given @align.

The compound pages (pgmap->align) might be useful for other ZONE_DEVICE
users. But I am not sure everybody will want to immediately switch to the
'struct page reuse' trick.

>> +               }
>>
>>                 error = arch_add_memory(nid, range->start, range_len(range),
>>                                         params);
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 9716ecd58e29..180a7d4e9285 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -691,10 +691,11 @@ void free_compound_page(struct page *page)
>>         __free_pages_ok(page, compound_order(page), FPI_NONE);
>>  }
>>
>> -void prep_compound_page(struct page *page, unsigned int order)
>> +static void __prep_compound_page(struct page *page, unsigned int order,
>> +                                unsigned int init_order)
>>  {
>>         int i;
>> -       int nr_pages = 1 << order;
>> +       int nr_pages = 1 << init_order;
>>
>>         __SetPageHead(page);
>>         for (i = 1; i < nr_pages; i++) {
>> @@ -711,6 +712,11 @@ void prep_compound_page(struct page *page, unsigned int order)
>>                 atomic_set(compound_pincount_ptr(page), 0);
>>  }
>>
>> +void prep_compound_page(struct page *page, unsigned int order)
>> +{
>> +       __prep_compound_page(page, order, order);
>> +}
>> +
>>  #ifdef CONFIG_DEBUG_PAGEALLOC
>>  unsigned int _debug_guardpage_minorder;
>>
>> @@ -6108,6 +6114,9 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>>  }
>>
>>  #ifdef CONFIG_ZONE_DEVICE
>> +
>> +#define MEMMAP_COMPOUND_SIZE (2 * (PAGE_SIZE/sizeof(struct page)))
>> +
>>  void __ref memmap_init_zone_device(struct zone *zone,
>>                                    unsigned long start_pfn,
>>                                    unsigned long nr_pages,
>> @@ -6138,6 +6147,12 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>         for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>>                 struct page *page = pfn_to_page(pfn);
>>
>> +               /* Skip already initialized pages. */
>> +               if (compound && (pfn % align >= MEMMAP_COMPOUND_SIZE)) {
>> +                       pfn = ALIGN(pfn, align) - 1;
>> +                       continue;
>> +               }
>> +
>>                 __init_single_page(page, pfn, zone_idx, nid);
>>
>>                 /*
>> @@ -6175,7 +6190,9 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>
>>         if (compound) {
>>                 for (pfn = start_pfn; pfn < end_pfn; pfn += align)
>> -                       prep_compound_page(pfn_to_page(pfn), order_base_2(align));
>> +                       __prep_compound_page(pfn_to_page(pfn),
>> +                                          order_base_2(align),
>> +                                          order_base_2(MEMMAP_COMPOUND_SIZE));
>>         }
> 
> Alex did quite a bit of work to optimize this path, and this
> organization appears to undo it. I'd prefer to keep it all in one loop
> so a 'struct page' is only initialized once. Otherwise by the time the
> above loop finishes and this one starts the 'struct page's are
> probably cache cold again.
> 
> So I'd break prep_compoud_page into separate head and tail  init and
> call them at the right time in one loop.
> 
Ah, makes sense! I'll split into head/tail counter parts -- Might get even
faster that already is.

Which makes me wonder if we shouldn't replace that line:

"memmap_init_zone_device initialized NNNNNN pages in 0ms\n"

to use 'us' or 'ns' where applicable. That's ought to be more useful information
to the user.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
