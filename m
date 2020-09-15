Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5771B26AE85
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 22:12:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4D7A3142AF3B9;
	Tue, 15 Sep 2020 13:12:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 11C93142AF3B7
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 13:12:05 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a12so4248225eds.13
        for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFOxjIBnPWa+tUxvtScNRMNkM/Rq7DWWcPcpqEr+OnU=;
        b=FwmvzEfj5WCP2nU3wZBoMHWDNOi4GN0JrczEj93mABch5op8aDrriCnV+P3NBJ95CN
         iLEzef5zUTzk3YZxfJnQIuTzAuiflCoVn106C4Bt4+g9W4v2JT+xoBSh1HuoCbeRmklC
         2X7gir4VkqIRsfLzcNI3g8OqGEYRsmm/TMTmZx2nDSgUnhzoJVu0tpKOfhk52THE1t/n
         43JNLnF7QdgSoA/Na1lkmRsnM+tiVKL4/ZV49eSVtVoSTgSwycJFIdT7FvLWi1ma389k
         uSN8wMg22mqAcoqp1Rp337KONjn5vdxQpAEC/VJn4s1zeT3VaKEqbD5/6Bd+9pAfobLM
         Y8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFOxjIBnPWa+tUxvtScNRMNkM/Rq7DWWcPcpqEr+OnU=;
        b=boOwrrvaHFnkW05qojEW2MfIxBCL9aKQudXVLd0j4+nQPPpdm48K8AswByR5vDDN44
         xtWx0gp4oa1kvuJNGpEIOV8pI5e6qdfr2ygFtVMoY8sGLavKa2dEGw9GmT+iJFmYG3VI
         BH+sAQibJO1pvtKXXhxEAsPii9n1HTihwYgPq8kUGW3PxEAIRSRH7BTrpK0r1y888k10
         B4Fyn9urJdKloZ3vqJko9HG4Eo++HzagJagcgxtkKxuhXSY8WsApdr1cjGsjhqVJKN8h
         ZdJXpjeAYjaYxSH6BGjXl7FfvHK8Dnjkgc//KO7ONRP1Oi4T5afxhTELB+FGlNNdhqBT
         QmgA==
X-Gm-Message-State: AOAM533iH62F6NdNLqWs1NaWH61ckH5lmPSViApnJkfoj5uNqbVb3PMV
	9BkNZWpVtotxrTJE31r7vpKylXCtboBedfdiiwOhtg==
X-Google-Smtp-Source: ABdhPJxsopp6jBRRY8lGI8VYrbENlHLOufKBifRJemW5k5Q/zj0z7CoEVAbr27SwbhTDBcO6b9mZQeoxBW5k8TU/eJQ=
X-Received: by 2002:aa7:c511:: with SMTP id o17mr24793563edq.300.1600200724195;
 Tue, 15 Sep 2020 13:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009141131220.30651@file01.intranet.prod.int.rdu2.redhat.com>
 <211sy17ij47lox90ncna7kwk-k7cl0b-ubtml5jg8ocd-r7lb68jgkncbq5ng3g-koqyd471rzfh-t231u5-sxwvexwht98i-b7in5pxxck0j-3b40lqlmuelf13q0uk-ye4ohhsbgodw-xuloz9wpp7tf.1600139009031@email.android.com>
 <20200915080106.GG4863@quack2.suse.cz> <CAPcyv4jHG7Lp0RrX+WmNHY5iSE5FjgrvYxd_d6TN5CKfc5LReQ@mail.gmail.com>
 <20200915195656.GA21635@redhat.com>
In-Reply-To: <20200915195656.GA21635@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 15 Sep 2020 13:11:53 -0700
Message-ID: <CAPcyv4g3=qVcXELKB7aR6HoPjOvVqAkWkQ3AJ8zr2hM8WDvdxw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E5=9B=9E=E5=A4=8D=EF=BC=9Aregression_caused_by_patch_6180bb446ab6?=
	=?UTF-8?Q?24b9ab8bf201ed251ca87f07b413=3F=3F_=28=22dax=3A_fix_detection_of_dax_s?=
	=?UTF-8?Q?upport_for_non=2Dpersistent_memory_block=3F=3F_devices=22=29?=
To: Mike Snitzer <snitzer@redhat.com>
Message-ID-Hash: NHPBRI3GCKGN46QD6KMKVXZY2IFUDBPH
X-Message-ID-Hash: NHPBRI3GCKGN46QD6KMKVXZY2IFUDBPH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, "colyli@suse.de" <colyli@suse.de>, Adrian Huang <ahuang12@lenovo.com>, Jan Kara <jack@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Mikulas Patocka <mpatocka@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NHPBRI3GCKGN46QD6KMKVXZY2IFUDBPH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 15, 2020 at 12:58 PM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Tue, Sep 15 2020 at  3:49pm -0400,
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Tue, Sep 15, 2020 at 1:01 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hi!
> > >
> > > On Tue 15-09-20 11:03:29, colyli@suse.de wrote:
> > > > Could you please to take a look? I am offline in the next two weeks.
> > >
> > > I just had a look into this. IMHO the justification in 6180bb446a "dax: fix
> > > detection of dax support for non-persistent memory block devices" is just
> > > bogus and people got confused by the previous condition
> > >
> > > if (!dax_dev && !bdev_dax_supported(bdev, blocksize))
> > >
> > > which was bogus as well. bdev_dax_supported() always returns false for bdev
> > > that doesn't have dax_dev (naturally so). So in the original condition
> > > there was no point in calling bdev_dax_supported() if we know dax_dev is
> > > NULL.
> > >
> > > Then this was changed to:
> > >
> > > if (!dax_dev || !bdev_dax_supported(bdev, blocksize))
> > >
> > > which looks more sensible at the first sight. But only at the first sight -
> > > if you look at wider context, __generic_fsdax_supported() is the bulk of
> > > code that decides whether a device supports DAX so calling
> > > bdev_dax_supported() from it indeed doesn't look as such a great idea. So
> > > IMO the condition should be just:
> > >
> > > if (!dax_dev)
> > >
> > > I'll send a fix for this.
> >
> > If you beat me to it, great, but you might be sleeping now. I agree
> > the original condition was bogus and looks to be a result of previous
> > non-thorough refactoring on my part. I think we can move that !dax_dev
> > into dax_supported(). I'll take a look.
>
> You trimmed the relevant portion of Jan's reply

Vishal already owned up to the process escape.

> but: can you also
> weigh-in one whether DM is using the wrong function to test for DAX?

That might be the original source of the bug because I would expect DM
to be using dax_supported() which should route to all the component
devices. I'll have a talk with whomever put that call to
generic_fsdax_supported() in DM:

git blame drivers/md/dm-table.c
...
7bf7eac8d6480 (Dan Williams         2019-05-16 13:26:29 -0700  865)
 return generic_fsdax_supported(dev->dax_dev, dev->bdev, blocksize,
...

oh...
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
