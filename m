Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2868528BD99
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 18:28:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C82315AE2A59;
	Mon, 12 Oct 2020 09:28:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.94.87; helo=nam10-mw2-obe.outbound.protection.outlook.com; envelope-from=nmeeramohide@micron.com; receiver=<UNKNOWN> 
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8099F15AE2A54
	for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 09:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUhLkq+181liDROWnjfgLbEYIfi3d1LgS4i5DHO49p3pXMilCsGcm1xlA0uIsAr4jhlHYtELxjvUz0OBxEnhFngbUFINfNMHfPAMmXxijou5tDhcX2JVLDGFZqzwU2EO7YTuUT3iTXyQ63ntJOaknhXfZMZ4arelfMDIKne5erPyxS53CLTDxkIG7dRsRzdXapbSXZKyLu7nEO+ZIDmLEFo9lf7W8V8mfHX2S2IeLb44M/Ru0O8YcMSMnY1AQb8ic13ZIVjE3Rn34rN67gZNJZqrDwlGTKFHdTNMOrWrJa1K+FGu6GVa4COHdHcmMMnPck1n9SzdtAAWePOCXIBndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JluFwbD7SGL9gJMR+EvXSujNucjW1WufbXqhWo5q/Ig=;
 b=Z+TWWhbwzAJGeHCM+tyOOCXF/D1iF0FHITXd4JKEQ+uVLsz0h+fLwJ6CaUFHhgOx3RtIMVwe3hXaP34c3skHXYL42Jad0WclkT3vLEYaK1AF9mzf5891i9f2/v4nWoA5ThkMwiA8kqVJT7qMBhyJw0EaEItR+EWDI0VOWrWeizIAliOWhcF/9oYJzB+yWrcU2a+DomEy7FXsChG97nP8/RL+IAhNm0gRXQ6dxSfc3QiI6FB5MoDeuEOAKlEXUbaw+4zy3lHk6AfbZNP+dxehoDO1OpZQQzrnYSXkyhIMdf6AXWKKnkH7/L+YrKRrcUbkx5hLyi64lce6wRiMQxYn7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JluFwbD7SGL9gJMR+EvXSujNucjW1WufbXqhWo5q/Ig=;
 b=JhOPaEy9gZsAi3QJlmQ3MOZChWlE+Vqte8Ol9QFEeJiiFwrUeNebYNeJjHM9Ll23j93M+Y56ZLTdshU8oWiixqSODwJmI3q3zybiG2Z4uKot6H5FtDM+ldCDHH/VQ7uZB5SER6otLkvbmXc2Ld9/sZiUhkvh0UFt6YMWU+VGvoA=
Received: from SN4PR0201CA0051.namprd02.prod.outlook.com
 (2603:10b6:803:20::13) by DM5PR08MB2411.namprd08.prod.outlook.com
 (2603:10b6:3:6e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Mon, 12 Oct
 2020 16:27:57 +0000
Received: from SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::26) by SN4PR0201CA0051.outlook.office365.com
 (2603:10b6:803:20::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Mon, 12 Oct 2020 16:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 SN1NAM01FT015.mail.protection.outlook.com (10.152.65.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:27:56 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 10:27:53 -0600
From: Nabeel M Mohamed <nmeeramohide@micron.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-nvdimm@lists.01.org>
Subject: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
Date: Mon, 12 Oct 2020 11:27:14 -0500
Message-ID: <20201012162736.65241-1-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
X-ClientProxiedBy: bowex17a.micron.com (137.201.21.209) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--9.617400-0.000000-31
X-TM-AS-MatchedID: 155702-703408-704232-702522-704499-701478-704783-701343-7
	03674-702207-702619-704623-703226-702874-701239-703851-704841-701342-703638
	-702877-701086-701580-702501-701969-700026-704671-700224-704585-700864-7045
	02-702672-700025-702935-703117-703713-702876-704418-702751-704397-702083-84
	7298-703550-703279-703651-702719-700335-702342-702203-704274-704637-702345-
	703215-701809-703017-700535-703712-105400-703958-700717-700863-703844-70504
	1-701589-704253-704318-702727-701913-704981-702754-701073-703812-703115-704
	949-701844-701031-705161-702783-703080-705247-700958-704718-700400-704960-7
	01030-700260-702617-703027-701077-704014-139705-148004-148036-42000-42003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92dd5db8-de2c-4b9f-f769-08d86ecbc6c2
X-MS-TrafficTypeDiagnostic: DM5PR08MB2411:
X-Microsoft-Antispam-PRVS: 
 <DM5PR08MB24119CA21526E5249201CBA5B3070@DM5PR08MB2411.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	782nXjsFi7qv2aLKDCGQrOvnveO+fursLNsr3n8R1M3A9f6xsitW/qHkoVy8fNr/U5Fc9XDZQ8fE0F7nq5pKeuCkceERRKx0uw/i6gBqImwK5RPMIdLwC/Ombeq+0OA7WzuAt6C2fAIsivNqoTvd9a0FvOWgZpLoSBwO4VPiMSGKvneNmFhN8Yoqt1c0Ioc5uf2HRuznTV050XshWIi4oogZ2KLySWAhvooxWyBVvG9TIqAF3FiQdARwb7VXLCqLFBRB7uO2swe6itE9V8OffVNON32BVHH7kO0OtuTefn9orJxKKykVq9RnllJBcV4/Hf46pgEnmiT4DQ+KsTMmZHsdSPjW5jM1c3FO0P5fEMJADgH7N+rGXusL2SHgLxQWC9HslSo99rMn48TW4DwYujpa/RY5d4y4YLKiV+bI/fYktMsUiJh3eJHrfwYLOYwRE4JU9KXFYGxODsc9frlL6vwpTtTKcSaDzc8bqYvMqLMHownpHjWYouoWDH21bI/FYnk52FKp6K+5/PTi7WZ9KQ==
X-Forefront-Antispam-Report: 
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966005)(30864003)(5660300002)(70586007)(70206006)(83380400001)(4326008)(6286002)(82310400003)(86362001)(107886003)(83080400001)(356005)(1076003)(7636003)(966005)(478600001)(2906002)(33310700002)(82740400003)(2616005)(186003)(8936002)(316002)(426003)(26005)(55016002)(336012)(7696005)(6666004)(8676002)(54906003)(110136005)(36756003)(47076004)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:27:56.3278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92dd5db8-de2c-4b9f-f769-08d86ecbc6c2
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR08MB2411
Message-ID-Hash: 7COU6EHKHXTJV5B35EAZLBQ3NWBXWTQT
X-Message-ID-Hash: 7COU6EHKHXTJV5B35EAZLBQ3NWBXWTQT
X-MailFrom: nmeeramohide@micron.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com, Nabeel M Mohamed <nmeeramohide@micron.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7COU6EHKHXTJV5B35EAZLBQ3NWBXWTQT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series introduces the mpool object storage media pool driver.
Mpool implements a simple transactional object store on top of block
storage devices.

Mpool was developed for the Heterogeneous-Memory Storage Engine (HSE)
project, which is a high-performance key-value storage engine designed
for SSDs. HSE stores its data exclusively in mpool.

Mpool is readily applicable to other storage systems built on immutable
objects. For example, the many databases that store records in
immutable SSTables organized as an LSM-tree or similar data structure.

We developed mpool for HSE storage, versus using a file system or raw
block device, for several reasons.

A primary motivator was the need for a storage model that maps naturally
to conventional block storage devices, as well as to emerging device
interfaces we plan to support in the future, such as
* NVMe Zoned Namespaces (ZNS)
* NVMe Streams
* Persistent memory accessed via CXL or similar technologies

Another motivator was the need for a storage model that readily supports
multiple classes of storage devices or media in a single storage pool,
such as
* QLC SSDs for storing the bulk of objects, and
* 3DXP SSDs or persistent memory for storing objects requiring
  low-latency access

The mpool object storage model meets these needs. It also provides
other features that benefit storage systems built on immutable objects,
including
* Facilities to memory-map a specified collection of objects into a
  linear address space
* Concurrent access to object data directly and memory-mapped to greatly
  reduce page cache pollution from background operations such as
  LSM-tree compaction
* Proactive eviction of object data from the page cache, based on
  object-level metrics, to avoid excessive memory pressure and its
  associated performance impacts
* High concurrency and short code paths for efficient access to
  low-latency storage devices

HSE takes advantage of all these mpool features to achieve high
throughput with low tail-latencies.

Mpool is implemented as a character device driver where
* /dev/mpoolctl is the control file (minor number 0) supporting mpool
  management ioctls
* /dev/mpool/<mpool-name> are mpool files (minor numbers >0), one per
  mpool, supporting object management ioctls

CLI/UAPI access to /dev/mpoolctl and /dev/mpool/<mpool-name> are
controlled by their UID, GID, and mode bits. To provide a familiar look
and feel, the mpool management model and CLI are intentionally aligned
to those of LVM to the degree practical.

An mpool is created with a block storage device specified for its
required capacity media class, and optionally a second block storage
device specified for its staging media class. We recommend virtual
block devices (such as LVM logical volumes) to aggregate the performance
and capacity of multiple physical block devices, to enable sharing of
physical block devices between mpools (or for other uses), and to
support extending the size of a block device used for an mpool media
class. The libblkid library recognizes mpool formatted block devices as
of util-linux v2.32.

Mpool implements a transactional object store with two simple object
abstractions: mblocks and mlogs.

Mblock objects are containers comprising a linear sequence of bytes that
can be written exactly once, are immutable after writing, and can be
read in whole or in part as needed until deleted. Mblocks in a media
class are currently fixed size, which is configured when an mpool is
created, though the amount of data written to mblocks will differ.

Mlog objects are containers for record logging. Records of arbitrary
size can be appended to an mlog until it is full. Once full, an mlog
must be erased before additional records can be appended. Mlog records
can be read sequentially from the beginning at any time. Mlogs in a
media class are always a multiple of the mblock size for that media
class.

Mblock and mlog writes avoid the page cache. Mblocks are written,
committed, and made immutable before they can be read either directly
(avoiding the page cache) or mmaped. Mlogs are always read and updated
directly (avoiding the page cache) and cannot be mmaped.

Mpool also provides the metadata container (MDC) APIs that clients can
use to simplify storing and maintaining metadata. These MDC APIs are
helper functions built on a pair of mlogs per MDC.

The mpool Wiki contains full details on the
* Management model in the "Configure mpools" section
* Object model in the "Develop mpool Applications" section
* Kernel module architecture in the "Explore mpool Internals" section,
  which provides context for reviewing this patch series

See https://github.com/hse-project/mpool/wiki

The mpool UAPI and kernel module (not the patchset) are available on
GitHub at:

https://github.com/hse-project/mpool

https://github.com/hse-project/mpool-kmod

The HSE key-value storage engine is available on GitHub at:

https://github.com/hse-project/hse

Changes in v2:

- Fixes build errors/warnings reported by bot on ARCH=m68k
Reported-by: kernel test robot <lkp@intel.com>

- Addresses review comments from Randy and Hillf:
  * Updates ioctl-number.rst file with mpool driver's ioctl code
  * Fixes issues in the usage of printk_timed_ratelimit()

- Fixes a readahead issue found by internal testing

Nabeel M Mohamed (22):
  mpool: add utility routines and ioctl definitions
  mpool: add in-memory struct definitions
  mpool: add on-media struct definitions
  mpool: add pool drive component which handles mpool IO using the block
    layer API
  mpool: add space map component which manages free space on mpool
    devices
  mpool: add on-media pack, unpack and upgrade routines
  mpool: add superblock management routines
  mpool: add pool metadata routines to manage object lifecycle and IO
  mpool: add mblock lifecycle management and IO routines
  mpool: add mlog IO utility routines
  mpool: add mlog lifecycle management and IO routines
  mpool: add metadata container or mlog-pair framework
  mpool: add utility routines for mpool lifecycle management
  mpool: add pool metadata routines to create persistent mpools
  mpool: add mpool lifecycle management routines
  mpool: add mpool control plane utility routines
  mpool: add mpool lifecycle management ioctls
  mpool: add object lifecycle management ioctls
  mpool: add support to mmap arbitrary collection of mblocks
  mpool: add support to proactively evict cached mblock data from the
    page-cache
  mpool: add documentation
  mpool: add Kconfig and Makefile

 .../userspace-api/ioctl/ioctl-number.rst      |    3 +-
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/mpool/Kconfig                         |   28 +
 drivers/mpool/Makefile                        |   11 +
 drivers/mpool/assert.h                        |   25 +
 drivers/mpool/init.c                          |  126 +
 drivers/mpool/init.h                          |   17 +
 drivers/mpool/mblock.c                        |  432 +++
 drivers/mpool/mblock.h                        |  161 +
 drivers/mpool/mcache.c                        | 1072 +++++++
 drivers/mpool/mcache.h                        |  104 +
 drivers/mpool/mclass.c                        |  103 +
 drivers/mpool/mclass.h                        |  137 +
 drivers/mpool/mdc.c                           |  486 +++
 drivers/mpool/mdc.h                           |  106 +
 drivers/mpool/mlog.c                          | 1667 ++++++++++
 drivers/mpool/mlog.h                          |  212 ++
 drivers/mpool/mlog_utils.c                    | 1352 ++++++++
 drivers/mpool/mlog_utils.h                    |   63 +
 drivers/mpool/mp.c                            | 1086 +++++++
 drivers/mpool/mp.h                            |  231 ++
 drivers/mpool/mpcore.c                        |  987 ++++++
 drivers/mpool/mpcore.h                        |  354 +++
 drivers/mpool/mpctl.c                         | 2747 +++++++++++++++++
 drivers/mpool/mpctl.h                         |   58 +
 drivers/mpool/mpool-locking.rst               |   90 +
 drivers/mpool/mpool_ioctl.h                   |  636 ++++
 drivers/mpool/mpool_printk.h                  |   43 +
 drivers/mpool/omf.c                           | 1316 ++++++++
 drivers/mpool/omf.h                           |  593 ++++
 drivers/mpool/omf_if.h                        |  381 +++
 drivers/mpool/params.h                        |  116 +
 drivers/mpool/pd.c                            |  424 +++
 drivers/mpool/pd.h                            |  202 ++
 drivers/mpool/pmd.c                           | 2046 ++++++++++++
 drivers/mpool/pmd.h                           |  379 +++
 drivers/mpool/pmd_obj.c                       | 1569 ++++++++++
 drivers/mpool/pmd_obj.h                       |  499 +++
 drivers/mpool/reaper.c                        |  686 ++++
 drivers/mpool/reaper.h                        |   71 +
 drivers/mpool/sb.c                            |  625 ++++
 drivers/mpool/sb.h                            |  162 +
 drivers/mpool/smap.c                          | 1031 +++++++
 drivers/mpool/smap.h                          |  334 ++
 drivers/mpool/sysfs.c                         |   48 +
 drivers/mpool/sysfs.h                         |   48 +
 drivers/mpool/upgrade.c                       |  138 +
 drivers/mpool/upgrade.h                       |  128 +
 drivers/mpool/uuid.h                          |   59 +
 50 files changed, 23194 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mpool/Kconfig
 create mode 100644 drivers/mpool/Makefile
 create mode 100644 drivers/mpool/assert.h
 create mode 100644 drivers/mpool/init.c
 create mode 100644 drivers/mpool/init.h
 create mode 100644 drivers/mpool/mblock.c
 create mode 100644 drivers/mpool/mblock.h
 create mode 100644 drivers/mpool/mcache.c
 create mode 100644 drivers/mpool/mcache.h
 create mode 100644 drivers/mpool/mclass.c
 create mode 100644 drivers/mpool/mclass.h
 create mode 100644 drivers/mpool/mdc.c
 create mode 100644 drivers/mpool/mdc.h
 create mode 100644 drivers/mpool/mlog.c
 create mode 100644 drivers/mpool/mlog.h
 create mode 100644 drivers/mpool/mlog_utils.c
 create mode 100644 drivers/mpool/mlog_utils.h
 create mode 100644 drivers/mpool/mp.c
 create mode 100644 drivers/mpool/mp.h
 create mode 100644 drivers/mpool/mpcore.c
 create mode 100644 drivers/mpool/mpcore.h
 create mode 100644 drivers/mpool/mpctl.c
 create mode 100644 drivers/mpool/mpctl.h
 create mode 100644 drivers/mpool/mpool-locking.rst
 create mode 100644 drivers/mpool/mpool_ioctl.h
 create mode 100644 drivers/mpool/mpool_printk.h
 create mode 100644 drivers/mpool/omf.c
 create mode 100644 drivers/mpool/omf.h
 create mode 100644 drivers/mpool/omf_if.h
 create mode 100644 drivers/mpool/params.h
 create mode 100644 drivers/mpool/pd.c
 create mode 100644 drivers/mpool/pd.h
 create mode 100644 drivers/mpool/pmd.c
 create mode 100644 drivers/mpool/pmd.h
 create mode 100644 drivers/mpool/pmd_obj.c
 create mode 100644 drivers/mpool/pmd_obj.h
 create mode 100644 drivers/mpool/reaper.c
 create mode 100644 drivers/mpool/reaper.h
 create mode 100644 drivers/mpool/sb.c
 create mode 100644 drivers/mpool/sb.h
 create mode 100644 drivers/mpool/smap.c
 create mode 100644 drivers/mpool/smap.h
 create mode 100644 drivers/mpool/sysfs.c
 create mode 100644 drivers/mpool/sysfs.h
 create mode 100644 drivers/mpool/upgrade.c
 create mode 100644 drivers/mpool/upgrade.h
 create mode 100644 drivers/mpool/uuid.h

-- 
2.17.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
