Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3404C1E494
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 00:19:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB6A82127674A;
	Tue, 14 May 2019 15:18:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::84a; helo=mail-qt1-x84a.google.com;
 envelope-from=30d7bxa4kdkciylukhuopnnpuznvvnsl.jvtspube-uckpttspzaz.hi.vyn@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9F5D021276BAF
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 15:18:58 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z7so691606qtb.9
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=hhxf3AcyDp0eVXaG87rECj9td0IjCbgyx1Cs8/dNg/A=;
 b=DWFXnp4Hv3gxia+unBmllYaYsTdEPeRc/MPliVDfhoKoHkDccBfKjOBBsFdOH4qVF4
 3CGJdM9LtOAktm1DF9ynbnqVLvb//vkXXPW7t/2caqYSYtjHk5Aaij84YmZjLohuJnsj
 duqt01BxicXxTwy4Wq1D8gJEpe7I1Bv/AntHK8CMGKACQmTwcpHMwk+lus/z1YcgauPS
 xb9wQdaOPB2kaJ1qgUx6KyFG2BH9s/HJu2I8bvz46w/Jq1pIQsjadDWuScGCXS8oRyST
 Yp+i+OKpZrGRDaOWBmMoeaAy5+jX8z364mHVYMUrFBoYt9kdi027M6YMfk5pPD9tA2HQ
 MQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=hhxf3AcyDp0eVXaG87rECj9td0IjCbgyx1Cs8/dNg/A=;
 b=ZaFguadDPAj6olu2hiZ0ji7ccSSSo5ako1hk4qimRa6b1Lbj/owEc6ZrP2y19yFMAl
 wjZKSKSku5k4vWO5P2CSfwtkaiR9AaA3FL+0Or9TmZDg7R4lK8yVWZDwx3PQcOOh5FdU
 uQJXtSjTHRh1NvZZ+wdSW7lKvellOECzQ4eBQSQC7qpHFXbl7psxYFU2EHidfdqSff1q
 aTO9vIQ3o21MWBqtikse8OEKW0omp7oEnvRj2PMJ/oF3jP5khTQqCtqFQD03k30WW2WL
 vEF71pzIE9LI8X+cSa9w2h6rpyMpx44FkA4m6UP0Z9InccNerKTs/QLHy4316VcoZSi2
 5Azg==
X-Gm-Message-State: APjAAAUFE7Zenmkob0c662aEHCCMB7QtuZHHsEaMBY6S2XFGkKmBGQCr
 BHmLfQNM18r4Vr58aw8j9eCehGcaA13wtYw+HUNhzw==
X-Google-Smtp-Source: APXvYqxBQ+PfPDI2jK3tSl4/2KK9BEIB1HtAeTqt6B2C5YgBbe+P8hDv92BaaZf8SMwpuI/42oh72dMCZGz5UE2CQk++4Q==
X-Received: by 2002:a0c:9ac8:: with SMTP id k8mr30361437qvf.132.1557872336955; 
 Tue, 14 May 2019 15:18:56 -0700 (PDT)
Date: Tue, 14 May 2019 15:17:01 -0700
In-Reply-To: <20190514221711.248228-1-brendanhiggins@google.com>
Message-Id: <20190514221711.248228-9-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v4 08/18] objtool: add kunit_try_catch_throw to the noreturn
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
index 479196aeb4096..be431d4557fe5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -166,6 +166,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"usercopy_abort",
 		"machine_real_restart",
 		"rewind_stack_do_exit",
+		"kunit_try_catch_throw",
 	};
 
 	if (func->bind == STB_WEAK)
-- 
2.21.0.1020.gf2820cf01a-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
