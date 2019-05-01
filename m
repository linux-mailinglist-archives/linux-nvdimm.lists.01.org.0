Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E366410FF3
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 01:05:11 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B00921237803;
	Wed,  1 May 2019 16:05:10 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c4a; helo=mail-yw1-xc4a.google.com;
 envelope-from=3iybkxa4kdiqjzmvlivpqooqv0owwotm.kwutqv25-v3lquutq010.89.wzo@flex--brendanhiggins.bounces.google.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail-yw1-xc4a.google.com (mail-yw1-xc4a.google.com
 [IPv6:2607:f8b0:4864:20::c4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 76878212377F9
 for <linux-nvdimm@lists.01.org>; Wed,  1 May 2019 16:05:08 -0700 (PDT)
Received: by mail-yw1-xc4a.google.com with SMTP id v127so1087067ywb.20
 for <linux-nvdimm@lists.01.org>; Wed, 01 May 2019 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=PRLXnvg3FnToIBJTwXVR7d2TK/MHZSW5pjHfdNwtr7Q=;
 b=K5TwnumODggM3WBroA2xjKir+Hf59I1szowVRTt0lzCy/25DKO4Auoy9KuasdBqFUu
 UWvBOKOTmtxVhAOl4er1T2140+nu1Bz+99TiGL9+yTK//z+jqboMkU5aijHYP0BbYsOh
 P/McaehM5toEAU772+pJGpQWNEZx5xhfrNPAJoKaW0IpWIVJaq0KjD8R8F3QXpB30i5m
 XrT04TmEJJAw/8yrNXA4XJeGyU/uVcdsIpKRYnl9kRb2X6reSvrGJiWqLpi2xAFDwIgz
 M+mClrFoRM5PxaczMRkZTVN0VXOBXS2l+ZY6dXc7xjKICM5LbtnpXVDT7unPYWdXqa7Y
 wpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=PRLXnvg3FnToIBJTwXVR7d2TK/MHZSW5pjHfdNwtr7Q=;
 b=DqIHdnMSfNZVaZyP9wptLw0vPH25WHzsxQ/o49ZQSPrW0WBB3zOqN4c11hv4z86DVe
 C6GbPWt8jP9593Q6E+qKspWm1vHpPHMx9xcr7qGV5W6CIJMqYHECg2XaiytuSjMLq/X2
 lOK40eyOlQQdea/AUOT5gFMtXOjk36NOIsPuDau4LjWFlzk76ej8h3jqZKxbxK7L1DNW
 loWvOxdjrrbhJGheRkFLD8oOa60IPFNrXyjJT1rKse1qF2KCQ7zsrNkrl1lu4e9xjdBc
 GWjr23qpEtlHQmKR+ZGEj12cbx6Uk4PU2kL1RSltqu8xX8NrJsagl0ipgp1zrbm+Lhgl
 0rbQ==
X-Gm-Message-State: APjAAAXILLKjkDSxbVSVZdoxtehMl8aHtPm758FhtkeRdOIT4+AWbK8V
 3O/jWpRvRomYZsX9C45eEoO+Ka4Ybyae2hFgdi1FZQ==
X-Google-Smtp-Source: APXvYqxSccXA/VUA/6JwG1W+T505ogTb6cCEY1XA3skvxQHV+dYiYJA75B70f0UwwhMZGG1vCcs3UYjo4MLfLh9fEqXVcw==
X-Received: by 2002:a25:aa87:: with SMTP id t7mr327533ybi.419.1556751907604;
 Wed, 01 May 2019 16:05:07 -0700 (PDT)
Date: Wed,  1 May 2019 16:01:26 -0700
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
Message-Id: <20190501230126.229218-18-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2 17/17] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
From: Brendan Higgins <brendanhiggins@google.com>
To: frowand.list@gmail.com, gregkh@linuxfoundation.org, keescook@google.com, 
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org, 
 sboyd@kernel.org, shuah@kernel.org
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
 wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 richard@nod.at, linux-kernel@vger.kernel.org, daniel@ffwll.ch,
 mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c78ae95c56b80..23cc97332c3d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12524,6 +12524,7 @@ S:	Maintained
 F:	fs/proc/proc_sysctl.c
 F:	include/linux/sysctl.h
 F:	kernel/sysctl.c
+F:	kernel/sysctl-test.c
 F:	tools/testing/selftests/sysctl/
 
 PS3 NETWORK SUPPORT
-- 
2.21.0.593.g511ec345e18-goog

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
