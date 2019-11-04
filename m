Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8888AEE7A0
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 Nov 2019 19:47:49 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 908F8100EA536;
	Mon,  4 Nov 2019 10:50:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 78218100EEBAC
	for <linux-nvdimm@lists.01.org>; Mon,  4 Nov 2019 10:50:33 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id d5so3277439otp.4
        for <linux-nvdimm@lists.01.org>; Mon, 04 Nov 2019 10:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAScZrMfcRjQQzWjos/ItVtsj2/Z80jqafi9Q8Gdat4=;
        b=jMQA21nktp7RKopIBS9wqFi6i1U/MgPY5om64JS4h+GGqMA1oI7IlIGbqbfdfrqdIA
         saCXi155JGBspLMG3er88AVUNsSmcsmIrx3Rav1KuF7BAVQDk1/UtICpwtaJeNyn9lpN
         zv7tUe2iDUpaiQ/lqfsdmsnlFBr2CFbMzBl+xVYpZUv4idw/1LM1jFM8OFJEqOKzAJHY
         LQ0Td6Y4IYI6qCqDnpk/+1znuoijhf3k3Umd2uq7wjPCm6RcGCgZXjVOYnmE7u/3h7WO
         bI1st2WpH0q9W/DyZwwx/RNqbWoMWwui8IsU8NhzYfZxOmVl9QynvfalKGl80BKpI4Vj
         x6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAScZrMfcRjQQzWjos/ItVtsj2/Z80jqafi9Q8Gdat4=;
        b=PJgXYKJdlA07ZcfsUH2E3V+iL13e2kAX+IiBxms6JcswGjEYvrXssKbktoYyrnMHT6
         P3ayRIWsJedVrMsme775uHmWRRpeuq+Vb4G2l/jLt1DGOcx9L904erfadB7LN7XRpAmz
         so+Rbgi6PQ5QQNSl5AVTlr2slI2okafvGmLAeKz5bj+2oOpqpkAbuWSliBNxMa9lGMir
         XnoUhXtwGdKQTYi6BGXwp0cq1AJChOhxanXiu6el6Wwr79r9qgWlt37SGuE7ZjpfQBNK
         xXyYnJZ+oW0mKWSI6wq+TLOBMmEM5PhWCebLy2TJKL3+piNPRhyrrJrwbfwn9JYkBl8A
         jYMQ==
X-Gm-Message-State: APjAAAVw7eXEy43qSmyKhBlBLDs5NnnOeys2ypW+tbQ18t3e9BD9D8HC
	6/CytAhgHMENJGnAAxTWA0XZVmaTUMAYFwSRrk7lLlIRHKg=
X-Google-Smtp-Source: APXvYqxMRWfUR8/8l4v/V1zDDPZJXYUW0sZlQfmt7b99qT10zFVdxsT5JqBY5W/7oDGnO9lc4SylLnvGzYiFdEHrW8M=
X-Received: by 2002:a05:6830:1e5a:: with SMTP id e26mr3118340otj.71.1572893263132;
 Mon, 04 Nov 2019 10:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20191003102915.28301-1-yamada.masahiro@socionext.com>
 <20191003102915.28301-4-yamada.masahiro@socionext.com> <x497e4kluxq.fsf@segfault.boston.devel.redhat.com>
 <CAK7LNASmpO6Dn2M1DtoCDs=RM+jwW7_tRhq7nqDU1YZWdRafuw@mail.gmail.com>
 <x494kznctuc.fsf@segfault.boston.devel.redhat.com> <CAK7LNAQnaBCkRCsRPjK9m6wLaDvTsgkiFgMEiObnfuncxOHZOg@mail.gmail.com>
 <CAPcyv4gFO=4EmObucuYyPNCS91y1H7d-M=0LebBK72YuD=ekNQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gFO=4EmObucuYyPNCS91y1H7d-M=0LebBK72YuD=ekNQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 4 Nov 2019 10:47:30 -0800
Message-ID: <CAPcyv4iWifdYsrrcs0TQ0Fd0Eoa5uXwe3CP-VzGCWAL6yKT3WA@mail.gmail.com>
Subject: Re: [PATCH 4/4] modpost: do not set ->preloaded for symbols from Module.symvers
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Message-ID-Hash: 6FX2UQFKPXGVF6BRS5Y642H3IX2ZDYPA
X-Message-ID-Hash: 6FX2UQFKPXGVF6BRS5Y642H3IX2ZDYPA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6FX2UQFKPXGVF6BRS5Y642H3IX2ZDYPA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Nov 3, 2019 at 10:43 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sun, Nov 3, 2019 at 7:12 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > On Sat, Nov 2, 2019 at 3:52 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> > >
> > > Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> > >
> > > > On Fri, Nov 1, 2019 at 1:51 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> > > >>
> > > >> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> > > >>
> > > >> > Now that there is no overwrap between symbols from ELF files and
> > > >> > ones from Module.symvers.
> > > >> >
> > > >> > So, the 'exported twice' warning should be reported irrespective
> > > >> > of where the symbol in question came from. Only the exceptional case
> > > >> > is when __crc_<sym> symbol appears before __ksymtab_<sym>. This
> > > >> > typically occurs for EXPORT_SYMBOL in .S files.
> > > >>
> > > >> Hi, Masahiro,
> > > >>
> > > >> After apply this patch, I get the following modpost warnings when doing:
> > > >>
> > > >> $ make M=tools/tesing/nvdimm
> > > >> ...
> > > >>   Building modules, stage 2.
> > > >>   MODPOST 12 modules
> > > >> WARNING: tools/testing/nvdimm/libnvdimm: 'nvdimm_bus_lock' exported
> > > >> twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > > >> WARNING: tools/testing/nvdimm/libnvdimm: 'nvdimm_bus_unlock'
> > > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > > >> WARNING: tools/testing/nvdimm/libnvdimm: 'is_nvdimm_bus_locked'
> > > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > > >> WARNING: tools/testing/nvdimm/libnvdimm: 'devm_nvdimm_memremap'
> > > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > > >> WARNING: tools/testing/nvdimm/libnvdimm: 'nd_fletcher64' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > > >> WARNING: tools/testing/nvdimm/libnvdimm: 'to_nd_desc' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > > >> WARNING: tools/testing/nvdimm/libnvdimm: 'to_nvdimm_bus_dev'
> > > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > > >> ...
> > > >>
> > > >> There are a lot of these warnings.  :)
> > > >
> > > > These warnings are correct since
> > > > drivers/nvdimm/Makefile and
> > > > tools/testing/nvdimm/Kbuild
> > > > compile the same files.
> > >
> > > Yeah, but that's by design.  Is there a way to silence these warnings?
> > >
> > > -Jeff
> > >
> >
> > "rm -f Module.symvers; make M=tools/testing/nvdimm" ?
> >
> > I'd like the _design_ fixed though.
>
> This design is deliberate. The goal is to re-build the typical nvdimm
> modules, but link them against mocked version of core kernel symbols.
> This enables the nvdimm unit tests which have been there for years and
> pre-date Kunit. That said, deleting Module.symvers seems a simple
> enough workaround.

This workaround triggers:

  WARNING: Symbol version dump ./Module.symvers
           is missing; modules will have no dependencies and modversions.

Which is a regression from the previous working state.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
