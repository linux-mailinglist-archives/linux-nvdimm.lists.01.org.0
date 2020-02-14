Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7190515E086
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Feb 2020 17:14:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7D6B81007A841;
	Fri, 14 Feb 2020 08:17:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A22821007B1FE
	for <linux-nvdimm@lists.01.org>; Fri, 14 Feb 2020 08:17:29 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id z9so9638944oth.5
        for <linux-nvdimm@lists.01.org>; Fri, 14 Feb 2020 08:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJSkTYCvUuCRhXBnRhkrP1c46bZMhGiu4D7tOaKXuM0=;
        b=TUVgGH+10OP0QOfVjjOiB3pWiwOUKsuUiIvS2dPoOiHEJ+gflR/wwJGrCUUF2mhb+L
         Axc0o/BRXHMoJSEOIyBQEr8+dnqBI1Wb/coI0NkxGw2UJKfWS/qbm3BnkKcAFlmgB9g6
         gK5qPwYeapi79o7WpYuozJAB3C5kWsh+Dy1Mwbz6Dv2weXKV3s3EcEd4/lARklW7Mi9B
         N3nw8Nx5bSNxARCryq22tEsTamZvkvmYXekTtxFvf8BUOYXz+SCYQeZNHNCB1v0rwoUI
         MBd44Vw6noBIA2/y+WDGmuf5EoshE6gfoROAdP74GN/W/iuQE3T0VuzBFys4RjJ01sVm
         mizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJSkTYCvUuCRhXBnRhkrP1c46bZMhGiu4D7tOaKXuM0=;
        b=ptsBoRrAsUilT8CRK5plhBuyv4lywm2luEOMpjJ+33qxwie7GqRlJYYnwrAlpH52uu
         c092jEl2Xo2Dc5rgqPYv85K30Qh3YJ7PeTSrRU9ZU2556EhDVNZJcd2FAKSq1WNmyXOJ
         JG5ylEPGcWgHN7hS4F9AlV9E7F10pJzr6CUvIRhLSoKU/TED76sHgJxWOke8MrXkclIH
         eE5ePP6lREYYXvcicr2ItMSqv/eeKXV4wlUgu0qlWeX71WTQOLRpDic5lRlWngZLY5c2
         ggsN5iyWIGjXNp3gPoQZExR0RqUy/y0ZhzyuW1rnOlf/ax7AEg2whBI7H0ZOQcx8QpDB
         Nslw==
X-Gm-Message-State: APjAAAUBhq4tq8FjwlDO4hF74r7JyrkcitwzGbPjs++A9c+hjrtJjkTI
	9x6UQwGp8WgbyQPQCKfQDEI/a+ToxP36OBpe9iL7OA==
X-Google-Smtp-Source: APXvYqyyYwqsY2qVUWroXx6oe10n03C/Di8japHo70TLsfGBvwSdZeQ33V2sE7QoJMC0rAbr81AlalNeIgEd+zoBmJA=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr2977688otk.363.1581696851225;
 Fri, 14 Feb 2020 08:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20200123154720.12097-1-jack@suse.cz> <x498sl73nsc.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4jKKfWCNHtxQDYcKV_6hMXWrATkppQ4v=4E0teOmT8+mg@mail.gmail.com> <20200213205843.GA6600@quack2.suse.cz>
In-Reply-To: <20200213205843.GA6600@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 14 Feb 2020 08:13:59 -0800
Message-ID: <CAPcyv4g7kPtuZ4Cix_4eTVX6p-oK3BsNkCkLmn1h=yhcrMYJ8A@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/nvdimm: Fix compilation failure without CONFIG_DEV_DAX_PMEM_COMPAT
To: Jan Kara <jack@suse.cz>
Message-ID-Hash: 3PLVR5NTCG2HX7VR3EAKAMY3BFJOQLVC
X-Message-ID-Hash: 3PLVR5NTCG2HX7VR3EAKAMY3BFJOQLVC
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3PLVR5NTCG2HX7VR3EAKAMY3BFJOQLVC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 14, 2020 at 1:42 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 12-02-20 12:49:41, Dan Williams wrote:
> > On Wed, Feb 12, 2020 at 6:04 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> > >
> > > Jan Kara <jack@suse.cz> writes:
> > >
> > > > When a kernel is configured without CONFIG_DEV_DAX_PMEM_COMPAT, the
> > > > compilation of tools/testing/nvdimm fails with:
> > > >
> > > >   Building modules, stage 2.
> > > >   MODPOST 11 modules
> > > > ERROR: "dax_pmem_compat_test" [tools/testing/nvdimm/test/nfit_test.ko] undefined!
> > > >
> > > > Fix the problem by calling dax_pmem_compat_test() only if the kernel has
> > > > the required functionality.
> > > >
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > >
> > > What's the motivation?  Is this just to fix randconfig builds?  The
> > > reason I ask is that the test suite will expect to be able to find the
> > > dax_pmem_compat module, so it doesn't make sense to me to disable those
> > > tests only in the kernel as you'll hit a problem when running the tests
> > > anyway.
> >
> > Yeah, at a minimum you'd also need to go fix up nfit_test_init() to
> > not check for the dax_pmem_compat module:
> >
> > https://github.com/pmem/ndctl/blob/master/test/core.c#L119
>
> OK.
>
> > > But, I understand if you want to prevent build bots from hitting
> > > compilation failures due to this.
> >
> > Hmm, build bots would only hit what's covered by
> > CONFIG_NVDIMM_TEST_BUILD, and that's only building
> > tools/testing/nvdimm/test/iomap.c.
> >
> > Jan, were you just looking to use nfit_test outside of running the
> > ndctl test suites? Or was this just a drive-by compilation test?
>
> The problem is following: We build our distro kernels without
> CONFIG_DEV_DAX_PMEM_COMPAT because we don't need that functionality. And
> Jing Han (from Intel ;) is now complaining that he cannot compile and run
> the ndctl testsuite on our kernels... It seems stupid to enable that config
> option for all distro users just to be able to run the testsuite but OTOH
> it would be neat to be able to run the testsuite with stock distro
> config.

Sounds good, minus the fact that Jing and I were not on the same page.
I'll send the ndctl fixup.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
