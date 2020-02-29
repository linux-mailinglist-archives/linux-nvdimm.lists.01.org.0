Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA1317495D
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:39:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BB81010FC3769;
	Sat, 29 Feb 2020 12:40:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 906BF10FC36EA
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:40:07 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:39:15 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="318461859"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:39:15 -0800
Subject: [ndctl PATCH 35/36] ndctl/lib/namespace: Fix resource retrieval
 after size change
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:23:10 -0800
Message-ID: <158300779047.2141307.11160238427930235188.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: VABRSIF4G6HSZX7ABOOPIYYF5I3G3E5B
X-Message-ID-Hash: VABRSIF4G6HSZX7ABOOPIYYF5I3G3E5B
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VABRSIF4G6HSZX7ABOOPIYYF5I3G3E5B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The namespaceX.Y/resource attribute returns -1 while the namespace does
not have capacity allocated. While it is valid after setting the size
the library has already cached the error value. Teach
ndctl_namespace_set_size() to refresh ->resource.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/lib/libndctl.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index a996bff66fb2..ee737cbbfe3e 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -4484,6 +4484,24 @@ static int namespace_set_size(struct ndctl_namespace *ndns,
 		return rc;
 
 	ndns->size = size;
+
+	/*
+	 * A size change event invalidates / establishes 'resource', try
+	 * to refresh it.
+	 */
+	if (snprintf(path, len, "%s/resource", ndns->ndns_path) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				ndctl_namespace_get_devname(ndns));
+		ndns->resource = ULLONG_MAX;
+		return 0;
+	}
+
+	if (sysfs_read_attr(ctx, path, buf) < 0) {
+		ndns->resource = ULLONG_MAX;
+		return 0;
+	}
+
+	ndns->resource = strtoull(buf, NULL, 0);
 	return 0;
 }
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
