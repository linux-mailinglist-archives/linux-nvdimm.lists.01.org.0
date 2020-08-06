Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E564123DA6E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Aug 2020 14:48:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5548E12BB672C;
	Thu,  6 Aug 2020 05:48:09 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1043; helo=mail-pj1-x1043.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6A2EB12BB672C
	for <linux-nvdimm@lists.01.org>; Thu,  6 Aug 2020 05:48:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mt12so6607268pjb.4
        for <linux-nvdimm@lists.01.org>; Thu, 06 Aug 2020 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgt5XAihCLJaVHJlMe8TetVQwBqCaj8b3qioXTJ2+vg=;
        b=cVDJg15MaNC0GISBDGvzJWR3h7L0Y77xI+cWJIl9AAl2UEHlveuAamkAQpgkwPlcjn
         AgfSqdpvf6OFuiQ6g93SmixO7y7sT6CUe+L46b5gi9AOfsTh3eIHoyvdV16O3mDxVALq
         BUzd9qAfHyhwhS1FINt+59t/o1HdKz4LENyyf8JtcAPKkSeamqChw6kwALSpPtkr1LQ4
         TGDhA6wN3ZqGs3Vxbz/Z5medz9pDDJs1RaVCYHaByMhBh8WBGAFO71iqhiEIg4u7xh0H
         3le18bEFgP09v4MUh2GR0OqKsCbmB9WN51EBzUL/TvQiHkax56SORom648MhTJgxNWMb
         e7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgt5XAihCLJaVHJlMe8TetVQwBqCaj8b3qioXTJ2+vg=;
        b=rrlkfvMT2RRnA8N0UMdSLIwHaqyOWfVnKPq9Tm/6+cjP52kG5h2x99F6brvUAXH5dy
         6X92nDl5BJ6Bqb5kvABATnnR4jkpKG8VRxmQINjQ3wYO4rXSwMyYkk76HkpHuN0LEB4e
         bQxAQDXfIaRK6+lNRiOGn2Jy/1xk+/OqGL9WachgfYd4w/Kx6+6IcOWULXEhkQgPYsKl
         i4VE/9WJHHSwWexXU6Afpr1DtNSMMYTpz9Ruxibr/MA/vCcEwgkA9NdImZ28JBKSVxjl
         5d4EZmVgkbxRkZqDAHb8/EaXTp1bSEg5Cwd6VSrY3tk4cRSAuVJ4iefsfSKiwfGFUr7G
         iqpw==
X-Gm-Message-State: AOAM533WMQXWkIvMnr02GQt9c5DK1QRaB17hWTZLbAWhHoMvV+KAAo9k
	8BAX++JbcJ1fcDwYeCqM97a8oAqg3hY=
X-Google-Smtp-Source: ABdhPJxImF5WOhmnda8sL3y9+kAN3AlYk2DEFVFr+9BaF2piHj9dujHmq16sOUJty+qAA+lC9bUuLw==
X-Received: by 2002:a17:902:cb91:: with SMTP id d17mr7503871ply.223.1596718086602;
        Thu, 06 Aug 2020 05:48:06 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([203.223.190.240])
        by smtp.gmail.com with ESMTPSA id p187sm9443907pfg.136.2020.08.06.05.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 05:48:06 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl PATCH trivial] test: Remove a redundant ndctl_namespace_foreach
Date: Thu,  6 Aug 2020 18:17:02 +0530
Message-Id: <20200806124702.305084-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: 7JU53YAB7KQJ4JW2LGPKKTKX7UM7A7ZA
X-Message-ID-Hash: 7JU53YAB7KQJ4JW2LGPKKTKX7UM7A7ZA
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7JU53YAB7KQJ4JW2LGPKKTKX7UM7A7ZA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I don't think this was intended to be in the code.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 test/multi-pmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/test/multi-pmem.c b/test/multi-pmem.c
index 668662c..cb7cd40 100644
--- a/test/multi-pmem.c
+++ b/test/multi-pmem.c
@@ -162,7 +162,6 @@ static int do_multi_pmem(struct ndctl_ctx *ctx, struct ndctl_test *test)
 		char uuid_str1[40], uuid_str2[40];
 		uuid_t uuid_check;
 
-		ndctl_namespace_foreach(region, ndns)
 		sprintf(devname, "namespace%d.%d",
 				ndctl_region_get_id(region), i);
 		ndctl_namespace_foreach(region, ndns)
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
