Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F56DDDC26
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Oct 2019 05:23:54 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 778631007B5D7;
	Sat, 19 Oct 2019 20:25:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CAE401007B5C1
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 20:25:38 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 20:23:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,318,1566889200";
   d="scan'208";a="187207960"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.164])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2019 20:23:42 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 06/10] daxctl: show a 'movable' attribute in device listings
Date: Sat, 19 Oct 2019 21:23:28 -0600
Message-Id: <20191020032332.16776-7-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191020032332.16776-1-vishal.l.verma@intel.com>
References: <20191020032332.16776-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: EX5Z6NBATPUP2SRJ24UDI3DNQPC4OR3M
X-Message-ID-Hash: EX5Z6NBATPUP2SRJ24UDI3DNQPC4OR3M
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Olson <ben.olson@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EX5Z6NBATPUP2SRJ24UDI3DNQPC4OR3M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For dax devices in 'system-ram' mode, display a 'movable' attribute in
device listings. This helps a user easily determine if memory was not
onlined in the expected way for any reason.

Link: https://github.com/pmem/ndctl/issues/110
Reported-by: Ben Olson <ben.olson@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 util/json.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/util/json.c b/util/json.c
index 5e6a32a..497c52b 100644
--- a/util/json.c
+++ b/util/json.c
@@ -278,7 +278,7 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct json_object *jdev, *jobj;
-	int node;
+	int node, movable;
 
 	jdev = json_object_new_object();
 	if (!devname || !jdev)
@@ -306,6 +306,18 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 	if (jobj)
 		json_object_object_add(jdev, "mode", jobj);
 
+	if (mem) {
+		movable = daxctl_memory_is_movable(mem);
+		if (movable == 1)
+			jobj = json_object_new_boolean(true);
+		else if (movable == 0)
+			jobj = json_object_new_boolean(false);
+		else
+			jobj = NULL;
+		if (jobj)
+			json_object_object_add(jdev, "movable", jobj);
+	}
+
 	if (!daxctl_dev_is_enabled(dev)) {
 		jobj = json_object_new_string("disabled");
 		if (jobj)
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
