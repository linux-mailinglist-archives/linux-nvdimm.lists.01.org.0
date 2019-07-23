Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FEF71FBE
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Jul 2019 20:59:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 75009212BF9A7;
	Tue, 23 Jul 2019 12:02:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A649921A07094
 for <linux-nvdimm@lists.01.org>; Tue, 23 Jul 2019 12:02:13 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id l15so45154469otn.9
 for <linux-nvdimm@lists.01.org>; Tue, 23 Jul 2019 11:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Gga3GN1sJSSGSoAetAJZPMlHuhtl3uxhTYisJ9liJac=;
 b=vaqX2lCQ6JSRLt86K+/9sTCf2B6tfGbYEXKIAuw6dB0fG4ALiF1AC4pLjgFjAQ8AHU
 3xmhyE1ECwsWZaLuE2TqQzAAYCNbjJNb0pEvMDTKQSTv8Hwjga4rHL8QOvqHWxMvS4Ol
 kWNAmVCC23ybzAQr4nNY9/VI/FKqfMHhpEKdyXQdj5qY1Tc/n+rsJfM87+kIuA2mNCfg
 CDD/jF4NiKZm4HtGzrHOp5UyUpmwbXADLPd0PEX8qEY6t5YRDVhMRWClp06ADQ6aedQZ
 bdYiw6mBqYvCEWYPR9Lco4OEPzpo8NoEamSRbSXLCGn72916nQ2ahhzvQHtijYxI2Onn
 zErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gga3GN1sJSSGSoAetAJZPMlHuhtl3uxhTYisJ9liJac=;
 b=RPso42rf3lN/SlusYG2GSx56HQYEBQeku9eC7Sy2FbvSwuQ9jlxil8QT/P7YWUONy/
 vAoDrEF+zv4ltJyQgWzWTqOFDLoxu3NCBbTvO/HCwjRJs3WSh9xvZ0EbzIBQRBjCEYr5
 6GgMvdAtlfOCnT/oZNgpfzUEjxQTB1tkCLa0RjWi8mJVK+/avGPfQDu2ugLO2jquVzus
 SpiJGmqUW/ROW5j8ZUTp/fL2NXoYsYbQNQGG/FIoLeGJKEWhj+ES7dhhFHEI+7blf7UB
 F6uyioNL9wYdG2AEgkPl8T4FSqumobb0mAIewK7SHKJ0UNGl5YngbasWjD7RcQwoKtNF
 MaBA==
X-Gm-Message-State: APjAAAWRiPvHgCuaOSbIWRhmD5Je5kj2biPFwkYuxmNoVpExaYgAqIOK
 P6+4ezeizLbAiDvvGRqRbn4/JND1OpeXAnACep+j5g==
X-Google-Smtp-Source: APXvYqxOCgvikuHmZY+dZf/65HKsO2YNUHkSb5AEehgUi/0I1YwhdbrTNy41F77BMU/QyxFr/gPimrom1hBqGZggjkE=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr52120939otn.71.1563908386594; 
 Tue, 23 Jul 2019 11:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <87a7f45qik.fsf@linux.ibm.com> <877ea85p64.fsf@linux.ibm.com>
In-Reply-To: <877ea85p64.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Jul 2019 11:59:35 -0700
Message-ID: <CAPcyv4hKSfeeo+eLu0=4-wca2TwBx5OJfaxD36o5uG8Vd=DibA@mail.gmail.com>
Subject: Re: Picking 0th namespace if it is idle
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

On Thu, May 30, 2019 at 1:20 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> aneesh.kumar@linux.ibm.com (Aneesh Kumar K.V) writes:
>
> > Hi Dan,
> >
> > With the patch series to mark the namespace disabled if we have mismatch
> > in pfn superblock, we can endup with namespace0 marked idle/disabled.
> >
> > I am wondering why do do the below in ndctl.
> >
> >
> > static struct ndctl_namespace *region_get_namespace(struct ndctl_region *region)
> > {
> >       struct ndctl_namespace *ndns;
> >
> >       /* prefer the 0th namespace if it is idle */
> >       ndctl_namespace_foreach(region, ndns)
> >               if (ndctl_namespace_get_id(ndns) == 0
> >                               && !is_namespace_active(ndns))
> >                       return ndns;
> >       return ndctl_region_get_namespace_seed(region);

Without this change if you create 2 namespaces, destroy those two
namespaces and then create another namespace that newest namespace
might end up being namespace0.1 instead of namespace0.0. This ends up
confusing end users that don't understand why they end up with
/dev/pmem0.1 and then at reboot it changes back to /dev/pmem0. So it's
purely a cosmetic detail.

I think we could teach ndctl about how to detect this case as separate
from a typically idle namespace state. Effectively pfn-device bind
failures due to missing page size support is a new error state that
ndctl needs to be made aware of independent of the typical idle state.
However, all I think is needed here is to fallback to
ndctl_region_get_namespace_seed() if ndctl_namespace_get_size() is
non-zero.

> > }
> >
> > I have a kernel patch that will create a namespace_seed even if we fail
> > to ename a pfn backing device. Something like below
> >
> > @@ -747,12 +752,23 @@ static void nd_region_notify_driver_action(struct nvdimm_bus *nvdimm_bus,
> >               }
> >       }
> >       if (dev->parent && is_nd_region(dev->parent) && probe) {
> >               nd_region = to_nd_region(dev->parent);
> >               nvdimm_bus_lock(dev);
> >               if (nd_region->ns_seed == dev)
> >                       nd_region_create_ns_seed(nd_region);
> >               nvdimm_bus_unlock(dev);
> >       }
> > +
> > +     if (dev->parent && is_nd_region(dev->parent) && !probe && (ret == -EOPNOTSUPP)) {
> > +             nd_region = to_nd_region(dev->parent);
> > +             nvdimm_bus_lock(dev);
> > +             if (nd_region->ns_seed == dev)
> > +                     nd_region_create_ns_seed(nd_region);
> > +             nvdimm_bus_unlock(dev);
> > +     }
> > +
> >
> > With that we can end up with something like the below after boot.
> > :/sys/bus/nd/devices/region0$ sudo ndctl list -Ni
> > [
> >   {
> >     "dev":"namespace0.1",
> >     "mode":"fsdax",
> >     "map":"mem",
> >     "size":0,
> >     "uuid":"00000000-0000-0000-0000-000000000000",
> >     "state":"disabled"
> >   },
> >   {
> >     "dev":"namespace0.0",
> >     "mode":"fsdax",
> >     "map":"mem",
> >     "size":2147483648,
> >     "uuid":"094e703b-4bf8-4078-ad42-50bebc03e538",
> >     "state":"disabled"
> >   }
> > ]
> >
> > namespace0.0 is the one we failed to initialize due to PAGE_SIZE
> > mismatch.
> >
> > We do have namespace_seed pointing to namespacece0.1 correct. But a ndtl
> > create-namespace will pick namespace0.0 even if we have seed file
> > pointing to namespacec0.1.
> >
> >
> > I am trying to resolve the issues related to creation of new namespaces
> > when we have some namespace marked disabled due to pfn_sb setting
> > mismatch.
> >
> > -aneesh
>
> With that ndctl namespace0.0 selection commented out, we do get pick the
> right idle namespace.
>
> #ndctl list -Ni
> [
>   {
>     "dev":"namespace0.1",
>     "mode":"fsdax",
>     "map":"mem",
>     "size":0,
>     "uuid":"00000000-0000-0000-0000-000000000000",
>     "state":"disabled"
>   },
>   {
>     "dev":"namespace0.0",
>     "mode":"fsdax",
>     "map":"mem",
>     "size":2147483648,

Yes, this being non-zero means the namespace is not idle.

Maybe with --force we can ignore the size checking and just reclaim
the 0th namespace for a new namespace.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
