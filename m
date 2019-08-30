Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12EBA2E9E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Aug 2019 06:40:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C77172021EBD9;
	Thu, 29 Aug 2019 21:42:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BD644202110C1
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 21:42:44 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id p23so5762833oto.0
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 21:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=znlSjFifR4bZCt8WzGvCBM2x7ZoHG5Iy5U5fRW1Bzm0=;
 b=mPsEPoJQUF8K+6VZeF61RSBRggyblB9YKNxDH0gf++ISCxuiTvADbQwXrgWT2t4qF2
 9VxOa+yHr2s2zLB8hzngymhk0kpGR49kkte2QUoVIZa0E+LidmYl5JM7RNA7/mQ3unbZ
 QC432iTHIwfX2heX5kbJLDERvkpz24VaHOAufSx6e/VR+itHzNpyS1wtHlXDP5SqEapc
 Nr4Vah5Jw7r6o3m3y9SgCFSuFVa1bdpsPfNPOMl37rsHXEbqTO4UDqCsyKiobbXafT3h
 PLaY6Lfu0SltUo+mwM2CIrq4ur7na36FDNrc5/fmKqa7+DJCC04gGF7Exn3ySdh00dT5
 k8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=znlSjFifR4bZCt8WzGvCBM2x7ZoHG5Iy5U5fRW1Bzm0=;
 b=PAoCIGJwYlmqZ7H2BTSfpeL2XqXc3+jwuJV9zT0Mkn8O3MVvxJDiFNKCeoGcnxxVkX
 E5WMntkGf9jUtYRwSJYn7eKVa8IE9WQ1oLYUBRino+WzmiGpXERLjWNBM2SIQbMtRf3e
 LyvR2GwwrQigBDAfL+JCLiPEKJBWShwK+fdtvq/KIgbhqvc9oVCFyiK2Gtxo2lJJ2OM8
 8gZVfR8NDRtaWf5vn08YIMlqixRj0iiGa4vlEA3MVF/eJQp9ISNLx22yjozjjO3KWbi2
 OH9hRR6UeH7vDKNkyZ+niqm+iD6e3l08iBVrDM3xdlaFUgz6K4ku5B8iL5/g2F6h6K36
 vxoA==
X-Gm-Message-State: APjAAAXKeoXHF99JcDW24hIrAfBfyQ3bpsT07U+QSGl9rLCXFvbYeNRh
 4EXHiasmb3ktSv4CFMSk6Zr/30QABUIa8nEdz9Zb+A==
X-Google-Smtp-Source: APXvYqytSWHkfo/foSLfUBrw4QUL2WMCpBFUJSuOYERHzhr3tmvt6BIvBWfzK3jseiHDW60Ixi13NW2xnIsWg848RO8=
X-Received: by 2002:a05:6830:458:: with SMTP id
 d24mr10487665otc.126.1567140054908; 
 Thu, 29 Aug 2019 21:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190807040029.11344-1-aneesh.kumar@linux.ibm.com>
 <156711523501.12658.8795324273505326478.git-patchwork-notify@kernel.org>
 <87lfvbnujk.fsf@linux.ibm.com>
In-Reply-To: <87lfvbnujk.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 29 Aug 2019 21:40:41 -0700
Message-ID: <CAPcyv4g7nQ201DV6r1-2Jq2vyHWzstHD2txwZvR5z6NMY_mqiw@mail.gmail.com>
Subject: Re: [PATCH] nvdimm/of_pmem: Provide a unique name for bus provider
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Aug 29, 2019 at 9:31 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> patchwork-bot+linux-nvdimm@kernel.org writes:
>
> > Hello:
> >
> > This patch was applied to nvdimm/nvdimm.git (refs/heads/libnvdimm-for-next).
> >
> > On Wed,  7 Aug 2019 09:30:29 +0530 you wrote:
> >> ndctl utility requires the ndbus to have unique names. If not while
> >> enumerating the bus in userspace it drops bus with similar names.
> >> This results in us not listing devices beneath the bus.
> >>
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> ---
> >>  drivers/nvdimm/of_pmem.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >
> > Here is a summary with links:
> >   - nvdimm/of_pmem: Provide a unique name for bus provider
> >     https://git.kernel.org/nvdimm/nvdimm/c/49bddc73d15c25a68e4294d76fc74519fda984cd
> >
> > You are awesome, thank you!
>
> We decided to fix this in ndctl tool? If we go with ndctl fix, we
> can drop the kernel change.

Oh, I was planning to do both any concerns if I keep the kernel
change, otherwise I'll need to rebase the branch.

> Parallely I am planning to do a  fix
> for papr_scm driver that will update the provider name as "papr_scm". That
> way we can find out the backend driver using
>
> :~> ndctl list -B
> [
>   {
>     "provider":"papr_scm",
>     "dev":"ndbus1"
>   },
>   {
>     "provider":"of_pmem",
>     "dev":"ndbus0"
>   }
> ]
>
>
> -aneesh
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
