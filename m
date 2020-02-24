Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B52F2169BF9
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 02:51:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 028C810FC33E7;
	Sun, 23 Feb 2020 17:52:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com; envelope-from=jbi.octave@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A498310FC33E6
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 17:52:08 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s10so7364618wmh.3
        for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 17:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nfdAonBHBDdIO56FXt/6K3IvqAFG9q35tqL/Ax7yCLk=;
        b=FFO+GTQRYzvhCR/T9+OWH1M/t3DTcKoSYbe3tNNlO+4/iYItgFWLssom6rF8Xp9YL8
         FxIOs3ucAdHWJObclb57laiH68CJjjRonzGzNSWiCQ/ESHEqfnKpwxZFfjpEupFud1Gh
         ScWU0ls2v0O4nQQImaNXlT+NkoNmtJKDBODogXyRBkFgjkWET9G11A95E8WFvbabMkKT
         9rXEO9BXZPJFODc7CEd8pXl1KQuU8Kb3GqpOCwqpN8BcPH7Xx+UPCD5KKsaTfES7j0mA
         UeBHMq2Ab5fM0AceBfL3d0nyb19eoV8z4Uv4Tl07m86GL4c8Ymptqshgij9ep3Wd8xjI
         UgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nfdAonBHBDdIO56FXt/6K3IvqAFG9q35tqL/Ax7yCLk=;
        b=Mu6pqwJlKWgSLyOc3WUeahG0ibeVvfHaA4DwDpFA60cZAfVhYHGoDs58uvhtuAxQRi
         l8okfFgUBJWthI2h6YmeXNR+gKXDkjGBE6RwNLxV7J0Oo4NTQIJwgQRmkgX7az/8N+xb
         Q/wGM9vEPifuFLicnrEnhi4aaAq4PvSN3Uj0c3GhrW4ox7dBVhw9p3n/NL1vlKqk2A0J
         C6CAU50l3JaHhOf75xTsRL9FsEvfAZD23o7haaOUC7Uvz9pbWcGWJPDK3dR2DLslMQmI
         /Lj+v4VOIJ8KYeRcZE4SrQlr88vnP0DGiYk12SPci3uTPcL4jW0ahz3lhxeML+yFFiRu
         BHEA==
X-Gm-Message-State: APjAAAVXv7RMqNN0EifVrVexHZPCXwi9JmrZZ5gEIkRcLM5IQbFcWxAH
	1CSyzbKPe8UcY4mUS3fsxQ==
X-Google-Smtp-Source: APXvYqxJAxUIP1L7ykTRvXbpONm2cH/HKZWVO+UYiPkZXblqP/FothfdvA4k9N0h6ME4NC2QJV/tMA==
X-Received: by 2002:a05:600c:114d:: with SMTP id z13mr18633181wmz.105.1582509074914;
        Sun, 23 Feb 2020 17:51:14 -0800 (PST)
Received: from ninjahub.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm9528128wrf.67.2020.02.23.17.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 17:51:14 -0800 (PST)
From: Jules Irenge <jbi.octave@gmail.com>
To: boqun.feng@gmail.com
Subject: [PATCH v2] dax: Add missing annotations for dax_read_lock() and dax_read_unlock()
Date: Mon, 24 Feb 2020 01:50:49 +0000
Message-Id: <20200224015049.57556-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Message-ID-Hash: LPWTYFPP43A4X6IHNYFXF7HIAPQZUNCK
X-Message-ID-Hash: LPWTYFPP43A4X6IHNYFXF7HIAPQZUNCK
X-MailFrom: jbi.octave@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: vishal.l.verma@intel.co, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, yi.zhang@redhat.com, Jules Irenge <jbi.octave@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LPWTYFPP43A4X6IHNYFXF7HIAPQZUNCK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sparse reports warnings at dax_read_lock() and dax_read_unlock()

warning: context imbalance in dax_read_lock() - wrong count at exit
warning: context imbalance in dax_read_unlock() - unexpected unlock

The root cause is the missing annotations at dax_read_lock()
	and dax_read_unlock()

Add the missing __acquires(&dax_srcu) annotation to dax_read_lock()
Add the missing __releases(&dax_srcu) annotation to dax_read_unlock()

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
Changes since V1
Correct commit log typing mistakes

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
