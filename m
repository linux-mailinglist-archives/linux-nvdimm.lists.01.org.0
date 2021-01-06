Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D492EBFB4
	for <lists+linux-nvdimm@lfdr.de>; Wed,  6 Jan 2021 15:43:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B3AB100EC1C8;
	Wed,  6 Jan 2021 06:43:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C41D2100ED4AF
	for <linux-nvdimm@lists.01.org>; Wed,  6 Jan 2021 06:43:53 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 40B7FAF5B;
	Wed,  6 Jan 2021 14:43:52 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
To: linux-nvdimm@lists.01.org
Subject: [PATCH ndctl] dimm: re-fix potential fd leakage in dimm_action()
Date: Wed,  6 Jan 2021 15:43:43 +0100
Message-Id: <20210106144343.22099-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: BQS24TJJE7B7HYOGVU5UWSO3FAUVC6XV
X-Message-ID-Hash: BQS24TJJE7B7HYOGVU5UWSO3FAUVC6XV
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Suchanek <msuchanek@suse.de>, Zhiqiang Liu <liuzhiqiang26@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BQS24TJJE7B7HYOGVU5UWSO3FAUVC6XV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There are cases not covered by the original fix and cases added by the
latter patch.

Also there is one case of usage added without returning from the
function.

Fixes: ff434d87ccbd ("dimm: fix potential fd leakage in dimm_action()")
Fixes: 41a7e24af5db ("ndctl/dimm: Auto-arm firmware activation")

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 ndctl/dimm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index 09ce49e1d2ca..1c177b5494ec 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -1333,12 +1333,15 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
 	if (param.arm_set && param.disarm_set) {
 		fprintf(stderr, "set either --arm, or --disarm, not both\n");
 		usage_with_options(u, options);
+		rc = -EINVAL;
+		goto out_close_fout;
 	}
 
 	if (param.disarm_set && !param.disarm) {
 		fprintf(stderr, "--no-disarm syntax not supported\n");
 		usage_with_options(u, options);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out_close_fout;
 	}
 
 	if (!param.infile) {
@@ -1351,13 +1354,15 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
 			if (!param.arm_set && !param.disarm_set) {
 				fprintf(stderr, "require --arm, or --disarm\n");
 				usage_with_options(u, options);
-				return -EINVAL;
+				rc = -EINVAL;
+				goto out_close_fout;
 			}
 
 			if (param.arm_set && !param.arm) {
 				fprintf(stderr, "--no-arm syntax not supported\n");
 				usage_with_options(u, options);
-				return -EINVAL;
+				rc = -EINVAL;
+				goto out_close_fout;
 			}
 		}
 		actx.f_in = stdin;
@@ -1425,7 +1430,8 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
 		if (count > 1) {
 			error("write-labels only supports writing a single dimm\n");
 			usage_with_options(u, options);
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out_close_fin_fout;
 		} else if (single)
 			rc = action(single, &actx);
 	}
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
