Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780E42AAECC
	for <lists+linux-nvdimm@lfdr.de>; Mon,  9 Nov 2020 02:44:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EB6D4165124D9;
	Sun,  8 Nov 2020 17:44:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com; envelope-from=enbyamy@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 17C18165124D8
	for <linux-nvdimm@lists.01.org>; Sun,  8 Nov 2020 17:44:18 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 32so7476474otm.3
        for <linux-nvdimm@lists.01.org>; Sun, 08 Nov 2020 17:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zx0c9QjdSSJdv5cZelIQSpfHvvwpNT84JqxZReYCE4M=;
        b=mX3ChUCPcgEEO3MiehfN9/V0VDmBhN8v2Ss/9rR8R3DbEx2mKz1k1qh1wUp4tJ5KZd
         OGolOOhZaswj3nHQ6YpNm6MPOSZrbkW3OGiyPfXuTcXjmymal0YsHvJNT0SVWaXCgOVM
         Mzr++RGC2PC0DviZ+paYAiZzXymYRejVCznkc871IGNAFESrqseKEHLQu+95F6BjOioT
         iXHw1kDO8HUDxg8/2Ie2kw8sCKCLm4cEP3hESJHQ0F/3gGcQs8XFqdOD6fX/godHbj4n
         KvMydU7y0F8zFH9DB7oxfKJgkNY8xRhNo2kuGF7gJx6BQ/87RDo0qpZ4bokM5gqiRPcE
         MRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zx0c9QjdSSJdv5cZelIQSpfHvvwpNT84JqxZReYCE4M=;
        b=kbq3X1VBv1vM1FHH63sG/b25XuhrbGKxmanXN32M+Oe+x8mA6S8JS9Dz0osbNWz+WC
         v4oBVQMAsTT5a83dz0eWmxWR6uG8GlwiCorjgij9uaxj4TMTCbwW0iJoIOzZH+OZs120
         F3kXD3nf+mzB+zWZI3bXOLGKg6pq3FxP4oIPJx+POZebyzKbdI9jjFkW0h/G+Iw+gseA
         Jm+RLWHDvPreimUI8VhQx3QrFEUt+qA3I/RxZvoWhWjQwyNaRukTSXQN3TpFlFi/X8rz
         qUAThcILEAcr0xMB0Z/prkO1D2UgpYKuCTcAnFHvSr7VzFoodBnQNUPxFqfBRSCSRpda
         Re2g==
X-Gm-Message-State: AOAM532ZPTDC3aL9Ed3K64EpX9AZAbm5c/9+sNOoVzL1aACi996/Hjns
	34lbp26xkov2L1ax72zgyTvb2V7zSygXB53AYbQ=
X-Google-Smtp-Source: ABdhPJyKVhaUESLtlsP92cqSh9d/N0HYJVtvO4iu/WankSFdIidQyQrvCJ/s8TtjX+BrlTg37YJQoHBBKlNOHxaTTSk=
X-Received: by 2002:a9d:694e:: with SMTP id p14mr8056410oto.254.1604886257849;
 Sun, 08 Nov 2020 17:44:17 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT6O6uP12YMU1NaU-4CR-AaxRUhhWHY=zUtNXpHUfxrF=A@mail.gmail.com>
 <20201109013322.GA9685@magnolia>
In-Reply-To: <20201109013322.GA9685@magnolia>
From: Amy Parker <enbyamy@gmail.com>
Date: Sun, 8 Nov 2020 17:44:07 -0800
Message-ID: <CAE1WUT4RV3rd8YRQdh0dRqATRhP3DUNe4X=ZC8DopqBo74dJyA@mail.gmail.com>
Subject: Re: Best solution for shifting DAX_ZERO_PAGE to XA_ZERO_ENTRY
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Message-ID-Hash: XCDJ6IXLEA5F5YLDAXAPMKUHH3IWOQDR
X-Message-ID-Hash: XCDJ6IXLEA5F5YLDAXAPMKUHH3IWOQDR
X-MailFrom: enbyamy@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XCDJ6IXLEA5F5YLDAXAPMKUHH3IWOQDR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Nov 8, 2020 at 5:35 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Sun, Nov 08, 2020 at 05:15:55PM -0800, Amy Parker wrote:
> > I've been writing a patch to migrate the defined DAX_ZERO_PAGE
> > to XA_ZERO_ENTRY for representing holes in files.
>
> Why?  IIRC XA_ZERO_ENTRY ("no mapping in the address space") isn't the
> same as DAX_ZERO_PAGE ("the zero page is mapped into the address space
> because we took a read fault on a sparse file hole").
>
> --D

Matthew recommended that we use a single entry here instead of adding
extra unnecessary definitions:
> Right now, fs/dax.c uses a bit -- DAX_ZERO_PAGE --
> to represent a hole in the file.  It could equally well use a single entry,
> and we already have one defined, XA_ZERO_ENTRY.  I think a patch to
> convert it over would be a great idea.

In practice, it works perfectly fine - ran a qemu instance with a 20 GiB
NVDIMM, set up a standard namespace and ran XFS with DAX enabled
on it, and then passed over it with xfstests. Nothing changed versus
the current effect.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
