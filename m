Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F97D1328C3
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jan 2020 15:23:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BFFB210097DE6;
	Tue,  7 Jan 2020 06:26:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8263810097F32
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 06:26:25 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id v140so17831186oie.0
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jan 2020 06:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r3VJe/dxyES65jnKtxYvETSNTHRiCAT6fnUUzfyEBsw=;
        b=IntyA5ICPEcRthqRYPCmMbZcDUdsPJKB41XMg3aNHyS8R6cuHoUT2CPYMdsXtRhIV/
         LE4AcTadPsbgzvkcanUbj/feghWprHupsWmFBAPc7sYF+VAsmKBx0fZyJQK8bF8M1Psc
         370rbvXm8e9yiT13+D5wg9K9mjUTdZdQ9TNUaJGocfOBIb2O4l3RX+l6g6lrQRLR542K
         uq6u075ZxqWd1dtGOT1YwXlKc+p25Z2v9ktm+IMQk7DdS4ccYqbvvQwR3hNsxwzI7ML7
         uZQ0x6Z/8r+EpXB5udA1qIlwP1zqd7XKjywpXRr4ylCkyezT+6v9gNmT4LaYtbSFwB4R
         bikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r3VJe/dxyES65jnKtxYvETSNTHRiCAT6fnUUzfyEBsw=;
        b=CgrBx5EnhaBtU0k979GHQoD+OgkfMwh3XCC7YrU5ArVa2g8V4OD2vTaVElvYFImAtD
         4wk5FcYERI/yvVyuj1NV+1Ft6/jncLuwMnovM45ppn4HW3/Rz2XweygZa6gs0txJbl8L
         SFD2CJMFe9SLZZQqip6P1upy2HF4rLH6+mJDkssEpRLv9RLpC+KCL2xdN0oY5jCoG6XI
         l+JR69Mt11JXJSyRssVR+ZqEbb2vF4erjV+mMyr5EKSyV0CvNxfjUJ4lCVv1wKgQ2bFY
         efxhM1MrIHp9nnOftYG86KxXnHVEh6EjS9Z2W+3zYiFthNzCDajm963BaCbU/3TDjBp6
         Bk8A==
X-Gm-Message-State: APjAAAW7Li35eyuwmuhVa6+rPXiu2yMC0xSVeSJ0KNx/Y136WCyTMfQD
	X77Fl7ICVWnSEJ1iVrF39igZtfp80PNEIgrQt5HIyw==
X-Google-Smtp-Source: APXvYqw+M12ZkKSJLTKleOTV1+IDlcbTBO8wNYejP3Rd62JSmbodZTAR2/rj6LbHMWOXB71wX7xzQYargDcyrZtNksM=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr7383807oij.149.1578406985047;
 Tue, 07 Jan 2020 06:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20190821175720.25901-1-vgoyal@redhat.com> <20190821175720.25901-2-vgoyal@redhat.com>
 <20190826115152.GA21051@infradead.org> <20190827163828.GA6859@redhat.com>
 <20190828065809.GA27426@infradead.org> <20190828175843.GB912@redhat.com>
 <20190828225322.GA7777@dread.disaster.area> <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com> <20200107125159.GA15745@infradead.org>
In-Reply-To: <20200107125159.GA15745@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Jan 2020 06:22:54 -0800
Message-ID: <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To: Christoph Hellwig <hch@infradead.org>
Message-ID-Hash: DABQU3FMBTZBWMSTKVDDX56D5I22YQEV
X-Message-ID-Hash: DABQU3FMBTZBWMSTKVDDX56D5I22YQEV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DABQU3FMBTZBWMSTKVDDX56D5I22YQEV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 7, 2020 at 4:52 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Dec 16, 2019 at 01:10:14PM -0500, Vivek Goyal wrote:
> > > Agree. In retrospect it was my laziness in the dax-device
> > > implementation to expect the block-device to be available.
> > >
> > > It looks like fs_dax_get_by_bdev() is an intercept point where a
> > > dax_device could be dynamically created to represent the subset range
> > > indicated by the block-device partition. That would open up more
> > > cleanup opportunities.
> >
> > Hi Dan,
> >
> > After a long time I got time to look at it again. Want to work on this
> > cleanup so that I can make progress with virtiofs DAX paches.
> >
> > I am not sure I understand the requirements fully. I see that right now
> > dax_device is created per device and all block partitions refer to it. If
> > we want to create one dax_device per partition, then it looks like this
> > will be structured more along the lines how block layer handles disk and
> > partitions. (One gendisk for disk and block_devices for partitions,
> > including partition 0). That probably means state belong to whole device
> > will be in common structure say dax_device_common, and per partition state
> > will be in dax_device and dax_device can carry a pointer to
> > dax_device_common.
> >
> > I am also not sure what does it mean to partition dax devices. How will
> > partitions be exported to user space.
>
> Dan, last time we talked you agreed that partitioned dax devices are
> rather pointless IIRC.  Should we just deprecate partitions on DAX
> devices and then remove them after a cycle or two?

That does seem a better plan than trying to force partition support
where it is not needed.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
