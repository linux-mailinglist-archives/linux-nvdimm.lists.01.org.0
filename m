Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07A027B256
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Sep 2020 18:47:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4DA4D153A8A02;
	Mon, 28 Sep 2020 09:47:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.243.63; helo=nam12-dm6-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C2C68152EDBC6
	for <linux-nvdimm@lists.01.org>; Mon, 28 Sep 2020 09:47:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IF9oR2Gtf1pVsFTX8XThtxJPsHBbGvrvFWxYdZt+64lYDt7X6ukRg3upqIGuGQtw0omCwUsHOeZzRkPqFGNqGsk3lqW4T/RSqk8XagkuOCt3J3EqHqUWWOohazkX4D75/ckTVkF38C70qTzFM3b0K7+TJkP+9BjlWTgW04tmH7hiXOEHeisc7rKB6cQDuMj8oxdx3ZAK3yY6L+OnDcKDIyawNrwsNJjdoOMllEwYEPW8BvJxs7beWumO1rjL05GtMq1xhSN69L3hNXIjDmR+O8dRjvpDqxy5fnQW45YkZtUY7DyN13ki0DqR2Pdo0PTp3TcaJsb6nLVPyzUPv/1xEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5+W5IPj0I+A/FL2xIaXyC92JyKwkGNl6/DMkg79/JA=;
 b=elrI8/3hwqp9V+y8ODz00WBu2F6Oxs/tB03B+PtIaRDxysqecXcfON3TmAhrHTMx7NYyrggfW/s6KA3MTk7InWpRuQoN7/X3hiUk42zLcIW2KvEw7Si/13vXIb+GI2VJTY8Plu4sq+W9id8X/4X0VJ5rdTLHuk75WwMFLH5oUaN2GehlFS8uv1a85OsTSmazO3nxHgpD1e6H5Ve5apxiSzMSarhFyAo/APgoLMNTUKIDHfTsqiZMPE+Q4tji+W1ozuiyj6D8yPokriQjocUWNSnVM/utICKgDqTTCKiYv9IpxF8QqgqaUecRXUxFrerdrzaa8sqrSxr5EIJjS+PJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5+W5IPj0I+A/FL2xIaXyC92JyKwkGNl6/DMkg79/JA=;
 b=flgZidUl39wzQ9MaiyHJuyXjdrGJD4NNlB2WZDiEJro6jX9918TnzriIqYeoKZawrHuj4IzG4qrhg1Xg+5a955CEvFKBWT34LYgGT4Qy5qFgSL5G1MPiqWAoY7e+zhyip1zrpUmuzRkZu4R2gKNxtLwAckoQDTkMEmZDXQqMFfA=
Received: from BN6PR13CA0036.namprd13.prod.outlook.com (2603:10b6:404:13e::22)
 by DM6PR08MB4924.namprd08.prod.outlook.com (2603:10b6:5:43::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Mon, 28 Sep
 2020 16:47:21 +0000
Received: from BN3NAM01FT028.eop-nam01.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::16) by BN6PR13CA0036.outlook.office365.com
 (2603:10b6:404:13e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.17 via Frontend
 Transport; Mon, 28 Sep 2020 16:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 BN3NAM01FT028.mail.protection.outlook.com (10.152.67.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 16:47:21 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Sep
 2020 10:47:17 -0600
From: <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH 21/22] mpool: add documentation
Date: Mon, 28 Sep 2020 11:45:33 -0500
Message-ID: <20200928164534.48203-22-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200928164534.48203-1-nmeeramohide@micron.com>
References: <20200928164534.48203-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17d.micron.com (137.201.21.212) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--9.760600-0.000000-31
X-TM-AS-MatchedID: 700076-701429-701480-703017-703140-702395-188019-703213-1
	21336-702688-703226-700958-704714-701073-703361-705279-704726-703230-700863
	-702719-703080-704418-700010-703640-139705-780058-702617-701321-703415-7018
	80-704500-701510-703812-705244-702783-704959-700335-703414-704961-704841-70
	2779-703851-703700-704965-148004-148036-42000-42003-190014
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edca1e7e-e11d-44a5-613d-08d863ce2b78
X-MS-TrafficTypeDiagnostic: DM6PR08MB4924:
X-Microsoft-Antispam-PRVS: 
 <DM6PR08MB4924866AEDA69D4B016DA3C3B3350@DM6PR08MB4924.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lGAaWM9IX4Xd3ps41VjUqXJ9wGD15vXS6+dFrR54uorTRXr3gsEPM6FaJDgyUpxY8xID3CKaK93k/PUzWFDl9i6cyMRk5GeHydMi6KeAI5xoI5rP2Z/l43ec4GRrRdKUvOqktahoqloWoI1f9Ys8yAlZaTYH3LmivAhbMl2JAuIsC2czvS4aYivKkihahndBkNLXkOPbkkQgbuG6f/M+NwbgjcSx/NPt5kolPYI5gR27uYb7EslKhtbsQNCSTVw9wEK34BIRMvDSEbR5xkgxqT3Des9Vw2V0ApY4KKicGvgeixrsVY1d4/b7j/5Fo4K/VUfg2+YnbVsRhUDdgI/Xlt/Z7e8vIPMXtdcIgFAPygtpFWhGyUVEk1abxKgNZqCEksLbqJo7hd4RDGxp65ACkpFnhB7OjJMrB6t3go7R/fmzZ5AJ1irihcVLiIgGR0IBknqx+ORwHnvt63o0dRgV/HovMyJtjY9/o7Uq5vnBQqmXtlH0ZVlfDb8oAkzOS6EA4Y5omdByPEAV0VIyV1Qe59V0QVtdWmDwHIhAQWQO7pi0IaLtoYQtR3aGdMe5ni6RIpSCDsuiPNkGCwf7/V4cMA==
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966005)(478600001)(186003)(26005)(70206006)(426003)(54906003)(55016002)(4326008)(8936002)(110136005)(8676002)(70586007)(86362001)(83380400001)(33310700002)(82740400003)(316002)(356005)(5660300002)(2616005)(7636003)(107886003)(2906002)(6286002)(6666004)(1076003)(47076004)(336012)(2876002)(36756003)(82310400003)(7696005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 16:47:21.5028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edca1e7e-e11d-44a5-613d-08d863ce2b78
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3NAM01FT028.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4924
Message-ID-Hash: OKB646YLTS7FQOZSKLRZY7D7TGRTL66Q
X-Message-ID-Hash: OKB646YLTS7FQOZSKLRZY7D7TGRTL66Q
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OKB646YLTS7FQOZSKLRZY7D7TGRTL66Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Nabeel M Mohamed <nmeeramohide@micron.com>

This adds locking hierarchy documentation for mpool.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/mpool-locking.rst | 90 +++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 drivers/mpool/mpool-locking.rst

diff --git a/drivers/mpool/mpool-locking.rst b/drivers/mpool/mpool-locking.rst
new file mode 100644
index 000000000000..6a5da727f2fb
--- /dev/null
+++ b/drivers/mpool/mpool-locking.rst
@@ -0,0 +1,90 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+Mpool Locking
+=============
+
+Hierarchy
+---------
+::
+
+  mpool_s_lock
+  pmd_s_lock
+  eld_rwlock          object layout r/w lock (per layout)
+  pds_oml_lock        "open mlog" rbtree lock
+  mdi_slotvlock
+  mmi_uqlock          unique ID generator lock
+  mmi_compactlock     compaction lock (per MDC)
+  mmi_uc_lock         uncommitted objects rbtree lock (per MDC)
+  mmi_co_lock         committed objects rbtree lock (per MDC)
+  pds_pdvlock
+  pdi_rmlock[]
+  sda_dalock
+
+Nesting
+-------
+
+There are three nesting levels for mblocks, mlogs, and mpcore's own
+metadata containers (MDCs):
+
+1. PMD_OBJ_CLIENT for client mblocks and mlogs.
+2. PMD_MDC_NORMAL for MDC-1/255 and their underlying mlog pairs.
+3. PMD_MDC_ZERO for MDC-0 and its underlying mlog pair.
+
+A thread of execution may obtain at most one instance of a given lock-class
+at each nesting level, and must do so in the order specified above.
+
+The following helper functions determine the nesting level and use the
+appropriate _nested() primitive or lock pool::
+
+  pmd_obj_rdlock() and _rdunlock()
+  pmd_obj_wrlock() and _wrunlock()
+  pmd_mdc_rdlock() and _rdunlock()
+  pmd_mdc_wrlock() and _wrunlock()
+  pmd_mdc_lock() and _unlock()
+
+For additional information on the _nested() primitives, see
+https://www.kernel.org/doc/Documentation/locking/lockdep-design.txt.
+
+MDC Compaction Locking Patterns
+-------------------------------
+
+In addition to obeying the lock hierarchy and lock-class nesting levels, the
+following locking rules must also be followed for object layouts and all
+mpool properties stored in MDC-0 (e.g., the list of mpool drives pds_pdv[]).
+
+Object layouts (struct pmd_layout):
+
+- Readers must read-lock the layout using pmd_obj_rdlock().
+- Updaters must both write-lock the layout using pmd_obj_wrlock() and lock
+  the mmi_compactlock for the object's MDC using pmd_mdc_lock() before
+  first logging the update in that MDC and then updating the layout.
+
+Mpool properties stored in MDC-0:
+
+- Readers must read-lock the data structure(s) associated with the property.
+- Updaters must both write-lock the data structure(s) associated with the
+  property and lock the mmi_compactlock for MDC-0 using pmd_mdc_lock() before
+  first logging the update in MDC-0 and then updating the data structure(s).
+
+This locking pattern achieves the following:
+
+- For objects associated with a given MDC-0/255, layout readers can execute
+  concurrent with compacting that MDC, whereas layout updaters cannot.
+- For mpool properties stored in MDC-0, property readers can execute
+  concurrent with compacting MDC-0, whereas property updaters cannot.
+- To compact a given MDC-0/255, all in-memory and on-media state to be
+  written is frozen by simply locking the mmi_compactlock for that MDC
+  (because updates to the committed objects tree may take place only while
+  holding both both the compaction mutex and the mmi_co_lock write lock).
+
+Furthermore, taking the mmi_compactlock does not reduce concurrency for
+object or property updaters because these are inherently serialized by the
+requirement to synchronously append log records in the associated MDC.
+
+Object Layout Reference Counts
+------------------------------
+
+The reference counts for an object layout (eld_ref) are protected
+by mmi_co_lock or mmi_uc_lock of the object's MDC dependiing upon
+which tree it is in at the time of acquisition.
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
