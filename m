Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 842026B3A7
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Jul 2019 03:56:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1CD78212BF569;
	Tue, 16 Jul 2019 18:58:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com;
 envelope-from=3oyauxq4kdoifvirherlmkkmrwksskpi.gsqpmryb-rzhmqqpmwxw.ef.svk@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 878D3212BF556
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 18:58:38 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id u1so13715296pgr.13
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 18:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ZxnEgoL+cAyfHeVT/PTT350Q+1yvdmLsRRNYnQGVvxQ=;
 b=anmcre763jqYfgk0jWG0amSJjr9xJDchU7aCLTMoA7GWTjnXP43elmKF15Bo6z8jT/
 uSdYJORRrIzHzGZUbqnAbFwRKeFJDrWfiw0+1PMnDT6HXctOw3e70AmsBr86zxdtYfSF
 9QjexNnudSykx+gILjsNgF/Izk1Qd8cYoWCnqxAFQZkhT4rceTgpbKV8nPdU7wapAdRi
 hbcyVdfr+6dA554hVrDR7CH/dYVdpdsHvTXr12IEodevpJMzgKPwR62HOJtcZbsFshbz
 4nNBdIsyoQPIZCFxFyp3Hb3/XaXqHo2KdfXbEpGJ/wTbzl09x42ZZcaPUlA1B0bBeqvO
 Hw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ZxnEgoL+cAyfHeVT/PTT350Q+1yvdmLsRRNYnQGVvxQ=;
 b=JXevmdqpVA0hA82u0aQcYmcaZ6nSnlxv0ZjyWgGAi42tGZlPoGOll6BwQEbcyJBd4d
 bMWoArIzT9lyKK7aCuLlBX0ixy8zmu7Cq/f42Qv4+2Oqc0W5DEOaRmo9BzI+a0nzKFnY
 XsDxOiNmLunLCZOrgWof9+8I2rt66ekao4W1b0JCKacE21smwh1/bb8WgrJXqCWqw20z
 gWK0I9Fr7Ac5NJZmP2aHj2aD8PXv5k3bTsj+3dUFpm5MRj8jqd7dhb/FgsjlN0Hp6+mx
 KKQMYP4Lu3zDULnys8uW+B8seWzkfjf8hYuAHoOO0FPIAstTbXDBHKhCWCnEt0XeKFqc
 mFDA==
X-Gm-Message-State: APjAAAVscFMeKOzVgAf2awlmSeuPxpxEx2ueMeDXx1W8mx6bXT+oX9dd
 7LwYwGqF8d+Kwv91X+3XAoDJi8JLXKxTP6ORSR5b3w==
X-Google-Smtp-Source: APXvYqzdOd/pnZZFL/pS6/iieMJ7feNcywGmwm2i67xQ+rYX0bj48kl8BcSe4yfiKEhFGYAbbZpECxiAzIcb05C1kfs0DA==
X-Received: by 2002:a63:fc52:: with SMTP id r18mr37450939pgk.378.1563328569459; 
 Tue, 16 Jul 2019 18:56:09 -0700 (PDT)
Date: Tue, 16 Jul 2019 18:55:31 -0700
In-Reply-To: <20190717015543.152251-1-brendanhiggins@google.com>
Message-Id: <20190717015543.152251-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190717015543.152251-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v11 06/18] kbuild: enable building KUnit
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
