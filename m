Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CA928BDA1
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 18:28:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BCE6415B409FA;
	Mon, 12 Oct 2020 09:28:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.75.70; helo=nam02-bl2-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (mail-eopbgr750070.outbound.protection.outlook.com [40.107.75.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1566C15B409E5
	for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 09:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqV5EyECtmEyHpqOZKEQ773tsCzixm1FH5OziIGDm5rqmHZdp//5l7mrm6rkglXIOCcYGQH02ju13kBCfavUoJ0ROpgQa+K5d8/auqpzRwfFi9WF+2gOh2+bTuFXQwy/Th4XTPDTMMt0zRq/s7z+kc+13ussLkyQvO0prthvkiyCGeDZcvyxXKd9+fFjoeTSkHKwxk40+QfcqGnCcyCecPNY9Popk9DmEt7L+JWYCLR/QL3Nk4FeUyf0Nouy4Xln3T66wof2sk87YN6W4donjvdirWMUbLFJRdfJt/Td58NM39eeGb7akqYfVhIqY0fNPNgTocxDomR4x9AOdpi5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMcC/WkWvy5y0OW3Hhjr5sSx9X/kauqvbqpWFnsD6B8=;
 b=OxNqSk5kZ4bxJGsWoUxa8HOHsQcvfug9jYwyGLd/R5sNap7mRBJwjhcLjsNUKePXUHJVI2Dw3urY2eHTiz+J4NNywHHJyemn0LPgSUFAL0tquXTKz+HG/ZlZWTgOj2kZ5DZJo1eeH1UdKdGbvQuij8+j3jrkobAq6NAnWvGqoPbFVmMCTemjBbLBO+C7faNlR8k10eq6RC6lwjTjY8QjWlYcSiFAW4/SIWKP1xzgVhZmd6Bb10FMjLGi2cMWpApUMUDdgXrayhLP2uNXXqtTLHSmGZdQiXxtVK9YtgP+5J0pFd1oEL9q6xovP06o7b00xcoWi+R+DA/XXu4d6YoBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMcC/WkWvy5y0OW3Hhjr5sSx9X/kauqvbqpWFnsD6B8=;
 b=Z2T+SuZF5Qj6N41R+OtdvrpF0vBXWEE33kJvLVRenFixr3wsdV2g9yPp45pTa3uFVMc/q5j7fOM081IcA6tKPlLbBFA499mo/Y3mjphlWAqe4ucDoX56udh6aphI+pFVUrFApKbUQQXSh+ThwkOOIJ5yIvN3AXgmGLpFwt4orwM=
Received: from SN4PR0201CA0055.namprd02.prod.outlook.com
 (2603:10b6:803:20::17) by DM6PR08MB4922.namprd08.prod.outlook.com
 (2603:10b6:5:52::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Mon, 12 Oct
 2020 16:28:04 +0000
Received: from SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::51) by SN4PR0201CA0055.outlook.office365.com
 (2603:10b6:803:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend
 Transport; Mon, 12 Oct 2020 16:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 SN1NAM01FT015.mail.protection.outlook.com (10.152.65.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:28:03 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 10:27:56 -0600
From: Nabeel M Mohamed <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH v2 03/22] mpool: add on-media struct definitions
Date: Mon, 12 Oct 2020 11:27:17 -0500
Message-ID: <20201012162736.65241-4-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
X-ClientProxiedBy: bowex17a.micron.com (137.201.21.209) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--15.128200-0.000000-31
X-TM-AS-MatchedID: 155702-700076-702178-701912-703851-704959-847575-701029-7
	00863-704401-705022-702177-701480-704962-701809-703017-703140-702395-188019
	-703213-121336-701105-704673-703967-701475-701910-703027-701275-701073-7049
	83-704500-701604-702754-704376-701589-705220-702965-700535-704477-702433-70
	4990-701576-704318-851458-702914-700864-704997-701772-700809-701342-702346-
	704481-704463-703173-704978-704397-702940-704210-701366-700025-853544-70078
	7-704183-702688-703215-700524-704792-703393-703357-703080-121104-702779-703
	957-704718-704895-700071-188199-704815-188198-702888-705279-704418-702504-1
	21536-702972-705023-702171-702837-702008-703958-148004-148036-42000-42003-1
	90014
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff522184-b91d-4c74-29fa-08d86ecbcb2c
X-MS-TrafficTypeDiagnostic: DM6PR08MB4922:
X-Microsoft-Antispam-PRVS: 
 <DM6PR08MB4922AAD48A38FC91CE18523CB3070@DM6PR08MB4922.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gpmtbST5UaJ5O8kqVywlNoPk2BkXzSxpqXv1e/c3DiAwPrCAo2LJQf48AiR0EC5jhA62T8t4T2IRKjSYQR+vlhLaaJbK5Tz8doyTZZ5L46ZMx1iXou38CrUjDKVtVrZ6Hhdxh2lCk4lPL7vkCMTRYaaPJJv975TtwrLQuCTY9whId7Z8sH7EHHp2/QWkSYYOnfFs80OwbBbwSwS40f0Mv/JnSgkJ6G855t8kmy5Vwe+Ii9Gt8STtAXgdG2cU94ki0spHa4Wldme6YWyJ6lHTms6Mi8OtftAnuwcb4BXp5o8Lgvdo3g5aE+OTsx6M6AVMxp0NgZ1NOU9SflnBROpQvqtdHOk6l5htwi4zUrWGGHlPnvp//EhE4bwgSy8y+/6Qc3nIJWEmx4Fb9Uhn54ou9G7WfwMk99++c4rEO8P9usoP22dLN9w3NxgFAPVoXJ+ShIec+l1fIzjM+LLMJuvdyNuW+nC3CEHqKmbCk/Csn/Q=
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966005)(426003)(55016002)(8936002)(7696005)(478600001)(82740400003)(110136005)(316002)(70206006)(54906003)(26005)(2616005)(70586007)(2906002)(336012)(7636003)(83380400001)(6286002)(8676002)(86362001)(47076004)(82310400003)(5660300002)(30864003)(36756003)(1076003)(33310700002)(356005)(186003)(6666004)(107886003)(4326008)(461764006)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:28:03.7281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff522184-b91d-4c74-29fa-08d86ecbcb2c
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4922
Message-ID-Hash: 3DIIEVB6RR4ZV5UZKJYD6PFEUHBOLOQV
X-Message-ID-Hash: 3DIIEVB6RR4ZV5UZKJYD6PFEUHBOLOQV
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3DIIEVB6RR4ZV5UZKJYD6PFEUHBOLOQV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This adds headers containing the following on-media formats:
- Mpool superblock
- Object management records: create, update, delete, and erase
- Mpool configuration record
- Media class config and spare record
- OID checkpoint and version record
- Mlog page header and framing records

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/omf.h     | 593 ++++++++++++++++++++++++++++++++++++++++
 drivers/mpool/omf_if.h  | 381 ++++++++++++++++++++++++++
 drivers/mpool/upgrade.h | 128 +++++++++
 3 files changed, 1102 insertions(+)
 create mode 100644 drivers/mpool/omf.h
 create mode 100644 drivers/mpool/omf_if.h
 create mode 100644 drivers/mpool/upgrade.h

diff --git a/drivers/mpool/omf.h b/drivers/mpool/omf.h
new file mode 100644
index 000000000000..c750573720dd
--- /dev/null
+++ b/drivers/mpool/omf.h
@@ -0,0 +1,593 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+/*
+ * Pool on-drive format (omf) module.
+ *
+ * Defines:
+ * + on-drive format for mpool superblocks
+ * + on-drive formats for mlogs, mblocks, and metadata containers (mdc)
+ * + utility functions for working with these on-drive formats
+ * That includes structures and enums used by the on-drive format.
+ *
+ * All mpool metadata is versioned and stored on media in little-endian format.
+ *
+ * Naming conventions:
+ * -------------------
+ * The name of the structures ends with _omf
+ * The name of the structure members start with a "p" that means "packed".
+ */
+
+#ifndef MPOOL_OMF_H
+#define MPOOL_OMF_H
+
+#include <linux/bug.h>
+#include <asm/byteorder.h>
+
+/*
+ * The following two macros exist solely to enable the OMF_SETGET macros to
+ * work on 8 bit members as well as 16, 32 and 64 bit members.
+ */
+#define le8_to_cpu(x)  (x)
+#define cpu_to_le8(x)  (x)
+
+
+/* Helper macro to define set/get methods for 8, 16, 32 or 64 bit scalar OMF struct members. */
+#define OMF_SETGET(type, member, bits) \
+	OMF_SETGET2(type, member, bits, member)
+
+#define OMF_SETGET2(type, member, bits, name)				\
+	static __always_inline u##bits omf_##name(const type * s)	\
+	{								\
+		BUILD_BUG_ON(sizeof(((type *)0)->member)*8 != (bits));	\
+		return le##bits##_to_cpu(s->member);			\
+	}								\
+	static __always_inline void omf_set_##name(type *s, u##bits val)\
+	{								\
+		s->member = cpu_to_le##bits(val);			\
+	}
+
+/* Helper macro to define set/get methods for character strings embedded in OMF structures. */
+#define OMF_SETGET_CHBUF(type, member) \
+	OMF_SETGET_CHBUF2(type, member, member)
+
+#define OMF_SETGET_CHBUF2(type, member, name)				\
+	static inline void omf_set_##name(type *s, const void *p, size_t plen) \
+	{								\
+		size_t len = sizeof(((type *)0)->member);		\
+		memcpy(s->member, p, len < plen ? len : plen);		\
+	}								\
+	static inline void omf_##name(const type *s, void *p, size_t plen)\
+	{								\
+		size_t len = sizeof(((type *)0)->member);		\
+		memcpy(p, s->member, len < plen ? len : plen);		\
+	}
+
+
+/* MPOOL_NAMESZ_MAX should match OMF_MPOOL_NAME_LEN */
+#define OMF_MPOOL_NAME_LEN 32
+
+/* MPOOL_UUID_SIZE should match OMF_UUID_PACKLEN */
+#define OMF_UUID_PACKLEN 16
+
+/**
+ * enum mc_features_omf - Drive features that participate in media classes
+ *	                  definition. These values are ored in a 64 bits field.
+ */
+enum mc_features_omf {
+	OMF_MC_FEAT_MLOG_TGT   = 0x1,
+	OMF_MC_FEAT_MBLOCK_TGT = 0x2,
+	OMF_MC_FEAT_CHECKSUM   = 0x4,
+};
+
+
+/**
+ * enum devtype_omf -
+ * @OMF_PD_DEV_TYPE_BLOCK_STREAM: Block device implementing streams.
+ * @OMF_PD_DEV_TYPE_BLOCK_STD:    Standard (non-streams) device (SSD, HDD).
+ * @OMF_PD_DEV_TYPE_FILE:	  File in user space for UT.
+ * @OMF_PD_DEV_TYPE_MEM:	  Memory semantic device. Such as NVDIMM
+ *                                direct access (raw or dax mode).
+ * @OMF_PD_DEV_TYPE_ZONE:	  zone-like device, such as open channel SSD
+ *				  (OC-SSD) and SMR HDD (using ZBC/ZAC).
+ * @OMF_PD_DEV_TYPE_BLOCK_NVDIMM: Standard (non-streams) NVDIMM in sector mode.
+ */
+enum devtype_omf {
+	OMF_PD_DEV_TYPE_BLOCK_STREAM	= 1,
+	OMF_PD_DEV_TYPE_BLOCK_STD	= 2,
+	OMF_PD_DEV_TYPE_FILE		= 3,
+	OMF_PD_DEV_TYPE_MEM		= 4,
+	OMF_PD_DEV_TYPE_ZONE		= 5,
+	OMF_PD_DEV_TYPE_BLOCK_NVDIMM    = 6,
+};
+
+
+/**
+ * struct layout_descriptor_omf - Layout descriptor version 1.
+ * @pol_zcnt: number of zones
+ * @pol_zaddr: zone start addr
+ *
+ * Introduced with binary version 1.0.0.0.
+ * "pol_" = packed omf layout
+ */
+struct layout_descriptor_omf {
+	__le32 pol_zcnt;
+	__le64 pol_zaddr;
+} __packed;
+
+/* Define set/get methods for layout_descriptor_omf */
+OMF_SETGET(struct layout_descriptor_omf, pol_zcnt, 32)
+OMF_SETGET(struct layout_descriptor_omf, pol_zaddr, 64)
+#define OMF_LAYOUT_DESC_PACKLEN (sizeof(struct layout_descriptor_omf))
+
+
+/**
+ * struct devparm descriptor_omf - packed omf devparm descriptor
+ * @podp_devid:    UUID for drive
+ * @podp_zonetot:  total number of zones
+ * @podp_devsz:    size of partition in bytes
+ * @podp_features: Features, ored bits of enum mc_features_omf
+ * @podp_mclassp:   enum mp_media_classp
+ * @podp_devtype:   PD type (enum devtype_omf)
+ * @podp_sectorsz:  2^podp_sectorsz = sector size
+ * @podp_zonepg:    zone size in number of zone pages
+ *
+ * The fields mclassp, devtype, sectosz, and zonepg uniquely identify the media class of the PD.
+ * All drives in a media class must have the same values in these fields.
+ */
+struct devparm_descriptor_omf {
+	u8     podp_mclassp;
+	u8     podp_devtype;
+	u8     podp_sectorsz;
+	u8     podp_devid[OMF_UUID_PACKLEN];
+	u8     podp_pad[5];
+	__le32 podp_zonepg;
+	__le32 podp_zonetot;
+	__le64 podp_devsz;
+	__le64 podp_features;
+} __packed;
+
+/* Define set/get methods for devparm_descriptor_omf */
+OMF_SETGET(struct devparm_descriptor_omf, podp_mclassp, 8)
+OMF_SETGET(struct devparm_descriptor_omf, podp_devtype, 8)
+OMF_SETGET(struct devparm_descriptor_omf, podp_sectorsz, 8)
+OMF_SETGET_CHBUF(struct devparm_descriptor_omf, podp_devid)
+OMF_SETGET(struct devparm_descriptor_omf, podp_zonepg, 32)
+OMF_SETGET(struct devparm_descriptor_omf, podp_zonetot, 32)
+OMF_SETGET(struct devparm_descriptor_omf, podp_devsz, 64)
+OMF_SETGET(struct devparm_descriptor_omf, podp_features, 64)
+#define OMF_DEVPARM_DESC_PACKLEN (sizeof(struct devparm_descriptor_omf))
+
+
+/*
+ * mlog structure:
+ * + An mlog comprises a consecutive sequence of log blocks,
+ *   where each log block is a single page within a zone
+ * + A log block comprises a header and a consecutive sequence of records
+ * + A record is a typed blob
+ *
+ * Log block headers must be versioned. Log block records do not
+ * require version numbers because they are typed and new types can
+ * always be added.
+ */
+
+/*
+ * Log block format -- version 1
+ *
+ * log block := header record+ eolb? trailer?
+ *
+ * header := struct omf_logblock_header where vers=2
+ *
+ * record := lrd byte*
+ *
+ * lrd := struct omf_logrec_descriptor with value
+ *   (<record length>, <chunk length>, enum logrec_type_omf value)
+ *
+ * eolb (end of log block marker) := struct omf_logrec_descriptor with value
+ *   (0, 0, enum logrec_type_omf.EOLB/0)
+ *
+ * trailer := zero bytes from end of last log block record to end of log block
+ *
+ * OMF_LOGREC_CEND must be the max. value for this enum.
+ */
+
+/**
+ * enum logrec_type_omf -
+ * @OMF_LOGREC_EOLB:      end of log block marker (start of trailer)
+ * @OMF_LOGREC_DATAFULL:  data record; contains all specified data
+ * @OMF_LOGREC_DATAFIRST: data record; contains first part of specified data
+ * @OMF_LOGREC_DATAMID:   data record; contains interior part of data
+ * @OMF_LOGREC_DATALAST:  data record; contains final part of specified data
+ * @OMF_LOGREC_CSTART:    compaction start marker
+ * @OMF_LOGREC_CEND:      compaction end marker
+ *
+ * A log record type of 0 signifies EOLB. This is really the start of the
+ * trailer but this simplifies parsing for partially filled log blocks.
+ * DATAFIRST, -MID, -LAST types are used for chunking logical data records.
+ */
+enum logrec_type_omf {
+	OMF_LOGREC_EOLB      = 0,
+	OMF_LOGREC_DATAFULL  = 1,
+	OMF_LOGREC_DATAFIRST = 2,
+	OMF_LOGREC_DATAMID   = 3,
+	OMF_LOGREC_DATALAST  = 4,
+	OMF_LOGREC_CSTART    = 5,
+	OMF_LOGREC_CEND      = 6,
+};
+
+
+/**
+ * struct logrec_descriptor_omf -packed omf logrec descriptor
+ * @polr_tlen:  logical length of data record (all chunks)
+ * @polr_rlen:  length of data chunk in this log record
+ * @polr_rtype: enum logrec_type_omf value
+ */
+struct logrec_descriptor_omf {
+	__le32 polr_tlen;
+	__le16 polr_rlen;
+	u8     polr_rtype;
+	u8     polr_pad;
+} __packed;
+
+/* Define set/get methods for logrec_descriptor_omf */
+OMF_SETGET(struct logrec_descriptor_omf, polr_tlen, 32)
+OMF_SETGET(struct logrec_descriptor_omf, polr_rlen, 16)
+OMF_SETGET(struct logrec_descriptor_omf, polr_rtype, 8)
+#define OMF_LOGREC_DESC_PACKLEN (sizeof(struct logrec_descriptor_omf))
+#define OMF_LOGREC_DESC_RLENMAX 65535
+
+
+#define OMF_LOGBLOCK_VERS    1
+
+/**
+ * struct logblock_header_omf - packed omf logblock header for all versions
+ * @polh_vers:    log block hdr version, offset 0 in all vers
+ * @polh_magic:   unique magic per mlog
+ * @polh_pfsetid: flush set ID of the previous log block
+ * @polh_cfsetid: flush set ID this log block belongs to
+ * @polh_gen:     generation number
+ */
+struct logblock_header_omf {
+	__le16 polh_vers;
+	u8     polh_magic[OMF_UUID_PACKLEN];
+	u8     polh_pad[6];
+	__le32 polh_pfsetid;
+	__le32 polh_cfsetid;
+	__le64 polh_gen;
+} __packed;
+
+/* Define set/get methods for logblock_header_omf */
+OMF_SETGET(struct logblock_header_omf, polh_vers, 16)
+OMF_SETGET_CHBUF(struct logblock_header_omf, polh_magic)
+OMF_SETGET(struct logblock_header_omf, polh_pfsetid, 32)
+OMF_SETGET(struct logblock_header_omf, polh_cfsetid, 32)
+OMF_SETGET(struct logblock_header_omf, polh_gen, 64)
+/* On-media log block header length */
+#define OMF_LOGBLOCK_HDR_PACKLEN (sizeof(struct logblock_header_omf))
+
+
+/*
+ * Metadata container (mdc) mlog data record formats.
+ *
+ * NOTE: mdc records are typed and as such do not need a version number as new
+ * types can always be added as required.
+ */
+/**
+ * enum mdcrec_type_omf -
+ * @OMF_MDR_UNDEF:   undefined; should never occur
+ * @OMF_MDR_OCREATE:  object create
+ * @OMF_MDR_OUPDATE:  object update
+ * @OMF_MDR_ODELETE:  object delete
+ * @OMF_MDR_OIDCKPT:  object id checkpoint
+ * @OMF_MDR_OERASE:   object erase, also log mlog gen number
+ * @OMF_MDR_MCCONFIG: media class config
+ * @OMF_MDR_MCSPARE:  media class spare zones set
+ * @OMF_MDR_VERSION:  MDC content version.
+ * @OMF_MDR_MPCONFIG:  mpool config record
+ */
+enum mdcrec_type_omf {
+	OMF_MDR_UNDEF       = 0,
+	OMF_MDR_OCREATE     = 1,
+	OMF_MDR_OUPDATE     = 2,
+	OMF_MDR_ODELETE     = 3,
+	OMF_MDR_OIDCKPT     = 4,
+	OMF_MDR_OERASE      = 5,
+	OMF_MDR_MCCONFIG    = 6,
+	OMF_MDR_MCSPARE     = 7,
+	OMF_MDR_VERSION     = 8,
+	OMF_MDR_MPCONFIG    = 9,
+	OMF_MDR_MAX         = 10,
+};
+
+/**
+ * struct mdcver_omf - packed mdc version, version of an mpool MDC content.
+ * @pv_rtype:      OMF_MDR_VERSION
+ * @pv_mdcv_major: to compare with MAJOR in binary version.
+ * @pv_mdcv_minor: to compare with MINOR in binary version.
+ * @pv_mdcv_patch: to compare with PATCH in binary version.
+ * @pv_mdcv_dev:   used during development cycle when the above
+ *                 numbers don't change.
+ *
+ * This is not the version of the message framing used for the MDC. This is
+ * version of the binary that introduced that version of the MDC content.
+ */
+struct mdcver_omf {
+	u8     pv_rtype;
+	u8     pv_pad;
+	__le16 pv_mdcv_major;
+	__le16 pv_mdcv_minor;
+	__le16 pv_mdcv_patch;
+	__le16 pv_mdcv_dev;
+} __packed;
+
+/* Define set/get methods for mdcrec_version_omf */
+OMF_SETGET(struct mdcver_omf, pv_rtype, 8)
+OMF_SETGET(struct mdcver_omf, pv_mdcv_major, 16)
+OMF_SETGET(struct mdcver_omf, pv_mdcv_minor, 16)
+OMF_SETGET(struct mdcver_omf, pv_mdcv_patch, 16)
+OMF_SETGET(struct mdcver_omf, pv_mdcv_dev,   16)
+
+
+/**
+ * struct mdcrec_data_odelete_omf - packed data record odelete
+ * @pdro_rtype: mdrec_type_omf:OMF_MDR_ODELETE, OMF_MDR_OIDCKPT
+ * @pdro_objid: object identifier
+ */
+struct mdcrec_data_odelete_omf {
+	u8     pdro_rtype;
+	u8     pdro_pad[7];
+	__le64 pdro_objid;
+} __packed;
+
+/* Define set/get methods for  mdcrec_data_odelete_omf */
+OMF_SETGET(struct  mdcrec_data_odelete_omf, pdro_rtype, 8)
+OMF_SETGET(struct  mdcrec_data_odelete_omf, pdro_objid, 64)
+
+
+/**
+ * struct mdcrec_data_oerase_omf - packed data record oerase
+ * @pdrt_rtype: mdrec_type_omf: OMF_MDR_OERASE
+ * @pdrt_objid: object identifier
+ * @pdrt_gen:   object generation number
+ */
+struct mdcrec_data_oerase_omf {
+	u8     pdrt_rtype;
+	u8     pdrt_pad[7];
+	__le64 pdrt_objid;
+	__le64 pdrt_gen;
+} __packed;
+
+/* Define set/get methods for mdcrec_data_oerase_omf */
+OMF_SETGET(struct mdcrec_data_oerase_omf, pdrt_rtype, 8)
+OMF_SETGET(struct mdcrec_data_oerase_omf, pdrt_objid, 64)
+OMF_SETGET(struct mdcrec_data_oerase_omf, pdrt_gen, 64)
+#define OMF_MDCREC_OERASE_PACKLEN (sizeof(struct mdcrec_data_oerase_omf))
+
+
+/**
+ * struct mdcrec_data_mcconfig_omf - packed data record mclass config
+ * @pdrs_rtype: mdrec_type_omf: OMF_MDR_MCCONFIG
+ * @pdrs_parm:
+ */
+struct mdcrec_data_mcconfig_omf {
+	u8                             pdrs_rtype;
+	u8                             pdrs_pad[7];
+	struct devparm_descriptor_omf  pdrs_parm;
+} __packed;
+
+
+OMF_SETGET(struct mdcrec_data_mcconfig_omf, pdrs_rtype, 8)
+#define OMF_MDCREC_MCCONFIG_PACKLEN (sizeof(struct mdcrec_data_mcconfig_omf))
+
+
+/**
+ * struct mdcrec_data_mcspare_omf - packed data record mcspare
+ * @pdra_rtype:   mdrec_type_omf: OMF_MDR_MCSPARE
+ * @pdra_mclassp: enum mp_media_classp
+ * @pdra_spzone:   percent spare zones for drives in media class
+ */
+struct mdcrec_data_mcspare_omf {
+	u8     pdra_rtype;
+	u8     pdra_mclassp;
+	u8     pdra_spzone;
+} __packed;
+
+/* Define set/get methods for mdcrec_data_mcspare_omf */
+OMF_SETGET(struct mdcrec_data_mcspare_omf, pdra_rtype, 8)
+OMF_SETGET(struct mdcrec_data_mcspare_omf, pdra_mclassp, 8)
+OMF_SETGET(struct mdcrec_data_mcspare_omf, pdra_spzone, 8)
+#define OMF_MDCREC_CLS_SPARE_PACKLEN (sizeof(struct mdcrec_data_mcspare_omf))
+
+
+/**
+ * struct mdcrec_data_ocreate_omf - packed data record ocreate
+ * @pdrc_rtype:     mdrec_type_omf: OMF_MDR_OCREATE or OMF_MDR_OUPDATE
+ * @pdrc_mclass:
+ * @pdrc_uuid:
+ * @pdrc_ld:
+ * @pdrc_objid:     object identifier
+ * @pdrc_gen:       object generation number
+ * @pdrc_mblen:     amount of data written in the mblock, for mlog this is 0
+ * @pdrc_uuid:      Used only for mlogs. Must be at the end of this struct.
+ */
+struct mdcrec_data_ocreate_omf {
+	u8                             pdrc_rtype;
+	u8                             pdrc_mclass;
+	u8                             pdrc_pad[2];
+	struct layout_descriptor_omf   pdrc_ld;
+	__le64                         pdrc_objid;
+	__le64                         pdrc_gen;
+	__le64                         pdrc_mblen;
+	u8                             pdrc_uuid[];
+} __packed;
+
+/* Define set/get methods for mdcrec_data_ocreate_omf */
+OMF_SETGET(struct mdcrec_data_ocreate_omf, pdrc_rtype, 8)
+OMF_SETGET(struct mdcrec_data_ocreate_omf, pdrc_mclass, 8)
+OMF_SETGET(struct mdcrec_data_ocreate_omf, pdrc_objid, 64)
+OMF_SETGET(struct mdcrec_data_ocreate_omf, pdrc_gen, 64)
+OMF_SETGET(struct mdcrec_data_ocreate_omf, pdrc_mblen, 64)
+#define OMF_MDCREC_OBJCMN_PACKLEN (sizeof(struct mdcrec_data_ocreate_omf) + \
+				   OMF_UUID_PACKLEN)
+
+
+/**
+ * struct mdcrec_data_mpconfig_omf - packed data mpool config
+ * @pdmc_rtype:
+ * @pdmc_oid1:
+ * @pdmc_oid2:
+ * @pdmc_uid:
+ * @pdmc_gid:
+ * @pdmc_mode:
+ * @pdmc_mclassp:
+ * @pdmc_captgt:
+ * @pdmc_ra_pages_max:
+ * @pdmc_vma_size_max:
+ * @pdmc_utype:         user-defined type (uuid)
+ * @pdmc_label:         user-defined label (ascii)
+ */
+struct mdcrec_data_mpconfig_omf {
+	u8      pdmc_rtype;
+	u8      pdmc_pad[7];
+	__le64  pdmc_oid1;
+	__le64  pdmc_oid2;
+	__le32  pdmc_uid;
+	__le32  pdmc_gid;
+	__le32  pdmc_mode;
+	__le32  pdmc_rsvd0;
+	__le64  pdmc_captgt;
+	__le32  pdmc_ra_pages_max;
+	__le32  pdmc_vma_size_max;
+	__le32  pdmc_rsvd1;
+	__le32  pdmc_rsvd2;
+	__le64  pdmc_rsvd3;
+	__le64  pdmc_rsvd4;
+	u8      pdmc_utype[16];
+	u8      pdmc_label[MPOOL_LABELSZ_MAX];
+} __packed;
+
+/* Define set/get methods for mdcrec_data_mpconfig_omf */
+OMF_SETGET(struct mdcrec_data_mpconfig_omf, pdmc_rtype, 8)
+OMF_SETGET(struct mdcrec_data_mpconfig_omf, pdmc_oid1, 64)
+OMF_SETGET(struct mdcrec_data_mpconfig_omf, pdmc_oid2, 64)
+OMF_SETGET(struct mdcrec_data_mpconfig_omf, pdmc_uid, 32)
+OMF_SETGET(struct mdcrec_data_mpconfig_omf, pdmc_gid, 32)
+OMF_SETGET(struct mdcrec_data_mpconfig_omf, pdmc_mode, 32)
+OMF_SETGET(struct mdcrec_data_mpconfig_omf, pdmc_rsvd0, 32)
+OMF_SETGET(struct mdcrec_data_mpconfig_omf, pdmc_captgt, 64)
+OMF_SETGET(struct mdcrec_data_mpconfig_omf, pdmc_ra_pages_max, 32)
+OMF_SETGET(struct mdcrec_data_mpconfig_omf, pdmc_vma_size_max, 32)
+OMF_SETGET(struct mdcrec_data_mpconfig_omf, pdmc_rsvd1, 32)
+OMF_SETGET(struct mdcrec_data_mpconfig_omf, pdmc_rsvd2, 32)
+OMF_SETGET(struct mdcrec_data_mpconfig_omf, pdmc_rsvd3, 64)
+OMF_SETGET(struct mdcrec_data_mpconfig_omf, pdmc_rsvd4, 64)
+OMF_SETGET_CHBUF(struct mdcrec_data_mpconfig_omf, pdmc_utype)
+OMF_SETGET_CHBUF(struct mdcrec_data_mpconfig_omf, pdmc_label)
+#define OMF_MDCREC_MPCONFIG_PACKLEN (sizeof(struct mdcrec_data_mpconfig_omf))
+
+
+/*
+ * Object types embedded in opaque uint64 object ids by the pmd module.
+ * This encoding is also present in the object ids stored in the
+ * data records on media.
+ *
+ * The obj_type field is 4 bits. There are two valid obj types.
+ */
+enum obj_type_omf {
+	OMF_OBJ_UNDEF       = 0,
+	OMF_OBJ_MBLOCK      = 1,
+	OMF_OBJ_MLOG        = 2,
+};
+
+/**
+ * sb_descriptor_ver_omf - Mpool super block version
+ * @OMF_SB_DESC_UNDEF: value not on media
+ */
+enum sb_descriptor_ver_omf {
+	OMF_SB_DESC_UNDEF        = 0,
+	OMF_SB_DESC_V1           = 1,
+
+};
+#define OMF_SB_DESC_VER_LAST   OMF_SB_DESC_V1
+
+
+/**
+ * struct sb_descriptor_omf - packed super block, super block descriptor format version 1.
+ * @psb_magic:  mpool magic value; offset 0 in all vers
+ * @psb_name:   mpool name
+ * @psb_poolid: UUID of pool this drive belongs to
+ * @psb_vers:   sb format version; offset 56
+ * @psb_gen:    sb generation number on this drive
+ * @psb_cksum1: checksum of all fields above
+ * @psb_parm:   parameters for this drive
+ * @psb_cksum2: checksum of psb_parm
+ * @psb_mdc01gen:   mdc0 log1 generation number
+ * @psb_mdc01uuid:
+ * @psb_mdc01devid: mdc0 log1 device UUID
+ * @psb_mdc01strip: mdc0 log1 strip desc.
+ * @psb_mdc01desc:  mdc0 log1 layout
+ * @psb_mdc02gen:   mdc0 log2 generation number
+ * @psb_mdc02uuid:
+ * @psb_mdc02devid: mdc0 log2 device UUID
+ * @psb_mdc02strip: mdc0 log2 strip desc.
+ * @psb_mdc02desc:  mdc0 log2 layout
+ * @psb_mdc0dev:    drive param for mdc0 strip
+ *
+ * Note: these fields, up to and including psb_cksum1, are known to libblkid.
+ * cannot change them without havoc. Fields from psb_magic to psb_cksum1
+ * included are at same offset in all versions.
+ */
+struct sb_descriptor_omf {
+	__le64                         psb_magic;
+	u8                             psb_name[OMF_MPOOL_NAME_LEN];
+	u8                             psb_poolid[OMF_UUID_PACKLEN];
+	__le16                         psb_vers;
+	__le32                         psb_gen;
+	u8                             psb_cksum1[4];
+
+	u8                             psb_pad1[6];
+	struct devparm_descriptor_omf  psb_parm;
+	u8                             psb_cksum2[4];
+
+	u8                             psb_pad2[4];
+	__le64                         psb_mdc01gen;
+	u8                             psb_mdc01uuid[OMF_UUID_PACKLEN];
+	u8                             psb_mdc01devid[OMF_UUID_PACKLEN];
+	struct layout_descriptor_omf   psb_mdc01desc;
+
+	u8                             psb_pad3[4];
+	__le64                         psb_mdc02gen;
+	u8                             psb_mdc02uuid[OMF_UUID_PACKLEN];
+	u8                             psb_mdc02devid[OMF_UUID_PACKLEN];
+	struct layout_descriptor_omf   psb_mdc02desc;
+
+	u8                             psb_pad4[4];
+	struct devparm_descriptor_omf  psb_mdc0dev;
+} __packed;
+
+OMF_SETGET(struct sb_descriptor_omf, psb_magic, 64)
+OMF_SETGET_CHBUF(struct sb_descriptor_omf, psb_name)
+OMF_SETGET_CHBUF(struct sb_descriptor_omf, psb_poolid)
+OMF_SETGET(struct sb_descriptor_omf, psb_vers, 16)
+OMF_SETGET(struct sb_descriptor_omf, psb_gen, 32)
+OMF_SETGET_CHBUF(struct sb_descriptor_omf, psb_cksum1)
+OMF_SETGET_CHBUF(struct sb_descriptor_omf, psb_cksum2)
+OMF_SETGET(struct sb_descriptor_omf, psb_mdc01gen, 64)
+OMF_SETGET_CHBUF(struct sb_descriptor_omf, psb_mdc01uuid)
+OMF_SETGET_CHBUF(struct sb_descriptor_omf, psb_mdc01devid)
+OMF_SETGET(struct sb_descriptor_omf, psb_mdc02gen, 64)
+OMF_SETGET_CHBUF(struct sb_descriptor_omf, psb_mdc02uuid)
+OMF_SETGET_CHBUF(struct sb_descriptor_omf, psb_mdc02devid)
+#define OMF_SB_DESC_PACKLEN (sizeof(struct sb_descriptor_omf))
+
+/*
+ * For object-related records OCREATE/OUPDATE is max so compute that here as:
+ * rtype + objid + gen + layout desc
+ */
+#define OMF_MDCREC_PACKLEN_MAX max(OMF_MDCREC_OBJCMN_PACKLEN,            \
+				   max(OMF_MDCREC_MCCONFIG_PACKLEN,      \
+				       max(OMF_MDCREC_CLS_SPARE_PACKLEN, \
+					   OMF_MDCREC_MPCONFIG_PACKLEN)))
+
+#endif /* MPOOL_OMF_H */
diff --git a/drivers/mpool/omf_if.h b/drivers/mpool/omf_if.h
new file mode 100644
index 000000000000..5f11a03ef500
--- /dev/null
+++ b/drivers/mpool/omf_if.h
@@ -0,0 +1,381 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+#ifndef MPOOL_OMF_IF_H
+#define MPOOL_OMF_IF_H
+
+#include "uuid.h"
+#include "mpool_ioctl.h"
+
+#include "mp.h"
+#include "omf.h"
+
+struct mpool_descriptor;
+struct pmd_layout;
+
+/*
+ * Common defs: versioned via version number field of enclosing structs
+ */
+
+/**
+ * struct omf_layout_descriptor - version 1 layout descriptor
+ * @ol_zaddr:
+ * @ol_zcnt: number of zones
+ * @ol_pdh:
+ */
+struct omf_layout_descriptor {
+	u64    ol_zaddr;
+	u32    ol_zcnt;
+	u16    ol_pdh;
+};
+
+/**
+ * struct omf_devparm_descriptor - version 1 devparm descriptor
+ * @odp_devid:    UUID for drive
+ * @odp_devsz:    size, in bytes, of the volume/device
+ * @odp_zonetot:  total number of zones
+ * @odp_zonepg:   zone size in number of zone pages
+ * @odp_mclassp:  enum mp_media_classp
+ * @odp_devtype:  PD type. Enum pd_devtype
+ * @odp_sectorsz: 2^podp_sectorsz = sector size
+ * @odp_features: Features, ored bits of enum mp_mc_features
+ *
+ * The fields zonepg, mclassp, devtype, sectosz, and features uniquely identify
+ * the media class of the PD.
+ * All drives in a media class must have the same values in the below fields.
+ */
+struct omf_devparm_descriptor {
+	struct mpool_uuid  odp_devid;
+	u64                odp_devsz;
+	u32                odp_zonetot;
+
+	u32                odp_zonepg;
+	u8                 odp_mclassp;
+	u8                 odp_devtype;
+	u8                 odp_sectorsz;
+	u64                odp_features;
+};
+
+/*
+ * Superblock (sb) -- version 1
+ *
+ * Note this is 8-byte-wide reversed to get correct ascii order
+ */
+#define OMF_SB_MAGIC  0x7665446c6f6f706dULL  /* ASCII mpoolDev - no null */
+
+/**
+ * struct omf_sb_descriptor - version 1 superblock descriptor
+ * @osb_magic:  mpool magic value
+ * @osb_name:   mpool name, contains a terminating 0 byte
+ * @osb_cktype: enum mp_cksum_type value
+ * @osb_vers:   sb format version
+ * @osb_poolid: UUID of pool this drive belongs to
+ * @osb_gen:    sb generation number on this drive
+ * @osb_parm:   parameters for this drive
+ * @osb_mdc01gen:   mdc0 log1 generation number
+ * @osb_mdc01uuid:
+ * @osb_mdc01devid:
+ * @osb_mdc01desc:  mdc0 log1 layout
+ * @osb_mdc02gen:   mdc0 log2 generation number
+ * @osb_mdc02uuid:
+ * @osb_mdc02devid:
+ * @osb_mdc02desc:  mdc0 log2 layout
+ * @osb_mdc0dev:   drive param for mdc0
+ */
+struct omf_sb_descriptor {
+	u64                            osb_magic;
+	u8                             osb_name[MPOOL_NAMESZ_MAX];
+	u8                             osb_cktype;
+	u16                            osb_vers;
+	struct mpool_uuid              osb_poolid;
+	u32                            osb_gen;
+	struct omf_devparm_descriptor  osb_parm;
+
+	u64                            osb_mdc01gen;
+	struct mpool_uuid              osb_mdc01uuid;
+	struct mpool_uuid              osb_mdc01devid;
+	struct omf_layout_descriptor   osb_mdc01desc;
+
+	u64                            osb_mdc02gen;
+	struct mpool_uuid              osb_mdc02uuid;
+	struct mpool_uuid              osb_mdc02devid;
+	struct omf_layout_descriptor   osb_mdc02desc;
+
+	struct omf_devparm_descriptor  osb_mdc0dev;
+};
+
+/**
+ * struct omf_logrec_descriptor -
+ * @olr_tlen:  logical length of data record (all chunks)
+ * @olr_rlen:  length of data chunk in this log record
+ * @olr_rtype: enum logrec_type_omf value
+ *
+ */
+struct omf_logrec_descriptor {
+	u32    olr_tlen;
+	u16    olr_rlen;
+	u8     olr_rtype;
+};
+
+/**
+ * struct omf_logblock_header -
+ * @olh_magic:   unique ID per mlog
+ * @olh_pfsetid: flush set ID of the previous log block
+ * @olh_cfsetid: flush set ID this log block
+ * @olh_gen:     generation number
+ * @olh_vers:    log block format version
+ */
+struct omf_logblock_header {
+	struct mpool_uuid    olh_magic;
+	u32                olh_pfsetid;
+	u32                olh_cfsetid;
+	u64                olh_gen;
+	u16                olh_vers;
+};
+
+/**
+ * struct omf_mdcver - version of an mpool MDC content.
+ * @mdcver:
+ *
+ * mdcver[0]: major version number
+ * mdcver[1]: minor version number
+ * mdcver[2]: patch version number
+ * mdcver[3]: development version number. Used during development cycle when
+ *            the above numbers don't change.
+ *
+ * This is not the version of the message framing used for the MDC.
+ * This the version of the binary that introduced that version of the MDC
+ * content.
+ */
+struct omf_mdcver {
+	u16    mdcver[4];
+};
+
+#define mdcv_major    mdcver[0]
+#define mdcv_minor    mdcver[1]
+#define mdcv_patch    mdcver[2]
+#define mdcv_dev      mdcver[3]
+
+/**
+ * struct omf_mdcrec_data -
+ * @omd_version:  OMF_MDR_VERSION record
+ * @omd_objid:  object identifier
+ * @omd_gen:    object generation number
+ * @omd_layout:
+ * @omd_mblen:  Length of written data in object
+ * @omd_old:
+ * @omd_uuid:
+ * @omd_parm:
+ * @omd_mclassp: mp_media_classp
+ * @omd_spzone:   percent spare zones for drives in media class
+ * @omd_cfg:
+ * @omd_rtype: enum mdcrec_type_omf value
+ *
+ * object-related rtypes:
+ * ODELETE, OIDCKPT: objid field only; others ignored
+ * OERASE: objid and gen fields only; others ignored
+ * OCREATE, OUPDATE: layout field only; others ignored
+ */
+struct omf_mdcrec_data {
+	union ustruct {
+		struct omf_mdcver omd_version;
+
+		struct object {
+			u64                             omd_objid;
+			u64                             omd_gen;
+			struct pmd_layout              *omd_layout;
+			u64                             omd_mblen;
+			struct omf_layout_descriptor    omd_old;
+			struct mpool_uuid               omd_uuid;
+			u8                              omd_mclass;
+		} obj;
+
+		struct drive_state {
+			struct omf_devparm_descriptor  omd_parm;
+		} dev;
+
+		struct media_cls_spare {
+			u8 omd_mclassp;
+			u8 omd_spzone;
+		} mcs;
+
+		struct mpool_config    omd_cfg;
+	} u;
+
+	u8             omd_rtype;
+};
+
+/**
+ * objid_type() - Return the type field from an objid
+ * @objid:
+ */
+static inline int objid_type(u64 objid)
+{
+	return ((objid & 0xF00) >> 8);
+}
+
+static inline bool objtype_valid(enum obj_type_omf otype)
+{
+	return otype && (otype <= 2);
+};
+
+/*
+ * omf API functions -- exported functions for working with omf structures
+ */
+
+/**
+ * omf_sb_pack_htole() - pack superblock
+ * @sb: struct omf_sb_descriptor *
+ * @outbuf: char *
+ *
+ * Pack superblock into outbuf little-endian computing specified checksum.
+ *
+ * Return: 0 if successful, -EINVAL otherwise
+ */
+int omf_sb_pack_htole(struct omf_sb_descriptor *sb, char *outbuf);
+
+/**
+ * omf_sb_unpack_letoh() - unpack superblock
+ * @sb: struct omf_sb_descriptor *
+ * @inbuf: char *
+ * @omf_ver: on-media-format superblock version
+ *
+ * Unpack little-endian superblock from inbuf into sb verifying checksum.
+ *
+ * Return: 0 if successful, -errno otherwise
+ */
+int omf_sb_unpack_letoh(struct omf_sb_descriptor *sb, const char *inbuf, u16 *omf_ver);
+
+/**
+ * omf_sb_has_magic_le() - Determine if buffer has superblock magic value
+ * @inbuf: char *
+ *
+ * Determine if little-endian buffer inbuf has superblock magic value
+ * where expected; does NOT imply inbuf is a valid superblock.
+ *
+ * Return: 1 if true; 0 otherwise
+ */
+bool omf_sb_has_magic_le(const char *inbuf);
+
+/**
+ * omf_logblock_header_pack_htole() - pack log block header
+ * @lbh: struct omf_logblock_header *
+ * @outbuf: char *
+ *
+ * Pack header into little-endian log block buffer lbuf, ex-checksum.
+ *
+ * Return: 0 if successful, -errno otherwise
+ */
+int omf_logblock_header_pack_htole(struct omf_logblock_header *lbh, char *lbuf);
+
+/**
+ * omf_logblock_header_len_le() - Determine header length of log block
+ * @lbuf: char *
+ *
+ * Check little-endian log block in lbuf to determine header length.
+ *
+ * Return: bytes in packed header; -EINVAL if invalid header vers
+ */
+int omf_logblock_header_len_le(char *lbuf);
+
+/**
+ * omf_logblock_header_unpack_letoh() - unpack log block header
+ * @lbh: struct omf_logblock_header *
+ * @inbuf: char *
+ *
+ * Unpack little-endian log block header from lbuf into lbh; does not
+ * verify checksum.
+ *
+ * Return: 0 if successful, -EINVAL if invalid log block header vers
+ */
+int omf_logblock_header_unpack_letoh(struct omf_logblock_header *lbh, const char *inbuf);
+
+/**
+ * omf_logrec_desc_pack_htole() - pack log record descriptor
+ * @lrd: struct omf_logrec_descriptor *
+ * @outbuf: char *
+ *
+ * Pack log record descriptor into outbuf little-endian.
+ *
+ * Return: 0 if successful, -EINVAL if invalid log rec type
+ */
+int omf_logrec_desc_pack_htole(struct omf_logrec_descriptor *lrd, char *outbuf);
+
+/**
+ * omf_logrec_desc_unpack_letoh() - unpack log record descriptor
+ * @lrd: struct omf_logrec_descriptor *
+ * @inbuf: char *
+ *
+ * Unpack little-endian log record descriptor from inbuf into lrd.
+ */
+void omf_logrec_desc_unpack_letoh(struct omf_logrec_descriptor *lrd, const char *inbuf);
+
+/**
+ * omf_mdcrec_pack_htole() - pack mdc record
+ * @mp: struct mpool_descriptor *
+ * @cdr: struct omf_mdcrec_data *
+ * @outbuf: char *
+ *
+ * Pack mdc record into outbuf little-endian.
+ * NOTE: Assumes outbuf has enough space for the layout structure.
+ *
+ * Return: bytes packed if successful, -EINVAL otherwise
+ */
+int omf_mdcrec_pack_htole(struct mpool_descriptor *mp, struct omf_mdcrec_data *cdr, char *outbuf);
+
+/**
+ * omf_mdcrec_unpack_letoh() - unpack mdc record
+ * @mdcver: mdc content version of the mdc from which this data comes.
+ *          NULL means latest MDC content version known by this binary.
+ * @mp:     struct mpool_descriptor *
+ * @cdr:    struct omf_mdcrec_data *
+ * @inbuf:  char *
+ *
+ * Unpack little-endian mdc record from inbuf into cdr.
+ *
+ * Return: 0 if successful, -errno on error
+ */
+int omf_mdcrec_unpack_letoh(struct omf_mdcver *mdcver, struct mpool_descriptor *mp,
+			    struct omf_mdcrec_data *cdr, const char *inbuf);
+
+/**
+ * omf_mdcrec_isobj_le() - determine if mdc recordis object-related
+ * @inbuf: char *
+ *
+ * Return true if little-endian mdc record in inbuf is object-related.
+ */
+int omf_mdcrec_isobj_le(const char *inbuf);
+
+/**
+ * omf_mdcver_unpack_letoh() - Unpack le mdc version record from inbuf.
+ * @cdr:
+ * @inbuf:
+ */
+void omf_mdcver_unpack_letoh(struct omf_mdcrec_data *cdr, const char *inbuf);
+
+/**
+ * omf_mdcrec_unpack_type_letoh() - extract the record type from a packed MDC record.
+ * @inbuf: packed MDC record.
+ */
+u8 omf_mdcrec_unpack_type_letoh(const char *inbuf);
+
+/**
+ * logrec_type_datarec() - data record or not
+ * @rtype:
+ *
+ * Return: true if the log record type is related to a data record.
+ */
+bool logrec_type_datarec(enum logrec_type_omf rtype);
+
+/**
+ * omf_sbver_to_mdcver() - Returns the matching mdc version for a given superblock version
+ * @sbver: superblock version
+ */
+struct omf_mdcver *omf_sbver_to_mdcver(enum sb_descriptor_ver_omf sbver);
+
+int omf_init(void) __cold;
+void omf_exit(void) __cold;
+
+#endif /* MPOOL_OMF_IF_H */
diff --git a/drivers/mpool/upgrade.h b/drivers/mpool/upgrade.h
new file mode 100644
index 000000000000..3b3748c47a3e
--- /dev/null
+++ b/drivers/mpool/upgrade.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+/*
+ * Defines structures for upgrading MPOOL meta data
+ */
+
+#ifndef MPOOL_UPGRADE_H
+#define MPOOL_UPGRADE_H
+
+#include "omf_if.h"
+
+/*
+ * Size of version converted to string.
+ * 4 * (5 bytes for a u16) + 3 * (1 byte for the '.') + 1 byte for \0
+ */
+#define MAX_MDCVERSTR          24
+
+/*
+ * Naming conventions:
+ *
+ * omf structures:
+ * ---------------
+ * The old structure names end with _omf_v<version number>.
+ * For example: layout_descriptor_omf_v1
+ * The current/latest structure name end simply with _omf.
+ * For example: layout_descriptor_omf
+ *
+ * Conversion functions:
+ * ---------------------
+ * They are named like:
+ * omf_convert_<blabla>_<maj>_<min>_<patch>_<dev>to<maj>_<min>_<patch>_<dev>()
+ *
+ * For example: omf_convert_sb_1_0_0_0to1_0_0_1()
+ *
+ * They are not named like omf_convert_<blabla>_v1tov2() because sometimes the
+ * input and output structures are exactly the same and the conversion is
+ * related to some subtle interpretation of structure filed[s] content.
+ *
+ * Unpack functions:
+ * -----------------
+ * They are named like:
+ * omf_<blabla>_unpack_letoh_v<version number>()
+ * <version number> being the version of the structure.
+ *
+ * For example: omf_layout_unpack_letoh_v1()
+ * Note that for the latest/current version of the structure we cannot
+ * name the unpack function omf_<blabla>_unpack_letoh() because that would
+ * introduce a name conflict with the top unpack function that calls
+ * omf_unpack_letoh_and_convert()
+ *
+ * For example for layout we have:
+ * omf_layout_unpack_letoh_v1() unpacks layout_descriptor_omf_v1
+ * omf_layout_unpack_letoh_v2() unpacks layout_descriptor_omf
+ * omf_layout_unpack_letoh() calls one of the two above.
+ */
+
+/**
+ * struct upgrade_history -
+ * @uh_size:    size of the current version in-memory structure
+ * @uh_unpack:  unpacking function from on-media format to in-memory format
+ * @uh_conv:    conversion function from previous version to current version,
+ *              set to NULL for the first version
+ * @uh_sbver:   corresponding superblock version since which the change has
+ *              been introduced. If this structure is not used by superblock
+ *              set uh_sbver =  OMF_SB_DESC_UNDEF.
+ * @uh_mdcver: corresponding mdc ver since which the change has been
+ *              introduced
+ *
+ * Every time we update a nested structure in superblock or MDC, we need to
+ * save the following information about this update, such that we can keep the
+ * update history of this structure
+ */
+struct upgrade_history {
+	size_t                      uh_size;
+	int (*uh_unpack)(void *out, const char *inbuf);
+	int (*uh_conv)(const void *pre, void *cur);
+	enum sb_descriptor_ver_omf  uh_sbver;
+	struct omf_mdcver          uh_mdcver;
+};
+
+/**
+ * omfu_mdcver_cur() - Return the latest mpool MDC content version understood by this binary
+ */
+struct omf_mdcver *omfu_mdcver_cur(void);
+
+/**
+ * omfu_mdcver_comment() - Return mpool MDC content version comment passed in via "mdcver".
+ * @mdcver:
+ */
+const char *omfu_mdcver_comment(struct omf_mdcver *mdcver);
+
+/**
+ * omfu_mdcver_to_str() - convert a version into a string.
+ * @mdcver: version to convert
+ * @buf:    buffer in which to place the conversion.
+ * @sz:     size of "buf" in bytes.
+ *
+ * Returns "buf"
+ */
+char *omfu_mdcver_to_str(struct omf_mdcver *mdcver, char *buf, size_t sz);
+
+/**
+ * omfu_mdcver_cmp() - compare two versions a and b
+ * @a:  first version
+ * @op: compare operator (C syntax), can be "<", "<=", ">", ">=", "==".
+ * @b:  second version
+ *
+ * Return (a op b)
+ */
+bool omfu_mdcver_cmp(struct omf_mdcver *a, char *op, struct omf_mdcver *b);
+
+/**
+ * omfu_mdcver_cmp2() - compare two versions
+ * @a:     first version
+ * @op:    compare operator (C syntax), can be "<", "<=", ">", ">=", "==".
+ * @major: major, minor, patch and dev which composes the second version
+ * @minor:
+ * @patch:
+ * @dev:
+ *
+ * Return true (a op b)
+ */
+bool omfu_mdcver_cmp2(struct omf_mdcver *a, char *op, u16 major, u16 minor, u16 patch, u16 dev);
+
+#endif /* MPOOL_UPGRADE_H */
-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
