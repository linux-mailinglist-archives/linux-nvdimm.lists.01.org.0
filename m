Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D6630A9
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Jul 2019 08:34:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6686F212AD59B;
	Mon,  8 Jul 2019 23:34:06 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e4a; helo=mail-vs1-xe4a.google.com;
 envelope-from=3wzukxq4kdeyjzmvlivpqooqv0owwotm.kwutqv25-v3lquutq010.89.wzo@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com
 [IPv6:2607:f8b0:4864:20::e4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 33CA521290DC5
 for <linux-nvdimm@lists.01.org>; Mon,  8 Jul 2019 23:34:05 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id b23so2399859vsl.20
 for <linux-nvdimm@lists.01.org>; Mon, 08 Jul 2019 23:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=xqyprLFtmsoy8kXd9YLO/VFwieDqS65MPOOJ9C+cs/4=;
 b=BV0dE8SvbznNengE0ZbiFjAkJDhECZRlV6y0anjBwPZPZ1QJAxXC1g/NWLJmkwh2dQ
 ymUxDZfk5Xo5TuLgPcbXMU1zelBpG5lRvdeCkasNl4X/Vnt9x4r1W8pPWC4/g+lUwaKi
 8JU4Z1wA6vTfOZEjHhdR9Mlf+yIQ7pF/76uNwAV9V52L6+GkfjA6GEFVHibZRCvNE6a8
 Fu4VfyO8IzEKX7M6CI/FgWBxODziZFM48h2BxhCVoZ3/hlGN10lCqjL51sWnlSnDcy2T
 mBdvBHfYXaqHr68JZPdHCE3Q2egJ+2F4FMM5YKC+b5EV9OgFhj4bqtOQ/+4RJplYTmiD
 NT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=xqyprLFtmsoy8kXd9YLO/VFwieDqS65MPOOJ9C+cs/4=;
 b=euiBTF1Mgw9a28ZKLJeWjX+FPDqBwSEWFkHXfOLsVcuqHFa6njNby/DgXNlJFNX0ch
 5zukYUuSLLoHURkr3wznCDBZ/xzlO7KRfRKol43o/CmM201x2LK0p7KOF0EcDA2ukdkY
 UwJnb/6fIeQg8sgHXa0M2wQAahlgKsBU7/R2NIicmIDLTNbfaqHiHFfUIkj+1iZtY1R5
 q/uk0uuVCyuZiZhkFvevZhut21HqlmNimJTeIE2blL5jaY1XELoVzO8AmvoF9VQvlGu+
 MuNdgXZX87nID6uPRyUVIGsjxkafnYGRd/+AKOSF99fhhe8fyKr0coqtmvRFAywbFJoI
 iSzA==
X-Gm-Message-State: APjAAAXvA4FmpwUWI2eLdPV45oeCLOxFRPgYeeT1kk0Tc0RVl4zl5d4N
 XcXZwt4F3viMsXdF6aU6MOVDG02p8fCLuglY82JrEw==
X-Google-Smtp-Source: APXvYqwNJiHBkRfCSkqsV5H5ZuEZsj6nanDgGNZ3VAmzTo0fg8lJCoDeNDmY/ozNQHmnZsAUL9Mc41SFcAh6mWnqjC3NSQ==
X-Received: by 2002:ab0:20d8:: with SMTP id z24mr4416164ual.1.1562654043545;
 Mon, 08 Jul 2019 23:34:03 -0700 (PDT)
Date: Mon,  8 Jul 2019 23:30:11 -0700
In-Reply-To: <20190709063023.251446-1-brendanhiggins@google.com>
Message-Id: <20190709063023.251446-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v7 06/18] kbuild: enable building KUnit
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
index 3e4868a6498b2..60cf4f0813e0d 100644
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
