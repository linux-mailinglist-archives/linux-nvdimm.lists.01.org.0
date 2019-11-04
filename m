Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 335E4ED922
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 Nov 2019 07:43:48 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 112E9100EA525;
	Sun,  3 Nov 2019 22:46:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 866DE100EA523
	for <linux-nvdimm@lists.01.org>; Sun,  3 Nov 2019 22:46:36 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id v138so13159233oif.6
        for <linux-nvdimm@lists.01.org>; Sun, 03 Nov 2019 22:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVi5iAn9z9FIX4+R36z5iyM84YAlie4p4vOr8JLkA9Q=;
        b=HAFK9ZBNpKvG2W2+y1NYoDvTHPz0Ih82Jqp011X6KSmbJ1OgFdZTIc4d0/6vIbvxKL
         gs/6jFk8EYz5eDiKziCqdb7/8/dAzil45O7dvO+dDXp1z5/y2wIH43iLURPE4+F9d1Ka
         mztxNJCXNFIRQQLB4EtiifXijLtOJUcrUf3I7WhhP2AW4eD5w9B3bk0JQ3llROT4jdoA
         K3QGqKi6NCewRfVYH9qcFMvofHFLFTzqhx4DdXaDWK7X6EFm6mycQxkpgjQor9zzncoS
         Sb1Brgwghyca3G1DkJhJE3T9uHRx0/LMuWdW1Al8/QtDZSxZrlahzzw4tkVhcjvNCEfH
         ObHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVi5iAn9z9FIX4+R36z5iyM84YAlie4p4vOr8JLkA9Q=;
        b=UIPceHPAFjG+5cG3Fm16Lhp4iCdsCKdMeFBpW6AOuFRuqMDxcmvnPtwhPCScvwLL0P
         kBjLBee/3Qe7v2f0PzP3tx52GrTiK6SFRzyPUwUgKUjEzvO617e4M6IefreBxM6Mnh/B
         ACr/AVk/mLUd0v3uNYr3WIMssExrOYddstMrpzZ4uLoPQfgI8N9yuV33M4gf1kGlPEiF
         AAMvfkWKZ4MoTo9igBatyRThwQ7XYzCng902R3KZc23pKEic3CI9qKHmdMqSPmmW2Ndi
         6TXf5RXvD8UGFx0RV7lXAiXB81I0dofhEut3SfwOzIElCPPDU5CouzFfKNXTCw5Dm0Q+
         QlMg==
X-Gm-Message-State: APjAAAV3J8+Dk+LmsOHo6qqvZJz9p14ALHrM5q5qXdFDzbUNDk1LgJMS
	/mJD14mEwI78b+bT4co7OVA9u9wi+i58DxJxmra+KQ==
X-Google-Smtp-Source: APXvYqzYYiSRCLzgJDin99LR5fIfz6VmH9pke67vQaykCEY2cIpBFhjcU9jQxFNcNlHYIOGijfZuC9W/totY10rVFTU=
X-Received: by 2002:aca:ead7:: with SMTP id i206mr2880755oih.0.1572849822071;
 Sun, 03 Nov 2019 22:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20191003102915.28301-1-yamada.masahiro@socionext.com>
 <20191003102915.28301-4-yamada.masahiro@socionext.com> <x497e4kluxq.fsf@segfault.boston.devel.redhat.com>
 <CAK7LNASmpO6Dn2M1DtoCDs=RM+jwW7_tRhq7nqDU1YZWdRafuw@mail.gmail.com>
 <x494kznctuc.fsf@segfault.boston.devel.redhat.com> <CAK7LNAQnaBCkRCsRPjK9m6wLaDvTsgkiFgMEiObnfuncxOHZOg@mail.gmail.com>
In-Reply-To: <CAK7LNAQnaBCkRCsRPjK9m6wLaDvTsgkiFgMEiObnfuncxOHZOg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 3 Nov 2019 22:43:31 -0800
Message-ID: <CAPcyv4gFO=4EmObucuYyPNCS91y1H7d-M=0LebBK72YuD=ekNQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] modpost: do not set ->preloaded for symbols from Module.symvers
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Message-ID-Hash: MLU3HPU2XP7D4CISWPEUXJVF6BTHCIUF
X-Message-ID-Hash: MLU3HPU2XP7D4CISWPEUXJVF6BTHCIUF
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MLU3HPU2XP7D4CISWPEUXJVF6BTHCIUF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Nov 3, 2019 at 7:12 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Sat, Nov 2, 2019 at 3:52 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >
> > Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> >
> > > On Fri, Nov 1, 2019 at 1:51 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> > >>
> > >> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> > >>
> > >> > Now that there is no overwrap between symbols from ELF files and
> > >> > ones from Module.symvers.
> > >> >
> > >> > So, the 'exported twice' warning should be reported irrespective
> > >> > of where the symbol in question came from. Only the exceptional case
> > >> > is when __crc_<sym> symbol appears before __ksymtab_<sym>. This
> > >> > typically occurs for EXPORT_SYMBOL in .S files.
> > >>
> > >> Hi, Masahiro,
> > >>
> > >> After apply this patch, I get the following modpost warnings when doing:
> > >>
> > >> $ make M=tools/tesing/nvdimm
> > >> ...
> > >>   Building modules, stage 2.
> > >>   MODPOST 12 modules
> > >> WARNING: tools/testing/nvdimm/libnvdimm: 'nvdimm_bus_lock' exported
> > >> twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > >> WARNING: tools/testing/nvdimm/libnvdimm: 'nvdimm_bus_unlock'
> > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > >> WARNING: tools/testing/nvdimm/libnvdimm: 'is_nvdimm_bus_locked'
> > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > >> WARNING: tools/testing/nvdimm/libnvdimm: 'devm_nvdimm_memremap'
> > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > >> WARNING: tools/testing/nvdimm/libnvdimm: 'nd_fletcher64' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > >> WARNING: tools/testing/nvdimm/libnvdimm: 'to_nd_desc' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > >> WARNING: tools/testing/nvdimm/libnvdimm: 'to_nvdimm_bus_dev'
> > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > >> ...
> > >>
> > >> There are a lot of these warnings.  :)
> > >
> > > These warnings are correct since
> > > drivers/nvdimm/Makefile and
> > > tools/testing/nvdimm/Kbuild
> > > compile the same files.
> >
> > Yeah, but that's by design.  Is there a way to silence these warnings?
> >
> > -Jeff
> >
>
> "rm -f Module.symvers; make M=tools/testing/nvdimm" ?
>
> I'd like the _design_ fixed though.

This design is deliberate. The goal is to re-build the typical nvdimm
modules, but link them against mocked version of core kernel symbols.
This enables the nvdimm unit tests which have been there for years and
pre-date Kunit. That said, deleting Module.symvers seems a simple
enough workaround.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
