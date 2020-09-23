Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C692274DF5
	for <lists+linux-nvdimm@lfdr.de>; Wed, 23 Sep 2020 02:43:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6CD4B1459414C;
	Tue, 22 Sep 2020 17:43:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DB5BE13F8350E
	for <linux-nvdimm@lists.01.org>; Tue, 22 Sep 2020 17:43:14 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id j2so17986458eds.9
        for <linux-nvdimm@lists.01.org>; Tue, 22 Sep 2020 17:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63NW9gk7HRpDHGoorZLXSxJtBEzJkCrOurZGFYdeq1s=;
        b=QEiJCmMJ+abH4jXWF874MeS11eIiKXKE3h+n39sqAGLPIycrn0MxhLfS6Wo+aHjo6o
         BgjErpz4dkHZ481e5ATkWq93dIaYf6zudSHfhcDNkoV5W8p3tDbaqO0s4spGS+JLBOVL
         xn4KEw0MJ1HUUzUo1qdlmI3HLQin57sr4yXqNNwLYhvbPhHVBqnKcLDYDRBfUSirJosj
         6VaWUYcV9FK1rBmUDtcRLgsOTXJ8dZ55TiXMjedniQ+O9jvUR4qfgY1xDTm4+TC3Ugui
         fAgPDzIRGT2lufyhiDkf+4OuUSwYygqW1DEk06diJYWny7csi55q33hB6fNRubbxlgJ1
         Vk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63NW9gk7HRpDHGoorZLXSxJtBEzJkCrOurZGFYdeq1s=;
        b=FOJefA8FGJEo8/ksH9sMb6TgxaXV+tJd23gtRJLfhb/ZlCLP1UDhjCPnZkl4mex9RZ
         JRI9QIRw2UBa/kPKtEWkQs/UvRZXZgcbLmhErzIuRNphPpwV2r+xM1LILdai+3EURqbv
         2ni5xIMBByhq/fh9AeIZGzWFdegkOR8GfHXD/8bpWf21WPsLa/2BYfw3UH2ZbIK5C8ff
         MVTjC0oYDMjhwB/3HZnWszfgZcCBsf179VTdCTbb+BOK+Gk1+doFRxbvejhRx1M9BADR
         6ip2QQlRmZcRHOODPlqsbLuwrFPxbxoSNPAxwLHd2ALE4DMt4oVD8odAQYjeKrMvP805
         XkoA==
X-Gm-Message-State: AOAM533+cncDuARMx62be2d17CVBVdcfMxEo/H3vVDk4isAp4bUGqSmy
	g2GjmlVemnCe6f+byUk8FxeggIeiDoDWoZBiroYYSw==
X-Google-Smtp-Source: ABdhPJxEyMjaWBOlTNqZq+aOqsUhRrRJuhmMZTQc6iiISsny0Ld0R8ZOQAu5Co8gVaeeYbMO5GjUCtpLRRG7qTwcHRY=
X-Received: by 2002:aa7:c511:: with SMTP id o17mr7090354edq.300.1600821793001;
 Tue, 22 Sep 2020 17:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
 <c59111f9-7c94-8b9e-2b8c-4cb96b9aa848@redhat.com> <CAPcyv4j8-5nWU5GPDBoFicwR84qM=hWRtd78DkcCg4PW-8i6Vg@mail.gmail.com>
 <20200821162134.97d551c6fe45b489992841a8@linux-foundation.org> <7d51834a-9544-b2e8-bfba-1c3e2da0e470@redhat.com>
In-Reply-To: <7d51834a-9544-b2e8-bfba-1c3e2da0e470@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 22 Sep 2020 17:43:01 -0700
Message-ID: <CAPcyv4gfBj66Dwy0yn2CX=cCT=yqR9wHE2gY1Q5_Nq2vnh0zPg@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved ranges
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: VOSWB7EXJCSU2564JY7RIRBMEEQJXN3D
X-Message-ID-Hash: VOSWB7EXJCSU2564JY7RIRBMEEQJXN3D
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Joao Martins <joao.m.martins@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@ozlabs.org>, Brice Goglin <Brice.Goglin@inr
 ia.fr>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Vetter <daniel@ffwll.ch>, Andy Lutomirski <luto@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Zhen Lei <thunder.leizhen@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VOSWB7EXJCSU2564JY7RIRBMEEQJXN3D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 8, 2020 at 3:46 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 22.08.20 01:21, Andrew Morton wrote:
> > On Wed, 19 Aug 2020 18:53:57 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >
> >>> I think I am missing some important pieces. Bear with me.
> >>
> >> No worries, also bear with me, I'm going to be offline intermittently
> >> until at least mid-September. Hopefully Joao and/or Vishal can jump in
> >> on this discussion.
> >
> > Ordinarily I'd prefer a refresh&resend for 2+ week-old series such as
> > this.
> >
> > But given that v4 all applies OK and that Dan has pending outages, I'll
> > scoop up this version, even though at least one change has been suggested.
> >
>
> Should I try to fix patch #11 while Dan is away? Because I think at
> least two things in there are wrong (and it would have been better to
> split that patch into reviewable pieces).

Hey David,

Back now, I'll take a look. I didn't immediately see a way to
meaningfully break up that patch without some dead-code steps in the
conversion, but I'll take another run at it.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
