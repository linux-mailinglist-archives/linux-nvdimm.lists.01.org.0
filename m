Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9029BA4C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Aug 2019 03:35:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2FCB520218C24;
	Fri, 23 Aug 2019 18:38:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com;
 envelope-from=3wzrgxq4kdpqxnajzwjdeccejockkcha.ykihejqt-jrzeiiheopo.wx.knc@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8FBCA20218C20
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 18:37:59 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id k9so6860016pls.13
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 18:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=Q7v6rEQoCsNNbU95UVuiGKqKwX05H1mjzimMiwgdjks=;
 b=kTDliowP7o3AiRgwqQlGdSorwzrpE74OzrYLBSyQym+RMD9BcY3HKgRqyUg56Jh5m2
 I0kSBhwhcQDEAp90nh3ZujDoa38kQhvTP1Jc+/wt8WWFrQiFg8l/9HyGs9d14T1TjS1K
 Iw0FVBL+/zSCAfzOAcwGjAtR42R3mpopg+GAsodk20VK3Hx90/Z6GucUnjkTQWGo6oql
 bMw16WK1ZxXYYN0eEFBOFKGaezq1RdQqMO8lXVb1eJIA70O3pkzZs/U8eRTUz/d/bNJT
 yjpEiEVsNfRUxPdw7uiUvTOiKewWG+vAZPNE1VIsegRpZQeLlLR0Qo6aFDH1RA0oJYKp
 WGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Q7v6rEQoCsNNbU95UVuiGKqKwX05H1mjzimMiwgdjks=;
 b=Z7WHVZL2UmrUCZwMVhNNC91coCGZQozzOTxaQwaA6yLc5j0rsltiZQeszHJ4JbFVQB
 Y6GFpi/SGiMpBZ2Qp98umTmyCsCq58eYT6JmQ9XeCoxN6uexcM/UA/l7OFom1mGScPhG
 NCwNsmvjNxWfQ7nebP8cj+oy65Zd74oDkrKRVmk+foDsCGxyeOGzBsO2W0FyfHwpAKz8
 ZLRFn2XlG1OWRfQecFeMWR/b3VvoQtjXoByeL+9NVknzi5xWjMn0GsVxyO4CRWZquEGe
 DZEL2w9/Rl/W/7x9p5vvTTAuwOK95YYpiHJts8x3yFLCizjFsz5PAni6zh+2sZJhTUmJ
 UupA==
X-Gm-Message-State: APjAAAWhypeRj+HShnme04P/btVbOmhonxLH3GolIKJ0wCXIl4JdVktr
 5dei5rYiO4CsxL6GXJKlaFAs1xEeiGS7V1ZUAlctqw==
X-Google-Smtp-Source: APXvYqzJyyLtfmAOBIQlbX+eop2/oig96oKMIaKGeExSCTI7BXDWjOnL13u84fw7hBXw+uulsexqobHzTGtoBwBytj+Rlg==
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr6412047pgq.130.1566610521287; 
 Fri, 23 Aug 2019 18:35:21 -0700 (PDT)
Date: Fri, 23 Aug 2019 18:34:23 -0700
In-Reply-To: <20190824013425.175645-1-brendanhiggins@google.com>
Message-Id: <20190824013425.175645-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190824013425.175645-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v15 16/18] MAINTAINERS: add entry for KUnit the unit testing
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
index a2c343ee3b2c..f0bd77e8a8a2 100644
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
2.23.0.187.g17f5b7556c-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
