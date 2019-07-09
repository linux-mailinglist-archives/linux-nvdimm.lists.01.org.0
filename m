Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1135A630F8
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Jul 2019 08:35:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DDF7B21959CB2;
	Mon,  8 Jul 2019 23:35:26 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e4a; helo=mail-vs1-xe4a.google.com;
 envelope-from=3rdukxq4kdjc2i5e41e89779ej7ff7c5.3fdc9elo-em49ddc9jkj.rs.fi7@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com
 [IPv6:2607:f8b0:4864:20::e4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 76A0D212B0FCD
 for <linux-nvdimm@lists.01.org>; Mon,  8 Jul 2019 23:35:25 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id m186so2396116vsm.2
 for <linux-nvdimm@lists.01.org>; Mon, 08 Jul 2019 23:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=/VeT4LMsGiTV0pNK4XYxpXDHYp6raL7HPeQMcvopP9E=;
 b=roIBcnzOyuf7R7TQa9ICeWdOERx3mva+VzvJQPH4lvFXtGT2/kaulCrRX+DGEkUw/T
 gaABeFeoYW9kQskz3db7OFV4HNtBmflz65SgSe0g3j583a0QDkTeu2M2IjdseeWReTnu
 TrDqk9xeVzUpKevzfptZTPMjNp4o8paWwnEbaXlbexoDNJRrxmcbR2miDUSceJwAQzUW
 OiDTI1GoYe74vWRMGh+gPjiZUfCGJrbuUZWDUB/57YD3HaPckGPhr0n53ahltY5Y07gQ
 s2Up2b/gCSIufCs+LQW1UFhHY8rTODW6TNZCUXZVQWTlrhIMZnGwj30v9FExmKRPN9mD
 U6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=/VeT4LMsGiTV0pNK4XYxpXDHYp6raL7HPeQMcvopP9E=;
 b=KscBzxltP+owsC9gap7qi9YJbSAqwD9TL5g617en/OBcUh+CwNnd5rVu9r5VHlHpZs
 EKCcP/3J831ZXhSEnjrrXugkuJDcsxKfNE2h11qQ0MqvahfynrclwVXzZtBnaluOazem
 5pA7SDF06/zvNH3My9DkSGBVRsCSC1SXcxjLR8HPDnJFTr/6FbII2F22glbSBzR8vfWF
 yIihI64GDOLPutNrB98ksDc5Yy8WMqrL0RiZkp8wGk2DCEbyNgyfdovCErLIFzwpu8Ns
 gVJhBG8eqIlRawStxawOA9j3GCJSUdjy2Ej0uPa0T18zu6CiIbKRvU+QdqSwMYeq6RFp
 sKEg==
X-Gm-Message-State: APjAAAV6Irsk3m8JE3UcMH82uFFR0KVTzHG7+3gPCVZT2wKJgZstkL/6
 dundGCZpaFmQUD/vKtWpJRwj/1pqYLdLxjUuilhwTQ==
X-Google-Smtp-Source: APXvYqyN/Q4TgY2+UreLNPIzXV6CJf/oH33neEZZJhWC+fF5Pg7HwPEIjdljos5DJcFFXaYWCs5Nyn8SejyeztD2NxtvMw==
X-Received: by 2002:a1f:3244:: with SMTP id y65mr3749601vky.77.1562654124159; 
 Mon, 08 Jul 2019 23:35:24 -0700 (PDT)
Date: Mon,  8 Jul 2019 23:30:21 -0700
In-Reply-To: <20190709063023.251446-1-brendanhiggins@google.com>
Message-Id: <20190709063023.251446-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v7 16/18] MAINTAINERS: add entry for KUnit the unit testing
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
