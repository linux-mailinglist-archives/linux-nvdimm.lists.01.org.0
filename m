Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B98CADC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Aug 2019 07:52:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 05883212CFEAB;
	Tue, 13 Aug 2019 22:54:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com;
 envelope-from=3nqftxq4kdce8obka7kefddfkpdlldib.9ljifkru-ksafjjifpqp.xy.lod@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C5DAF2030431F
 for <linux-nvdimm@lists.01.org>; Tue, 13 Aug 2019 22:54:39 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s21so64106999plr.2
 for <linux-nvdimm@lists.01.org>; Tue, 13 Aug 2019 22:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=dJI3f1SN7FHCWsT2YqJJAK+Vl1EvHBTDcI6eHyMtfac=;
 b=sDK5BT/dvFb/4wwwQc1PTpPfH2empuHwtwW683jTc1/UBzcVhObxNP6pBGFilT0sdq
 YjFA/RSQMApVVG+t8h1ynCnvPdjVkkT4nFOBzw6j86bvAZfGFyoYXaIKH1aOmyN2jmCD
 jUU/GIuMEPnspV2nccFjXTCmkzDGT+WZ84tAAqSxmHfl/ERNtjccEG5kl3wcxEb9cTTq
 HoSgKYVtNTanG5OqH7HxaTtMxnQztFLBRlhJ5hoYcT1Yny5tYkm3VtA63Leys4fWCsMI
 KbnsbQWD30WYxkZtVqZaWnTXS2XmF8P1lMAnt7SfjvXusNDDBGHrhs/Rz5S38DPj/h3r
 n92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=dJI3f1SN7FHCWsT2YqJJAK+Vl1EvHBTDcI6eHyMtfac=;
 b=FLJJy6JgLCHHYB1r3jt9aa95DnsWIJyx/HAcdEmhpdDVF22eXfsEnWXmjKD62dFfuu
 JZxhE7ydfjpQPY6XoYkg+jz7PuuAYEqpHnwx8pwrzdzVm2AthahsIOT+WJmgZi2agBUu
 oyiLkf6PUH6BCvp7UUAsQEsSLM6fAzxdDt11ZUOAJiIujJFP1GDxrHqzmSgmUpfdMENb
 KWsEk24imvHO5yaV5aem7zPQn69uvhpRbgyisc7575F+BzQ6TR2RFCDt6+fFyonMDdeX
 0ycwwNshxXtz5tIlHfS3sd27kXZ4yvghvyYjsYq/u3eWYeO18/6ev1rIcUnL+3k9FdhV
 tUdw==
X-Gm-Message-State: APjAAAU3Cfg6ZachkGh+K3c+k6UKotiWpxPyhD3fcoE74KVFBk1ZJqkG
 oOs/BcQ6gRJjFkxTN0i8ezFaadbt0rExcWoux4SuQg==
X-Google-Smtp-Source: APXvYqx15GDkg8PQB7JqjQGJp0JcWDFj1Zkf1yox9JkFPI/5qXF/sLjhNwC7NbFBzfAoGHt2OonLFNZNFwcrsUAQ3uzHkA==
X-Received: by 2002:a63:3006:: with SMTP id w6mr37892554pgw.440.1565761950937; 
 Tue, 13 Aug 2019 22:52:30 -0700 (PDT)
Date: Tue, 13 Aug 2019 22:50:58 -0700
In-Reply-To: <20190814055108.214253-1-brendanhiggins@google.com>
Message-Id: <20190814055108.214253-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190814055108.214253-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v13 08/18] objtool: add kunit_try_catch_throw to the noreturn
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
index 176f2f0840609..0c8e17f946cda 100644
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
2.23.0.rc1.153.gdeed80330f-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
