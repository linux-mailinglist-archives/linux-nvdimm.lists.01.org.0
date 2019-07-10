Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FC464238
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jul 2019 09:17:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7768C212B5F19;
	Wed, 10 Jul 2019 00:17:06 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com;
 envelope-from=375alxq4kdjy1h4d30d78668di6ee6b4.2ecb8dkn-dl38ccb8iji.qr.eh6@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 810E9212B5F16
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 00:17:04 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id n7so914786pgr.12
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 00:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=LDQmGV1sXKMjUeOhPKTnD5bP1+GpH11oHwNBh3L4XLs=;
 b=SWzxZhZeLl9B3ZN7KUpRnolnKVc0OJkXJr8qwulUb9s67eZjf6r3kc2Ogx/J6NFBmy
 uqmVFD7ak9Qf8Uo8aXEIMGv7YGtgPRuHX+xSuxQCpHpu8vO6QWhPhnFk65OLmSU98Mo+
 abndx4F4lNunK2LAN8X5bdTYvCw0G/l5uts0dKuU3ZLpu8KxF7vnPevzWZqEjMu7PyE6
 VfeMLPMw4Y1TpnuCapjefj7vkaiOpHNz5UIbiIVdL+S7PfmVCxTs5cgeeOlAwMRo0y8X
 qh0rs5Mg9wZHPZxBzOCF9AroydvmP+xOktJ7l+4j5selLe+O3LHZFGlyYirSiQEquBlu
 n+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=LDQmGV1sXKMjUeOhPKTnD5bP1+GpH11oHwNBh3L4XLs=;
 b=ZDRq6D/pWm3usSlWY+EOFkUx+UFqZscUy4IgiF2ni9MzXN+aqt9YYUj7ebEln+vzu4
 FI0zPwUqcU7VR7wYBqBKFYSvoP56NP+GBgi7TysrGey/UbP/j0uYMBf2Mvo7qTLUXS+2
 erCa3h/sY/b5THzXesmRP/lu+9nZpAF+hg2PFFgvGgoNu2h9Gi/JFYvunRsmwK2eDsAK
 S7ygxiduCmQUVzmsjNmrOjkV9LfdMoo1fXGMDw7iSVf204tDWGTm8iNUVnX4tIlVRSdt
 ZLnzftm1jdYYWU9uHasEEP8V+2QtMvuCfjhDrtI2KTpbUkR8SC43Z+CGpehO1DgetFXb
 jIiQ==
X-Gm-Message-State: APjAAAWmiqNAGwIjew9P2SQUxV2Zv6PwDb0kq3U/4JOxC9k6eEphxSBw
 tkyWd9f0pPXOSPlBC575nwTI63JozrEfne5EiJyZ8A==
X-Google-Smtp-Source: APXvYqwlEXuLFBHdrrK58SUL+5pvcKzBeJ5OszOrbsQfgRsSasvNDQkhx5yemg7ePksEVTpnjPnL52tUKDt89i4lgsAB3w==
X-Received: by 2002:a63:ad07:: with SMTP id g7mr33234528pgf.405.1562743023620; 
 Wed, 10 Jul 2019 00:17:03 -0700 (PDT)
Date: Wed, 10 Jul 2019 00:15:08 -0700
In-Reply-To: <20190710071508.173491-1-brendanhiggins@google.com>
Message-Id: <20190710071508.173491-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190710071508.173491-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v8 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
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
 kunit-dev@googlegroups.com, richard@nod.at, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au,
 linux-fsdevel@vger.kernel.org
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
index 48d04d180a988..f8204c75114da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12721,12 +12721,14 @@ F:	Documentation/filesystems/proc.txt
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
2.22.0.410.gd8fdbe21b5-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
