Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6592F15B226
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Feb 2020 21:49:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B3CDD1007B1C6;
	Wed, 12 Feb 2020 12:53:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C1DAC1007B1C5
	for <linux-nvdimm@lists.01.org>; Wed, 12 Feb 2020 12:53:11 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 59so3316669otp.12
        for <linux-nvdimm@lists.01.org>; Wed, 12 Feb 2020 12:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzAnvFKRa1rShyWAAtj5laDf0mBaivK8jzBUoAkIJxQ=;
        b=s9aSwWvYOk+BLyHlSlWkz2Yc1BVZNcv4PEJlBXOGQM5wzSP/+5OFEI9XZ+fZQ+7ICw
         GSnSUFuyv4xAILvoIv1SrCqMLbbsvZoHYsJ8KmC0v1VG3mDAP0PVMtYFVxHW5kRjA/8B
         25HS7u98HJpINnosmedau0C3YmqPhpilXq0H7SBn6ReW75v+MJWkPb1eROTe6fuJ+MKB
         uMY0Eu14wgadGQZS/RE2GLjD4gcZil1AYcphNCL5dh3cyaPj2uX9SOUD9gPfcvIDOFps
         CeZL784ydYvO2mbOHb+Ox65PAzV1UlLJUvvIRSwvfx8IHuqiyXR438i9TFXk9mNBPjT2
         6XBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzAnvFKRa1rShyWAAtj5laDf0mBaivK8jzBUoAkIJxQ=;
        b=CB7lwl763luKpUGXiPd1FUXdwmyPPMLSY2sNDp6VuTMAhWHXdM07VJeQeXCm0GBDNP
         652zP7dAZxd3HyC/FBBzzDMks+PZ1U0+vtK2vxYeYiLjQaLe/PKSP/heBOGEknr1mN4l
         Outos1O4i1gZK3cvxnuqB2Yt6ioJVsvvZNTBWwWG6PD89ec0e9dWiUHfJh7XrQfmFBtT
         zxGUKKj+urrMi//WGQXiifX/2Pxy6CSRYg/VKQTpFged3XIz5c2OVWK+JvF71JI/UE85
         VC135Xwhz1mGI8kf/VDEC4YcWr1rxsBYVqP+zIlOUQX0lYf/sybxrv2L7e6McflGZONL
         P36A==
X-Gm-Message-State: APjAAAWWiCV+RP/ceWqecQBMW4FZcEOvvFLzhMlUSaXAjFMkrtQ05cVq
	NDiBL8pvf46RPWXlbwBM87ERIUlcbSnIyLhk1bgTZg==
X-Google-Smtp-Source: APXvYqzUyLp39PsVXVE/sIDaZr2OO0XTDZ/pQWO5P9qRKWTMRHvXRWLXA5/ZyfiyaduNZe4BkTv/LsPjc46utnftSMo=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr10116231otl.71.1581540593277;
 Wed, 12 Feb 2020 12:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20200123154720.12097-1-jack@suse.cz> <x498sl73nsc.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x498sl73nsc.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 12 Feb 2020 12:49:41 -0800
Message-ID: <CAPcyv4jKKfWCNHtxQDYcKV_6hMXWrATkppQ4v=4E0teOmT8+mg@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/nvdimm: Fix compilation failure without CONFIG_DEV_DAX_PMEM_COMPAT
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: QUXBI35ETZVZHVTASJUWC5CBMGXJI55Z
X-Message-ID-Hash: QUXBI35ETZVZHVTASJUWC5CBMGXJI55Z
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QUXBI35ETZVZHVTASJUWC5CBMGXJI55Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 12, 2020 at 6:04 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Jan Kara <jack@suse.cz> writes:
>
> > When a kernel is configured without CONFIG_DEV_DAX_PMEM_COMPAT, the
> > compilation of tools/testing/nvdimm fails with:
> >
> >   Building modules, stage 2.
> >   MODPOST 11 modules
> > ERROR: "dax_pmem_compat_test" [tools/testing/nvdimm/test/nfit_test.ko] undefined!
> >
> > Fix the problem by calling dax_pmem_compat_test() only if the kernel has
> > the required functionality.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
>
> What's the motivation?  Is this just to fix randconfig builds?  The
> reason I ask is that the test suite will expect to be able to find the
> dax_pmem_compat module, so it doesn't make sense to me to disable those
> tests only in the kernel as you'll hit a problem when running the tests
> anyway.

Yeah, at a minimum you'd also need to go fix up nfit_test_init() to
not check for the dax_pmem_compat module:

https://github.com/pmem/ndctl/blob/master/test/core.c#L119

> But, I understand if you want to prevent build bots from hitting
> compilation failures due to this.

Hmm, build bots would only hit what's covered by
CONFIG_NVDIMM_TEST_BUILD, and that's only building
tools/testing/nvdimm/test/iomap.c.

Jan, were you just looking to use nfit_test outside of running the
ndctl test suites? Or was this just a drive-by compilation test?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
