Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32292A9280
	for <lists+linux-nvdimm@lfdr.de>; Fri,  6 Nov 2020 10:26:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7FDEF1674C0ED;
	Fri,  6 Nov 2020 01:26:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.32; helo=szxga06-in.huawei.com; envelope-from=liuzhiqiang26@huawei.com; receiver=<UNKNOWN> 
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 660B31673C07E
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 01:26:32 -0800 (PST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CSFPm54vvzhgxr
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 17:26:20 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 17:26:13 +0800
Subject: [ndctl PATCH 4/8] dimm: fix potential fd leakage in dimm_action()
To: <vishal.l.verma@intel.com>
References: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <1ca17cf4-a5fd-786d-fa50-8ed09ccd55e4@huawei.com>
Date: Fri, 6 Nov 2020 17:26:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Message-ID-Hash: K53J3EMKFP456D6ANRJ5DNDS2VZZQIV2
X-Message-ID-Hash: K53J3EMKFP456D6ANRJ5DNDS2VZZQIV2
X-MailFrom: liuzhiqiang26@huawei.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linfeilong <linfeilong@huawei.com>, liuzhiqiang26@huawei.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K53J3EMKFP456D6ANRJ5DNDS2VZZQIV2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


In dimm_action(), actx.f_out and actx.f_in may be set by calling
fopen(). If exceptions occur, we will directly goto out tag.
However, we did not close actx.f_out|actx.f_in in out tag, which
will cause fd leakage.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 ndctl/dimm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index 90eb0b8..2f52cda 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -1352,7 +1352,7 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
 			fprintf(stderr, "failed to open: %s: (%s)\n",
 					param.infile, strerror(errno));
 			rc = -errno;
-			goto out;
+			goto out_close_fout;
 		}
 	}

@@ -1371,7 +1371,7 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
 		fprintf(stderr, "'%s' is not a valid label version\n",
 				param.labelversion);
 		rc = -EINVAL;
-		goto out;
+		goto out_close_fin_fout;
 	}

 	rc = 0;
@@ -1423,12 +1423,14 @@ static int dimm_action(int argc, const char **argv, struct ndctl_ctx *ctx,
 		util_display_json_array(actx.f_out, actx.jdimms, flags);
 	}

-	if (actx.f_out != stdout)
-		fclose(actx.f_out);
-
+ out_close_fin_fout:
 	if (actx.f_in != stdin)
 		fclose(actx.f_in);

+ out_close_fout:
+	if (actx.f_out != stdout)
+		fclose(actx.f_out);
+
  out:
 	/*
 	 * count if some actions succeeded, 0 if none were attempted,
-- 
1.8.3.1


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
