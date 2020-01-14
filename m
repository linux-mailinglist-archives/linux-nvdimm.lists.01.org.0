Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B45013B538
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jan 2020 23:23:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5551C10097DBB;
	Tue, 14 Jan 2020 14:26:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A825310097DB8
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jan 2020 14:26:35 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id m2so9424158otq.3
        for <linux-nvdimm@lists.01.org>; Tue, 14 Jan 2020 14:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMbN1Woq544EfOz/nfTttJ7Xl0GliaVxV4hQJh4QosE=;
        b=C57IauRMqinuAWTYCo5F6FpoAxD6l1tnXRkUV9Yp8jG0u5XVdw7Tq1FtkDft9QMAsM
         e91sVxxfbB7VV/SdDxU7ia89cdtc/wFaKJPoZdZWBISOQXj9aEK3Qoa3KEWF0UbNmCI4
         ToId79vINoXMj3VmXCSiXoWS5YnHK8S68mVrpm8kYb6guvcXGETqDN/05svyPuhGTkJD
         J1XEnETkz4oaJd5S+3iL3sDuEyAQdO5Z1R9xyCCj5YRS8hCiacAXzo/h/BhZmANiro1i
         krRoo5aKVW4r9YNdl+5pWKl9DAmz/y0agtKvABl07X/vusocmjng6K5HDyPO6/fpt4wR
         ysWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMbN1Woq544EfOz/nfTttJ7Xl0GliaVxV4hQJh4QosE=;
        b=NBs+cBle6uqbTOXedn596uEW8XELGM6f+WpNQwcRA13UYY5ZXLQnBYN9wQ3vn/yXhd
         dyzZg2PinQSARwCdb78MMen/G6S7QShCzbIf4deueFR9djXTyQqhPEM/iaw44GpttIXH
         u9OEi+i6lTq9sq521Kempz5MrNkwm6uCr00fiQx1RbhPqwcfsfgczmjgjWCBih/ZmN0H
         8b83Hs/O4jo7x6CAUE5OQ50IRWFedI7CZGif9He+is4bfOBHOLkQ5cTmevF9m0Kwjfu9
         Z30TXagxSgTHg0BAWfyiP9Q0Ky0A62DytWVsdHLVKT/iS8xfSc4O5J4LQeGwDqxbLS2j
         fIUw==
X-Gm-Message-State: APjAAAXlcGm1zN5FpyonfcIEhIvbaj6svsRMIHda5cp6it8yhBRHM6Ol
	KR3wplArS+HWjLAe/1hIZIrbZXZzujgHHHT8wBcFng==
X-Google-Smtp-Source: APXvYqzOj0y10lowarBS0JJLnrvBFRxnVw01yD2hv4VnkEfe2ZTMAVrMVqvG1TtiLJXv8MX8dl19DhHZVCzvPr5O3Lg=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr471449otk.363.1579040595440;
 Tue, 14 Jan 2020 14:23:15 -0800 (PST)
MIME-Version: 1.0
References: <20200107170731.GA472641@magnolia> <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com> <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200109112447.GG27035@quack2.suse.cz> <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com> <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com>
In-Reply-To: <20200114212805.GB3145@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 14 Jan 2020 14:23:04 -0800
Message-ID: <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: SX65E6PYDO3LNP6KJHEKWPULBCQNRAV4
X-Message-ID-Hash: SX65E6PYDO3LNP6KJHEKWPULBCQNRAV4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SX65E6PYDO3LNP6KJHEKWPULBCQNRAV4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 14, 2020 at 1:28 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Jan 14, 2020 at 12:39:00PM -0800, Dan Williams wrote:
> > On Tue, Jan 14, 2020 at 12:31 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Thu, Jan 09, 2020 at 12:03:01PM -0800, Dan Williams wrote:
> > > > On Thu, Jan 9, 2020 at 3:27 AM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Tue 07-01-20 10:49:55, Dan Williams wrote:
> > > > > > On Tue, Jan 7, 2020 at 10:33 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > > > W.r.t partitioning, bdev_dax_pgoff() seems to be the pain point where
> > > > > > > dax code refers back to block device to figure out partition offset in
> > > > > > > dax device. If we create a dax object corresponding to "struct block_device"
> > > > > > > and store sector offset in that, then we could pass that object to dax
> > > > > > > code and not worry about referring back to bdev. I have written some
> > > > > > > proof of concept code and called that object "dax_handle". I can post
> > > > > > > that code if there is interest.
> > > > > >
> > > > > > I don't think it's worth it in the end especially considering
> > > > > > filesystems are looking to operate on /dev/dax devices directly and
> > > > > > remove block entanglements entirely.
> > > > > >
> > > > > > > IMHO, it feels useful to be able to partition and use a dax capable
> > > > > > > block device in same way as non-dax block device. It will be really
> > > > > > > odd to think that if filesystem is on /dev/pmem0p1, then dax can't
> > > > > > > be enabled but if filesystem is on /dev/mapper/pmem0p1, then dax
> > > > > > > will work.
> > > > > >
> > > > > > That can already happen today. If you do not properly align the
> > > > > > partition then dax operations will be disabled. This proposal just
> > > > > > extends that existing failure domain to make all partitions fail to
> > > > > > support dax.
> > > > >
> > > > > Well, I have some sympathy with the sysadmin that has /dev/pmem0 device,
> > > > > decides to create partitions on it for whatever (possibly misguided)
> > > > > reason and then ponders why the hell DAX is not working? And PAGE_SIZE
> > > > > partition alignment is so obvious and widespread that I don't count it as a
> > > > > realistic error case sysadmins would be pondering about currently.
> > > > >
> > > > > So I'd find two options reasonably consistent:
> > > > > 1) Keep status quo where partitions are created and support DAX.
> > > > > 2) Stop partition creation altogether, if anyones wants to split pmem
> > > > > device further, he can use dm-linear for that (i.e., kpartx).
> > > > >
> > > > > But I'm not sure if the ship hasn't already sailed for option 2) to be
> > > > > feasible without angry users and Linus reverting the change.
> > > >
> > > > Christoph? I feel myself leaning more and more to the "keep pmem
> > > > partitions" camp.
> > > >
> > > > I don't see "drop partition support" effort ending well given the long
> > > > standing "ext4 fails to mount when dax is not available" precedent.
> > > >
> > > > I think the next least bad option is to have a dax_get_by_host()
> > > > variant that passes an offset and length pair rather than requiring a
> > > > later bdev_dax_pgoff() to recall the offset. This also prevents
> > > > needing to add another dax-device object representation.
> > >
> > > I am wondering what's the conclusion on this. I want to this to make
> > > progress in some direction so that I can make progress on virtiofs DAX
> > > support.
> >
> > I think we should at least try to delete the partition support and see
> > if anyone screams. Have a module option to revert the behavior so
> > people are not stuck waiting for the revert to land, but if it stays
> > quiet then we're in a better place with that support pushed out of the
> > dax core.
>
> Hi Dan,
>
> So basically keep partition support code just that disable it by default
> and it is enabled by some knob say kernel command line option/module
> option.

Yes.

> At what point of time will we remove that code completely. I mean what
> if people scream after two kernel releases, after we have removed the
> code.

I'd follow the typical timelines of Documentation/ABI/obsolete which
is a year or more.

>
> Also, from distribution's perspective, we might not hear from our
> customers for a very long time (till we backport that code in to
> existing releases or release this new code in next major release). From
> that view point I will not like to break existing user visible behavior.
>
> How bad it is to keep partition support around. To me it feels reasonaly
> simple where we just have to store offset into dax device into another
> dax object:

If we end up keeping partition support, we're not adding another object.

> and pass that object around (instead of dax_device). If that's
> the case, I am not sure why to even venture into a direction where some
> user's setup might be broken.

It was a mistake to support them. If that mistake can be undone
without breaking existing deployments the code base is better off
without the concept.

> Also from an application perspective, /dev/pmem is a block device, so it
> should behave like a block device, (including kernel partition table support).
> From that view, dax looks like just an additional feature of that device
> which can be enabled by passing option "-o dax".

dax via block devices was a crutch that we leaned on too heavily, and
the implementation has slowly been moving away from it ever since.

> IOW, can we reconsider the idea of not supporting kernel partition tables
> for dax capable block devices. I can only see downsides of removing kernel
> partition table support and only upside seems to be little cleanup of dax
> core code.

Can you help find end users that depend on it? Even the Red Hat
installation guide example shows mounting on pmem0 directly. [1]

My primary concern is people that might be booting from pmem as boot
support requires an EFI partition table, and initramfs images would
need to be respun to move to kpartx.

[1]: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html-single/storage_administration_guide/index#Configuring-Persistent-Memory-for-File-System-Direct-Access-DAX
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
