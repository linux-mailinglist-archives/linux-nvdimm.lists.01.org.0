Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40776349CB3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Mar 2021 00:10:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 09DB7100EAB51;
	Thu, 25 Mar 2021 16:10:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7C26A100F2243
	for <linux-nvdimm@lists.01.org>; Thu, 25 Mar 2021 16:10:33 -0700 (PDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PNAKeT143162;
	Thu, 25 Mar 2021 23:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=210uT+K2DSFz/dK2BBxVr5ZahPOQRm22NW+bo9aavM0=;
 b=kdPu/YrepQSQaqj0HIQGx7iFW2Baoe21XnhNSMNf1EF1WTSiOqASQabzsN2D8dZOa+Yd
 hRAP8PUaI3GVCbWcPKohEEhd7un5eN2qYYbXj4lAYEYNTykJ9No1/6XASDpOjqwOY87g
 nqGfvAHeeM5xOARoRwF7GIIIFvYttvHKw6yO6oM7JZkDG7a6qHGshcAMIwMVJkywwwRc
 7Z6QpisA5f6u2IA02tFJUSC1vW1AjqogDiljCGoUHLNXpho/otmQIB6Zc9rS++WNeXQM
 W5mWLILNJKyoLW6W0DlnL3E/h1qJhn79dB7ldV4/m2SrC+9vbEI3ELSwvipY0q1p4XRr fg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2130.oracle.com with ESMTP id 37h13hrdws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12PN0WTp105695;
	Thu, 25 Mar 2021 23:10:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
	by aserp3020.oracle.com with ESMTP id 37h14mdkgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Mar 2021 23:10:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4EwmHl84jEPCq3dd1n0Jswyr9GAeesF4ZZ3KEMIx1TtZrLsiuzeCbHBJ0anGr5WZE1PCbWH/AEV9yB69FQlj07U1eTjFGGH0XcJCpotdCI6Z/Zp79KMY9Kvvlu/jPex9MNoGM7HUySZUwgvuw4VlJOsJ3b/3/osB+51SDj0molqCCs5RjnbrSRm/ke6emS3/0FGJYmXthih/zUPXutkfklJmDmLDzWJ2hm3+iXOzUUxmg5qD9RsNC/W1+2Z3iOl4pMfatXCbDhQCyyUJRkvxZNG7FIQQq6uy5nbH8P3FAIh07rnejXiCu91XlDvBE37pw6F3B3s4exFdQgf12EiDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=210uT+K2DSFz/dK2BBxVr5ZahPOQRm22NW+bo9aavM0=;
 b=TL0n3jnRMxix5ASyH+WWoW5l7H5rUl1yE5bJIUYH7CJndpB/ztOEIap2zlL0tmQk6fi54Uv2nKXJ/7bXdCujcIlR8uDIhRS4fHTThdRlD4inRvVAkNAUGBVABIl1ghcNWB4ZKFO24QAj9ixttdx1X/GERSweVgcZKGGxptSIpfcuOY/vt/3MROz6ZcANAOCyfABqcMsgHBmhG6hj6npHogbKgpUZjiW0Jne1RjZfnqLAM6ZG+7gDd56e0BGFUgUgQSo2CRkCdSgHl/z9NPpyADTPDatup66yRRp9m/0/anqprRWxG68yvlw3WLqhlv7Slvjlc3JoYUnsT0LgQi0qvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=210uT+K2DSFz/dK2BBxVr5ZahPOQRm22NW+bo9aavM0=;
 b=uXpeRyXQ6DO3S2sBVSxBnc4/Yurn8PP/1Tgm7CCjz+tkihXQla3WScVk/QhtY9vccAbkxne8urZy7m7Zw0YJtAjtFNESb0fbKHDpqPIfwbn610cQIPMlG9rEbxhng124+etUUtSZTbsDZi+lGQ48EUpS+k98TCd2an1fYErz0qY=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 23:10:17 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 23:10:17 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 08/11] mm/sparse-vmemmap: use hugepages for PUD compound pagemaps
Date: Thu, 25 Mar 2021 23:09:35 +0000
Message-Id: <20210325230938.30752-9-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210325230938.30752-1-joao.m.martins@oracle.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::22) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO2P265CA0082.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 23:10:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4f9bed1-1e3c-45aa-eae0-08d8efe326ed
X-MS-TrafficTypeDiagnostic: BY5PR10MB4371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB4371C361E8A6ED661E6F0E76BB629@BY5PR10MB4371.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	djcUSWEml1yOso3W5Th50VtJhm+hJyt1lbzaL6HiZKMhFn71uf6yiou6ArV/pWL37718YVhOR0PrmA9mAhFXhzuqBT+9xDnjitbEl4zXcSaNAxx9onkwBGvdwjO7skC8Znj/2ysCNlhuuqOjTXaovVeojh/gfyTlG7KK/WQygewmed8cylWISkryxISKMo9B57ogTwHtgPHiheM/+gEejRLqx1eHr1Uw0WrJWHdxVxKVzn7LKI67uA2K9NQ2/xRGJntc0/qBS4TW1fBOaLs5Crz6MovDqeIgk6w4btxb6v+ncNGrAP9ntpqxqFWUk5HrHtL/sn9xpVQe4oln4HJZPHUo3TQ8ptANEDUsggvEzpOkeF6+ac8D9vpt+Bw/PjjfhUc3vkYgVuS6xH6Ho0B/vsZqIaPcfEKddTCvB2XV/n5B9i2SG1o7r4MFkn0NJi+8JakFAn/b9RRzDRxpzRA29tgRf7FIOQcCddj9qUvNeBhRHnAnjDmBBjzb5y8aFakumyqGhPJcmPULaf5yIk14fKfJaAgb+xyBlQmvNGEaCzx4SzoR0ftDwiJDOtbKMW0rUk1MWnywWzk+nN3z+pbV0lu03k+xa50bRSlRN9Jrml56R2xq3lDeZY7KjIri05SJMFQDRHRZrwHtUftprtQySw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(396003)(136003)(186003)(26005)(16526019)(7696005)(316002)(38100700001)(54906003)(103116003)(478600001)(6486002)(2906002)(52116002)(83380400001)(6916009)(66946007)(86362001)(66556008)(8936002)(4326008)(6666004)(5660300002)(36756003)(2616005)(1076003)(956004)(66476007)(107886003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?FQPG9J9y7QJJWqXCZxiRR5Ll5DO9Tlwqktt32JHEjVMSCQH3AqP/8U4WB64I?=
 =?us-ascii?Q?arQAwOvKSA5qWIj5FA4ZVmftmfYAPz+UhAKLrqcWymVcj940f1ZYL2aPfUGk?=
 =?us-ascii?Q?bhALXqy1OOwFj2Wg7h4ZnxpVKiWC1VVSZV31AMeq7O8EWD8U3Pt4Ju9houHK?=
 =?us-ascii?Q?SnltLPG1Ig5lYh+y+Pma54Jt8K39sHi6MSkMRA/4ZgX+V0D92RpDShNUSvzV?=
 =?us-ascii?Q?T8ooSbj55nrUncmBFoesZGVTo7z/cXRqN72ww0IyEfeww3Iw41XRYj+NBTNo?=
 =?us-ascii?Q?c3MIuFWoMtI2kwpHD6ROGXgDlz669lZOWwUjgLrGriPYHCenYEdi6BKFpGej?=
 =?us-ascii?Q?feSvK9uoXYDvX3eMrIfZZjsRMl9G1cRYlECMkUtWcQiuGxePkI6DnzCF5VHJ?=
 =?us-ascii?Q?Q4gfwBnSyxvoVRAJIAbKZQcBWYakSKDs4w4jowJa97vCOiZNU/wKTqGAtLdZ?=
 =?us-ascii?Q?FVe5u+CpSj7iScgzT+oR0pSGNk1CcON2i6WL2B8/0lfl4vqJIbCaW0uC9FCw?=
 =?us-ascii?Q?MDYpYbub1+8KiOPblgpUIwzzmYQV5v6M28D6dhu0gtWd/cMD+Hxdukz0hShM?=
 =?us-ascii?Q?1tT9sM1bkXKr9sUKTlgRMnj63EJXWgGsfgRfRX3nWuKQ+PIS8FGye8PiyQSd?=
 =?us-ascii?Q?LDdo7PS6rmR5iWtdyZe9lrx1FsOBgW1d3kAEB6cFuhoilca/X92boMQ/WxyA?=
 =?us-ascii?Q?q/+NMeAnscnTRZePgYz9gOl21SNsinN4VYR/fYuF1Tr8Lz4zCHrsNqb/unL5?=
 =?us-ascii?Q?JpGu8ySp1sApc0G0Cdb4P9ONGAmx1gOD1Q2t154LR4gfile/d3HdAaLcOi8e?=
 =?us-ascii?Q?0FPjC3T1xGk04CNtk53Rk2tU1tZR9XGIBu70yykJfLcnOmkLAPIDkkC7cO7E?=
 =?us-ascii?Q?JqbI4URuF0Vd3R6YqItrr1EVFbpM9jfCbI0T61XyhJMxcIeXvYH5bUITXC5M?=
 =?us-ascii?Q?I+PqhBz8FuAx/KB3acvAiAuAssXDhIK0db9JyvL1zvofZcr0SC++LFWXsSMt?=
 =?us-ascii?Q?A5K5iC5R0g/9GCS9xbDomiX41aE+MxQIJRTmJMrKiAwD5sT+9w8GosVZWYv2?=
 =?us-ascii?Q?uALPojzIUt7+70ZAX0wci3pmdMLFe2RxaOLyonQmgq1WzXAzDr/rw3X9bhYx?=
 =?us-ascii?Q?48sX9jmujSFOY+JXgDXhagY94JYzPOz9u6Fexh0d2zcCgGLDwVgRQHy8b0hk?=
 =?us-ascii?Q?gmIZ1K5PDKgBSqHL41ySd3rbeJBhpK8mqcoE2VHZuBPfmh4wB2gG1dgnxWnO?=
 =?us-ascii?Q?s3pD2Z+enIsAg2LJu5ahrJcTnGbmtfKBvRkkxJH/4OkvSdEtKdUPCUV/cESY?=
 =?us-ascii?Q?PA9HnPKrpta8APu3+/A8sQqc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f9bed1-1e3c-45aa-eae0-08d8efe326ed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 23:10:17.1081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiulKvIbBb+B7+f+HtLl6XtCm8azBpeb3Uo3lxOk8uzKfF83sULDvvsmP0pPXtPzACGJ0wTrMq7LJ/WmWklizvfX4Is9oAVeOsuIRUhHUbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4371
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250170
X-Proofpoint-GUID: HRpf4phBP-1AKrMwMP5g_gznjuJfHVdy
X-Proofpoint-ORIG-GUID: HRpf4phBP-1AKrMwMP5g_gznjuJfHVdy
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250171
Message-ID-Hash: OXGOMIUGNEZQP2YYBAML5C6SXMNIF2RT
X-Message-ID-Hash: OXGOMIUGNEZQP2YYBAML5C6SXMNIF2RT
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OXGOMIUGNEZQP2YYBAML5C6SXMNIF2RT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Right now basepages are used to populate the PUD tail pages, and it
picks the address of the previous page of the subsection that preceeds
the memmap we are initializing.  This is done when a given memmap
address isn't aligned to the pgmap @align (which is safe to do because
@ranges are guaranteed to be aligned to @align).

For pagemaps with an align which spans various sections, this means
that PMD pages are unnecessarily allocated for reusing the same tail
pages.  Effectively, on x86 a PUD can span 8 sections (depending on
config), and a page is being  allocated a page for the PMD to reuse
the tail vmemmap across the rest of the PTEs. In short effecitvely the
PMD cover the tail vmemmap areas all contain the same PFN. So instead
of doing this way, populate a new PMD on the second section of the
compound page (tail vmemmap PMD), and then the following sections
utilize the preceding PMD we previously populated which only contain
tail pages).

After this scheme for an 1GB pagemap aligned area, the first PMD
(section) would contain head page and 32767 tail pages, where the
second PMD contains the full 32768 tail pages.  The latter page gets
its PMD reused across future section mapping of the same pagemap.

Besides fewer pagetable entries allocated, keeping parity with
hugepages in the directmap (as done by vmemmap_populate_hugepages()),
this further increases savings per compound page. For each PUD-aligned
pagemap we go from 40960 bytes down to 16384 bytes. Rather than
requiring 8 PMD page allocations we only need 2 (plus two base pages
allocated for head and tail areas for the first PMD). 2M pages still
require using base pages, though.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/linux/mm.h  |  3 +-
 mm/sparse-vmemmap.c | 79 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 49d717ae40ae..9c1a676d6b95 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3038,7 +3038,8 @@ struct page * __populate_section_memmap(unsigned long pfn,
 pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
 p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
 pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
-pmd_t *vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node);
+pmd_t *vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node,
+			    void *block);
 pte_t *vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
 			    struct vmem_altmap *altmap, void *block);
 void *vmemmap_alloc_block(unsigned long size, int node);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index f57c5eada099..291a8a32480a 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -172,13 +172,20 @@ static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
 	return p;
 }
 
-pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
+pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node,
+				       void *block)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
 	if (pmd_none(*pmd)) {
-		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
-		if (!p)
-			return NULL;
+		void *p = block;
+
+		if (!block) {
+			p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
+			if (!p)
+				return NULL;
+		} else {
+			get_page(virt_to_page(block));
+		}
 		pmd_populate_kernel(&init_mm, pmd, p);
 	}
 	return pmd;
@@ -220,15 +227,14 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 	return pgd;
 }
 
-static int __meminit vmemmap_populate_address(unsigned long addr, int node,
-					      struct vmem_altmap *altmap,
-					      void *page, void **ptr)
+static int __meminit vmemmap_populate_pmd_address(unsigned long addr, int node,
+						  struct vmem_altmap *altmap,
+						  void *page, pmd_t **ptr)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
 
 	pgd = vmemmap_pgd_populate(addr, node);
 	if (!pgd)
@@ -239,9 +245,24 @@ static int __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pud = vmemmap_pud_populate(p4d, addr, node);
 	if (!pud)
 		return -ENOMEM;
-	pmd = vmemmap_pmd_populate(pud, addr, node);
+	pmd = vmemmap_pmd_populate(pud, addr, node, page);
 	if (!pmd)
 		return -ENOMEM;
+	if (ptr)
+		*ptr = pmd;
+	return 0;
+}
+
+static int __meminit vmemmap_populate_address(unsigned long addr, int node,
+					      struct vmem_altmap *altmap,
+					      void *page, void **ptr)
+{
+	pmd_t *pmd;
+	pte_t *pte;
+
+	if (vmemmap_populate_pmd_address(addr, node, altmap, NULL, &pmd))
+		return -ENOMEM;
+
 	pte = vmemmap_pte_populate(pmd, addr, node, altmap, page);
 	if (!pte)
 		return -ENOMEM;
@@ -285,13 +306,26 @@ static inline int __meminit vmemmap_populate_page(unsigned long addr, int node,
 	return vmemmap_populate_address(addr, node, NULL, NULL, ptr);
 }
 
-static pte_t * __meminit vmemmap_lookup_address(unsigned long addr)
+static int __meminit vmemmap_populate_pmd_range(unsigned long start,
+						unsigned long end,
+						int node, void *page)
+{
+	unsigned long addr = start;
+
+	for (; addr < end; addr += PMD_SIZE) {
+		if (vmemmap_populate_pmd_address(addr, node, NULL, page, NULL))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static pmd_t * __meminit vmemmap_lookup_address(unsigned long addr)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
 
 	pgd = pgd_offset_k(addr);
 	if (pgd_none(*pgd))
@@ -309,11 +343,7 @@ static pte_t * __meminit vmemmap_lookup_address(unsigned long addr)
 	if (pmd_none(*pmd))
 		return NULL;
 
-	pte = pte_offset_kernel(pmd, addr);
-	if (pte_none(*pte))
-		return NULL;
-
-	return pte;
+	return pmd;
 }
 
 static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
@@ -335,9 +365,22 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 	offset = PFN_PHYS(start_pfn) - pgmap->ranges[pgmap->nr_range].start;
 	if (!IS_ALIGNED(offset, pgmap_align(pgmap)) &&
 	    pgmap_align(pgmap) > SUBSECTION_SIZE) {
-		pte_t *ptep = vmemmap_lookup_address(start - PAGE_SIZE);
+		pmd_t *pmdp;
+		pte_t *ptep;
+
+		addr = start - PAGE_SIZE;
+		pmdp = vmemmap_lookup_address(addr);
+		if (!pmdp)
+			return -ENOMEM;
+
+		/* Reuse the tail pages vmemmap pmd page */
+		if (offset % pgmap->align > PFN_PHYS(PAGES_PER_SECTION))
+			return vmemmap_populate_pmd_range(start, end, node,
+						page_to_virt(pmd_page(*pmdp)));
 
-		if (!ptep)
+		/* Populate the tail pages vmemmap pmd page */
+		ptep = pte_offset_kernel(pmdp, addr);
+		if (pte_none(*ptep))
 			return -ENOMEM;
 
 		return vmemmap_populate_range(start, end, node,
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
