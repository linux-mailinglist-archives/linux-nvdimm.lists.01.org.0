Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B44A3114C6B
	for <lists+linux-nvdimm@lfdr.de>; Fri,  6 Dec 2019 07:47:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 533451011350E;
	Thu,  5 Dec 2019 22:51:04 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1041; helo=mail-pj1-x1041.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9A7D41011350D
	for <linux-nvdimm@lists.01.org>; Thu,  5 Dec 2019 22:51:02 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id g4so2321604pjs.10
        for <linux-nvdimm@lists.01.org>; Thu, 05 Dec 2019 22:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cq17JqcwYiQ0Qf4ck8F3GCt/JsZkJIuVOWQsWAQiZCE=;
        b=Kfm9tEVoIioF96aHSHBMfRwiyiI/rZZhLCcPrMTJvHXE8ZmMm6zv0BEGs5FPhJ1Pnq
         0QuXTVsEbdygl7t2uzVoMhDwPSUwWLm1ZYsueQ2NbZ24F3bpSNTTV/hFNqivZTzhVq/d
         AbeADbuiJh6OqACDQXjRjxqLth0EZOg3/qnQebRGITAMNcCPWqciERgrEXanAshDmSAa
         nI5+rlLIZxe+JDyGByfu3EYur5drktomcNO9CcO/E8ZzJRkSw6bX3UHE0H9VPNahlmyR
         t4k2aJGp+E25yvZE9E0aeMI7S3aDu8U+umuFmp4Qyogv5UbaTZjxjCC0XKJ0+fU8LL1/
         dHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cq17JqcwYiQ0Qf4ck8F3GCt/JsZkJIuVOWQsWAQiZCE=;
        b=HSXPSvyJkuvMIg5qSzkIXONpRqwM9VWZXzMnvVA99EM1+Z0Y0GdGFcfJsc+9PkUJuZ
         FBAC22xVsdJOvQu1Py8MzdT5Flm2F/LL4aq55UC59NCWZ9meZNqYdRvh8cFM+LNi6LTM
         XyRp35wuSyUuXQGbMIimAoIxTiKZmz2F9eztsNctfb13RTKhh/Ax5sAPJNud4VQ5LEYG
         JsDULDWnTOfT6B5Ac+hJ/ZVAdHrKgQMnh54HiHh7Zux0Eu5GsY7z8IoVavPl3IPTBx45
         fjgQGBpBXV16gEFvZKUvjlcgQRJtAT+xT78j4TTeCm5TILFMcbQmTADKnZHWUqD+V+kL
         NFtw==
X-Gm-Message-State: APjAAAVvruBusaJEdh6to+AFHG+tC60rhSc8dmNbItnCzFrPvhqLTvA/
	E0lr/GzzQHxrUQaN0mDyVBPVIIVAHz8=
X-Google-Smtp-Source: APXvYqwfFcthCpP7uRa7rOKA6rPuXvvWmnaaiEInGaWjz1rjTsuhSi67Xac5gN+akvIhFnlumMZU4A==
X-Received: by 2002:a17:902:fe98:: with SMTP id x24mr13148477plm.155.1575614859426;
        Thu, 05 Dec 2019 22:47:39 -0800 (PST)
Received: from santosiv.in.ibm.com ([129.41.84.64])
        by smtp.gmail.com with ESMTPSA id n188sm5624053pga.84.2019.12.05.22.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 22:47:38 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org,
	Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] ndctl/zero-labels: Display error if regions are active
Date: Fri,  6 Dec 2019 12:17:31 +0530
Message-Id: <20191206064731.283172-1-santosh@fossix.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Message-ID-Hash: HCN44MSIPCIYBDEXL5B2FCMZIZ5XJAG2
X-Message-ID-Hash: HCN44MSIPCIYBDEXL5B2FCMZIZ5XJAG2
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HCN44MSIPCIYBDEXL5B2FCMZIZ5XJAG2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Get zero-labels behave similar to init-labels.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/dimm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index b1b84c2..8b039fb 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -80,6 +80,12 @@ static int action_enable(struct ndctl_dimm *dimm, struct action_context *actx)
 
 static int action_zero(struct ndctl_dimm *dimm, struct action_context *actx)
 {
+	if (ndctl_dimm_is_active(dimm)) {
+		fprintf(stderr, "%s: regions active, abort label write\n",
+			ndctl_dimm_get_devname(dimm));
+		return -EBUSY;
+	}
+
 	return ndctl_dimm_zero_label_extent(dimm, param.len, param.offset);
 }
 
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
