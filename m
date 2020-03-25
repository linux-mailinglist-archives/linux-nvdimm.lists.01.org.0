Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6B192EF2
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Mar 2020 18:10:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0FDC310FC340C;
	Wed, 25 Mar 2020 10:11:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C4C9910FC3166
	for <linux-nvdimm@lists.01.org>; Wed, 25 Mar 2020 10:11:42 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a43so3409172edf.6
        for <linux-nvdimm@lists.01.org>; Wed, 25 Mar 2020 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3TB/V3cS5dQRTb7u6NS+KlfC79/CqRkvKXs/fm6g34w=;
        b=eHcC+28qlTy7M88OlVi6MBXlOrqK6YikB2zKmxyH4Yh1II3FzBdkQrjEEUT5Zt3lJu
         ckS7jpRPAdgt6whblMJd4ptrhZCQL79TrQz8EbzL0SeL83J/LyAjkzbRTsOj4IE/KEeE
         s2Cx4bQIQCOK5OekxWCKafQD5/kxGKWTNVCCl4E/5W9kzq593H6wZiiDm60ecwOxStL2
         LeujouVThMSlNjsaf48F3Yw3But0ebd1m3dEIw4LmAEfh2yIpX1peWDg7aUtH9KwQIa8
         ruxLdm7gd+iIRBKXSIwL4KQlpkNOOyUGpbdyDdyC5u5j4vY/p7zfHHalqOU/fQZAlsKW
         n5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TB/V3cS5dQRTb7u6NS+KlfC79/CqRkvKXs/fm6g34w=;
        b=CB5qcpXBGVNmcoR2k9R88bi8oJ3qnVkMZoC6UfnhNjKR3K0hsRAn2J2EYLxJ4wDt6r
         DSWeHdDPNpKbiGIBJ0Nbw4EmUXMHaEXtsMzMrrv2AjxgmTbWa/3ejNs9iZj+zlKe1hLT
         h4Iq2V2eVIaP0z/ZFpPOsojRkFywBWfEtn9DjJGr8Hec8S7pNco9hqDb5BggBk57gPh0
         bTAsLvu517hjOpa9qS5pV4VsPInedpIeQUdTEVC6RY1ERfJWJscAs133RJGKz+h9Yllo
         iYFmhJUQ/0KRLQUugEqEf8X+BPLh+nTGK5FYcurTll+ji32VaEzwicutrvkmVlIaRdA9
         e7Fw==
X-Gm-Message-State: ANhLgQ3qD/ni2EQkzwVx4WxnZU78WT0gCZ3G7TzEIZ7w6zVhprs5lCXH
	kYibQUECAu5VY1En9VtTMTLs55zBZ/Y4DdZ2R8ASkw==
X-Google-Smtp-Source: ADFU+vsMpfwwBF1AU4XFYsAjtIxydM3lmExgrwiqtzAko7x2yr0UVmhQyTxicjQSFrrQLSYnbAn1QFVDiy2ZTJ11JoQ=
X-Received: by 2002:a17:906:1e8a:: with SMTP id e10mr4231020ejj.56.1585156250955;
 Wed, 25 Mar 2020 10:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158489357825.1457606.17352509511987748598.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200325111039.GA32109@willie-the-truck>
In-Reply-To: <20200325111039.GA32109@willie-the-truck>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 25 Mar 2020 10:10:36 -0700
Message-ID: <CAPcyv4jQDbdUN3pwjkDx-R6Dd3adDSWq+50+O7mqZw5ezNXHeg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] ACPI: HMAT: Attach a device for each soft-reserved range
To: Will Deacon <will@kernel.org>
Message-ID-Hash: NX2HKFBVOM7VNMIE7HX33O2JDBEZVXTH
X-Message-ID-Hash: NX2HKFBVOM7VNMIE7HX33O2JDBEZVXTH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Brice Goglin <Brice.Goglin@inria.fr>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Joao Martins <joao.m.martins@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NX2HKFBVOM7VNMIE7HX33O2JDBEZVXTH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 25, 2020 at 4:10 AM Will Deacon <will@kernel.org> wrote:
>
> On Sun, Mar 22, 2020 at 09:12:58AM -0700, Dan Williams wrote:
> > The hmem enabling in commit 'cf8741ac57ed ("ACPI: NUMA: HMAT: Register
> > "soft reserved" memory as an "hmem" device")' only registered ranges to
> > the hmem driver for each soft-reservation that also appeared in the
> > HMAT. While this is meant to encourage platform firmware to "do the
> > right thing" and publish an HMAT, the corollary is that platforms that
> > fail to publish an accurate HMAT will strand memory from Linux usage.
> > Additionally, the "efi_fake_mem" kernel command line option enabling
> > will strand memory by default without an HMAT.
> >
> > Arrange for "soft reserved" memory that goes unclaimed by HMAT entries
> > to be published as raw resource ranges for the hmem driver to consume.
> >
> > Include a module parameter to disable either this fallback behavior, or
> > the hmat enabling from creating hmem devices. The module parameter
> > requires the hmem device enabling to have unique name in the module
> > namespace: "device_hmem".
> >
> > Rather than mark this x86-only, include an interim phys_to_target_node()
> > implementation for arm64.
> >
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Brice Goglin <Brice.Goglin@inria.fr>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Jeff Moyer <jmoyer@redhat.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/arm64/mm/numa.c      |   13 +++++++++++++
> >  drivers/dax/Kconfig       |    1 +
> >  drivers/dax/hmem/Makefile |    3 ++-
> >  drivers/dax/hmem/device.c |   33 +++++++++++++++++++++++++++++++++
> >  4 files changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > index 4decf1659700..00fba21eaec0 100644
> > --- a/arch/arm64/mm/numa.c
> > +++ b/arch/arm64/mm/numa.c
> > @@ -468,3 +468,16 @@ int memory_add_physaddr_to_nid(u64 addr)
> >       pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
> >       return 0;
> >  }
> > +
> > +/*
> > + * device-dax instance registrations want a valid target-node in case
> > + * they are ever onlined as memory (see hmem_register_device()).
> > + *
> > + * TODO: consult cached numa info
> > + */
> > +int phys_to_target_node(phys_addr_t addr)
> > +{
> > +     pr_warn_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
> > +                     addr);
> > +     return 0;
> > +}
>
> Could you implement a generic version of this by iterating over the nodes
> with for_each_{,online_}node() and checking for intersection with
> node_{start,end}_pfn()?

Interesting. The gap is that node_{start,end}_pfn() requires
node_data[] which to date architectures have only setup for online
nodes. Recall a target node is an offline node that could come online
later. However, reworking offline data into node_data could be the
local solution for arm64, I'd just ask that each of the 6
memory-hotplug capable archs go make that opt-in decision themselves.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
