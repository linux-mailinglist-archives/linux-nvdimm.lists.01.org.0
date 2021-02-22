Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8EC3214FB
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 12:24:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 20CD4100EBB98;
	Mon, 22 Feb 2021 03:24:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 99E36100EBB7C
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 03:24:51 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MBOO8Z019154;
	Mon, 22 Feb 2021 11:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2GAv44hkyenmCyplRHoo6U6l6ffKs5Lcwo7dJ1hkpQQ=;
 b=KCdQwDEXWUOtGnq8xtpMXSl9SIJJkd+CTWz1UcpN4h2clRDnwD1GAd0P4pBnQDxAvVFF
 7JbuShO8Ycj/VDUq2umnu0k5uksks4RDMDOZPLUVwOpSQMt/YvoU/QvV1wfyacqRx/Yw
 Sw+DvXGX7wM9mXiSgj/g+EyHTb+h83igWXZ830RKKkbzGmjnSpcUd2QzeOcQlnxkslGg
 eNl1XJcU/pr4Z4kzM0wGgiswF+lptkwjc7vrnGl4LPUeGiEhlLX3ivlakE0LZvqL4QrP
 w4hgHaca5UWM3Q0fYNcCoyZ0sRzo7q3dozPwh6ztiMs2zIC3awfEn7k3Esy/jGjTyaO1 xw==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 36ugq3a5vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 11:24:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MBKUL9090953;
	Mon, 22 Feb 2021 11:24:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by aserp3020.oracle.com with ESMTP id 36ucawwmt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Feb 2021 11:24:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnlUQmDc+3b3mTwGK72SY7cR/0j6RJZ/rww/6Ox1PKCQ1ucCOT59XZDPOYFhqNb8tOH7YnNffZkqqbJsDqdUsrMnu90kFcnKeB6K5uk2Hq7qeSaJPib1jdkYIuRrCMfZJrpXsf0xcXOlpnLLryQfKwkWE/J5xnImhGM1OG9iN6H4Wxl2EfoKIjYb4ZrssXYZMwmUd1YAO0lJ99OSij0+5UrddxgV5ZWfeBgQ0u5OSLqcTkrXFvlfQx1gKHh2GUQOujtCK6025h0MsyU4MvVBmIQHugvvzV62sbAktTZtVopLY320PLEJydXE0MREGMKokMXm4RQuAJ7JcAHcKO1pdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GAv44hkyenmCyplRHoo6U6l6ffKs5Lcwo7dJ1hkpQQ=;
 b=AhUSHcSbzl/Fw7XAXH6Q8wiIif6hInh5A/DE8kbMvXKjymHQTtn9B9AVcORfzXC8YFEHO2WQa/cq/47gpEe3mqDP7ZLjl4oBT18nDfETy+vHMQtS2ogxUXbSKu0i4V2zGnNvsKlove84L6OcauMLeUlV+g/vngDOnFda5Ocs/0IfonUTW3hvT901PCpaI9A66lZpiq71F6nKZEgZDIpCDbfFmzozaH6lFEkRVpcKe7HQGO13r0X94de5kcNToV10kii+b+20nxYh2KcLqVrZW0rv96AGaXjMDkZ4VQp2cXtQTltgdWwjTqoTfP8G+ti9qiEu2Noft2ejkW6NIO0VEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GAv44hkyenmCyplRHoo6U6l6ffKs5Lcwo7dJ1hkpQQ=;
 b=VFKPp7MH9YpOHlJB+U8D0ZQ2f1XTIhG4lwJXUQZjW5YVfpD/V39LC/VAvxGAU/GANQrU0WOTdvbhBfJrFF+TO1SjDZqw1ePUBkZomvLpfo4kgxPvhDVU+3yG7/JDIUpYT2wtIvT/OPGRsKUzQWNQnajPY+si12IiBNTv7fUOUMI=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3352.namprd10.prod.outlook.com (2603:10b6:a03:159::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Mon, 22 Feb
 2021 11:24:37 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 11:24:37 +0000
Subject: Re: [PATCH RFC 1/9] memremap: add ZONE_DEVICE support for compound
 pages
To: Dan Williams <dan.j.williams@intel.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-2-joao.m.martins@oracle.com>
 <7249cfd2-c178-2e6a-6b03-307a05f11785@nvidia.com>
 <CAPcyv4iMzaAqKe6C1Q_feHL5SwppPdBem0i6XfYX4sL1U6sHgg@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <7e8908ca-4d0f-6549-0442-d4b15fbc90ab@oracle.com>
Date: Mon, 22 Feb 2021 11:24:31 +0000
In-Reply-To: <CAPcyv4iMzaAqKe6C1Q_feHL5SwppPdBem0i6XfYX4sL1U6sHgg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0425.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::16) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0425.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18b::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31 via Frontend Transport; Mon, 22 Feb 2021 11:24:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7789e6a-2c05-4995-a21d-08d8d724700c
X-MS-TrafficTypeDiagnostic: BYAPR10MB3352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB33521F1E12A03E60F9412856BB819@BYAPR10MB3352.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	U874Dekc+AFcamqIVDj0Piw7S9bnZtFKiWmkr1At3dOwvY0fQ9/3w0p1ecuzow5AruVwzAmXnoXyns/t+dn4nbx7HfPNfzAH9CKuqKqWC2gaJGEO6qqLyx5b6K90tycdH3dYpzN8cFzaBiUUSyX39eudL7gFyF5WYNzVgCONGJa50esdVFhwNY+CUXEfDCDOKuharejQsw6O+Iew8C9qjYG1PC886Gt7nI21oXJZZ5uP1iB2OFtuWzN1IVyeDw+HTG4xpQlralnxuEtoreMT5YIOJuiH+O6ak9uXcguEVX1gWiYyLyWZMss9zviMTl33itPyTIskykUY8plntuzqRH98y0v8V9s9UxrNjSBTX986Yz9bU/EOdnI3u3oZtDeqTDMbHrun8vvp4H2W9noVRjotSeMBBRBECh52ktdwOL+/Zs4p6ZqurG28XCgzwcPsexrZ8jy7BMUy6O6N51o/kWBsaPP4DuWPjBToOTK3rmBSVBxYParFg3XCl8b7R1uceIdVM1Bo7oP+dYvjP2ESFl3J4PeWjc8wB+Zg8PxTNcPQOYSxeD5AJbYNzVTHaO8uZlZ1gv9szwOm4foEELRjDw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(39860400002)(136003)(6916009)(2906002)(31696002)(36756003)(86362001)(66946007)(66556008)(66476007)(83380400001)(4326008)(5660300002)(478600001)(53546011)(2616005)(6666004)(956004)(16576012)(54906003)(316002)(26005)(31686004)(186003)(16526019)(6486002)(8676002)(8936002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?dEVIVmxxeEpxM1ExZWdWclozNWhIVkFPdGdRclFiYWUxZjZON2k0N0c2WXBW?=
 =?utf-8?B?QmVNS3JkVzhwUFhqRjdSMi9VSzhQL20veDhqYkNsSDFoQ3BXczNkZ1JpTFhC?=
 =?utf-8?B?aVVDWlhtWmpWOW03RHlkVnk5RjJLYVRjVllUcnlEOVkvMEtwNHNnM256RXgx?=
 =?utf-8?B?VGpZbm9sb1ArYndybHlIdXpUNnBNTkhQSWtCS1JuellNcDJvVXB0S29ad0Jj?=
 =?utf-8?B?Uk1NTkgrQmVodzI3WlA5NHJMTXZPQWZ3Sk5uTjlvOWowckJpN3crK1kySUhZ?=
 =?utf-8?B?L1E3S3pyKzZjRUI1NGpGZXRXN2h1a2gwOWt6QlZubEVsRVVUYXEvRm5zNnN5?=
 =?utf-8?B?aDdxVXMwVFA2R2dTMUx4RnFzOEJtNEM2QzN5R0dMZ0NwSFEwNzJDRWt3TVVq?=
 =?utf-8?B?UUhrMVVtU2oxQ2p5UTRINW5QTVlmb0ZoNlpvOC9SSWhibnkrdUxGMEVRNlRW?=
 =?utf-8?B?M2FGRkhwNENkY1lOcUZVNW9RelBDYzdTZGJCTWhMNGV3a2ptNVFUTWJIZmxT?=
 =?utf-8?B?TURnekMrYlovVWFod3VRODZnaXo1RnNxdGMzcE44VmxCL0NLcWNZN2xramF1?=
 =?utf-8?B?eFNTN0N6VmRMSHhDZnRlU0xONUVKVTBoKzJ3b0RpL1kvQ085Q3N4TTVpUTVh?=
 =?utf-8?B?NmljdU9zVEFtSUpscm1DQWZVcDFNbENZYUhwYy9HNTRGVG1yWStXMlZacHUz?=
 =?utf-8?B?TkpHTFVOQVBaekRnWDg3Yjg4ZjBPaW4xUUlTMjN0a0E0S2psVWJHaGYrcGM0?=
 =?utf-8?B?ZUtGRVNYRGVLSjhxbGgvZm5obUdlRzNsSUxNSU15bHZuS0xLcGFqZ2xSS0NU?=
 =?utf-8?B?UzYrYUZPOWZUMDJtNlhiRUl5MEhTbnVLbUtjNzA0UzZxRmVYbktCbmMzMmhz?=
 =?utf-8?B?Uk9DSEsvN0JnamtMYThISWxZbnhmejlFOGF2dG52LzVmK3B1MVl5ZTVKTlYr?=
 =?utf-8?B?bVo2VUlvdUNlalZDaFRuUzZGZCtaMy81bWRTVVRncmMrUGxXcjlvemlKbGRm?=
 =?utf-8?B?ZXRNUmg0U2p2MW5QaEVqMnVhazZnMm84UmVCN2EwL0lxY0RENkY0SHhRYUQz?=
 =?utf-8?B?WFBwWlhNRUxIRmhXa2U4YjN5eTA3REZSUnVBY3dqVDVaa0h2LzdYdkVsVzlJ?=
 =?utf-8?B?clNBRjZrOU5jeU9Md0lPTlNBbWZCeCs2eFYvK2NsMlU3YjUweUcrWi9HV2gy?=
 =?utf-8?B?NEFHbHVmcG9RWTE2SGF5dW9nV2M5SHoyanBCR3djWkxwbndLOHFaT3VEcktE?=
 =?utf-8?B?dU12ZXk0VVZPdnhGMFB3dFpORjAwRkdrYXJvb05NbG13NGNvQkZOb0tRNktY?=
 =?utf-8?B?YlFyUzQzOXJiY0RRb3Q1NjYvdnI0SURKNjF0OGRaSkRWeUZ3ZDY0SU1tYVlM?=
 =?utf-8?B?MitBdVA3K0JLd3YrK1dteEFsWXBGQ2VKVW16ak1zQ0ZnRENJb3cwd1FRTDl3?=
 =?utf-8?B?MkJadUF1QTBzbXRNaE1CYnFydVh3dkxqRnJtNW1CcTFiL3l2OFcrcURnUkIx?=
 =?utf-8?B?R21nc0JodS90V0JLMFl2eGV0QytNRjJvL1h3V0w1ME0reW1NeFByMHZ3cVB1?=
 =?utf-8?B?Q1BsQ0IxRmFZQXVNVkZPbGNDODNSbzl2M1ZQbWF0aWJXMFVpUFhRSC8rcWhp?=
 =?utf-8?B?U0FaeStzandYeUdadDJ3cDJWR1FGbW9RODNCeVFvTXA2Z01EWklFeDFXa0xI?=
 =?utf-8?B?aTVMbDA4YUxLeHhYSWNxZW5oaGNiV29wc3R1Tyt3ZTRuYmlwdUVTbWJZUGRj?=
 =?utf-8?Q?l7vx/AvVmK3p2KnQ8TT9L7DEfoOaEV4bmqluX6J?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7789e6a-2c05-4995-a21d-08d8d724700c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 11:24:37.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kr7O6Ks165OMCKpDI5vo0sl8DSeFrTAnpLp5ABdU2NxsgrYX4+9XqH55euhXb7Pfn+1dY9NAk2IjROoQVV1MRknfDksM/jup4Vl9C6szu98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3352
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220106
Message-ID-Hash: XQ5TOU2VVQFNTUGINLRTAL5E34NMXQSE
X-Message-ID-Hash: XQ5TOU2VVQFNTUGINLRTAL5E34NMXQSE
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XQ5TOU2VVQFNTUGINLRTAL5E34NMXQSE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/20/21 1:43 AM, Dan Williams wrote:
> On Tue, Dec 8, 2020 at 9:59 PM John Hubbard <jhubbard@nvidia.com> wrote:
>> On 12/8/20 9:28 AM, Joao Martins wrote:
>>> diff --git a/mm/memremap.c b/mm/memremap.c
>>> index 16b2fb482da1..287a24b7a65a 100644
>>> --- a/mm/memremap.c
>>> +++ b/mm/memremap.c
>>> @@ -277,8 +277,12 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>>>       memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
>>>                               PHYS_PFN(range->start),
>>>                               PHYS_PFN(range_len(range)), pgmap);
>>> -     percpu_ref_get_many(pgmap->ref, pfn_end(pgmap, range_id)
>>> -                     - pfn_first(pgmap, range_id));
>>> +     if (pgmap->flags & PGMAP_COMPOUND)
>>> +             percpu_ref_get_many(pgmap->ref, (pfn_end(pgmap, range_id)
>>> +                     - pfn_first(pgmap, range_id)) / PHYS_PFN(pgmap->align));
>>
>> Is there some reason that we cannot use range_len(), instead of pfn_end() minus
>> pfn_first()? (Yes, this more about the pre-existing code than about your change.)
>>
>> And if not, then why are the nearby range_len() uses OK? I realize that range_len()
>> is simpler and skips a case, but it's not clear that it's required here. But I'm
>> new to this area so be warned. :)
> 
> There's a subtle distinction between the range that was passed in and
> the pfns that are activated inside of it. See the offset trickery in
> pfn_first().
> 
>> Also, dividing by PHYS_PFN() feels quite misleading: that function does what you
>> happen to want, but is not named accordingly. Can you use or create something
>> more accurately named? Like "number of pages in this large page"?
> 
> It's not the number of pages in a large page it's converting bytes to
> pages. Other place in the kernel write it as (x >> PAGE_SHIFT), but my
> though process was if I'm going to add () might as well use a macro
> that already does this.
> 
> That said I think this calculation is broken precisely because
> pfn_first() makes the result unaligned.
> 
> Rather than fix the unaligned pfn_first() problem I would use this
> support as an opportunity to revisit the option of storing pages in
> the vmem_altmap reserve soace. The altmap's whole reason for existence
> was that 1.5% of large PMEM might completely swamp DRAM. However if
> that overhead is reduced by an order (or orders) of magnitude the
> primary need for vmem_altmap vanishes.
> 
> Now, we'll still need to keep it around for the ->align == PAGE_SIZE
> case, but for most part existing deployments that are specifying page
> map on PMEM and an align > PAGE_SIZE can instead just transparently be
> upgraded to page map on a smaller amount of DRAM.
> 
I feel the altmap is still relevant. Even with the struct page reuse for
tail pages, the overhead for 2M align is still non-negligeble i.e. 4G per
1Tb (strictly speaking about what's stored in the altmap). Muchun and
Matthew were thinking (in another thread) on compound_head() adjustments
that probably can make this overhead go to 2G (if we learn to differentiate
the reused head page from the real head page). But even there it's still
2G per 1Tb. 1G pages, though, have a better story to remove altmap need.

One thing to point out about altmap is that the degradation (in pinning and
unpining) we observed with struct page's in device memory, is no longer observed
once 1) we batch ref count updates as we move to compound pages 2) reusing
tail pages seems to lead to these struct pages staying more likely in cache
which perhaps contributes to dirtying a lot less cachelines.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
