Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB74910B8B4
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 Nov 2019 21:47:25 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7743B101134E0;
	Wed, 27 Nov 2019 12:50:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 513A81011333F
	for <linux-nvdimm@lists.01.org>; Wed, 27 Nov 2019 12:50:44 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 12:47:21 -0800
X-IronPort-AV: E=Sophos;i="5.69,250,1571727600";
   d="scan'208";a="203199416"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 12:47:20 -0800
Subject: [daxctl PATCH] daxctl/list: Avoid memory operations without
 resource data
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 27 Nov 2019 12:33:05 -0800
Message-ID: <157488678518.2821503.2969182209770415299.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: ZVLJMDZ7YTGWE4WEI2KA3PBT3QT2HFUO
X-Message-ID-Hash: ZVLJMDZ7YTGWE4WEI2KA3PBT3QT2HFUO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michal Biesek <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZVLJMDZ7YTGWE4WEI2KA3PBT3QT2HFUO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Resource data is restricted to root-only, and "daxctl list" is likely to
be run by non-root. Skip listing memory-object details when the resource
is not available.

Otherwise, "daxctl list" from non-root emits:

   libdaxctl: memblock_in_dev: dax1.0: Unable to determine resource

Reported-by: Michal Biesek <michal.biesek@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 util/json.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/json.c b/util/json.c
index 0abaf3a5b9c2..6745bcc19058 100644
--- a/util/json.c
+++ b/util/json.c
@@ -306,7 +306,7 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 	if (jobj)
 		json_object_object_add(jdev, "mode", jobj);
 
-	if (mem) {
+	if (mem && daxctl_dev_get_resource(dev) != 0) {
 		movable = daxctl_memory_is_movable(mem);
 		if (movable == 1)
 			jobj = json_object_new_boolean(true);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
