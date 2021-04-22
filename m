Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D67C3681AD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Apr 2021 15:45:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A95B100EAB65;
	Thu, 22 Apr 2021 06:45:14 -0700 (PDT)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id CE98C100EF27E
	for <linux-nvdimm@lists.01.org>; Thu, 22 Apr 2021 06:45:11 -0700 (PDT)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AjY/5o6GzN7Zw6DVUpLqECMeALOonbusQ8zAX?=
 =?us-ascii?q?/mp2TgFYddHdqtC2kJ0gpHvJoRsyeFVlo9CPP6GcXWjRnKQZ3aA9NaqvNTOJhE?=
 =?us-ascii?q?KGII1u5oPpwXnBNkTFnNJ1+rxnd8FFaeHYKXhfoYLE7BKjE9AmqeP3lZyAoevF?=
 =?us-ascii?q?1X9iQUVLRshbnmREIz2WGEF3WwVKbKBRfPWhz/BarDmtc2l/VLXYOlA5WYH4x+?=
 =?us-ascii?q?HjpdbPZB4qI1od4hCSsDXA0tXHOind8hAAcz4n+9sfzVQ=3D?=
X-IronPort-AV: E=Sophos;i="5.82,242,1613404800";
   d="scan'208";a="107477137"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Apr 2021 21:45:06 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
	by cn.fujitsu.com (Postfix) with ESMTP id A8D934D0B8BB;
	Thu, 22 Apr 2021 21:45:06 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 22 Apr 2021 21:45:07 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 22 Apr 2021 21:45:06 +0800
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 0/3] fsdax: Factor helper functions to simplify the code
Date: Thu, 22 Apr 2021 21:44:58 +0800
Message-ID: <20210422134501.1596266-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-yoursite-MailScanner-ID: A8D934D0B8BB.A36A0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Message-ID-Hash: 52ZNVT5FD77FNUV4GQW57CRRKYWA6GAA
X-Message-ID-Hash: 52ZNVT5FD77FNUV4GQW57CRRKYWA6GAA
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/52ZNVT5FD77FNUV4GQW57CRRKYWA6GAA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>

The page fault part of fsdax code is little complex. In order to add CoW
feature and make it easy to understand, I was suggested to factor some
helper functions to simplify the current dax code.

This is separated from the previous patchset called "V3 fsdax,xfs: Add
reflink&dedupe support for fsdax", and the previous comments are here[1].

[1]: https://patchwork.kernel.org/project/linux-nvdimm/patch/20210319015237.993880-3-ruansy.fnst@fujitsu.com/

Changes from V2:
 - fix the type of 'major' in patch 2
 - Rebased on v5.12-rc8

Changes from V1:
 - fix Ritesh's email address
 - simplify return logic in dax_fault_cow_page()

(Rebased on v5.12-rc8)
==

Shiyang Ruan (3):
  fsdax: Factor helpers to simplify dax fault code
  fsdax: Factor helper: dax_fault_actor()
  fsdax: Output address in dax_iomap_pfn() and rename it

 fs/dax.c | 443 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 234 insertions(+), 209 deletions(-)

--
2.31.1


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
