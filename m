Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688A7B9ADC
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Sep 2019 01:46:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 02AF521962301;
	Fri, 20 Sep 2019 16:45:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::d4a; helo=mail-io1-xd4a.google.com;
 envelope-from=3m16fxq4kdga9pclb8lfgeeglqemmejc.amkjglsv-ltbgkkjgqrq.yz.mpe@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com
 [IPv6:2607:f8b0:4864:20::d4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C3A8E202ECFBC
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 16:45:27 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id t11so13048720ioc.13
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 16:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=iAt6nbLOTb6MSd0OQpor+vgL4LVt0KITsii11UOE388=;
 b=AYjtMTJ/bM129CXuepq5nEai9unWmuv9KrBsNEIaNyPvQ4Lt9h0LEysSES4HAewjdy
 29QdHAI+HmjwUpZpOFfp+65UA1AXawPyQBrV9eC7bzwv+iTdkaID8+C2RbUTQ424wFXU
 ikBwbFbcoWCNie+/3MBIfmo5PilLysY1O2sVT4F+CzBPblIy6HgcB1k/q+DaLNKLnOPG
 KGhX19FC/G+6Iq+SUJYyTo1TyMfAp7OPjYNGjrMoMDGT8Lcrz3+Do8Yd4VbmfMqldrGC
 31xONjlg/4CyE/OtZ+d8kznbXo+3NUSFplR4NcCXIsv/+7PDrkmrSqkTzl+KSxrv6PXb
 yRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=iAt6nbLOTb6MSd0OQpor+vgL4LVt0KITsii11UOE388=;
 b=AKud2K+/pjFkXkR31WogWtQSYQfUyzCw215PqjUgTwVABnP6Cr6dgr77AjV1iyKTpH
 nO5wzL1OmxSHY3RlI87SS8yO8+W0jvlcMkWIbocM0T5Lq8ZoA7bQYzGd4gJu3DWtRvd7
 aYFYsW8WYSXlsriz0JW3lRc91S+pKHZNZ1RVyLP4my59vXPZJ8BqEgRbswMADBMX51/U
 NGyeIfWv0J28clj/SMRzziNAZO++FWyxJUwaPN0yfHNftfcOGgOevLi4E7z/sShQ0FF4
 vzpitnSHt4hI4UIO07f6KrTCksdxUSWjMRp5Yjxk5DrP6vdJBIYeBxtvxyV2LR3hKTXV
 YqEQ==
X-Gm-Message-State: APjAAAWKL+sQDx1DrEVllyPWoKLXMST3ffhP5B89Zg34tCsUTRa2TpjQ
 G2zFzLC19yY6yk4ww6bukdadITidDPH7zGivcKR88Q==
X-Google-Smtp-Source: APXvYqwvNWfMwXT5OHmC0FOVMC3AvIVvQINgZf/DTvElVJK0vl4Su5PZQX9OXJ1XdFr+Yzg+uGF0Z+1UbeiJPCoJbgdZWw==
X-Received: by 2002:a65:4145:: with SMTP id x5mr4101853pgp.259.1569021595251; 
 Fri, 20 Sep 2019 16:19:55 -0700 (PDT)
Date: Fri, 20 Sep 2019 16:19:10 -0700
In-Reply-To: <20190920231923.141900-1-brendanhiggins@google.com>
Message-Id: <20190920231923.141900-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v16 06/19] lib: enable building KUnit in lib/
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
 Kees Cook <keescook@chromium.org>, linux-kbuild@vger.kernel.org,
 Tim.Bird@sony.com, linux-um@lists.infradead.org, rostedt@goodmis.org,
 julia.lawall@lip6.fr, kunit-dev@googlegroups.com, richard@nod.at,
 torvalds@linux-foundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

KUnit is a new unit testing framework for the kernel and when used is
built into the kernel as a part of it. Add KUnit to the lib Kconfig and
Makefile to allow it to be actually built.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.debug | 2 ++
 lib/Makefile      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5960e2980a8a..5870fbe11e9b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2144,4 +2144,6 @@ config IO_STRICT_DEVMEM
 
 source "arch/$(SRCARCH)/Kconfig.debug"
 
+source "lib/kunit/Kconfig"
+
 endmenu # Kernel hacking
diff --git a/lib/Makefile b/lib/Makefile
index 29c02a924973..67e79d3724ed 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -96,6 +96,8 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
+obj-$(CONFIG_KUNIT) += kunit/
+
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
 CFLAGS_kobject_uevent.o += -DDEBUG
-- 
2.23.0.351.gc4317032e6-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
