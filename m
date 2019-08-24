Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0215B9BA2D
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Aug 2019 03:34:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 137842194EB75;
	Fri, 23 Aug 2019 18:37:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::94a; helo=mail-ua1-x94a.google.com;
 envelope-from=3pjrgxq4kdnc4k7g63gab99bgl9hh9e7.5hfebgnq-go6bffeblml.tu.hk9@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com
 [IPv6:2607:f8b0:4864:20::94a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5D7CA20216B62
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 18:37:31 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id u24so834740uah.19
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 18:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=oSIzNOWvDyzzTQYSf3JN3pjXcKbBe8KEci8pOjVJ0rM=;
 b=nEHLmeCRlNn0vOScVKEBkHT9QuVr1Oityp0ad1fJrBgKxBJq59NmT/ZxcqBl0ysYGY
 yBt6jDjJXfbChkboOUvoU1g4lMi5JhoLzLoPtSz0B7Gl3KjaQndZoMGWZM1pwP5FqO2L
 ClAyL8t2tO6QQLf/Rdl73Zm9P1Bxdp0ClvJv9LduvM5M9mb/TnDoBVSclkO9Oi3eEhfY
 8NnIwRm6UnqLKN4t1Om7vxtkwx92uAnNdr+iweCdUyRT1FCa7j7mICsbGiVBKfN2mKGc
 xbxZey/OA2ersCb91kmL3JKIZJS7NkWS14E+JHvZ4oQi8xyQ+btxx8VHVRXqILcsnZkg
 eYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=oSIzNOWvDyzzTQYSf3JN3pjXcKbBe8KEci8pOjVJ0rM=;
 b=ZrehsBbZWBYKrhLLKqJlRVvuGf1bVhBozbbHDoqy6rAGXTTt77SVZV1sBOhFI0L86J
 41VRhaTmtDBb4aKQGkfr0VlBUIGganTXbFptBrkZ3flfDqad/uHlYhRp27zs0OLcB2oE
 ADYsmKy+HxS+BgqwtugoeFHmrUsH7UN6Pw+XYm4bMfEjxQEVLT9B0m/rpRmPgRdvLzNn
 L+LQGH8zryNGzUyesKPZhAOAhVgwP21JiUBNguSAwqgaH3X41dZmgXuK+zt6VFxwqzeE
 wWy2TK4PHg0xWbOZmq6c5qKI0nHZaUJxQbuDXT3CdiQ86sBo5+8ifZmZfLdQnfx8XRO5
 2qwg==
X-Gm-Message-State: APjAAAXbxryTWCgeCpSubnfkZ+gQCc4gBZoda7j01PAm4ONKOJgHE82R
 un/OI/K77es0VjrcOPrLDhx2TSZ8vWOT/nz9Fx5uSw==
X-Google-Smtp-Source: APXvYqxmiJDAEh/zAWwF62TCvIYIDIZRIkbCAatUA+zDm/ooJsxNG6fj5NyV/30vHftZKCTGXzwU0uEqfd5BNafZzZSuxw==
X-Received: by 2002:ac5:c4cc:: with SMTP id a12mr3950071vkl.28.1566610492442; 
 Fri, 23 Aug 2019 18:34:52 -0700 (PDT)
Date: Fri, 23 Aug 2019 18:34:13 -0700
In-Reply-To: <20190824013425.175645-1-brendanhiggins@google.com>
Message-Id: <20190824013425.175645-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190824013425.175645-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v15 06/18] kbuild: enable building KUnit
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
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 Kconfig  | 2 ++
 Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Kconfig b/Kconfig
index e10b3ee084d4..47886dbd6c2a 100644
--- a/Kconfig
+++ b/Kconfig
@@ -32,3 +32,5 @@ source "lib/Kconfig"
 source "lib/Kconfig.debug"
 
 source "Documentation/Kconfig"
+
+source "kunit/Kconfig"
diff --git a/Makefile b/Makefile
index 23cdf1f41364..3795d0a5d037 100644
--- a/Makefile
+++ b/Makefile
@@ -1005,6 +1005,8 @@ PHONY += prepare0
 ifeq ($(KBUILD_EXTMOD),)
 core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
 
+core-$(CONFIG_KUNIT) += kunit/
+
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
 		     $(net-y) $(net-m) $(libs-y) $(libs-m) $(virt-y)))
-- 
2.23.0.187.g17f5b7556c-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
