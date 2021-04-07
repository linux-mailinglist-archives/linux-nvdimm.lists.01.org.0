Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C43F356D6C
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Apr 2021 15:38:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 14A0B100EBB63;
	Wed,  7 Apr 2021 06:38:37 -0700 (PDT)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 08B97100ED480
	for <linux-nvdimm@lists.01.org>; Wed,  7 Apr 2021 06:38:33 -0700 (PDT)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ar/A2yKmE+fEX87hrXqSrAW7HDtjpDfLM3DAb?=
 =?us-ascii?q?vn1ZSRFFG/GwvcaogfgdyFvImC8cMUtQ/eyoFYuhZTfn9ZBz6ZQMJrvKZmTbkU?=
 =?us-ascii?q?ahMY0K1+Xf6hLtFyD0/uRekYdMGpIVNPTeFl5/5Pya3CCdM/INhOaK67qpg+C2?=
 =?us-ascii?q?9QYJcShPZ7t75wl0Tia3e3cGJzVuPpYyGJqC6scvnVPJFkg/VNixBXUOQoH41r?=
 =?us-ascii?q?/2va/hCCRnOzcXrCGKjR6NrIXxCgWk2H4lOA9n8PMP9nfknmXCipmejw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800";
   d="scan'208";a="106746627"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Apr 2021 21:38:31 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id D35764CEA876;
	Wed,  7 Apr 2021 21:38:27 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 7 Apr 2021 21:38:27 +0800
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 7 Apr 2021 21:38:27 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 7 Apr 2021 21:38:26 +0800
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 0/3] fsdax: Factor helper functions to simplify the code
Date: Wed, 7 Apr 2021 21:38:20 +0800
Message-ID: <20210407133823.828176-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-yoursite-MailScanner-ID: D35764CEA876.A0B2C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Message-ID-Hash: YXKYC5XQFNXML5AS6JN3KRDWD5DIAX6Z
X-Message-ID-Hash: YXKYC5XQFNXML5AS6JN3KRDWD5DIAX6Z
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YXKYC5XQFNXML5AS6JN3KRDWD5DIAX6Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The page fault part of fsdax code is little complex. In order to add CoW
feature and make it easy to understand, I was suggested to factor some
helper functions to simplify the current dax code.

This is separated from the previous patchset called "V3 fsdax,xfs: Add
reflink&dedupe support for fsdax", and the previous comments are here[1].

[1]: https://patchwork.kernel.org/project/linux-nvdimm/patch/20210319015237.993880-3-ruansy.fnst@fujitsu.com/

Changes from V1:
 - fix Ritesh's email address
 - simplify return logic in  dax_fault_cow_page()

(Rebased on v5.12-rc5)
==

Shiyang Ruan (3):
  fsdax: Factor helpers to simplify dax fault code
  fsdax: Factor helper: dax_fault_actor()
  fsdax: Output address in dax_iomap_pfn() and rename it

 fs/dax.c | 439 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 232 insertions(+), 207 deletions(-)

-- 
2.31.0


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
