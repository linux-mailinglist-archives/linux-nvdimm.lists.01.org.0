Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22C766877
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Jul 2019 10:18:11 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1044F212B7DA6;
	Fri, 12 Jul 2019 01:20:37 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com;
 envelope-from=3p0ioxq4kdfqxd09zw9342249e2aa270.ya8749gj-9hz48874efe.mn.ad2@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7CC35212B7D83
 for <linux-nvdimm@lists.01.org>; Fri, 12 Jul 2019 01:20:35 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id d187so5286308pga.7
 for <linux-nvdimm@lists.01.org>; Fri, 12 Jul 2019 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=tRWxB/VAAV03ErbuMUlwG4nfr04i5uXxvmyjeK/eYMw=;
 b=fHwJnLlLISoqqvDLfyGk8Vw3/9WOMxJ7OvlFCg60FTmh8rrkGX1XqrgWqeHGbkOsY9
 +9oig5zdjDaOqX38pwXJ11qc7zDS9xm51tLG8d25Pjl1qnpFQ00DiM7DgsXnHCHhAf4u
 nWPLyei0fJyAgxO/X1UeAkr7Vthrx42va4uBivgP+bj8Y81BwkUY+zTsBlN4qLRnMdWU
 WEsrFUyDNb2QC4wmy18R655kwuWcHYQFH6bB1A4/qso+3SZixPG89crgQSo4SlPakdWA
 lNMkNruO9RTX0Na3yK694/C+DuZRUD9DprT3tYjpbz8Q1UNMfW9LI+przQMH/Z0msupI
 vhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=tRWxB/VAAV03ErbuMUlwG4nfr04i5uXxvmyjeK/eYMw=;
 b=hVpgIQMcm0pDWGYrcJfJp/chNTUfo8z9wnYVJZIHi+FUo55mlnQ4++13gwsXuq2WpJ
 Lj7sXCwz3pr1heUdU9OhIX5sKnzzToV5aSiFOtsvo28wOGB7XkRt1v0xtDhncpswp5xP
 55lvNgOnYSwwLee3tEqjcqEoBZtvk/RFq1dYtumra7xU86LBroWeP7dIqAg5eo4DGnQz
 YuyRBY3tMLZBvzpdYqlDO1b/E7Ihg7Jz0VPFcdvf2M46Dio2ZMpAMkKwleIIlw5KeLw9
 4giE9rvQjeVa2kxRbIFpcEbOBN6tgI/ozHMWhScGPEES5J+bY0X+/jvgLJ0foIZD9MRC
 0FHQ==
X-Gm-Message-State: APjAAAX229ldwf9t7OidZ1/5IGCcxVt0NSCw8mHo9kf36K/JNl6eq9W9
 GKknxIEOBdepo4POr1W38ObDMQVaQtJUHjcZqgeNSQ==
X-Google-Smtp-Source: APXvYqzSxxZhDV/VHuvjEAx+PSSV2CXvVreQjca+MxOlfBW78VEVBMXf9ELB10VRLpFN34tmpwg5o+RRVIJafuHGXJT+dA==
X-Received: by 2002:a63:755e:: with SMTP id f30mr9386006pgn.246.1562919487340; 
 Fri, 12 Jul 2019 01:18:07 -0700 (PDT)
Date: Fri, 12 Jul 2019 01:17:32 -0700
In-Reply-To: <20190712081744.87097-1-brendanhiggins@google.com>
Message-Id: <20190712081744.87097-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 06/18] kbuild: enable building KUnit
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
 Michal Marek <michal.lkml@markovi.net>, richard@nod.at, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

KUnit is a new unit testing framework for the kernel and when used is
built into the kernel as a part of it. Add KUnit to the root Kconfig and
Makefile to allow it to be actually built.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 Kconfig  | 2 ++
 Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Kconfig b/Kconfig
index 48a80beab6853..10428501edb78 100644
--- a/Kconfig
+++ b/Kconfig
@@ -30,3 +30,5 @@ source "crypto/Kconfig"
 source "lib/Kconfig"
 
 source "lib/Kconfig.debug"
+
+source "kunit/Kconfig"
diff --git a/Makefile b/Makefile
index 3e4868a6498b2..0ce1a8a2b6fec 100644
--- a/Makefile
+++ b/Makefile
@@ -993,6 +993,8 @@ PHONY += prepare0
 ifeq ($(KBUILD_EXTMOD),)
 core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
 
+core-$(CONFIG_KUNIT) += kunit/
+
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
 		     $(net-y) $(net-m) $(libs-y) $(libs-m) $(virt-y)))
-- 
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
