Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B2A376D1B
	for <lists+linux-nvdimm@lfdr.de>; Sat,  8 May 2021 01:02:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2B1F1100EAAE2;
	Fri,  7 May 2021 16:02:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DFDE0100EAAE1
	for <linux-nvdimm@lists.01.org>; Fri,  7 May 2021 16:02:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n2so15862830ejy.7
        for <linux-nvdimm@lists.01.org>; Fri, 07 May 2021 16:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cysv76arNz3MFs69VgX48DEkoN+9KVfkGC6lPIgs6LE=;
        b=g8Uua7ZkJUkGmrfi9VOU8KXTzma6Sz/ha6C4zc2aV/dvLPFPBuro4R1QQHIupXI1K3
         Nq0ofBpyKFYN+zfIgJzSfNoYSchacVQcM/LzruoFvtv+dVO+PufL97znHHXj2rf1+cIB
         wapM++MV9+XseRUEnb9GC8DcT6lgUQ9j3nAVnLFScuw/sJ3+jM0WSbwmjR9pXsbpvjEF
         eYE9gaXgPB0JVWi7ZW1iLMhAEJ+Icu8UmkixAEjfU4q2PGCAgLJdlGzxNd4aYczL0NWq
         9edVVRwc5zWREXezpVsrimURLVLQ4MkNiyoNvaWBs3MhYSnGuNGRgEvL9o+vC7/bG4i0
         cVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cysv76arNz3MFs69VgX48DEkoN+9KVfkGC6lPIgs6LE=;
        b=O+NAe0Z3s19JaEOPtau2yrsGyWdph3ovRDkTIGgLNV/QNBZ2YC8xXe5EsLEWHY0XxV
         clJNjJL4EUe/LfYDMvTAgV3WM4/ZH+rdPDq260hW4zDA4cJH/LSUXV16uTwDsYVjMDzu
         yBXB0zivpZADShripazTLc1QWdTYzAQibGfHqIvADM/h50NuVdLeo5z4oLVWa6qaf7WD
         E1XT7uqjVJ5banG7qgSv39j+TrE/JQiiNhAe/7KXtcKSt9b5kjqddkVOUw0jgT2Yvkfq
         OtsUzfc7qwels4q7hklyOmpfX5QxJr4yuQcEh4ahCVWV/wx1X/EXbv8PkjZRIygPyCZH
         Jlwg==
X-Gm-Message-State: AOAM533ztGZUHmMdhnIjBYxSnb+XFg6V84YvXcB2O6vvPFBxtWG3NJmW
	IneY908cXovAL7qlwJwtx1lfOZzTrShso4GRpsBaNg==
X-Google-Smtp-Source: ABdhPJx0vlXi8joVqX/bKq6BizKlwHJaiCJq3xBs6gTLXhtM3osxEcKR8qoOa8bY8Rty55XhIwEh7d0ppVWIj9mVfww=
X-Received: by 2002:a17:906:33da:: with SMTP id w26mr12947744eja.472.1620428524398;
 Fri, 07 May 2021 16:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <162037273007.1195827.10907249070709169329.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0gBCxFQ1pC1PTRximwzGXOSQDCzOfjX497aqBq5GQ48tA@mail.gmail.com>
 <CAPcyv4jUdebFQvrhi0yzNyZ1wwzeGDpf6T34m=bfL593s-PEcA@mail.gmail.com> <CAJZ5v0g_q7ceyLmmVzhAyruFd4CxSJj+JdigFURPoHNwG_DRyw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g_q7ceyLmmVzhAyruFd4CxSJj+JdigFURPoHNwG_DRyw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 7 May 2021 16:01:53 -0700
Message-ID: <CAPcyv4hVLc0hpZ5ft-XQ7a4OMrYbH=Y6t_tUbiteKcR4G0NT+A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NFIT: Fix support for variable 'SPA' structure size
To: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID-Hash: ZXS5GOMJ7IUKZBLGJOZLP7UYJ4BF32RQ
X-Message-ID-Hash: ZXS5GOMJ7IUKZBLGJOZLP7UYJ4BF32RQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Rafael Wysocki <rafael.j.wysocki@intel.com>, Bob Moore <robert.moore@intel.com>, Erik Kaneda <erik.kaneda@intel.com>, Yi Zhang <yi.zhang@redhat.com>, nvdimm@lists.linux.dev, linux-nvdimm <linux-nvdimm@lists.01.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZXS5GOMJ7IUKZBLGJOZLP7UYJ4BF32RQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 7, 2021 at 7:49 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, May 7, 2021 at 4:12 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, May 7, 2021 at 2:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > Hi Dan,
> > >
> > > On Fri, May 7, 2021 at 9:33 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > ACPI 6.4 introduced the "SpaLocationCookie" to the NFIT "System Physical
> > > > Address (SPA) Range Structure". The presence of that new field is
> > > > indicated by the ACPI_NFIT_LOCATION_COOKIE_VALID flag. Pre-ACPI-6.4
> > > > firmware implementations omit the flag and maintain the original size of
> > > > the structure.
> > > >
> > > > Update the implementation to check that flag to determine the size
> > > > rather than the ACPI 6.4 compliant definition of 'struct
> > > > acpi_nfit_system_address' from the Linux ACPICA definitions.
> > > >
> > > > Update the test infrastructure for the new expectations as well, i.e.
> > > > continue to emulate the ACPI 6.3 definition of that structure.
> > > >
> > > > Without this fix the kernel fails to validate 'SPA' structures and this
> > > > leads to a crash in nfit_get_smbios_id() since that routine assumes that
> > > > SPAs are valid if it finds valid SMBIOS tables.
> > > >
> > > >     BUG: unable to handle page fault for address: ffffffffffffffa8
> > > >     [..]
> > > >     Call Trace:
> > > >      skx_get_nvdimm_info+0x56/0x130 [skx_edac]
> > > >      skx_get_dimm_config+0x1f5/0x213 [skx_edac]
> > > >      skx_register_mci+0x132/0x1c0 [skx_edac]
> > > >
> > > > Cc: Bob Moore <robert.moore@intel.com>
> > > > Cc: Erik Kaneda <erik.kaneda@intel.com>
> > > > Fixes: cf16b05c607b ("ACPICA: ACPI 6.4: NFIT: add Location Cookie field")
> > >
> > > Do you want me to apply this (as the commit being fixed went in
> > > through the ACPI tree)?
> >
> > Yes, I would need to wait for a signed tag so if you're sending urgent
> > fixes in the next few days please take this one, otherwise I'll circle
> > back next week after -rc1.
>
> I'll be doing my next push after -rc1 either, so I guess it doesn't
> matter time-wise.

Ok, I got it, thanks for the offer.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
