Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC308CB0C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Aug 2019 07:52:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E3BA6213751C4;
	Tue, 13 Aug 2019 22:55:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e49; helo=mail-vs1-xe49.google.com;
 envelope-from=3tqftxq4kddkwmziyvicdbbdinbjjbgz.xjhgdips-iqydhhgdnon.vw.jmb@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com
 [IPv6:2607:f8b0:4864:20::e49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6AFB92131EC70
 for <linux-nvdimm@lists.01.org>; Tue, 13 Aug 2019 22:55:03 -0700 (PDT)
Received: by mail-vs1-xe49.google.com with SMTP id h3so29805690vsr.15
 for <linux-nvdimm@lists.01.org>; Tue, 13 Aug 2019 22:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=T94Ldr45BAcQvYAvJ8Y+rDntZ4kBO4X+NPr7Ifz4Qao=;
 b=mrsDShuTPkFleL/bpmmXLkqRWbGmCMe8eWyPKi8hXeRHkfVigWiAfCHpwD0hVSNcQQ
 S8nAwpSJBRDPldfYj4A7LBO4UErIGmgWKtbD3fPOSJ8H7nCd/iPxnlPTIuqisNCKz6dC
 xsqwzZjYKmcmc7B92vl/XvFCGelMiL6GF0SuWlPPsM5ByxumhuWkotPV9MRNYd9m6gmA
 41b1pgks2iQXJT5XNQ0LJ/qDuqTcu/TBD1bxU5cZhhvfdMVwqslpNg4GK4pDZxQJclKo
 YFYUxYFw4pCByCAxMdSAVqLOIIhMW50yvVPgkfJcvVzsEdWGh/78tRjbxOIRrK9JqJzG
 JBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=T94Ldr45BAcQvYAvJ8Y+rDntZ4kBO4X+NPr7Ifz4Qao=;
 b=hekTNlZ/mzP/laI3oq5LAnO5sUGcR6AbqoQphh3AgICyr/Cb9wgMXsdjTkZfEbPQFt
 ZPumZgETOZ7GiDw0kbRH7FKkwZGjSG9nwYY3TnNqVDj3e6UFoRBGx0Tbz+wKPW7XwBa2
 qBsj1+XJEpc2ktaYgK6i0y1tVrIaNz5eH1/n2ZtTbpedMBgPGx6nRVvhC5S1Ivx9gpDl
 nXTPB0VHn1ZiXYyqNt9AKBzcpZ4eYjBmNPNgwElh6pwAHkx3tHcMvbehEFkgLBHIIaRx
 GWCy/tV92ZCAbiWuG33+rw0+z81ssCUNILE3TmS+Nn6jbGUm0fZiC6icQfnwOvilTtSY
 bhxQ==
X-Gm-Message-State: APjAAAVZqiG3m9l/WesEmSDrUh4islzsNkFkHhP5WmevkuSx+bIz87WQ
 whcGoCHVZlqp/YEBxjO73Kh+Px48ORbj/l+uyuTAjQ==
X-Google-Smtp-Source: APXvYqwhfu0AdithZ3Dc34TPp6G9Q7271SINMDP2+L5uhJIlb8Si5QLWNAsthlY+87s1BKFjJAj5DJ6UsNfmB4wPi8P2YA==
X-Received: by 2002:ac5:c4cc:: with SMTP id a12mr18276120vkl.28.1565761974094; 
 Tue, 13 Aug 2019 22:52:54 -0700 (PDT)
Date: Tue, 13 Aug 2019 22:51:06 -0700
In-Reply-To: <20190814055108.214253-1-brendanhiggins@google.com>
Message-Id: <20190814055108.214253-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190814055108.214253-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v13 16/18] MAINTAINERS: add entry for KUnit the unit testing
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
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a2c343ee3b2ca..f0bd77e8a8a2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8799,6 +8799,17 @@ S:	Maintained
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
2.23.0.rc1.153.gdeed80330f-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
