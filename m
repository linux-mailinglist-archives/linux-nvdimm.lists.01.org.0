Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 743D5239ED1
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 07:20:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2893212A6D4C3;
	Sun,  2 Aug 2020 22:20:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 980A312A6D4C2
	for <linux-nvdimm@lists.01.org>; Sun,  2 Aug 2020 22:19:59 -0700 (PDT)
IronPort-SDR: cqgB/ANhrrHfVCqlrw5kS+XMrLhp4FOd0rYYhtziTAd8CH5GLLJFmWqF9p5eS3hw41vFbPjrz/
 VBaawlLnyMhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="153250852"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="153250852"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:19:59 -0700
IronPort-SDR: 1P3zlw70YK4CpXzkgSelhDwpbESepA0dWywWnFc5gq0JD7383hb5d8+IfsWhWoC5qtQg2dxy/x
 IDKWeYxwiZ+w==
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800";
   d="scan'208";a="366195655"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:19:59 -0700
Subject: [PATCH v4 14/23] drivers/base: Make device_find_child_by_name()
 compatible with sysfs inputs
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Date: Sun, 02 Aug 2020 22:03:41 -0700
Message-ID: <159643102106.4062302.12229802117645312104.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: WEJK7NPJNGYKMKYY544UUA3JLADFL73V
X-Message-ID-Hash: WEJK7NPJNGYKMKYY544UUA3JLADFL73V
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, joao.m.martins@oracle.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WEJK7NPJNGYKMKYY544UUA3JLADFL73V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use sysfs_streq() in device_find_child_by_name() to allow it to use a
sysfs input string that might contain a trailing newline.

The other "device by name" interfaces,
{bus,driver,class}_find_device_by_name(), already account for sysfs
strings.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2169c5132558..231189dd6599 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3328,7 +3328,7 @@ struct device *device_find_child_by_name(struct device *parent,
 
 	klist_iter_init(&parent->p->klist_children, &i);
 	while ((child = next_device(&i)))
-		if (!strcmp(dev_name(child), name) && get_device(child))
+		if (sysfs_streq(dev_name(child), name) && get_device(child))
 			break;
 	klist_iter_exit(&i);
 	return child;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
