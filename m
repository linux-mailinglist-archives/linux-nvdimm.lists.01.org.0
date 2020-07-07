Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F234B216433
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:56:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B3FE61108DEAC;
	Mon,  6 Jul 2020 19:56:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8473C1108DEAE
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:56:50 -0700 (PDT)
IronPort-SDR: dbNmq159XI8u6lfOuLe/qVC+19g8waVQVbvzX1vgEXEkcfG839HEzyQupXi0MqQ8gX2rh0GPZR
 iv2cGTMTNUGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="209052887"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="209052887"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:56:50 -0700
IronPort-SDR: az7jamnTlkjYXZImD8mtBvdauugNvygRqZ+cbSwWmBsrcHKB2CwRTyNIZi5+uLqIvUqoI56l8O
 laqk5hkfO4CA==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="323399435"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:56:49 -0700
Subject: [ndctl PATCH 03/16] ndctl/list: Indicate firmware update capability
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Mon, 06 Jul 2020 19:40:34 -0700
Message-ID: <159408963461.2386154.18353152465451652005.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: T3MXX3TVO6DRYQR2EK7AALVMJEJPJS7G
X-Message-ID-Hash: T3MXX3TVO6DRYQR2EK7AALVMJEJPJS7G
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T3MXX3TVO6DRYQR2EK7AALVMJEJPJS7G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Given all the components that need to be lined up to support firmware
update, add a "can_update" flag to indicate that all the proper plumbing is
in place.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/ndctl-update-firmware.txt |   21 ++++++++++++++++++---
 ndctl/util/json-firmware.c                    |    5 +++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/ndctl/ndctl-update-firmware.txt b/Documentation/ndctl/ndctl-update-firmware.txt
index 1aa7fee502ca..f93da6bf15e7 100644
--- a/Documentation/ndctl/ndctl-update-firmware.txt
+++ b/Documentation/ndctl/ndctl-update-firmware.txt
@@ -5,7 +5,7 @@ ndctl-update-firmware(1)
 
 NAME
 ----
-ndctl-update-firmware - provides for updating the firmware on an NVDIMM
+ndctl-update-firmware - update the firmware the given device
 
 SYNOPSIS
 --------
@@ -15,9 +15,24 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Provide a generic interface for updating NVDIMM firmware. The use of this
-depends on support from the underlying libndctl, kernel, as well as the
-platform itself.
+depends on support for the NVDIMM "family" in libndctl, the kernel needs
+to enable that command set, and the device itself needs to implement the
+command. Use "ndctl list -DF" to interrogate if firmware
+update is enabled. For example:
 
+[verse]
+ndctl list -DFu -d nmem1
+{
+  "dev":"nmem1",
+  "id":"cdab-0a-07e0-ffffffff",
+  "handle":"0",
+  "phys_id":"0",
+  "security":"disabled",
+  "firmware":{
+    "current_version":"0",
+    "can_update":true
+  }
+}
 
 OPTIONS
 -------
diff --git a/ndctl/util/json-firmware.c b/ndctl/util/json-firmware.c
index f7150d82d174..9a9db064d851 100644
--- a/ndctl/util/json-firmware.c
+++ b/ndctl/util/json-firmware.c
@@ -46,6 +46,11 @@ struct json_object *util_dimm_firmware_to_json(struct ndctl_dimm *dimm,
 	if (jobj)
 		json_object_object_add(jfirmware, "current_version", jobj);
 
+	rc = ndctl_dimm_fw_update_supported(dimm);
+	jobj = json_object_new_boolean(rc == 0);
+	if (jobj)
+		json_object_object_add(jfirmware, "can_update", jobj);
+
 	next = ndctl_cmd_fw_info_get_updated_version(cmd);
 	if (next == ULLONG_MAX) {
 		jobj = util_json_object_hex(-1, flags);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
