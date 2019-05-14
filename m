Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD77A1C21A
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 07:44:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BEBB8212746F3;
	Mon, 13 May 2019 22:44:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com;
 envelope-from=3rvxaxa4kdk4pfsbrobvwuuwbguccuzs.qcazwbil-bjrwaazwghg.op.cfu@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3D2BA212746E2
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 22:44:14 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id 94so9917025plc.19
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 22:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=hN9qf7+RrypIPHqUONQZmMGddOrdEANVDvigURbu6dA=;
 b=qpNcWD3Y0kl9+eBKEvbxHFNU7HSbifNewSYRx7Bf6o8l7Ke6/csSYyO5zv2WxAMwCw
 1clrx6usnqE/8tMeKdicTsHMdxaZhGE855zAfB2p5ktCxpqm1UvjHy6jbopoVHrKXTJu
 7XToK69m2OAEcktEp/sBKtsjQNLSLcqQn8GVwbQygY2DUZPUX/dOS5KbgqmQtNUtZYCp
 wrnJaamR7NoH4ePJwr456aJvpPNQSuIxVgAj7VigLO+2F4t6B5mXO5pvBmfaC8rN7V+L
 Ao7V5ERz7Y4bh1lVVQIOh9Hgtblw6vSKRA0X1/2C5pRc1A4nWNmmsMlR061f9/7kgHWi
 mU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=hN9qf7+RrypIPHqUONQZmMGddOrdEANVDvigURbu6dA=;
 b=uk1UZ/3mafO0g+nYfrrSkNBDVYXjW18wpaT1XTyZhzS7MlAMVgQY4U+RVxPTlhIfJn
 l1ndG9Kkr9CVD/EMvc5visVSUc0ayqXuFbv9ppmQysHlJsYbUyjJww1El0lNMdQgqWof
 sAxmK4vRWzpB7Hh8lwnY+FRU963h2/SkViV4O0q+mGPYhKxDEtkLyCAkngzlTZcNWL/A
 7oXTdmVujCOCXy20jdxSBESbW/+XzEkrn+5X3MAtEQ5NU4VlGB2roj8uNh2ZcSTRv4mq
 TUxk7h2OaLx/GrBl2yqSffHF4zeUSveD5Yi8ZGLK5jHm1Hg9iRZItZxIZuVxbU3Nj6l3
 KmJA==
X-Gm-Message-State: APjAAAXpkaCsbT+4+Mgs9140Qz5TOccMF/07ob1Zjm6R5b3ca0pRdWkn
 l0s6sGT7HLeSbFgC1AF/TZe0bL00+vq3Fv/M/XudEw==
X-Google-Smtp-Source: APXvYqypLujpnV/Vdl1pYHMXICHGFoX6Lv2fPwDbCH6fHgKJkPC2sx/Vc0HPXqG6cBw7dhDlnlPRD7bdIYYvS4bGxpiVHg==
X-Received: by 2002:a63:8741:: with SMTP id i62mr35837456pge.313.1557812653206; 
 Mon, 13 May 2019 22:44:13 -0700 (PDT)
Date: Mon, 13 May 2019 22:42:39 -0700
In-Reply-To: <20190514054251.186196-1-brendanhiggins@google.com>
Message-Id: <20190514054251.186196-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514054251.186196-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v3 06/18] kbuild: enable building KUnit
From: Brendan Higgins <brendanhiggins@google.com>
To: frowand.list@gmail.com, gregkh@linuxfoundation.org, keescook@google.com, 
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org, 
 sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu, 
 yamada.masahiro@socionext.com
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

Add KUnit to root Kconfig and Makefile allowing it to actually be built.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
Changes Since Last Revision:
 - Masahiro reported a number of issues here on the previous revision;
   however, all of the changes actually needed to happen on earlier or
   later patches.
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
index 26c92f892d24b..2ea87a8fe770d 100644
--- a/Makefile
+++ b/Makefile
@@ -969,7 +969,7 @@ endif
 PHONY += prepare0
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/ kunit/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
-- 
2.21.0.1020.gf2820cf01a-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
