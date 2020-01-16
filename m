Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39C013F70F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jan 2020 20:09:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AE6851007B8C2;
	Thu, 16 Jan 2020 11:12:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 54B451007B8C1
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jan 2020 11:12:31 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id l136so19870368oig.1
        for <linux-nvdimm@lists.01.org>; Thu, 16 Jan 2020 11:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nsG4OiSI74VDUNjgH/EGPUC6QzQOOzMAIB017xQliU=;
        b=J79PjTiwui87Gtdaft875ciI4awf5xIZ2OlEVeWr6PK1j7HDrzdets/eOiB9gFbjxU
         N8a+VDYTOh/zAoGUZWE4w1cYgXKFMyIY5mxDDqaoQWFa6T9HxfH2fP9PLUP1uKEVP7xo
         SFvhifCBTkknEhBzZWrz1h+yDcMOzcy1CAiSWM1LLzIaCNgg2JOGV1Bsk6VwLRFyGzsl
         3oI19Df8dP3bwMD1fbOXbUBm44Ixpu94cRB2oRYOQ/+C0gKdgTy/EpALksKs5ue92Nlt
         bvnoL/8n6PK1nwQDhUpD7aFZSXwTnAcIEDKECZAVt2HboWTI3XccHsyHaJHIW0AO8xHe
         C2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nsG4OiSI74VDUNjgH/EGPUC6QzQOOzMAIB017xQliU=;
        b=YxGG2zVotUtl83+wtWVU2oafW1va2OhfE+DpxlEDLXoOxuxepMT8zaRsfADX6fXMGu
         fCOfo9/wKgoekRNG5h2/pGGzi5/DJiW9npsHvEzfeayvDbF79oxciKdp2uZ//IUOjALM
         0CLqkjgelXnQVZkv4Tdo3uQGyhx1jlfWI/cZNxJ1wH8jXQNo1jL3CPIEuzZpnJlBQIkb
         qbvPmhp4ChgSpBJoG5p6nc7P2JxiBDQYPAFfiq7hxFTBopFyvRVqcuDudr17fhEwnT/S
         iOoLpgiXtuab17evohCCh6ZgiSYNsVeHit74+6vsyeGegLYwJ+NVn+zxVPoMg0MV0sWH
         lTJg==
X-Gm-Message-State: APjAAAV5IXcnXqQopjcvLMJhhzktzhl+o9yzSHxa7/9h/MtTrEkvD+iy
	LviK4axGEg5mJV9VwP/VMtK9Koyqk2P9Q8Lu6QBvpw==
X-Google-Smtp-Source: APXvYqxWT+/8vZf0zWr1Yl/badv1TRvP/1k5BqWSq6/+HNdAxAD63JMtXrBctEvUY7L00GT1BthDGiNYcFZ4grHpWxY=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr427008oia.73.1579201751684;
 Thu, 16 Jan 2020 11:09:11 -0800 (PST)
MIME-Version: 1.0
References: <20200109112447.GG27035@quack2.suse.cz> <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com> <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com> <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
 <20200115195617.GA4133@redhat.com> <CAPcyv4iEoN9SnBveG7-Mhvd+wQApi1XKVnuYpyYxDybrFv_YYw@mail.gmail.com>
 <x49wo9smnqc.fsf@segfault.boston.devel.redhat.com> <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
 <20200116183900.GC25291@redhat.com>
In-Reply-To: <20200116183900.GC25291@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 16 Jan 2020 11:09:00 -0800
Message-ID: <CAPcyv4irezimk8m4hysrd0rst_f0Rr+iiNxeFesqbxQnWYA2Xw@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: JGKQZCSW7ZLEZ3AMEJFPBAQUGS7MBOPM
X-Message-ID-Hash: JGKQZCSW7ZLEZ3AMEJFPBAQUGS7MBOPM
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JGKQZCSW7ZLEZ3AMEJFPBAQUGS7MBOPM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 16, 2020 at 10:39 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Jan 16, 2020 at 10:09:46AM -0800, Dan Williams wrote:
> > On Wed, Jan 15, 2020 at 1:08 PM Jeff Moyer <jmoyer@redhat.com> wrote:
> > >
> > > Hi, Dan,
> > >
> > > Dan Williams <dan.j.williams@intel.com> writes:
> > >
> > > > I'm going to take a look at how hard it would be to develop a kpartx
> > > > fallback in udev. If that can live across the driver transition then
> > > > maybe this can be a non-event for end users that already have that
> > > > udev update deployed.
> > >
> > > I just wanted to remind you that label-less dimms still exist, and are
> > > still being shipped.  For those devices, the only way to subdivide the
> > > storage is via partitioning.
> >
> > True, but if kpartx + udev can make this transparent then I don't
> > think users lose any functionality. They just gain a device-mapper
> > dependency.
>
> So udev rules will trigger when a /dev/pmemX device shows up and run
> kpartx which in turn will create dm-linear devices and device nodes
> will show up in /dev/mapper/pmemXpY.
>
> IOW, /dev/pmemXpY device nodes will be gone. So if any of the scripts or
> systemd unit files are depenent on /dev/pmemXpY, these will still be
> broken out of the box and will have to be modified to use device nodes
> in /dev/mapper/ directory instead. Do I understand it right, Or I missed
> the idea completely.

No, I'd write the udev rule to create links from /dev/pmemXpY to the
/dev/mapper device, and that rule would be gated by a new pmem device
attribute to trigger when kpartx needs to run vs the kernel native
partitions.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
