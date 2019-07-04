Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B64935F048
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jul 2019 02:37:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4A730212AF0A5;
	Wed,  3 Jul 2019 17:37:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com;
 envelope-from=3wuodxq4kdfivby7xu7120027c08805y.w86527eh-7fx26652cdc.kl.8b0@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 02EDB212AD598
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 17:37:46 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x13so2563004pgk.23
 for <linux-nvdimm@lists.01.org>; Wed, 03 Jul 2019 17:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=XlrqH678HDR84yo41rM73BaaQaGuXs9XZZneq4FOZeY=;
 b=ffmju7yr7gRfaJbHZ/EKKmVncl8VlWULQaThQY06zll3+6WpQG6lpGZ4OPQmMivptS
 8hDYradWvLpP2Ynet+Ye7uV0kLczbf6RFD8mFVTANX2yg7wM9YbXidQ/FQZgq07MWegb
 OGw9om8WRHzmMMnObSBGoIx3ybtRj+V2h+ffEXd5lxF3Nc0UTcEdl8L3/UVHObrq7Hpr
 pb1JvhsO78qMQnHwg/Ed80IloOa6WYSoqzkmmaIisIDaOlJlxgcTtQcFCed7VfZAR09f
 b9pzfPkA2sw/PBcf5XMV0Aycvwei2GOmUX9h6Qyralx5M52IFq4n3EvX8Bsm6682vUXZ
 cuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=XlrqH678HDR84yo41rM73BaaQaGuXs9XZZneq4FOZeY=;
 b=Embz9KkD2NtM+GMaBsRBGAEWC8/sJkR0Xn5IUbn/uE9IGPDCFm0BJFp6/X3BovlYNq
 s/NaU449Mz7nM5PLJmKjSrVv4O1iI3RJH3XabGYBKJZLDFUP9cBKOInstGvnXCoF2ZPo
 Zk3BpQx4KYsDuIITpIkLnnEDma/65U4qNtJDQ7Du2IH49qV6xtaoWBtf1Bh4innsdfzo
 8gt0TrJcDWvG3NAn9ARJx8HD9q7YB5+y944Mauswra23dO97ZPGAIWEijjSiW7zqBefV
 awEsDI0Bj/IMJyrdPCV7W+GPDsuqg8hFHD93prYtWG0C9bpUHfnYkZfM2HAEO4XFxn6b
 nYgA==
X-Gm-Message-State: APjAAAVObvD1mB5+7R1S59dPPhjtX66+MxgRRA5GMscqI0IIrJZZwomo
 8rzPPMYf0F9i3fFVFxjEqZ2PKaLljLPFy32FCkVL+A==
X-Google-Smtp-Source: APXvYqzEyrStQtoN+0MmqxKcoxkpwGwMdPWPCVJ2v+rt7FevA703DgZaVQugKeZ2rVGA0cnHCH+IEhNvyiDaQ8b6b05Cdg==
X-Received: by 2002:a63:1b07:: with SMTP id b7mr39423299pgb.133.1562200665901; 
 Wed, 03 Jul 2019 17:37:45 -0700 (PDT)
Date: Wed,  3 Jul 2019 17:36:03 -0700
In-Reply-To: <20190704003615.204860-1-brendanhiggins@google.com>
Message-Id: <20190704003615.204860-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190704003615.204860-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v6 06/18] kbuild: enable building KUnit
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

KUnit is a new unit testing framework for the kernel and when used is
built into the kernel as a part of it. Add KUnit to the root Kconfig and
Makefile to allow it to be actually built.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 Kconfig  | 2 ++
 Makefile | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

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
index fabc127d127f9..44e0d730dd5b6 100644
--- a/Makefile
+++ b/Makefile
@@ -991,7 +991,7 @@ endif
 PHONY += prepare0
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/ kunit/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
-- 
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
