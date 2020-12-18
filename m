Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E902DEB50
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 22:58:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D43CB100EB349;
	Fri, 18 Dec 2020 13:58:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D9D20100EB84B
	for <linux-nvdimm@lists.01.org>; Fri, 18 Dec 2020 13:58:22 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id w1so5300272ejf.11
        for <linux-nvdimm@lists.01.org>; Fri, 18 Dec 2020 13:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awSkLxPxfKKMYWXrPvJO5HFC6rX6G+L4B8C1Llf9W6k=;
        b=hLBV/ED7BfeJwzOqpNCmMYChlwoFiY2KhYRYAh9YAvNmhTCp5Rl5vOtjXE5lcygy6P
         xGW8sekB6mt/nykunGGg68jfMt3kl8nI0XjHiLHAw/Jl44bdjco/2PBUvN8fBn5kDwON
         gE1GN8Dxfx9SDSEZCsA/rAzWdaPWuRJucgTnKWiNxbhGi9kV9JTK9FfS9yflDIleezEV
         bNojTL0m3+dL9+Bw8KoCwccFevhvpilw/9ImOHE0xnU4wNOK7nlI50q9eVjVevAIbBH7
         jimQcsulIbzCWqGNVfNFRrbVZ+LrmM/3NVINZEg9b1lVwrhdpKkWdJLhFQIZGVrqeCxa
         DBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awSkLxPxfKKMYWXrPvJO5HFC6rX6G+L4B8C1Llf9W6k=;
        b=UdDEjCK624OtpzpMo9klqIQOGFmAPjjZ3ooWUnO29gWhYf2ooAGvAPiJMmgF0WFmc/
         p03EiNVYSOdAvAAx0FvRXXAc5kypwAUJuB0Y+opyhN1ohbVqQn5VpflEcmdV/hYyliQJ
         YMWBkwZnOpZbTgGvq7fXH9qPiGRTjH+JIfCYQdL3LuPw704Ncs3yRtd1jhwI59FbgcyG
         UJp/TXizm38PQiIQ5MsR83tUEQcTP/xGbKPCHQ9GC0mviD02Y0PDhxf0yY59GGVurCm8
         FGZh4B+bsW6FUaJO3H81zabtlkAOTAon1yJfokuCk+4FhVTkqrakzrRrzdeiKXioLjv9
         IPhA==
X-Gm-Message-State: AOAM531DDaMAd0sWxxp6uif+xCv/0lXcRNI/YNjZfqHyCJmqc7agORst
	DBdT5Ztpy6UWdoDMCk4p+FPYxwaqJlW+3hEqGJkSsg==
X-Google-Smtp-Source: ABdhPJw+WBaQpu6K/EP/XCCpxET87+bULI/RU+iA1GSA2CpDe3vqce08alBcHTx2GShwo2pEUBLYdR2k0/3Rq4IDZN0=
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr5756613ejb.264.1608328700420;
 Fri, 18 Dec 2020 13:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-5-ira.weiny@intel.com>
 <871rfoscz4.fsf@nanos.tec.linutronix.de> <87mtycqcjf.fsf@nanos.tec.linutronix.de>
 <878s9vqkrk.fsf@nanos.tec.linutronix.de> <CAPcyv4h2MvybBi==3uzAjGeW0R7azHYSKwmvzMXq9eM8NzMLEg@mail.gmail.com>
 <875z4yrfhr.fsf@nanos.tec.linutronix.de>
In-Reply-To: <875z4yrfhr.fsf@nanos.tec.linutronix.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Dec 2020 13:58:09 -0800
Message-ID: <CAPcyv4gqm5p+pVmX4JL0fT2LY0dfoT+UXAfsGLA9LMr42vp33A@mail.gmail.com>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
To: Thomas Gleixner <tglx@linutronix.de>
Message-ID-Hash: 4VOOV6RAEQIZFPZ6IWIFNSRBZVOGE27Z
X-Message-ID-Hash: 4VOOV6RAEQIZFPZ6IWIFNSRBZVOGE27Z
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4VOOV6RAEQIZFPZ6IWIFNSRBZVOGE27Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 18, 2020 at 1:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Dec 18 2020 at 11:20, Dan Williams wrote:
> > On Fri, Dec 18, 2020 at 5:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > [..]
> >>   5) The DAX case which you made "work" with dev_access_enable() and
> >>      dev_access_disable(), i.e. with yet another lazy approach of
> >>      avoiding to change a handful of usage sites.
> >>
> >>      The use cases are strictly context local which means the global
> >>      magic is not used at all. Why does it exist in the first place?
> >>
> >>      Aside of that this global thing would never work at all because the
> >>      refcounting is per thread and not global.
> >>
> >>      So that DAX use case is just a matter of:
> >>
> >>         grant/revoke_access(DEV_PKS_KEY, READ/WRITE)
> >>
> >>      which is effective for the current execution context and really
> >>      wants to be a distinct READ/WRITE protection and not the magic
> >>      global thing which just has on/off. All usage sites know whether
> >>      they want to read or write.
> >
> > I was tracking and nodding until this point. Yes, kill the global /
> > kmap() support, but if grant/revoke_access is not integrated behind
> > kmap_{local,atomic}() then it's not a "handful" of sites that need to
> > be instrumented it's 100s. Are you suggesting that "relaxed" mode
> > enforcement is a way to distribute the work of teaching driver writers
> > that they need to incorporate explicit grant/revoke-read/write in
> > addition to kmap? The entire reason PTE_DEVMAP exists was to allow
> > get_user_pages() for PMEM and not require every downstream-GUP code
> > path to specifically consider whether it was talking to PMEM or RAM
> > pages, and certainly not whether they were reading or writing to it.
>
> kmap_local() is fine. That can work automatically because it's strict
> local to the context which does the mapping.
>
> kmap() is dubious because it's a 'global' mapping as dictated per
> HIGHMEM. So doing the RELAXED mode for kmap() is sensible I think to
> identify cases where the mapped address is really handed to a different
> execution context. We want to see those cases and analyse whether this
> can't be solved in a different way. That's why I suggested to do a
> warning in that case.
>
> Also vs. the DAX use case I really meant the code in fs/dax and
> drivers/dax/ itself which is handling this via dax_read_[un]lock.
>
> Does that make more sense?

Yup, got it. The dax code can be precise wrt to PKS in a way that
kmap_local() cannot.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
