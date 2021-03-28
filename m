Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B4734BA3C
	for <lists+linux-nvdimm@lfdr.de>; Sun, 28 Mar 2021 01:14:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3E72B100ED497;
	Sat, 27 Mar 2021 17:14:10 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5EB2B100ED484
	for <linux-nvdimm@lists.01.org>; Sat, 27 Mar 2021 17:14:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so5965283pjq.5
        for <linux-nvdimm@lists.01.org>; Sat, 27 Mar 2021 17:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jW1FihCEffaGaGj8gStuf8iIdnTp4nBLiNWcZhstcdA=;
        b=GznLIUUkMJUMP2n6rvL9dmpXg8K2varWOubU2T9ZPIUHvYvXSUhp3bpqeBLc9oxb0F
         Cnwu5mE+vpHhpYjGrv73gE3ns3AE0i/pljMn5QCcLmvLNrDURPjhdTvnxMfZ1gUlugHU
         9/QMGfU3D32XnmQvR7jRuK8J4SkZY+KfOesRuJbrX/7h6Ne/5aGivFRBx46NJGpRqi0/
         HhQ5RNmycAE+3kuNIcI7tk+p+jiVDW/HYo1+HRYlrP87V7nijcPgCwR2aQqs4c4ednFo
         qf5ABjQ0VTnTpEd0fYi43KrdLXB6UdNHKEsMIY3f2evofp/F7KckHslWKB9iSVdBzVKN
         yTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jW1FihCEffaGaGj8gStuf8iIdnTp4nBLiNWcZhstcdA=;
        b=dCxvo05xUr9gWitGzkVwWoTYb17gqa7nTrdbs4jcAwnYXr+wi28VPAAP65PRxeSid7
         OjbnNwBRNd+ILei8mrRuFtsOMiDoXcLmNeaSvItqC31vAFNKQE1L4TC9YU00/GH4ylo5
         PRNYrRnjK3iI/QEZp9Je64zOnbZOejXGFya1Fl0eH6HMYV/j1PbhLthPa2TGq4xsCppS
         WXDtxkXu+LQJl8xaWmFUhzLM4tTZdfVscjK2lomCapd8nxA2o6OXwtcBcZljGckv2bSQ
         HIb2o/thMefUfBaJ36+hF3l65ntnQboGtFFbamoFYZRkLNdgv9wriZIlcycQRvLtDmwu
         1VqQ==
X-Gm-Message-State: AOAM532ApB+RlDtwS7F4tQHOg0987Xsi4dU6fSio4kpzN+zpbTLvJbAa
	MAB9yUy1gciy4ZAJD7gPR/ALF/6KpiMnfA==
X-Google-Smtp-Source: ABdhPJyZmGwXoOwKC0AirLRW2VdjWJaOTMlxkQnP/RWgTnpKfwvnPsEe5FMgDBxyVwXZIFsSktyO+g==
X-Received: by 2002:a17:90a:be0e:: with SMTP id a14mr19123016pjs.131.1616890445110;
        Sat, 27 Mar 2021 17:14:05 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id n25sm3550684pff.154.2021.03.27.17.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 17:14:04 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH] libndctl: Remove redundant checks and assignments
Date: Sun, 28 Mar 2021 05:43:51 +0530
Message-Id: <20210328001351.2245032-1-santosh@fossix.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Message-ID-Hash: 6DRWYMK4WHQL3UIAWHAQCN5KZXYMFRAG
X-Message-ID-Hash: 6DRWYMK4WHQL3UIAWHAQCN5KZXYMFRAG
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6DRWYMK4WHQL3UIAWHAQCN5KZXYMFRAG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

check_udev already checks for udev allocation failure, remove the redundant
check.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/lib/libndctl.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 36fb6fe..262d758 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -323,12 +323,9 @@ NDCTL_EXPORT int ndctl_new(struct ndctl_ctx **ctx)
 		dbg(c, "timeout = %ld\n", tmo);
 	}
 
-	if (udev) {
-		c->udev = udev;
-		c->udev_queue = udev_queue_new(udev);
-		if (!c->udev_queue)
-			err(c, "failed to retrieve udev queue\n");
-	}
+	c->udev_queue = udev_queue_new(udev);
+	if (!c->udev_queue)
+		err(c, "failed to retrieve udev queue\n");
 
 	c->kmod_ctx = kmod_ctx;
 	c->daxctl_ctx = daxctl_ctx;
-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
