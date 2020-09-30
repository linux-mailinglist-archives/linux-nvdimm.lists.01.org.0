Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFEF27EDCD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Sep 2020 17:49:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A85A154C7B95;
	Wed, 30 Sep 2020 08:49:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f42; helo=mail-qv1-xf42.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 906C2154C7B95
	for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 08:49:55 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id f11so1129635qvw.3
        for <linux-nvdimm@lists.01.org>; Wed, 30 Sep 2020 08:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8/IDDg3h30xL2yKxOXfAZ6SYDQxULsHhio1WiSzVoE=;
        b=b3/eSZrxq9ZmquVDBHUWHZcW8jE3GZMuVJn04cLVnXRpAKQlax71RkHw+TItyAcXOf
         D1/wbcVY1Tp22JA5trNf+ZAjp240f5Hp/IFo/bGRg5t96yAw73K+jPG6eeK7GgW9RdEC
         ny3mkwjN6Jbxx0cHBrAXUvhnEjA9uZ2q77xjQDVhYp6ayW0dfk4vY+vvylLCH4n3iIou
         EBVZoV1Mq2driC9DQmvoOR/tuiJl+S81PanPTc7I0Y30DOZRuJSte5ZddOgYWDDA+3Ku
         d6XBGCk1g17KTfCR9ZIbDx02vyCkW9AKXbdcDIwXXfv6XZ3jt79qZ0dt4xkzIRLPTPkL
         OZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8/IDDg3h30xL2yKxOXfAZ6SYDQxULsHhio1WiSzVoE=;
        b=Ye7o/FWHVRYZ5cVTWqtzKbhynm+E1XbvJHbsy5lIDVcquj/tq/5dUNh2KtZTuCjL+Z
         ZCM/BgSBRKWtpJ+D/Rt15+C98IKireM2IQmW42GGmAk/QAxUFEBgGF6rZa/MDfULNvr1
         UttrpQTgmfodp+JO0gSEErPaxdcYqLFKwli6zUQt3MCaXbsbiQz5lIinHUURguOBo5JO
         ewdociop/iBAvwJznMWdENhVJcKA53u9MUZ6GWwerBdA5HxcS6a3kaAmGdRX2ThGHILB
         kza6PlKU/NymVmNp9lZDBt+F6HLR/iYKIEI+GBUTPFnALAnL0n2uyMRIuvp6pzJMtbG9
         iQEg==
X-Gm-Message-State: AOAM5304nG5s/Vu5j7Bck0aOaEKKC+vIbq4C6geZTZ4WWVYfKY4FwVyK
	BghLO1unhV4aqeBouj0uxRZ+p+xKfwA/nHMhDDi2Sg==
X-Google-Smtp-Source: ABdhPJz35tnMcZ3NgGf2cA0sbRzUPpGd/75eBd+InpyMs61ib5CN5zyPrAngEN4AeGJwKtjR6R96dAebjOvm9ebx2O0=
X-Received: by 2002:ad4:4d52:: with SMTP id m18mr2946409qvm.55.1601480993835;
 Wed, 30 Sep 2020 08:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <160087928642.3520.17063139768910633998.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4iPuRWSv_do_h8stU0-SiWxtKkQWvzBEU+78fDE6VffmA@mail.gmail.com> <20200930050455.GA6810@zn.tnic>
In-Reply-To: <20200930050455.GA6810@zn.tnic>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 30 Sep 2020 08:49:42 -0700
Message-ID: <CAPcyv4j=eyVMbcnrGDGaPe4AVXy5pJwa6EapH3ePh+JdF6zxnQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] Renovate memcpy_mcsafe with copy_mc_to_{user, kernel}
To: Borislav Petkov <bp@alien8.de>
Message-ID-Hash: BDQSHU3N4CXF2DFOLRLWNQ2DJI2LVDJW
X-Message-ID-Hash: BDQSHU3N4CXF2DFOLRLWNQ2DJI2LVDJW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, stable <stable@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Mikulas Patocka <mpatocka@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 0day robot <lkp@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BDQSHU3N4CXF2DFOLRLWNQ2DJI2LVDJW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 29, 2020 at 10:05 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 29, 2020 at 03:32:07PM -0700, Dan Williams wrote:
> > Given that Linus was the primary source of review feedback on these
> > patches and a version of them have been soaking in -next with only a
> > minor conflict report with vfs.git for the entirety of the v5.9-rc
> > cycle (left there inadvertently while I was on leave), any concerns
> > with me sending this to Linus directly during the merge window?
>
> What's wrong with them going through tip?

There's been a paucity of response on these after converging on the
feedback from Linus. They missed v5.9, and I started casting about for
what could be done to make sure they did not also miss v5.10 if the
quiet continued. The preference is still "through tip".

> But before that pls have a look at this question I have here:
>
> https://lkml.kernel.org/r/20200929102512.GB21110@zn.tnic
>
> Thx.

Thanks, Boris, will do.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
