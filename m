Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CC611B126
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Dec 2019 16:29:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B4CB31011350C;
	Wed, 11 Dec 2019 07:32:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7F27E1011350B
	for <linux-nvdimm@lists.01.org>; Wed, 11 Dec 2019 07:32:31 -0800 (PST)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 610E82467F;
	Wed, 11 Dec 2019 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078149;
	bh=8um5EV3hcfb7Fzh9/6MZe6go/D4mpY0bz8x4S4AOiwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XwPQAiETPH3diLv/iZmyAwd6flLO1j6CbCeuBwSv/sfkq9kpBQW8cMoSuqp3dFUn3
	 WgOUUiGQNVGrf8D7ZalwBEHcaxwIIPLhx7Q47LtQ7oTQ0DYeW6jpOcy5IMLwQljVKE
	 ZH4hdhi0SLLXliBGANgzDo5h0mF1dLVGWfIPBDMo=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 35/58] libnvdimm/btt: fix variable 'rc' set but not used
Date: Wed, 11 Dec 2019 10:28:08 -0500
Message-Id: <20191211152831.23507-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152831.23507-1-sashal@kernel.org>
References: <20191211152831.23507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Message-ID-Hash: X63VWGXJ2P7H7QPK6PFQKJ3HQD7QICOU
X-Message-ID-Hash: X63VWGXJ2P7H7QPK6PFQKJ3HQD7QICOU
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Qian Cai <cai@lca.pw>, Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X63VWGXJ2P7H7QPK6PFQKJ3HQD7QICOU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Qian Cai <cai@lca.pw>

[ Upstream commit 4e24e37d5313edca8b4ab86f240c046c731e28d6 ]

drivers/nvdimm/btt.c: In function 'btt_read_pg':
drivers/nvdimm/btt.c:1264:8: warning: variable 'rc' set but not used
[-Wunused-but-set-variable]
    int rc;
        ^~

Add a ratelimited message in case a storm of errors is encountered.

Fixes: d9b83c756953 ("libnvdimm, btt: rework error clearing")
Signed-off-by: Qian Cai <cai@lca.pw>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Link: https://lore.kernel.org/r/1572530719-32161-1-git-send-email-cai@lca.pw
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/btt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index b2feda35966b1..471498469d0aa 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1259,11 +1259,11 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 
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
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
