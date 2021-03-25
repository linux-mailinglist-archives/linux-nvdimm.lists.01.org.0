Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 301E4349CAD
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Mar 2021 00:10:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 23B90100F2265;
	Thu, 25 Mar 2021 16:10:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8FA7A100EC1C8
	for <linux-nvdimm@lists.01.org>; Thu, 25 Mar 2021 16:10:32 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNA6x3136815;
	Thu, 25 Mar 2021 23:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=QddfEmjhRawgkFyzqoIhPYD+mvuoYVgtUhKerFl839Q=;
 b=cseMEbiRGLJTrL0DBT7xYPVGMVSmx1wyS6dpYXKx7syqiMeqgk52Oawf40JRXUTw60HK
 WqFT06Na4WidZs0E9/+s08dWhNcvRC90rlTxfjKNwO/AwXpe6bc2ls6qRl/Cgib9WoM8
 2hpww2/7IDyDs91sdO3KRkNUlKpQ1k5e/zFGFT/NsG6c8wVNqvqMv+Nkjd/Rt40ABny1
 5Nx6p+NFljKyybJIKaRbGL4IndeLWc92v2lZ+Pr3QaCNdioHh7NFdqNOktroks1rqhqU
 uC98BEIjBqC1z7erpzi5qubD1htiwRJ93lOxFHOtTO4N+YyZXoesRPDBVogJHT2U+npF 0A==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 37h13e8dxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNAJwI009531;
	Thu, 25 Mar 2021 23:10:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
	by userp3020.oracle.com with ESMTP id 37h14gdqdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOP4jXImOpb+0P2R4nQAL8P7obdUtuV9DqcqYBdoryZlTr06k1z5MAX+6S5/4TDUHzMnx3qVtPauMkbVk5r6mloZeHLhFvbPP8YPnoYlz5blgwUVwOOq5IVOcUZF7ltvHrI62B6uVecVckGzK1QvaKI5i09gJSujqc61EtsS5lLOYWigjYKNXQutZs3OdBXt6BIun3Y5+4Hq0aH3ylFgfo73FTjyn1wDBgPh1oHJ0nfAgfXHfUldRwI9k4AgrAqouxPn0B32F4ApEsEI2GW99Qoc0Xm/jrrqmPC2mYzhXeUNeSzvmb1JM6GUWJCD97EphjVx1cF0Sdif/83U2LcboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QddfEmjhRawgkFyzqoIhPYD+mvuoYVgtUhKerFl839Q=;
 b=lSpDGMA0sCKMNltrsxRB8cptI58yOapIZsKBI7dFAbkNjYz2MEso0r0TLf0BiGTlWHOfQL3Jft830xBK0phQGYen2jBgmjgWV6z4I9nW1Ell48C0K/9MuutNgW5fEiQByPNCBwLJmX4af5nQoXe5nwsORioM3ZreiV5D1MUhAZEe1bNF9E6rsV937NpcQLz213AHdJPeQXwDDA6XidreMLpq0q8G5bXGZh8VdoLUjdzDiogHN3DrASkUs2GO2xM3Lki7vT3VfhEqNf9GVNq7AE7kOnOdCtgVdTEQyqEgmuuBwGWlZi8gp7LdvplKTXK4xNlE5/iuGLX9Dmqd+PZ0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QddfEmjhRawgkFyzqoIhPYD+mvuoYVgtUhKerFl839Q=;
 b=yIFQM77oG1x0iDbTWEryTa9un+LZYeYdtKPIzTvW9S+I2morDnMWtCNSXys1klq3L9N7BZvHWplW2iqSeUeE27Jt0ShYxOhp63BCSNnkGhF+vCzI9s9nfPfD2AHZeaeLVk52hCDGnRvRfd7xIwHyIwrSN7YZAOELUN/MTVaOaKo=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB3987.namprd10.prod.outlook.com (2603:10b6:a03:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 23:10:13 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 23:10:13 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 07/11] mm/sparse-vmemmap: populate compound pagemaps
Date: Thu, 25 Mar 2021 23:09:34 +0000
Message-Id: <20210325230938.30752-8-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210325230938.30752-1-joao.m.martins@oracle.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::22) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 23:10:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 308d4f06-dd3a-4cf3-cefa-08d8efe32523
X-MS-TrafficTypeDiagnostic: BY5PR10MB3987:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB398725DA6E86EE189A5F4576BB629@BY5PR10MB3987.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UP7jnQ18G31lB1kKxkF+JG5uRVEn48ShcMtdmfO+X4G7Be0lk045mlqz6SaM1dsKlJQG6Qtf/8UuhOEsJd0Pb2E9RjKibP7hw77YH/LS1EqD6AKudLtRqLe96RTIcAuSxQuqv2l2DZz4uwXALlpr9YHFWKTqisFMiBCbznfuNV7GmZXpO3mseaqmTbHYwE97dOBhszIvaA/8avEqhqTGhgx0KEqBHfetzzrMv3ZsUKbOjAQYe85wAttvHE97o92hO0y/yMeGNPUepeQp8AAlFZasvm5t761+AxHVVzZFdE6K0HP1tvG+sJ0VGBWihxIk8yv/x2pkUpp0WMY4OvJ0P3AzBLHg4GwX2OpsWsvZVYE6bOTmxpeWw+TJs7E1BGmh7qGRFpPzz3pQXGhzAu9M/LeuNVRjtIKjRz4skBVztVaq5hPZXC6ptJqJ3pEVZ7bjZ12MvW/WUrmPot5DJeI/LDqPlG4w6OCthYjVa4t5bgoD3XAGlUMoC8tDetn+J0Av4mVC0+1x5ltyetASMIBiqKHAGq/E+gaKHEqD+zzG9D0Z89NC3h7szuV8I4wBfcHo06KhL3wJ6lHdKVnv7adNyOxhZUZUi2yXXecgcyr65BPXxrJ0MsQ4+omgPa+4n5KyAOiB+P2JyGit4DERdLewLg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(83380400001)(4326008)(26005)(107886003)(6916009)(36756003)(7696005)(52116002)(66476007)(66556008)(478600001)(66946007)(186003)(316002)(2906002)(8936002)(54906003)(2616005)(86362001)(8676002)(956004)(5660300002)(103116003)(1076003)(6666004)(38100700001)(16526019)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?OuTvKmN19YGFscccWvhDRD9OgEqxOIjeUwE/3ahV/VRcpb1KkVBWky2IOs9n?=
 =?us-ascii?Q?uj/CDNPOGafIrdZhPBu3FedFoQ00LfQt5yE2v52c8peTgHvYSTR9pOvEFRzW?=
 =?us-ascii?Q?5QlVdOrX5+5ou/T0fWwIvefReX9CvLrsadl0M+3r0Darj8zUJyWj3AQ3+XIs?=
 =?us-ascii?Q?vuXoodlEs3BcHhhMqpahl1lBRm8H+rrsMISRxJsmbyTM6y+Utid6azIW1x1y?=
 =?us-ascii?Q?XxSC5I6a5HoWcASjZemH24zdpzJJL4+A5uePuI7lmd4rxN1hwFrK7xKIZi5a?=
 =?us-ascii?Q?GHLpmvHQWs8nk2ThVC9WAIZ6PgAN35zJFl0cF9kRLb7Ol7N2+lwLZuplhY2o?=
 =?us-ascii?Q?kDZbYLUdzkUE3/MM/6+Fi6KgIdz+VWKzO3F8qtCsTTLJjjy0fN9DnWVhPpC2?=
 =?us-ascii?Q?DBwgYoJbsVTvOPcnpDAbrNEDLM2i6RTPNlU3bsin9rXqupGNdpTdnWZmcREu?=
 =?us-ascii?Q?rCfdoQv5qPGjyPapGGznucMT8nfHfAGaxF32Lysgg8dTRa8E4oc7E9DNf/o0?=
 =?us-ascii?Q?AFKXjds6c4n4HmLtsycezKbekwsAIMx9vyc5XPzFndGgn7TXYE5cPNze8Uin?=
 =?us-ascii?Q?EeTgxNE2+AiTXjEpeO4yAsSReFWyoYgIEHA0/zu/DCEjPmRejnoAYbRcB7Jg?=
 =?us-ascii?Q?90U+if46gXsgg0LEa2MN4JXJxinBc/CxauCsGvQ8lm0WGPAXwFJaKjEGdLHY?=
 =?us-ascii?Q?HuZTAHfWpLEXIq+6fYktBlXk30gH6CJqIo9cf3g1/vNHcGxHRepML+W9tZB9?=
 =?us-ascii?Q?nzO43gxOFLJTzBOWdWF5qtDV5Oeyp/+fRup5dljc2KtqzZ1FcEKvfcOk9EVZ?=
 =?us-ascii?Q?OdPCVe3bLT1Q0lNiyCetV+CcYxXuax4NAH5r2wX9xarVs6o/GsT3XruwGJHU?=
 =?us-ascii?Q?F8HqIb/BDRRslS7dDYJKohIhBACtsxs38aPwDnJZRYLjyX/j/mhuTGHkq1aU?=
 =?us-ascii?Q?LgIimxgo8x9MR0gKJb0oE59urJ4SRssx2e51Kw8QdmgoOumN6B7rFFyEQBuf?=
 =?us-ascii?Q?jsEHrRpoKpIagytu7TdNs/ST28OdoN3sd7c5K0n6Vh70WlkdV2hbnnb/v5x9?=
 =?us-ascii?Q?RIX8v2Es4PdNIIjstnfqzKEEBm2dAzVLQZYkZIdmdSnKb8HBQ7L/MG952O0R?=
 =?us-ascii?Q?gV2K4Vj6Yh7ibPq0hB4IUjQXBQ3udAMLACJAlaeunflzadSA/OHXxVi5J+gB?=
 =?us-ascii?Q?XSVaVbK0xI8lht0ScRq4c7dlkjnolfKHe7355J4IoEZx7F6A077fhNyJxxmw?=
 =?us-ascii?Q?MSJ7asaIK6t+d6xvzdOheqFZTNN7NJXADJGI+0Yb6gSxE76KCVphiQ3ta/9q?=
 =?us-ascii?Q?n19cPofHzlzr05SzIXXR4B4O?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308d4f06-dd3a-4cf3-cefa-08d8efe32523
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 23:10:13.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7e5n2naJqwC3/X8ObfL2eryTm4fFOdJfU+FLtT+fyyKibQl0iz93BUvy/BP7R5Fm6y0iqMtfwqO5i/IIaaoYQ4meig/4v1u4h2BQomYnV4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3987
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103250171
X-Proofpoint-ORIG-GUID: Ot2z5hX7jAYlurSVEuGHpS3W1JdAL1_k
X-Proofpoint-GUID: Ot2z5hX7jAYlurSVEuGHpS3W1JdAL1_k
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250171
Message-ID-Hash: FLTGWWYZFC73QL3JCXYK3J34GVIOSZ2W
X-Message-ID-Hash: FLTGWWYZFC73QL3JCXYK3J34GVIOSZ2W
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FLTGWWYZFC73QL3JCXYK3J34GVIOSZ2W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A compound pagemap is a dev_pagemap with @align > PAGE_SIZE and it
means that pages are mapped at a given huge page alignment and utilize
uses compound pages as opposed to order-0 pages.

To minimize struct page overhead we take advantage of the fact that
most tail pages look the same (except the first two). We allocate a
separate page for the vmemmap area which contains the head page and
separate for the next 64 pages. The rest of the subsections then reuse
this tail vmemmap page to initialize the rest of the tail pages.

Sections are arch-dependent (e.g. on x86 it's 64M, 128M or 512M) and
when initializing compound pagemap with big enough @align (e.g. 1G
PUD) it  will cross various sections. To be able to reuse tail pages
across sections belonging to the same gigantic page we fetch the
@range being mapped (nr_ranges + 1).  If the section being mapped is
not offset 0 of the @align, then lookup the PFN of the struct page
address that preceeds it and use that to populate the entire
section.

On compound pagemaps with 2M align, this lets mechanism saves 6 pages
out of the 8 necessary PFNs necessary to set the subsection's 512
struct pages being mapped. On a 1G compound pagemap it saves
4094 pages.

Altmap isn't supported yet, given various restrictions in altmap pfn
allocator, thus fallback to the already in use vmemmap_populate().

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/linux/mm.h  |   2 +-
 mm/memremap.c       |   1 +
 mm/sparse-vmemmap.c | 139 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 131 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 61474602c2b1..49d717ae40ae 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3040,7 +3040,7 @@ p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
 pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
 pmd_t *vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node);
 pte_t *vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-			    struct vmem_altmap *altmap);
+			    struct vmem_altmap *altmap, void *block);
 void *vmemmap_alloc_block(unsigned long size, int node);
 struct vmem_altmap;
 void *vmemmap_alloc_block_buf(unsigned long size, int node,
diff --git a/mm/memremap.c b/mm/memremap.c
index d160853670c4..2e6bc0b1ff00 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -345,6 +345,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 {
 	struct mhp_params params = {
 		.altmap = pgmap_altmap(pgmap),
+		.pgmap = pgmap,
 		.pgprot = PAGE_KERNEL,
 	};
 	const int nr_range = pgmap->nr_range;
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 8814876edcfa..f57c5eada099 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -141,16 +141,20 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 }
 
 pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-				       struct vmem_altmap *altmap)
+				       struct vmem_altmap *altmap, void *block)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
 	if (pte_none(*pte)) {
 		pte_t entry;
-		void *p;
-
-		p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
-		if (!p)
-			return NULL;
+		void *p = block;
+
+		if (!block) {
+			p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
+			if (!p)
+				return NULL;
+		} else if (!altmap) {
+			get_page(virt_to_page(block));
+		}
 		entry = pfn_pte(__pa(p) >> PAGE_SHIFT, PAGE_KERNEL);
 		set_pte_at(&init_mm, addr, pte, entry);
 	}
@@ -217,7 +221,8 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 }
 
 static int __meminit vmemmap_populate_address(unsigned long addr, int node,
-					      struct vmem_altmap *altmap)
+					      struct vmem_altmap *altmap,
+					      void *page, void **ptr)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -237,10 +242,14 @@ static int __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd = vmemmap_pmd_populate(pud, addr, node);
 	if (!pmd)
 		return -ENOMEM;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap);
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap, page);
 	if (!pte)
 		return -ENOMEM;
 	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
+
+	if (ptr)
+		*ptr = __va(__pfn_to_phys(pte_pfn(*pte)));
+	return 0;
 }
 
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
@@ -249,7 +258,110 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 	unsigned long addr = start;
 
 	for (; addr < end; addr += PAGE_SIZE) {
-		if (vmemmap_populate_address(addr, node, altmap))
+		if (vmemmap_populate_address(addr, node, altmap, NULL, NULL))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int __meminit vmemmap_populate_range(unsigned long start,
+					    unsigned long end,
+					    int node, void *page)
+{
+	unsigned long addr = start;
+
+	for (; addr < end; addr += PAGE_SIZE) {
+		if (vmemmap_populate_address(addr, node, NULL, page, NULL))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static inline int __meminit vmemmap_populate_page(unsigned long addr, int node,
+						  void **ptr)
+{
+	return vmemmap_populate_address(addr, node, NULL, NULL, ptr);
+}
+
+static pte_t * __meminit vmemmap_lookup_address(unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset_k(addr);
+	if (pgd_none(*pgd))
+		return NULL;
+
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
+		return NULL;
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud))
+		return NULL;
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd))
+		return NULL;
+
+	pte = pte_offset_kernel(pmd, addr);
+	if (pte_none(*pte))
+		return NULL;
+
+	return pte;
+}
+
+static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
+						     unsigned long start,
+						     unsigned long end, int node,
+						     struct dev_pagemap *pgmap)
+{
+	unsigned long offset, size, addr;
+
+	/*
+	 * For compound pages bigger than section size (e.g. 1G) fill the rest
+	 * of sections as tail pages.
+	 *
+	 * Note that memremap_pages() resets @nr_range value and will increment
+	 * it after each range successful onlining. Thus the value or @nr_range
+	 * at section memmap populate corresponds to the in-progress range
+	 * being onlined that we care about.
+	 */
+	offset = PFN_PHYS(start_pfn) - pgmap->ranges[pgmap->nr_range].start;
+	if (!IS_ALIGNED(offset, pgmap_align(pgmap)) &&
+	    pgmap_align(pgmap) > SUBSECTION_SIZE) {
+		pte_t *ptep = vmemmap_lookup_address(start - PAGE_SIZE);
+
+		if (!ptep)
+			return -ENOMEM;
+
+		return vmemmap_populate_range(start, end, node,
+					      page_to_virt(pte_page(*ptep)));
+	}
+
+	size = min(end - start, pgmap_pfn_align(pgmap) * sizeof(struct page));
+	for (addr = start; addr < end; addr += size) {
+		unsigned long next = addr, last = addr + size;
+		void *block;
+
+		/* Populate the head page vmemmap page */
+		if (vmemmap_populate_page(addr, node, NULL))
+			return -ENOMEM;
+
+		/* Populate the tail pages vmemmap page */
+		block = NULL;
+		next = addr + PAGE_SIZE;
+		if (vmemmap_populate_page(next, node, &block))
+			return -ENOMEM;
+
+		/* Reuse the previous page for the rest of tail pages */
+		next += PAGE_SIZE;
+		if (vmemmap_populate_range(next, last, node, block))
 			return -ENOMEM;
 	}
 
@@ -262,12 +374,19 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 {
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
+	unsigned int align = pgmap_align(pgmap);
+	int r;
 
 	if (WARN_ON_ONCE(!IS_ALIGNED(pfn, PAGES_PER_SUBSECTION) ||
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
-	if (vmemmap_populate(start, end, nid, altmap))
+	if (align > PAGE_SIZE && !altmap)
+		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
+	else
+		r = vmemmap_populate(start, end, nid, altmap);
+
+	if (r < 0)
 		return NULL;
 
 	return pfn_to_page(pfn);
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
