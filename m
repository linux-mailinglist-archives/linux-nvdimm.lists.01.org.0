Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 927ACEA55D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Oct 2019 22:28:32 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B62CD100EA554;
	Wed, 30 Oct 2019 14:29:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::742; helo=mail-qk1-x742.google.com; envelope-from=cai@lca.pw; receiver=<UNKNOWN> 
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 88A55100EA553
	for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 14:29:02 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 205so3143192qkk.1
        for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 14:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uytARhU4JI/IWniohgI1h0y5qFI/5ABlfCC5CreFQxg=;
        b=W6qOtwyIBZjyUMzGqRXB6G/6qHMzRhvEGhB7sUAOb/7Q0fbDCI2YDLOkQh1eth0aoc
         zqIciVQ+G3mGv+zctMK+TFdzw+XCwGqxXmtEkh94OX70f68eyfnbtWgJfSzHi1PcSZ3G
         CAVcLdYgMbOSQHcqkV5VQE+QYliMeOEGx1e3ND3k2EIB6yapWK8ru7QD/5ztb7f5pujO
         Pak0KSIiHl0AOG8ds3zA4UFJLxn3Jca/4N83l505TqjgpGl49Ei9pRJNsnmva3l2tOss
         yS6VPCeMMoksJcTTHiqXoVHSDlPTvqMOf0mX5pLpaldc8m3ZG6ktwT8DHh/Vcz49xOu2
         jpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uytARhU4JI/IWniohgI1h0y5qFI/5ABlfCC5CreFQxg=;
        b=bkq4yQ97ZuPGwdIWQli/CQJ4PHNB4OCbQtnrlksNSzoR6HYyo7aeGveyvedfND39XM
         aKUA7x/TtUOVUrtUONrViy2/apOMRQYEsLOpbBcHnGQaEtQeSKzhqq9nCXDr+vUCuXEL
         n3yZtJ0e0NIBKD8hxTlFLMTai4ilrcYDUQZoSVOtOZck9krnfISG9BE5V1EgbX+Y1lMJ
         5oNAnRwucqZdKpQQaoGV8Jv7b215sQeTAcDh/ouoB7jdxm4eCPnOcVtRiJzctejolJKn
         NoLyk+eJGZA3vhkYo3YRL0C17CzJINhnh22PxJAb57eSw0XBfHIxzqVWJqqChEtqBUmd
         6DnA==
X-Gm-Message-State: APjAAAWYXQM2z+qdLocXqekNPK4kaNfZ0F/2zNvsZB1yH1XW/iMBNHFN
	4PMjpdwEAb5UGEyWWn9IbUxIYQ==
X-Google-Smtp-Source: APXvYqxcwYAkthju/bxaBiwmlQyXIhoDs08LzlEAC4htL2+UH1+5Ji7t08N+xcWqICHjkBR79GnO+g==
X-Received: by 2002:a37:8a05:: with SMTP id m5mr1950049qkd.181.1572470907914;
        Wed, 30 Oct 2019 14:28:27 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 15sm670984qke.120.2019.10.30.14.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 14:28:27 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: dan.j.williams@intel.com
Subject: [PATCH v2] nvdimm/btt: fix variable 'rc' set but not used
Date: Wed, 30 Oct 2019 17:28:09 -0400
Message-Id: <1572470889-28754-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Message-ID-Hash: SROF6Q7ITPAUGAXCOLWP4Z7GEHEW5OQG
X-Message-ID-Hash: SROF6Q7ITPAUGAXCOLWP4Z7GEHEW5OQG
X-MailFrom: cai@lca.pw
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SROF6Q7ITPAUGAXCOLWP4Z7GEHEW5OQG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

drivers/nvdimm/btt.c: In function 'btt_read_pg':
drivers/nvdimm/btt.c:1264:8: warning: variable 'rc' set but not used
[-Wunused-but-set-variable]
    int rc;
        ^~

Add a ratelimited message in case a storm of errors is encountered.

Fixes: d9b83c756953 ("libnvdimm, btt: rework error clearing")
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: include the block address that is returning an error per Dan.

 drivers/nvdimm/btt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 3e9f45aec8d1..10313be78221 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1266,6 +1266,12 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 			/* Media error - set the e_flag */
 			rc = btt_map_write(arena, premap, postmap, 0, 1,
 				NVDIMM_IO_ATOMIC);
+
+			if (rc)
+				dev_warn_ratelimited(to_dev(arena),
+					"Error persistently tracking bad blocks at %#x\n",
+					premap);
+
 			goto out_rtt;
 		}
 
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
