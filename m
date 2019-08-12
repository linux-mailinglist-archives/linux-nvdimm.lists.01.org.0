Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F248A8A5F9
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 20:25:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 50A262130D7C8;
	Mon, 12 Aug 2019 11:27:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e4a; helo=mail-vs1-xe4a.google.com;
 envelope-from=3e69rxq4kdkgjzmvlivpqooqvaowwotm.kwutqvcf-vdlquutqaba.ij.wzo@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com
 [IPv6:2607:f8b0:4864:20::e4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 387AF2130D7C9
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 11:27:44 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id 4so3633524vsd.21
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=xF9O5bmycue+nV+5s3i5h7noHmCRlxc6YkqioFWCIGY=;
 b=gAMWQ0Rq8di8PJdodT5hlee8/JrnFuNFOn9CKpyZkYxConO+hEk83QI5D5n6+k+6i+
 j0b8I4ILhJznmcqU3rrbjs4jFGJOVI0aYBiq0akuO1nPcBMaWWmznfDoLTwhkyatCdEA
 c9YCcVql6VrKCVIbtdtdVUlkobrOu3R9UWzNO43ovANODpT48IxQkwpDo5jhYuvfRFsL
 IrapIf1i0x6MNbwEGnQ+3Au6uQnf5xQNefUPyKxDl8J0fJ3mJV/Y7aTsKcUmXRc87ISS
 XHXIdrXTomm9ohJ18ZDd64h92e/fcyzWZWHpYevEkb9YB6K2oK4ehj5IbdKdrEzicRYR
 VnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=xF9O5bmycue+nV+5s3i5h7noHmCRlxc6YkqioFWCIGY=;
 b=XP2o/5sCc3AC2tbI9W0ZxgaE7mhqoQ7KXLcR3fX1FIM9NcMyF+XQwAqMxMm4vTxpoZ
 4JGWas9EOJyz7tOUHsIQKx/B2TVo4hm73iLC8fvlqR8zLFrCdiK4Fm4CRjwqRoJf389B
 Hw7RTMl9vqBHoPahnz68Oc+iD0Nd9l04fg8EELu6Uaf84nebz2nD7eOJQQ5w7zGGZnzf
 R2HTcMndYyKaaYYcKqJaG9iChEq69Q10aaJ61HbZIMLOchfcFGQDWXbA8s6ChtrBWk2S
 YADirbHypPX3mb4Tb2yQBaf0mrRTObCV8D18UDRHM1oYDiyzolcpFnYpiWT0fcGURX3d
 ChNA==
X-Gm-Message-State: APjAAAV/XWEb8uBnZQiWt9ucMIa8XdtMFsrqXFNjWbunWP7fKS1AdPRu
 2rPDjqIL5OlrKXf5mQmNVCSBGu8jNOD2Opxw0XWDWA==
X-Google-Smtp-Source: APXvYqyeAsoiYSIZDssjIlvbmVHHgRUhDoFimGkDtWsUy8Gxg5PQGoL+C6ai0yY+oGoXi0nylGBGvuiQ4FD5jyk1/IcLBg==
X-Received: by 2002:a67:c287:: with SMTP id k7mr6956688vsj.208.1565634323531; 
 Mon, 12 Aug 2019 11:25:23 -0700 (PDT)
Date: Mon, 12 Aug 2019 11:24:19 -0700
In-Reply-To: <20190812182421.141150-1-brendanhiggins@google.com>
Message-Id: <20190812182421.141150-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v12 16/18] MAINTAINERS: add entry for KUnit the unit testing
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
