Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B60D6B7E8A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Sep 2019 17:50:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6F37721962301;
	Thu, 19 Sep 2019 08:50:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 92831202EA947
 for <linux-nvdimm@lists.01.org>; Thu, 19 Sep 2019 08:49:58 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f21so3467663otl.13
 for <linux-nvdimm@lists.01.org>; Thu, 19 Sep 2019 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hAQpuJV2hc6p1LNIlIb8VyFvKUvCMS8PN0tBtt6FY8g=;
 b=seKkheH9L6Q5ybmuPNvk0Wrw9yH85ozvkGL+Vx5sStO/GzFxmhUhVbVu5u93AeNf4n
 ruwGq3yRZJg7vOcCJi28Vba0DtMV1LAZcolcSN8o5oNIgZDhNRqelzkU9j3OiQRfEmbZ
 ODjuryRpyEpQykJrMhuWHxE1HPVZghaJNl12u5nxbHyhrcNIDrxfZcnkR8BDAA1+OqcX
 32LNkJnarbkNMRXOjuY5wno9BbTaj8tyQitAIaRAQ23CkCYtY5X57PPFRuVIe3xYKIs6
 2OatHxmMcR1M8jf6CzUWtjkzYSijFVfkG0+nJE+4FTZBF6UhCRflmcRlBLJYvon5Cn37
 fm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hAQpuJV2hc6p1LNIlIb8VyFvKUvCMS8PN0tBtt6FY8g=;
 b=uWAUGnigoLwEhLUIH79GPY9I4HM6GQAeYff/yensNIQCHPYTUaN8u/4h3p8mSBu0bL
 e9bH4s5WJX6mWGnuRKkVmGFY5TqvM8M9p+EXRunM1obYPlrDN5fcWY1exiQdTyzH6kOH
 SHHJDduunh2nOiNkt+omPEbSz9Zemj6wsNWGdT80E7t2yqONHg1UNTFaOtY5ag3hz0l5
 nfS3ne/ifu7xMnWXq62I7C22/xaWf60/XLb2zutCLJ5qy6yiMLyjEQoYwaOMJCHaFeWa
 RfZWeivb5k5NxnbC6Ro86rOwO1LK4DyetdN4Gc5qzzQxTyjNyyLrfwcTbz6zDZ56Cuy3
 Bkhg==
X-Gm-Message-State: APjAAAXj3QMbwVEiJ3HyyIjKwe41yEGgSV7ajKl1BMN0PWNEVVnAoHTE
 YkBC/mfd3WQ3gAoI7vdXBj7eZ2wVjD5RxO0E4Lh0FcNU
X-Google-Smtp-Source: APXvYqx5jRV6+eDsdrEQJLAz5sycwrIvMIJ1uWjq02VHOxeqzSZDpoE7ObPl/6L7NiDjqOSXGR8tePwtERt6emMydc8=
X-Received: by 2002:a9d:5ccc:: with SMTP id r12mr6690380oti.71.1568908252238; 
 Thu, 19 Sep 2019 08:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190919115547.GA17963@angband.pl>
 <CAPcyv4jYE_vmEqe+m7spaXV4FDgHLJpE9cp3Ry2e8vU0JZEFCA@mail.gmail.com>
 <20190919154708.GA24650@angband.pl>
In-Reply-To: <20190919154708.GA24650@angband.pl>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 19 Sep 2019 08:50:41 -0700
Message-ID: <CAPcyv4gmg4eKV-OmtOAX3f19Xe4eoWXX3bJodRGjAwT69Jwn4Q@mail.gmail.com>
Subject: Re: hang in dax_pmem_compat_release on changing namespace mode
To: Adam Borowski <kilobyte@angband.pl>
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

On Thu, Sep 19, 2019 at 8:47 AM Adam Borowski <kilobyte@angband.pl> wrote:
>
> On Thu, Sep 19, 2019 at 08:10:47AM -0700, Dan Williams wrote:
> > On Thu, Sep 19, 2019 at 4:56 AM Adam Borowski <kilobyte@angband.pl> wrote:
> > > Hi!
> > > If I try to change the mode of a devdax namespace that's in use (mapped by
> > > some process), ndctl hangs:
> >
> > Is it merely mapped, or might the pages be actively pinned / in use by
> > another part of the kernel? The kernel has no choice but to wait for
> > active page pins to drain. Can you get a stack trace of the process
> > with the dev-dax instance mapped?
>
> Looks like the behaviour is different depending on what the other process
> is:
> * with qemu, the hang is 100% reproducible, the guest continues to work and
>   cleanly exits -- qemu does not exit on its own (unlike normal case) but
>   SIGTERM terminates it correctly.  Thus, qemu is not stuck, only ndctl is.
> * with mere mmap() (I've used vmemcache) ndctl allows
>   reconfiguring the namespace.  No hang.
>
> My way to start qemu is:
> .----
> #!/bin/sh
> NET="-net bridge -net nic"
> DISK=eoan-devdax.disk
>
> exec qemu-system-x86_64 -enable-kvm -m 4096,slots=2,maxmem=16G -smp 8 $NET \
>  -drive if=none,id=hd,file="$DISK",format=raw,cache=unsafe,discard=on \
>  -device virtio-scsi-pci,id=scsi -device scsi-hd,drive=hd \
>  -M pc,nvdimm,nvdimm-persistence=mem-ctrl \
>  -object memory-backend-file,id=mem1,share=on,mem-path=/dev/dax0.0,size=4225761280,align=2M,pmem=on \
>  -device nvdimm,id=nvdimm1,memdev=mem1,label-size=256K \
>  -vnc :5

Ok, I'll take a look. At first glance nothing in that config should be
holding an indefinite page pin, so it does smell like a kernel bug.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
