Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5584AB9B1B
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Sep 2019 02:19:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 726DA202EDBA2;
	Fri, 20 Sep 2019 17:22:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c4a; helo=mail-yw1-xc4a.google.com;
 envelope-from=3jmyfxq4kdg8oeraqnauvttvaftbbtyr.pbzyvahk-aiqvzzyvfgf.no.bet@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-yw1-xc4a.google.com (mail-yw1-xc4a.google.com
 [IPv6:2607:f8b0:4864:20::c4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B4EA9202EDB95
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 17:22:18 -0700 (PDT)
Received: by mail-yw1-xc4a.google.com with SMTP id y70so6862893ywd.8
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 17:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=Ps4mUI1wXYQhLtVI103dUb/qTWn9bG8Bcp8PtHYLuE4=;
 b=EpNbfjIJuRPOCOw8ygVt5WAvRpQfiHatGYZwjgY/UZ3UU4/J5JO29UPtRNCKNGwr4u
 HR5TU9ANXlXVmgDGBTzBUUqpxyem/qzyq7qmjUXu1MGvm2lf3eReibfSpVaSU1x46VOX
 vQaLLmYjM8czMG9fp6VLmj58rn147nDT/G87jkl9sYjW+zzWZtggw8MOoUMcsRv1YSdu
 OcSmW/Yfal5Mdf89cgfBhi4EHglzpZ23RP8my3Qer2lvn0/q9sKxat8FQ+A1Oc8q35Es
 5PlZkq0yAipFEDl8SPEYZTEdNhhJ5hP1AsApRbss8lUYOAmCSW0WkUqxjyIWZ7co7DUi
 5fZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=Ps4mUI1wXYQhLtVI103dUb/qTWn9bG8Bcp8PtHYLuE4=;
 b=qO8ZpBy8/sYi0k9050W3ZMZLnUv2kiZjQV2+24hvetOGHQYxjXjZk3CqlF6r2v73Sz
 WtXt7tzJMYOMB/EN7GD2Q+PYd5Nlgafm6sH9gArCglEJPkLH/VRCLde75JXGIsoz2lzy
 XrgEruUgdDmZcGxpy8axeOUCymB2GfSzfkaUqdinIBQquDDIvQyDNbBVmV3UWmVpCg9K
 bTUbrRuFFQte4Z9hpcErJSOdmWFnhDxDQde/ehInMZwsHLyK6tFwS3tMyRrdF9LHvAJs
 xO306hY1TgkKmxiqFXZN3hi0VFd93Pr55QbtGZ/n2VWnm0j/k4TsoUicbUHWLeladQRF
 GWdA==
X-Gm-Message-State: APjAAAVLREVQbFCgA8ukngZY2tWm719VadjFTIUcKlW6vMMwvKGKBTCT
 2vFwsUUdHmpq7Z73lvQ0+5OSI1SjGRpuQqQ1V5sh/g==
X-Google-Smtp-Source: APXvYqxnvbMbdy5YJ/mEtKLf76ImSyCOMAVrkXJYz9e4+aH2Re3qbb/KlZrY7S4PNlrAaGxfIXAnQgsfQqHuv/2j4Q6tqA==
X-Received: by 2002:a25:8201:: with SMTP id q1mr12174472ybk.373.1569025166777; 
 Fri, 20 Sep 2019 17:19:26 -0700 (PDT)
Date: Fri, 20 Sep 2019 17:18:44 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v17 08/19] objtool: add kunit_try_catch_throw to the noreturn
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
 richard@nod.at, torvalds@linux-foundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au,
 linux-fsdevel@vger.kernel.org
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
index 176f2f084060..0c8e17f946cd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -145,6 +145,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"usercopy_abort",
 		"machine_real_restart",
 		"rewind_stack_do_exit",
+		"kunit_try_catch_throw",
 	};
 
 	if (!func)
-- 
2.23.0.351.gc4317032e6-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
