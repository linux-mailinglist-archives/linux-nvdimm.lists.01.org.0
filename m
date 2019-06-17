Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 851FD47CB6
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 10:28:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C33921962301;
	Mon, 17 Jun 2019 01:28:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::84a; helo=mail-qt1-x84a.google.com;
 envelope-from=3eu8hxq4kdlogwjsifsmnllnsxlttlqj.htrqnsz2-s0inrrqnxyx.56.twl@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7238E21296B16
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 01:28:02 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z6so8590330qtj.7
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 01:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=bPJF89cE4tB1wXKocb/qXW7wfYtIegjLntcYJJ0aEtU=;
 b=o3ogFQ5rdp7cs19G6mteH4rVDUn7teQlurDS0jWzA1kqGwAdqcTxbcDaERqO0pAcK0
 Eh/sClefw5IpL+NRbzQmr6gm3oBb2p8bAzIgg9VsGdKoZ8PJcp2xIjTn/DeBFhMeb7uR
 dNswLweSgYBoYpma1nvfuatrGqhK85GbkGMdIeoO4zRE00IECRglOhzr+/nawhYV39ee
 bQDQC5r2qfCqDqtCzLuaxcLPUb91JojIyYu9tnH2DTcRG9G6JLjrnwscNnQBm+FLS7Tv
 KGYroA3avaB1RnLa65qQXoiFVl6APqQtkplsbvke9XY0m46ewZR6DehJ3wQkF6J665bz
 WPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=bPJF89cE4tB1wXKocb/qXW7wfYtIegjLntcYJJ0aEtU=;
 b=AovkRX0Xjva7lsp7FOODE/c1aDICU4mq3JwpEIGsmJsuQZbfYBlPOr3cOdR26jAhlr
 8CGsl5n4JBCGW0riceSxr5nlNWOS0rNjvWS6/NfTV7nSvwM7JJw/FzjphdoKp3Z+/FxE
 i8ol6xo5GEUpTH3PUXqx/Kse8Wu///lKm7KT6Hea2OdRTmaf+cBOPVRy1fnP1qzHl3Cx
 9KFGzCBpLV7+4s/p34/cGs6Ur6O51diwybeyKis3sIGsN7pOv5Y6VEz+Q8yvZq4Bi7eV
 0iQO9TUhdVXE2pwqmFbEDhGyp/ZOgoRuTrFNPwhMy9UMVczESXPvAhGPn3obk7COgL5F
 1mkQ==
X-Gm-Message-State: APjAAAVGQAmiMiBNznXE+9JXfqjmg1rSJCWYklojsrIlzFWoS3CF+aL7
 w/XPHa/f33eRHd3XskxvmfUiHd2oh/AU2M/MEOOzng==
X-Google-Smtp-Source: APXvYqyTbtjCAcLDWOBf80YN420uGxHfWPtOCpnCXNoMdm2lw18nK8fM3CaU+vc/SrSDk5njDqLK9j/e5783XfBqOv3IRQ==
X-Received: by 2002:ac8:2ac5:: with SMTP id c5mr86955007qta.332.1560760081475; 
 Mon, 17 Jun 2019 01:28:01 -0700 (PDT)
Date: Mon, 17 Jun 2019 01:26:11 -0700
In-Reply-To: <20190617082613.109131-1-brendanhiggins@google.com>
Message-Id: <20190617082613.109131-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 16/18] MAINTAINERS: add entry for KUnit the unit testing
 framework
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

Add myself as maintainer of KUnit, the Linux kernel's unit testing
framework.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff9997..f3fb3fc30853e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8590,6 +8590,17 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	linux-kselftest@vger.kernel.org
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/dev-tools/kunit/
+F:	include/kunit/
+F:	kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
