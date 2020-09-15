Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 456B826AADC
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 19:39:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F3DF714DD0A54;
	Tue, 15 Sep 2020 10:39:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.194; helo=mail-oi1-f194.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 454D114D825AF
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 10:39:43 -0700 (PDT)
Received: by mail-oi1-f194.google.com with SMTP id m7so4862340oie.0
        for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 10:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgIuMsWuKwLw8HKrfM3Yi4VFysbOGkj72Chl+nIZli0=;
        b=Jc5yzqDbnVGBwt9ytdNcfC3kJOWoREjyci9G3QEvzyn+GWIWhrzyEDaHSfgxs2NCFX
         Dmt7c8aslVQPZ2T6PYwKiKAlchIwJOH0VzpWlnc1C19D9Tcpnf4w7rcUoi/rGY1bCbAo
         fviKJyGRmkZ+ZB6AA2g+IH3e8NP8NxDDAksaGLnuRJBq2tsXgFDmPEcJp/b7+LLNhWTV
         6y2Q+zj2/HeerFtLJ7jsHdeXgpHXbRVJDkI/CMVcQ0ryqA1BWsCBXU7mDmrzx34a9BuJ
         xbI1/JkgwTeXDeF03W4AmUgeADM4Hk7ujuMxqO1Ut5vFaKX0lQoYJEbR23kF7lyjlI39
         1qsQ==
X-Gm-Message-State: AOAM533CUlDjvzgFROdbFWT6xOywA6ZvsnnKepKzpw5A3BdG4TD0E0Ct
	XVycxZudXnvkYEFLFDEca3W/Jxjc3AZQtmpra/Q=
X-Google-Smtp-Source: ABdhPJxTm261fqP6s7VUyOJQXiMU4X0GOiKkSTJ3sNxgOmXbn0mO9MLalI7UITQ64YpedQWLzF8Gls774vUxN4TYflI=
X-Received: by 2002:aca:fd95:: with SMTP id b143mr396668oii.68.1600191582446;
 Tue, 15 Sep 2020 10:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <1597286952-5706-1-git-send-email-wangqing@vivo.com>
 <CAJZ5v0h=UmD33X_i80X3ww7nC=xQL7V8XaoNq2XvU_XcdQGfZQ@mail.gmail.com> <4e23dc722419e82d13772afc8e060d3203fd5a86.camel@intel.com>
In-Reply-To: <4e23dc722419e82d13772afc8e060d3203fd5a86.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Sep 2020 19:39:31 +0200
Message-ID: <CAJZ5v0jG-8Cwi1TfVDfgu+=q1MT+aY+aG15cAuthK7AvS1vYuQ@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: Use kobj_to_dev() instead
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "wangqing@vivo.com" <wangqing@vivo.com>
Message-ID-Hash: T3R5J3DJ5ZKWZJTETBN4HYIIYFQPAZQG
X-Message-ID-Hash: T3R5J3DJ5ZKWZJTETBN4HYIIYFQPAZQG
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "rafael@kernel.org" <rafael@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T3R5J3DJ5ZKWZJTETBN4HYIIYFQPAZQG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Aug 15, 2020 at 12:52 AM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Fri, 2020-08-14 at 17:28 +0200, Rafael J. Wysocki wrote:
> > On Thu, Aug 13, 2020 at 4:54 AM Wang Qing <wangqing@vivo.com> wrote:
> > > Use kobj_to_dev() instead of container_of()
> > >
> > > Signed-off-by: Wang Qing <wangqing@vivo.com>
> >
> > LGTM
> >
> > Dan, any objections?
>
> Looks good to me - you can add:
> Acked-by: Vishal Verma <vishal.l.verma@intel.com>

Applied as 5.10 material, thanks!

> > > ---
> > >  drivers/acpi/nfit/core.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > > index fa4500f..3bb350b
> > > --- a/drivers/acpi/nfit/core.c
> > > +++ b/drivers/acpi/nfit/core.c
> > > @@ -1382,7 +1382,7 @@ static bool ars_supported(struct nvdimm_bus *nvdimm_bus)
> > >
> > >  static umode_t nfit_visible(struct kobject *kobj, struct attribute *a, int n)
> > >  {
> > > -       struct device *dev = container_of(kobj, struct device, kobj);
> > > +       struct device *dev = kobj_to_dev(kobj);
> > >         struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
> > >
> > >         if (a == &dev_attr_scrub.attr && !ars_supported(nvdimm_bus))
> > > @@ -1667,7 +1667,7 @@ static struct attribute *acpi_nfit_dimm_attributes[] = {
> > >  static umode_t acpi_nfit_dimm_attr_visible(struct kobject *kobj,
> > >                 struct attribute *a, int n)
> > >  {
> > > -       struct device *dev = container_of(kobj, struct device, kobj);
> > > +       struct device *dev = kobj_to_dev(kobj);
> > >         struct nvdimm *nvdimm = to_nvdimm(dev);
> > >         struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> > >
> > > --
> > > 2.7.4
> > >
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
