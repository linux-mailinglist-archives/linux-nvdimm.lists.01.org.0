Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DA7203B67
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Jun 2020 17:47:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B1B8610FC729F;
	Mon, 22 Jun 2020 08:47:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F152D10FC729F
	for <linux-nvdimm@lists.01.org>; Mon, 22 Jun 2020 08:47:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh7so7724824plb.11
        for <linux-nvdimm@lists.01.org>; Mon, 22 Jun 2020 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xc2mKgeExdGmIWqPOYOYWo2Adk+x5jGFKVodlRCWmyU=;
        b=cHFkvNQ3kDK5qybk3Qkc7QMvYMDxnAW7w/x/z161hVHqWAJJ/0Mxy1ocu8GLKCHwwf
         AL54f+6RUWVivK0X3t1NG3a0lB5qLdxCGOOb8sIzxjwbywiESpPsEbnWmuoFPAt7YEue
         D83hrHNbHTPE0LkgCvRcCxjf7nPTEAVgTgiV+4R/1r9w/GwBO4vv3wN4UJF0jaOi0Cyw
         wp86iZ1b5TX6/RDHzyacxQcruuDDIb/uVZJEbjmrFJu36VXuY3WhlUDx+iu+YZ2Cx65D
         Mlc/2aK6I8TySALnESH8Q5RhFEavkhTc74hokrDyv/aYVOFILUOnwoLreHDmR/XWOEnf
         E8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xc2mKgeExdGmIWqPOYOYWo2Adk+x5jGFKVodlRCWmyU=;
        b=ZPYgqadih1yLrJCMv1vrKyXDtYVUNsyjKzlHcvhUJmNxAO8qpktP7QtodPfwulMGiK
         OTfO4vy1Chn7l5yLVBvSvXtOJhezjIxR5OE/SSXfR0dZC/mRyQH21B+mND9Qoh5NgJES
         HTkW9HmwGIxhJwOfxpixDVkynUf6dUkGvtbICLEoR3ERnsSWxZmUCtpLLSSFtRBxhhlU
         I7OPb+U+rTAT6VxI3QR10mpQyyV5Pip6Qbp7rMyDMhEhf8TphSFW1YUAm401lv9s23yd
         k9/dXlx8rJSGUuGmyQow4/w7uFTyFWH91fGFwp25MG+/BOYidcRE0JB6DbmwP8tqzKJt
         OBXg==
X-Gm-Message-State: AOAM533rhkjPH4iEkSQfysB5M5VyUyZbADAgzXkkxgSR8u75Uvj6juTx
	Ha1xHR/JUNw9HFioGPkSYS8OfrB1Try5EVLDnyggVB/d
X-Google-Smtp-Source: ABdhPJz7jigT5zkg/O2S5/eaBk4kjsdhjro5aDd0v+PmSBHqwDtOO8xOJsJOC98Bakhoy/3YazfLdb/XwgY8UG1pf7Q=
X-Received: by 2002:a17:90a:b30d:: with SMTP id d13mr18713382pjr.181.1592840828258;
 Mon, 22 Jun 2020 08:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <1821880.vZFEW4x2Ui@kreacher>
 <CAHp75VePDyPevCAOntFpTajf5zd9ocwjeWRz80WmCNtiDicpLg@mail.gmail.com> <CAJZ5v0hu9_TA0KAe=9ZCSG4_KijSYb=qnt8MYe9QYwGbz=pmBg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hu9_TA0KAe=9ZCSG4_KijSYb=qnt8MYe9QYwGbz=pmBg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Jun 2020 18:46:55 +0300
Message-ID: <CAHp75VdQbH28ZyqkgPU_tq8WpHf152=4LpLCSLUji3MmywMiQw@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 2/4] ACPI: OSL: Add support for deferred unmapping
 of ACPI memory
To: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID-Hash: VPDSMJLULYAURKUGVB34Q7KCCSQUDHUD
X-Message-ID-Hash: VPDSMJLULYAURKUGVB34Q7KCCSQUDHUD
X-MailFrom: andy.shevchenko@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Kaneda <erik.kaneda@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Bob Moore <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VPDSMJLULYAURKUGVB34Q7KCCSQUDHUD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 22, 2020 at 6:28 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Jun 22, 2020 at 4:56 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jun 22, 2020 at 5:06 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

...

> > > +               return true;
> > > +       }
> > > +
> > > +       return false;
> >
> > A nit:
> >
> > Effectively it returns a value of defer.
> >
> >   return defer;
> >
> > >  }
>
> Do you mean that one line of code could be saved?  Yes, it could.

Yes. The question here would it make a cleaner way for the reader to
understand the returned value?

(For the rest, nevermind, choose whatever suits better in your opinion)

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
