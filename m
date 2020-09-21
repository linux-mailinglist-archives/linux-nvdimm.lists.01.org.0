Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 114F2271FB5
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 12:09:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5D981143D24E0;
	Mon, 21 Sep 2020 03:08:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.65; helo=mail-ot1-f65.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3518F144623B5
	for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 03:08:56 -0700 (PDT)
Received: by mail-ot1-f65.google.com with SMTP id 60so11821374otw.3
        for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 03:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2U9zgdNA+W5z39mxrnSClctTCx07o8njSeYRiDkxUQ=;
        b=LTQKMrBLm6tZRyyVtsQNEMgI3rT/S1RvA4eKzD/FRYnByJhFrDIReit4LaOj439STF
         kHbRyeD/rMARRObs/Neb+vovJC4eZusMDjyzH3rhCWE5wwakHkVG07JVe5utWHvDLkrI
         gvL5sCTimvRk1nkZbhBBFeNlWfz2zRWq1EkRZiOb0ELoUtLuuHoofWoVVMV8jqwkCdt3
         hXPSluH5RtRONjxAIZ86QrtlBazYhpBoxcuad0fXOiSBJIE9gURu8W0Ozol0rtoRm31u
         D7ImPF7CnQd1FNdjz8q+7odOFS5yKlme4/C3Nxg6QzIHx+sZcNV26xaQP+OW9YfI4NtM
         vGeA==
X-Gm-Message-State: AOAM532RfI+ks0sjDXmwk1XkCa7ZJx8BUGwaItJTxqr1inqszW2RvSHm
	KxuKrA+tyfW0SnlYvuussIxROTIL7a+NrA9zRjI=
X-Google-Smtp-Source: ABdhPJx0z6nJuof9O9shP/JtBfaIqTwWgK7RVeG7KPf2KNQd6Y85WoyMiJQvHvcs+fN+TsY5UDMK5YpXqSLo0OHyosg=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr31653937otb.250.1600682934646;
 Mon, 21 Sep 2020 03:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200921010359.GO3027113@arch-chirva.localdomain>
 <CA+G9fYtCg2KjdB2oBUDJ2DKAzUxq3u8ZnMY9Et-RG9Pnrmuf9w@mail.gmail.com>
 <20200921073218.GA3142611@kroah.com> <20200921095035.GC5862@quack2.suse.cz>
In-Reply-To: <20200921095035.GC5862@quack2.suse.cz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Sep 2020 12:08:43 +0200
Message-ID: <CAMuHMdX871H5zqgb877Tw3N6PczpXTvnbCGRt++4udNpf8Oftg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFBST0JMRU06IDUuOS4wLXJjNiBmYWlscyB0byBjb21waWxlIGR1ZSB0byAncmVkZQ==?=
	=?UTF-8?B?ZmluaXRpb24gb2Yg4oCYZGF4X3N1cHBvcnRlZOKAmSc=?=
To: Jan Kara <jack@suse.cz>
Message-ID-Hash: 3QHZFT5WQCYKRSEFLPBQS4DMEMB4GYR7
X-Message-ID-Hash: 3QHZFT5WQCYKRSEFLPBQS4DMEMB4GYR7
X-MailFrom: geert.uytterhoeven@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Greg KH <gregkh@linuxfoundation.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, Stuart Little <achirvasub@gmail.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, kernel list <linux-kernel@vger.kernel.org>, linux- stable <stable@vger.kernel.org>, Adrian Huang <ahuang12@lenovo.com>, Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com, Mikulas Patocka <mpatocka@redhat.com>, lkft-triage@lists.linaro.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3QHZFT5WQCYKRSEFLPBQS4DMEMB4GYR7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Honza,

On Mon, Sep 21, 2020 at 11:54 AM Jan Kara <jack@suse.cz> wrote:
> On Mon 21-09-20 09:32:18, Greg KH wrote:
> > On Mon, Sep 21, 2020 at 11:34:17AM +0530, Naresh Kamboju wrote:
> > > On Mon, 21 Sep 2020 at 06:34, Stuart Little <achirvasub@gmail.com> wrote:
> > > > I am trying to compile for an x86_64 machine (Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz). The config file I am currently using is at
> > > >
> > > > https://termbin.com/xin7
> > > >
> > > > The build for 5.9.0-rc6 fails with the following errors:
> > > >
> > >
> > > arm and mips allmodconfig build breaks due to this error.
> >
> > all my local builds are breaking now too with this :(
> >
> > Was there a proposed patch anywhere for this?
>
> Attached patch should fix the build breakage. I'm sorry for that.

Thanks, this fixes my m68k build issues:
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
