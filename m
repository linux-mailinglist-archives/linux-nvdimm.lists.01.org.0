Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB17245BDF
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Aug 2020 07:22:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 73938133D9480;
	Sun, 16 Aug 2020 22:22:44 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D4E19132AAB55
	for <linux-nvdimm@lists.01.org>; Sun, 16 Aug 2020 22:22:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r4so6935514pls.2
        for <linux-nvdimm@lists.01.org>; Sun, 16 Aug 2020 22:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQ1Zpg49+9AEa7gh2FbaHLnEAEU3G56cL4NjHPBajgY=;
        b=z7A2Lnt+KNPZDYQzJHr74WfuUnei/Plq9xNSmmZcpwvKokAlcgKigHr0DUf/4gK4Zs
         D/NMmvbaOTb8scTytO6zOXy5P8sa3zyINrx3ZIRcrpbHhBm17KnOi5FTchy6tyOQACAe
         FIl46nOHfEiqJiDvoo5Huxl3j2894o9CiIFMJP2zr7M+OP96YMegnLM1HFCuImpzU8t/
         PsHLRAjtn3BfqWrmPEGr5iHv0GdjJowVC6b+Qm8T6gcMpTFNgLkr5dgPRAEcOKdg1BHB
         3sITmh/yXg4pZT0E39yQ/XuZxfxdev45wWDqVV4XjKPRzZRf799YSevTEchhBHuZ2EQJ
         guyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQ1Zpg49+9AEa7gh2FbaHLnEAEU3G56cL4NjHPBajgY=;
        b=K2in0A2Gx9qiX+UKTJmV7uHKuIgWW8cTyOxcq5IeDy+H3B+TWGT475QBtgpDjK5hbp
         4GgSXGqJ+ii9l1I4uUICdmnP44ifAs1XsOUg7Qe1YAjDrDORH0o1TwqSolAHTyM2glQX
         gz6UbTyZdI5XndyYL/LN6s02QDYemaTXg1f7rEhvUGdBdon3l3wFYPQ7Sxp/Mdl5pRnH
         AdDYwTd2jtaylLiEtt4pMdodqyH5vkNtrrLjekM3BzlDzKBehuCQMPEYaTDVc/pN81Wg
         jGs9M006+OKgTTpLNZZ3uK1Cn3UkgWsrMGuo097rTTII93mzaazZy6gikg2Gft4BQIER
         BcTA==
X-Gm-Message-State: AOAM5329bkYsGWdwQQqZ1hgxzU9U2pmW1/wnxoOjBLIF9P3nlCNAhwbU
	TsuxgQvLOoUyJSUrWJxKPpRTi7279i6rCg==
X-Google-Smtp-Source: ABdhPJw19coO5U7nGt69KuQbQOUkpKggpH6s6Qhm9qhld98jvFycZaONMpKq+Lm2XIoOl1zv+XctkQ==
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr10119543plt.307.1597641761575;
        Sun, 16 Aug 2020 22:22:41 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([2401:4900:16ef:a7f1:9aa9:b61c:f8c8:81b2])
        by smtp.gmail.com with ESMTPSA id go12sm15404105pjb.2.2020.08.16.22.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 22:22:40 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>
Subject: [PATCH] error-inject: Remove redundant has_nfit check
Date: Mon, 17 Aug 2020 10:52:13 +0530
Message-Id: <20200817052213.914076-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: ERDQMLVZTVC3KIG57EH7P7K46JBT6PJK
X-Message-ID-Hash: ERDQMLVZTVC3KIG57EH7P7K46JBT6PJK
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ERDQMLVZTVC3KIG57EH7P7K46JBT6PJK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

ndctl_bus_has_error_injection already has the ndctl_bus_has_nfit
check. Remove the redundant checks.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/lib/inject.c | 73 +++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 40 deletions(-)

diff --git a/ndctl/lib/inject.c b/ndctl/lib/inject.c
index ab0bee5..509ba27 100644
--- a/ndctl/lib/inject.c
+++ b/ndctl/lib/inject.c
@@ -190,8 +190,6 @@ NDCTL_EXPORT int ndctl_namespace_inject_error2(struct ndctl_namespace *ndns,
 
 	if (!ndctl_bus_has_error_injection(bus))
 		return -EOPNOTSUPP;
-	if (!ndctl_bus_has_nfit(bus))
-		return -EOPNOTSUPP;
 
 	for (i = 0; i < count; i++) {
 		rc = ndctl_namespace_inject_one_error(ndns, block + i, flags);
@@ -268,8 +266,6 @@ NDCTL_EXPORT int ndctl_namespace_uninject_error2(struct ndctl_namespace *ndns,
 
 	if (!ndctl_bus_has_error_injection(bus))
 		return -EOPNOTSUPP;
-	if (!ndctl_bus_has_nfit(bus))
-		return -EOPNOTSUPP;
 
 	for (i = 0; i < count; i++) {
 		rc = ndctl_namespace_uninject_one_error(ndns, block + i,
@@ -450,46 +446,43 @@ NDCTL_EXPORT int ndctl_namespace_injection_status(struct ndctl_namespace *ndns)
 	if (!ndctl_bus_has_error_injection(bus))
 		return -EOPNOTSUPP;
 
-	if (ndctl_bus_has_nfit(bus)) {
-		rc = ndctl_namespace_get_injection_bounds(ndns, &ns_offset,
-			&ns_size);
-		if (rc)
-			return rc;
+	rc = ndctl_namespace_get_injection_bounds(ndns, &ns_offset,
+						  &ns_size);
+	if (rc)
+		return rc;
 
-		cmd = ndctl_bus_cmd_new_ars_cap(bus, ns_offset, ns_size);
-		rc = ndctl_cmd_submit(cmd);
-		if (rc < 0) {
-			dbg(ctx, "Error submitting ars_cap: %d\n", rc);
-			goto out;
-		}
-		buf_size = ndctl_cmd_ars_cap_get_size(cmd);
-		if (buf_size == 0) {
-			dbg(ctx, "Got an invalid max_ars_out from ars_cap\n");
-			rc = -EINVAL;
-			goto out;
-		}
-		ndctl_cmd_unref(cmd);
+	cmd = ndctl_bus_cmd_new_ars_cap(bus, ns_offset, ns_size);
+	rc = ndctl_cmd_submit(cmd);
+	if (rc < 0) {
+		dbg(ctx, "Error submitting ars_cap: %d\n", rc);
+		goto out;
+	}
+	buf_size = ndctl_cmd_ars_cap_get_size(cmd);
+	if (buf_size == 0) {
+		dbg(ctx, "Got an invalid max_ars_out from ars_cap\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	ndctl_cmd_unref(cmd);
 
-		cmd = ndctl_bus_cmd_new_err_inj_stat(bus, buf_size);
-		if (!cmd)
-			return -ENOMEM;
+	cmd = ndctl_bus_cmd_new_err_inj_stat(bus, buf_size);
+	if (!cmd)
+		return -ENOMEM;
 
-		pkg = (struct nd_cmd_pkg *)&cmd->cmd_buf[0];
-		err_inj_stat =
-			(struct nd_cmd_ars_err_inj_stat *)&pkg->nd_payload[0];
+	pkg = (struct nd_cmd_pkg *)&cmd->cmd_buf[0];
+	err_inj_stat =
+		(struct nd_cmd_ars_err_inj_stat *)&pkg->nd_payload[0];
 
-		rc = ndctl_cmd_submit(cmd);
-		if (rc < 0) {
-			dbg(ctx, "Error submitting command: %d\n", rc);
-			goto out;
-		}
-		rc = injection_status_to_bb(ndns, err_inj_stat,
-			ns_offset, ns_size);
-		if (rc) {
-			dbg(ctx, "Error converting status to badblocks: %d\n",
-				rc);
-			goto out;
-		}
+	rc = ndctl_cmd_submit(cmd);
+	if (rc < 0) {
+		dbg(ctx, "Error submitting command: %d\n", rc);
+		goto out;
+	}
+	rc = injection_status_to_bb(ndns, err_inj_stat,
+				    ns_offset, ns_size);
+	if (rc) {
+		dbg(ctx, "Error converting status to badblocks: %d\n", rc);
+		goto out;
 	}
 
  out:
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
