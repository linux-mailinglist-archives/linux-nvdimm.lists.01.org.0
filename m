Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC936A525
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Jul 2019 11:43:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7C652212BC465;
	Tue, 16 Jul 2019 02:45:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::84a; helo=mail-qt1-x84a.google.com;
 envelope-from=3pzwtxq4kdbw3j6f52f9a88afk8gg8d6.4gedafmp-fn5aeedaklk.st.gj8@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D95AF212AF0B2
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 02:45:55 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id p34so17526116qtp.1
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ZxnEgoL+cAyfHeVT/PTT350Q+1yvdmLsRRNYnQGVvxQ=;
 b=agf+GEiYnsYgxKD+eX5Zr5iEIqArx1Ez38XIbM2zUwF+jCw6OW0eiE0IgwfAqlYXox
 CAlVrX0S8SSRU55Z1c2rRDq12LD77C9G+XVjbkBrq+fkTqHfsXI0imV9hRWG2ZvAS90m
 2c2uu0Q5uOb5hjdGFavlWbaLRn7upGPzUKOzK02UL9T78K8BX3ChJODaDGUQANK3tPoP
 aanOhJtLspMRoBYoEfxxmcWUNqIwsdubLyUHNMtGnlY+Dn7tSIfvpJ5APdl+8eBRmxio
 MMVAlOANOtJkxj5KLwb8vlKV1dJwolhgVqeUMfvFcmaoCLbrxapgKv6CSKy5nEgrqNu4
 rBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ZxnEgoL+cAyfHeVT/PTT350Q+1yvdmLsRRNYnQGVvxQ=;
 b=DQAiKNCxAfBna/oQBaI9X9At62dogUigGJUHECnRqIHXMfYXBVWEKCtUkxdqBFzoRW
 Au4d3D8KzUUH21JgCLP32OHvR+UCt0JOATBZ+MLNlUqDsfR57Y6jZWtH3tZRPSeAb8yk
 Jc2z+03OkT5ijs5uTnXXxxoOxpxKXibGiiuWLKXfBWOGwDCIx74+HCFMYg0mqGaNxtnd
 NVXYpvU/JzT+3H5us/RAq86nLf+Rh5xjEgydvmk+e68W6sRMC0LcZSrKM2/G/KdWmH/n
 535XHEWN4/DyaLKoSP9Mg7TdwFWdmp0Qug4enq70ZZlqtqNXTufbZiMUq2xuy8WmsX4g
 mRUA==
X-Gm-Message-State: APjAAAU2nF4rmV1VstI8DxARmJIVE3YYNDU0kPHDvFBEMT6hzQAElXiO
 jy+2D6dkYZ5lwI7ya+FqyYIpd8pTOfkMkePPwhpKDw==
X-Google-Smtp-Source: APXvYqzMr4UyHcoIfs203SmG1cldh3k+yn6h1nFlHx/9asdbVsmVxWorXsh8GDjT9ds0pMy9e7bEiUsj6ezLI7PPblj01Q==
X-Received: by 2002:a37:4b46:: with SMTP id y67mr20389260qka.66.1563270205950; 
 Tue, 16 Jul 2019 02:43:25 -0700 (PDT)
Date: Tue, 16 Jul 2019 02:42:50 -0700
In-Reply-To: <20190716094302.180360-1-brendanhiggins@google.com>
Message-Id: <20190716094302.180360-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190716094302.180360-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v10 06/18] kbuild: enable building KUnit
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
2.22.0.510.g264f2c817a-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
