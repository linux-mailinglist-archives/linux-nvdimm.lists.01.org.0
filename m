Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9ADB9B51
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Sep 2019 02:19:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6AD00202EF262;
	Fri, 20 Sep 2019 17:22:47 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com;
 envelope-from=3qmyfxq4kdisq6t2sp2wxvvx27v33v0t.r310x29c-2asx110x787.fg.36v@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 43A83202EDBA7
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 17:22:46 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x7so5455040plr.17
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 17:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=GL8bIr8dLG5/Kc/Y8WKLabBIaZO7WJH2uwuCEH7n76U=;
 b=JOe+XfR60TVQqjAO/rFGpvwAcA/DeU0SVyM/HI2Zhgf+PtyQB0/LAoxlOspG28eTUB
 KN9jxB3mTzgH/VAIVLmulJHeZb79W2QD+ooJERsLdgQedeMWn7VcN7Es1aYnH0Gkhhwi
 IWLHePrpOKcGs0YbMH6P+d7N9pQmEfolkxrEGwDrz/ATDZir+fRfFHmN/SDktuIu5Rh2
 YIeerHsfSRWFqIBf6DnJxi13eT3crcKMRNm5YJ3SiPsnPe1bj3g68f8sQWHI3XdZy9LM
 zpm7N5ugYQFlZqq0A7vg+AC3kwfWXBikM38GfptB+DWaOMSZABTa2cAcFPjPTvyX4Vkh
 9gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=GL8bIr8dLG5/Kc/Y8WKLabBIaZO7WJH2uwuCEH7n76U=;
 b=fLrJX+lgNOUusTRw7mR6eBj5j98xAL0s+JHFXRTxNetfG62wBZ5IaWs236qWCHnuCr
 G/XcDrSr9nkDFMWKDlJSDA8ftZXWI6H9nCRsYHbUfU9qXWkIwGniE+HsJ5NOMLgxDr9F
 VuavZIUy+Sbmx81z5AY1NZPqYj7DftDaBncZYDoJJTnCap//SLUmaPMO4JXpEDAejMaN
 uXBGeRyH984Ut2kV1kQgu9M/X+R/0oTm8Cdq17HEKYaUipGwXrp4F0xsuTFkOySXBj0O
 wNltcVMCauk/X4XCq4HprFMFQv2TYTjDrYyfkd3VpQdr0WTq9kfPevcZU9bQ48ZzQc2m
 1wAw==
X-Gm-Message-State: APjAAAWU7uC11euOOJOGREecF6YbM1kSStaZ0b54/1QLiMYFg1e70I76
 jvk6NlBCtH7XW9TyTeQAl7ZVWG1zQu5oCzaGrrKPkw==
X-Google-Smtp-Source: APXvYqzXl1Z5WO9dWeLbpxv4VzPzrj0gpja77fNZj2M2QIzsJxEJrlfVmtKghEGLDfEqjyLta/fW30aIAzXg7GqHAbqviQ==
X-Received: by 2002:a63:b954:: with SMTP id v20mr17995160pgo.140.1569025194919; 
 Fri, 20 Sep 2019 17:19:54 -0700 (PDT)
Date: Fri, 20 Sep 2019 17:18:54 -0700
In-Reply-To: <20190921001855.200947-1-brendanhiggins@google.com>
Message-Id: <20190921001855.200947-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190921001855.200947-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v17 18/19] MAINTAINERS: add proc sysctl KUnit test to PROC
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
