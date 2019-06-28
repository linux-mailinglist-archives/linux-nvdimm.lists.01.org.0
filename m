Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031755A4E1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 21:11:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3EA7A2129EBB7;
	Fri, 28 Jun 2019 12:11:22 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2A05A212AAFE9
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 12:11:19 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Jun 2019 12:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; d="scan'208";a="173564734"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by orsmga002.jf.intel.com with ESMTP; 28 Jun 2019 12:11:18 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v5 05/13] daxctl/list: add target_node for device
 listings
Date: Fri, 28 Jun 2019 13:11:02 -0600
Message-Id: <20190628191110.21428-6-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628191110.21428-1-vishal.l.verma@intel.com>
References: <20190628191110.21428-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The kernel provides a 'target_node' attribute for dax devices. When
converting a dax device to the system-ram mode, the memory is hotplugged
into this numa node. It would be helpful to print this in device
listings so that it is easy for applications to detect the node to
which the new memory belongs.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 util/json.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/util/json.c b/util/json.c
index babdc8c..f521337 100644
--- a/util/json.c
+++ b/util/json.c
@@ -271,6 +271,7 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 {
 	const char *devname = daxctl_dev_get_devname(dev);
 	struct json_object *jdev, *jobj;
+	int node;
 
 	jdev = json_object_new_object();
 	if (!devname || !jdev)
@@ -284,6 +285,13 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 	if (jobj)
 		json_object_object_add(jdev, "size", jobj);
 
+	node = daxctl_dev_get_target_node(dev);
+	if (node >= 0) {
+		jobj = json_object_new_int(node);
+		if (jobj)
+			json_object_object_add(jdev, "target_node", jobj);
+	}
+
 	return jdev;
 }
 
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
