Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB193376737
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 May 2021 16:49:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1332C100EAB77;
	Fri,  7 May 2021 07:49:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.43; helo=mail-ot1-f43.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 601BD100EAB73
	for <linux-nvdimm@lists.01.org>; Fri,  7 May 2021 07:49:48 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso8116256otn.3
        for <linux-nvdimm@lists.01.org>; Fri, 07 May 2021 07:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l66WwrIfYXPPqt7FNouM4SijVky0kURl9BRKhLx5Olw=;
        b=BtWKj4iAHoY9p2F2o3psABHhNUScQPhbF2BKkR0dzL5BYtkWcBqtyJ4q8e14jUJgPY
         L9StaFbMktFXR9kLywPnTaAN4rMGXM0fQdTSAHJdQixU6MIt9FHJdXyaEm61y3qtZsmT
         Fmb+oRQ+4QeJ0PQH7Ngs1KKpNuuRwofO2ibvcLDwi26n8PFOQCu3nRtZY4AAnncmFOge
         J5YsRxdX/C+2PCfQxxlapyydeS9P67fSJOQvzidJo2vZhQiHS0z0WyoT1pCXpWJ6Yyi3
         S0EZawmD0Y+9KB4b8qp2lqAD2AoSdtnG54CO04SgcapI6w9RVTPO89TOmelAv77qeUr4
         To1g==
X-Gm-Message-State: AOAM533Yv47Zyd/2YCBKqvIHs8bi6uPPTMLdDqJ9UHuDxHOBoznyRird
	IDGerre/tBXLyStE5xrG+JQetbUEjG/AOZc/j4E=
X-Google-Smtp-Source: ABdhPJwJ/Efd8Ja1dPWdSMymvbhACucR7P1kJhsAmSyKlyVRN8WDUqINXHChWukdv3xi3dM/kIb3SuazbyBGmIIg5xM=
X-Received: by 2002:a9d:5a7:: with SMTP id 36mr8640979otd.321.1620398987013;
 Fri, 07 May 2021 07:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <162037273007.1195827.10907249070709169329.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0gBCxFQ1pC1PTRximwzGXOSQDCzOfjX497aqBq5GQ48tA@mail.gmail.com> <CAPcyv4jUdebFQvrhi0yzNyZ1wwzeGDpf6T34m=bfL593s-PEcA@mail.gmail.com>
In-Reply-To: <CAPcyv4jUdebFQvrhi0yzNyZ1wwzeGDpf6T34m=bfL593s-PEcA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 May 2021 16:49:35 +0200
Message-ID: <CAJZ5v0g_q7ceyLmmVzhAyruFd4CxSJj+JdigFURPoHNwG_DRyw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NFIT: Fix support for variable 'SPA' structure size
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: U24E6UHH6YPMV4V5SYQWELC27GNP43FM
X-Message-ID-Hash: U24E6UHH6YPMV4V5SYQWELC27GNP43FM
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Bob Moore <robert.moore@intel.com>, Erik Kaneda <erik.kaneda@intel.com>, Yi Zhang <yi.zhang@redhat.com>, nvdimm@lists.linux.dev, linux-nvdimm <linux-nvdimm@lists.01.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U24E6UHH6YPMV4V5SYQWELC27GNP43FM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 7, 2021 at 4:12 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, May 7, 2021 at 2:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > Hi Dan,
> >
> > On Fri, May 7, 2021 at 9:33 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > ACPI 6.4 introduced the "SpaLocationCookie" to the NFIT "System Physical
> > > Address (SPA) Range Structure". The presence of that new field is
> > > indicated by the ACPI_NFIT_LOCATION_COOKIE_VALID flag. Pre-ACPI-6.4
> > > firmware implementations omit the flag and maintain the original size of
> > > the structure.
> > >
> > > Update the implementation to check that flag to determine the size
> > > rather than the ACPI 6.4 compliant definition of 'struct
> > > acpi_nfit_system_address' from the Linux ACPICA definitions.
> > >
> > > Update the test infrastructure for the new expectations as well, i.e.
> > > continue to emulate the ACPI 6.3 definition of that structure.
> > >
> > > Without this fix the kernel fails to validate 'SPA' structures and this
> > > leads to a crash in nfit_get_smbios_id() since that routine assumes that
> > > SPAs are valid if it finds valid SMBIOS tables.
> > >
> > >     BUG: unable to handle page fault for address: ffffffffffffffa8
> > >     [..]
> > >     Call Trace:
> > >      skx_get_nvdimm_info+0x56/0x130 [skx_edac]
> > >      skx_get_dimm_config+0x1f5/0x213 [skx_edac]
> > >      skx_register_mci+0x132/0x1c0 [skx_edac]
> > >
> > > Cc: Bob Moore <robert.moore@intel.com>
> > > Cc: Erik Kaneda <erik.kaneda@intel.com>
> > > Fixes: cf16b05c607b ("ACPICA: ACPI 6.4: NFIT: add Location Cookie field")
> >
> > Do you want me to apply this (as the commit being fixed went in
> > through the ACPI tree)?
>
> Yes, I would need to wait for a signed tag so if you're sending urgent
> fixes in the next few days please take this one, otherwise I'll circle
> back next week after -rc1.

I'll be doing my next push after -rc1 either, so I guess it doesn't
matter time-wise.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
