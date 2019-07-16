Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C4B6A52C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Jul 2019 11:43:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29172212BC46B;
	Tue, 16 Jul 2019 02:46:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a49; helo=mail-vk1-xa49.google.com;
 envelope-from=3q5wtxq4kdci9pclb8lfgeeglqemmejc.amkjglsv-ltbgkkjgqrq.yz.mpe@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com
 [IPv6:2607:f8b0:4864:20::a49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 12E52212B9A86
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 02:46:01 -0700 (PDT)
Received: by mail-vk1-xa49.google.com with SMTP id r4so9589132vkr.8
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 02:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=lZlBFQY3Us5crfW9WSC4bzJfPTy9JBI0rQpN2XrR9wI=;
 b=DX1LvNppWtT3TTQulWABcRXxpn8iTEBCN5ZSrvB8fB+IBGJFMNOzH7YL/HN+5yKRqJ
 41R44YMyFgs7gHPFM5RC4OR25wcyrJb2dRbNHBzIF8MDGN1aUqj0nQIjWPbmbCIDdiZS
 cbgtCzkOa7R72JDgOcaUDIdw3GtElQSqPValW/ciqg+U2tj3JnixmeuOd924bFFXqG4f
 z/GebTNz0Wj6zeIjBdId6Trn8NcfhaCv4E9mrcr/kEB/hlP7Y7V683cSF7qBPtXQVwqA
 OZ1pGjqpkfJcHrtSowOO3rz1QVSk8rt2UrNl+7wFdEQczKSB3unQbu1ZXA6E+PQkfKLB
 Ja9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=lZlBFQY3Us5crfW9WSC4bzJfPTy9JBI0rQpN2XrR9wI=;
 b=UsF3cCNGGBl/huNWXdYY9okArr11bti2CZGHIhqxRqriap+AQBVh2lTgqMwQDIz17N
 00DA7cLM8HpiBlMvNJGKtI3M5R5kklIzYjr9g/Rmxa2QrGGRLwSQwaRbQfO8Dzn9LpKp
 fITrxHmwssdwCq3Z7OY4IW1s9ssD/HEAifBKWZHwFrkwGkz5gvkWO2wP8W+hRXvNNAUI
 FJhDCn9Qvjd8EyyTlUjYXzH0sUvlE6SYhMVHCDvIzgAGoD+iHGg28DbZd7jJyOHk3ysM
 +krqwRBm9ktOBq1MLq75GlgnMicQdDfXL+LHjEfpJmHWi1vpESpsxdd0mJ0fs8KwgjXU
 q0Cg==
X-Gm-Message-State: APjAAAXvU4a6agqro3sKVh80InWIcGJvtVJFAkkwu7k5sgtP4LwfI07n
 hPbDYnJOl47C9vm7DCSKbIZdBUhjPFAjzhQ9GV53rw==
X-Google-Smtp-Source: APXvYqxqKbel/54jGzh19qChTyrMaZnWOC/e3EUzK7J+6Pv1AZ9Pc0NWXvhp/2B+Xqkw03JSEPx72ClnYnJPihFK/5czgQ==
X-Received: by 2002:a67:e9c3:: with SMTP id q3mr19671567vso.5.1563270211546;
 Tue, 16 Jul 2019 02:43:31 -0700 (PDT)
Date: Tue, 16 Jul 2019 02:42:52 -0700
In-Reply-To: <20190716094302.180360-1-brendanhiggins@google.com>
Message-Id: <20190716094302.180360-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190716094302.180360-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v10 08/18] objtool: add kunit_try_catch_throw to the noreturn
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
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://www.spinics.net/lists/linux-kbuild/msg21708.html
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
2.22.0.510.g264f2c817a-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
