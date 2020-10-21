Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3AE2950AE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Oct 2020 18:24:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C751D15EFF70D;
	Wed, 21 Oct 2020 09:24:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 508A61576156A
	for <linux-nvdimm@lists.01.org>; Wed, 21 Oct 2020 09:24:19 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dt13so4065420ejb.12
        for <linux-nvdimm@lists.01.org>; Wed, 21 Oct 2020 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3gOwLOinKxfS8Q7pKCJNt4sF+c6ZgP4dy5YmMvKFVL4=;
        b=qAnN66PpKcpHn9YzLKihJgVOkQ9RiPSnoahXPav8UFjfvTvYdnOJugMx+Fd4ph9kHp
         Oro5Qq1x7si+5H+KJWJevoJW2PHn8HhJAqRLzFSXOSgl79BDmY2AGJXBq0iiIUil78+M
         QysAFxNAXgaq/Mfg5kA/0QDMB4VRDlGFuK1DSc+fErnKb3L0gfZ+4VEFg0V7CyQQ7Myx
         qeo8gGSTenyT+jW3xqn8pKqyQzwMS+8RqvOWuqowUB5/1uULNeDD9IyXJHsQOwlNL0h6
         4SoyROAEGF6wAKzdCiIMKhtkonzXdK+mP6RB+X4yyJd9uj4fp1tIq731Z14sHGErjeC2
         4AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3gOwLOinKxfS8Q7pKCJNt4sF+c6ZgP4dy5YmMvKFVL4=;
        b=QF37L/eLGGivS0caVkpSPhCvaCCj+KwtlXbR+cwB/Qx72Yv2Gt6QtBFzDM5EjOOUwa
         vi0tcXEENN3RMQEDWYRwg2JtPbITzo+YjIkvrFL/gnaXj3cDtWb2/T4LBEq4BkqfJYM8
         sL6iGAIOqVdj48mroFdRbSTE1bYKtIUaHqsxaI+hMx9nkU+jd13bD+n+Xz2aEMhpSOXx
         i+n+iTXSEj87wE/DGjcI90NxX12VmgQrtrMXBv5QOVxBDPTKksRaXN6v4e+3VsUnQ/uG
         lzgiLrxC79G3nM3CjD2//j7yBkXD/rNifvy4WIszpUw4CxLPiRA7peqCtmV7Lf4BpFNY
         EXDg==
X-Gm-Message-State: AOAM530Y6TveIDXMjDon6ibTAIbAbY+ncXyHdKaIZnX50FCzu8Sp5025
	wOQO+mFUf97TYZgYyo+njlolfhfoIh9BJr5MaUI76w==
X-Google-Smtp-Source: ABdhPJxdbZlz7qjHcsJyG3VwrTEzzzv1Xnm7a3x75REVedoliNewQfm4hBXe15u3vhqNhzOv2lGigBFvNc+AOMCjKO4=
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr4164002ejz.341.1603297457480;
 Wed, 21 Oct 2020 09:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org> <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com> <CAMM=eLf+2VYHB6vZVjn_=GA5uXJWKL-d6PuCpHEBPz=_Loe58A@mail.gmail.com>
In-Reply-To: <CAMM=eLf+2VYHB6vZVjn_=GA5uXJWKL-d6PuCpHEBPz=_Loe58A@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 21 Oct 2020 09:24:06 -0700
Message-ID: <CAPcyv4hj2iPmf4YNdJLZqHMh2B10hbkSnk_9BAAACbG_LFKfBQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To: Mike Snitzer <snitzer@redhat.com>
Message-ID-Hash: XDQ5U2HZOM5JA32S6WLXETEQN3ZK35S4
X-Message-ID-Hash: XDQ5U2HZOM5JA32S6WLXETEQN3ZK35S4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Nabeel Meeramohideen Mohamed (nmeeramohide)" <nmeeramohide@micron.com>, Christoph Hellwig <hch@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Steve Moyer (smoyer)" <smoyer@micron.com>, "Greg Becker (gbecker)" <gbecker@micron.com>, "Pierre Labat (plabat)" <plabat@micron.com>, "John Groves (jgroves)" <jgroves@micron.com>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XDQ5U2HZOM5JA32S6WLXETEQN3ZK35S4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 21, 2020 at 7:24 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> Hey Dan,
>
> On Fri, Oct 16, 2020 at 6:38 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 2:59 PM Nabeel Meeramohideen Mohamed
> > (nmeeramohide) <nmeeramohide@micron.com> wrote:
> >
> > > (5) Representing an mpool as a /dev/mpool/<mpool-name> device file provides a
> > > convenient mechanism for controlling access to and managing the multiple storage
> > > volumes, and in the future pmem devices, that may comprise an logical mpool.
> >
> > Christoph and I have talked about replacing the pmem driver's
> > dependence on device-mapper for pooling.
>
> Was this discussion done publicly or private?  If public please share
> a pointer to the thread.
>
> I'd really like to understand the problem statement that is leading to
> pursuing a pmem native alternative to existing DM.
>

IIRC it was during the hallway track at a conference. Some of the
concern is the flexibility to carve physical address space but not
attach a block-device in front of it, and allow pmem/dax-capable
filesystems to mount on something other than a block-device.

DM does fit the bill for block-device concatenation and striping, but
there's some pressure to have a level of provisioning beneath that.

The device-dax facility has already started to grow some physical
address space partitioning capabilities this cycle, see 60e93dc097f7
device-dax: add dis-contiguous resource support, and the question
becomes when / if that support needs to extend across regions is DM
the right tool for that?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
