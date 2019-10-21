Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3526DF596
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Oct 2019 21:04:08 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EEFFE1007A2F3;
	Mon, 21 Oct 2019 12:04:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7D70D10077F8D
	for <linux-nvdimm@lists.01.org>; Mon, 21 Oct 2019 07:45:05 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 21so11162445otj.11
        for <linux-nvdimm@lists.01.org>; Mon, 21 Oct 2019 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxMjjLmCV5wu1SmNNdDes4wpF04tbh7UfnzG8agpR2I=;
        b=SMM8mEPV5eIu4/MGnm96tEXoZP/uFIWNabBj+JlhE1PpBLziaE6xkdwXDD3R7SFApE
         b7CBRP/aIKTqteGouH/nWWkMGLuNkDsJ+38UcnHH9GKzx8ufmkHQ9ndW3044/R5QIWm+
         b3oXY6yHKbCMLYaxpGMu50UbVsFyaYeOSPMu6TKt+7IZ9AW907IT8hQhpmtibI7k7IgL
         hJb/YKf5bOtScYctW3xRu7BheXgJQL90Nl4L8SP5hSkBj6Pw1eFda14kOt4G2Yyk2azO
         EaNGeuETqvNrnBF6glEtn2nBIA3ykxMyD0bp7KHDqiI83KemtUQhIxRwtFAQcsB5WHXz
         4k4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxMjjLmCV5wu1SmNNdDes4wpF04tbh7UfnzG8agpR2I=;
        b=INcVau/BOt5sVNaOndcwPc7kwhDfVDkSuhQqLt3Jq9ksB3Y+8o0EF0mlhrDcd+4HoK
         tazv7yRM2b8BR005A2oJ36NzsElOh1r9Xnl3wJwZF520hhonaJdnyQh22Rtokl8b4Nz/
         QAqSCi9DTQGD+nsrX9dRAvgn2/xhR6m5I2KXX2C0QAovznvvNmTFCtOZRFwDvuhXxCHh
         Z3gOC70SmGqfqV26Z+VfUX/Hsj3+5Ryfk7XMh9spl2usKDk4FJ25B1h1zFX0hvK68ZXM
         AFRA9UyKiLpq8Ax1kLz0TmRm8g3g8Q0ECwTD04czfoYA9r4ixaltH22oDbhfyG5nJFYP
         vLkg==
X-Gm-Message-State: APjAAAVubECHAD7YdX1o471zvnkQYkCFy+/uIwaZ3589q/1YwfSG0Jwd
	s6VjzjmA7gk7Rd4I40+wu4/0dOXasnwk4dfPJJ8lfw==
X-Google-Smtp-Source: APXvYqwnfS9nd3wLOGs0D0OfKHD+SBxl97XKF9D56iGQIcLGlwPyed8/yOfLu8En+dOBF5iJpDt1gOXwywtP/o3xkzA=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr19200169otn.363.1571668999984;
 Mon, 21 Oct 2019 07:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191018123534.GA6549@mwanda> <CAJZ5v0jeoJrrn56VqRSoY-Mc9rp04tWYbTCsQugZV=vXQk0nNg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jeoJrrn56VqRSoY-Mc9rp04tWYbTCsQugZV=vXQk0nNg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 21 Oct 2019 07:43:10 -0700
Message-ID: <CAPcyv4jL=7WFjxK1UmWRoxup0gDzjapLdt7GxwOsg1xYEPr4ew@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: unlock on error in scrub_show()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID-Hash: F2QATVUEZCUIBBZ65YRGWU7N4DFZBTSU
X-Message-ID-Hash: F2QATVUEZCUIBBZ65YRGWU7N4DFZBTSU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dan Carpenter <dan.carpenter@oracle.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F2QATVUEZCUIBBZ65YRGWU7N4DFZBTSU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Oct 20, 2019 at 4:35 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Oct 18, 2019 at 2:38 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > We change the locking in this function and forgot to update this error
> > path so we are accidentally still holding the "dev->lockdep_mutex".
> >
> > Fixes: 87a30e1f05d7 ("driver-core, libnvdimm: Let device subsystems add local lockdep coverage")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/acpi/nfit/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index 1413324982f0..14e68f202f81 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -1322,7 +1322,7 @@ static ssize_t scrub_show(struct device *dev,
> >         nfit_device_lock(dev);
> >         nd_desc = dev_get_drvdata(dev);
> >         if (!nd_desc) {
> > -               device_unlock(dev);
> > +               nfit_device_unlock(dev);
> >                 return rc;
> >         }
> >         acpi_desc = to_acpi_desc(nd_desc);
> > --
>
> Applying as a fix for 5.4, thanks!
>
> @Dan W: Please let me know if you'd rather take it yourself.

If you already have it applied, I have no concerns.

Acked-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
