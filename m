Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A152B349CAC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Mar 2021 00:10:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 05D1E100EB353;
	Thu, 25 Mar 2021 16:10:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2E5C9100EC1C8
	for <linux-nvdimm@lists.01.org>; Thu, 25 Mar 2021 16:10:32 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNA6go136814;
	Thu, 25 Mar 2021 23:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=lPo7Ti03CLdH4oj2DM8QS4tfFwfDCyyGc1h07TMfb2U=;
 b=SCJu1NnZxzGgLQ7S7QXfreRj7QqgRg2lsJnIyOXFE/AUTpKi5EdiyGtOGs7ZFLgsbigw
 0PC/bH2LCQPzPkRc4epDpPN+QDTPj/i3cTjIb/dltxRmwdte0s6KSVmToBdFRRjt1CRX
 HA4dDXNwWxK5A9+OClMW52QQyx0X+lBGG0IXwmWcq9NEzmtTXjaqgoPfndFRCB/IZhtz
 QQOg6IFMnHjZCJTjlLnWR0eEZHOcGsjYRB54qFYZnxhvqtSGXKBuUyEaCLCepK0O3Mcz
 v3iIgaOebqxsMOy/qlYsg2f0QJV338vIlTfUyGP5URY2ymr/UED42eUsiCf3RsCZ55J9 nw==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 37h13e8dxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PN1Ko6002948;
	Thu, 25 Mar 2021 23:10:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by aserp3030.oracle.com with ESMTP id 37h140nhh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlNOMrkhrGa8uNUt9EJC6kYU9JVSQi8xV9ga4v7MxEjy4qTAmsuUg+tBHx5wMizNXLd43tP9l2OjGl7R4qsI8lsObt4hnPzH03KYpprvKD1tbpmwPXMtFk++685K6xio/RCqTMqCewhSSc4KQuTmnp07WI9Vc9AFhHgt+w9IHR6noj4H2ioG1X7/LIePA/npZMY3X8MwdQEVHZsKVmgvhP3Ig9BYMRpCzGeQXnBPrmupwvBczZ2dbijqXgCIdFWKNHvxolmn8P1c+X1t5XgXqO4KkWA7mbExmrggBCnNGzSOOzs02hIvgk8iS+OxdSaEe720dx/Ak3llTAAzlz7KGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPo7Ti03CLdH4oj2DM8QS4tfFwfDCyyGc1h07TMfb2U=;
 b=oOB69t4RKHex0+j9nt9T+TZlayMIb7cN/AJXiHA/YuVTNo2j+Dh4LNQELGO3cnkcB2Smw4lNYMTzZ7VASEQ2t1uWJmbd47j5KMvbmvgS6xNLWfIPFlhUMmdYueS+NSFaHlP6MuF0zY/aBspyKclWM1ALm1Yz98bbxxpntzd29TClIW0VGAQzPL5M+rJZ2C0CBHgcP1I3hsBajWb8QqgE4p8OEVLhY5BPO7LMh8owyKtTOlMGNUklVvhKQopc+ELzT0cIWONUdZ7SKesEW6rRtQTGvB+171rTmL80ad90QeUMe4Evuy544hRJmRGcP8MopfkaTDIO1uyzcYtRfEbHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPo7Ti03CLdH4oj2DM8QS4tfFwfDCyyGc1h07TMfb2U=;
 b=bYxTxW3KR0QJo2ptTtesjdAVIsZQb3SuLXpWlx9aK3F2yk+8wvvjkToU1tz0pgc+Wi1YmabefNTF9i7d0VIrSw2boZ8e4cAUIGPiSOk0kcJmy5hi4mU/prlHGZfQ0NzgD3v3svXQtHVoXs/nJGhtdzsFBUpzn1fHE438kALAgHc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2853.namprd10.prod.outlook.com (2603:10b6:a03:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 23:10:20 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 23:10:20 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 09/11] mm/page_alloc: reuse tail struct pages for compound pagemaps
Date: Thu, 25 Mar 2021 23:09:36 +0000
Message-Id: <20210325230938.30752-10-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210325230938.30752-1-joao.m.martins@oracle.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::22) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 23:10:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad2cc3f9-8144-4bc0-5b37-08d8efe32952
X-MS-TrafficTypeDiagnostic: BYAPR10MB2853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB28530A6A1B7D3297BC27E292BB629@BYAPR10MB2853.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	C+le9RwC/ssugtmFYnZxMmv9+VJj3BKbPX2Oxefp2BU8ZZbjgd9m0lxPaaNzw3rkUKyzp0mnYYPI6uKUXBTK2RkZgs9QDdZUsKTZUkSr5A7MNJmI7sTf61ZT8h2Osq9CWyW3SbE0pHiwMq7Nxr0yM3lsWKYS2lt+d6kt01VSeJqgojENHdELCyZBlmCwp6/gWjkrNesKJI8U71ofc0N+HArGp44Po2huE/GQjVK94MTJ4IkMuKoD4bys9SDCAd1c/WxOYdy01tK/ZYvtnbYK+5koiH8daIKuTW6pUm4MyhyltAnwIs+TAl7Uejm/eebO8S3itcHbSHOb7gr/4tUfPpSOQfNka7PlX4HpEu5dPY8kiPVJDaKtwPT3D7YJAdV+vXLb+Pe89lVuamN+0sv/iwudFo6iBG7yljvMxWz31n45iSLy0oVRhUXVVl19K04JcpqKhKEKzYeRN/vHJI7fydCbU4PK5j5g2FlO3Jcbgw50G57fRQfkfjjVvaCY+FyWZo2o0lDiI3doQot2VaovTaNkRM9fAIWRcWjuN241tZwP1aPLKct+WkAHyj95BaBEcaQSmepuPlhthAVWHTWebj+uC6P6Kf+tP2oxbq6jh3NTWHwegfQetRPLg8BSo3o7UxWtB9WYcgi2pZMmwQZZIG+Yj99sPE5jnVC3LNzO9R0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(396003)(366004)(136003)(38100700001)(4326008)(8676002)(1076003)(2616005)(8936002)(956004)(6666004)(6916009)(107886003)(66476007)(478600001)(103116003)(86362001)(186003)(83380400001)(7696005)(5660300002)(52116002)(316002)(66556008)(6486002)(36756003)(16526019)(2906002)(26005)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?15hNaVsw1F0i21kGlUWylfbw3kiFhsYcxUlbqo6x1MxYxMidB1BkXXVbHWZ3?=
 =?us-ascii?Q?mmNQTV1QMKuxmA1GpxZcqTF46kJ3MUuaeQhI6SWER/DxTLSD+MJbJcJtlaTy?=
 =?us-ascii?Q?2Rb8YlwtIAGgVb3zi5Ev4uvP9ptD1+U1eXiouQkuu+IYv+QIqNntH4on3orO?=
 =?us-ascii?Q?/uf+Q0bTXHdjnDy0tM8IaX7iLeFe7EsfFDyHceaeugUBw/SJIIcedppD7bkw?=
 =?us-ascii?Q?hNMVNTHhybsvVM6pW9sr2be6syngH7Rv9ZunNDbWrLGOjPmzKJIl7TONRfGX?=
 =?us-ascii?Q?ag6qeYibkEEiGSrrq3KFyWv5AAE0hJ5TRnr9R4VFEVC5Q/U2YXkfjjOyu1uP?=
 =?us-ascii?Q?GpGVZCDvjrOsWfNxUNY+XA+28fdzW0a+lCfDYVInxkmllwoJaIamAhF6w5ob?=
 =?us-ascii?Q?Hs2NyLVEH76gPRO/J6IAcFDvYubMvZqVd3YuIo62/kGYs0lQppyV2OgVyuKu?=
 =?us-ascii?Q?95b3zDSJ5qMzRtlpUflYqCJP6bkYfA7zSZLLNCOtasNH/qLD0Lp8jpIW4qyO?=
 =?us-ascii?Q?iNJMjdxiW11WIkatkhUwV9ooQHrNjH9WgAVEaT8dgvWOikuIxp8XjPg7mXBL?=
 =?us-ascii?Q?1Cm2UQV6hNrFB2Msc9f8GwRFUKwTKS0meJ19gP+5NuKa6ExbssZoA5N+zb+3?=
 =?us-ascii?Q?DC90eKwzWzIz0F7sFDPIyd0OshZ80h4LUDhrK7lWENnSva6LeLZik+WdNu0F?=
 =?us-ascii?Q?vKTWdsxEokrU6K7MqrJd4F1fJF+ZjYpAFov9fIIwhleF3ETJvmUpOmDWzSbS?=
 =?us-ascii?Q?rtwGi6tJFaxuw3384O52XvpbehAV7rzsHo3JPoI9OruPuqS23E7il22dmn13?=
 =?us-ascii?Q?3ft2/DcKR2JDGOfvao4TQ65//nIIknkj0MHBFb72G7YHT+iDwXlH81nVN3j/?=
 =?us-ascii?Q?RDXUKzC5HV83rsZKF8cywLcB1FaiS+hZATERvOGaQd7b0aNJXLPLZlRfyrZl?=
 =?us-ascii?Q?jkyiAKuNLpVQr/IDgp8xdYuRABF+DFxaKHNJICmyJNfUioTFC98blfphdYxp?=
 =?us-ascii?Q?JNt5L5lYFzvGbYEDvmXySvMDjnHhNmOdfWHX2+ybwlybXMkcAPtFU26lg/f9?=
 =?us-ascii?Q?RlQxGcVv1O9gXypYpL0B07iE+bbHsb3DkmloFtei5BAqFb/btqC2mYfWYG63?=
 =?us-ascii?Q?9Gd4humfSIPtGOw04DUbhfpTp3YghZITCX2+q9FzyX101HceOHpk/mNf9PGF?=
 =?us-ascii?Q?PsLWNWSNCeyXWsXEnpHLEGnhPtVo6hayeoW2DLbDcee3HQdI3NFLueGB/txp?=
 =?us-ascii?Q?X8nGKqXd/ZFhfB5WaGVWlpBkv+5RacnFYDUjdXIDQeda8vmv4xwaCIAVeXYu?=
 =?us-ascii?Q?+Elabcxc8kJdRB8zf6Cy74fC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2cc3f9-8144-4bc0-5b37-08d8efe32952
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 23:10:20.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bZPo4M1iS9RArrgZTQ4scNML5a0J6knRCS+/uOZ9gNge7AH/s+p8QYPJjr5HY5qCSByHfy43kQzC7adwUxIVpJugzjYql483LLDw1vo7WA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2853
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103250170
X-Proofpoint-ORIG-GUID: 9SFP2AaPkjf1RiUFbRtNNwvkEne0BrnQ
X-Proofpoint-GUID: 9SFP2AaPkjf1RiUFbRtNNwvkEne0BrnQ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250171
Message-ID-Hash: L45MA2DKCKWRLY4KTD2DJ7O3KYD4I7Z5
X-Message-ID-Hash: L45MA2DKCKWRLY4KTD2DJ7O3KYD4I7Z5
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L45MA2DKCKWRLY4KTD2DJ7O3KYD4I7Z5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When a pgmap @align is set, all pages are mapped at a given huge page
alignment and thus uses compound pages to describe them as opposed to a
struct per 4K.

With @align > PAGE_SIZE and when struct pages are stored in ram
(!altmap) most tail pages are reused. Consequently, the amount of unique
struct pages is a lot smaller that the total amount of struct pages
being mapped.

When struct pages are initialize in memmap_init_zone_device, make
sure that only unique struct pages are initialized i.e. the first 2
4K pages per @align which means 128 struct pages, instead of 32768 for
2M @align or 262144 for a 1G @align.

Keep old behaviour with altmap given that it doesn't support reusal
of tail vmemmap areas.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 mm/page_alloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3a77f9e43f3a..948dfad6754b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6277,6 +6277,8 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 }
 
+#define MEMMAP_NR_PAGES	(2 * (PAGE_SIZE/sizeof(struct page)))
+
 void __ref memmap_init_zone_device(struct zone *zone,
 				   unsigned long start_pfn,
 				   unsigned long nr_pages,
@@ -6287,6 +6289,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	struct vmem_altmap *altmap = pgmap_altmap(pgmap);
 	unsigned int pfn_align = pgmap_pfn_align(pgmap);
 	unsigned int order_align = order_base_2(pfn_align);
+	unsigned long ntails = min_t(unsigned long, pfn_align, MEMMAP_NR_PAGES);
 	unsigned long zone_idx = zone_idx(zone);
 	unsigned long start = jiffies;
 	int nid = pgdat->node_id;
@@ -6302,6 +6305,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	if (altmap) {
 		start_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
 		nr_pages = end_pfn - start_pfn;
+		ntails = pfn_align;
 	}
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfn_align) {
@@ -6315,7 +6319,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 
 		__SetPageHead(page);
 
-		for (i = 1; i < pfn_align; i++) {
+		for (i = 1; i < ntails; i++) {
 			__init_zone_device_page(page + i, pfn + i, zone_idx,
 						nid, pgmap);
 			prep_compound_tail(page, i);
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
