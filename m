Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC65B9AED
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Sep 2019 01:52:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B835121962301;
	Fri, 20 Sep 2019 16:51:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::849; helo=mail-qt1-x849.google.com;
 envelope-from=3vf6fxq4kdiegwjsifsmnllnsxlttlqj.htrqnsz2-s0inrrqnxyx.56.twl@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CD61F202ECFBD
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 16:51:06 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id c8so10036868qtd.20
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 16:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=GL8bIr8dLG5/Kc/Y8WKLabBIaZO7WJH2uwuCEH7n76U=;
 b=CzgTCJo8a03qtDkryi8S7GqE3WBkXpTH7h8KPPyCJ/R7yPOdQC+gbMLhhZO+qiGjtk
 54sY/XHjJn4GHW/KCNJea84VmG0gPWw0E7BExnqcKWyg3Kz/ZtYTaMSh+TwGbp9qsgIk
 s7KtsGrN1A86XI0MRInVo2n83P+LNe6ZOMKostCkOJP2PnvWM3cxmYY7Tx+N2B+zejw+
 nTowY3+Pk1lGifYnmfpFWAzDCYnjgqGhu3ohRMdCvw11WlX2ydoXxkQ4zZtinpNk32nk
 /kaVxxucPBvWZLeXCPZndsCjhhXXVaNBJ+OattQtQm5izw7LOib7R5p257wQQqk2kihb
 P5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=GL8bIr8dLG5/Kc/Y8WKLabBIaZO7WJH2uwuCEH7n76U=;
 b=HraK2VQ6ldgBxu18B3f5wyfZrrbeRdQY4sZRY9yt76Cnl/MyeFAmnaTLoJ3Zo4/uwD
 af/lOZQHJ1ElOYO+nCRwvZF9GkIMIeA5VVNBPfA6AO2yIHGcMv8ecrzJCgKeTnSf3XyM
 ZeyLidoijNO49tU6T/omPobB3bLy/LxKxBvbkGWHsYQHygdumCCfEGZwdfBL+baNLoNY
 dUZ2XDphhYC38iqW7o6B+I9cQiEsG5AmOJEX8hEzbnE0gt/pxHewcyRXD21qqidiqy5X
 plo1T38nBrvJ+qezyPu2Z/6YMMMia2edGCm/SMJytVlqj4ckFlXnIClCdq/9a6hLmvhA
 uL2g==
X-Gm-Message-State: APjAAAW/XlVlBRI2JUfSbcVSR0DhUVV/CcmKBMGckrnCas7sGAi0UkW7
 pFmHfy/Icc9EuP8L6/3oQR16JIBoMxo+xm/sWUDqiw==
X-Google-Smtp-Source: APXvYqys3CVY+ZJk3HZQ+2n1DealAsHrwQI2guSNKDoKj0PZfd4ijUtGVuBrwdz736i08AAJsEhXYd5CBLACuWNBY3hfvA==
X-Received: by 2002:a65:608e:: with SMTP id t14mr17679666pgu.373.1569021628859; 
 Fri, 20 Sep 2019 16:20:28 -0700 (PDT)
Date: Fri, 20 Sep 2019 16:19:22 -0700
In-Reply-To: <20190920231923.141900-1-brendanhiggins@google.com>
Message-Id: <20190920231923.141900-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v16 18/19] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
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
 wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com,
 Iurii Zaikin <yzaikin@google.com>, jdike@addtoit.com, dan.carpenter@oracle.com,
 devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com,
 linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr,
 kunit-dev@googlegroups.com, richard@nod.at, torvalds@linux-foundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch,
 mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section,
and add Iurii as a maintainer.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Iurii Zaikin <yzaikin@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3d0d184ae4e..6663d4accd36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12983,12 +12983,14 @@ F:	Documentation/filesystems/proc.txt
 PROC SYSCTL
 M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Kees Cook <keescook@chromium.org>
+M:	Iurii Zaikin <yzaikin@google.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/proc/proc_sysctl.c
 F:	include/linux/sysctl.h
 F:	kernel/sysctl.c
+F:	kernel/sysctl-test.c
 F:	tools/testing/selftests/sysctl/
 
 PS3 NETWORK SUPPORT
-- 
2.23.0.351.gc4317032e6-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
