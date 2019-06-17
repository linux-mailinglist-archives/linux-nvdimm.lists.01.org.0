Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA77047CBA
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 10:28:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 907AE21962301;
	Mon, 17 Jun 2019 01:28:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c49; helo=mail-yw1-xc49.google.com;
 envelope-from=3fk8hxq4kdl8gwjsifsmnllnsxlttlqj.htrqnsz2-s0inrrqnxyx.56.twl@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-yw1-xc49.google.com (mail-yw1-xc49.google.com
 [IPv6:2607:f8b0:4864:20::c49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A9F7E21296B16
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 01:28:07 -0700 (PDT)
Received: by mail-yw1-xc49.google.com with SMTP id p68so11577181ywp.2
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=EsSBOAivkaHwi6D12Cv8eKMrxsdP+T6KPHsvwbMQYm0=;
 b=C7EmzIa5t1p3To0eH+Btt+UKnk2zWoDCRcHlxDDez+EJGzuX5/OCX+VtE4f/+IBxBU
 mGEeX0YKVsmTpTHqWxwdvH8hqIG3FELhUYhSlXikfd0094SnjH2SPp0dcm0R005htjts
 6D/xP0jMwTBwY1jE9/ZxkY0+RYLVqYuSTLbgUEKmyJPUnfix1cU3MelrOVMNgQTKcGe9
 cFGgfxb8WDzOX4wGL98vqfITN9oZvAZ6ZQuIixRxb8VtiucW8A40EeqqX9/1t6jRhzWX
 B1r5Tw0xfFTV6bdsPqlvoEcQ0Y0C9kM0VAB1WtVyge15d2r4CngkCHzpB/WflMNr6YDF
 mQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=EsSBOAivkaHwi6D12Cv8eKMrxsdP+T6KPHsvwbMQYm0=;
 b=O6GAhCp4sQpeOA5oy08lqeomql6GxDfkB1dJRnZQs9qT5bxFw6r6T3P+/Q9c/JFTNO
 +/SfxrJEPxwbaDvyPSBm+lHk2TRIkSZctk3eSVht6X7NMX7w1S38uRUSMPn0L7UHE4bf
 aMv1YvP8oy0uUaRXtjz9aA63r38x+4+ltoyEG7GukoIWSJvoEf0X7PZS7EFCvOZLBPhA
 ol7BO+dvsA3RWnzYpcGcCdlRu8YYyztslnNSlUpJPj9zfYIyY3SvCJ5NC5fwGmD6ZoPi
 h1c98DrRcmsNAYave4MhvuyFCb/lphLROxIMzJaruuMSNdxxQHPLEZ9RR6TAhoZvUfsz
 qh2w==
X-Gm-Message-State: APjAAAUFt5h+wXEsBzTGtDl0ABL5sHyKxAdvxTWLvdpx7n/mBdePys1V
 OdtPlYnbwrZXrf8tRirb0AA17hbJwTHkIuaq/YIgYA==
X-Google-Smtp-Source: APXvYqygaxiZVfos+CJ+dORKXgXbsd4xQo+Oa0IXMYwFW3jHO/QMUCpEYOoJXhDPIYS8TyQgU0luKfcb92R2UWUxnJ1x6Q==
X-Received: by 2002:a25:7642:: with SMTP id r63mr57620375ybc.253.1560760086697; 
 Mon, 17 Jun 2019 01:28:06 -0700 (PDT)
Date: Mon, 17 Jun 2019 01:26:13 -0700
In-Reply-To: <20190617082613.109131-1-brendanhiggins@google.com>
Message-Id: <20190617082613.109131-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
From: Brendan Higgins <brendanhiggins@google.com>
To: frowand.list@gmail.com, gregkh@linuxfoundation.org, jpoimboe@redhat.com, 
 keescook@google.com, kieran.bingham@ideasonboard.com, mcgrof@kernel.org, 
 peterz@infradead.org, robh@kernel.org, sboyd@kernel.org, shuah@kernel.org, 
 tytso@mit.edu, yamada.masahiro@socionext.com
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
 Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org,
 Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org,
 linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com,
 wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 richard@nod.at, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3fb3fc30853e..05cd8ffd33c8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12718,6 +12718,7 @@ S:	Maintained
 F:	fs/proc/proc_sysctl.c
 F:	include/linux/sysctl.h
 F:	kernel/sysctl.c
+F:	kernel/sysctl-test.c
 F:	tools/testing/selftests/sysctl/
 
 PS3 NETWORK SUPPORT
-- 
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
