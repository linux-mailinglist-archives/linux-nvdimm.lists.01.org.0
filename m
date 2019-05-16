Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6E720EA2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 20:27:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B2B522125ADEC;
	Thu, 16 May 2019 11:27:49 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BC80F21BADAB2
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 11:27:47 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w144so3241269oie.12
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+Y+Oy6YWaHW3Y5EmZplWPCzvPKWgZJckhlgjaNz/4A4=;
 b=kmCA/ecDeCxycovbrXLXCxmJKC2gNWQrig4EB41Rfpt3BcdU9SN4HillTadniXfdTw
 Bph3ZtI/7E9NtUQLrXslh4joaSt2kxFsm+CnuxdRo601rTRf2yW5e0YsyRYewIbMVuqC
 Nh1TTMxkYm86rHxldOjJC7TdcPXkBAUp3mX4sOtKgAs9elzTw+CkrRy0qug4tMPTre5E
 Ew8GoEWjdKFYwRIRuc7hNBgRkydeHzZj5yHWCVsV7TSEPuSZu+e+zhslXIrYhQyHDW0n
 /395cIUVH11nUHkt95Y2xHNeWzpfpwjcbTgToE3jP1WU9tnRzuNMH0P9a56LmR6e1aTh
 dhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+Y+Oy6YWaHW3Y5EmZplWPCzvPKWgZJckhlgjaNz/4A4=;
 b=Y7bhAk2f8f9NEKKHi80zs4kHXdUbPoOlKL0OTAF9ybUEz65h+K4U+hQbR8tSxyBqom
 ojTv4nCWBqoblMYRefO4nYGSsvzbr96Um1XuKUhF3tCd5moIzKTo3ZxvbarhCm80aUat
 IP3g5ONBmpkN59O7YnaDjdU93n9h+Rn30WOGyrViv7bJhh5JayfukOEh+j/6zNkP7agB
 cKGM8pZpCJXMt0ljWqVciOO+FhnrRdHLnjUhxfjGxOKdX16Gn9QI77hNjVxa9r6ME41p
 7hdgKekSneJOgS6YqXLK7nPSVERpoHdYIK4aBPqk6f8qwFqZxi+KBrEobcMionRr6DCA
 bKNg==
X-Gm-Message-State: APjAAAUlsJbz+oINj7DB45zq98zGtQ5kIQA9lBSxEUeJf+y8mWZadPug
 jD31tdY/YOhXFBGPEZt9NmktFbGEDFeFpaXuv50cBg==
X-Google-Smtp-Source: APXvYqxYBblZJBgYSIlhubthLqgDnClOs30HE4kc12ldNOKu1qTw/psxOmXhYfknENYh987lHsPCQVQZ7Gl70ZShJ34=
X-Received: by 2002:aca:dfc4:: with SMTP id w187mr11276071oig.70.1558031266988; 
 Thu, 16 May 2019 11:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <1558022693-9631-1-git-send-email-cai@lca.pw>
In-Reply-To: <1558022693-9631-1-git-send-email-cai@lca.pw>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 16 May 2019 11:27:36 -0700
Message-ID: <CAPcyv4jJ4AX7OKLBMo3SSomrneRef6OB=qpBESiQwAinnM+How@mail.gmail.com>
Subject: Re: [PATCH] nvdimm: fix compilation warnings with W=1
To: Qian Cai <cai@lca.pw>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 16, 2019 at 9:05 AM Qian Cai <cai@lca.pw> wrote:
>
> Several places (dimm_devs.c, core.c etc) include label.h but only
> label.c uses NSINDEX_SIGNATURE, so move its definition to label.c
> instead.
>
> In file included from drivers/nvdimm/dimm_devs.c:23:
> drivers/nvdimm/label.h:41:19: warning: 'NSINDEX_SIGNATURE' defined but
> not used [-Wunused-const-variable=]
>
> Also, some places abuse "/**" which is only reserved for the kernel-doc.
>
> drivers/nvdimm/bus.c:648: warning: cannot understand function prototype:
> 'struct attribute_group nd_device_attribute_group = '
> drivers/nvdimm/bus.c:677: warning: cannot understand function prototype:
> 'struct attribute_group nd_numa_attribute_group = '
>
> Those are just some member assignments for the "struct attribute_group"
> instances and it can't be expressed in the kernel-doc.

Ah, good point, I missed that.

> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Qian Cai <cai@lca.pw>

Looks good, I'll pull this in for a post -rc1 update.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
