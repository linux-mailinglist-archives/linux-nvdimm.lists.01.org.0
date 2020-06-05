Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE01EFE23
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 18:40:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C6F821009F038;
	Fri,  5 Jun 2020 09:34:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9CFE31009F036
	for <linux-nvdimm@lists.01.org>; Fri,  5 Jun 2020 09:34:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n24so10818201ejd.0
        for <linux-nvdimm@lists.01.org>; Fri, 05 Jun 2020 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MiHJvWvFUN4W4TOaBTTRVwH9Kbcz3EtLSrutNpEo/8=;
        b=BXGx739NHMzDG5jF4pX2SjGcZdBMtypWsjdXc+T5TXcMRY3QFLn1zVYTB10ArVqHfw
         bS2lJVfCpuTD82oSoAPn3j92VWPnGK3U9NUDm8MQimf3XMKwYy5kLcX07pC1YGpVXB2O
         3gP+9IYgz88+xJpYfAzaurF+CZ8yPzls/rjK0WfZtXiZKUXRZsqhDHr4qc11YmqpXt9e
         r86XRpvXT+Cy7gLPk8Rype/AN669h2aux8SKpgTvrVFDhanzHQcIcspCONHUC6/YyZs1
         5ZPK/WfUFfhDs5cz5AFCES84sqyqXKNvoU5i+bNAsSbPuv0mImc46an+0ZEFKox19Ymn
         uSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MiHJvWvFUN4W4TOaBTTRVwH9Kbcz3EtLSrutNpEo/8=;
        b=lHeKN3Nj0ItPDGI991TfwvF9iYsEpFAz9HrwEEz2sjeIhxfb5A88YR/vmRJHO3Hc7H
         RCa6pNyCYG7K//d+IlJJmx1kX5UOtVFpU7nvxXE4c/ND/kZMn7GWHPG1y+v//EVf4hzz
         Tx21P+F5Qs6gGZ998WRd09x2UOR0KxT5RICXA9VQGgn0beSajzOwN1olVtTkKws3T/a5
         0dbFsT+vbOSatywe1bHWNDA2/9GwgsW73/lLqXSOSccj83vTXjhweywvPmHoXEYWDLH6
         MVoyQx25t1DWpR2NP6M43T5IRIsDyHnJkE2AR6GxYSFziURFMD31sEQD4bT9+twcWGP6
         aTLQ==
X-Gm-Message-State: AOAM530AP/06DZL+4J8FRxeeepgPdR7nbMubiKtZX5ttwAAqXGEq8yQ2
	anM1uwbrBlaI70OxDsofBlEMeJwWFSpUutdItuzQXw==
X-Google-Smtp-Source: ABdhPJz9NOYy2yZ6H8XGWcEzcmqj7Uj80HxfYALJr2J1pSWlpcP4qVMIo7RE/ZyxbXyEIMN2Y5wxAGBnr9c0Vhr3t/s=
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr4137917ejb.237.1591375193798;
 Fri, 05 Jun 2020 09:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0gq55A7880dOJD7skwx7mnjsqbCqEGFvEo552U9W2zH3Q@mail.gmail.com>
 <CAPcyv4gQNPNOmSVrp7epS5_10qLUuGbutQ2xz7LXnpEhkWeA_w@mail.gmail.com> <CAJZ5v0g-TSk+7d-b0j5THeNtuSDeSJmKZHcG3mBesVZgkCyJOg@mail.gmail.com>
In-Reply-To: <CAJZ5v0g-TSk+7d-b0j5THeNtuSDeSJmKZHcG3mBesVZgkCyJOg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 5 Jun 2020 09:39:42 -0700
Message-ID: <CAPcyv4iECAzRjAUJ1hymOzZRjBYQ_baFrSz=2ah=2pfehn9S_g@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Drop rcu usage for MMIO mappings
To: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID-Hash: 3A6YXBZY26HPDNL33R7BUAW3AEGEHGP7
X-Message-ID-Hash: 3A6YXBZY26HPDNL33R7BUAW3AEGEHGP7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Rafael Wysocki <rafael.j.wysocki@intel.com>, Stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3A6YXBZY26HPDNL33R7BUAW3AEGEHGP7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 5, 2020 at 9:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
[..]
> > The fix we are looking at now is to pre-map operation regions in a
> > similar manner as the way APEI resources are pre-mapped. The
> > pre-mapping would arrange for synchronize_rcu_expedited() to be elided
> > on each dynamic mapping attempt. The other piece is to arrange for
> > operation-regions to be mapped at their full size at once rather than
> > a page at a time.
>
> However, if the RCU usage in ACPI OSL can be replaced with an rwlock,
> some of the ACPICA changes above may not be necessary anymore (even
> though some of them may still be worth making).

I don't think you can replace the RCU usage in ACPI OSL and still
maintain NMI lookups in a dynamic list.

However, there are 3 solutions I see:

- Prevent acpi_os_map_cleanup() from triggering at high frequency by
pre-mapping and never unmapping operation-regions resources (internal
discussion in progress)

- Prevent walks of the 'acpi_ioremaps' list (acpi_map_lookup_virt())
from NMI context by re-writing the physical addresses in the APEI
tables with pre-mapped virtual address, i.e. remove rcu_read_lock()
and list_for_each_entry_rcu() from NMI context.

- Split operation-region resources into a separate mapping mechanism
than APEI resources so that typical locking can be used for the
sleepable resources and let the NMI accessible resources be managed
separately.

That last one is one we have not discussed internally, but it occurred
to me when you mentioned replacing RCU.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
