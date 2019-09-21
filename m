Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AED1B9B14
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Sep 2019 02:19:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 488C82194EB7C;
	Fri, 20 Sep 2019 17:22:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::749; helo=mail-qk1-x749.google.com;
 envelope-from=3iwyfxq4kdgojzmvlivpqooqvaowwotm.kwutqvcf-vdlquutqaba.ij.wzo@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com
 [IPv6:2607:f8b0:4864:20::749])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3F79E202ECFDC
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 17:22:13 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id g62so10162197qkb.20
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 17:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=XOGsKwy33nriWO2piNArgCsTjyMNHJTJvDyvFgo5s6U=;
 b=Sgz7213+qbN86RpnjYxwE7eAvRTa0YN6r1fXC9nQwi+bQLfmJ0RS4WpN0N81z/odi6
 XGU7gCUSbBUdgle5NaqiHXybHGODmoKDWh/0HAkn64T1Co7SCCYmXUpCIrrnRh6Jb2Ll
 XjhlpTMqtnLolZQwP4aDBcCgL59XhMxAa5lJCd2J1Bs9Ujfs0mesiC80xjKZ798sbyV+
 vVOclVVTpXfND0vcjZ+oQRPMBJniMNy5trFLGfHLvvfXmpzxMSeWVg1bhaD800YWS3Zv
 cO7oaTS4ubnNeNZIACnRD79K40w8Hjvmr0YhQlHzIcQKEkRRSV52zVfDjQ/PSTjPN9NX
 xkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=XOGsKwy33nriWO2piNArgCsTjyMNHJTJvDyvFgo5s6U=;
 b=od0B56tAO2QsH8WFIbums5BjNXcUIAUHLJuNR/zRnuLwgPWL56QC0thTA+4Jq2zJZl
 okNwk29P6DhU4s0u1N/I3ZywPfTHx7Hx1BtDS3NrUAtKiml9VByqJ4zkmpmOgO5aAuWr
 hFita4ktbu+0vvWEqfALP20ZhOpztDSRotpILM+KVXnFq0KnSN3K4adfJa+96qmsjfOl
 fCdJsRk40AcfQ5QHbu+SEAOx4rdBH4QTVfNKEu3wRGyZTL47REMj+WFAJTazqhZx+K7r
 rhTJiwlp2tVAK5yObuT8DTQuRJXsQwCHX4XTio3baixFjPybdBWvg0GpG2/TMBcL0k2z
 WW5w==
X-Gm-Message-State: APjAAAVi53uPPD7Tqk7AxXZYV7UeI8KO0ikB0cbDHUkdGgl+OjJIX9T+
 dyUL46OQoWCFPvNxn4aR8ZDAb1I6xo3PEljC2rIWHA==
X-Google-Smtp-Source: APXvYqyhYc2gzw2zw7hNHJ45JP5rJlx8noEcdat85g5q14wTmwmkyJ6JmxX9AzFR4w2ah2LgF306gHYAybhUcuUrVrOySQ==
X-Received: by 2002:a0c:9792:: with SMTP id l18mr12691255qvd.79.1569025161226; 
 Fri, 20 Sep 2019 17:19:21 -0700 (PDT)
Date: Fri, 20 Sep 2019 17:18:42 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v17 06/19] lib: enable building KUnit in lib/
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
index 5960e2980a8a..1c69640e712f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1681,6 +1681,8 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 	  See Documentation/debugging-via-ohci1394.txt for more information.
 
+source "lib/kunit/Kconfig"
+
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
 	def_bool y
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
