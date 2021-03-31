Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E7C3507AC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Mar 2021 21:56:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A74B2100EB358;
	Wed, 31 Mar 2021 12:56:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 22391100EB355
	for <linux-nvdimm@lists.01.org>; Wed, 31 Mar 2021 12:56:31 -0700 (PDT)
IronPort-SDR: t3HuOy9dOf/yBOHMQMkoAKn5M60nB1X+uTdnMLfeSc8juX5cHKYo2yB66vlyvFE1kQAgQMx8GA
 TlcRSJtlMGdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="189849271"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400";
   d="scan'208";a="189849271"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 12:56:24 -0700
IronPort-SDR: St2xoNNGmSJrfuAAaRk5IEbVveJLLIAH48/X+ybA+cHrrOaoo9pwcuFjHPjjd8KTte9sQCozGH
 C5KGNnYcm/nA==
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400";
   d="scan'208";a="455655746"
Received: from ateichma-mobl.amr.corp.intel.com (HELO omniknight.intel.com) ([10.212.50.195])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 12:56:24 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH] daxctl: emit counts of total and online memblocks
Date: Wed, 31 Mar 2021 13:56:19 -0600
Message-Id: <20210331195619.533491-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Message-ID-Hash: OB7YI4TXZHRSP6E6PV7AEBEJ5TLYO3QM
X-Message-ID-Hash: OB7YI4TXZHRSP6E6PV7AEBEJ5TLYO3QM
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Steve Scargall <steve.scargall@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OB7YI4TXZHRSP6E6PV7AEBEJ5TLYO3QM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fir daxctl device listings, if in 'system-ram' mode, it is useful to
know whether the memory associated with the device is online or not.
Since the memory is comprised of a number of 'memblocks', and it is
possible (albeit rare) to have a subset of them online, and the rest
offline, we can't just use a boolean online-or-offline flag for the
state.

Add a couple of counts, one for the total number of memblocks associated
with the device, and another for the ones that are online.

Link: https://github.com/pmem/ndctl/issues/139
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Steve Scargall <steve.scargall@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 util/json.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/util/json.c b/util/json.c
index ca0167b..a8d2412 100644
--- a/util/json.c
+++ b/util/json.c
@@ -482,6 +482,17 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 		json_object_object_add(jdev, "mode", jobj);
 
 	if (mem && daxctl_dev_get_resource(dev) != 0) {
+		int num_sections = daxctl_memory_num_sections(mem);
+		int num_online = daxctl_memory_is_online(mem);
+
+		jobj = json_object_new_int(num_online);
+		if (jobj)
+			json_object_object_add(jdev, "online_memblocks", jobj);
+
+		jobj = json_object_new_int(num_sections);
+		if (jobj)
+			json_object_object_add(jdev, "total_memblocks", jobj);
+
 		movable = daxctl_memory_is_movable(mem);
 		if (movable == 1)
 			jobj = json_object_new_boolean(true);
-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
