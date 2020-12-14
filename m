Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7342D967C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 14 Dec 2020 11:41:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A870100ED482;
	Mon, 14 Dec 2020 02:41:53 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 17B9B100EF276
	for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:41:51 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t37so12203102pga.7
        for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xhAFrR9jtzwDWeloSl3q32TBY64JH9RSrkYJWBlq3yk=;
        b=irEgvvpupjA17CYTQasZUCb+9fsoVPN/AwSwMDzEvC7eEMZlTQDqtcQdq7Bhent89d
         diuHNOry2uRrEI/uGBJgl00uv6oY1tcwfc37gzwOd/YT3ncZqVzPu7t1Gp5nDsli373A
         mKEOBpkzDnTUFZayhNzVp5kauX1Zp/w/zCBIVPFD71D8eU/uP1UAgFZNaOwnB/x+GVIe
         ZWdNe/fRG4Y2seHFXRbSgcwIsa+I7SXo0CFZlHD2YPfoXscFBJ4tElsu79jC81mbRA2d
         TWhQn0mEt6sNg/qEcNMnmq0vmHcH2PzFvmN5QyzoXlDMc6YGa4usfieZ1ksswmFdnPha
         xYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhAFrR9jtzwDWeloSl3q32TBY64JH9RSrkYJWBlq3yk=;
        b=JASC/1jJLrmbQyX0/LJZR6QuIgobn7mhNlZwC1FgZDcymy5z8p9ozJ+gmlfBiF8zJE
         JRQ0PITyxTvWpe6XtlVk90caAqx8tvn2W1NwIY8P9o4wppyOueyO+9eH2hmkdtHjrwfc
         VJqWR9oxj9Z6OSpuwklQI8JeTWCOGX7wZRU3G1OIXmxoINO6DimkSgP6iLoos087+G4/
         zbrEH5VhfM3BZRug+osiTzjRNVeOywiNiN+v4hZAB82EpziAMrXoiLaucJ40nqFKYbsg
         x1TPPid147NjXPXyetGZAOQaYJnahO3oqHVas8mGyGm51EDfjY19qSGRXze2n6pSdXgz
         ggqw==
X-Gm-Message-State: AOAM530Q8hX+bgAVSb+DTNmKfLiD53X5ygDg8yZ5O/ejZGKak6mtJJnO
	4dnXq6sWXbv8SKDn8A3KhpHATnEdZe4Q2Q==
X-Google-Smtp-Source: ABdhPJzyOUuCPNVZ9zj6WFpKAJd2i2dYitWjDvCHfJjLKTpKBelVdjx5U/oNFX9f+5ePws+aWkpAFQ==
X-Received: by 2002:a63:f90a:: with SMTP id h10mr23560364pgi.375.1607942510574;
        Mon, 14 Dec 2020 02:41:50 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id f193sm6208581pfa.81.2020.12.14.02.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 02:41:50 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl RFC v5 4/5] test/libndctl: skip SMART tests on non-nfit devices
Date: Mon, 14 Dec 2020 16:11:25 +0530
Message-Id: <20201214104126.2410043-4-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214104126.2410043-1-santosh@fossix.org>
References: <20201214103859.2409175-1-santosh@fossix.org>
 <20201214104126.2410043-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: SWECJHKBKSEHNYJCQFWBSDPLDNV2AFKG
X-Message-ID-Hash: SWECJHKBKSEHNYJCQFWBSDPLDNV2AFKG
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SWECJHKBKSEHNYJCQFWBSDPLDNV2AFKG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is just a temporary check till the new module has SMART capabilities
emulated.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 test/libndctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/libndctl.c b/test/libndctl.c
index 5043ae0..001f78a 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -2427,7 +2427,8 @@ static int check_commands(struct ndctl_bus *bus, struct ndctl_dimm *dimm,
 	 * The kernel did not start emulating v1.2 namespace spec smart data
 	 * until 4.9.
 	 */
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0)))
+	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0))
+	    || !ndctl_bus_has_nfit(bus))
 		dimm_commands &= ~((1 << ND_CMD_SMART)
 				| (1 << ND_CMD_SMART_THRESHOLD));
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
