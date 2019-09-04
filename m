Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E99EAA9462
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Sep 2019 23:01:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A04C321962301;
	Wed,  4 Sep 2019 14:02:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id ED5612021B709
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 14:02:47 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w6so4603085oie.11
 for <linux-nvdimm@lists.01.org>; Wed, 04 Sep 2019 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gbMg2gT0eK1ry/hW9bYxRjvZXvQWZKvryvSEwWRLJg0=;
 b=erBPdxgMv8hGKO1Tnsra/Y0ig1EPkqyi7/BzfJ9LCdZDss/rBQb+WD+fHb3l095+/M
 S/pTuiuP+WtBAQK/C1Q2qfK9jyqRoc3wE498DUh2jmQSzD3X84O1woxxJKWPHNKjuoNK
 hypuYwahJ5q/fAmfqxmHzf5Is/YJgC5wLuFo6IYYSKE9XzsttBuoXH9233L9vs/8pIrw
 sXfs0jfW59k+GvZI0InIsOc2F2YZrqQaMTjpWlaIJKEtrSLliCrPjzMC59CtD57EeDs7
 qOwhrI4cfsbfJx28yw1P6Wpqa0Biyjt7aqOuDJeVQXSi2QlCSdZO5j/Pdw1FlkkkZH3G
 Covg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gbMg2gT0eK1ry/hW9bYxRjvZXvQWZKvryvSEwWRLJg0=;
 b=L1+i0cHd6BdkuwYIpgH6B5Wb++EtQu9fE941fDKZL8FYs8vdRvoAXG01j6QuFnJgwj
 CFPkXErZHsDsioXs5JVmkXynpWC/1A4RiaNaa/zKSSyz+r+38AZ1lt6Ti3nwIBz3nDmD
 Sunuao1Wu+40AC0qFeytL65+y+jE5Lnd4KG8DpPhyAFnxlN990QerNsN/A5iG07BI9+u
 wjvKPjRmqeago0/M8GAh3tvhZfN0OI4ckRz9heviUHjmr6G/o2ve+k24WJ4aa5Smr0y2
 enrKRlDDFK1TAEKWH7QdzXT/tqNjvgEZKGV2Q4B5LNRVxMS7S8ansdpcVRnMLUo0xo4w
 ErEQ==
X-Gm-Message-State: APjAAAU4txClJb19zOvQxUapaozFO6Ulhj741XwZx4Ps2W+tn4h0g4uA
 usefxDkgeSuypp7yIAm1VNPp42cOVML6HW9eIOUlCg==
X-Google-Smtp-Source: APXvYqztkFpRq3nTXNSzv7MMbrzlb38n8pB+OYMHf3vroP9b5CfP94qF0Gcjb2EILd1NzenUiEVhqW/UXWjeUxjhL5c=
X-Received: by 2002:aca:4b05:: with SMTP id y5mr54097oia.70.1567630902756;
 Wed, 04 Sep 2019 14:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190904010819.11012-1-vishal.l.verma@intel.com>
 <20190904010819.11012-2-vishal.l.verma@intel.com>
 <CAPcyv4ipdLhKSUVZ-U3ZFpcuw=tJJTq1ZW5x6vJ-bJNReyjJbQ@mail.gmail.com>
 <be47815b3d454ce76a81799ba355b5579713c916.camel@intel.com>
In-Reply-To: <be47815b3d454ce76a81799ba355b5579713c916.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 4 Sep 2019 14:01:31 -0700
Message-ID: <CAPcyv4inooSbqCaAXJ4KzwVMxcDpfKpMD2QG5aXOP_sKnFy6UQ@mail.gmail.com>
Subject: Re: [ndctl PATCH 2/2] libdaxctl: fix device reconfiguration with
 builtin drivers
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
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
Cc: "Brice.Goglin@inria.fr" <Brice.Goglin@inria.fr>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Sep 4, 2019 at 1:27 PM Verma, Vishal L <vishal.l.verma@intel.com> wrote:
>
> On Tue, 2019-09-03 at 19:20 -0700, Dan Williams wrote:
> >
> > > +static int try_kmod_builtin(struct daxctl_dev *dev, const char *mod_name)
> > > +{
> > > +       const char *devname = daxctl_dev_get_devname(dev);
> > > +       struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> > > +       struct kmod_module *kmod;
> > > +       int rc = -ENXIO;
> > > +
> > > +       rc = kmod_module_new_from_name(ctx->kmod_ctx, mod_name, &kmod);
> > > +       if (rc < 0) {
> > > +               err(ctx, "%s: failed getting module for: %s: %s\n",
> > > +                       devname, mod_name, strerror(-rc));
> > > +               return rc;
> > > +       }
> > > +
> > > +       if (kmod_module_get_initstate(kmod) != KMOD_MODULE_BUILTIN)
> > > +               return -ENXIO;
> > > +
> > > +       dbg(ctx, "%s inserting module: %s\n", devname,
> > > +               kmod_module_get_name(kmod));
> > > +       rc = kmod_module_probe_insert_module(kmod,
> > > +                       KMOD_PROBE_APPLY_BLACKLIST,
> > > +                       NULL, NULL, NULL, NULL);
> > > +       if (rc < 0) {
> > > +               err(ctx, "%s: insert failure: %d\n", devname, rc);
> > > +               return rc;
> > > +       }
> > > +       dev->module = kmod;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static int daxctl_insert_kmod_for_mode(struct daxctl_dev *dev,
> > >                 const char *mod_name)
> > >  {
> > > @@ -877,6 +908,8 @@ static int daxctl_insert_kmod_for_mode(struct daxctl_dev *dev,
> > >         int rc = -ENXIO;
> > >
> > >         if (dev->kmod_list == NULL) {
> >
> > Hmm, why wait until now to check if this list is NULL. How about fall
> > back to kmod_module_new_from_name() at to_module_list() time? That
> > would seem to simplify this follow up routine to not need to worry
> > about working around a NULL list.
>
> So we moved the list checking to later in the process around v4 of the
> original series, so that we don't unnecessarily fail add_dax_dev() if
> for some reason a list wasn't created.

Ah true, I forgot that wrinkle, however...

> Also, we use mod_name = dax_modules[mode] during an 'enable' to
> determine the module name to use for the fallback - we wouldn't have
> this at add_dax_dev() time.

Since modalias is already not reliable it seems the implementation
should go ahead never do module lookups and just do everything based
on module names.

In other words the libndctl panacea of not needing to hard code module
names is already lost in libdaxctl land. If the code drops modalias
usage does that clean up some of these flows?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
