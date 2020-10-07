Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0233B28578B
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Oct 2020 06:23:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CAC6D158AFE97;
	Tue,  6 Oct 2020 21:23:46 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 280FC158AFE98
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 21:23:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f19so588596pfj.11
        for <linux-nvdimm@lists.01.org>; Tue, 06 Oct 2020 21:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLRlG/7IMAxe3+wfn0iPA9kYBHpGAKo6CuoMSRj+vAM=;
        b=JrEmiN20QdilbDJkA//fC67vI5IAS64p0gDQcbpCY4CZEaH+MuLLGNcRMmsmTXir3G
         bW+4lEWRKX2B7KY89Xp0vCrszvCRGaDHUi77LIMb+Qv3TU5wIrjfL9f8QSGTcV4aZAJh
         uQeiDXkM+zj6p3qQGb9RudG1nzPJvSajvfaH/BWEwBooY+pH4j3ftnwMWb0DIXpP9V7W
         JamRMqWoO8T3EjS1RdK0FHbt7QOg3UdRXofvvm1z7+o+p2mZbBZuXlSuROCb8zbz9I2T
         sQAeZm35MtfOWC0NnWD807tv46zqvdxSBwZbpCOXs7hfzsVU1wtdhmLOJRj/8oo/Wzm9
         BGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLRlG/7IMAxe3+wfn0iPA9kYBHpGAKo6CuoMSRj+vAM=;
        b=sd0SB2OgejajJasWEU5LaoXWvL334Wz/uIxiPPXmwqj30OmwPFw6lrEiDdBYqMsL5P
         lweo7v9yqLfzEB/E5zLbz5K32xGkkJTJDnRx4dN8D25xxGVL019BmEHL7N07ZpkZxAdf
         aiBxvTHCRo34a/6TtUlnbiovdR12WTkxcUdO8P+TIZrqQh7ZPTkygbQ+K8nGI4Va97aY
         6lGTi2OZcQ7bqYuAoVOzd4FipRVcDaBCsUx58xe8dMYV2pT0LV4+W03GDA744EWJ11jU
         9zQ+8wBeN4AFugaUE65MzV56f0EPo5AMHjOQWmNzo64QcWDY5sPGzXA+jbXlhJ+i3mCu
         GJXg==
X-Gm-Message-State: AOAM531RrNhE96bEe0jTdMxxlggS6+vAHx41E3a6BNdMuwyAKrYj6URa
	4/0tuIbR6OmvhTpanHjvwNA5C2O9DkwihQ==
X-Google-Smtp-Source: ABdhPJxeJU407QqZhhX83RDCbfaS524AiRCtdiIrcQpzTt/Gwsp9nJ8wHSgrTIRcimewStQRQ54K+g==
X-Received: by 2002:a63:5821:: with SMTP id m33mr1332237pgb.16.1602044623601;
        Tue, 06 Oct 2020 21:23:43 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id t186sm844499pgc.49.2020.10.06.21.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 21:23:43 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH RFC ndctl 5/9] test/libndctl: skip smart tests for non-nfit platforms
Date: Wed,  7 Oct 2020 09:52:52 +0530
Message-Id: <20201007042256.1110626-5-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007042256.1110626-1-santosh@fossix.org>
References: <20201006010013.848302-1-santosh@fossix.org>
 <20201007042256.1110626-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: 22WI7BFXU5IZ7TBRDENLIOTKL6M7TR3R
X-Message-ID-Hash: 22WI7BFXU5IZ7TBRDENLIOTKL6M7TR3R
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/22WI7BFXU5IZ7TBRDENLIOTKL6M7TR3R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 test/libndctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/libndctl.c b/test/libndctl.c
index 1a5a267..93cbc7a 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -2451,7 +2451,7 @@ static int check_commands(struct ndctl_bus *bus, struct ndctl_dimm *dimm,
 	 * The kernel did not start emulating v1.2 namespace spec smart data
 	 * until 4.9.
 	 */
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0)))
+	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0)) || !ndctl_bus_has_nfit(bus))
 		dimm_commands &= ~((1 << ND_CMD_SMART)
 				| (1 << ND_CMD_SMART_THRESHOLD));
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
