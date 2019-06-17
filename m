Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D3B47C79
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 10:27:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 44D0621296B2D;
	Mon, 17 Jun 2019 01:27:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::84a; helo=mail-qt1-x84a.google.com;
 envelope-from=34e4hxq4kdiko4r0qn0uvttv05t11tyr.p1zyv07a-08qvzzyv565.de.14t@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 94FDD21290DD8
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 01:27:13 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l11so8559527qtp.22
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 01:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=P7qQxupR077m/rPxlenNGlU3U4VVv+id9WBQp+CCiSA=;
 b=dqLUMwrRZQiMFvm38V0z6iKhsbbQcU8U8N8pSEIsFltqJAqDIL/1dU9s/SknImAoiG
 1jAZQEw1jfjkQsGEKRRwb9c9VUuPvm1EKJpmDRR2Dx395sZirD9rolf3UZGnMkXVT/0g
 B3W+XYMY5/uFttGCyyCOCwERc21fwwPtQ60cuJu7C6FZEa+rCRJoJDWrBrFGXpHe4lpW
 7DlYd2qA6sgsitjocepZeYwQsJtKZWf+m6SkXaSyypkDwrgPqUoUG19PSneUhdkmbpZl
 HjkxdkJ4mI1ik3KnnJs+UUjsWS4abEl/JWsf72O68EzBa7qdBYOno2uD0pv3+2nii6q2
 tKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=P7qQxupR077m/rPxlenNGlU3U4VVv+id9WBQp+CCiSA=;
 b=fUj05sVn2rwdcd/hrRXPHmHZzVAvNOSmS3P2lxj5wOyfxrezs7pajlseku9VxiZy3x
 Dwp4tq//phOm++dhvs5QI3yEb6H1ckYDMoKTk1eHuTlL4whLSAMF5auQaXD5jTEM+E2x
 l37Ew0VOpi8eJYwZ+V3G3dEaWxqB3CXh0WzQ9ynRzq33S6Ih7TtoWArAcmiL+ECSyQEg
 8kKTsvslU9Qtfuq8kyXQhH6zA1Q9KwmY+VlbgXelhdV2bTMVtI1crwdtasQNQRIAglL0
 Q8H2Cl+XJPYFe3B2S9QbWyPRxAGZARPEJFNFQnXC05mIaMYJVe/OOKHmsspaq22BlcFS
 gYtg==
X-Gm-Message-State: APjAAAVcUij/qqdCK9OuztwFP46hZ4BwL6EMgN2+yFuOUS4KVSOk0g7J
 GFEhEfrmCOJZEqnI40YNcwXfekJgsY3gA6Ca8cgfrw==
X-Google-Smtp-Source: APXvYqx0YR1LOvLx8MrLc4kC+IavL77YnqU0ZCY8iQpLJogfIJFPCQppkE8daCg0rbTkPkzwWah6Jy7PTx84UaIsCg506w==
X-Received: by 2002:a37:47d1:: with SMTP id u200mr53840375qka.21.1560760032086; 
 Mon, 17 Jun 2019 01:27:12 -0700 (PDT)
Date: Mon, 17 Jun 2019 01:26:03 -0700
In-Reply-To: <20190617082613.109131-1-brendanhiggins@google.com>
Message-Id: <20190617082613.109131-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 08/18] objtool: add kunit_try_catch_throw to the noreturn
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
