Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B45AB1DD608
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 May 2020 20:34:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7AD23116A73D2;
	Thu, 21 May 2020 11:30:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 75F5F116834A3
	for <linux-nvdimm@lists.01.org>; Thu, 21 May 2020 11:30:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id j21so10082793ejy.1
        for <linux-nvdimm@lists.01.org>; Thu, 21 May 2020 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bZB73trM7JmhHu61hJTv3jHzEz2F1LugfJH/YUnVYqg=;
        b=ZM0h1GWbWile7S9kQ21W3BI/ip9+OMrHJQM/ajHArCqSOHsyg1dYmKoJFtj44pXod0
         pwCSMuGGJZy9M1T+xesSJUXoYT1fHIG2ya7bms8M042L/YvVVLZhdlhMfHiSAJvcVvl5
         wBk8KemIgKTFzuU/H/rr1Jwp7heVqhu00V0iZ/DX7nf4nTgs64/gbhC3vRrJzMNA/BRP
         lN11dlSr7OChTKcZjQ59FQuqVQYGvE1lrPSzErFh6SHR2ZrOcF5Cnh8IsvKvI/mAhbi5
         SUvSN1YJNGeE1hPBIiD1+aatRedeMSFeggTjfMlUq27TUEb16fz5ByISYIt9JRWNRtZ1
         D8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bZB73trM7JmhHu61hJTv3jHzEz2F1LugfJH/YUnVYqg=;
        b=cffLd5D2Cp7jlFkG9gSQHcWNfmDKedhtX8q07DLpYrtdC3lShe9hPixKFqt8AP/Zdp
         O6cOMjhqyFoPjByB1hCi2zDs9PZ+O4VOUlBGIx8/nEWZgPCDt3C0FpLvvNqwRjDFmMvY
         sjjjxWPt8wJxpAGKMFmwYOHJKft96ND3BCAXJnH2PTuEZ2jehd/CJIoQTK5yUGDayp/1
         zciiEWh8PrnhzdjzXxHqpGsj99j0Fv1OFZDDLmfqzM6Ib0SSJkhKqd843EyiFSP5JsNx
         DuUnl9BZmvz+8YHh4exrJe8rlOSyU28r2lNwPUxeHCaF03f82jDejMzIJH4OkJxjPfr9
         yVfw==
X-Gm-Message-State: AOAM532mvq9PeeKFbrvzypn1HizEs3xR2a6fT6NEKeP/5KYftx8fyV3O
	JRBhtsIlEaeR3p5wRs8kldFs8nAm0pDCKQ7drOfYzdKy
X-Google-Smtp-Source: ABdhPJwKsXh+titAh6DgDZ1r89xS/iYOoQMiDoMrFLMmmvU1QitGELpC8ydHrsAa6yiizxbaijdstcJLj1jjRajAA2w=
X-Received: by 2002:a17:906:379b:: with SMTP id n27mr4691961ejc.432.1590086059384;
 Thu, 21 May 2020 11:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200513034705.172983-1-aneesh.kumar@linux.ibm.com>
 <20200513034705.172983-3-aneesh.kumar@linux.ibm.com> <CAPcyv4iAdrdMiSzVr1UL9Naya+Rq70WVuKqCCNFHe1C4n+E6Tw@mail.gmail.com>
 <87v9kspk3x.fsf@linux.ibm.com> <CAPcyv4g+oE305Q5bYWkNBKFifB9c0TZo6+hqFQnqiFqU5QFrhQ@mail.gmail.com>
 <87d070f2vs.fsf@linux.ibm.com> <CAPcyv4jZhYXEmYGzqGPjPtq9ZWJNtQyszN0V0Xcv0qtByK_KCw@mail.gmail.com>
 <x49o8qh9wu5.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49o8qh9wu5.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 21 May 2020 11:34:08 -0700
Message-ID: <CAPcyv4hbwqrERcs4oVGOAnew0A=HRm0muoKm3+4UzZLpOF12Yw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: RCJNLQILC4LXMHKVUJXFPOD2UMMVEBEU
X-Message-ID-Hash: RCJNLQILC4LXMHKVUJXFPOD2UMMVEBEU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, alistair@popple.id.au, Mikulas Patocka <mpatocka@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RCJNLQILC4LXMHKVUJXFPOD2UMMVEBEU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 21, 2020 at 7:39 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> >> But I agree with your concern that if we have older kernel/applications
> >> that continue to use `dcbf` on future hardware we will end up
> >> having issues w.r.t powerfail consistency. The plan is what you outlined
> >> above as tighter ecosystem control. Considering we don't have a pmem
> >> device generally available, we get both kernel and userspace upgraded
> >> to use these new instructions before such a device is made available.
>
> I thought power already supported NVDIMM-N, no?  So are you saying that
> those devices will continue to work with the existing flushing and
> fencing mechanisms?
>
> > Ok, I think a compile time kernel option with a runtime override
> > satisfies my concern. Does that work for you?
>
> The compile time option only helps when running newer kernels.  I'm not
> sure how you would even begin to audit userspace applications (keep in
> mind, not every application is open source, and not every application
> uses pmdk).  I also question the merits of forcing the administrator to
> make the determination of whether all applications on the system will
> work properly.  Really, you have to rely on the vendor to tell you the
> platform is supported, and at that point, why put further hurdles in the
> way?

I'm thoroughly confused by this. I thought this was exactly the role
of a Linux distribution vendor. ISVs qualify their application on a
hardware-platform + distribution combination and the distribution owns
picking ABI defaults like CONFIG_SYSFS_DEPRECATED regardless of
whether they can guarantee that all apps are updated to the new
semantics.

The administrator is not forced, the administrator if afforded an
override in the extreme case that they find an exception to what was
qualified and need to override the distribution's compile-time choice.

>
> The decision to require different instructions on ppc is unfortunate,
> but one I'm sure we have no control over.  I don't see any merit in the
> kernel disallowing MAP_SYNC access on these platforms.  Ideally, we'd
> have some way of ensuring older kernels don't work with these new
> platforms, but I don't think that's possible.

I see disabling MAP_SYNC as the more targeted form of "ensursing older
kernels don't work.

So I guess we agree that something should break when baseline
assumptions change, we just don't yet agree on where that break should
happen?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
