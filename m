Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 178783766E9
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 May 2021 16:12:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 571E3100EAB71;
	Fri,  7 May 2021 07:12:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 32C71100EB82B
	for <linux-nvdimm@lists.01.org>; Fri,  7 May 2021 07:12:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s7so5704623edq.12
        for <linux-nvdimm@lists.01.org>; Fri, 07 May 2021 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLniGNx4BxwN5Xd2zc0IGUwak+T5o8FFC1I3NPRJVXE=;
        b=uSs5tE4pdnmy1J5EesfN1eVWvpFDfJ1ly/S1gTE+RpFTbkyv0qiHb7E3qglgh8xHeS
         51bFyaQw0kQBalHPUo0unemVmMkSLKeHgnWjmLyZviH5ltlwQ5w8sEy88hLzBwu7ad/B
         zId42r9UHXvzucZJhnw6CY46qlzIOkoSgUuGrt9Qln+5C8FcQvhsJ2TJNZ8XMIPfRNpe
         hH2GQpcVWp/1TFmPymsPLa+DjiOZsOXrMSqn3NO5nSt30M5AUVcS1/z6Jfs5LgU9uaAq
         Z/Xli3WwfSlv2I4lCwDksdIsO3RJhiGl3/c9yr6lKw5xT5P2QsOrTRaen476Jl00SkKB
         KyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLniGNx4BxwN5Xd2zc0IGUwak+T5o8FFC1I3NPRJVXE=;
        b=p3oiOka8JMhqewceUb8rnEvv6Nc0hmMrdwVRN80Y4bf+V33UziXL38/PKQ2FaBzQcC
         i0Y+yRttq3SCzZZprqrsTGS8KD5x7pldtAt3T3R/9vudaEF8ZmTur16ffbgXNEDqTW0H
         Hzc/B20/UNNdyl9gFM6FqrNZAkCJLssbPTJoFxdsp9I1jKDxuOAQPtXb+62a7YXXuMef
         3GEc+K7hdXcWNPJGSe3l9Svi4Zb6yB0bmqGptgtujQUofmyJn36s8jLY4MY53GCh6mgl
         05qAKaEUuJwRrEBRLQUGFgMemiNNP90gA5TydS5rf47nwyNURhI/+gl+fEqNgbGK1LTM
         P1Lw==
X-Gm-Message-State: AOAM531ecrImttreO6o9nUk98dzGsM1rtOm+DkCE8N94/+wQjg9NEmHu
	8vku7WIKYbPiEyDAV/XvR5B5Do7WQly4BGV6QE9qkA==
X-Google-Smtp-Source: ABdhPJwWyScMuqXDcIBAuztYBHKcNDRNOaJtIKcFL4gBL8++2X0f1kwToRZXeC3Mdnv0qiilb3DxuPS08o181IP/mbQ=
X-Received: by 2002:a50:f0d6:: with SMTP id a22mr11880375edm.354.1620396766237;
 Fri, 07 May 2021 07:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <162037273007.1195827.10907249070709169329.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0gBCxFQ1pC1PTRximwzGXOSQDCzOfjX497aqBq5GQ48tA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gBCxFQ1pC1PTRximwzGXOSQDCzOfjX497aqBq5GQ48tA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 7 May 2021 07:12:51 -0700
Message-ID: <CAPcyv4jUdebFQvrhi0yzNyZ1wwzeGDpf6T34m=bfL593s-PEcA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NFIT: Fix support for variable 'SPA' structure size
To: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID-Hash: U4KDFSWO7M5CDRQFY6FXWMPXNTBBJMPM
X-Message-ID-Hash: U4KDFSWO7M5CDRQFY6FXWMPXNTBBJMPM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Rafael Wysocki <rafael.j.wysocki@intel.com>, Bob Moore <robert.moore@intel.com>, Erik Kaneda <erik.kaneda@intel.com>, Yi Zhang <yi.zhang@redhat.com>, nvdimm@lists.linux.dev, linux-nvdimm <linux-nvdimm@lists.01.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U4KDFSWO7M5CDRQFY6FXWMPXNTBBJMPM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 7, 2021 at 2:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Hi Dan,
>
> On Fri, May 7, 2021 at 9:33 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > ACPI 6.4 introduced the "SpaLocationCookie" to the NFIT "System Physical
> > Address (SPA) Range Structure". The presence of that new field is
> > indicated by the ACPI_NFIT_LOCATION_COOKIE_VALID flag. Pre-ACPI-6.4
> > firmware implementations omit the flag and maintain the original size of
> > the structure.
> >
> > Update the implementation to check that flag to determine the size
> > rather than the ACPI 6.4 compliant definition of 'struct
> > acpi_nfit_system_address' from the Linux ACPICA definitions.
> >
> > Update the test infrastructure for the new expectations as well, i.e.
> > continue to emulate the ACPI 6.3 definition of that structure.
> >
> > Without this fix the kernel fails to validate 'SPA' structures and this
> > leads to a crash in nfit_get_smbios_id() since that routine assumes that
> > SPAs are valid if it finds valid SMBIOS tables.
> >
> >     BUG: unable to handle page fault for address: ffffffffffffffa8
> >     [..]
> >     Call Trace:
> >      skx_get_nvdimm_info+0x56/0x130 [skx_edac]
> >      skx_get_dimm_config+0x1f5/0x213 [skx_edac]
> >      skx_register_mci+0x132/0x1c0 [skx_edac]
> >
> > Cc: Bob Moore <robert.moore@intel.com>
> > Cc: Erik Kaneda <erik.kaneda@intel.com>
> > Fixes: cf16b05c607b ("ACPICA: ACPI 6.4: NFIT: add Location Cookie field")
>
> Do you want me to apply this (as the commit being fixed went in
> through the ACPI tree)?

Yes, I would need to wait for a signed tag so if you're sending urgent
fixes in the next few days please take this one, otherwise I'll circle
back next week after -rc1.

>
> If you'd rather take care of it yourself:
>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
