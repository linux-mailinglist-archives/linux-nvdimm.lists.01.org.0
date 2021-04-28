Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A57136D4BD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Apr 2021 11:26:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4654C100EB82F;
	Wed, 28 Apr 2021 02:26:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=sanjanasrinidhi1810@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 26EAB100EB82C
	for <linux-nvdimm@lists.01.org>; Wed, 28 Apr 2021 02:26:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y62so10698879pfg.4
        for <linux-nvdimm@lists.01.org>; Wed, 28 Apr 2021 02:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HdBXAeW9ho79sbyDSekS4yet6htvB8OKbQECD3STw9g=;
        b=jkVromoQu4MIvHxNxzjt6BTZYcg0ej3QJP/jMLiFq/+9P/og+Sn79uD7ulFAtyomLD
         w3z7Q1HFewI7wwA5EfDyFfwimsz3zYurtxJnPh8DKTIsFSiDVcJFvvFzTCyoi/FH5eVN
         oqwTTOsyTFT4aW8h/IC55BnG9baY2wkJEeqba78+DIJNuqnUssSESVMsCsfs6HEOXBYS
         DRa+labNc5d194sLzRhzpY5+CA4OxHomBRunlNv/jiETZNyNvHrJIvF9J4d/upFNZ6nN
         dOfie9wM3aY2QYMj23dhe4vHVI372C3k2+rqGIioQilSiHeyUfoqKFYQQAS2x+YvK2+7
         J2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HdBXAeW9ho79sbyDSekS4yet6htvB8OKbQECD3STw9g=;
        b=IberjWK22Ch3XxPTgQICAo2BX8cgc0ngrMPCtG3FxuIgqCh9jrYR/BFZi8RbAUKWag
         bVVyPxDg+BgBuVFTBCdx8HV5Fg0evprGUKR/RqwXWJA+6N8DKRRWguC+X5V73rOsNmUs
         ulS45Bc0WvnApkJlxwdCekblAcFX4jbY5Xgb4KgIFS6mdjJDzwcQUCQ8pP2VMw82t2vF
         ZGxcv7F550HiIVqAqJl6rEBawPGd/eWdUsRxci2OtZP7YecJEKljmbaQqPaGXcGwyv64
         63fXDxaJAPFtOy4Ng6KPGbYv/k3Siag+9Uz56LDv5UIoHxC4JRl8IEWkak5r6jPqi9tL
         QUZQ==
X-Gm-Message-State: AOAM532M32UOGfKeM+HebqnyPEMw+g3eziF/XIJRwnfMhhLCaNBvKVc+
	GQuTDFmcx3LoQU0KmBUBGT0=
X-Google-Smtp-Source: ABdhPJw7I0R9nrycMGShtYmIay08lbgPBXI0Aahfaxd0Pcm0k6t0qup20D1I2bQR2lT7PjLsEH1RGw==
X-Received: by 2002:a65:48c5:: with SMTP id o5mr25873562pgs.101.1619602008433;
        Wed, 28 Apr 2021 02:26:48 -0700 (PDT)
Received: from localhost ([115.99.221.24])
        by smtp.gmail.com with ESMTPSA id c26sm4686373pfo.67.2021.04.28.02.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 02:26:48 -0700 (PDT)
Date: Wed, 28 Apr 2021 14:56:43 +0530
From: Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
To: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com
Subject: [PATCH] Add blank line after declarations
Message-ID: <20210428092643.y2z2bezd2evu5kak@sanjana-VirtualBox>
MIME-Version: 1.0
Content-Disposition: inline
Message-ID-Hash: LGXVJLS7JQBWZIX6LXNGWMMIKRFJKBQN
X-Message-ID-Hash: LGXVJLS7JQBWZIX6LXNGWMMIKRFJKBQN
X-MailFrom: sanjanasrinidhi1810@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LGXVJLS7JQBWZIX6LXNGWMMIKRFJKBQN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Blank line is added after declarations to maintain code uniformity.

Signed-off-by: Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
---
 drivers/dax/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 5fa6ae9dbc8b..1f7cd75e379f 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -477,6 +477,7 @@ static struct dax_device *to_dax_dev(struct inode *inode)
 static void dax_free_inode(struct inode *inode)
 {
 	struct dax_device *dax_dev = to_dax_dev(inode);
+
 	kfree(dax_dev->host);
 	dax_dev->host = NULL;
 	if (inode->i_rdev)
@@ -487,6 +488,7 @@ static void dax_free_inode(struct inode *inode)
 static void dax_destroy_inode(struct inode *inode)
 {
 	struct dax_device *dax_dev = to_dax_dev(inode);
+
 	WARN_ONCE(test_bit(DAXDEV_ALIVE, &dax_dev->flags),
 			"kill_dax() must be called before final iput()\n");
 }
@@ -502,6 +504,7 @@ static const struct super_operations dax_sops = {
 static int dax_init_fs_context(struct fs_context *fc)
 {
 	struct pseudo_fs_context *ctx = init_pseudo(fc, DAXFS_MAGIC);
+
 	if (!ctx)
 		return -ENOMEM;
 	ctx->ops = &dax_sops;
-- 
2.25.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
