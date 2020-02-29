Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F5D174939
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:36:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6BC7010FC3405;
	Sat, 29 Feb 2020 12:37:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 40B9010FC33F3
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:37:22 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:30 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="385829438"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:30 -0800
Subject: [ndctl PATCH 04/36] daxctl/list: Avoid memory operations without
 resource data
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 29 Feb 2020 12:20:25 -0800
Message-ID: <158300762526.2141307.10889440591212566194.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: RDRYOXN7LVOR7PIMX46U3KNI3QH6NW7Q
X-Message-ID-Hash: RDRYOXN7LVOR7PIMX46U3KNI3QH6NW7Q
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michal Biesek <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RDRYOXN7LVOR7PIMX46U3KNI3QH6NW7Q/>
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
