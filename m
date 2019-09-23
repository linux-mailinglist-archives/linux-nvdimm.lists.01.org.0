Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D4BB088
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Sep 2019 11:03:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8206E21962301;
	Mon, 23 Sep 2019 02:06:18 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com;
 envelope-from=3ciqixq4kdjk4k7g63gab99bgl9hh9e7.5hfebgnq-go6bffeblml.tu.hk9@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E79F0202EF293
 for <linux-nvdimm@lists.01.org>; Mon, 23 Sep 2019 02:06:16 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id a31so1395165pgm.20
 for <linux-nvdimm@lists.01.org>; Mon, 23 Sep 2019 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=GL8bIr8dLG5/Kc/Y8WKLabBIaZO7WJH2uwuCEH7n76U=;
 b=IK3lUhPXkzXhSvQIu+QuD9wg5OjRhXIx6R/1B72oWK2uJ0Nc49oBemxVDpO6gZkWRz
 r5Q+L670bXmCW3zMVAf3oMGaNtrGBuzg9HJNjTzgL1sBfwbcKO118nwQm0rJpddQednM
 KpNWZzKb0DUsUERs4XdcPVCF/89zqyiQ+dnDkgvo5ltfnBmV+HvyblX09P4dgdQPw2u0
 17yNFekR+X0MNh7fo92DkFObENGEJcH0ryjhE0Bm0qQeRMUt17q/Uq7kMA2sQZjESqQ1
 RQ+yW4hX3SAZxma4mXg0sDXgS2AFiXtg1oGzOgnvsob1BdP2nTD+FIzUrQah22RLTY5F
 9YNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=GL8bIr8dLG5/Kc/Y8WKLabBIaZO7WJH2uwuCEH7n76U=;
 b=hjgvLFR+3LTbj+dSolfxjNfTGrJRQAbkNaqRbzLkIak6FQJuj/DDGGSPHKj2PZvO7E
 TKFPHKYdtaWGuR1AvqmJaMnDegpZbq7ArXoxW6CkwZ0mS+lzElYu2Z6vlds1Ynl6cbiK
 Id3xDz3KvvdRjtKvA1ZLmztx5d1KlyIsQYiG6bZ/+SWI1d+l+gvSoBtDTWw0+EC5q7rK
 j2tDn4Gku5T1dnpv2knbk2akrchctAFrBtQoQpNwtYHBshgD4CX56lVQKEYBE/6QqJ3k
 2dAdB8XMNi66woI0jq5x4uCqz1xu58Iq5qOKY7LIHzSIDvNaSSzvGtLA60Qcf7mOykmL
 cRDA==
X-Gm-Message-State: APjAAAWkgEEAcawBRlXMBYFezfgA5/wOUdLa1jRBHxgioNkLQN4RHw9n
 xmDoWkuOgWF/7f+dIzP4QK+IxGf/udz98y2809qj/A==
X-Google-Smtp-Source: APXvYqxHEgGNTtObJUfhRvTo0FGBMpt3QEn24wQykdFVcS3XLsFIcn8xjDZXfPIdHz3/ajFW+XsHHvIjGJVlc4qOgSQ11Q==
X-Received: by 2002:a63:1a5a:: with SMTP id a26mr28561962pgm.178.1569229424351; 
 Mon, 23 Sep 2019 02:03:44 -0700 (PDT)
Date: Mon, 23 Sep 2019 02:02:48 -0700
In-Reply-To: <20190923090249.127984-1-brendanhiggins@google.com>
Message-Id: <20190923090249.127984-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v18 18/19] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
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
 wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com,
 Iurii Zaikin <yzaikin@google.com>, jdike@addtoit.com, dan.carpenter@oracle.com,
 devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com,
 linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr,
 kunit-dev@googlegroups.com, richard@nod.at, torvalds@linux-foundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch,
 mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section,
and add Iurii as a maintainer.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Iurii Zaikin <yzaikin@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3d0d184ae4e..6663d4accd36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12983,12 +12983,14 @@ F:	Documentation/filesystems/proc.txt
 PROC SYSCTL
 M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Kees Cook <keescook@chromium.org>
+M:	Iurii Zaikin <yzaikin@google.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/proc/proc_sysctl.c
 F:	include/linux/sysctl.h
 F:	kernel/sysctl.c
+F:	kernel/sysctl-test.c
 F:	tools/testing/selftests/sysctl/
 
 PS3 NETWORK SUPPORT
-- 
2.23.0.351.gc4317032e6-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
