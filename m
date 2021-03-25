Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FED349CB6
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Mar 2021 00:10:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 960C8100EAB5D;
	Thu, 25 Mar 2021 16:10:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C30E6100EAB4B
	for <linux-nvdimm@lists.01.org>; Thu, 25 Mar 2021 16:10:40 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNA629136802;
	Thu, 25 Mar 2021 23:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=2LEtq198GuV0ib2ePVeimqbTpQFbr2hIOS+83MDx9bg=;
 b=q4tMKNXSndodqHTzm99GJGkrEfka8XGPOxRRegJm9pYmgWvroTFm+UPPc7izS9bHYCE3
 NC1CIiPiznHYXDngy35TWtcGj/IAUqa/48oTbpz7pcafVkggi9Al+NiFqN5M4BjG4X44
 qEExk02SE2QbWRyguE79K5VoEheaHnRmseaOpyDanSCvGuJ9uaFCGey3RC4aTs1KUIis
 Y549TKpjq79jnKIW4InX3FDlwBDTBvE48O3zb/0rE9qYvttgWLdqxt9xELBuuKTxZHr5
 4zev8gCGCIxTTqbC5n4Ow0Ei5Pv3DUDNnp1MjIvqVP1fh3Liye8lLp5KfEy6QD+kaxr+ kA==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 37h13e8dwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PN0JKP161365;
	Thu, 25 Mar 2021 23:10:00 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
	by userp3020.oracle.com with ESMTP id 37h14gdpp3-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjEVAE4qa7D1N3CR1mhvhF7oTtWN0NIVr5rbauCPZpHiunAgkR8Q0ro7wAHWgQHJ8UNAdpLLJHtekC+EihAsDmRRcPt9lrgBBlmIe2POqYgIQ2TwLRrMiwCK+/rmL2/JqB+UHJQ9S3Uf8ZO9Z+a583yhA7WNJ6/RKt/oM0kqHmj+Sv+lXah5QEsZ02CycuSYoVn6B+DMPCmNMVwXbmK3Fm9CpYxeD3Alx2V3WGrlW92pSsHtKaNjmkUEQGlvYtavdCx6pM3JaWCJJxXd0bg940ZrB7js1ySvsr1XRaFYgG30LY4IX+otqYe2MvJELqtkz30SYQBFv+cbOuTkwxDe9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LEtq198GuV0ib2ePVeimqbTpQFbr2hIOS+83MDx9bg=;
 b=KLGek+aUAvTHvEfpcVTkzljdzZ233MgeIZ8ot+fCO0VV4uL6xbB9nNXPHBH6OFNioGKBvYyhPwqbBG1qgOIAJqAyEujvx13j/tQoJ68SPq0ojJkk1ZNKkJR2hFfNOkYiWXqDb1zx6M9fgvILqAzaTCOFgrwz30VZplLBGAM/G+ehCVm6MkQ2iymE++B+o+Eiv+1UYbH8LaDvx7FPXQiYhR27d6chahpSM/nSHn05lm0yfB8jZg4wj8z8/19DU5V94tbbHVsvqzvAez6AShL7ijuP9RFzbFFTpqkMotRmLVk7F4yv4G+B3eaBbNPP6pg2QuoTZLmmSG78RFkYU5xpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LEtq198GuV0ib2ePVeimqbTpQFbr2hIOS+83MDx9bg=;
 b=eViCeMuTk5wN9ZGhRnhNodO7Ey1MFbMebakysp/WBoozQQD881GGAahAgKmmPCQ3edJf5wQjlcA8Gja/ien5YtVQwKbiVawuR395S8ipCmnY4NEWIzyRACDCQ9PB+HwpF/pALeCN6h5qrKuPIaDDR0dMuV6cDwNnQw9n1IQBWUI=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB3987.namprd10.prod.outlook.com (2603:10b6:a03:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 23:09:58 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 23:09:57 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 02/11] mm/page_alloc: split prep_compound_page into head and tail subparts
Date: Thu, 25 Mar 2021 23:09:29 +0000
Message-Id: <20210325230938.30752-3-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210325230938.30752-1-joao.m.martins@oracle.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::22) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 23:09:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e420956-ef07-4054-fd0a-08d8efe31bc4
X-MS-TrafficTypeDiagnostic: BY5PR10MB3987:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB3987D19FB26AC54475885402BB629@BY5PR10MB3987.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	d0OaagaGgfZE8D5BWnwaRGh2CSRgZgcHu6KSK4maLUf3KhLV8ipVzSIG5r4OzAZ9556q3zSAmg/6jvtLBJQG6h8IArD8xvmI3b8RNk/e9fFNTqKv6t54Fp7viumHyuCQURVqxFPThThrfWcDebLje1oYK3bpKWyS4SkWej+gEcNemLGhhCzMrwfIvXFiRjrk+2J0+upb9ZlzT85UG1YyIilG8EAUILy1NsCIivwfFwujD9eSJolwDdASPqiY1cL4zaZ5QAvTBwDTK3mQr5u+EZQkZR8tbhUYWpdRBpAlXEEZ1Ob1v0CyNHb8PoYzdiEeB7XGkUiIH50aq2DPLkg/3BjmI8LqqE+9fni/CyUVL2sKiAnXyDrL4ALdCVwGMtDOgO2p/fV32YB4prvY36lpxNTdwaSP2+FeQ3L9nF2iZhCz4f67Fiq/2TzGoAh0DbWR61WTGim6pIRp7cngmy0xl3NJYPugsw7PAWH9afFdIDtwSQXF5R+A2lD7azkIaiXBP7SSM1nsMABIDbmN5IpzW4D/gOp1bL4QBDXPTevme7PqPp7mfyPM0NXNLLYEkGjbLdL6PdeNF0NteuYxhq7+CzceBOEUgIkEAwipl578RuF/1m+COPjEvG4fNCUPc/K7jHrhfta5XEPyJdHAWvVrMCJDw5Yf1iZLkDLDSz7w8ZU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(83380400001)(4326008)(26005)(107886003)(6916009)(36756003)(7696005)(52116002)(66476007)(66556008)(478600001)(66946007)(186003)(316002)(2906002)(8936002)(54906003)(2616005)(86362001)(8676002)(956004)(5660300002)(103116003)(1076003)(6666004)(38100700001)(16526019)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?c7ikc8k9fH1Oesi1Zhg0iJifQPEmTQNCzGC21WiPbC0QHNzzMr3AmzkIH9UX?=
 =?us-ascii?Q?X4Ni/oy5NuIYsZTsAS1CIDrCMh74l29ikr8oHKwamZNMRTRTbhlHrV/59tFa?=
 =?us-ascii?Q?y5ax5w7Vii52SHbyQG6HpSF8kmRO3nC0wpobg1tZ00stxhpLMTrOzbCdntaW?=
 =?us-ascii?Q?xNTPbdse4ht2Jdoo4wSDA96OfaS4DkXR9i0lHHy2Cxyu3V4fNER0V7t759si?=
 =?us-ascii?Q?WN9ZyAMPctjsGpxnJqvgVDEd5TE8UaymzgDOtp+aRiWL7oyo72HjpUGBeGc2?=
 =?us-ascii?Q?F0xoIZPFifxC8JuTY3pHVqouBHT2zQCqPiL8rH3vHOVDAjM3hBwgs44L0mK1?=
 =?us-ascii?Q?2HYJeRpBOQTmJ6yU8KwYJMIC5zx3IvtueaX6krlhq/6h0Mar9nvQhOinyQDW?=
 =?us-ascii?Q?5fR8CVtUiuxSrb95S+VMNo5x85REYbarkgT+goauDPOhBD50Bng3uALizpeX?=
 =?us-ascii?Q?kPI1+4Vf7G4vYoLVoFzPnRdTMnEdpQPjgk1G+EnYajomaEhizGYGa+lpVKBk?=
 =?us-ascii?Q?mIChNzeVWS9dRNiNzIyE1kc/KgX0Pp6LOfR2HpR7aq/Zfst4UoZx3Rfpd8ym?=
 =?us-ascii?Q?md3pEcMn2bQw4sdk411rh1zqEeVw1IUSuhYak4/RDcw/HH43wEL8WqtG3oKE?=
 =?us-ascii?Q?UQjAxgIULxcTi6jjg3rgRIV2a+QZNbfbSvRTxDnm7NpIlAPwHtLb19UhkIYP?=
 =?us-ascii?Q?IyEkCk4+yzxiOkxvanECF/H8LWcN+VLO7K53V8pa3TiVvjWetuLGLPkxSHm9?=
 =?us-ascii?Q?qlqtd8Qx0yB/p2f124nKOncshiLFMeBdtqNrf9Uo3yXuPcG1J9g71nA43tLt?=
 =?us-ascii?Q?SITioIraJ+CqE1TrUWHwQTKne64/s9nphz/xODwrwZyVROXBpPxq2/IlMNRL?=
 =?us-ascii?Q?alWwd3EQPhUkr+HSBHl6yaxD6MzatS09Onwi7K9Qv/oOO1Qgh6dTHD/tQOi3?=
 =?us-ascii?Q?vC5qbpBeAiY/IWon22K+fnE0IvSYrcektgXfP0/3yKeLBgYhDbkZ2gxnhE2Z?=
 =?us-ascii?Q?HJJp9bZ8ewVKjOpewAICABI/gPHirgOAw1yJRNeMTibvSJdEq4QTU9p9o+Ga?=
 =?us-ascii?Q?3h9ZtpTnvVn4mKHUmrkzD23cOlF77K6m7yFcdVlsJuUQsv0E1wQyDcc9DDLg?=
 =?us-ascii?Q?O2Jb3gmBhotfpDX6TECbXyi1sb1b7oER/DBUPE8DVJj2dqCn6PUhZqRJXsNP?=
 =?us-ascii?Q?aAU/ls9K9kve9u2S5ymUqJj8zVRBgHetN93d9grmJe2HNIVlBZeDsKU59L3N?=
 =?us-ascii?Q?C2PCoa9j1ERQczZ5wD1KG7DkGv/zlaO6SMfb5R+rGofyQn4lQwqtbUeplk8l?=
 =?us-ascii?Q?RTuakCQfVg2B7sKwWBdTAGaS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e420956-ef07-4054-fd0a-08d8efe31bc4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 23:09:57.8202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9xGrKpg2kynMP7u7Y/zBuy6HnyhjpEy2D1i/Wx4YjAUXX49kOjTt1Z8A9JA3Kl0EqwIp1rbmSIeYMVO/Y4zWkGFTAMDa7j7fH4DWpqUBAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3987
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103250170
X-Proofpoint-ORIG-GUID: VjROm8v2CNCxM4qDZO-U68FCShxXr5C2
X-Proofpoint-GUID: VjROm8v2CNCxM4qDZO-U68FCShxXr5C2
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250171
Message-ID-Hash: GMPUHZ2BHXSOBQKG4WC4H76EZBN7OVHZ
X-Message-ID-Hash: GMPUHZ2BHXSOBQKG4WC4H76EZBN7OVHZ
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GMPUHZ2BHXSOBQKG4WC4H76EZBN7OVHZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Split the utility function prep_compound_page() into head and tail
counterparts, and use them accordingly.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 mm/page_alloc.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c53fe4fa10bf..43dd98446b0b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -692,24 +692,34 @@ void free_compound_page(struct page *page)
 	__free_pages_ok(page, compound_order(page), FPI_NONE);
 }
 
+static void prep_compound_head(struct page *page, unsigned int order)
+{
+	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
+	set_compound_order(page, order);
+	atomic_set(compound_mapcount_ptr(page), -1);
+	if (hpage_pincount_available(page))
+		atomic_set(compound_pincount_ptr(page), 0);
+}
+
+static void prep_compound_tail(struct page *head, int tail_idx)
+{
+	struct page *p = head + tail_idx;
+
+	set_page_count(p, 0);
+	p->mapping = TAIL_MAPPING;
+	set_compound_head(p, head);
+}
+
 void prep_compound_page(struct page *page, unsigned int order)
 {
 	int i;
 	int nr_pages = 1 << order;
 
 	__SetPageHead(page);
-	for (i = 1; i < nr_pages; i++) {
-		struct page *p = page + i;
-		set_page_count(p, 0);
-		p->mapping = TAIL_MAPPING;
-		set_compound_head(p, page);
-	}
+	for (i = 1; i < nr_pages; i++)
+		prep_compound_tail(page, i);
 
-	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
-	set_compound_order(page, order);
-	atomic_set(compound_mapcount_ptr(page), -1);
-	if (hpage_pincount_available(page))
-		atomic_set(compound_pincount_ptr(page), 0);
+	prep_compound_head(page, order);
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
