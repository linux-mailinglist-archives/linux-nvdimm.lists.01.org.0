Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E911E73C3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 May 2020 05:43:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 541B8122FA65F;
	Thu, 28 May 2020 20:38:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1041; helo=mail-pj1-x1041.google.com; envelope-from=hexiaoshuaishuai@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 05FC5122F367D
	for <linux-nvdimm@lists.01.org>; Thu, 28 May 2020 20:38:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ci23so550141pjb.5
        for <linux-nvdimm@lists.01.org>; Thu, 28 May 2020 20:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dUM0rLjJMLBDCp4mui5XTo2X4iZFVh/+VCE0yq/m+4k=;
        b=kW7UBzbmji9y/ZcbcW0RIqSC6gFMIV97+6oQsMVyXOGZq9O+aXXY9Ec+w95AJ1XRu1
         QHabUGIn7eMxVSdblwL7AG23J8unloZtv0Fo8k50DhLgkU3cj0NBYhS+cScbMWFptaNX
         W/azwMWVwyezLWrBnmz03l613FRwyesguvgZac+icd4tHXevxkihsWrD7YG9Y6gxWKMA
         XS0+0Ldv6H8x1oajnywMuGGlpxU4y3H6+PBmCTbqENQhgSuMcVkCvcrs4u3KIEFR4MeK
         ZnMPrmF+1R21T7c0NPUzps+H7H6NLsutmQPpBpqtP55wypnGsXFusO3BFxH/dW8OhjEN
         +aDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dUM0rLjJMLBDCp4mui5XTo2X4iZFVh/+VCE0yq/m+4k=;
        b=irhfmf99lVMwfKrQMLwBF2pUfls18A/dmG5OqwwcVLAnSnoD8TBKeQ/w6IMpdO+wo8
         kAc4N2ZxCK89UPkrrrwz5xqCZ6ANJ93bkhfzfzcOV4/EiLuZQuU9MUf1zrl35Fdp9L7a
         AuzDsdTOMeL0M6uVVoEqj8kCs9YaLiqYnEU/vR1tvYSwp42O44YxqrY5yC/hP+0ZJ0Wb
         jkNm2J3/P+qpPWoreJJ6H2htJmvXKWE8q3yNz6O4Thvsd+ZaTZKmH49+XovO3IWHV0yl
         YrTHu6rUcqhcd72Pazp6qMhKg34G+IETHB/jwsRwdLlcNKIB7iXSfmy0e/KtBlaM5wPz
         MkZQ==
X-Gm-Message-State: AOAM531bAQPpM3Rbm0CAAZxsk8dxIfBq9ca//MqD6bRnTRF1nhmbMt1W
	Mh6tBEDdtSCZjzTdsNq2cWk=
X-Google-Smtp-Source: ABdhPJzj6KxLAOVRnmQh4LQDtAuYiTHfTGOc9OmTbQpH0e7nl+0amngL3zCB2bfReh+xivMJpdMQZQ==
X-Received: by 2002:a17:90a:2e8a:: with SMTP id r10mr7205477pjd.33.1590723782175;
        Thu, 28 May 2020 20:43:02 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 25sm6620225pjk.50.2020.05.28.20.43.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 20:43:01 -0700 (PDT)
From: Shuai He <hexiaoshuaishuai@gmail.com>
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com
Subject: [PATCH] drivers/dax/bus: Use kobj_to_dev() API
Date: Fri, 29 May 2020 11:42:57 +0800
Message-Id: <1590723777-8718-1-git-send-email-hexiaoshuaishuai@gmail.com>
X-Mailer: git-send-email 2.7.4
Message-ID-Hash: PML2ASA3SHBCXREAZI4CPG4UXBG2ISIS
X-Message-ID-Hash: PML2ASA3SHBCXREAZI4CPG4UXBG2ISIS
X-MailFrom: hexiaoshuaishuai@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Shuai He <hexiaoshuaishuai@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PML2ASA3SHBCXREAZI4CPG4UXBG2ISIS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use kobj_to_dev() API instead of container_of().

Signed-off-by: Shuai He <hexiaoshuaishuai@gmail.com>
---
 drivers/dax/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index df238c8..24625d2 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -331,7 +331,7 @@ static DEVICE_ATTR_RO(numa_node);
 
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 
 	if (a == &dev_attr_target_node.attr && dev_dax_target_node(dev_dax) < 0)
-- 
2.7.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
