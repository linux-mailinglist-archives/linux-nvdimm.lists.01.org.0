Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9465272116
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 12:29:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1A7621426364E;
	Mon, 21 Sep 2020 03:29:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::841; helo=mail-qt1-x841.google.com; envelope-from=achirvasub@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9FB991426364A
	for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 03:29:37 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v54so11751159qtj.7
        for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 03:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ha7uOpPsgSYW9Dzxfe8r1fOa9581cD52tuAWOWOVJgQ=;
        b=E9djVZppygHioNIyuetXkKkSPhJ6xTYCkuEKqwRIbnCjVA2PbtbGAF39BFm2WhPnzN
         wvvdClq3m4rNKCOmjZMG646YbDmD+Lk9lrdx6eaFv5BKZTJY0u5JtlHxP/erCed+zSrR
         weGDSrv8VJInEJBLlffO9hjOnoVKBHS8T2rY5kTAxTfgtzVI0mnbEsrZ4crQ4CP3Y3Nh
         ZlR4MK+HfsyHwGvFMt8/t9ovpEm8udyXbeRkCaYYwDlKAktj2Gu2eBqZYT+MOS6HE4RL
         Dl/7Nbwt7rCZswZoWshNSoWD7UOX0biZBudZqTGU9/iAtCMVuvlZp9cU8n2/XsbECrfp
         t5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ha7uOpPsgSYW9Dzxfe8r1fOa9581cD52tuAWOWOVJgQ=;
        b=StkS71NmHS+2Zn6q44fjkgMqnC6FbZeEi7XnQzy86w/g8AK3OgraGK2lqY5PjtXTXd
         YTfOqlqo0/Tj0qL2E476kLH0YWdTb9L+f2+Hk1xmuU4WkHyfR/RdinECR8DvYoRHbaMo
         1h6wPOScmiWddRzft83p4E7112FldufHm0v5ygoJRKaDBpsI4KL5VA49q2pZ17DCom7O
         JTJa070DEHLccdAzBRas0JhwHb0obbGGrwd6f2pJM8M3+wNQPEknwjE/fCPu4YDOJcyF
         cUbUr8L/OZv0HgMTDcp2sBMRJA9qnPfMNx43uQXaXC/SXvbMtUBdWIW64MBTINBXI0cv
         4/Bg==
X-Gm-Message-State: AOAM531gcGN2DHWY68+1LZ555yxfi6xeoCatRIXy0DViTQTxi2N07o10
	ocghvFCZJk0iju5JUuGEk94=
X-Google-Smtp-Source: ABdhPJyS7MgtwJ+ssdbtRNH5SJYuKINkDAEqZtCxruKBvMWxT7F7TZjyZ5h7mMWWPol4qvQ4hk36xQ==
X-Received: by 2002:aed:3bdc:: with SMTP id s28mr46154317qte.124.1600684176350;
        Mon, 21 Sep 2020 03:29:36 -0700 (PDT)
Received: from arch-chirva.localdomain (pool-68-133-6-220.bflony.fios.verizon.net. [68.133.6.220])
        by smtp.gmail.com with ESMTPSA id d5sm10328576qtm.36.2020.09.21.03.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:29:35 -0700 (PDT)
Date: Mon, 21 Sep 2020 06:29:33 -0400
From: Stuart Little <achirvasub@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: PROBLEM: 5.9.0-rc6 fails =?utf-8?Q?to_?=
 =?utf-8?Q?compile_due_to_'redefinition_of_=E2=80=98dax=5Fsupported?=
 =?utf-8?B?4oCZJw==?=
Message-ID: <20200921102933.GF3027080@arch-chirva.localdomain>
References: <20200921010359.GO3027113@arch-chirva.localdomain>
 <CA+G9fYtCg2KjdB2oBUDJ2DKAzUxq3u8ZnMY9Et-RG9Pnrmuf9w@mail.gmail.com>
 <20200921073218.GA3142611@kroah.com>
 <20200921095035.GC5862@quack2.suse.cz>
 <CAMuHMdX871H5zqgb877Tw3N6PczpXTvnbCGRt++4udNpf8Oftg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdX871H5zqgb877Tw3N6PczpXTvnbCGRt++4udNpf8Oftg@mail.gmail.com>
Message-ID-Hash: NYJEM5YJXQXOISXNLYR3FBVTB67KDZXA
X-Message-ID-Hash: NYJEM5YJXQXOISXNLYR3FBVTB67KDZXA
X-MailFrom: achirvasub@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, Greg KH <gregkh@linuxfoundation.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, kernel list <linux-kernel@vger.kernel.org>, linux- stable <stable@vger.kernel.org>, Adrian Huang <ahuang12@lenovo.com>, Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com, Mikulas Patocka <mpatocka@redhat.com>, lkft-triage@lists.linaro.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NYJEM5YJXQXOISXNLYR3FBVTB67KDZXA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Confirmed: the patch fixed the build for me as well; thank you! 

On Mon, Sep 21, 2020 at 12:08:43PM +0200, Geert Uytterhoeven wrote:
> Hi Honza,
> 
> On Mon, Sep 21, 2020 at 11:54 AM Jan Kara <jack@suse.cz> wrote:
> > On Mon 21-09-20 09:32:18, Greg KH wrote:
> > > On Mon, Sep 21, 2020 at 11:34:17AM +0530, Naresh Kamboju wrote:
> > > > On Mon, 21 Sep 2020 at 06:34, Stuart Little <achirvasub@gmail.com> wrote:
> > > > > I am trying to compile for an x86_64 machine (Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz). The config file I am currently using is at
> > > > >
> > > > > https://termbin.com/xin7
> > > > >
> > > > > The build for 5.9.0-rc6 fails with the following errors:
> > > > >
> > > >
> > > > arm and mips allmodconfig build breaks due to this error.
> > >
> > > all my local builds are breaking now too with this :(
> > >
> > > Was there a proposed patch anywhere for this?
> >
> > Attached patch should fix the build breakage. I'm sorry for that.
> 
> Thanks, this fixes my m68k build issues:
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
