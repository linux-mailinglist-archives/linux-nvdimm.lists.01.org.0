Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BCB19AECA
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 17:34:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A49F610FC3618;
	Wed,  1 Apr 2020 08:35:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com; envelope-from=jbi.octave@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D126910FC3616
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 08:35:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h9so549377wrc.8
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2xmqhIkgms3NDdu1qlsVKf+BkC4V+OOS1HRZtVEAu4=;
        b=dXfEz2tqSq0A0uKS8WMMW3fcexD5Eam5TUcjz0Wa4rgsfIwZqgRp3/POPt7VOsMRoV
         y6RE57GEWJkU5Y08tV4U0WTaKM6hGIJhvF8fv9n9GHZMSBojXiXiMPxasEQJ8zGPe3Nb
         +tQ8mPIIYrGiDwYv0hgswsMZ1niRU1p3XVMZ6gnsxz1K0Vux2/lRKQWNlGel1e7V2ASn
         atlYAjBhIkOtsdMzhAFmD0zbuk0jw8PV+XGuPwgoCKm55Lxg1g80sHWuPAygpPrY7MQQ
         A9jpIDPB9/+q8WWNCB28P2Icb3nHTIwTWJDA2X4iUJDxOemtre54/wcYPVYj6LNscNsG
         Xiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v2xmqhIkgms3NDdu1qlsVKf+BkC4V+OOS1HRZtVEAu4=;
        b=I0fs3H74p3UGVqu/8Vcm5GCNF51sKgP+VtSlmi35BY643pKMaWiBGsmvB1F0wZAyC9
         TSmunbhhQIUbWcf3Fwz64Xlh8jyfkwWRmvLEfN8BtjUovm4RJzbuA93XCNsGJilnv4UD
         7C55BbR+svtduxeybDqZeVira96l5dlpwr38Zkd4k/o7fYpr7Ko7LMPjzEUhLuy+C4rI
         QfnW15gEFErTa5rzmJZtYVNX8ziG/j9WLPfVQ4hGEEQVX7XJZzhfXsMH/4hD3MTyd3Cy
         9mcyNvtjfMYYjclMfkVm1HwCF0FGqEOe4fChl1Qpe5rq5ENoH9RTSVltv2eP+i2XpzsX
         6kOA==
X-Gm-Message-State: ANhLgQ3fj8gDutNXbR1bls8xIXi/aromxdpcZIud1wQRD9w+SZLwg6OG
	0akPywcz7sDoOlCk4wtVTw==
X-Google-Smtp-Source: ADFU+vuoH/j7UWYyGvcYZzuuMhyJjjfDWZOAJY2ULBtVPmlcQjeVjkbPb7b6pQfmfMvPOyTvWKbzGA==
X-Received: by 2002:adf:9022:: with SMTP id h31mr26058270wrh.223.1585755250075;
        Wed, 01 Apr 2020 08:34:10 -0700 (PDT)
Received: from earth.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id d7sm3275741wrr.77.2020.04.01.08.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 08:34:09 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] dax: Add missing annotation for wait_entry_unlocked()
Date: Wed,  1 Apr 2020 16:33:59 +0100
Message-Id: <20200401153400.23610-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Message-ID-Hash: 4NAXUEQDOUHDE3ZDHDIGFA2BPISA3EZU
X-Message-ID-Hash: 4NAXUEQDOUHDE3ZDHDIGFA2BPISA3EZU
X-MailFrom: jbi.octave@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jules Irenge <jbi.octave@gmail.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, "open list:FILESYSTEM DIRECT ACCESS DAX" <linux-fsdevel@vger.kernel.org>, "open list:FILESYSTEM DIRECT ACCESS DAX" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4NAXUEQDOUHDE3ZDHDIGFA2BPISA3EZU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sparse reports a warning at wait_entry_unlocked()

warning: context imbalance in wait_entry_unlocked() - unexpected unlock

The root cause is the missing annotation at wait_entry_unlocked()
Add the missing __releases(xas->xa->xa_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/dax.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dax.c b/fs/dax.c
index 35da144375a0..ee0468af4d81 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -244,6 +244,7 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
  * After we call xas_unlock_irq(), we cannot touch xas->xa.
  */
 static void wait_entry_unlocked(struct xa_state *xas, void *entry)
+	__releases(xas->xa->xa_lock)
 {
 	struct wait_exceptional_entry_queue ewait;
 	wait_queue_head_t *wq;
-- 
Change since v2
- gives more accurate lock variable name
2.25.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
