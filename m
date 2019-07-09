Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD7A630BD
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Jul 2019 08:34:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E6C83212AF0AF;
	Mon,  8 Jul 2019 23:34:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::84a; helo=mail-qt1-x84a.google.com;
 envelope-from=3ejukxq4kdgueuhqgdqkljjlqvjrrjoh.frpolqxa-qyglppolvwv.de.ruj@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8FA00212AD59B
 for <linux-nvdimm@lists.01.org>; Mon,  8 Jul 2019 23:34:35 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id i12so15854140qtq.4
 for <linux-nvdimm@lists.01.org>; Mon, 08 Jul 2019 23:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=zxmYDY9n+QBUjDbNH9DRIe0/wlKXcDbLcLkE9B0ZmxI=;
 b=C4g3uHhNIZIht1nDzDUYm5V2TjqZkqGF4g9U0/Ah+KUIKNc92+/rAoZLx/j01ufbx7
 NTm9IwMbUppcuvs4/CbGM/P0DyEHMaX5TywaRSRvptj6oN81uoUUr62xNvGuYDcNVDhI
 49JoB6UQIsqC/ex5+qHWG3RBZgDlLpJreDtgP29yMI72YRGwOp5k0fkqtT7o2iuSgqiU
 jq5xmkuTYFQ0vqw+N5FHoRuAmb15morhS8McfPpBFBEg4HYmxmXZTsCM3/1UF7oaf6qT
 6YjxVprc/Kxlv2BBc7YWTCmJqDgvhPwsK5BvIOIwE6wSlnDUwRReHV24YJIEmr9unbnc
 X8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=zxmYDY9n+QBUjDbNH9DRIe0/wlKXcDbLcLkE9B0ZmxI=;
 b=lhOHPEjxNivnPEPtMQlChbmJMuFuY1CFD62w1oa5A46etkDc/SPHEfRmTdKQ7E/Ech
 NNajuxQdjLRKJ/OAeeDlCekn9bNaqYQ32xHGRrGJ4ElCSdunaOQkMm4P9eZrRRkG4ltN
 ZPMQghxhWzLhSeVLw/VgETYjrg7DS24Mx2Afe395ZzoVrfj32+kxKm+KvvlljRwQ1syP
 Vze0ySSYBTN6TFvJqb1aqTR05edTDqy/Kdiliq9RWyA/1o/lCCwYEgU8+3mw+QoCrT8b
 qHZA1B7Paz9CAqj3fOoMquWeOj4nC78d4XZGdG2oTBTDkOzHTzWW8wZI5vu/Lt9ZKo/D
 lqBQ==
X-Gm-Message-State: APjAAAXx31GTrow0A4uB8hB9rnfA61GtVRRS/hYt31YhupCRDbn8OKdl
 nAYV7+GoVPv253S9soyxXPH10qrDJrCouvzQxa8aNw==
X-Google-Smtp-Source: APXvYqwOwsIg2AU8i+/acrVUiG/ZVksl2o22EvWFY5S+OQozRKmXPRdDhqqqE6sia3AQVvck9Y39W2rm/r7998eZ/E7wPg==
X-Received: by 2002:a0c:9895:: with SMTP id f21mr17680434qvd.123.1562654074507; 
 Mon, 08 Jul 2019 23:34:34 -0700 (PDT)
Date: Mon,  8 Jul 2019 23:30:13 -0700
In-Reply-To: <20190709063023.251446-1-brendanhiggins@google.com>
Message-Id: <20190709063023.251446-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v7 08/18] objtool: add kunit_try_catch_throw to the noreturn
 list
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
 kbuild test robot <lkp@intel.com>, linux-nvdimm@lists.01.org,
 khilman@baylibre.com, knut.omang@oracle.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 richard@nod.at, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Fix the following warning seen on GCC 7.3:
  kunit/test-test.o: warning: objtool: kunit_test_unsuccessful_try() falls through to next function kunit_test_catch()

kunit_try_catch_throw is a function added in the following patch in this
series; it allows KUnit, a unit testing framework for the kernel, to
bail out of a broken test. As a consequence, it is a new __noreturn
function that objtool thinks is broken (as seen above). So fix this
warning by adding kunit_try_catch_throw to objtool's noreturn list.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Link: https://www.spinics.net/lists/linux-kbuild/msg21708.html
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 172f991957269..98db5fe85c797 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -134,6 +134,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"usercopy_abort",
 		"machine_real_restart",
 		"rewind_stack_do_exit",
+		"kunit_try_catch_throw",
 	};
 
 	if (func->bind == STB_WEAK)
-- 
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
