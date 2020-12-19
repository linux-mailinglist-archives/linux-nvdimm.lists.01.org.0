Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9EE2DEDBE
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Dec 2020 08:52:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 78835100EF25B;
	Fri, 18 Dec 2020 23:52:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4EE8B100EF257
	for <linux-nvdimm@lists.01.org>; Fri, 18 Dec 2020 23:52:23 -0800 (PST)
IronPort-SDR: q3UuoB4nzqRSDN1ohNGdr7C3bQLX8H4bV7lggqE9cUIVVPfD3KJ50I5oCL18WUUAqkIve44H2k
 XXhmpJHrfooQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="154777661"
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400";
   d="scan'208";a="154777661"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 23:52:22 -0800
IronPort-SDR: fd/X/4+4Wd6ubZa17QLMPZsDfc0mDPo9DhGWKXZ0kGXmO2nc3eyU/FOCwTSCwM24bnfAGA4hHk
 WnBqs/finmfQ==
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400";
   d="scan'208";a="389195874"
Received: from mvchisti-mobl1.amr.corp.intel.com (HELO omniknight.intel.com) ([10.251.13.237])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 23:52:21 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH] daxctl/device: fix a memory leak in create-device
Date: Sat, 19 Dec 2020 00:52:20 -0700
Message-Id: <20201219075220.4089532-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: 2ECPJ5S6IECNLUP6EFOR57LNQCQ2B3WU
X-Message-ID-Hash: 2ECPJ5S6IECNLUP6EFOR57LNQCQ2B3WU
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2ECPJ5S6IECNLUP6EFOR57LNQCQ2B3WU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Static analysis reports that we neglected to free 'maps' which is used
to hold mappings parsed out of an input file. Free this at the end of
do_xaction_region so we don't leak any memory. Additionally, using local
variables for the calloc cause a scope warning. Fix this by just
allocating into the 'maps' variable directly. Give 'len' / 'nmaps' the
same treatment.

Fixes: 5bedb2a8197a ("daxctl: allow creating devices from input json")
Cc: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/device.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/daxctl/device.c b/daxctl/device.c
index 161025e..0721a57 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -157,10 +157,9 @@ static int sort_mappings(const void *a, const void *b)
 static int parse_device_file(const char *filename)
 {
 	struct json_object *jobj, *jval = NULL, *jmappings = NULL;
-	int i, len, rc = -EINVAL, region_id, id;
+	int i, rc = -EINVAL, region_id, id;
 	const char *chardev;
 	char  *region = NULL;
-	struct mapping *m;
 
 	jobj = json_object_from_file(filename);
 	if (!jobj)
@@ -187,12 +186,12 @@ static int parse_device_file(const char *filename)
 		return rc;
 	json_object_array_sort(jmappings, sort_mappings);
 
-	len = json_object_array_length(jmappings);
-	m = calloc(len, sizeof(*m));
-	if (!m)
+	nmaps = json_object_array_length(jmappings);
+	maps = calloc(nmaps, sizeof(*maps));
+	if (!maps)
 		return -ENOMEM;
 
-	for (i = 0; i < len; i++) {
+	for (i = 0; i < nmaps; i++) {
 		struct json_object *j, *val;
 
 		j = json_object_array_get_idx(jmappings, i);
@@ -201,23 +200,21 @@ static int parse_device_file(const char *filename)
 
 		if (!json_object_object_get_ex(j, "start", &val))
 			goto err;
-		m[i].start = json_object_get_int64(val);
+		maps[i].start = json_object_get_int64(val);
 
 		if (!json_object_object_get_ex(j, "end", &val))
 			goto err;
-		m[i].end = json_object_get_int64(val);
+		maps[i].end = json_object_get_int64(val);
 
 		if (!json_object_object_get_ex(j, "page_offset", &val))
 			goto err;
-		m[i].pgoff = json_object_get_int64(val);
+		maps[i].pgoff = json_object_get_int64(val);
 	}
-	maps = m;
-	nmaps = len;
-	rc = 0;
+
+	return 0;
 
 err:
-	if (!maps)
-		free(m);
+	free(maps);
 	return rc;
 }
 
@@ -817,6 +814,7 @@ static int do_xaction_region(enum device_action action,
 			break;
 		}
 	}
+	free(maps);
 
 	/*
 	 * jdevs is the containing json array for all devices we are reporting
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
