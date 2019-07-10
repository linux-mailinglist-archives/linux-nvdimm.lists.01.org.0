Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6931F641FD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jul 2019 09:16:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1BC7D212B5EF4;
	Wed, 10 Jul 2019 00:16:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com;
 envelope-from=3vjalxq4kdgmcsfoeboijhhjothpphmf.dpnmjovy-owejnnmjtut.bc.psh@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 33DAD212AF0CE
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 00:16:13 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id t19so921801pgh.6
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 00:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=iuxOaaMz6/nuHb4KDKomfiTWkThnS6wenM774buKrcs=;
 b=swqomuh58V+Sg//U5cqY4Rh1tAi5bpvhwwunna8PvZbQacehjqw+jiBLjywU0PbaV9
 EpODX3G17IiD5mmqty6Ua7/wUUbyRya6LeMviTjJAwbg/+76UIMSyvVrzPVSUJ2WEY6n
 7lKwDj5zpEYSoIULXjTR+oBBCZfl1dvR7J33Y2miUOUDO2Sy18EJCy+VItMzFFxQAIdY
 /T4mQvRlNaRhUjVLmQuSsEc2qgj1X526Ie3m5Fj/WHcsnej2NpsOOSsTm8U1rai+iQqu
 RmvsSm+44+WEG138VYE5wa2mwKza4bSKWLX0erx0LKL6ndVzLZQYCX9qJk+XOClYHS4x
 pMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=iuxOaaMz6/nuHb4KDKomfiTWkThnS6wenM774buKrcs=;
 b=WI8qdwZBpacjovFK3pkrjTdmck8YvwZwfbM0kTM/o+tqp84HsoBjnZJ2A4+0Z97ciI
 dy859wCss40T8tqg987MArPq+1EN+F1IlaKWsljaebuvsNOGl1rt22NFWLj9brBZCts5
 rSsqbXhezGjS7wnxJ2H5EkcePIdTrMyc7GVy34Cn6P63jFihRGRGgiCE6pnpkuI0nUCi
 3Bpj2sEujM8fPKHNLwHqhRmzs8mxPqbf0bAOKMAo/cb9rQRHpTfAVhYTr7BZ5IMtSqU1
 qgyS78dnJt6EYNmwe+0fVXENCk9zf3otWHaeF2eOyOeruaqynUO2dyYx3exGTN5DnuTp
 8L7w==
X-Gm-Message-State: APjAAAW2PTR7EZZaZXRJ1LNFNjmMFQepeoK4VX3OhyTu/DPvSMRpzyKu
 a8H20oqIy4ZIcCcgTqRjfryOMfc8Q7qMFdxBWKAGSA==
X-Google-Smtp-Source: APXvYqwvKVOfsz0NTC0mYXChGLM55lyRHym2AQRa0cKt8qzoul87EQvweiisK/9Kb7Yw/xDtn57GMjoaeQBD5oomo5boFg==
X-Received: by 2002:a63:c442:: with SMTP id m2mr22869503pgg.286.1562742972197; 
 Wed, 10 Jul 2019 00:16:12 -0700 (PDT)
Date: Wed, 10 Jul 2019 00:14:56 -0700
In-Reply-To: <20190710071508.173491-1-brendanhiggins@google.com>
Message-Id: <20190710071508.173491-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190710071508.173491-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v8 06/18] kbuild: enable building KUnit
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
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
