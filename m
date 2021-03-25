Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 111EA349CB5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Mar 2021 00:10:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5EC46100EAB59;
	Thu, 25 Mar 2021 16:10:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 97FBB100F2265
	for <linux-nvdimm@lists.01.org>; Thu, 25 Mar 2021 16:10:34 -0700 (PDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PN0Vnp136486;
	Thu, 25 Mar 2021 23:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=sJbZIR57JdReehTQrFNZbt8IGbBmigebPUcx85AKKSY=;
 b=OFe5S135BYfavh2KoL1KEU4wKeL4Df6mHvL60VO+EQ1EQMH/4zuxW+h25h6mNSSN9NsI
 UhCaO5hx3+JBncUeZOgFd2hyRZKsSBjmXZL41aEsP2Qle/c/2PE6RVHxpa4+dP4J7aTh
 1oB/46tLoeVEakUKYfkQAUKTs/v22C2HdusSbJn1a5R/602ovpqtJpQyNkNeOJZgE2rn
 yM2Z2LcCbrCLr3MKv5ZUhXOQqnsc7ETiorXkLzgHO/flo16zBZGSwurHLG14WOqKEV5P
 WZw3I9CCsdh1dGonhpuznGnp7/DIoMpUM4pyHFXtdEuBpX1j4/xKvEOkAVlbOPhOBC6Q 5Q==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 37h13hrdw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PN0JKM161365;
	Thu, 25 Mar 2021 23:09:59 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
	by userp3020.oracle.com with ESMTP id 37h14gdpp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:09:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejVkB68dQtVMiQdRo1O/1YdBDSDDVRCWHj4FG7Le6rlEroqhfW9eifuncF3PrFh35HXmV1v8G9COULldeY9XixtKXyAEj7p1Mmqe9yshtG4VnJXqFtw7WCIwYp7FIbEG4vQOPQEQuYYs78Cd6IPV5YvzplXwi44mIsrjBy+wCuaUj+tbkEQ7wK4ebiP8OgVPn0lCEH8953O/ciPtas/KW1f5siED+VdMqbr+UHMRfMzlrH8FVDv97bY/ueTCDo6ljYYfVsjmrlVxfeAiR7bkRWLlBvwP5k1bOQkJL5/PoLLzLT3CCUNSumHqvxUcAEqkZe11qyb3IBLFs9GM9WL6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJbZIR57JdReehTQrFNZbt8IGbBmigebPUcx85AKKSY=;
 b=HtxmCbjjd9e5Bm47p6whES0jYDg6QMPO4o4K4U0henAV/l2V0XkLjCxaHY0kKVynSgqCZZCyFhGXAPNDyUZq5OihGaV8l7JNgLQPOqNiNKJHkB24sL86zg2mPG0T/ZnKwcPD3AjrSstmU/OuEINAOppXhk0PFj9XFrUD4r/mTa6vtDDuc5DiV4NDkFnutfJHyhxdL3BXVl6PjLwttI3LlZ34usZeBCy5fbeu7WZuHINekyMvCrqT4vrzrAS9tJND+RhP88ekBIZUWO7njZysK5LV0Q4LXofVZ0y5jooRtI4QRbziDZzJZ0nLF4prbGwkn/tWb5cgrECzIkUvTtCH5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJbZIR57JdReehTQrFNZbt8IGbBmigebPUcx85AKKSY=;
 b=jY7RJsEeYW02ap9uyxUJRj5VR/v2G3B2pPTbbA1WVyz6rLFf4tRGYx+qBFtoG3IwsrULmDHERefu0icgz4hi07vPgmOa4shEc226ET+ivhKOiF4vIb22l0bWjiqCoqwtJmRVkjjk7RUCeCcd264jQcSqDKl4fQCcAor2SjWJC3Y=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB3987.namprd10.prod.outlook.com (2603:10b6:a03:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 23:09:51 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 23:09:51 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 00/11] mm, sparse-vmemmap: Introduce compound pagemaps
Date: Thu, 25 Mar 2021 23:09:27 +0000
Message-Id: <20210325230938.30752-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::22) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 23:09:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d986e06e-56f3-412f-ded4-08d8efe317f9
X-MS-TrafficTypeDiagnostic: BY5PR10MB3987:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB39876262A191ECE4A24FEC1ABB629@BY5PR10MB3987.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SfToY1RSSw+hzfJX8IK3v7xyKucEzMlduxthJPGZVfvVSbQMM7RzwZOA5iGow+qr7aIzk08QvCEjXumKRGThtQjFf/vtAUG224CPD+oaPV/1i09lB9rs57sZ9xjl1MVvV3Qrj2tKI6N0Vp3m0Kh06BXrzGKptzbKWyPO1x/XQiJurhVb85V2HIaTkCIHVvfpyui1QvKlpY+Jd7M2WRn8EKOPicKOGNSCg3J95kaycOYoYtWTizsECtotTfoPXYTfrhEgyIoJvXzsAeFxbh1SQK9c37bkOZKggDifZ4y7vaNM+8rstuC9mntO07Ra4SnzjGnWuLoAA9LhgGz8oBrSmtJZ75y8oEaTGp83uz9civjf9XT0jWbRZ53SNhE7Q7p6fiMIYdMCX+hz2c5FYmnyTsToAE9zif0WNViUG2r5AT62WPQOSkqq2iZBOudMXKoX3u+qcKON/f0u3r0lxRfj/XleQMSNMVcEf0w3uwsM7NNIpCpS3Wl68AV2gsd/m2BJGctzp/SLxx51Qu6IhyzyCkmAbc6dDTpRqzkK/B2kATIwYlgUSxBjB/7rGes5wpB6P861dBVewJELOxXTkFdkCXth3belwbxo9ZNIojU2VwH5owVgDXesRJXLPI5KttAki4LOaNRAYWTNbehUB1FZzW1Ch28qxUwZbN1VVNVXyyzJ+9iMCH4hx+k1ITnwe52lvAPgyiXR9s4O/viKwnv+9/lc6ROoJTdsnBfOt0/PaGI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(83380400001)(4326008)(26005)(107886003)(6916009)(36756003)(7696005)(52116002)(66476007)(966005)(66556008)(478600001)(66946007)(186003)(316002)(2906002)(8936002)(54906003)(2616005)(86362001)(8676002)(956004)(5660300002)(103116003)(1076003)(6666004)(38100700001)(16526019)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?L54mNKjqA1buS9ddquleJRpLODsL+Icbh/FLzqbV/iCzY+Gkaf1MrvpS/LL/?=
 =?us-ascii?Q?OJxiSKeuVgR2pJhYvz5sHKE6KUrjZBeQAhqcJynR0XDgGBZ3iz0FLnGF8x+X?=
 =?us-ascii?Q?OtmfDMndZ5EvNOC1fq1A5feQ1fm31Rds2oX10t8GnTp0O4ZY1DPkquHoiX4l?=
 =?us-ascii?Q?+VfMKo9F59MIb1V5fV6zfho6f/Upp9wL+SR/N5PkhrGJdjOKUYvykNZYSf05?=
 =?us-ascii?Q?m92RgjMUIG/A/jCUY/itu2bJg552YLjaDonIs+D8Fe4kkz3tuG/MrqJyplF7?=
 =?us-ascii?Q?BCp0VFbSeTCbGf1Aoh3jAyqRlZM1F6teDIM1nAuYCwViaf2Hu8GuJf3a6KlO?=
 =?us-ascii?Q?afnyvs/phVh860G2sob9MnnghDzDfNZLdKW9HjPStTFopvgwKb5gI9C7NxEZ?=
 =?us-ascii?Q?NFIXzTQGEkt1koA0LaW0NsWzeepe3mHmZ+KYJr0SqnwJmtJos+Qoai7Q6EM1?=
 =?us-ascii?Q?X/dzF/PJ5KxVnaCFp8j25NSj+sxMbHjbmklNFdir0M9I3q24LQw2ycMlktnE?=
 =?us-ascii?Q?wox6FMkvtiK+T4U0yA0sGnZlV8dTN2gJ/B8XgJpW2vnXUuv1caDNm5sr/+6K?=
 =?us-ascii?Q?XM8bJOUapUNhM9SXkGLzqvN3EyexCIGmYcv9oRmZs4fVVuPAJlDjqa8Xq6si?=
 =?us-ascii?Q?HRdDBhpl7OqGUn13+QMCvpl4sVGCEsWUxZi8X28PWXEA3jegPFBqS9mv9TAv?=
 =?us-ascii?Q?eyiU6i/oMsPISDCG6ino6Qezg/jlKU/gUSbB4MqEuCFW/vUnuji9TqEhORCI?=
 =?us-ascii?Q?HrHoTONbRuRfSrfeczD/D0XMxESePhCfzL8U2g03UCQnsM7BqBhcBWBC3URY?=
 =?us-ascii?Q?wNrG09GJ01ewJ7iT3WGErKdlc5BjHwyIZIOzOvjk3U84EtHogY/0LOieTBrG?=
 =?us-ascii?Q?ekrIjsOxfCVk2KxF1ecLyPmeitiC8+jZE7F6aivNd3Krax1oq99v8cCylrNf?=
 =?us-ascii?Q?y7WuN3voMtRS/DB/ndLwnpRyRE1BYsY+1ipmw7qUPOLpzgX2jJBjFLKt5H+t?=
 =?us-ascii?Q?w96qgacER1tKVD14eEibPcpg1KHYwsEGNJvr3rZuYnO8DoPU/H4wP/vU1XSp?=
 =?us-ascii?Q?8hXLJ/QxgIDC90L/gIGnA/iWI37zXCW3ki6VHRpydOBVPDbRyrR/iMvZ5PFY?=
 =?us-ascii?Q?VZhqC4sx9VOQzBdQ4BrH2TvMtky0uxnUlTi1IxAIpEDP+eX4pxtWNFPO+WLH?=
 =?us-ascii?Q?EMy4yYWnuX4NTlJ4e3NY4jZzOuuH7we66jc5qFZGYyPsBanHPl4fTLHumSRy?=
 =?us-ascii?Q?1ZyEqfVFBm4MF3kpdDJh4poyEKnnsUqv3Kccrez8FDj9IW4Q+nE/GOfZFZuT?=
 =?us-ascii?Q?Iz5r3FChPMKg3b+u0Xe2TQOK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d986e06e-56f3-412f-ded4-08d8efe317f9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 23:09:51.4429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEQo75x8SSayj5J1MOerlnwwL6CsgaX5hGlTI2WyzoanvVFZUCRmoA/unMMctMdyb1VPZYrckYODH5lLNsBPt+0I2X3SuA/mHeOAZrqbQWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3987
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103250170
X-Proofpoint-GUID: 4gzdoo56Y-R2duWh3zbZvd8N7oH8hp0J
X-Proofpoint-ORIG-GUID: 4gzdoo56Y-R2duWh3zbZvd8N7oH8hp0J
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250170
Message-ID-Hash: MFTYIYNJYH4SFJJ7GYV7AVMTR4PCC2ED
X-Message-ID-Hash: MFTYIYNJYH4SFJJ7GYV7AVMTR4PCC2ED
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MFTYIYNJYH4SFJJ7GYV7AVMTR4PCC2ED/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hey,

This series, attempts at minimizing 'struct page' overhead by
pursuing a similar approach as Muchun Song series "Free some vmemmap
pages of hugetlb page"[0] but applied to devmap/ZONE_DEVICE. 

[0] https://lore.kernel.org/linux-mm/20210308102807.59745-1-songmuchun@bytedance.com/

The link above describes it quite nicely, but the idea is to reuse tail
page vmemmap areas, particular the area which only describes tail pages.
So a vmemmap page describes 64 struct pages, and the first page for a given
ZONE_DEVICE vmemmap would contain the head page and 63 tail pages. The second
vmemmap page would contain only tail pages, and that's what gets reused across
the rest of the subsection/section. The bigger the page size, the bigger the
savings (2M hpage -> save 6 vmemmap pages; 1G hpage -> save 4094 vmemmap pages).

This series also takes one step further on 1GB pages and *also* reuse PMD pages
which only contain tail pages which allows to keep parity with current hugepage
based memmap. This further let us more than halve the overhead with 1GB pages
(40M -> 16M per Tb)

In terms of savings, per 1Tb of memory, the struct page cost would go down
with compound pagemap:

* with 2M pages we lose 4G instead of 16G (0.39% instead of 1.5% of total memory)
* with 1G pages we lose 16MB instead of 16G (0.0014% instead of 1.5% of total memory)

Along the way I've extended it past 'struct page' overhead *trying* to address a
few performance issues we knew about for pmem, specifically on the
{pin,get}_user_pages_fast with device-dax vmas which are really
slow even of the fast variants. THP is great on -fast variants but all except
hugetlbfs perform rather poorly on non-fast gup. Although I deferred the
__get_user_pages() improvements (in a follow up series I have stashed as its
ortogonal to device-dax as THP suffers from the same syndrome).

So to summarize what the series does:

Patch 1: Prepare hwpoisoning to work with dax compound pages.

Patches 2-4: Have memmap_init_zone_device() initialize its metadata as compound
pages. We split the current utility function of prep_compound_page() into head
and tail and use those two helpers where appropriate to take advantage of caches
being warm after __init_single_page(). Since RFC this also lets us further speed
up from 190ms down to 80ms init time.

Patches 5-10: Much like Muchun series, we reuse PTE (and PMD) tail page vmemmap
areas across a given page size (namely @align was referred by remaining
memremap/dax code) and enabling of memremap to initialize the ZONE_DEVICE pages
as compound pages or a given @align order. The main difference though, is that
contrary to the hugetlbfs series, there's no vmemmap for the area, because we
are populating it as opposed to remapping it. IOW no freeing of pages of
already initialized vmemmap like the case for hugetlbfs, which simplifies the
logic (besides not being arch-specific). After these, there's quite visible
region bootstrap of pmem memmap given that we would initialize fewer struct
pages depending on the page size with DRAM backed struct pages. altmap sees no
difference in bootstrap.

    NVDIMM namespace bootstrap improves from ~268-358 ms to ~78-100/<1ms on 128G NVDIMMs
    with 2M and 1G respectivally.

Patch 11: Optimize grabbing page refcount changes given that we
are working with compound pages i.e. we do 1 increment to the head
page for a given set of N subpages compared as opposed to N individual writes.
{get,pin}_user_pages_fast() for zone_device with compound pagemap consequently
improves considerably with DRAM stored struct pages. It also *greatly*
improves pinning with altmap. Results with gup_test:

                                                   before     after
    (16G get_user_pages_fast 2M page size)         ~59 ms -> ~6.1 ms
    (16G pin_user_pages_fast 2M page size)         ~87 ms -> ~6.2 ms
    (16G get_user_pages_fast altmap 2M page size) ~494 ms -> ~9 ms
    (16G pin_user_pages_fast altmap 2M page size) ~494 ms -> ~10 ms

    altmap performance gets specially interesting when pinning a pmem dimm:

                                                   before     after
    (128G get_user_pages_fast 2M page size)         ~492 ms -> ~49 ms
    (128G pin_user_pages_fast 2M page size)         ~493 ms -> ~50 ms
    (128G get_user_pages_fast altmap 2M page size)  ~3.91 ms -> ~70 ms
    (128G pin_user_pages_fast altmap 2M page size)  ~3.97 ms -> ~74 ms

The unpinning improvement patches are in mmotm/linux-next so removed from this
series.

I have deferred the __get_user_pages() patch to outside this series
(https://lore.kernel.org/linux-mm/20201208172901.17384-11-joao.m.martins@oracle.com/),
as I found an simpler way to address it and that is also applicable to
THP. But will submit that as a follow up of this.

Patches apply on top of linux-next tag next-20210325 (commit b4f20b70784a).

Comments and suggestions very much appreciated!

Changelog,

 RFC -> v1:
 (New patches 1-3, 5-8 but the diffstat is that different)
 * Fix hwpoisoning of devmap pages reported by Jane (Patch 1 is new in v1)
 * Fix/Massage commit messages to be more clear and remove the 'we' occurences (Dan, John, Matthew)
 * Use pfn_align to be clear it's nr of pages for @align value (John, Dan)
 * Add two helpers pgmap_align() and pgmap_pfn_align() as accessors of pgmap->align;
 * Remove the gup_device_compound_huge special path and have the same code
   work both ways while special casing when devmap page is compound (Jason, John)
 * Avoid usage of vmemmap_populate_basepages() and introduce a first class
   loop that doesn't care about passing an altmap for memmap reuse. (Dan)
 * Completely rework the vmemmap_populate_compound() to avoid the sparse_add_section
   hack into passing block across sparse_add_section calls. It's a lot easier to
   follow and more explicit in what it does.
 * Replace the vmemmap refactoring with adding a @pgmap argument and moving
   parts of the vmemmap_populate_base_pages(). (Patch 5 and 6 are new as a result)
 * Add PMD tail page vmemmap area reuse for 1GB pages. (Patch 8 is new)
 * Improve memmap_init_zone_device() to initialize compound pages when
   struct pages are cache warm. That lead to a even further speed up further
   from RFC series from 190ms -> 80-120ms. Patches 2 and 3 are the new ones
   as a result (Dan)
 * Remove PGMAP_COMPOUND and use @align as the property to detect whether
   or not to reuse vmemmap areas (Dan)

Thanks,
	Joao

Joao Martins (11):
  memory-failure: fetch compound_head after pgmap_pfn_valid()
  mm/page_alloc: split prep_compound_page into head and tail subparts
  mm/page_alloc: refactor memmap_init_zone_device() page init
  mm/memremap: add ZONE_DEVICE support for compound pages
  mm/sparse-vmemmap: add a pgmap argument to section activation
  mm/sparse-vmemmap: refactor vmemmap_populate_basepages()
  mm/sparse-vmemmap: populate compound pagemaps
  mm/sparse-vmemmap: use hugepages for PUD compound pagemaps
  mm/page_alloc: reuse tail struct pages for compound pagemaps
  device-dax: compound pagemap support
  mm/gup: grab head page refcount once for group of subpages

 drivers/dax/device.c           |  58 +++++++--
 include/linux/memory_hotplug.h |   5 +-
 include/linux/memremap.h       |  13 ++
 include/linux/mm.h             |   8 +-
 mm/gup.c                       |  52 +++++---
 mm/memory-failure.c            |   2 +
 mm/memory_hotplug.c            |   3 +-
 mm/memremap.c                  |   9 +-
 mm/page_alloc.c                | 126 +++++++++++++------
 mm/sparse-vmemmap.c            | 221 +++++++++++++++++++++++++++++----
 mm/sparse.c                    |  24 ++--
 11 files changed, 406 insertions(+), 115 deletions(-)

-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
