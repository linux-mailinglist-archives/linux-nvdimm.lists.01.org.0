Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5CF153C55
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Feb 2020 01:41:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DDAD510FC3175;
	Wed,  5 Feb 2020 16:44:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2F0E9100780A8
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 16:44:13 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 59so3839427otp.12
        for <linux-nvdimm@lists.01.org>; Wed, 05 Feb 2020 16:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wKAh9wuYiuc5W6sTWogwjdscmPsuVFsTNX4yHQsFIQ=;
        b=ldEkAgr+NcpWdcJk25F86nfxNKZtEH+jI9I9Rl0qVXtcuA9BPt77zEVCLoEN5Pbeol
         fHRD2E+B6ohnU2qzDz4q3NM7cYCa+RYlPygijcI8ic5lpPVVL7v5clOaMgcHwD0ho1hA
         LJsiC8J8IecPG3PeqXkAJ5bGXGV8bguP2795Q/z5zOF0HVknVy2gkJju2zWumZDaX6az
         jTuhKaBPZ8Tn02AWfKm+kWtHIHwwE9gCyzGxtNJIe2gS9eDWbwVU7wfYqkcZciaNpdWx
         7lq9mFWmRI385KNZTtMQ/0zZAzATJ/eJ49ZglHTOYr8wGch8GBFt7G0YjjN5tRH23+rV
         8ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wKAh9wuYiuc5W6sTWogwjdscmPsuVFsTNX4yHQsFIQ=;
        b=cTKTgVqsTyRyu4tPsOAGxy8V4OSX5RTD7VVmnkcC6fT3v8mzjF0pRap5/hY0rvl+23
         kle09YOdLjZaaUcDZltIHhjXKWHC+aO4dAbt0hSXoLF4EsIUEx2wjSi5MsqlblTfZft2
         nAVxMHYw6llKwJbBPTenBFFnQZLiC1joX+uFIZGBodFaRAnfNlaYTahVQZm6K2DX/Dzx
         nJUnM0hnO+RV1eHhKJYlv/JCNenM+Q/iMAelXlzeivFooaVGRLjS2Z4yuyts+lecsG8f
         PvulmoQFlyUYZjs2IaReGcZN1668xAb9TJp72i/B0JVPf9MlYDuupZdgtOHzVb4NSlqw
         dAxg==
X-Gm-Message-State: APjAAAXznaVsijrvSfEGWiVkQ0QFAkpccxp8jiiO8GuNxwH+2XphyVIJ
	I3aQdn/DLI75rJ4QfbluMM/tFg0Ne5iOM4+ab4YEUg==
X-Google-Smtp-Source: APXvYqyKZ7yhH4qQ9POMbzWU+GRmK/2Uv1thD8dauL6GIvGQJ18ctO/qrHQMqFzNWYo5JVYYzySS+tO87KVxX3Ho1aw=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr29141169otk.363.1580949655787;
 Wed, 05 Feb 2020 16:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20200203200029.4592-1-vgoyal@redhat.com> <20200203200029.4592-2-vgoyal@redhat.com>
 <20200205183050.GA26711@infradead.org> <20200205200259.GE14544@redhat.com>
In-Reply-To: <20200205200259.GE14544@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 5 Feb 2020 16:40:44 -0800
Message-ID: <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com>
Subject: Re: [PATCH 1/5] dax, pmem: Add a dax operation zero_page_range
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: Q7SWMPXXQ3VYJ736YEA4F22ZPXZLCDYW
X-Message-ID-Hash: Q7SWMPXXQ3VYJ736YEA4F22ZPXZLCDYW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q7SWMPXXQ3VYJ736YEA4F22ZPXZLCDYW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 5, 2020 at 12:03 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Feb 05, 2020 at 10:30:50AM -0800, Christoph Hellwig wrote:
> > > +   /*
> > > +    * There are no users as of now. Once users are there, fix dm code
> > > +    * to be able to split a long range across targets.
> > > +    */
> >
> > This comment confused me.  I think this wants to say something like:
> >
> >       /*
> >        * There are now callers that want to zero across a page boundary as of
> >        * now.  Once there are users this check can be removed after the
> >        * device mapper code has been updated to split ranges across targets.
> >        */
>
> Yes, that's what I wanted to say but I missed one line. Thanks. Will fix
> it.
>
> >
> > > +static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> > > +                               unsigned int offset, size_t len)
> > > +{
> > > +   int rc = 0;
> > > +   phys_addr_t phys_pos = pgoff * PAGE_SIZE + offset;
> >
> > Any reason not to pass a phys_addr_t in the calling convention for the
> > method and maybe also for dax_zero_page_range itself?
>
> I don't have any reason not to pass phys_addr_t. If that sounds better,
> will make changes.

The problem is device-mapper. That wants to use offset to route
through the map to the leaf device. If it weren't for the firmware
communication requirement you could do:

dax_direct_access(...)
generic_dax_zero_page_range(...)

...but as long as the firmware error clearing path is required I think
we need to do pass the pgoff through the interface and do the pgoff to
virt / phys translation inside the ops handler.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
