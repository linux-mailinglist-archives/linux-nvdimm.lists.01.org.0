Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C70AF349CAE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Mar 2021 00:10:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D668100F2275;
	Thu, 25 Mar 2021 16:10:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 00154100EC1C8
	for <linux-nvdimm@lists.01.org>; Thu, 25 Mar 2021 16:10:32 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNANo3136845;
	Thu, 25 Mar 2021 23:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=l+oIxM4yS48AwZPIlRoyiB81tsG53ciuXr1IICEm6OA=;
 b=zO4yOUzPUQygL/UJ15heZoGBpQQKMZ3H/BjE3HWfeDg93m7MJhbN2vd3uHbPFYpIwceD
 G+a2QLHxTyKckcrx4+pgn7e+KAUPlnVa+xhb71AVLjMSnCG09nk4Yi22SHx333dSlbR6
 MMs3W13CUagS5CFFJVjCvdRYZBoJOBrC7dNd2/QzfaKNo/bPR87ZoC7GaQI3ugcr+bmR
 jEX1ea4Er2CqbHHWhs1G8FjV0lz0cflZaLEJri/uujCKGlr9qHdqnJxrDhVER+LA0TTD
 Rt0k8IAAeAFgT/K5/zCCL60VtnhCE+l+dkl7CE644pbPf/7GXA79kqeqdXmd1s3Uw3UU XA==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 37h13e8dxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNAItT009261;
	Thu, 25 Mar 2021 23:10:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
	by userp3020.oracle.com with ESMTP id 37h14gdpy3-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kE0ZzokvVCjJBTuzXTgQm5tC5JHCwv3VHmR/ABG54VKWW9ooPWM5MWKS6HDUuuj2uriD0HOWya2xwbHHX3IERMFCZt4RcCVEe3WSHdBkab8TdUfAsTwWooDg0hw/h/VPvHUnESzZRv+dG/lbHsGb+WS68Yyg29LfN/oMfU+E6wb8qpRWRTh882Bmqv0IhTeL6ZOEwXOfK8vF7Q2UeaxbcHYORNlLsxM+abzUcjF1xJgD+6eWxHmazm+jdM8YOniRbs7QvQFAWkQ8vdHVjPx37j+s75TJ/Yrprtf0EdboJa8BusgXeMsj/MH3IXDwQvWT13AWAYZW9Dsna/uolsS4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+oIxM4yS48AwZPIlRoyiB81tsG53ciuXr1IICEm6OA=;
 b=R4iNsOcat1TIEuSkERaRfEn14ywAAjAiqApajubP4WKt1AzdSD9KO5SKO4C9O+3DIO6wU3tZq4aZ4hnFYzjAnwo1YFp3dw2Zz+pw4zXqCXza4/yzjlE/UaMd9ixfuh9mjAFOjaVsHfh0Ba09qgdczfx33nUbM775lxBOmT74QrcwF8TZX6Rj/Li31xaOPrAdPwt4l6GdAUQCMdu0WE7bZTmItmRtTrqG6cFCzTCh9ZUMOcuzZgBqo3MEuaTQ5g0n0Uwp4fwMWpLDXc0Ze1xChCaq6yOuoR6W3GkxsmC7QQ7mLLaaiB2dDWqvMeAJQA1ejn0UfxFhmEJ069ogPlfG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+oIxM4yS48AwZPIlRoyiB81tsG53ciuXr1IICEm6OA=;
 b=FFGw5i4EeTa3bMGJh8/5nReUtUjlg9ar8raK5NSZjcHW8mFvm76GBxXujoiOcbWlNOYEXjWrWsur49HbCyyhuSOylw6amESGpYfuNetDvCOL+WuPy2d+OTa8/UGJWUFNnDG2yRROy0BL21CabRG1jSQu2rq/b80Q+PLyCI7mnDA=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB3987.namprd10.prod.outlook.com (2603:10b6:a03:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 23:10:10 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 23:10:10 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 06/11] mm/sparse-vmemmap: refactor vmemmap_populate_basepages()
Date: Thu, 25 Mar 2021 23:09:33 +0000
Message-Id: <20210325230938.30752-7-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210325230938.30752-1-joao.m.martins@oracle.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::22) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 23:10:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 004aeac3-4deb-4908-db61-08d8efe32347
X-MS-TrafficTypeDiagnostic: BY5PR10MB3987:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB3987DAC47892E4373FDCA9FEBB629@BY5PR10MB3987.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	22S/stCPQ7HqSlGdw3zLYjBa1C9pAaSHlafdKYpa5GYD1FrRcviUy3N+VyKkNP4i6xHPljmf38BpSe0aEsI42hto5FPEOlktxx07/8TCbgu+HOdFscyWli7MjiJDshQk9+POHWH2aTSiBYe83LjjwGs+SQ40C40/WVAuvo37K+WxkTttjRieSPDmlVQIINS/dbolRgSSAV1DDrOaqzG/4ChsG3itAy2UoMUvQnSYLEirhQL8Qe1ndMj82Y6LY2bX42pgwEbBJEMP8Hc4ucoUGMp3WKqhAGktVbrifDMrIyigfcaFLdGcUnOS3Ykuz4cEtRZJRUhfszXffOuWv3FNdJW0MNK9eZaSpD7VFQapBgqGudh6AHADtWdqUe333x9oJSqmTpK8l6vjgXLdeMS9PB93xKLEOLJNcxS56RzPxrA1fAR4ZmyxrYRXVLr/LXs69ikyuB4Ot9KWKrt+bDmKZ21hTKnLCnj4+i6l+xc/Hl9sqW12f2e+9KsUsMkuwr2eQjPeaHVi9ZqpHiq0WYHh+ORMI75Si7yWSyse4J3PyMLOpK8JXm6E37UfIHBq7Y3QN7thumnwYQZHpMpOIM6gjqbexqFv+UewSm16VAuqqpE+FzP2tj4faJamx8YmUzdLmeTi7zqzJSlkqVSE0d0hUvIpikvim4fMA1FiIv7isTE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(83380400001)(4326008)(26005)(107886003)(6916009)(36756003)(7696005)(52116002)(66476007)(66556008)(478600001)(66946007)(186003)(316002)(2906002)(8936002)(54906003)(2616005)(86362001)(8676002)(956004)(5660300002)(103116003)(1076003)(6666004)(38100700001)(16526019)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?nLmKkAepXl0LlUEt4E47SXSie6tdX2iGDfUiJw5/Lo6MnpHD4gf3lMdZM2LL?=
 =?us-ascii?Q?q0Wjch11KOoLFhTf5IWJjX3lF0sHLm9eMohatHqytQghllh/WwXfI6t/ljNT?=
 =?us-ascii?Q?/gYIzL+bTJds9fQji07rI+vChJnwOPILUWJZI4VEqhvq6b7L36AChp3wQonL?=
 =?us-ascii?Q?PXzPLXcjpSJRNyJ/wbnajnIrAIdqmUp9FvO332d2COl7ixKm+jVMrPERTCyT?=
 =?us-ascii?Q?jCQYYiU28pSF6c7T59sbMr2DmUDMUUaDZkm46w94Vltgr7GU0DuzdqDo2gSn?=
 =?us-ascii?Q?nSyknSPkxjA9JBtlrP+2g2e5BvAgyaDvStAyg8rUxniovwydJhwh5IL/qJQM?=
 =?us-ascii?Q?M2b1EbyeGpy6BMwEwQDu6t9wk6iEo9UGsk5RMlU3Tu4ZW/i4d8MxhzrQMkjT?=
 =?us-ascii?Q?aUQs+2ydN0CLX5Fmv8zfEYc+76kaRP8tmz6rrVoQBU5fZ6Ke959UjAQlfdWL?=
 =?us-ascii?Q?zbZ98WkOMvIYI2pf8i4gjIrFuFCis43Ft+CH8T/SNJHYuwm66txX94qOPCH5?=
 =?us-ascii?Q?hntSdd2x2QEU9/wE1jNkH99vmnoqk838/P1gboyZV7w/oUyaRhx5jrTPr+mZ?=
 =?us-ascii?Q?2S3zgjx3QIu+bDmTG06tj2tP/E9uB5Bt/Rfs9CV07leYU4WmP7AhXwMRjm7d?=
 =?us-ascii?Q?44q9uxwB11sZLoR6bR74Mr/ZcQw1D7SWDq/ikCJqf67gfldHZhkMCxdrulVl?=
 =?us-ascii?Q?J+LvBKRMJRBV6k3kbs9B76pxqYpWH4e+Y72czl67V4Tu3XfpqxRx9G6uclxK?=
 =?us-ascii?Q?HIK+XQeoL8aUI2zmj7BUr36gBApV6rDIgdsvRsflmB/oDn903k1QqZFhg+8s?=
 =?us-ascii?Q?JeyK37goJHeGvmzJUW3konNoYebmCLplh2GdH75OzLpP677B76T4AyXuOqqB?=
 =?us-ascii?Q?JgeYXZcFkYLrGntDVgvjpFU0RPWeXqWVHPmG/WXyBIGOcPZCvcnUMDbIqKni?=
 =?us-ascii?Q?Mj0QZgbyZjboaXHRSAQ4bilqkeREQ0CO8xx9v9Ty6X6FCEiEa0688fCpRq4o?=
 =?us-ascii?Q?rgf+36G/yWvl8drggoR01K+S7DaJT++tRr0HKHMttCqripZpTjX1QJXMs5Md?=
 =?us-ascii?Q?ZmdbNpDUBpjcp36F461BtZtHBmL7rgLAeus1d2Jg2HZ3A0BKwfkG6T4NVNih?=
 =?us-ascii?Q?81fHGAT2iqIRglFLivb2zgaTMhtQGERyGWrZJsDEQL8in37HxS5/5CCUL4/9?=
 =?us-ascii?Q?gNNnneIwYpRNPn43f7kDEVPsjGw0I3ar7DyoPfLld2yx6Ks+d+dy5Wi49xVQ?=
 =?us-ascii?Q?acGGaAMWiH9UHozWwGSz5CtMrKl3+gvGM3+qHAbSQ72SQWE+VRAOlMjMwpgL?=
 =?us-ascii?Q?HYZls6QeffjsMwvXnaySYtVY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004aeac3-4deb-4908-db61-08d8efe32347
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 23:10:10.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUfBfa8QdKinRu4vL4Fwfk8yAnNuW+gMXjoZD16oja5PoEgwhs26rPend95vmPbsRGTZPAeliR3leRHN2EtG6OgxJgqrPPmMV/U5MQCWRtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3987
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103250171
X-Proofpoint-ORIG-GUID: jTOgDfGZfIafMdb-8p3Md7XqE5vWZaUB
X-Proofpoint-GUID: jTOgDfGZfIafMdb-8p3Md7XqE5vWZaUB
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250171
Message-ID-Hash: 37IFS54AFA2H7UYD7ZZAGMWVFAMPGZFP
X-Message-ID-Hash: 37IFS54AFA2H7UYD7ZZAGMWVFAMPGZFP
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/37IFS54AFA2H7UYD7ZZAGMWVFAMPGZFP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Move the actual pte population logic into a separate function
vmemmap_populate_address() and have vmemmap_populate_basepages()
walk through all base pages it needs to populate.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 mm/sparse-vmemmap.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 370728c206ee..8814876edcfa 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -216,33 +216,41 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 	return pgd;
 }
 
-int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
-					 int node, struct vmem_altmap *altmap)
+static int __meminit vmemmap_populate_address(unsigned long addr, int node,
+					      struct vmem_altmap *altmap)
 {
-	unsigned long addr = start;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 
+	pgd = vmemmap_pgd_populate(addr, node);
+	if (!pgd)
+		return -ENOMEM;
+	p4d = vmemmap_p4d_populate(pgd, addr, node);
+	if (!p4d)
+		return -ENOMEM;
+	pud = vmemmap_pud_populate(p4d, addr, node);
+	if (!pud)
+		return -ENOMEM;
+	pmd = vmemmap_pmd_populate(pud, addr, node);
+	if (!pmd)
+		return -ENOMEM;
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap);
+	if (!pte)
+		return -ENOMEM;
+	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
+}
+
+int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
+					 int node, struct vmem_altmap *altmap)
+{
+	unsigned long addr = start;
+
 	for (; addr < end; addr += PAGE_SIZE) {
-		pgd = vmemmap_pgd_populate(addr, node);
-		if (!pgd)
-			return -ENOMEM;
-		p4d = vmemmap_p4d_populate(pgd, addr, node);
-		if (!p4d)
-			return -ENOMEM;
-		pud = vmemmap_pud_populate(p4d, addr, node);
-		if (!pud)
-			return -ENOMEM;
-		pmd = vmemmap_pmd_populate(pud, addr, node);
-		if (!pmd)
-			return -ENOMEM;
-		pte = vmemmap_pte_populate(pmd, addr, node, altmap);
-		if (!pte)
+		if (vmemmap_populate_address(addr, node, altmap))
 			return -ENOMEM;
-		vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
 	}
 
 	return 0;
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
