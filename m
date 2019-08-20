Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E889E96D3E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 01:21:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 40AE920212CA4;
	Tue, 20 Aug 2019 16:22:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e4a; helo=mail-vs1-xe4a.google.com;
 envelope-from=3gobcxq4kdouiylukhuopnnpuznvvnsl.jvtspube-uckpttspzaz.hi.vyn@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com
 [IPv6:2607:f8b0:4864:20::e4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 46B8220212C93
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 16:22:56 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id k1so150954vsq.8
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=T94Ldr45BAcQvYAvJ8Y+rDntZ4kBO4X+NPr7Ifz4Qao=;
 b=EFyVTG07Exi4UaiWRBWcrqjeK3OigGHFopAe2CffL0d9XPm3H7ECo7PJmaYrh2vVMN
 Ied1Uh53sjFh8MiXULxEEWKt522KBiD8/qCyc8ionMtskrEQY7AqJbtuXdeIRpVfR6J3
 NUsaVEI1vhxCxPBbmusd2UlYmQ0HRh0pDPbSdlJ0EkPvwPHcRfFofWtl5psF+Ikb+C9K
 292A+bKTq6YKyswmWOE/7TWI00ErLohvyzIi69m+MDfqGzeQzw5X8+B6e2SdUL9F/KwC
 jTNNYJlhHSc41CLuQBbGC/bYqdnIwGNTR8qH7sFYld8Yd4Ekrs8JKToVb0VvbYD8qhpQ
 o+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=T94Ldr45BAcQvYAvJ8Y+rDntZ4kBO4X+NPr7Ifz4Qao=;
 b=e4vF5rP9F8NhD2Ma5SxrAY2OeOPaySwyjqSsiOyaRwAvhbZPnwLuJmMw44vKKLqjIM
 0+eVY8MK4E9n65CN3WjX968iv05ayWO26i7Gp/RDsDaQHnHsQQv4gbyDCinCWnsmWvhc
 4qlWVzkcD0eCQ7dRWdpiNvbKzrJ+Vsz/6YohZFfgBJshLzInR78nPS4Y6avYg5s2mVb4
 4ASHoOlV8B8mOzW7AtlOZ47FM1h5uwjJLHRN9Anj4sHywfZgBsQhUPEWQZDMKCzbiJ+I
 3+106eqNCukEA6Qqqc9Bjnl3G3//+fprNWt7xDCTrGCb2WbZgS/Xd09+Es91d9XlFsZm
 CblA==
X-Gm-Message-State: APjAAAVfVnBjT6ojj7ZXNYDwe0j0+SQJNnxU5FAyDg53/mqZQcI64kq/
 Fhjg/3ByeNREJK3/UUNRReD7NZxw2ahAPZgoHS5EyA==
X-Google-Smtp-Source: APXvYqxh2r8/Dyslnkrm5yAR1V7pXj5oYYDJiDInjvKNVIOiEnzifza+DlpH9bEyO+XPLxxYg+bgGDgljzWHWJgD5OjvrA==
X-Received: by 2002:ab0:5ad1:: with SMTP id x17mr748825uae.52.1566343298916;
 Tue, 20 Aug 2019 16:21:38 -0700 (PDT)
Date: Tue, 20 Aug 2019 16:20:44 -0700
In-Reply-To: <20190820232046.50175-1-brendanhiggins@google.com>
Message-Id: <20190820232046.50175-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190820232046.50175-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v14 16/18] MAINTAINERS: add entry for KUnit the unit testing
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
