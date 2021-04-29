Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB49C36ED1B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Apr 2021 17:08:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 09C23100ED4BF;
	Thu, 29 Apr 2021 08:08:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=shubhankarvk@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 06DE6100ED49E
	for <linux-nvdimm@lists.01.org>; Thu, 29 Apr 2021 08:08:32 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a11so4022624plh.3
        for <linux-nvdimm@lists.01.org>; Thu, 29 Apr 2021 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GgXjPCns+v+eTZAmZafN0sCl2pErz4or/Z5oduKbOjM=;
        b=NOB7NTePrT66Rm9kLn0amKEGyBEPyg8zzxAqifAtZtkD4aZYV58gYuqmp9WytOdFDV
         scMvNF4k+BsBz5Q9Ww1c3wfh3MRfln13ka6MsVrR6fsuuUNoOxRFA/UhwwYT39G3PuG3
         GAoF8SIIcUX1Gom+cT0grvMFxHAZ18mHOW5YrGEj4fQNcQEd+B5YJcHozhl0IKqqd5ek
         zJQdMr41fpuy+qV3Y9zSMX/p3y419ZGiHxw8AZrtbY3LQRgGKK6PPJnc3lb+EGl07ozl
         OLSv5ojaqQBu5F88jkgSRBPVWl7tlKiF5ZS5kIlj4bz1oav/zce+R3eRczcHVxGZlQNF
         MlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GgXjPCns+v+eTZAmZafN0sCl2pErz4or/Z5oduKbOjM=;
        b=Tij5lV1QluWxLmrYMXRSxeW8r/P2PMpeEZVJqIzX0ZF2EtKL4R112Vdc8cKBVYC7Ks
         nu5+iWzp3TmbJZlUf7plSDBI1J7ramFOiUyii9bTb8ImuL34mEWK5//A0mGZCPkOxbhU
         iSgvGKGQMlEBkwWLVGS1Zq9Tg91Uyo5yNCTK4LWY/F+Zf4/ocVynr2NMgaTE6Uck7b3M
         7JxAY61lV12BidPT6AAEAqTWuwfLEopsqPSPsE6JJINVpqiE3Crx81DN5RQZJM5l1cfQ
         JNRnMxH2mArC3WA4TZ3CynNaYaYBkqjGuLF+Uu0fxzI0P8+ULaJC6fuWuOY/7kEijN6M
         vihA==
X-Gm-Message-State: AOAM531Y9hLhjVgd8E4VrC5gsA/wP+AGuyCa3tyYODnVTZVPl1typeAg
	5xCVNT93ZZUrcXkL4QW+i9SlpCZoPWAk+U44
X-Google-Smtp-Source: ABdhPJzcYVTJIuTNAaStQGXkeKJ+uhEePxuz3QpkB7hBzFgUkPgetxIb2Qo8N30n0hWwJOIcUJLEyA==
X-Received: by 2002:a17:90a:788d:: with SMTP id x13mr7891362pjk.140.1619708911670;
        Thu, 29 Apr 2021 08:08:31 -0700 (PDT)
Received: from localhost ([157.45.131.193])
        by smtp.gmail.com with ESMTPSA id m12sm204486pgn.24.2021.04.29.08.08.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Apr 2021 08:08:30 -0700 (PDT)
Date: Thu, 29 Apr 2021 20:38:21 +0530
From: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To: dan.j.williams@intel.com
Subject: [PATCH] drivers: nvdimm: region_devs.c: Add tabs instead of space
Message-ID: <20210429150821.a23qgknksyqk6ajy@kewl-virtual-machine>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Message-ID-Hash: 4BI52AR7REVY4DK7RBEVXPIOSU64JX4X
X-Message-ID-Hash: 4BI52AR7REVY4DK7RBEVXPIOSU64JX4X
X-MailFrom: shubhankarvk@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, sanjanasrinidhi1810@gmail.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4BI52AR7REVY4DK7RBEVXPIOSU64JX4X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Space has been replaced with a tab as mentioned in Lindent
This is done to maintain code uniformity.

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/nvdimm/region_devs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ef23119db574..e8a8fe3fc5a4 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1089,7 +1089,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	if (!nd_region->lane)
 		goto err_percpu;
 
-        for (i = 0; i < nr_cpu_ids; i++) {
+	for (i = 0; i < nr_cpu_ids; i++) {
 		struct nd_percpu_lane *ndl;
 
 		ndl = per_cpu_ptr(nd_region->lane, i);
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
