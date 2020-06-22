Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4B5203AD2
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Jun 2020 17:28:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 07ED010FC72A1;
	Mon, 22 Jun 2020 08:28:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.68; helo=mail-ot1-f68.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C16E610FC729F
	for <linux-nvdimm@lists.01.org>; Mon, 22 Jun 2020 08:28:05 -0700 (PDT)
Received: by mail-ot1-f68.google.com with SMTP id g7so13329027oti.13
        for <linux-nvdimm@lists.01.org>; Mon, 22 Jun 2020 08:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2c95N6ci/w7OThvHcf5Fy4XsnnDSG6ckQoNsGPl1eo=;
        b=DqTL45lKv5qel/A5k1cxJPqUEMEAhcnjI0Ug85k0wLUGg5F4r0nkA14ASo7TXAdzFg
         CJbs9TcoYb+qKk01yKzhcdzVbY49KqnwAAD/hT7IjPYaKs+IDvZzvJwuvHBaMICT8Qx+
         DB3/LA+8ZVP7V5C4x2z+YEwvEzmS2JRySsCZaty28xR1XpnG8bDRzYEsMcCIV8XOpcb6
         k+bMN6bX7dMx05n6ESBE2kIAViRFXUigr7X/OIpIhfbI6/2wa+FbxRZ02LBrm2Droks5
         qn+wQO/jtgTdjpnVz172d69grmrGX0Ng/oAMdFsuuqqhoQL9Ia2a3D74OFXE6pgKtawp
         sPRg==
X-Gm-Message-State: AOAM530IG3VRck7On63k21yUNLC3Co+1jX4oi8XkXmt/Ia92ZzWEhUwr
	R2H04io+0X0tY2iBBElcn714b67wO2rCazVIp2A=
X-Google-Smtp-Source: ABdhPJwPycask6rXfFgrsgFmggHDR562yU+PZHy41snSPCHC1tppXmJo1aa1PK+69GQNrvfUgNROeNC4pvEbtPnx6sM=
X-Received: by 2002:a05:6830:10ca:: with SMTP id z10mr13946922oto.167.1592839684757;
 Mon, 22 Jun 2020 08:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <1821880.vZFEW4x2Ui@kreacher> <CAHp75VePDyPevCAOntFpTajf5zd9ocwjeWRz80WmCNtiDicpLg@mail.gmail.com>
In-Reply-To: <CAHp75VePDyPevCAOntFpTajf5zd9ocwjeWRz80WmCNtiDicpLg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jun 2020 17:27:53 +0200
Message-ID: <CAJZ5v0hu9_TA0KAe=9ZCSG4_KijSYb=qnt8MYe9QYwGbz=pmBg@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 2/4] ACPI: OSL: Add support for deferred unmapping
 of ACPI memory
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Message-ID-Hash: 3QNQRQ5ATVAEQBTRLP4QQUJX5TVUWKVD
X-Message-ID-Hash: 3QNQRQ5ATVAEQBTRLP4QQUJX5TVUWKVD
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Kaneda <erik.kaneda@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3QNQRQ5ATVAEQBTRLP4QQUJX5TVUWKVD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 22, 2020 at 4:56 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jun 22, 2020 at 5:06 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Implement acpi_os_unmap_deferred() and
> > acpi_os_release_unused_mappings() and set ACPI_USE_DEFERRED_UNMAPPING
> > to allow ACPICA to use deferred unmapping of memory in
> > acpi_ex_system_memory_space_handler() so as to avoid RCU-related
> > performance issues with memory opregions.
>
> ...
>
> > +static bool acpi_os_drop_map_ref(struct acpi_ioremap *map, bool defer)
> >  {
> > -       unsigned long refcount = --map->refcount;
> > +       if (--map->track.refcount)
> > +               return true;
> >
> > -       if (!refcount)
> > -               list_del_rcu(&map->list);
> > -       return refcount;
> > +       list_del_rcu(&map->list);
> > +
>
> > +       if (defer) {
> > +               INIT_LIST_HEAD(&map->track.gc);
> > +               list_add_tail(&map->track.gc, &unused_mappings);
>
> > +               return true;
> > +       }
> > +
> > +       return false;
>
> A nit:
>
> Effectively it returns a value of defer.
>
>   return defer;
>
> >  }

Do you mean that one line of code could be saved?  Yes, it could.

>
> ...
>
> > @@ -416,26 +421,102 @@ void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
> >         }
> >
> >         mutex_lock(&acpi_ioremap_lock);
> > +
> >         map = acpi_map_lookup_virt(virt, size);
>
> A nit: should it be somewhere else (I mean in another patch)?

Do you mean the extra empty line?

No, I don't think so, or the code style after this patch would not
look consistent.

> >         if (!map) {
>
> ...
>
> > +       /* Release the unused mappings in the list. */
> > +       while (!list_empty(&list)) {
> > +               struct acpi_ioremap *map;
> > +
> > +               map = list_entry(list.next, struct acpi_ioremap, track.gc);
>
> A nt: if __acpi_os_map_cleanup() (actually acpi_unmap() according to
> the code) has no side effects, can we use list_for_each_entry_safe()
> here?

I actually prefer a do .. while version of this which saves the
initial check (which has been carried out already).

> > +               list_del(&map->track.gc);
> > +               __acpi_os_map_cleanup(map);
> > +       }
> > +}
>
> ...
>
> > @@ -472,16 +552,18 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
> >                 return;
> >
> >         mutex_lock(&acpi_ioremap_lock);
> > +
> >         map = acpi_map_lookup(addr, gas->bit_width / 8);
>
> A nit: should it be somewhere else (I mean in another patch)?

Nope.

Thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
