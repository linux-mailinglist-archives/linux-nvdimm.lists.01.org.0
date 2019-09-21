Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3150DB9B49
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Sep 2019 02:19:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 43643202EDBAB;
	Fri, 20 Sep 2019 17:22:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a4a; helo=mail-vk1-xa4a.google.com;
 envelope-from=3pwyfxq4kdiyl1oxnkxrsqqsx2qyyqvo.mywvsx47-x5nswwvs232.ab.y1q@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com
 [IPv6:2607:f8b0:4864:20::a4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 16548202EDB95
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 17:22:41 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id w1so3426746vkd.10
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 17:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=MYcfIKSKU50yEk2GBsBM2m5RiXljhL+2ZE7FFRNNMnA=;
 b=rYwL1vV9cAt6aW7K9UQ1TVv7Nis579iXiupkGlrJI5z1hBl5vWUe1ss1znAKVnTbtB
 SMKvA8N5qnF3S+ncfW7/2zlZrGFafD5oVhBy9vsu8P3mLLCWEjcjgc6EQJJEfD2JwVaP
 w7BO8yfXBiij6pLZQsbZTdY0iOqvQv5jzGk6XRZ+c8Lqf/6gYPE66QZjvcKApVeDqc0L
 ww9Sp4aoovE3lpLwl/WQ1l3THJquaMgBLszzK6JcU55vPYwK4rlvpxxUUtGGtCBaU4a8
 /DZg7vF11+JkeqazuvE5Qg3co4fNsX454Qm3YhNh7olmtf/8c974/6FV8CDzvwsuLetM
 6oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=MYcfIKSKU50yEk2GBsBM2m5RiXljhL+2ZE7FFRNNMnA=;
 b=c4durWYcTv5LJxsOzosxKTXLNc9LF3HXpDx+Z98BQyzRfvwrEUqahmeR2G4oskP1mv
 oj18dvPYwmm5vT7wBaxlKgNmbklHBZK7iuYSsBrNGlGubU6AQLSozyjDZmEDi/+I+LwW
 u3Y2zAOlU0Avte798ZW1E1kBRCblg9qCYBaMI8SEuKSLnfwN/c41jaX4Eu8NrZXNCIDH
 ZalfKKIrTlk51gtZ6oRcNzMdcwr9ZIZwulVbF+tSVAxJWAkwt8dQroLG5NHtKWi7DSlj
 VNLfmR63ZZ3lZlVRpWDF1nAUIAcHsm3Eu2U9LTJfmeIOpd/HAi2OeK3MAbBUWT2EyFOH
 ULyA==
X-Gm-Message-State: APjAAAXSOoqi/9cLb30EnuzB0TR8XJVW4vOkKAWi8SKkQsCP6RmxIvhM
 wBnGgwm+rzjEeOU2wbkGmnWesq3B8JwbjubsNaH/Bg==
X-Google-Smtp-Source: APXvYqzOx0clHQC670a6muPylspP6OHx1qxZmcK2LkXePQZnafFqCeM6G2+UolARC9Ywjom62MOYO4JFPeltIEhIgU6qyA==
X-Received: by 2002:ab0:2811:: with SMTP id w17mr3530779uap.111.1569025189180; 
 Fri, 20 Sep 2019 17:19:49 -0700 (PDT)
Date: Fri, 20 Sep 2019 17:18:52 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v17 16/19] MAINTAINERS: add entry for KUnit the unit testing
 framework
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
 richard@nod.at, torvalds@linux-foundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add myself as maintainer of KUnit, the Linux kernel's unit testing
framework.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a50e97a63bc8..e3d0d184ae4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8802,6 +8802,17 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	linux-kselftest@vger.kernel.org
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/dev-tools/kunit/
+F:	include/kunit/
+F:	lib/kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.23.0.351.gc4317032e6-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
