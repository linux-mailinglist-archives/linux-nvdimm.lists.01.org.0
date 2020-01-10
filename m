Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B12C1368E1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Jan 2020 09:20:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8A48D10097DCC;
	Fri, 10 Jan 2020 00:24:11 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3568410097DF8
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 00:24:10 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r11so656688pgf.1
        for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 00:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7b8XZOJXTk9zV76aUeE358xzYYpesRiHnpjM8weZogk=;
        b=vu878lOopdqQ+PrVkdO+JayiWO+IGIMGxt4b1rBO7X4NZDl5VVsm1eoO1zZo+tylJK
         6Vr9qDyApsNC2iC5rHddG718AXggc65u3frPAwvV3GMVRZO297c3gJy8NIgqeYijsyIw
         zYakl8jDJ0Zho9+fX1nb2cd6XnVt4Fwk/xAaiScAd04HeFYcNN5A20W68k/SUiz/Synw
         MUwK/W1I0aD5So7lUrHxBd85j0U0HIfKURi4f/FV5ADyaR6hL/dTERsWZLCunYTd60Gb
         SxfYxTDbNWIL15hAy4+cvqwRFSYaa4Hy7pis/64FdC5WmRhPugc5dcc/p2eiPdw1fy0S
         sD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7b8XZOJXTk9zV76aUeE358xzYYpesRiHnpjM8weZogk=;
        b=fi755HJZjNmSe2GR413c5G6RiLKBus5dyuGCwEendacieLN/ogreh/izIS/6BVS7DC
         vuX/OFdvF/5a8M2lFQ5AVKBGfbyRah4l1pAGbsg/ZiCErpwIWrjom2LW21bvz7fjdhit
         VAXZkDmgrvxR3CkrPmCCYd8Leiduz5BwwyoYS3XRdLXcb/thKKnSv/Ic1JMRuBcpbegU
         BMm4eJ3OU3UXU4j1Gsl8Yv2FfQ42bC3/g+K5KSLfuV5mc4XUFW5iRA9qKUgIbMf74/Pl
         IpYq5cL/tQJ2zuY94HyD0dBigjAoQYcyxNZkY3tIsiJye10HqgT24twtH/Jmop1lWT4B
         W1jw==
X-Gm-Message-State: APjAAAWkDMtjTwwFlTBIn7kHQUeUb94yUX6xhveSnCe2ofiX4qwFJIma
	udQqpeZTyw7sRwCKiG2Njq6HrbbMM7Q=
X-Google-Smtp-Source: APXvYqyV0Nnfdlw43HYX2NtpfTy8Y6GbVxK+kT+L2aKtY9+C3d0QvwQEqVmCcemhXBozzqBO1VJS9Q==
X-Received: by 2002:a63:510e:: with SMTP id f14mr2899834pgb.35.1578644450525;
        Fri, 10 Jan 2020 00:20:50 -0800 (PST)
Received: from santosiv.in.ibm.com ([129.41.84.78])
        by smtp.gmail.com with ESMTPSA id d65sm1755123pfa.159.2020.01.10.00.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 00:20:49 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH ndctl] ndctl/namespace: Fix enable-namespace error for seed namespaces
Date: Fri, 10 Jan 2020 13:50:17 +0530
Message-Id: <20200110082017.3485529-1-santosh@fossix.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <157854344810.1994459.8270881085555839853.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157854344810.1994459.8270881085555839853.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Message-ID-Hash: 6PJ7O2WCGU3B4GIKYUIZBBGZJMJLOSCD
X-Message-ID-Hash: 6PJ7O2WCGU3B4GIKYUIZBBGZJMJLOSCD
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: harish@linux.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6PJ7O2WCGU3B4GIKYUIZBBGZJMJLOSCD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

'ndctl enable-namespace all' tries to enable seed namespaces too, which results
in a error like

libndctl: ndctl_namespace_enable: namespace1.0: failed to enable

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/lib/libndctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 6596f94..4839214 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -4010,11 +4010,16 @@ NDCTL_EXPORT int ndctl_namespace_enable(struct ndctl_namespace *ndns)
 	const char *devname = ndctl_namespace_get_devname(ndns);
 	struct ndctl_ctx *ctx = ndctl_namespace_get_ctx(ndns);
 	struct ndctl_region *region = ndns->region;
+	unsigned long long size = ndctl_namespace_get_size(ndns);
 	int rc;
 
 	if (ndctl_namespace_is_enabled(ndns))
 		return 0;
 
+	/* Don't try to enable idle namespace (no capacity allocated) */
+	if (size == 0)
+		return -1;
+
 	rc = ndctl_bind(ctx, ndns->module, devname);
 
 	/*
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
