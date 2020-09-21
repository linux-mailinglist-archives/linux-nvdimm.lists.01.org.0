Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4532227322C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 20:47:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6F42713E17882;
	Mon, 21 Sep 2020 11:47:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DD0F01462B0F1
	for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 11:47:51 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id ay8so13813245edb.8
        for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyDbIcQAdvsX0pQDLSC3IzwQOFdxADNEZk7v/eXeHTc=;
        b=IoHznwPzHOT1/HK/4KdjNbW3VhuKGXl+P/cFZ5oOS8j7l6omlNvRVY+IX6ljbCmS4u
         Nm7ZCAXl8KTfXvYsSNmXHgC0uian9TgtQxLW+oi0tNX7fNWt89tv2IDtS3IssEV+OiAg
         mDL8abQO6xKee3Gp++DudPOLquaQrWDV+eRi0yhkTY2YNC9KqOtUuvBwDkwQokWnobrA
         ydVOgaXnbtflxVXc5lTvukwzoCJv7t73HFLvd0FWJP7GCnXVDWL4a3zlYb3vAavqu2CW
         tIuGeZj73fNt3triaqANlSDGLTWXI+DgTY2SZXAWF4y1XUb6DBXx4kCdpGDxGZH/LwGh
         4fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyDbIcQAdvsX0pQDLSC3IzwQOFdxADNEZk7v/eXeHTc=;
        b=jN4sLvFGJzmYksuYU2DHFzkcNS8GtiGmhXeZJ7D+J3o6BGKCp1qt2igKBPdH/RX7b2
         DSxIlOUNOYM/UXP4t6zq29lVw3Iw8FZ+QT0quS0j9am7dV1vX+KF98s8maOFf+dfUGY9
         3ireFGhOrydWoxQAjQ3UgoqMGUi51VJTt9bG9jR69fMthSZrJ8fqLZj/sDuagfzr7FV6
         KhoAe/lwHtV1EcLwQlG0OzlzNf2AEosjDO8yvL3kGcCLT8ZeaShxnBqxhyMT6lldw0gA
         mMCxelel5IG2tcveaxD5dqNGMi4mrMzdDa1s40dFsjurCDoLiq6Rh0HhDvyWPVHNWgJ7
         Q36A==
X-Gm-Message-State: AOAM5335BOgWfX1kycHX87CQQuQ7kYyuCAq9Nv+jNPss3BQ3TpobzBHe
	xA6TD8K88AL0dWjkjNSam9rsAOj4hdvSPpq4/BXyTA==
X-Google-Smtp-Source: ABdhPJyr3HoCDSaaSE6/nQdSCDm40TS19EV3SXSzVioIoKdk8F7Y7f0V8JbN08ev9d+bgVmhdVvRbDDZMn9JIW+Dx+I=
X-Received: by 2002:aa7:d04d:: with SMTP id n13mr324028edo.354.1600714069342;
 Mon, 21 Sep 2020 11:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkGd6mPw_OKHwmpVs_xxFW2oqAoXyr7M8hu3PCCwkqCEQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkGd6mPw_OKHwmpVs_xxFW2oqAoXyr7M8hu3PCCwkqCEQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 21 Sep 2020 11:47:38 -0700
Message-ID: <CAPcyv4jZfbuS8zHZXBNqRTi_1HzHLUztkxDmsruMk5PGinGhPg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IGVycm9yOiByZWRlZmluaXRpb24gb2Yg4oCYZGF4X3N1cHBvcnRlZOKAmQ==?=
To: Nick Desaulniers <ndesaulniers@google.com>
Message-ID-Hash: OIJKH457TY726UJB32GVENGGDFHWYUJL
X-Message-ID-Hash: OIJKH457TY726UJB32GVENGGDFHWYUJL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, clang-built-linux <clang-built-linux@googlegroups.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "kernelci.org bot" <bot@kernelci.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OIJKH457TY726UJB32GVENGGDFHWYUJL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 21, 2020 at 11:35 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Hello DAX maintainers,
> I noticed our PPC64LE builds failing last night:
> https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047043
> https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047056
> https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/388047099
> and looking on lore, I see a fresh report from KernelCI against arm:
> https://lore.kernel.org/linux-next/?q=dax_supported
>
> Can you all please take a look?  More concerning is that I see this
> failure on mainline.  It may be interesting to consider how this was
> not spotted on -next.

The failure is fixed with commit 88b67edd7247 ("dax: Fix compilation
for CONFIG_DAX && !CONFIG_FS_DAX"). I rushed the fixes that led to
this regression with insufficient exposure because it was crashing all
users. I thought the 2 kbuild-robot reports I squashed covered all the
config combinations, but there was a straggling report after I sent my
-rc6 pull request.

The baseline process escape for all of this was allowing a unit test
triggerable insta-crash upstream in the first instance necessitating
an urgent fix.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
