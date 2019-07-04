Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 374135F05A
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jul 2019 02:38:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DC05D212AD5BC;
	Wed,  3 Jul 2019 17:38:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::74a; helo=mail-qk1-x74a.google.com;
 envelope-from=3zuodxq4kdf47naj96jdeccejockkcha.8kihejqt-jr9eiiheopo.wx.knc@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com
 [IPv6:2607:f8b0:4864:20::74a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 02431212AD5B0
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 17:37:58 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a65so5468656qkc.23
 for <linux-nvdimm@lists.01.org>; Wed, 03 Jul 2019 17:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=P7qQxupR077m/rPxlenNGlU3U4VVv+id9WBQp+CCiSA=;
 b=eX6g8UJwZVNX+4r+AShnzJta6FGseuE/5NG3bFT5qUZ29kjG3eSigy79cygGRMy3wG
 OlNuhPBgbypVjqEcuiDHgE8ZRW8TX/6T/BgVy+sLlM5y+9VJjnZhvIDMlYZBOk2ci75G
 h9xN0mf0vc5siI3tGh96t9saSuC00p9xuUwaUPkUcu6P9gaKRQ9QK0tgT0c83lmxhbU3
 2FMuBJqZmiDCRtom/5lZVTemVzcNLahTde7XIKJINA6n2Xld/6QvzyMORAoQ1D2is3wV
 ghoNX0qf/AFPDEbC7dn7jjJOxJsOmrsv/J4evI99aFvqYr9hJhmbq+e2Zzdo3qYeS+O3
 59sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=P7qQxupR077m/rPxlenNGlU3U4VVv+id9WBQp+CCiSA=;
 b=CINdjhIdcdgw5OviFZ/uxXNpX7QyIDdB0yS+GLgaVD0CLEQKndFnZ/IcUHAq+NTQhk
 Ue4W2BkNKc/kJhLNgAkdItsXCIBvYQgBZHJC8Kjbm30QpFRQWyXJlIeFYqlwtj6HKkXi
 rHB4ZI9HgCbSO5rbFo0afh/KyM8G+XaA1H4pKq6hvNbWKV0JE6llPl34mMSthQKAZXMD
 xqJhZR8bMe821CQtVN3B+XNRjTnRcwm+BZjphYwNk83QjKfmr7ZxblDW/LWn2MgnTRe7
 4dK4rf3jaOmO6JpDcMi/zIY93zx6sm6yrWYDtJ6vKc/y34zLRrdJQajzHCzrRRIXMB4s
 IRUg==
X-Gm-Message-State: APjAAAXl5BDERhKrQSuARspoSzp1kanMfgxQSz1/SyqyycXY8ro4nxvw
 t3ucaiIlmLq/Zh8jIREIP7t6rLMHb36cCPVl3xsW2w==
X-Google-Smtp-Source: APXvYqytggehTlSFZvjf2aviCQRPatILKKaUGgr20IkSkXU2ITJH43rWfM0KxJCOSm3yMfSZQ3zYRWZoJDKAEm/SDyDtaQ==
X-Received: by 2002:ac8:7b99:: with SMTP id p25mr3074172qtu.243.1562200677358; 
 Wed, 03 Jul 2019 17:37:57 -0700 (PDT)
Date: Wed,  3 Jul 2019 17:36:05 -0700
In-Reply-To: <20190704003615.204860-1-brendanhiggins@google.com>
Message-Id: <20190704003615.204860-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190704003615.204860-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v6 08/18] objtool: add kunit_try_catch_throw to the noreturn
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
