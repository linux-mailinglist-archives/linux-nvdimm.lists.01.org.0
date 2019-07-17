Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC64E6B3B6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Jul 2019 03:56:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 97B0F212BF564;
	Tue, 16 Jul 2019 18:58:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::849; helo=mail-qt1-x849.google.com;
 envelope-from=3p4auxq4kdoglboxnkxrsqqsxcqyyqvo.mywvsxeh-xfnswwvscdc.kl.ybq@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1D456212BF56B
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 18:58:45 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d26so19911967qte.19
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 18:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=lZlBFQY3Us5crfW9WSC4bzJfPTy9JBI0rQpN2XrR9wI=;
 b=tqrR9xFTwORg1QSrmBsFleKT9JOo0mWeTxGW4Cfwc/bY+SbwKbWZtnZC5uqvLPXSy0
 fFTbFyRnOTfxluTh2q6BMZP1q+PSU3GiYh3dcvTTUMWsTDnE6XZgVauYWvDh+EbTKMPB
 KOgoPOnY6LBnwW9fDpo4DT805XeLouwSR15jHAff7jT0L9EmtILO0Z0eY1r1rCV8Q2i5
 O5GViNSp0p+IvC97BTusPHUJbhRwBbnLV8q2bc7TmAONmWtyLpSkhVrAreIyO5wcuztq
 zhOnGzS12A0sd7xlto/kMnwO3Xxh5zXw/gRGmyzq7nhT8lD3eB9n4tJ+8f/lrXrHJcfq
 mv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=lZlBFQY3Us5crfW9WSC4bzJfPTy9JBI0rQpN2XrR9wI=;
 b=sl4MQJ9jbgikZDkOe1ZiPDzDbU4WHL1QOE4gBIM90uGej+To+cEZbte4u+2y45nhgS
 xDH1CTGkgxvqjJstjkqKVhs2PHZYwPme/c/jgkWwuZhzXFJ4NEMGW1RgKKfK1Do7lLQa
 kwmu8/scqN++Rn1quKy9nV8lLFE2XGYUviMAMltpgn3hav6enkxgKtjOPTRfEm/veynT
 WE8rxooQ8Y6t0bBVT3CECGP4YviCh1HT5K/gHAHgHekMPEYwhWiWTeS3JkB+kPSh74Wh
 pxznt3pH3PCGh/l8OEEpeiLUevW4rIB0AYSeebshnd9eIiP95x1QERjTWy7mlJdEWvK4
 G3RQ==
X-Gm-Message-State: APjAAAVDWfrCgt3g9Jcfj8k50xRoc53X7hDGcfBD09OxngriBWbE/b5F
 Z7z+fa284oSQG9jhBHnxwnvjUyDOc8MtQK6jRfLdjA==
X-Google-Smtp-Source: APXvYqy/TbQinVkJuiRr7In6NyYeP8GT0mPKVABGBjQoi+qfrDV3qI73/LYe4gjXEi7BN46B71HCJBM5Bwy+83T+EO8gPQ==
X-Received: by 2002:aed:37a1:: with SMTP id j30mr25579345qtb.367.1563328575182; 
 Tue, 16 Jul 2019 18:56:15 -0700 (PDT)
Date: Tue, 16 Jul 2019 18:55:33 -0700
In-Reply-To: <20190717015543.152251-1-brendanhiggins@google.com>
Message-Id: <20190717015543.152251-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190717015543.152251-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v11 08/18] objtool: add kunit_try_catch_throw to the noreturn
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
