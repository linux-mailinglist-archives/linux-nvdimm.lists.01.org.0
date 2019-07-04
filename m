Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922F55F09C
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jul 2019 02:38:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9AD6F2194D387;
	Wed,  3 Jul 2019 17:38:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com;
 envelope-from=3lkodxq4kdi8uax6wt601zz16bz77z4x.v75416dg-6ew15541bcb.jk.7az@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 497E9212AF0B4
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 17:38:47 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id w14so2275173plp.4
 for <linux-nvdimm@lists.01.org>; Wed, 03 Jul 2019 17:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=yOq03FKyvTfw/88JWebcCYFjQ+wDLwnIL9ZsmSGzZoY=;
 b=rqWRzI+VdoQ/rfAYWs+wJAt9qGoYlT+FmEZeSfQAzaVH20KzD6U58OfqalgNvRWq7i
 amSOe1o21GH4WDXzMF1heRcVHb5JJhS8lOcJdH1eA2sed1w50eK2TMHRb28oarEVVAqI
 zAwf0qJ8dWxINt8KyuIQ7b1ziwT+SMOhrULOa/pomp97DzR+c6fFqEvHQGhCltHFumFT
 dTCpV01W0drilgpn+1ZuX+iDAuM8CPlK6/6JLx/r9n5IKoaSjOojV7mjDzhEgMbXl7rr
 wlYIsOpWE53J7MjhsqjJnK4LspBE7HqSDeUUzHcHTIamen2UfAwJgNwwNGSqjm+cn7E+
 Cm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=yOq03FKyvTfw/88JWebcCYFjQ+wDLwnIL9ZsmSGzZoY=;
 b=WQ1FI+WS5VZKnPjF3NECCiXHOOBNAgRsjE3ac4tb6dj5z7e2PcPoFiUUOAsbqest9A
 jRAvE0nohEKJItJeK2EVd9dX8/pfG6A3b28j4qUMmspO8EBEXfAAqC3favSudmyKgV3E
 IVe+N4A7/qgpl0dsHXFAGhtZ5LbiAIbxP96QiIlvyW639qIkFLHc6ENG306t8KvCS50l
 DsRiDUKswG4EqvRe49JuR9ssCnN7Oa1Vsm6rqy+l0E8v9ewnjjjlE9WYlRBoMam8WlCR
 4XP9SS00jZ2+MRzsjcELw4nCj9ySNrZttuKGiOnX6nRpJfVLx0/9vR0XrGT3wQLpxuq+
 cH/g==
X-Gm-Message-State: APjAAAX+wrc/ycATTTrUOydXdr8ezJsDeHVB6hlqs6CZxKEv2OvobGer
 IC/I6ukP1EfFhU0u13djg2eDyqsc9bMRVl2uEmf6QQ==
X-Google-Smtp-Source: APXvYqzAM3YkV212D9iXbYWHJQSzqyj9BCDvcajKIxmq/07/ntRt++FdQVosrJyuKB2bZiRSFDT8qr6QUnHcZEZJj5SipQ==
X-Received: by 2002:a63:4105:: with SMTP id o5mr41354444pga.308.1562200726339; 
 Wed, 03 Jul 2019 17:38:46 -0700 (PDT)
Date: Wed,  3 Jul 2019 17:36:13 -0700
In-Reply-To: <20190704003615.204860-1-brendanhiggins@google.com>
Message-Id: <20190704003615.204860-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190704003615.204860-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v6 16/18] MAINTAINERS: add entry for KUnit the unit testing
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
index 01a52fc964dae..856a7c4f7dcf2 100644
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
