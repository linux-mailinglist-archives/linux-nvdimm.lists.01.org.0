Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D19613B3BF
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jan 2020 21:39:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2547910097DAB;
	Tue, 14 Jan 2020 12:42:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E8AAC10097E0A
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jan 2020 12:42:31 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id p8so13953505oth.10
        for <linux-nvdimm@lists.01.org>; Tue, 14 Jan 2020 12:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIZnzMCbYIPyWmmiZXOrwZsr2d1DaLuYf9PqBFFGxaY=;
        b=1ufiHoIhgkel1wNgfe5RR02iDJ6+fd8UzlDlpmsKFP4dFT9Zw+z+eHe5IHCwBCzia3
         Qx3uIUdT99fmuIsed3Wcx0ZiytVs24h1TKYzEHptbEJN6KLwBLnismJWzCM54qIzbXng
         6i+ainEaEBsD70PzhoIWMZ4fJhRG9/48EC7wGC+l3Tme4CNXCr+PDkn9oDjPuVkiudiu
         Jx7Hin+lVNC4afdBHw5tEOHqQLhQ+LCEm1bcbgLD2uj8DLGYhrZaQksVeFHTnazOxnuZ
         Kf5qJe/0whlXEMBDWBNM1CA1AAsAXa05zB+qlcDBZa7WUgJ3Wn6b+JSCmcNfsshtiJ1A
         CETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIZnzMCbYIPyWmmiZXOrwZsr2d1DaLuYf9PqBFFGxaY=;
        b=AzQ3Up1a+eGExDbZJV4EVImnGpC+bPFZuCqNrUly7irtc4zDtEFhwk4wvdvZuUQQUT
         iHEL+sKDYe7dIurpSJmxix5W8ducQwOZXrvfDhuryHN6/uw41VQU2/BGD5azvPfbDmwb
         NOABtm6SSr1gfExfJ5L6Dlalg0j6DUp3voQCDkZrdqAe7LDyO8c8f6uzxEp0/+uDeoUm
         6D0Bbx9OVCd9lbCE+TWzG43Jt5wHpjmSZmes92A0HSVNUi7D+WiUJnU7nXnlP7MTqqlJ
         YU9A92U0Q5CJo8iP8OWBKtxZWOz86l4WpKFaz11M+svq9h22rOSh2HtwpsFsLEFmRfFM
         DrPw==
X-Gm-Message-State: APjAAAWb0oh/ER1fSCNiNoYxtn0mSEH5JHqyQv2qpM7o9WBcl1ui5yNx
	5XBHAj5aIdbP+X1GQhGjaTG0ORKx6QjOO1a0s9Ssrw==
X-Google-Smtp-Source: APXvYqzvyu/O19EV+W3nd5Qbhe0VPu8Zpxx4j6lAGURR9nwfPKNQXF393TmIiEgkujYPUIcgpRgr0BZ6QoEDec2+nxI=
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr130746oto.71.1579034351613;
 Tue, 14 Jan 2020 12:39:11 -0800 (PST)
MIME-Version: 1.0
References: <20200107125159.GA15745@infradead.org> <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia> <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com> <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200109112447.GG27035@quack2.suse.cz> <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com>
In-Reply-To: <20200114203138.GA3145@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 14 Jan 2020 12:39:00 -0800
Message-ID: <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: JLBEWFXBJARX3FGJ6WIDU5IMYVJQGTSA
X-Message-ID-Hash: JLBEWFXBJARX3FGJ6WIDU5IMYVJQGTSA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JLBEWFXBJARX3FGJ6WIDU5IMYVJQGTSA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 14, 2020 at 12:31 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Jan 09, 2020 at 12:03:01PM -0800, Dan Williams wrote:
> > On Thu, Jan 9, 2020 at 3:27 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 07-01-20 10:49:55, Dan Williams wrote:
> > > > On Tue, Jan 7, 2020 at 10:33 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > W.r.t partitioning, bdev_dax_pgoff() seems to be the pain point where
> > > > > dax code refers back to block device to figure out partition offset in
> > > > > dax device. If we create a dax object corresponding to "struct block_device"
> > > > > and store sector offset in that, then we could pass that object to dax
> > > > > code and not worry about referring back to bdev. I have written some
> > > > > proof of concept code and called that object "dax_handle". I can post
> > > > > that code if there is interest.
> > > >
> > > > I don't think it's worth it in the end especially considering
> > > > filesystems are looking to operate on /dev/dax devices directly and
> > > > remove block entanglements entirely.
> > > >
> > > > > IMHO, it feels useful to be able to partition and use a dax capable
> > > > > block device in same way as non-dax block device. It will be really
> > > > > odd to think that if filesystem is on /dev/pmem0p1, then dax can't
> > > > > be enabled but if filesystem is on /dev/mapper/pmem0p1, then dax
> > > > > will work.
> > > >
> > > > That can already happen today. If you do not properly align the
> > > > partition then dax operations will be disabled. This proposal just
> > > > extends that existing failure domain to make all partitions fail to
> > > > support dax.
> > >
> > > Well, I have some sympathy with the sysadmin that has /dev/pmem0 device,
> > > decides to create partitions on it for whatever (possibly misguided)
> > > reason and then ponders why the hell DAX is not working? And PAGE_SIZE
> > > partition alignment is so obvious and widespread that I don't count it as a
> > > realistic error case sysadmins would be pondering about currently.
> > >
> > > So I'd find two options reasonably consistent:
> > > 1) Keep status quo where partitions are created and support DAX.
> > > 2) Stop partition creation altogether, if anyones wants to split pmem
> > > device further, he can use dm-linear for that (i.e., kpartx).
> > >
> > > But I'm not sure if the ship hasn't already sailed for option 2) to be
> > > feasible without angry users and Linus reverting the change.
> >
> > Christoph? I feel myself leaning more and more to the "keep pmem
> > partitions" camp.
> >
> > I don't see "drop partition support" effort ending well given the long
> > standing "ext4 fails to mount when dax is not available" precedent.
> >
> > I think the next least bad option is to have a dax_get_by_host()
> > variant that passes an offset and length pair rather than requiring a
> > later bdev_dax_pgoff() to recall the offset. This also prevents
> > needing to add another dax-device object representation.
>
> I am wondering what's the conclusion on this. I want to this to make
> progress in some direction so that I can make progress on virtiofs DAX
> support.

I think we should at least try to delete the partition support and see
if anyone screams. Have a module option to revert the behavior so
people are not stuck waiting for the revert to land, but if it stays
quiet then we're in a better place with that support pushed out of the
dax core.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
