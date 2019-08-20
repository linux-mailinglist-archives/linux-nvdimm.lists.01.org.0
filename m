Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CBA96D16
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 01:21:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2214421959CB2;
	Tue, 20 Aug 2019 16:22:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com;
 envelope-from=3zybcxq4kdmgp5s1ro1vwuuw16u22uzs.q20zw18b-19rw00zw676.ef.25u@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 541E820212C85
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 16:22:26 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id c9so175869pgm.18
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=XDtrvkw0RFhKlN+LitTFqDIh4jTE9hk9LUw2Z5/BXjo=;
 b=GfB79yRsARKNmez787qOELsZmZ3ww5c5KdNG+MLM0ZkalMFVMmzyjPSn7wZeKhOphO
 BJWZzy7YmkXN9/UgkFTtef1jj4+FlXlngojqX89H7vuOPC0dYVsNdB9owDKZLENOO6L5
 mxaSuOLfjrFzQEiAZ9YZ1XMnJWlLFr+j5jaqMZyZSETAJxRVYZ3vcpGhrvvLt0+24Fkg
 GZ+bfBrp0EHb5FcC7VXGQ67bGympCSJmn5xE411lPMKlT0PWqRWUEwUdiREWT5Re1UX4
 RFh+MSnWSjrJ6WwkjZADkd8PAGH3yovb64iBwHH4kCoaMcvhoh9Vu+pgfCSgkklmMJmE
 GyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=XDtrvkw0RFhKlN+LitTFqDIh4jTE9hk9LUw2Z5/BXjo=;
 b=dtonzUTpKGcC4pKAB2Co2CLi/aTwhmU7huA9oOxLrvhVxpDyGx8bxikGJbGNT69pTY
 amsz4t9DQ5h4Y4iKaDqINk7X8cdzJZSforc0A1nYWxTQ3COq9JyGqmCbAN7Jjk97iSLW
 ZMSfpJuhTj46rnqOGmzGoTvB9PWeiRxA1bljKnN8o9cEyxL1D9bnEqz8SuqMtQj7wEP6
 1T7bjIL9k3BvwdveXSQr2f4MUXM5a4pGGoNbsFHI1bkojKofskvoXzoqjyXUJAVeSCyM
 OD3qYsMwqUNei6WLx9uZSahqgzXcvmeQ2N4UqHQBSlpaVuv2/+Oz3Ahj45F4COni8gLU
 C0uA==
X-Gm-Message-State: APjAAAUolsWz7fyjrJSdg2Jar1Krpt5HI0KjSwXqSckyyLKUd2vd1fdD
 12Os3MtrM1zKf/KonobE5wzTRDkkBs40+3YxRq4Rng==
X-Google-Smtp-Source: APXvYqwnRfaDdNNQbwqYi1sBE/pq+1Vm1Sa6tTF8ExzVh/t1i5vgUriUWM0c3aCP4jWc1mxnMQ3Gtejv3fCq1fQ0LkUxoA==
X-Received: by 2002:a63:460d:: with SMTP id t13mr26021274pga.205.1566343269803; 
 Tue, 20 Aug 2019 16:21:09 -0700 (PDT)
Date: Tue, 20 Aug 2019 16:20:34 -0700
In-Reply-To: <20190820232046.50175-1-brendanhiggins@google.com>
Message-Id: <20190820232046.50175-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190820232046.50175-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v14 06/18] kbuild: enable building KUnit
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
index e10b3ee084d4d..47886dbd6c2a6 100644
--- a/Kconfig
+++ b/Kconfig
@@ -32,3 +32,5 @@ source "lib/Kconfig"
 source "lib/Kconfig.debug"
 
 source "Documentation/Kconfig"
+
+source "kunit/Kconfig"
diff --git a/Makefile b/Makefile
index 23cdf1f413646..3795d0a5d0376 100644
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
2.23.0.rc1.153.gdeed80330f-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
