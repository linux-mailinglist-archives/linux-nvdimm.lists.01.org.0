Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F9C15CE42
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Feb 2020 23:43:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D584E10FC33F9;
	Thu, 13 Feb 2020 14:46:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0A80310FC33F9
	for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 14:46:57 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id p8so7241531oth.10
        for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 14:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hY6CV+ND7e1YGXWSjo+0nHc7akywE0TMpMRwKM18M98=;
        b=SmXDDB05FgkSDjl82jr0vRzKFNDC3TzgJv9zwXei/I8lhH2nzhediAtWrWFbK9wXps
         wqfiVO9vLKiQJNvx+mp9CQFnigfPh8wsRpGBXWaHzSNrFsKci0RSWKoq+fG8mOU1ja3K
         /NCtdPzVJL3iA8WlfgAGnEM6bun1wPKuHZEjQxtkZChKXjNflJXcfsnvL1rclMTMlK6x
         gJQBCVPju+i+TEYEemIW2T1wXWG0kEK3aCPIDm7r9cls3Ljs7SmIhsmz4tCY7Narvkw4
         zbytoCGOxRXBfvQLCi0bOqRXCJxEiRUBxiMN+CtG/8LyrUCmJy9Hbtn4FVG7+NX2yDTj
         lGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hY6CV+ND7e1YGXWSjo+0nHc7akywE0TMpMRwKM18M98=;
        b=bkc/PbQZsIVKytu2AZAmfnBjlL1UspWVwsHQI0HME+lXM47cL5HHdET5Bn5WitSXPP
         G7c3/iLydGz/pwRK6QVCbo5k+7EjvEmRZ2TlOTh4YmdHdZChNLn5rW7I55O+6wVReE9C
         vtkW3b/C+bmtsyV+XSIY6/3I1b56yeQ+AIfLz1ZVP1A7+A7nLyL+9eLOrebS4lPbntOq
         N01B1O1gfACI+HLzJ/75BER1DCuB88iU75UjOtTVnS7y9zruJ1Ci7dhzaHw7NzndIlm9
         SLHTgx6Z6HKK4k/COkZ4NB7mAutzPRcLLI0xAqzsWyRA2xug1ZevMudZN+0CLNXwGefN
         5b9Q==
X-Gm-Message-State: APjAAAUVFYqAABHNrSV4f6y/nK+19Cu0mLDCm73RF+Mxd0BhJrPTHgCS
	FxZyeoeaCM4Q6i5Slkzn5XfVZGU7DWGYHiWioTfb+B+0ilo=
X-Google-Smtp-Source: APXvYqwh0QpibBwkg8wqD1qCgWrU0VARu4V8rflQRY8+mOYx9YxokcdwDNt0F3KAuE2fZ50H4DcCVvTlaEy10NTp/PU=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr15692065otk.363.1581633819941;
 Thu, 13 Feb 2020 14:43:39 -0800 (PST)
MIME-Version: 1.0
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158155490897.3343782.14216276134794923581.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49k14q5ezs.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49k14q5ezs.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 13 Feb 2020 14:43:28 -0800
Message-ID: <CAPcyv4hQouRNBcJ4uZ2mysr_aKstLhvUf66gRQ_3QoQNyOy72g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] libnvdimm/namespace: Enforce memremap_compat_align()
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: VDOVGL2S4JYILMAIEIDGPLDAGLXDHAHO
X-Message-ID-Hash: VDOVGL2S4JYILMAIEIDGPLDAGLXDHAHO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VDOVGL2S4JYILMAIEIDGPLDAGLXDHAHO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 13, 2020 at 1:55 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > The pmem driver on PowerPC crashes with the following signature when
> > instantiating misaligned namespaces that map their capacity via
> > memremap_pages().
> >
> >     BUG: Unable to handle kernel data access at 0xc001000406000000
> >     Faulting instruction address: 0xc000000000090790
> >     NIP [c000000000090790] arch_add_memory+0xc0/0x130
> >     LR [c000000000090744] arch_add_memory+0x74/0x130
> >     Call Trace:
> >      arch_add_memory+0x74/0x130 (unreliable)
> >      memremap_pages+0x74c/0xa30
> >      devm_memremap_pages+0x3c/0xa0
> >      pmem_attach_disk+0x188/0x770
> >      nvdimm_bus_probe+0xd8/0x470
> >
> > With the assumption that only memremap_pages() has alignment
> > constraints, enforce memremap_compat_align() for
> > pmem_should_map_pages(), nd_pfn, or nd_dax cases.
> >
> > Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Cc: Jeff Moyer <jmoyer@redhat.com>
> > Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Link: https://lore.kernel.org/r/158041477336.3889308.4581652885008605170.stgit@dwillia2-desk3.amr.corp.intel.com
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/nvdimm/namespace_devs.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> > index 032dc61725ff..aff1f32fdb4f 100644
> > --- a/drivers/nvdimm/namespace_devs.c
> > +++ b/drivers/nvdimm/namespace_devs.c
> > @@ -1739,6 +1739,16 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
> >               return ERR_PTR(-ENODEV);
> >       }
> >
> > +     if (pmem_should_map_pages(dev) || nd_pfn || nd_dax) {
> > +             struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
> > +             resource_size_t start = nsio->res.start;
> > +
> > +             if (!IS_ALIGNED(start | size, memremap_compat_align())) {
> > +                     dev_dbg(&ndns->dev, "misaligned, unable to map\n");
> > +                     return ERR_PTR(-EOPNOTSUPP);
> > +             }
> > +     }
> > +
> >       if (is_namespace_pmem(&ndns->dev)) {
> >               struct nd_namespace_pmem *nspm;
> >
>
> Actually, I take back my ack.  :) This prevents a previously working
> namespace from being successfully probed/setup.

Do you have a test case handy? I can see a potential gap with a
namespace that used internal padding to fix up the alignment. The goal
of this check is to catch cases that are just going to fail
devm_memremap_pages(), and the expectation is that it could not have
worked before unless it was ported from another platform, or someone
flipped the page-size switch on PowerPC.

> I thought we were only
> going to enforce the alignment for a newly created namespace?  This should
> only check whether the alignment works for the current platform.

The model is a new default 16MB alignment is enforced at creation
time, but if you need to support previously created namespaces then
you can manually trim that alignment requirement to no less than
memremap_compat_align() because that's the point at which
devm_memremap_pages() will start failing or crashing.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
