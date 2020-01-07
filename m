Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2A7132FD0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jan 2020 20:46:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 52BDE10097DBE;
	Tue,  7 Jan 2020 11:50:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 734E710097DBD
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 11:50:08 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id p67so478483oib.13
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jan 2020 11:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMeNYRjmE3xADDHseE8To74pLJCIPrrI6iJEnl8/MJE=;
        b=aT9oM/LCSkoU4DdjNflW1gLMp0wxVh5dnFJb8sf5sPgjVDLhWEqnZiSRpAeeGcHRg3
         GRzzra9Yib97QPwwnxC3RKcRXN0Osb1l24DjUOUZJ42RCQqm3m5RkDe9UzWztOZTtr3w
         XJLFOTDwV3oVI5CjkHlup8nJ4bFUjCoH08/1ROlE0ivkkm69CMkthrbLYK4pynoIEaCB
         4b2UfkD1BJyszzW0TA68YU1tJwy/mY/yyObGN3t3ngSw0QpZlvhObmzfxajy07Khz5ST
         sg9FBbkL6YcKUuz5INzL2GxKWtGK7zsaP+IAywWCUcl1epohdi+uxvi6VWUJeh0J4I0J
         5dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMeNYRjmE3xADDHseE8To74pLJCIPrrI6iJEnl8/MJE=;
        b=gOuW79ACvgLDJJVxCuQOAg+IkNGUzyrVN+dfHN16gvYw1IHlF807i7HAfm8gmP/BOD
         Vl/4Lgg86M56rNh6ySAe11J/hSqgo8YayFj3Yy0FUgkIdEyPEmYShRVUi2rgHR60JT0A
         bW8Bn7Ak7n9Ma7wf0nSAn2f/8BdhGlQ9bR8psmBDT7lRzk0m9TUbhQ4PVeRUon8N5Ra1
         EYup5aijK40dXGbHfzkCS1Adq0EFuxwGZ28Ht5w5zi4qjblfqgbnJAC6+HJoiKbFRqgM
         nAh8h/xn03FgROAfpR2hxG67WqW0oZfQ/d/craSr/PezZAYR4OJseEvInnNDDu0ASAst
         UGFA==
X-Gm-Message-State: APjAAAUSNltnYS0P1gbksf14lBTMGhvnU8QzqOM/qlYliaUM0QRalotW
	arcINa88+QsGW3vgI9Cb7JvCPxPNCueqydPP1yIFdgmF
X-Google-Smtp-Source: APXvYqySAx4Aj+DuXpJ61i5oIH9smYDCpRBqp5amCWZu7+ti/Z0kAtAfr2EMJlp3TgztEotsg427i+HmWJznPk4npVI=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr33945oia.73.1578426408315;
 Tue, 07 Jan 2020 11:46:48 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com> <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia> <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com> <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200107190258.GB472665@magnolia>
In-Reply-To: <20200107190258.GB472665@magnolia>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Jan 2020 11:46:37 -0800
Message-ID: <CAPcyv4ia9r0rdbb7t0JvEnGW6nnHdAWUHbaMrY5FKBY+4Fum6Q@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Message-ID-Hash: ETOQRGIBZWCV3AU2HZ65QCRL4PUJ7H6D
X-Message-ID-Hash: ETOQRGIBZWCV3AU2HZ65QCRL4PUJ7H6D
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ETOQRGIBZWCV3AU2HZ65QCRL4PUJ7H6D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 7, 2020 at 11:03 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
[..]
> > That can already happen today. If you do not properly align the
> > partition then dax operations will be disabled.
>
> Er... is this conversation getting confused?  I was talking about
> kpartx's /dev/mapper/pmem0p1 being a straight replacement for the kernel
> creating /dev/pmem0p1.  I thnk Vivek was complaining about the
> inconsistent behavior between the two, even if the partition is aligned
> properly.
>
> I'm not sure how alignment leaked in here?

Oh, whoops, I was jumping to the mismatch between host device and
partition and whether we had precedent to fail to support dax on the
partition when the base block device does support it.

But yes, the mismatch between kpartx and native partitions is weird.
That said kpartx is there to add partition support where the kernel
for whatever reason fails to, or chooses not to, and dax is looking
like such a place.

> > This proposal just
> > extends that existing failure domain to make all partitions fail to
> > support dax.
>
> Oh, wait.  You're proposing that "partitions of pmem devices don't
> support DAX", not "the kernel will not create partitions for pmem
> devices".
>
> Yeah, that would be inconsistent and weird.

More weird than the current constraints?

> I'd say deprecate the
> kernel automounting partitions, but I guess it already does that, and

Ok, now I don't know why automounting is leaking into this discussion?

> removing it would break /something/.

Yes, the breakage risk is anyone that was using ext4 mount failure as
a dax capability detector.

> I guess you could put
> "/dev/pmemXpY" on the deprecation schedule.

...but why deprecate /dev/pmemXpY partitions altogether? If someone
doesn't care about dax then they can do all the legacy block things.
If they do care about dax then work with whole device namespaces.

The proposal is to detect dax on partitions and warn people to move to
kpartx. Let the core fs/dax implementation continue to shed block
dependencies.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
