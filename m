Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8029009D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Aug 2019 13:18:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1EB19202E2D4A;
	Fri, 16 Aug 2019 04:20:47 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=justin.he@arm.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by ml01.01.org (Postfix) with ESMTP id 64DBD202E292C
 for <linux-nvdimm@lists.01.org>; Fri, 16 Aug 2019 04:20:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A59EB28;
 Fri, 16 Aug 2019 04:18:54 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.169.40.54])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D86093F706;
 Fri, 16 Aug 2019 04:18:52 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/2] Fix and support dax kmem on arm64
Date: Fri, 16 Aug 2019 19:18:42 +0800
Message-Id: <20190816111844.87442-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Jia He <justin.he@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvdimm@lists.01.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

This patch set is to fix some dax kmem driver issues and then it can 
support to use pmem as normal RAM in arm64 qemu guest.

Jia He (2):
  drivers/dax/kmem: use default numa_mem_id if target_node is invalid
  drivers/dax/kmem: give a warning if CONFIG_DEV_DAX_PMEM_COMPAT is
    enabled

 drivers/dax/kmem.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.17.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
