Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8D72109D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 00:41:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B16902125ADC4;
	Thu, 16 May 2019 15:41:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F218421255850
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 15:41:01 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 May 2019 15:41:01 -0700
X-ExtLoop1: 1
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by FMSMGA003.fm.intel.com with ESMTP; 16 May 2019 15:41:01 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v3 05/10] daxctl/list: add numa_node for device listings
Date: Thu, 16 May 2019 16:40:48 -0600
Message-Id: <20190516224053.3655-6-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516224053.3655-1-vishal.l.verma@intel.com>
References: <20190516224053.3655-1-vishal.l.verma@intel.com>
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
listings so that it is easy for applications to detect the numa node to
which the new memory belongs.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 util/json.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/util/json.c b/util/json.c
index babdc8c..b7ce719 100644
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
+			json_object_object_add(jdev, "numa_node", jobj);
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
