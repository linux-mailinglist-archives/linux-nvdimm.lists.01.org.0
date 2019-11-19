Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7997C101295
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 Nov 2019 05:41:54 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B03F100DC42C;
	Mon, 18 Nov 2019 20:42:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 64EA4100DC42B
	for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 20:42:44 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id m193so17699562oig.0
        for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 20:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3MHq1VeKFp127FUICx04ubISK/Dg9APGUYHbc8GCeE=;
        b=05QWaL6gVTbgGCnZuO1yjSnjhWRi3w56l7hdlFSvvB8HiMDjBUO8yQ0RvJvlVo0qrc
         LDTYINUM5Yz7PgMGOy/bFHjxL6KJLqarZnNaOW355ivIXYFifzzcwVSAotpWlAb448cg
         cGiHNiToS3o3BeltrXgUR8vT8b73Tsz627J+9LPszqNyQyTUj33nxl3KHG3AHLooI3Gd
         yVTaO6OHo0EuDIIK5dpNL5RXxotYXkd8Hp4zLWlaTagZrtXbh5DsQV4EK9s/xTexTKeu
         pm4BC3RVxJ3UeExcy4v3Sr3p2qNqBENFM83bjAQnXRlcbCyQKBclbh76qG9xPSZT8Gty
         L9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3MHq1VeKFp127FUICx04ubISK/Dg9APGUYHbc8GCeE=;
        b=Ap7u5of1fIoyDCJO1sysXTKBATxUcaYjFTZ7TaiEYnhktYKnuCrVRsFn4kebMNPZOo
         E8611nEjC7IIUDiZyHxvYDM72KBdgXahQpVzpx669Uwot8gAFbFOLqehND7lWb4T0LSd
         spMou3mLvgclX+t+NlZ7tKbgiNK4FgSpxF9WYKZI6yQ6FpL3wxXfGiusDvCx6D8LkKaQ
         sJ/q/kw7S5hSMZ/JCI5zNdjp/NvcSDm/KeVigx/mIsc7oXYFI59/pyCbTDKBZHoDstUV
         lp+Aq06676lz6/258BtGJuhXCpLu1Oy9ZP19nCF3ilFGRrGYpTpWk5gJQneqRBwHHoMV
         Os4g==
X-Gm-Message-State: APjAAAUShDbhlHfX/hz5KtZUqHYeKmq6b7u/dArjEM4n9JodnQ7Xf7fA
	Glhuv80UPJo38a8oIczk56Z+5khXEeSGyd+nqQtGyQ==
X-Google-Smtp-Source: APXvYqwaHXiniUcSPs62JothmUuDkzT/zx/0SnTg3vefxzqbvzTfYsTVt7fj8ADLqJF7B6/l1DhnNw4N/Z8KxZnRhnU=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr2403758oib.105.1574138509410;
 Mon, 18 Nov 2019 20:41:49 -0800 (PST)
MIME-Version: 1.0
References: <20191025044721.16617-1-alastair@au1.ibm.com> <20191025044721.16617-9-alastair@au1.ibm.com>
 <8232c1a6-d52a-6c32-6178-de082174a92a@linux.ibm.com> <CAPcyv4g9b6PyREurH9NcQf4BO2YcRGJPBZDqGKy-Vz91mBKjew@mail.gmail.com>
 <02374c9a-39fb-5693-3d9c-aa7e7674a6c1@linux.ibm.com> <7fd5a4571062a06da8f09f18300794b48ead5dc1.camel@au1.ibm.com>
 <33b6f6b2-5ca1-7c08-01db-6aad73f9a0ec@linux.ibm.com>
In-Reply-To: <33b6f6b2-5ca1-7c08-01db-6aad73f9a0ec@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 18 Nov 2019 20:41:37 -0800
Message-ID: <CAPcyv4gOB3=U_0NU81qr1v8w4rd8i3AMHZuT1hs05sx287YgcA@mail.gmail.com>
Subject: Re: [PATCH 08/10] nvdimm: Add driver for OpenCAPI Storage Class Memory
To: Andrew Donnellan <ajd@linux.ibm.com>
Message-ID-Hash: ELDNX5ZRPOPFDS3DPT227QB2LB6DN555
X-Message-ID-Hash: ELDNX5ZRPOPFDS3DPT227QB2LB6DN555
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Alastair D'Silva <alastair@au1.ibm.com>, Frederic Barrat <fbarrat@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Wei Yang <richard.weiyang@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Qian Cai <cai@lca.pw>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Hari Bathini <hbathini@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Linux MM <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, li
 nuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ELDNX5ZRPOPFDS3DPT227QB2LB6DN555/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 18, 2019 at 7:29 PM Andrew Donnellan <ajd@linux.ibm.com> wrote:
>
> On 19/11/19 1:48 pm, Alastair D'Silva wrote:
> > On Tue, 2019-11-19 at 10:47 +1100, Andrew Donnellan wrote:
> >> On 15/11/19 3:35 am, Dan Williams wrote:
> >>>> Have you discussed with the directory owner if it's ok to split
> >>>> the
> >>>> driver over several files?
> >>>
> >>> My thought is to establish drivers/opencapi/ and move this and the
> >>> existing drivers/misc/ocxl/ bits there.
> >>
> >> Is there any other justification for this we can think of apart from
> >> not
> >> wanting to put this driver in the nvdimm directory? OpenCAPI drivers
> >> aren't really a category of driver unto themselves.
> >>
> >
> > There is a precedent for bus-based dirs, eg. drivers/(ide|w1|spi) all
> > contain drivers for both controllers & connected devices.
> >
> > Fred, how do you feel about moving the generic OpenCAPI driver out of
> > drivers/misc?
>
> Instinctively I don't like the idea of creating a whole opencapi
> directory, as OpenCAPI is a generic bus which is not tightly coupled to
> any particular application area, and drivers for other OpenCAPI devices
> are already spread throughout the tree (e.g. cxlflash in drivers/scsi).

I'm not suggesting all opencapi drivers go there, nor the entirety of
this driver, just common infrastructure. That said, it's hard to talk
about specifics given the current state of the patch set. I have not
even taken a deeper look past the changelog as this 3K lines-of-code
submission needs to be broken up into smaller pieces before we settle
on what pieces belong where.

Just looking at the diffstat, at a minimum it's not appropriate for
them to live in drivers/nvdimm/ directly, drivers/nvdimm/oxcl/ would
be an acceptable starting point.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
