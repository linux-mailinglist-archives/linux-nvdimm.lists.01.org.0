Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664D414F91C
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Feb 2020 18:10:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 254EB1003E988;
	Sat,  1 Feb 2020 09:13:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com; envelope-from=lukas.bulwahn@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2631210097DCC
	for <linux-nvdimm@lists.01.org>; Sat,  1 Feb 2020 09:13:09 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t2so12469782wrr.1
        for <linux-nvdimm@lists.01.org>; Sat, 01 Feb 2020 09:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M5KeM9XPEcQOSTgANXYZAkXANlceUDSTwSKd2fmzxsg=;
        b=ZeX2LgenLwzZn2ZefiTmLj9NSXzjTV6+FCUUDVss9vB31lMUHQNVmOtA9fxqFtJ38I
         08wxomhQbtbHmBA5uv6n0XpDJWGJrmbSNuHxVSx44Zj0bwnwp2koV5n2eutjKe7CR3u5
         GIKOf7H6uw9FSNuPNz/Lj0SJlm7SnlxkeouzHgCIVGumBT8jYAuLxj5x0Dh3gWJtPHtX
         5OfUx45n5OWYL7F4g3JSiStWSMqLbpQQfYXPrxvRCUKtnxiEu27ql6lSMHzJdqo18Eqd
         cFKY0zPrI+CVeNBrXOcxv/LF+XUH2aWCwK4FcPhgdJEMGJK+ebVoFR++DvC6o0OAClBW
         R0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M5KeM9XPEcQOSTgANXYZAkXANlceUDSTwSKd2fmzxsg=;
        b=myPM9NnWMk4MUVUnLVM9YjKREkh04MStKnFi3zQ4lmDK/AviRLys9QrH5kMGAIEOoW
         e1XXxPIN22u+ZVukTKSkZ2tHoyEWl8R0H4MSOk4ZbaEYKSujm3ehdRNjR0UgD+pP2tnD
         bpmwFHOkCqLuwAQJUJZT/+Otos4aRLreEKVgxUNVnymMOjFY4YYF3UWVYgEGW9lVMT1V
         HQyJPZzBN9by3AeeJXFr9FPo1KaxrjJrpq3yzS31TJbAb6vgxpjoq5jNVAbMgxACO89t
         pUZYKMDONmZKDC7tr8D8JKdt2SyMk7W2UlIVyNwuxYCZ+z/ROmxUIUFKx0JKD/woqjl5
         AGBg==
X-Gm-Message-State: APjAAAWLfp24d/6IeLuul6NBWOTxb51fF9zPjauVG+myDzZKeJsmhE7m
	rKHe5IazkY65s9GKEv/xLaw=
X-Google-Smtp-Source: APXvYqyXQPivQeOLGHjYOjxCCwEvHsE7pCbNy5Bktscfvdep4bNFD1CxryQdNM3Ire8mEOCXQ23L6Q==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr5223481wrv.196.1580576989001;
        Sat, 01 Feb 2020 09:09:49 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d5f:200:619d:5ce8:4d82:51eb])
        by smtp.gmail.com with ESMTPSA id a62sm16311759wmh.33.2020.02.01.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 09:09:48 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH RFC] MAINTAINERS: clarify maintenance of nvdimm testing tool
Date: Sat,  1 Feb 2020 18:09:33 +0100
Message-Id: <20200201170933.924-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Message-ID-Hash: TF33JYWLILW7IGLRN4UIYRUS3NHF7PRO
X-Message-ID-Hash: TF33JYWLILW7IGLRN4UIYRUS3NHF7PRO
X-MailFrom: lukas.bulwahn@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TF33JYWLILW7IGLRN4UIYRUS3NHF7PRO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The git history shows that the files under ./tools/testing/nvdimm are
being developed and maintained by the LIBNVDIMM maintainers.

This was identified with a small script that finds all files only
belonging to "THE REST" according to the current MAINTAINERS file, and I
acted upon its output.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
This is a RFC patch based on what I could see as an outsider to nvdimm.
Dan, please pick this patch if it reflects the real responsibilities.

applies cleanly on current master and next-20200131

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f77fb8cdde3..929386123257 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9564,6 +9564,7 @@ F:	drivers/acpi/nfit/*
 F:	include/linux/nd.h
 F:	include/linux/libnvdimm.h
 F:	include/uapi/linux/ndctl.h
+F:	tools/testing/nvdimm/
 
 LICENSES and SPDX stuff
 M:	Thomas Gleixner <tglx@linutronix.de>
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
