Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E5996D4F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 01:21:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7641220212CB1;
	Tue, 20 Aug 2019 16:23:02 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com;
 envelope-from=3iibcxq4kdosoeraqnauvttvaftbbtyr.pbzyvahk-aiqvzzyvfgf.no.bet@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0B44F2020D32C
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 16:23:01 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id w30so250979pfj.4
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 16:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=wKRiEgRg+/DU2DEnW3JXAo2ALm03Zt5EFSXAgxYeqSQ=;
 b=BFgC57EX5wNdOQeCPRvrkh94WwexKb08vmyjsrJYYbSvIPMVtFNt0v7lMY+yRZgSz5
 oipoLw5Xfl6v4PwsrckLZfwZgE+j41FjO9gfguvyeEoWUjr80Lp1xi4tWE7l3R9tPISY
 eDySOP8l0zqaHCiVre3eM0d83K8JTZAmnC7SAVBFQ1zcNvupC/ftjS4ePbli9gfQHh+S
 onygslKzC00E5mdUOcPr6G94dCN68feD11yxMzgKCuJmp4lHBeeZynaVoyNM8JGrzQ6m
 Jll+36t+qhbi/zn7MTmSl2mo18NrRtJTZxG0GKBzOcDk/wstf4agP9aE9EebO0R21bYD
 RepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=wKRiEgRg+/DU2DEnW3JXAo2ALm03Zt5EFSXAgxYeqSQ=;
 b=VcTc0eA82huCHOiFfZwTuHBkZZOZ1Bh1vC2/zj6S5tZNi13Jd/YIfK4Uj1Lg1cWhkq
 YkCuLFaoPUWNY0R+qvwEQ2iC8qVWRs8dZ6i5dHQkqYAW+TKNL8d93wNXIkm6Pm49ZxuG
 D8Xl3QRLHGDwUQQRyiSKwuISasgMgzA9ZhOAFpxzH2/YHf441C1iKOYAdsjgCVMhmT/p
 jb4ZVTaAWhuvOs1FECkT+KjfWqLLreIC3c77yZtw4huONLrwLaimy1FyBl5FWRaYwy7H
 yiOup6wCV6wedA6V0v5A656S+NQwrr8/FdnLxSVvHMJ+UzrJQyEc8fhtETiILINd8CMC
 pgnQ==
X-Gm-Message-State: APjAAAUI312gyU1YpEMUXRpYjZW3oMrydKpnJ0X46nYKYdHQ6NOHuXYl
 GpYtHjU3iQvGWlIi//ubaxuQT62krd7YJYIcQqLcyQ==
X-Google-Smtp-Source: APXvYqxEgOhZD3PGSn1+kT2I99YeG1HucF3rfBzgNXbSwxMoFoKzl7eYRx6lZPZGhCgAiM9akAkguErs7fj6mhP+rzIR0Q==
X-Received: by 2002:a63:4042:: with SMTP id n63mr16008379pga.75.1566343304518; 
 Tue, 20 Aug 2019 16:21:44 -0700 (PDT)
Date: Tue, 20 Aug 2019 16:20:46 -0700
In-Reply-To: <20190820232046.50175-1-brendanhiggins@google.com>
Message-Id: <20190820232046.50175-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190820232046.50175-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v14 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
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
index f0bd77e8a8a2f..0cac78807137b 100644
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
2.23.0.rc1.153.gdeed80330f-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
