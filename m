Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CB124328E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Aug 2020 04:49:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 117EE12FE1626;
	Wed, 12 Aug 2020 19:49:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=59.111.176.18; helo=m17618.mail.qiye.163.com; envelope-from=wangqing@vivo.com; receiver=<UNKNOWN> 
Received: from m17618.mail.qiye.163.com (m17618.mail.qiye.163.com [59.111.176.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2226812FDF5DE
	for <linux-nvdimm@lists.01.org>; Wed, 12 Aug 2020 19:49:29 -0700 (PDT)
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
	by m17618.mail.qiye.163.com (Hmail) with ESMTPA id B1D5E4E1586;
	Thu, 13 Aug 2020 10:49:24 +0800 (CST)
From: Wang Qing <wangqing@vivo.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	linux-nvdimm@lists.01.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] acpi/nfit: Use kobj_to_dev() instead
Date: Thu, 13 Aug 2020 10:49:10 +0800
Message-Id: <1597286952-5706-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
	oVCBIfWUFZT0xMHRoYSkkZQ01JVkpOQkxJQ01CTU5KQ0lVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
	FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NVE6GSo4ST8tH0MvTDIJPDA#
	MhcKFBZVSlVKTkJMSUNNQk1OTUhJVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
	SU5KVUxPVUlJTVlXWQgBWUFJSU9DNwY+
X-HM-Tid: 0a73e5b8df529376kuwsb1d5e4e1586
Message-ID-Hash: NQOB3YKPTMSHFGB2VDFF4OBVRDJV3YTL
X-Message-ID-Hash: NQOB3YKPTMSHFGB2VDFF4OBVRDJV3YTL
X-MailFrom: wangqing@vivo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Wang Qing <wangqing@vivo.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NQOB3YKPTMSHFGB2VDFF4OBVRDJV3YTL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use kobj_to_dev() instead of container_of()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/acpi/nfit/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index fa4500f..3bb350b
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1382,7 +1382,7 @@ static bool ars_supported(struct nvdimm_bus *nvdimm_bus)
 
 static umode_t nfit_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
 
 	if (a == &dev_attr_scrub.attr && !ars_supported(nvdimm_bus))
@@ -1667,7 +1667,7 @@ static struct attribute *acpi_nfit_dimm_attributes[] = {
 static umode_t acpi_nfit_dimm_attr_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 
-- 
2.7.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
