Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 436A164230
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jul 2019 09:17:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CA289212B5F13;
	Wed, 10 Jul 2019 00:17:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com;
 envelope-from=36palxq4kdjewcz8yv8231138d19916z.x97638fi-8gy37763ded.lm.9c1@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 38138212B5F10
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 00:16:59 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a20so825615pfn.19
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 00:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=/VeT4LMsGiTV0pNK4XYxpXDHYp6raL7HPeQMcvopP9E=;
 b=BlZBqRR1qRdimox75W2P/i8C72pSin2IGTFtfmWWoBCvv+dsuvBdZ3/5aEpQ89PXk2
 HuskMyBFp2JqOQVUUEK0hsAQ0kjZkM8S/FywQuU6p0ypQLPCs+6NoLDj1kq51PvEuYF5
 qrdgV1mMDoflgBNJCXAcSwSGNYJkMOXfQvDOfH0JYLVQXGZ1i6UKi+51vZvxngVYRCqi
 zUJQpdHTuvjJ6rn5moXv9JrV9XiIipdlgDqKiR4V1XRaP/xyAV9wQ3bDfUgimZ4sWrJO
 BOrrvDOkdcB9a2+X4Dl7x+F0dFrJO/wdly+nhX3UZItJ2/G7J+HtrefxGaobvJsGaO8S
 dzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=/VeT4LMsGiTV0pNK4XYxpXDHYp6raL7HPeQMcvopP9E=;
 b=kT4d09W+4CPw6dKBhsh2xMvqPRjgDr6vHef6G/QYk1DRXILUjqHggKbxf30fbYnWsC
 7uIwLUWxBzvoSb+NlggNPQAkaZsMbQCsLnGjVMS0oEVBjZbyYsjYqBQqi3aPP/Y2Bc7i
 s4BK9G3MpFae2aC/kqoctmmpcgcdjCVQPl4bbWjuDgkpi/lnAEy7ynvwng3sGveP6h/t
 DPH2dAdK/Zs/5srhBxvBzk7WF7a6sEmQ0/oesYRaEZMJb0YpmV0wXS2yvGMbP/CrFJVe
 km4L6B7lYEyVcYdGr0bvWVN9SQ2SDa9FNDCSx3Orgg3AL+42jZX82x+sk75nFBxx19bQ
 mYSw==
X-Gm-Message-State: APjAAAXamA2tt8QpXU/u11br7Dx0KZd2lS0y6dDvPqtuB6AFKm+tw3o0
 QFgM2HYnOZubCaLRUCrNPAa481sxvr8keIwV7uiB6A==
X-Google-Smtp-Source: APXvYqy3gEnvLtzenDeoBpvruwM86/d4R4MSA4rfrSkFPoe3MSdS+t35zDjs7EFvAtglaLFEtGooue6BA3jgPd6GRUh5Fg==
X-Received: by 2002:a63:d0:: with SMTP id 199mr35409907pga.85.1562743018345;
 Wed, 10 Jul 2019 00:16:58 -0700 (PDT)
Date: Wed, 10 Jul 2019 00:15:06 -0700
In-Reply-To: <20190710071508.173491-1-brendanhiggins@google.com>
Message-Id: <20190710071508.173491-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190710071508.173491-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v8 16/18] MAINTAINERS: add entry for KUnit the unit testing
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
