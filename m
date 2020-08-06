Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219EE23DB62
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Aug 2020 17:35:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 26E1011E35C58;
	Thu,  6 Aug 2020 08:35:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::644; helo=mail-ej1-x644.google.com; envelope-from=mingo.kernel.org@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6165211E35C3D;
	Thu,  6 Aug 2020 08:35:08 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id kq25so37835336ejb.3;
        Thu, 06 Aug 2020 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jAnZHwKItrjXdvdR58QzqOoGM6YiK6Tg67ZIO3IEXZQ=;
        b=PaV9DzcXBRT4XdiWVj2xuDnpNzGzZvTVchEJ29eJg3AwKErvnq9AkPTWImWIdPrvSk
         Cm1fi9ZxhQcs1r7k5zNMztQZEJqDMdu4nka/5tt8Hhb9cFcUnBoSa31kj9ZW0F5Bwztk
         NHaIsLTKVw7u8qV/lSP5g3fWoeyPzO6NUKldsdvdpw3jIGhMz1cqJ+9ArczJ7cx3GIwk
         PX8WirWmF4DG/A/CFrnhy+HE2KQsK+ZRlZFYc32HeYG6Tbh2C++BzOTYyxkUXmkEOi0k
         xTt2rad3nwG1/HXaM/GIW7ndJd+xF1vxwoL77XDNGhT/4l0+wVpZ2QhQn6ruUQVtS02g
         ux2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jAnZHwKItrjXdvdR58QzqOoGM6YiK6Tg67ZIO3IEXZQ=;
        b=i/hm4mrsBtkduWYQ3mWc1gMCGsmdYlAeE9OE+2RTQLEhLYFsWmxLs5wSVYwNMXELhH
         xpNXsJcP966E2vg0UKy80+S+iPz/Ck+WZRSMwJiVwbvUGfaBAg8zYQSkGRtNIX7JMYaV
         0q+9SH5fwiMfA0NKnFaEE8LzK3fnifOCHBR3NtOEmTxoltR3x+gT0+8OeMVQqCTdVWnl
         ejTAsZ/+bOrFagN9v8AoEha1nJUFg5hj3YaAU94JACWAXiMkSdoqlsxjPxDV4OKk8NJO
         Z6zy9EtGlmZatr6gjonLbGL/ym47Z05i+flU5Mgp1aS9e5HNEIpI9mgNtJJ/X/0FL0xb
         EGUg==
X-Gm-Message-State: AOAM530LbeI9gzs0BOIzO3/Q0vh/uxL/Fin8RN0pDUelo+0yf9uJ8VuZ
	p4ThvrFhJu0N+dEanIZh2ZxLgAs4
X-Google-Smtp-Source: ABdhPJzGSWcXsTvrFChy/oKLxWzAYTmdg9pUBz7YXxu/sHbxaHPFNUziq5MLvb9Mv5LaLwHDPyG+XA==
X-Received: by 2002:a17:907:4064:: with SMTP id nl4mr4903112ejb.342.1596728106880;
        Thu, 06 Aug 2020 08:35:06 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h9sm4027593ejt.50.2020.08.06.08.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:35:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 6 Aug 2020 17:35:00 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [x86/copy_mc] a0ac629ebe: fio.read_iops -43.3% regression
Message-ID: <20200806153500.GC2131635@gmail.com>
References: <159630256804.3143511.8894023468833792004.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200803094257.GA23458@shao2-debian>
 <20200806133452.GA2077191@gmail.com>
 <CAPcyv4hS7K0Arrd+C0LhjrFH=yGJf3g55_WkHOET4z58AcWrJw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4hS7K0Arrd+C0LhjrFH=yGJf3g55_WkHOET4z58AcWrJw@mail.gmail.com>
Message-ID-Hash: IIWCRP7YDT7OQDTUWR2VXFUBAHLHFJWM
X-Message-ID-Hash: IIWCRP7YDT7OQDTUWR2VXFUBAHLHFJWM
X-MailFrom: mingo.kernel.org@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: kernel test robot <rong.a.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Erwin Tsaur <erwin.tsaur@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 0day robot <lkp@intel.com>, lkp@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IIWCRP7YDT7OQDTUWR2VXFUBAHLHFJWM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


* Dan Williams <dan.j.williams@intel.com> wrote:

> On Thu, Aug 6, 2020 at 6:35 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * kernel test robot <rong.a.chen@intel.com> wrote:
> >
> > > Greeting,
> > >
> > > FYI, we noticed a -43.3% regression of fio.read_iops due to commit:
> > >
> > >
> > > commit: a0ac629ebe7b3d248cb93807782a00d9142fdb98 ("x86/copy_mc: Introduce copy_mc_generic()")
> > > url: https://github.com/0day-ci/linux/commits/Dan-Williams/Renovate-memcpy_mcsafe-with-copy_mc_to_-user-kernel/20200802-014046
> > >
> > >
> > > in testcase: fio-basic
> > > on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory
> > > with following parameters:
> >
> > So this performance regression, if it isn't a spurious result, looks
> > concerning. Is this expected?
> 
> This is not expected and I think delays these patches until I'm back
> from leave in a few weeks. I know that we might lose some inlining
> effect due to replacing native memcpy, but I did not expect it would
> have an impact like this. In my testing I was seeing a performance
> improvement from replacing the careful / open-coded copy with rep;
> mov;, which increases the surprise of this result.

It would be nice to double check this on the kernel-test-robot side as 
well, to make sure it's not a false positive.

Thanks,

	Ingo
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
