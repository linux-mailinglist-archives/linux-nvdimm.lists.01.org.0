Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D218CB1E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Aug 2019 07:53:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1C224202B75C7;
	Tue, 13 Aug 2019 22:55:10 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com;
 envelope-from=3vkftxq4kdd8csfoeboijhhjothpphmf.dpnmjovy-owejnnmjtut.12.psh@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2574F202B75C1
 for <linux-nvdimm@lists.01.org>; Tue, 13 Aug 2019 22:55:09 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id s10so4184861pfd.16
 for <linux-nvdimm@lists.01.org>; Tue, 13 Aug 2019 22:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=wKRiEgRg+/DU2DEnW3JXAo2ALm03Zt5EFSXAgxYeqSQ=;
 b=e8FnE4mzksKwKvHVDlhEsFZll89sGvciMN+IkbM+27IPEZvPiJyQZInF8yV9NhMYq5
 vs+LUwYUb20DCcYCn6SgBoTbY0tfpRpCJoQOagxYzblakC9sr9JOvrg2Z+ToMmRMwvzh
 W+3DTHzK7xnkQZVQ6KUpVxkAPxTGGt6gMvmYWcNyb4TdDD2AZp6DkCO9LxTIB6gc2NkR
 bYLd8E3VZQ28b+NnVnfDxgRPMzHrRVicrIjbAMBpySYF0hIPz5mX7m0RgEkpsqWHBtlN
 y2eydwtd5RoWffNSECN7w7xvCO4q2ycFf/Ue1TR7mmJyNY9xmsOr5bUS2NW6Xg+zMMY4
 HQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=wKRiEgRg+/DU2DEnW3JXAo2ALm03Zt5EFSXAgxYeqSQ=;
 b=t6c/ESWzLKDSnsb2V5e07hEynTv9OUCP278RcPWQdCk+ve1353/s4+c5b0Ba7wCFwG
 2cureFuRuYZ3QxzZlV2IWY6oWdVwHTe6nqIB/Zkunjhs5aOPpxKopanEUVztWSEwsrk8
 UrVscZY4oie1BZNuoEiOtT8LjVbWuB8IxJFAZDDOr+fHDHxiW9I9xNTJBnElTlIRTqAT
 ZJx1d3xnu9t9nDlXbx/skXRlRAnJ38sA4Q3Zk1AVJuEDhhpOD3ziF5S95xSLEMnzU8A1
 a5dprzeqDP/SsSXOV2ORvGzrAXfRG7Gxl57IW+RowDRRC83q6r5Hyy97vyTdQtqPv9NN
 S2xA==
X-Gm-Message-State: APjAAAWOS4Qj6fTH6IcyvrcrHsOYw0IGb/xoskN61wTbksMbTVqd9pfQ
 oQRLrUWmJ63jmHsf15XuslCp8G513QckBSgc8PVrBw==
X-Google-Smtp-Source: APXvYqx8XUDmNFB1JCe6JK97kDtNg7kpWNPeo7m6HD2zKnDH3s9T3hzazsfNitBEdvd+5JAN+R311UbpJ0stRAJs22yoRQ==
X-Received: by 2002:a63:be0d:: with SMTP id l13mr568158pgf.357.1565761980273; 
 Tue, 13 Aug 2019 22:53:00 -0700 (PDT)
Date: Tue, 13 Aug 2019 22:51:08 -0700
In-Reply-To: <20190814055108.214253-1-brendanhiggins@google.com>
Message-Id: <20190814055108.214253-19-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190814055108.214253-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v13 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
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
