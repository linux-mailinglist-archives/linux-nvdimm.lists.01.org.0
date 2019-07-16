Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 548E76A54B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Jul 2019 11:44:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E5986212B9A9B;
	Tue, 16 Jul 2019 02:46:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com;
 envelope-from=3xpwtxq4kdd0aqdmczmghffhmrfnnfkd.bnlkhmtw-muchllkhrsr.z0.nqf@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 80F4A212BC48D
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 02:46:27 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id e7so764113pgm.2
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=z+RsQ5cMJRNJEspG7oJoFcFROmHPEJhG9JB06H11s3Q=;
 b=CUY4X28sB+ODqLkExBF1TPtKPBrP8z61MsztlmFA3r3gT07JFbpBdEO5woSX6qXc5N
 7BJpPco1WgRlDYy/qo0/eQlbH81eSVuboFms9Vfai0ZrWDbY3TxcYEjJ862ij9z1VGEB
 1XEk67DEtl2x2z0HdpX/hfuCpUB44Qgi9Z5nNVY0IvyFXpJdsd7uca/G6oZFZDgCNkBl
 9KwMhzPT+UvSiWeRn/CMWIFt4CB2a/Hi+EdyU8gaY+ftONCJpCEIb11YwL2UTJXycDAy
 5pyhBy52Rf1DEP5nqhHWDX5FpEAPRVHHNegfFxUpAFP0dG/QMJ9n8t8pRQ9jJ7cscePK
 Kt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=z+RsQ5cMJRNJEspG7oJoFcFROmHPEJhG9JB06H11s3Q=;
 b=JsHzJRxRZwgTPzNv1Zs4R6hTEcIC25EfHY/+rHwoOfFRfXW5lpljUdw5UEEjlc3M9W
 0F4lNVOGPqBegAPlPkmoaBfstd4ncGoq9iT8u0UfOcXJU7FR1onkVKys5FmXN2B4yUtw
 9IkKKqlI6f2pKIHDbGaWhD3orldJphUZSZBX1VjOAhUxdBZrhM4QTmfhubi4DjF7aI2Y
 dTFvT5n+xTM7fm/oaw+g1wXQKbS0ZYtiGQNV93NbJghGRIjZrvLIDb5UoVSek0uVclSl
 6J091zN1IVpWWtp4km+zTu3Q3u8CAKRPVCJ5KZb8vqCJIFAI9Yz9lR0hAwntDUWK719A
 3oQg==
X-Gm-Message-State: APjAAAW8UfNmWGA+u0IFHCsvfSid9pZFQ/iFCvk0zxvrGVc+dzitnNfU
 bHani+R9BTnnQKizj15ArT4fdV5STrnZWkpzVFB/4w==
X-Google-Smtp-Source: APXvYqx6tsQcpzZYDcAwRrqh43EK99hhlzkdZq0K9nskPImImgYN/CiLbSuAKeIKHVdKNAnHBHuOTFF9uImlQQjUAKlIJg==
X-Received: by 2002:a63:f401:: with SMTP id g1mr33239239pgi.314.1563270238515; 
 Tue, 16 Jul 2019 02:43:58 -0700 (PDT)
Date: Tue, 16 Jul 2019 02:43:02 -0700
In-Reply-To: <20190716094302.180360-1-brendanhiggins@google.com>
Message-Id: <20190716094302.180360-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190716094302.180360-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v10 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
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
2.22.0.510.g264f2c817a-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
