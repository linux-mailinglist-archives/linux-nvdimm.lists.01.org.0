Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249F2DE7BA
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 17:59:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3690B100EB33C;
	Fri, 18 Dec 2020 08:59:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 07A61100EB33A
	for <linux-nvdimm@lists.01.org>; Fri, 18 Dec 2020 08:59:28 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u19so3067961edx.2
        for <linux-nvdimm@lists.01.org>; Fri, 18 Dec 2020 08:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2IQ6TE/rhYWCk2P0BT6shtYVSJjLwqOvjZqkUrg3hg=;
        b=x0bdaXnT2B4JXcqIt4PJy6h+bXPGtd8toCsOgNdWIJa1nPBCH5WTS5rerVO30HHHv+
         0mEXFdRjcKh4IwU/rzCLurT6prPOAZRgSMIqzb+6RHbn47F53bE4mnZw4nfnwKqzLt9O
         y2s6lpJCJeivzJE/dzH1mAeUqmd6PsLFZpksfWbC5s5r/QUjZboSHmr84aZIE5P0LJzo
         X7gN+dmAo5f5vnJ+NP5gpsL6toXTlaOai1neElJ2mwb0KuuQoEZyD/SwUgY9jIhveiWf
         ANrkYt1dOrFDv6aPQb04TGSt5QVD0JKHk4L6JLZ7vVZPZsgr5RluZpOmVL9LdFpgPmDm
         3uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2IQ6TE/rhYWCk2P0BT6shtYVSJjLwqOvjZqkUrg3hg=;
        b=MovYdCwzUXa2TT5fDRNJGL5ipg9n3dEVapyV6Y743kdMBIP+O0cbJQ7Tdwhk4sWiaM
         UVgarA6injuAAFVLAWHQ0sxCkIM78r4KKGrt3cG0MYByA4cYnOEW0fZ3ZLH7w2BXlmOD
         aYgv7+K2aBTrJeDoOi8hdi1+O10iqi71F69mm2tI5S0K7qWxtH2MtwdtFNAfIqEzts8r
         rN9YWK6Sx6WBgTyMMY0iZ58k9Bs6jHPCWLf+Kg/1O+pw+HILuQp/Vj8oLWlomQdnBmbG
         r6rQPrB4dnp29JBTvdiJ1aGAAvXGm9TPDLkKG+Wwgwj76hr+FCijdYxI+Whzr27XxxMl
         1Tgw==
X-Gm-Message-State: AOAM5328XDc6XpNjjTPHJG+Y/X5NxVKARszVHVaGW85WxT+RbFENsVEf
	du9EZBR8P3fBrvFk4toZJPiEO0x5BIxjl8UbQvUYRA==
X-Google-Smtp-Source: ABdhPJzi8p93x3vt5BPfkyWakXSFrE3q9YiaTjtJjD9XWTCVmH/VzLNltbu680O+caKH/UqiktjQd9bnfrMv9AkR1X4=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr5242794edr.97.1608310766755;
 Fri, 18 Dec 2020 08:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-11-ira.weiny@intel.com>
 <570ead2a-ff41-e730-d61d-0f59c67b1903@intel.com> <20201218040509.GD1563847@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20201218040509.GD1563847@iweiny-DESK2.sc.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Dec 2020 08:59:16 -0800
Message-ID: <CAPcyv4hixbKqkkh4DsRgAF7fARH2n2zzHnqQa1cNrXDrH9PekA@mail.gmail.com>
Subject: Re: [PATCH V3 10/10] x86/pks: Add PKS test code
To: Ira Weiny <ira.weiny@intel.com>
Message-ID-Hash: LQ2FKURJGI77TNQ47YTKE7T7777VA3WR
X-Message-ID-Hash: LQ2FKURJGI77TNQ47YTKE7T7777VA3WR
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LQ2FKURJGI77TNQ47YTKE7T7777VA3WR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 17, 2020 at 8:05 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Thu, Dec 17, 2020 at 12:55:39PM -0800, Dave Hansen wrote:
> > On 11/6/20 3:29 PM, ira.weiny@intel.com wrote:
> > > +           /* Arm for context switch test */
> > > +           write(fd, "1", 1);
> > > +
> > > +           /* Context switch out... */
> > > +           sleep(4);
> > > +
> > > +           /* Check msr restored */
> > > +           write(fd, "2", 1);
> >
> > These are always tricky.  What you ideally want here is:
> >
> > 1. Switch away from this task to a non-PKS task, or
> > 2. Switch from this task to a PKS-using task, but one which has a
> >    different PKS value
>
> Or both...
>
> >
> > then, switch back to this task and make sure PKS maintained its value.
> >
> > *But*, there's no absolute guarantee that another task will run.  It
> > would not be totally unreasonable to have the kernel just sit in a loop
> > without context switching here if no other tasks can run.
> >
> > The only way you *know* there is a context switch is by having two tasks
> > bound to the same logical CPU and make sure they run one after another.
>
> Ah...  We do that.
>
> ...
> +       CPU_ZERO(&cpuset);
> +       CPU_SET(0, &cpuset);
> +       /* Two processes run on CPU 0 so that they go through context switch.  */
> +       sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpuset);
> ...
>
> I think this should be ensuring that both the parent and the child are
> running on CPU 0.  At least according to the man page they should be.
>
> <man>
>         A child created via fork(2) inherits its parent's CPU affinity mask.
> </man>
>
> Perhaps a better method would be to synchronize the 2 threads more to ensure
> that we are really running at the 'same time' and forcing the context switch.
>
> >  This just gets itself into a state where it *CAN* context switch and
> > prays that one will happen.
>
> Not sure what you mean by 'This'?  Do you mean that running on the same CPU
> will sometimes not force a context switch?  Or do you mean that the sleeps
> could be badly timed and the 2 threads could run 1 after the other on the same
> CPU?  The latter is AFAICT the most likely case.
>

One way to guarantee that both threads run is to just pass a message
between them over a pipe and wait for the submitter to receive an ack
from the other end.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
