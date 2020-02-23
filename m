Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E40A169AAB
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 00:18:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4407F1007B1F6;
	Sun, 23 Feb 2020 15:18:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com; envelope-from=jbi.octave@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 141721007B1F1
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 15:18:50 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id t23so7197370wmi.1
        for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 15:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+LokEgk1OhCrIxCmqaU1nM/hbi0PMRKHeGZ/+qQiZ0=;
        b=WxJxvW7S7Tz2b6SBXdAVYnjRHLSfa7FbKJLMOZlTGVrI2g01Fgn1qfwPi31Tpvxz/F
         mtoIEApfsV+vV4P6AYC2imNjwiPxX6kR/eq+B/kav2hBTYR5oSKABqpmoyQ+lVmrSH4H
         gmIEShzOYsMb7vB12RlsHijOgSMF9BXmKF2kmVPa/BylY5BEhJSGihsBdZb64/TwOS4/
         zVcjeV9iHUfXWXFNF8JA7Ro20aRnz+nGYgEb7QNHoVj6FzDIfsWiJWTRsueCexqOUt4V
         lV4MeE9HuAoLj9oAbCXL8/3GSY6/+l8RzDyEKgSE2gaZFVg5X1z9CyJ0HpiGrNbgEP4s
         Sfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+LokEgk1OhCrIxCmqaU1nM/hbi0PMRKHeGZ/+qQiZ0=;
        b=Oux5xVmgG1iNX3RAfl44HHpd/ejhOfIhWYnAYMiGDqLDYQ8Vk920LPOHIqZNdSvujM
         zjf1YZplpA7X1izUv+SjPnPrAci5CXYYrlqBfC8/GUlQoiZRlj9mOfLnMucn9CnkyKiJ
         CIfpPlGqm5Vec3lyU9HuP06+HcuNqX07sganVibWSk7eXFO0uYvDu39gzMTlKi+r7opE
         mZwFRwyQloSQQNkDMRHuXgGYkASZEpLDT2h4D+FQbtGeNrh8OpkmGsOPyB3y5wLyomVm
         +CyyoZ93FlxeUVErBWONCx2tK24XCsvYvDw0cfpKeSae8D0JhUC7OiodkFoUMebBzxX/
         UoDQ==
X-Gm-Message-State: APjAAAVb8hR9YNcCTsfo2ox9EfLZPGaibDeka/U8qeWCs7MzaKEFOXaH
	Reau1CmZWiQpES4SJS/qaw==
X-Google-Smtp-Source: APXvYqx1xZoZd3Mg7blMfa6A8ZoF9XsfYVxAGm7/w6r4xbRVfj5XMCLb2k9zu8tiV2VMfYJA/cbBeA==
X-Received: by 2002:a1c:16:: with SMTP id 22mr18168884wma.8.1582499875389;
        Sun, 23 Feb 2020 15:17:55 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:17:54 -0800 (PST)
From: Jules Irenge <jbi.octave@gmail.com>
To: boqun.feng@gmail.com
Subject: [PATCH 02/30] dax: Add missing annotations ofr dax_read_lock() and dax_read_unlock()
Date: Sun, 23 Feb 2020 23:16:43 +0000
Message-Id: <20200223231711.157699-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Message-ID-Hash: LEVGXDD2MSLICDDMINAH7UIYSKT36MMA
X-Message-ID-Hash: LEVGXDD2MSLICDDMINAH7UIYSKT36MMA
X-MailFrom: jbi.octave@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: jbi.octave@gmail.com, linux-kernel@vger.kernel.org, "open list:DEVICE DIRECT ACCESS DAX" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LEVGXDD2MSLICDDMINAH7UIYSKT36MMA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sparse reports warning at dax_read_lock() and at dax_read_unlock()

warning: context imbalance in dax_read_lock() - wrong count at exit
 warning: context imbalance in dax_read_unlock() - unexpected unlock

The root cause is the mnissing annotations at dax_read_lock()
	and dax_read_unlock()

Add the missing __acquires(&dax_srcu) notations to dax_read_lock()
Add the missing __releases(&dax_srcu) annotation to dax_read_unlock()

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/dax/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 26a654dbc69a..f872a2fb98d4 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -28,13 +28,13 @@ static struct super_block *dax_superblock __read_mostly;
 static struct hlist_head dax_host_list[DAX_HASH_SIZE];
 static DEFINE_SPINLOCK(dax_host_lock);
 
-int dax_read_lock(void)
+int dax_read_lock(void) __acquires(&dax_srcu)
 {
 	return srcu_read_lock(&dax_srcu);
 }
 EXPORT_SYMBOL_GPL(dax_read_lock);
 
-void dax_read_unlock(int id)
+void dax_read_unlock(int id) __releases(&dax_srcu)
 {
 	srcu_read_unlock(&dax_srcu, id);
 }
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
