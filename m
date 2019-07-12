Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73FC668B0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Jul 2019 10:18:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4D875212B9A70;
	Fri, 12 Jul 2019 01:21:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::84a; helo=mail-qt1-x84a.google.com;
 envelope-from=3ykioxq4kdhcwmziyvicdbbdinbjjbgz.xjhgdips-iqydhhgdnon.vw.jmb@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D3008212B7D90
 for <linux-nvdimm@lists.01.org>; Fri, 12 Jul 2019 01:21:09 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id k31so6328461qte.13
 for <linux-nvdimm@lists.01.org>; Fri, 12 Jul 2019 01:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=LDQmGV1sXKMjUeOhPKTnD5bP1+GpH11oHwNBh3L4XLs=;
 b=ajMvr06ssanFu9RH2ulwsIFgwcP3l/5lqWEJ4esAE7iplXyXRdoSrlII6lIzkciV9c
 8fS3nAoGa/HEi4KQyyTUBP5BR7yF3M+y9W97hSaSVNMs7BQDT5O+1ViXKXfznttmHdA4
 kZj77gRl1AQhpyhVrBktIROAMxvXbx6avdgvMOr4xBoGYGhyUIqfYD/dLpvgaPFXSOWO
 xbcNYLSdxlgrhAxlcEUApm2APOEsny1ZyIbfB8sr4BAZx09pOkCoMJnlgMX+1V3SASYs
 BSMIHfLGoKRYl/0WYsLgnjKM0J6KWHxKs/rp+Dqs7J9PUiYp83sE3bi0Q56vLyTXyarh
 dgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=LDQmGV1sXKMjUeOhPKTnD5bP1+GpH11oHwNBh3L4XLs=;
 b=RIAsREfuNn1z8wcKZW5oG/n7tETDcV3lAwmdwLMQWzvAyC2ELyS1k7BiT80hdhEJog
 vrrT3BIOMToSJXVxUj8eR2EdarassUZF8g98HBkKCIpP5rRRMTKTVvdYj9nHc78vD8z7
 PjBk0FAIMhiRWZIR3qs3Dd1mBBUBC9ejb3FcIKLBr3Rkss/p3dIGSgaW47Mmpn0vSzaq
 eSJj/iUbSzjyUB6N+T6S3+RPLNBZmMguoKsDp7YL/ySmmk+nTYv2oa7iC9WiX8H0yb3K
 +ZnPiPVwsb8i/gcfMhpQurubD5YMoNSYEcDncHIvruRFXhKui/VAp9dOB1SdvRgiGoXC
 fiYQ==
X-Gm-Message-State: APjAAAUNRnNaEpCw9bOc4IwfmmM0MmqmP1zgGB1FtVQZtkSUBQ9BFL1i
 qyNkgu6rhFq9mperE9/Y4nD6tJJuLklPS8aciUJYSw==
X-Google-Smtp-Source: APXvYqzC+SZLS5J+4fhjs10zmFF3ZVskrEEqUdAP/3LUu2LLwXYMIIoYM0ZhbtGFlpH7G417ya7cYZF2uvns6Cyv43rpDw==
X-Received: by 2002:a37:9a8b:: with SMTP id c133mr4814616qke.261.1562919522167; 
 Fri, 12 Jul 2019 01:18:42 -0700 (PDT)
Date: Fri, 12 Jul 2019 01:17:44 -0700
In-Reply-To: <20190712081744.87097-1-brendanhiggins@google.com>
Message-Id: <20190712081744.87097-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
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
