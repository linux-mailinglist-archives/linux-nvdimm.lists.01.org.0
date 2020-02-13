Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E5F15CA56
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Feb 2020 19:27:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60FD810FC337F;
	Thu, 13 Feb 2020 10:30:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 873F010FC337D
	for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 10:30:18 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id i1so6756625oie.8
        for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 10:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpDOVVwQMoKUWV1DWVonUPFvZBLp80J0wZPDxMAaRfY=;
        b=rXaw+VQU+BjuhG30DscKYH7MHhb9UTyRb7apt36HoQ8vdfEazZoV8TpMsYehOANm0i
         Ad49SZMMYnTxNsI7UYPu9i/7tKY+5XCh/fe8Z1IbV33TjJwh5imPo0ja1SnmDxIPKhfn
         q+yfBnL9eDiFLTnNzbTpbFj5XyBowu9DqukeqXcR2zJ2l+nDzbWibmPHahu0Rvx6B7gV
         LCizkUaCHYg1paEJYE6UMN3g7C1a9UI3LSbC0Pj+VY65RbvSvZZ46MAz9Lzu1ZR9HI0C
         k+JHaH7IVx36F/8pTOY+F3F7OSNAfYTrt+U8MtfhYkDEjbioFaldj1Q3VG7lIVd6c1/G
         sjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpDOVVwQMoKUWV1DWVonUPFvZBLp80J0wZPDxMAaRfY=;
        b=dfeI+r2Kl4ynh51lYcLNESvp4IlcbLgXTtltLioC08ujVfJ7pTv097uhuv7H3Tl3ig
         oSzRqYla1eEuquRczxP4KDKjmxI0Q3FgT0fmYyi2552iCBc6pYPMp+tZF37L6V/qUPgy
         8BZ5c9Tq6Ff3LTxCU3dcjrm15RPWw7Av+hp4oi1fKPeRlsCqkoKSKS92FwDAzfwJh4hE
         Z9LmqNSweUcSppQXhNZ6q/WVnfWRcgWRNl13Bam6WCIXXrAPVO0XM/7WkhEC/uX48QSD
         Jhx0EQYmf1t8kfH4eJ++++d27ufsaG/7HMBLNdPcH39sBq4qaUmrunCR4+2fVfx9He+z
         nskw==
X-Gm-Message-State: APjAAAWLtFm4OjfoSC+jgG64FdjViWekueXfJqh+Eg5uGdNHe7sSKnZ8
	eMIMQAX/cnnJ5XVFu07+v2whyugFesOoAcv25eOMbQ==
X-Google-Smtp-Source: APXvYqxht5FHJenXXKFjAcL0FoNd3tudfWztDG42KiVuUkVg02EE/Iivz69tviiGm0uxN1GdKP8BzvtNR9xEopXkwfI=
X-Received: by 2002:aca:4c9:: with SMTP id 192mr4016542oie.105.1581618420229;
 Thu, 13 Feb 2020 10:27:00 -0800 (PST)
MIME-Version: 1.0
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158155490379.3343782.10305190793306743949.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x498sl677cf.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x498sl677cf.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 13 Feb 2020 10:26:49 -0800
Message-ID: <CAPcyv4i8xNEsdX=8c2+ehf24U2AFcc-sKmAPS9UoVvm8z0aRng@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/memremap_pages: Introduce memremap_compat_align()
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: GGMSFAHIA6JZ4DQP4LMMDQZQVOPVLV3L
X-Message-ID-Hash: GGMSFAHIA6JZ4DQP4LMMDQZQVOPVLV3L
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GGMSFAHIA6JZ4DQP4LMMDQZQVOPVLV3L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 13, 2020 at 8:58 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > The "sub-section memory hotplug" facility allows memremap_pages() users
> > like libnvdimm to compensate for hardware platforms like x86 that have a
> > section size larger than their hardware memory mapping granularity.  The
> > compensation that sub-section support affords is being tolerant of
> > physical memory resources shifting by units smaller (64MiB on x86) than
> > the memory-hotplug section size (128 MiB). Where the platform
> > physical-memory mapping granularity is limited by the number and
> > capability of address-decode-registers in the memory controller.
> >
> > While the sub-section support allows memremap_pages() to operate on
> > sub-section (2MiB) granularity, the Power architecture may still
> > require 16MiB alignment on "!radix_enabled()" platforms.
> >
> > In order for libnvdimm to be able to detect and manage this per-arch
> > limitation, introduce memremap_compat_align() as a common minimum
> > alignment across all driver-facing memory-mapping interfaces, and let
> > Power override it to 16MiB in the "!radix_enabled()" case.
> >
> > The assumption / requirement for 16MiB to be a viable
> > memremap_compat_align() value is that Power does not have platforms
> > where its equivalent of address-decode-registers never hardware remaps a
> > persistent memory resource on smaller than 16MiB boundaries. Note that I
> > tried my best to not add a new Kconfig symbol, but header include
> > entanglements defeated the #ifndef memremap_compat_align design pattern
> > and the need to export it defeats the __weak design pattern for arch
> > overrides.
> >
> > Based on an initial patch by Aneesh.
>
> I have just a couple of questions.
>
> First, can you please add a comment above the generic implementation of
> memremap_compat_align describing its purpose, and why a platform might
> want to override it?

Sure, how about:

/*
 * The memremap() and memremap_pages() interfaces are alternately used
 * to map persistent memory namespaces. These interfaces place different
 * constraints on the alignment and size of the mapping (namespace).
 * memremap() can map individual PAGE_SIZE pages. memremap_pages() can
 * only map subsections (2MB), and at least one architecture (PowerPC)
 * the minimum mapping granularity of memremap_pages() is 16MB.
 *
 * The role of memremap_compat_align() is to communicate the minimum
 * arch supported alignment of a namespace such that it can freely
 * switch modes without violating the arch constraint. Namely, do not
 * allow a namespace to be PAGE_SIZE aligned since that namespace may be
 * reconfigured into a mode that requires SUBSECTION_SIZE alignment.
 */

> Second, I will take it at face value that the power architecture
> requires a 16MB alignment, but it's not clear to me why mmu_linear_psize
> was chosen to represent that.  What's the relationship, there, and can
> we please have a comment explaining it?

Aneesh, can you help here?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
