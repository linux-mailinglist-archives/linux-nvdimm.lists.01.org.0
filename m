Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9D6A544
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Jul 2019 11:43:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 544C6212BC484;
	Tue, 16 Jul 2019 02:46:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::849; helo=mail-qt1-x849.google.com;
 envelope-from=3wzwtxq4kddgvlyhxuhbcaachmaiiafy.wigfchor-hpxcggfcmnm.uv.ila@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 80234212BC460
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 02:46:22 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o11so8938958qtq.10
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=jufAXaUURqTtvupks8boLXlDljriz0DHAMYuxhv6lic=;
 b=vgpjGaWHBzHp9ycl7Gj2VvPUN4KEgffqXLjPFXd1s5ujHZe3mNs3njAqvdwJ/pmGw3
 cTbhhCjUBglYq1eqSSC2/VqemNQReHtHO5ekEj80R0GOCdZRfZlMYes2JOCN6sWABPu6
 RTo7zbnna68DX6bqksoVpM74FQZ/trOI14k7tVnje6LtNi3fa4Buw2HyANgHkkzueQMK
 8t0o/iQ+br0rWSl3vrgZXFzmyolX1OOI2GAXJBbdbbfCPa8PlSzOZt2TbS0KraBI1Ham
 covVnXHmFYADrljfP70Ep4gjXsasOB5sG1ihjrdHn2AaN0481p+2WqQRbwAEFWNBYJaJ
 HXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=jufAXaUURqTtvupks8boLXlDljriz0DHAMYuxhv6lic=;
 b=L6Ak46eLNvOURDOZMLabgvQqg0ePoOdyjRwgtijMRqrXeDclvlVj5W4U7hpGIHfklk
 cA+DgJCtArs7woKwx5gK1WR7wKHNncnGSxFK+dQ3bo0itNkko42MdrNfR7VIdG5HafKP
 a6S2qYzeIX4fGgVXTTu9yR6IUouI7OyUDbn6qt8EI+BGuyW5WsYSpEW5vDvLeAg1LRnv
 x1LOgr9spbfhmjYf5cto9+icMm5mCLQRnq5ysYZwXAoyretoX2vkngulFHjHpv7BsdwB
 JS68RLYoyJEr89vAOF2pzK4PxqYqW/lOfG9XPE/CYfjWg8etv7r3o0gsMi1hlWWGmiK0
 IIDA==
X-Gm-Message-State: APjAAAXkEwPH4hc4glSAJyraUL1P6AcXGACskcuKSxN3QdRAjl+PLu2a
 lUs3v3henw030eJMPoF7hix3QE/KjshXgx3Q9LUEIw==
X-Google-Smtp-Source: APXvYqxdoQCxyS2vi6iOV0SdFglJCYiFfVTskokE9ndTy0QxxgXK+rPdzc5HOt48np2BPs4oIwccRZf5oOo7m1gjUarTgA==
X-Received: by 2002:ae9:c310:: with SMTP id n16mr21197178qkg.438.1563270233041; 
 Tue, 16 Jul 2019 02:43:53 -0700 (PDT)
Date: Tue, 16 Jul 2019 02:43:00 -0700
In-Reply-To: <20190716094302.180360-1-brendanhiggins@google.com>
Message-Id: <20190716094302.180360-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190716094302.180360-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v10 16/18] MAINTAINERS: add entry for KUnit the unit testing
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
2.22.0.510.g264f2c817a-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
