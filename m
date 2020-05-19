Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CAC1DA022
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 May 2020 20:59:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A44411E48A26;
	Tue, 19 May 2020 11:56:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6EB8411E1B596
	for <linux-nvdimm@lists.01.org>; Tue, 19 May 2020 11:56:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d7so210313eja.7
        for <linux-nvdimm@lists.01.org>; Tue, 19 May 2020 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MmeCE2rNLbyTWV0xi9uw/p7FZOlCO9sFDmL+q409Ck0=;
        b=eNKiZqD0vS2pR3tIJYsN12i9G1IVXbuerFMfQCRENKtoh5ZvGgP0XiPS6ml0NCK07P
         EOplW9dBqXQL91BtIfiZQRZV3HmJlk8LTt7tSC5DuVqB6SNCf8BnLT+wQOZ1cbhuaqLh
         HL113jfQAu0wbHAAf6xDGxMUhC/fjgiCc/aLfIWfC8HllajjXk9B1y52JEELCZPThJnG
         wLKmZ+9e7jQ924QlMz0g7jP5yDBsckqLajGqzUnzSfvZ81PskoLOqwaRyVeu1ZI60auR
         ppGcjLdTKV8fsA7Syaz4Z5ek0zp89+yuPCwsDjYSthf2ZMtJ70fZnvMYnbGK3N555e65
         uFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MmeCE2rNLbyTWV0xi9uw/p7FZOlCO9sFDmL+q409Ck0=;
        b=mLoh5ksb0ZWRDBLRHpk24ZwTqk3TxaN+iwRw0CLyEfBtLDYCGFd3ybBptPyxt3onNK
         rzdlEYcEeLSzYeUJONwFhY23rWpgDylPpAy/hk8hZj5ZIiReJw3g8SGYQusLB5K16LuY
         OZPx29jaTavI6lVdnBEU50Za7pEBpa0/JMJhVB6a/63bKdBBGae4xEBkK4B6TAJmy7Qd
         vmtdbJMFyUlH5kaGY4pm3sy0+MzqbclpZ/JMU4GTyJ1eueghi+344NOKB6Cg4QNkITcq
         viGoBFWckzbwf8b56/FDGco1Ngor0AQRoP2PrjdnohrYW6ugWEbEwCvPpouA4lXsPhga
         36ww==
X-Gm-Message-State: AOAM532HdDyDqhfMqmV7qWToWAhw1ff94KjvdvZxR31IpTgYs8hAsylp
	zCXfcQVsGZ6prrwDoqCGWw/tH+GhuiO6cl/jLn0VJWrG
X-Google-Smtp-Source: ABdhPJyyvelSDTZhXRqUnGw6DaM8Owg0RToFl89XRs5sJg99jrP5k72QLw9t7cVYey5hGbkZfQdBwxPfAynowjdKeCE=
X-Received: by 2002:a17:906:fb0e:: with SMTP id lz14mr554066ejb.237.1589914781961;
 Tue, 19 May 2020 11:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200513034705.172983-1-aneesh.kumar@linux.ibm.com>
 <20200513034705.172983-3-aneesh.kumar@linux.ibm.com> <CAPcyv4iAdrdMiSzVr1UL9Naya+Rq70WVuKqCCNFHe1C4n+E6Tw@mail.gmail.com>
 <87v9kspk3x.fsf@linux.ibm.com> <CAPcyv4g+oE305Q5bYWkNBKFifB9c0TZo6+hqFQnqiFqU5QFrhQ@mail.gmail.com>
 <87d070f2vs.fsf@linux.ibm.com>
In-Reply-To: <87d070f2vs.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 19 May 2020 11:59:30 -0700
Message-ID: <CAPcyv4jZhYXEmYGzqGPjPtq9ZWJNtQyszN0V0Xcv0qtByK_KCw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: LOE46LRUDEQPBDJA6NBN66LMBVC6JEF6
X-Message-ID-Hash: LOE46LRUDEQPBDJA6NBN66LMBVC6JEF6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, alistair@popple.id.au
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LOE46LRUDEQPBDJA6NBN66LMBVC6JEF6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 19, 2020 at 6:53 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Mon, May 18, 2020 at 10:30 PM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
>
> ...
>
> >> Applications using new instructions will behave as expected when running
> >> on P8 and P9. Only future hardware will differentiate between 'dcbf' and
> >> 'dcbfps'
> >
> > Right, this is the problem. Applications using new instructions behave
> > as expected, the kernel has been shipping of_pmem and papr_scm for
> > several cycles now, you're saying that the DAX applications written
> > against those platforms are going to be broken on P8 and P9?
>
> The expecation is that both kernel and userspace would get upgraded to
> use the new instruction before actual persistent memory devices are
> made available.
>
> >
> >> > I'm thinking the kernel
> >> > should go as far as to disable DAX operation by default on new
> >> > hardware until userspace asserts that it is prepared to switch to the
> >> > new implementation. Is there any other way to ensure the forward
> >> > compatibility of deployed ppc64 DAX applications?
> >>
> >> AFAIU there is no released persistent memory hardware on ppc64 platform
> >> and we need to make sure before applications get enabled to use these
> >> persistent memory devices, they should switch to use the new
> >> instruction?
> >
> > Right, I want the kernel to offer some level of safety here because
> > everything you are describing sounds like a flag day conversion. Am I
> > misreading? Is there some other gate that prevents existing users of
> > of_pmem and papr_scm from having their expectations violated when
> > running on P8 / P9 hardware? Maybe there's tighter ecosystem control
> > that I'm just not familiar with, I'm only going off the fact that the
> > kernel has shipped a non-zero number of NVDIMM drivers that build with
> > ARCH=ppc64 for several cycles.
>
> If we are looking at adding changes to kernel that will prevent a kernel
> from running on newer hardware in a specific case, we could as well take
> the changes to get the kernel use the newer instructions right?

Oh, no, I'm not talking about stopping the kernel from running. I'm
simply recommending that support for MAP_SYNC mappings (userspace
managed flushing) be disabled by default on PPC with either a
compile-time or run-time default to assert that userspace has been
audited for legacy applications or that the platform owner is
otherwise willing to take the risk.

> But I agree with your concern that if we have older kernel/applications
> that continue to use `dcbf` on future hardware we will end up
> having issues w.r.t powerfail consistency. The plan is what you outlined
> above as tighter ecosystem control. Considering we don't have a pmem
> device generally available, we get both kernel and userspace upgraded
> to use these new instructions before such a device is made available.

Ok, I think a compile time kernel option with a runtime override
satisfies my concern. Does that work for you?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
