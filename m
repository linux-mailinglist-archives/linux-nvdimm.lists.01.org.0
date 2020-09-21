Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39743273204
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 20:35:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5F449139E74BD;
	Mon, 21 Sep 2020 11:35:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN> 
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE57113568218
	for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 11:35:02 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 67so9777014pgd.12
        for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/2Z8IartBkPtffqIjRI7bDn8ReaBQI4yKoJOHK76NzU=;
        b=N5VnRGG3UinLkmKATCgG20q65Ejs+/qK8kOdK6WTtEAzuq6GtOBWcP/A2Xc/L2DDHl
         FeAQ+dJzzzWSZdUZNBEZxz9MGUqoadPHzHPfiTRTiKBmt2Vaybqt9XMVQC7cfNbyYrSB
         O7M5aTKfIdUWnCmCeHADhfe+R49GLTvWguPCFVpXr/3TNR8DgmbgYLHfwjzn4z+/btRx
         KTy8zA2w2qPGp/0zzljIPNGTM/ZLFgjOBu2Crv1L+mux1usIFczRz+CMyyM3QkRAzs+w
         Cz43LvV9wOy7f6nRW6lDZiRkU0DLOdk9ODdcjB1I1fTu0alTg3vphjgLHXBhb2ChEa7S
         uKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/2Z8IartBkPtffqIjRI7bDn8ReaBQI4yKoJOHK76NzU=;
        b=Rt+K9eOwadJen7yUpe+/CGm+uMG3hSzGSVrfYzKLfV848JowYzpuWB2evsva0Cm5Is
         Vv9bznpscdHalUJXEMbNxwFXsYJSvQZ47iINFmRRmRy9DDhc/nH3IXlNlS5HjE2EldZM
         R+bwOLbSPTwRMGCj1LPbDtAiih1cQ+/pvD90wNJVwp4LYrtU6Yvf9mgQ50EGjf92xIRq
         XW9AOCMY+j5ay4XdPZCrNpf9MuG5+5VYSsd20y9GO3GXUy8KLgKWpOqrrh2CSdRd0ZDZ
         rToZu9/hMjR6wA3N1O4Aa1KX9ulU8JhHZr3MKqDQSxp1d1ai8PV9879/btFbdJkvCymc
         kP/g==
X-Gm-Message-State: AOAM5338AOacee3FDBE3FzgqFDjvESJ+yw+tbFY9CdcnahsjvQR9jvNl
	i1/IuL4BKYCvXdEPzdS/zxTny/gBF0VCpd9LpmAlOw==
X-Google-Smtp-Source: ABdhPJwzOLY3JOyQMdXQlvGgHxA7es13k1t0ixfOKnHwmIn512BrNKuuEDqN2QxAEj7fYfAaMxDEPoHbj71Ti5BiV3o=
X-Received: by 2002:a63:7882:: with SMTP id t124mr685123pgc.381.1600713302134;
 Mon, 21 Sep 2020 11:35:02 -0700 (PDT)
MIME-Version: 1.0
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 21 Sep 2020 11:34:51 -0700
Message-ID: <CAKwvOdkGd6mPw_OKHwmpVs_xxFW2oqAoXyr7M8hu3PCCwkqCEQ@mail.gmail.com>
Subject: =?UTF-8?B?ZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiDigJhkYXhfc3VwcG9ydGVk4oCZ?=
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	dave.jiang@intel.com
Message-ID-Hash: TBQO2UTUHS6OGDH4HYHY4R6MCVM4MKFO
X-Message-ID-Hash: TBQO2UTUHS6OGDH4HYHY4R6MCVM4MKFO
X-MailFrom: ndesaulniers@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, clang-built-linux <clang-built-linux@googlegroups.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "kernelci.org bot" <bot@kernelci.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TBQO2UTUHS6OGDH4HYHY4R6MCVM4MKFO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello DAX maintainers,
I noticed our PPC64LE builds failing last night:
https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047043
https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047056
https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047099
and looking on lore, I see a fresh report from KernelCI against arm:
https://lore.kernel.org/linux-next/?q=dax_supported

Can you all please take a look?  More concerning is that I see this
failure on mainline.  It may be interesting to consider how this was
not spotted on -next.
-- 
Thanks,
~Nick Desaulniers
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
