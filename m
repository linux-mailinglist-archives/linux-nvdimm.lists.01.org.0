Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7894153E5B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Feb 2020 06:51:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9511910FC317D;
	Wed,  5 Feb 2020 21:54:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CA35010F6CD1C
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 21:54:56 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 66so4384788otd.9
        for <linux-nvdimm@lists.01.org>; Wed, 05 Feb 2020 21:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5g0ucY/9ZUFtix2XnQy2cuPMuPVQiShNOwSgn0I8OBU=;
        b=xqhYbXKDufyJWDOQlr2Ba/YbuGJTDJ2ziwxMsioPHK8lJUB4/CAxrEL+moRSD8vyrb
         P8EqSdqAMegqk31UKFdftPK5/+cmDLrCM6ly22OIyg6gsdd2R7ZLPjw9pcUJ/q5RR0G5
         fLmVfaMcawk1UE/23D6St4s/a6I9mTLo3F5jajstpw7oCE/fYrfhTRbXrLuPqW2SHJPy
         AJ5z5DEgvFpoMlwxgzPfG0OUuAZs64RZ1jdy1x38BTGcFFSZZlvzqoHwnS5WYlKlxHrT
         S4P0VJvg0zJv7zvW0pAdwx8kw9JZ9LQMIqF1abVjF4Dd0TKDl4DBYq5Lc7iYYQ8GUTiR
         SyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5g0ucY/9ZUFtix2XnQy2cuPMuPVQiShNOwSgn0I8OBU=;
        b=BvvlWIDJVgw6ayxDqOKpWaKNmQR6f9EFfgX3tFd9a+q57+M0oai5Kv8s8MMoqKGDPe
         G8f/Jhzsy6GDtjKfWhuSYUfYY7stBroohAqNyGcQt5hWnKaV4yArCS2yj44Kx2dSJ9aA
         5KIl2kf6swChWPVvvZv4Bxbv/29232FIT2M1TRj2NNHfUZZ49hfKpOnNlUXmdAD6DLJl
         nFXgIMmx9GBEGL4Y64uIFF1JhHrIt4cLcOvvV5JUBWbONz8lAvs0G7NppkRQNDbFyIL9
         q2nS9oMFfNezwxRWHV9/kP9GkfnBL9qLnAtJ7GxApGvDPXJtraNwZLEzjEpVTGQzGT3b
         2bEA==
X-Gm-Message-State: APjAAAWCSkPpr2qBYM0XZu+Inppg0reFo2F9+s8M1rTRu4/FG94Z0xiw
	WXxXFRORNQPNlmNWntNL6wlUE5EZY5IQ6HS18eadyg==
X-Google-Smtp-Source: APXvYqypAdFCvnslXe/NRqIbZavieNDLc3RQJ1uJD67YGnwibNCmUiqPR2pnxgssN+GhWMlzNTosjpJpU37+bWuZVfs=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr27237824otl.71.1580968298443;
 Wed, 05 Feb 2020 21:51:38 -0800 (PST)
MIME-Version: 1.0
References: <158041475480.3889308.655103391935006598.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158041476763.3889308.13149849631980018039.stgit@dwillia2-desk3.amr.corp.intel.com>
 <875zgl3fa9.fsf@mpe.ellerman.id.au>
In-Reply-To: <875zgl3fa9.fsf@mpe.ellerman.id.au>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 5 Feb 2020 21:51:27 -0800
Message-ID: <CAPcyv4jVHnJbPYp1gqDnuwtEgt1NNHDt72vby7hK5dP43C+s8Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/memremap_pages: Introduce memremap_compat_align()
To: Michael Ellerman <mpe@ellerman.id.au>
Message-ID-Hash: WFDSUEHASK5FAGC35JNS5I34CCANK2FT
X-Message-ID-Hash: WFDSUEHASK5FAGC35JNS5I34CCANK2FT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WFDSUEHASK5FAGC35JNS5I34CCANK2FT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 4, 2020 at 7:05 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
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
> > persistent memory resource on smaller than 16MiB boundaries.
> >
> > Based on an initial patch by Aneesh.
> >
> > Link: http://lore.kernel.org/r/CAPcyv4gBGNP95APYaBcsocEa50tQj9b5h__83vgngjq3ouGX_Q@mail.gmail.com
> > Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/powerpc/include/asm/io.h |   10 ++++++++++
> >  drivers/nvdimm/pfn_devs.c     |    2 +-
> >  include/linux/io.h            |   23 +++++++++++++++++++++++
> >  include/linux/mmzone.h        |    1 +
> >  4 files changed, 35 insertions(+), 1 deletion(-)
>
> The powerpc change here looks fine to me.
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thanks Michael, unfortunately the kbuild robot just woke up and said
that mips does not like including mmzone.h from io.h. The
entanglements look intractable.

Is there a file I can stash a strong definition of
memremap_compat_align(), maybe arch/powerpc/mm/mem.c? Then I can put a
generic __weak definition in mm/memremap.c rather than play header
file include games.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
