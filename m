Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 577721D886C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 18 May 2020 21:45:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DA34311D4F162;
	Mon, 18 May 2020 12:41:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 15EF511D15F9C
	for <linux-nvdimm@lists.01.org>; Mon, 18 May 2020 12:41:56 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h16so9538673eds.5
        for <linux-nvdimm@lists.01.org>; Mon, 18 May 2020 12:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98AvPLVUFFiv8829bVvMBDsSV4ORTaaKvOxhTAw6au4=;
        b=bgaWUWFS8BQa27P81AmG/w9hGlORYFhFFEVixIKGbalMrY+SzrbARefgkNpirjGoYI
         F26Z5l7yKrmjse3GY/98043ujFVAWV9pKs8aclgUWlahTMbt3HWVCLwAtfGXc1huxbaY
         nzRCqNEqdn8kNpyKSa23/PGY53VfXNcec4u3J5lI3jeYv+RYxiJllO8htErQ88yg1vim
         Cdmb7L9yAwhWZ8eh6Ucg/0XbFLRT8AlJXFxU6PVAitYBJInEOk2EdPeaZLq61ua/6Pt4
         AcSXIiSSk5XR2oOOr1/Zw8JnNWN2iCiR1v1l4PwtAQG3sMRD9Vm06/JLx0eTvGxQ+DUz
         /nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98AvPLVUFFiv8829bVvMBDsSV4ORTaaKvOxhTAw6au4=;
        b=VtzYHg2HkGITCgFtezS1gXjLQi7zl3sOYFsekM9dgoyKrXoVyM5P0F+iwIcKemEtFL
         19RlrlCZOdds5XimaFXKkEAZ+npB1rgplR8wRb1Z9Lw2HLtiLKk//VpMhEPBgHf/rr1+
         yVBNX883US+pJZseqrpw9aS2e7LaItqKilUpP7M0AE3YaD3UR2aF8mLqzjgtWSQOyz3e
         4hAZiP3vKzlzdw0WXfsywZInbeiPIFDrZUjZ3+oBTU1EH2vIQ40xCu7++EcFpkPaTv78
         LUmYDCwkSaBPNEEiY/kP3mRDPWxCQr8OppQHz21urMoSzaZt52WLL80WWCIFRlgDART1
         rR0w==
X-Gm-Message-State: AOAM533BzW5pH64BVcj/Mu3WYH2PYb83UzY+V9jSakShXv96vQghHhor
	nk7GcwWU08xA6ai7zekq7RWtRdtCuFec2UDDTxb/1A==
X-Google-Smtp-Source: ABdhPJxPSkNBXQqdwy3+WaOEI9qyJGv/GoSr3pXUWmXyeJvuVZ5OleDuHHY5nQ/2I+LrDbv6A7cc3OdmEYHc+akuda4=
X-Received: by 2002:aa7:c944:: with SMTP id h4mr10732201edt.383.1589831107355;
 Mon, 18 May 2020 12:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200511090034.GX5770@shao2-debian> <440dae1b-9146-0bc3-e8f2-bd3cb3aa89bb@intel.com>
 <CAPcyv4jKZp2bOZZ+ZMrcbFw9fPzeDu8waqwG6mBVpWwGq2DGtw@mail.gmail.com> <438c1743-5c8a-287d-3f97-e4a451ae8027@arm.com>
In-Reply-To: <438c1743-5c8a-287d-3f97-e4a451ae8027@arm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 18 May 2020 12:44:55 -0700
Message-ID: <CAPcyv4i=Mty-rvXFXNU85VJpB0zB445Gu9-J5qadHftYmpVEXg@mail.gmail.com>
Subject: Re: [ACPI] b13663bdf9: BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
To: James Morse <james.morse@arm.com>
Message-ID-Hash: WYBJGZ56QH5ZM2PYWC67KAC4YGFX7EJ2
X-Message-ID-Hash: WYBJGZ56QH5ZM2PYWC67KAC4YGFX7EJ2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, kernel test robot <rong.a.chen@intel.com>, stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, lkp@lists.01.org, Linux ACPI <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WYBJGZ56QH5ZM2PYWC67KAC4YGFX7EJ2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, May 18, 2020 at 11:08 AM James Morse <james.morse@arm.com> wrote:
>
> Hi guys,
>
> On 12/05/2020 19:05, Dan Williams wrote:
> > On Tue, May 12, 2020 at 9:28 AM Rafael J. Wysocki
> > <rafael.j.wysocki@intel.com> wrote:
> >> Dan,
> >>
> >> Has this been addressed in the v2?
> >
> > No, this looks like a case I was concerned about, i.e. the GHES code
> > is not being completely careful to avoid calling potentially sleeping
> > functions with interrupts disabled. There is the nice comment that
> > indicates that the fixmap should be used when ghes_notify_lock_irq()
> > is held, but there seems to be no infrastructure to use / divert to
> > the fixmap in the ghes_proc() path.
>
> ghes_map()/ghes_unmap() use the fixmap for reading the firmware provided records,
> but this came through apei_read(), which claims to be IRQ and NMI safe...
>
>
> > That needs to be reworked first.
> > It seems the implementation was getting lucky before to hit the cached
> > acpi_ioremap in this path under rcu_read_lock(), but it appears it
> > should have always been using the fixmap. Ying, James, is my read
> > correct?
>
> The path through this thing is pretty tortuous: The static HEST contains the address of
> the pointer that firmware updates to point to CPER records when they are generated. This
> pointer might be static (records are always in the same place), it might not.
>
> The address in the tables is static. ghes.c maps it in ghes_new():
> |       rc = apei_map_generic_address(&generic->error_status_address);
>
> which happens before the ghes_add_timer()/request_irq()/ghes_nmi_add() stuff, so we should
> always use the existing mapping.
>
> __ghes_peek_estatus() reads the pointer with apei_read(), which should use the mapping
> from ghes_new(), then uses ghes_copy_tofrom_phys() which uses the fixmap to read the CPER
> records.
>
>
> Does apei_map_generic_address() no longer keep the GAR/address mapped?
> (also possible I've totally mis-understood how ACPIs caching of mappings works!)

Upon further investigation the problem appears to be that
System-Memory OperationRegions are dynamically mapped at runtime for
ASL code. This results in every unmap event triggering eviction from
the cache and incurring synchronize_rcu_expedited(). The APEI code
avoids this path by taking an extra reference at the beginning of time
such that the rcu-walk through the cache at NMI time is guaranteed to
both succeed, and not trigger an unmap event.

So now I'm looking at whether System-Memory OperationRegions can be
generically pre-mapped in a similar fashion.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
