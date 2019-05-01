Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C3710FED
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 01:05:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 319F0212377FC;
	Wed,  1 May 2019 16:05:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::749; helo=mail-qk1-x749.google.com;
 envelope-from=3hibkxa4kdh8euhqgdqkljjlqvjrrjoh.frpolqx0-qyglppolvwv.34.ruj@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com
 [IPv6:2607:f8b0:4864:20::749])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6726E212377E6
 for <linux-nvdimm@lists.01.org>; Wed,  1 May 2019 16:05:03 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id t67so669002qkd.15
 for <linux-nvdimm@lists.01.org>; Wed, 01 May 2019 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=afBg8MXFYLPd4ElKfFZ/trSYMLXMP5LFZoVsy/mQzmY=;
 b=PS4XqgmjxFmmLNG4a7+Yce39oWOBnGeJYietXRtGGHG0s3tkKrTLVv7t3JuVJrcTc1
 KutFoAYJImIE74KhH7bcdjYmLxEqwrGbPqelhF2X00dTLnac17nc5IPrwiXTTicbz2f9
 yHnW72a+93CtmfTKR5QnGRSzt8et/Ly4ZcAVMfSHn+SCxSXzw1zkw1nB3vFldf3GmDRW
 V4jWuf1z1oJKJ/mTHNywIeCyEt6ToYpE7TZ6xlVusdVzZZyPSGv5HNpNNowdGSJw2egz
 dfdafxGTQxLWVkGcavQ+2Y+ar4k87+QhgoKGq5GA6P9r8ZHVHqdJk/unxr+39pqN5T9x
 Di2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=afBg8MXFYLPd4ElKfFZ/trSYMLXMP5LFZoVsy/mQzmY=;
 b=PLicmJDKvA1lSNKe+B1LlphMBrX6hGNznDmeL39rcDwrS5TjA/whqfdmUyS5neN1MY
 3awh8lQVmpsZgfWQhAs6BeVaazkrBQ+Q0JxZ/Rme1czLned1+hyAgth+75IaiH3nVikc
 9DwLAQ92u0jW11gsjhJeg+zH932yVJNN98nMvBM2kxeX8eohDZVRCrnB4ydkZNuZSozJ
 N7zDNm/f06aXddrX0rKcH10Vnu9Ahxw6pj2EM8Ny5lmD3Rj2HFYp0JuT46rSsxBQ7bvG
 eeav/rt8JiB7JdeNsNwLB6G1DZhy6Npfe17RuNK8HIwYNgdomd557CT4qMBfa6W+v414
 x/0g==
X-Gm-Message-State: APjAAAViKGw/iTPe3v25wyZJ41c5CzcArBc5Hte0piDK208DKjkdpAYW
 RvhmtLGCqt29QP50nM1oaj0uNIHURfjvxZrnsJi/LQ==
X-Google-Smtp-Source: APXvYqyrbTtQWB061i/IuTmGR1fZJktprQX+nOIOp8d1N9azYCgnL4QkQ8IwHRr2AUs5hUUYn4R+op23q7+ENLYHRpSNog==
X-Received: by 2002:ad4:5365:: with SMTP id e5mr604591qvv.197.1556751902442;
 Wed, 01 May 2019 16:05:02 -0700 (PDT)
Date: Wed,  1 May 2019 16:01:24 -0700
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Message-Id: <20190501230126.229218-16-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2 15/17] MAINTAINERS: add entry for KUnit the unit testing
 framework
From: Brendan Higgins <brendanhiggins@google.com>
To: frowand.list@gmail.com, gregkh@linuxfoundation.org, keescook@google.com, 
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org, 
 sboyd@kernel.org, shuah@kernel.org
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
 richard@nod.at, linux-kernel@vger.kernel.org, daniel@ffwll.ch,
 mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add myself as maintainer of KUnit, the Linux kernel's unit testing
framework.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c38f21aee787..c78ae95c56b80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8448,6 +8448,16 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/kunit/
+F:	include/kunit/
+F:	kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.21.0.593.g511ec345e18-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
