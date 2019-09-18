Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18605B6FC0
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Sep 2019 01:40:35 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 36CE1202EA936;
	Wed, 18 Sep 2019 16:39:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C5E09202EA932
 for <linux-nvdimm@lists.01.org>; Wed, 18 Sep 2019 16:39:42 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z6so1481271otb.2
 for <linux-nvdimm@lists.01.org>; Wed, 18 Sep 2019 16:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PDQmKC/gOMi6sqZQA7S/aMJ9nwprCWZMCL6cDdDtiwo=;
 b=g8sIiTEUBjwC+jypUemhJSEmv702F9Wm/OQ2yvgmSceH+YZ9TxygCePbNrYI9DjIMI
 QSVrOoN8zmC6+1UX8tJ6WVHh4sA9vGCkaI7q7ebzxUnvEk/XNQxfZ9O9fiZ1mAAArD/F
 SNacoKkcB2wWT6XFmeZ6gPp7SkarL28rhJGFA8pVIZbbHN1xwRW1q/Y0WFEYWtTXLdD8
 xhUMR4yM79Gaiq79K8LkdUGo465NZ6oTNyiAQUBcqjo1C7zHU/fSvIV7MSqKuAHd4p1u
 Mzm5LHoHcYXkOiVGlntTvZzvSL9EKYpe3ec7uy1T493+iO8CiJlMJTa4zC/87w+4VKaf
 YQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PDQmKC/gOMi6sqZQA7S/aMJ9nwprCWZMCL6cDdDtiwo=;
 b=hoYZN5OXRbC5laEhq+hcRCgrkK5uVuRvazb3Ux4p+lDgL1mf0ilEYtBTPjAngK/fxZ
 l2mVBHYyG21Yrq2fTyY3JOS3bP+p8NmVm9jKatm43/PwG8HBkr9PrynD3Cyxyqv2vnhv
 ceW9+NYr1lY5BwzOIoOxvQyVgNC8QgOHHD5YYpvfJ5VZS+O2T0Mg+pN3XeAJyhsgakpQ
 wukYxn17TsSh5G4uyuob2pFel8cpM0hb+gzpOP60+h0K6QLHKBzJJl2JMrhpmGp+R9Hi
 J0kUrwQLrFqaSTDJ0SI7m0SxlGWzY5GineesjfDdTXXcxDRehvU0GDMNyLK2dOZh1iNR
 vDMg==
X-Gm-Message-State: APjAAAW3OUS/uOrbr7Rt+6hS+ksul4+aLREkrHTtqxQMYnR4I0HnWHhu
 S0pgUVfahOeirprYV2A+g0nme7Cg5jRm5EWg6a7tfA==
X-Google-Smtp-Source: APXvYqy/eeyRCXrtqIXQiK+EIL6EIZYEXp405qr/gxBJydI6Go09Ucme6OvwkC4jXQNVr3w/eolqtR0naKQMNido3N8=
X-Received: by 2002:a9d:5ccc:: with SMTP id r12mr4419959oti.71.1568850030063; 
 Wed, 18 Sep 2019 16:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190918042148.77553-1-natechancellor@gmail.com>
In-Reply-To: <20190918042148.77553-1-natechancellor@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 18 Sep 2019 16:40:18 -0700
Message-ID: <CAPcyv4g-aCrn7pq967rFJ+K_ENifNkZ_azLg6S03V8TGuFdOhg@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/nfit_test: Fix acpi_handle redefinition
To: Nathan Chancellor <natechancellor@gmail.com>
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
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Sep 17, 2019 at 9:23 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> After commit 62974fc389b3 ("libnvdimm: Enable unit test infrastructure
> compile checks"), clang warns:
>
> In file included from
> ../drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:15:
> ../drivers/nvdimm/../../tools/testing/nvdimm/test/nfit_test.h:206:15:
> warning: redefinition of typedef 'acpi_handle' is a C11 feature
> [-Wtypedef-redefinition]
> typedef void *acpi_handle;
>               ^
> ../include/acpi/actypes.h:424:15: note: previous definition is here
> typedef void *acpi_handle;      /* Actually a ptr to a NS Node */
>               ^
> 1 warning generated.
>
> The include chain:
>
> iomap.c ->
>     linux/acpi.h ->
>         acpi/acpi.h ->
>             acpi/actypes.h
>     nfit_test.h
>
> Avoid this by including linux/acpi.h in nfit_test.h, which allows us to
> remove both the typedef and the forward declaration of acpi_object.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/660
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> I know that every maintainer has their own thing with the number of
> includes in each header file; this issue can be solved in a various
> number of ways, I went with the smallest diff stat. Please solve it in a
> different way if you see fit :)
>

Looks good to me. I'll pick this up for a post v5.4-rc1 push.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
