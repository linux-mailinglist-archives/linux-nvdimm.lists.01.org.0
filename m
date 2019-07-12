Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D371A668A9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Jul 2019 10:18:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C920B212B9A6D;
	Fri, 12 Jul 2019 01:21:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::84a; helo=mail-qt1-x84a.google.com;
 envelope-from=3xeioxq4kdheqgtcspcwxvvxchvddvat.rdbaxcjm-cksxbbaxhih.pq.dgv@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 646BF212B7D9B
 for <linux-nvdimm@lists.01.org>; Fri, 12 Jul 2019 01:21:04 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e39so6310393qte.8
 for <linux-nvdimm@lists.01.org>; Fri, 12 Jul 2019 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=/VeT4LMsGiTV0pNK4XYxpXDHYp6raL7HPeQMcvopP9E=;
 b=qreLyDZjzSLoWfpDHCemqbAq4PXoCjzSqYvbTxAd3kFq3wcUyd+boew/WgT3T7RHKf
 9DHlYVSAqLvipRWptlYWn4421M2Xu79CzGuk0KbMBlm1rUNK/LznjqA5jW0KnQrmPC1/
 ZdvaHVQI+zq7HWPn4JYjZ3UxDWONOm9Fg1U4Ecy32VB7daAIzd0UYNo8Igah97TpODMo
 MVXHkHxO9A/C5JuWACVZ2C+c1BoQti5W6xYr4Ma7OZ7F6w0tbitEV7BrH7wkYWA0AS6z
 P4gr0KTVRKLs4lFGYERkJWYY15XOw3BkYa4JdcPBUKCPwG5pDxM1xMCqK+sWqXrnX2Nl
 h1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=/VeT4LMsGiTV0pNK4XYxpXDHYp6raL7HPeQMcvopP9E=;
 b=Kg3l2UjhLT8rrw1cLI504Wyo72DBmqmdfsFApaHqQmLJG+aPPwHX43wazU7a+zr1oZ
 rLJ/IYVCfdiMwr+VmdwbyABscDqwR6ZvBf0iUF2pD15LzZjHheAnzLE61mtDtfyFENGY
 Fr/g1M4ryVf31Q02z6JZTu+hDkAdqtecNrRWjObxhrwH3QvoZXRYkKxkb2K3BOQSlJDa
 ObvFeleq3C9N/6mY+1VmNTaw4VJEFFwf3sg/dSpuXo5Zh21bWBHQHwTzTgSr6JmyS+HM
 kcOb3X+0qBPhN1DKifd3VMtejq3hAMc52g0BU/eCkkVqQ8paDfvbCM+q0gYcBhe1uqzT
 V9+w==
X-Gm-Message-State: APjAAAVd4b/aSMlF4T96I4YbZaNFqpqb2W1lNiCdkkiW8lNAZfwkFkSI
 V9K5TOpv6CZgnqcY959cE6j5lZbkQ3Kj2doMItk8nQ==
X-Google-Smtp-Source: APXvYqx3AxPNySvREBXGAkzPq2NP7j575Vhr0oMdi/29YJtnWUzDE5tk9+TI4/b/ozPiwUtBDdK31OQO693qoPZNoLH1jQ==
X-Received: by 2002:ac8:849:: with SMTP id x9mr5356269qth.16.1562919516598;
 Fri, 12 Jul 2019 01:18:36 -0700 (PDT)
Date: Fri, 12 Jul 2019 01:17:42 -0700
In-Reply-To: <20190712081744.87097-1-brendanhiggins@google.com>
Message-Id: <20190712081744.87097-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 16/18] MAINTAINERS: add entry for KUnit the unit testing
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
 richard@nod.at, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add myself as maintainer of KUnit, the Linux kernel's unit testing
framework.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 677ef41cb012c..48d04d180a988 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8599,6 +8599,17 @@ S:	Maintained
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
+F:	kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
