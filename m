Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AECBEB214
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 15:05:43 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0E5CD100DC401;
	Thu, 31 Oct 2019 07:06:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com; envelope-from=cai@lca.pw; receiver=<UNKNOWN> 
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8B82C100EA60B
	for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 07:06:05 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m16so6744859qki.11
        for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8g/fCqmTpfKLTY3+g19TSl1xtmw42oOlQtbZEptQxXY=;
        b=Ojd9BDEap9xE3g4HQnpHAdCyMWxWnAfFSiVEhn/xryjjQTXRroD9B72k6zI6oz35XG
         nvS5bWyOWkEYu07cHE+RaZOHJVd4szHa1v/b6LaXkmuY/8NsKYXaw1kEXNFKj1nhtLvQ
         8L7v8iwSmFNlH6DHcWDuDDOC9SF90c1r3IkwhiIf6FJKmmACUcBhikG68rM6l7xNAbcO
         fSoDlE1vBp64Dp9vcPD6egrrMQYRWKXEenVF6lR4v8/3if8Vjkqj87Q4AqQ8tAD4CcRH
         YnnJnZjMShZjIldORX3KpAvCbb4QetumevJo4jxpSt4cFDxybJBcaQNoVvhRRkyPizDt
         r3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8g/fCqmTpfKLTY3+g19TSl1xtmw42oOlQtbZEptQxXY=;
        b=dTPUzSWca93mjmnj4zTFEgb3XG8qU7/2qH6fFnYXkES7RU3FKjmNCmGWL3zFoAOqQi
         KZh8D0tRdVvKaToiiPeY/RWXymKuLzjSD0S2cV6GNMf5olzXQqhqdcT1Zr4WuaMc1Fml
         O0DmDcQuLOPHmrLEOMLHuYoTtqrJzcW/d5jQSnUoNiIc0R7kC/TQWqPEhiah8hQan/dy
         HyrQ4IVe/OP8dbXCMZN6MXXyofgo9R63I/5HuFZF6pTyf35u752sAthFkM/UZENhbB0g
         Hie2mQ+GxcE89rjcnzNorCrNRyNFIs/byNppDjH1OCCQ6kXoExKKTAnf05qp388vy25v
         ihUg==
X-Gm-Message-State: APjAAAV0XkYEjeuIENTW60RhTCcfvPjY26irQkskuX1OOIqYOnaxM2H1
	uOcOmk9AV1XrE66RPXL2nQxkiQ==
X-Google-Smtp-Source: APXvYqyG/hUnDLvbvo52/8FbBpz3n8E2t1ayAlf4yaDYMPmL9atb/FR4GhdAJID08GoPMr6e2rjD1w==
X-Received: by 2002:ae9:e714:: with SMTP id m20mr5276736qka.280.1572530736235;
        Thu, 31 Oct 2019 07:05:36 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y33sm3167025qta.18.2019.10.31.07.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 07:05:35 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: dan.j.williams@intel.com
Subject: [PATCH v3] nvdimm/btt: fix variable 'rc' set but not used
Date: Thu, 31 Oct 2019 10:05:19 -0400
Message-Id: <1572530719-32161-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Message-ID-Hash: R7G67RZ5LIKNYTRI7A52H7UM24PXEDQS
X-Message-ID-Hash: R7G67RZ5LIKNYTRI7A52H7UM24PXEDQS
X-MailFrom: cai@lca.pw
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R7G67RZ5LIKNYTRI7A52H7UM24PXEDQS/>
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
v3: remove the unused "rc" per Vishal.
v2: include the block address that is returning an error per Dan.

 drivers/nvdimm/btt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 3e9f45aec8d1..5129543a0473 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1261,11 +1261,11 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 
 		ret = btt_data_read(arena, page, off, postmap, cur_len);
 		if (ret) {
-			int rc;
-
 			/* Media error - set the e_flag */
-			rc = btt_map_write(arena, premap, postmap, 0, 1,
-				NVDIMM_IO_ATOMIC);
+			if (btt_map_write(arena, premap, postmap, 0, 1, NVDIMM_IO_ATOMIC))
+				dev_warn_ratelimited(to_dev(arena),
+					"Error persistently tracking bad blocks at %#x\n",
+					premap);
 			goto out_rtt;
 		}
 
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
