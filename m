Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E5147C6C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 10:27:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0190D21962301;
	Mon, 17 Jun 2019 01:27:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e4a; helo=mail-vs1-xe4a.google.com;
 envelope-from=31k4hxq4kdh8euhqgdqkljjlqvjrrjoh.frpolqx0-qyglppolvwv.34.ruj@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com
 [IPv6:2607:f8b0:4864:20::e4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5A46021295C9B
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 01:27:03 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id y70so2030223vsc.6
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 01:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=x00LgSmLKToDFMVzGBRd3p5tkepZRYMdj+2oyEasIr8=;
 b=QRuUpR7fe5b6KQBbrm5CJpf+ld0Qdmum4wKPR1jUB+VQRr9GS6e7oJ5ulOSoALkGRP
 ovpTcXb4G9btECrBBzgf45fxCMM2GXv30izjPgnZKuYLFrpwe3HXhZDQB73XVrAejJxD
 IgfII4Z9jaY8fPVzbtqxbOwVsCvGiB0RF4Mffv1td7BVKS1Kx0JJZAXyrkGkivyiYA63
 hsgbC0KTmy8G9zVu3WhXcfLq7dYt6rebWJmZYOhXohOw40uDx9fx1rlyjCam74q3M300
 OpJon9kmObZYZt7VkAjWX8Hir7yRWcNZaLM02mxdF6GX3sH1HnSt2LSrmWpaGI1AehdZ
 m5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=x00LgSmLKToDFMVzGBRd3p5tkepZRYMdj+2oyEasIr8=;
 b=NBrMD+vvHfg1H27sLVCowxVWQbd/rTo7iLCujO6wtIZK/W7llqPmPfFC59Bdw2eqcY
 INiE2GowEcipoD+1PceMa+2L3h0z0z190L7RwaXq0ZkvJ0z87ssTzlKLKJ/2LzRX9YTk
 fSKBLhigB/6kAPGDH//Zc21nL6cYl2y7OCwBL2dUsu+6HaniG3wUvOid64jr7XCW60Ke
 eeCX0vBNNMLII5N4NL3ohP8nHOdQZQmkTmR/N7hy3f0DZmBRnu5RX8lkjNfIqKqkxNLZ
 LMaqvXBrl8yivCNY5D0L5YoCz+wvhktiydUqXSjPj5vYa3ZRHaO3UpZyCtxM95UdpKgo
 kfOA==
X-Gm-Message-State: APjAAAWTO2B7z6KxgyF0oFlKM2lFPRlMRmy5sjkL6QU1wzps5Cse1diO
 ezJhfB67CK4TJyTQm/dXkAuVW0VKA38ijn1scnFvHw==
X-Google-Smtp-Source: APXvYqw0AQqNp/70EN0nmAb/HcpHOuljd/qoLNtxJ0Hn2/jd1Zqa5j+kjBpA0VFAeCRj9jxoqQZAwaaDKLUcJqXCrNqWPg==
X-Received: by 2002:a67:6d44:: with SMTP id i65mr58904024vsc.106.1560760022147; 
 Mon, 17 Jun 2019 01:27:02 -0700 (PDT)
Date: Mon, 17 Jun 2019 01:26:01 -0700
In-Reply-To: <20190617082613.109131-1-brendanhiggins@google.com>
Message-Id: <20190617082613.109131-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 06/18] kbuild: enable building KUnit
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
index b81e172612507..4b544a8eebee4 100644
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
