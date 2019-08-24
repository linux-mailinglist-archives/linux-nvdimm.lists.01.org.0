Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B51F9BA50
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Aug 2019 03:35:31 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C16B20218C29;
	Fri, 23 Aug 2019 18:38:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com;
 envelope-from=3x5rgxq4kdpodtgpfcpjkiikpuiqqing.eqonkpwz-pxfkoonkuvu.23.qti@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 790E720218C21
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 18:38:05 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y22so6838613plr.20
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 18:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=RZYwg2AKNWWbK5AlePl3YpD83HqbQqaQ/S9W/auEYuc=;
 b=sXlKKJhgEU1wa6b+t1Kfk3Us9JBNqB6qgFrYAorUjpNahnQtVB62F129r9jqW7As2D
 TECRv23j+orFXVoF1btyTlgKbGavDLv/mRXRpxUvewJTVsSyWUiwJR/MDWHL2k4m7043
 cnxd+RK+ZXWwaD0m4kGAzCv3TPvws/OkUrPxVWvZj7C8gOUsEIbG1ulzMU+UBC5ulBWq
 dWbj8dEXXE7CGrs/FCxd7vyonAjP9xvohhPSk8O9Rj98/htG5iBLR1KI8Hh4Pbg0s00U
 4YCNUKyFTqpEwz4Jf4CPs5qIZGCq3zkZi2UB5XVr4PO3/OBx5gUJAlDS2TXKFE4g9qqr
 g5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=RZYwg2AKNWWbK5AlePl3YpD83HqbQqaQ/S9W/auEYuc=;
 b=BzuI59rGJwk1+zGkwk//hJqIPJQcGNNcv2YukSv5nx/N2XTY1k29oK/XGrpwVywvFr
 1tCO/IcSdSxeJ0/LHMh3z7Ex4vSSisdClQ4f8i6QwcEtBanH8uam5muEfeId7Gvc7QcW
 xqKhlAFdeRECSsHqYM8spxw53JpISkyk/p9m7h5ecb/nnCpZC0VV1UaCwlQieoyEVHqM
 fgB75wTKRAPTz+RXJuzh69H23Yx2Z1QwOPXBm9BpzdQq/sHNvAzUytw2eUU9Dh31dqP7
 0jKlfvfy1RUJAwdQH3qoBbPQZvB25i2F6PlDOl18f2QzTB3qCXRJXBpQCbYlX39i/4+Y
 CR1w==
X-Gm-Message-State: APjAAAVnpomzc+nKLwIYMqrORYu8UV10RqYb9nebEd/sXTB9vHr4oMnE
 xNSeNBBJkFje06UvrovWM8CIoBdXgll3VIXTL1zrFg==
X-Google-Smtp-Source: APXvYqxeho9rBF0ZZ6VsD/UiYLMznIviw0ZlKZiyS4hv5yytF5NdlNUif2Pu10B+ZY4kXv3ubxh1pUBcBlFmg94D169gig==
X-Received: by 2002:a63:c03:: with SMTP id b3mr6561436pgl.23.1566610527139;
 Fri, 23 Aug 2019 18:35:27 -0700 (PDT)
Date: Fri, 23 Aug 2019 18:34:25 -0700
In-Reply-To: <20190824013425.175645-1-brendanhiggins@google.com>
Message-Id: <20190824013425.175645-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190824013425.175645-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v15 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
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
index f0bd77e8a8a2..0cac78807137 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12965,12 +12965,14 @@ F:	Documentation/filesystems/proc.txt
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
2.23.0.187.g17f5b7556c-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
