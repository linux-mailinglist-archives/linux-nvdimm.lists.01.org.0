Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E489AA9551
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Sep 2019 23:40:11 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 64C4A20260CEB;
	Wed,  4 Sep 2019 14:41:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 012242021EBD8
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 14:41:11 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h4so27328oih.8
 for <linux-nvdimm@lists.01.org>; Wed, 04 Sep 2019 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=du14M5TANbFhdAEbuVrturUJ8CXo21DYse7m61TlUNI=;
 b=F0z/I2Uve7i5Y4DWLqDrdF3R/H8NxNbEiGshr+b93SqjXMKItwR1Bo8rANEPHBVuug
 46qQM0fTZa/vKSePqdkSFsLFnKFSmoU7R47VPO035IqDrW0gsM7O/mDe+Qx2xJO2H2P/
 i+Sgb+Raw9imoK8tXCm7r4DQjADrU3CMLT240Xv1TQ61zDpCgFKkCz4LJWNguwbKMz9w
 hYWmG4JhPYRi4Ti2DlFs90Nf7yhSJXU3Q2BRRIFxjwiNfa3sWTdGQct0wJBn5BlvVFyD
 AQ5fXhqLHasocpToocoFzqXQexu/bD8/XMypiExqH75MV1FXLFc9QDI++7tGwD85FPqx
 zaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=du14M5TANbFhdAEbuVrturUJ8CXo21DYse7m61TlUNI=;
 b=f1ocb45pnxlNozp1OawSVdoauP7kn6Dnvb+uMMFrS5hx+7r/lLLEd9OLkrij45CipT
 vcU2VQeSablJCgZvEl+y0vm4lThz9fKLHPtkIHIzumPFZcFeysuVg7hVPDl1zDu+vqib
 V8+/QaJChquwD4Pc436qU+l1v0YJIIWCe21JFKIOM9yvyb287/VPn/CwCcfqG5MYL+FG
 wapsEkgcP9AR+73sN4HR+4ctUqGKBT5Il/+mTOR/rC9ngpWOG0xVtSdJIJt1ioZNZsyk
 mptdlX3p/AxRSFewy1wTCSJc7q/Dn9Z7W8zMiiSNUAoAxIz5xgGVDllfRsmUJ+oGqtwm
 KDDg==
X-Gm-Message-State: APjAAAVaiRRWH73bzM8K/1GTxzeJN0T355QpQzDOh8fCFwMRzIzbjFF1
 7nKaUoJHZ7Tr2mH9onoYOGOfYI1DmumddSnjfAMGYw==
X-Google-Smtp-Source: APXvYqxmG8v2SFRyW6F8mr9tFjXI6rXAcnYPdaJQZBJA6X5ITX1BEruXzJyHn6lF1Iec9H9O71L7Q6C5UEQtrhxQbWM=
X-Received: by 2002:aca:5dc3:: with SMTP id r186mr140742oib.73.1567633207730; 
 Wed, 04 Sep 2019 14:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190904010819.11012-1-vishal.l.verma@intel.com>
 <20190904010819.11012-2-vishal.l.verma@intel.com>
 <CAPcyv4ipdLhKSUVZ-U3ZFpcuw=tJJTq1ZW5x6vJ-bJNReyjJbQ@mail.gmail.com>
 <be47815b3d454ce76a81799ba355b5579713c916.camel@intel.com>
 <CAPcyv4inooSbqCaAXJ4KzwVMxcDpfKpMD2QG5aXOP_sKnFy6UQ@mail.gmail.com>
 <25878b6903086ee20d332a02cd784065d93cea61.camel@intel.com>
In-Reply-To: <25878b6903086ee20d332a02cd784065d93cea61.camel@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 4 Sep 2019 14:39:56 -0700
Message-ID: <CAPcyv4iTH9SuCUNSJ0Snw5cz6YpX6O887PAkR6fPEmQ7iWRGmw@mail.gmail.com>
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

On Wed, Sep 4, 2019 at 2:17 PM Verma, Vishal L <vishal.l.verma@intel.com> wrote:
>
> On Wed, 2019-09-04 at 14:01 -0700, Dan Williams wrote:
> > On Wed, Sep 4, 2019 at 1:27 PM Verma, Vishal L <vishal.l.verma@intel.com> wrote:
> > > On Tue, 2019-09-03 at 19:20 -0700, Dan Williams wrote:
> > > >
> > > > Hmm, why wait until now to check if this list is NULL. How about fall
> > > > back to kmod_module_new_from_name() at to_module_list() time? That
> > > > would seem to simplify this follow up routine to not need to worry
> > > > about working around a NULL list.
> > >
> > > So we moved the list checking to later in the process around v4 of the
> > > original series, so that we don't unnecessarily fail add_dax_dev() if
> > > for some reason a list wasn't created.
> >
> > Ah true, I forgot that wrinkle, however...
> >
> > > Also, we use mod_name = dax_modules[mode] during an 'enable' to
> > > determine the module name to use for the fallback - we wouldn't have
> > > this at add_dax_dev() time.
> >
> > Since modalias is already not reliable it seems the implementation
> > should go ahead never do module lookups and just do everything based
> > on module names.
> >
> > In other words the libndctl panacea of not needing to hard code module
> > names is already lost in libdaxctl land. If the code drops modalias
> > usage does that clean up some of these flows?
>
> Yep I think so - we use modalias to construct a lookup list, but we
> still have to use the name to resolve to the final module based on the
> mode. I think we can remove the list lookup and replace it with simply:
>
>         kmod_module_new_from_name(ctx->kmod_ctx, mod_name, &kmod);
>
> It would clean up the module related flows, but is there any
> disadvantage to doing this?

The small disadvantage is that now libdaxctl is not immune to upstream
kernel reworks that might rename, or eliminate the module. libndctl
has that immunity to those type of reworks, but it is only a
theoretical problem. In practice modules don't renamed or eliminated
all that often. In the case of dax the device-model reworks almost
violated that assumption, but CONFIG_DEV_DAX_PMEM_COMPAT covered the
gap.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
