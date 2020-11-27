Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794552C698A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 27 Nov 2020 17:41:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D72E1100EBBC8;
	Fri, 27 Nov 2020 08:41:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com; envelope-from=enbyamy@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AA890100EBBC7
	for <linux-nvdimm@lists.01.org>; Fri, 27 Nov 2020 08:41:55 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id v202so6432582oia.9
        for <linux-nvdimm@lists.01.org>; Fri, 27 Nov 2020 08:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvWvhtMw4/htNL9ufrpeeiTrNh5C8K1xoJuv3kml8OU=;
        b=mWijLgZ5NSU7tK5Er9vqbGC4jbfS0Bqq/aYyMsemdaGkzC26693YU2vfClXz6l5bFX
         8V9Tmh1URUsBmfAtzpfJBSsWjrAMMRM9/VMPWONetAV5szTP8VaMKJt+DpMU0x3qRxB/
         4YoNhkXtcge1clOF9lx0p8oXJqD3ybi1HvdmslWxLE5axdlugRoidPml/hLfeIITAWtl
         yTKrJi82eFqDSzCwL+Yzgm5kKBDeaBT1VyKWR1CG4OsbzW+rx4h73WYKIcI9FPIy9+GM
         iu3pcLOuzKUDAHJ3BQiAIDZYWXTxv9STtLSAcRtxi6amYyeKf3Y7xbbxGpa2Uz/KoAYg
         /0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvWvhtMw4/htNL9ufrpeeiTrNh5C8K1xoJuv3kml8OU=;
        b=PDjGiHjZHBowYAEzry7VlcPoNliRz3CiIaiLI9YaxQm2pjW+LBA43ibjU4r9vTya3k
         bMS3DPSc2hcngkJ/FWOV453iDSND5/amr+uGt9AN7yNIuvmFtDRaV8NRA9Cr3JSZPodw
         1xn2WNzOmKxMah7XTDgijF68Fpc74pDxgr4FT1wfQPbFT3J2+HtYoohdaVl51CVFBRLs
         b1ZPncaaYC4hkf4U0D+pMWKHmu9CSIRd/LNtd3oDIaPDyTvrrgjya9D7btH8KaFTJK0h
         pK88HgHNCEmWddGsaPgE1uoS4vGi8RVjg25gmUvQJhYQK5wag3AEWZbM0UYSA/lU1elj
         0dKQ==
X-Gm-Message-State: AOAM533sCca7hrVxSKXHaEM12x2Ru+zLwcGdKMHhBLqm5o/oGr690CQV
	CQZ9lQvWKmGskHgAGtSCd8HyRTKeOlNGQDTwtzs=
X-Google-Smtp-Source: ABdhPJwRKRxB7y76hqIzaFmgJaVpdK47Nv9ZPEeXr/XzuKloFjYjcqgPameihf+YTWPob14ioae9JMvesl5/ldmcCDA=
X-Received: by 2002:a05:6808:3b1:: with SMTP id n17mr6121939oie.139.1606495314568;
 Fri, 27 Nov 2020 08:41:54 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT6O6uP12YMU1NaU-4CR-AaxRUhhWHY=zUtNXpHUfxrF=A@mail.gmail.com>
 <20201109013322.GA9685@magnolia> <20201109015001.GX17076@casper.infradead.org>
 <CAE1WUT7LBAKYoZ=-UxEdt1OdoirwcKMU_A=6TAKPo7HxwnS+zw@mail.gmail.com> <20201109033559.GY17076@casper.infradead.org>
In-Reply-To: <20201109033559.GY17076@casper.infradead.org>
From: Amy Parker <enbyamy@gmail.com>
Date: Fri, 27 Nov 2020 08:41:43 -0800
Message-ID: <CAE1WUT4-jc-R-Hi2X8QpnNBCNMv3Bb4jWivnVzB1Lu=VCxupcA@mail.gmail.com>
Subject: Re: Best solution for shifting DAX_ZERO_PAGE to XA_ZERO_ENTRY
To: Matthew Wilcox <willy@infradead.org>
Message-ID-Hash: LVG5UZUYT2TTSE22VNZK4BAIM2VPFTBH
X-Message-ID-Hash: LVG5UZUYT2TTSE22VNZK4BAIM2VPFTBH
X-MailFrom: enbyamy@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Darrick J. Wong" <darrick.wong@oracle.com>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LVG5UZUYT2TTSE22VNZK4BAIM2VPFTBH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sorry for the long reply time - personal issues came up.

On Sun, Nov 8, 2020 at 7:36 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Nov 08, 2020 at 05:54:14PM -0800, Amy Parker wrote:
> > On Sun, Nov 8, 2020 at 5:50 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Sun, Nov 08, 2020 at 05:33:22PM -0800, Darrick J. Wong wrote:
> > > > On Sun, Nov 08, 2020 at 05:15:55PM -0800, Amy Parker wrote:
> > > > > XA_ZERO_ENTRY
> > > > > is defined in include/linux/xarray.h, where it's defined using
> > > > > xa_mk_internal(257). This function returns a void pointer, which
> > > > > is incompatible with the bitwise arithmetic it is performed on with.
> > >
> > > We don't really perform bitwise arithmetic on it, outside of:
> > >
> > > static int dax_is_zero_entry(void *entry)
> > > {
> > >         return xa_to_value(entry) & DAX_ZERO_PAGE;
> > > }
> >
> > We also have:
> >
> > if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
> >        unsigned long index = xas->xa_index;
> >        /* we are replacing a zero page with block mapping */
> >        if (dax_is_pmd_entry(entry))
> >               unmap_mapping_pages(mapping, index & ~PG_PMD_COLOUR,
> >                             PG_PMD_NR, false);
> >        else /* pte entry */
> >               unmap_mapping_pages(mapping, index, 1, false);
> > }
> >
> > and:
> >
> > *entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> >               DAX_PMD | DAX_ZERO_PAGE, false);
>
> Right.  We need to be able to distinguish whether an entry represents
> a PMD size.  So maybe we need XA_ZERO_PMD_ENTRY ... ?  Or we could use
> the recently-added xa_get_order().

I could add an additional dependent patch for this. Where would we
want XA_ZERO_PMD_ENTRY declared? Considering we're dependent
on DAX_PMD, I'd say in fs/dax.c, but if there's a better solution I'm missing...

> >
> > That'd probably be a better idea - so what should we do about the type
> > issue? Not typecasting it causes it not to compile.
>
> I don't think you'll need to do any casting once the bit operations go
> away ...

True, but what're we going to do about dax_is_zero_entry? We haven't
figured out what to do about that yet... a typecast back to void* of
xa_to_value locally could work, as it itself is just shifting an entry right
by 1 bit and then typecasting it to unsigned long. Thoughts?

Best regards,
Amy Parker
(she/her)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
