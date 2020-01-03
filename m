Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 037F912FC1E
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Jan 2020 19:12:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 94D2C1011366C;
	Fri,  3 Jan 2020 10:15:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A939610113668
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jan 2020 10:15:41 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id c16so14756390oic.3
        for <linux-nvdimm@lists.01.org>; Fri, 03 Jan 2020 10:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3brJhWTSesWIRxDSnHgjF8nIZbts1Wu314rZzjXn1M=;
        b=lAn6FgwQQMYzkHNrvN1rRFNYVp+0/0fgWehxuV9jdkjbcq9UCjg/LWklrQMinMlTD+
         rjYhtgI2mNvRwWUnxAh3hV7ai1xjTahx4eD0I1E9IdQ4AWpZK0J6emaWKMy8TPy41pKP
         h63PGVQD/FEUvYx/yJwAhI8+3ooXUTbsu+MiCIAAHl1x2cxQqUlcp3d01qkIiWnF0sdv
         N2jvz2p8Z951aXN0UyUCkTU2WzwTU9HH0ZeLgyQzMMEl2rsW74FOlfswuDQP5Pw2wqYc
         ECOLx9irUQlfTHxACK2Lo5WiAl8FxMN5h06QpbaSb3r19c6QAS8YIyYY0iE0yDWNxke9
         SqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3brJhWTSesWIRxDSnHgjF8nIZbts1Wu314rZzjXn1M=;
        b=JKQc96I5NfFW8PcU1u0/GyjebSJrmX/1EBeoQ/FxykCR82BzXh3vtWaQNIxiDPJVg6
         /eTYXXT7n735Clebvt01ux5xtRzFhrJ+2N+WkeC129cMF+fWFalLdj6Qcio6EOX9dMO2
         BEmfwUU8ehRD6caVSN9LeDoTkD1RT5FRDM7vo8qBZywO+Y4jcmzXjkc3eGP46ac1MGDr
         +mPsJREU/PLVUQyrV2Wqs2CSrKXksGtVuCutF125LT4r9Tcz9X37426zvP9UqW3GZUto
         +STo87peGCAeLVV18XGU93aanzGAGiEgkC3dlkgMQY4Xq0QPdTQ2ND2YBIvnlQQr+RaK
         GEhA==
X-Gm-Message-State: APjAAAU6vYji4CAI3bm9kAeOJWMkuaMRNu+OE+3GrvrbF6oxOV7aSh2h
	SYWNAEjZWLMFzERLptjQrHgb/KGTDaY86vh6rjirlQ==
X-Google-Smtp-Source: APXvYqxNvahWxntDLEIKUszdbRJxBKjKuUGiDqlTVmO0biL4kYnJB9fAtU7+SaWNBxJZ6Rlsg/jaWbQJSirwoQgnbaI=
X-Received: by 2002:aca:3b44:: with SMTP id i65mr4303906oia.70.1578075140713;
 Fri, 03 Jan 2020 10:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20190821175720.25901-1-vgoyal@redhat.com> <20190821175720.25901-3-vgoyal@redhat.com>
 <20190826115316.GB21051@infradead.org> <20190826203326.GB13860@redhat.com>
 <20190826205829.GC13860@redhat.com> <20200103141235.GA13350@redhat.com>
In-Reply-To: <20200103141235.GA13350@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 3 Jan 2020 10:12:09 -0800
Message-ID: <CAPcyv4hr-KXUAT_tVy-GuTOq1GvVGHKsHwAPih60wcW3DGmqRg@mail.gmail.com>
Subject: Re: [PATCH 02/19] dax: Pass dax_dev to dax_writeback_mapping_range()
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: OVB432LKSV2GHU5QE2Q4ILZVILSYZ2XP
X-Message-ID-Hash: OVB432LKSV2GHU5QE2Q4ILZVILSYZ2XP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoph Hellwig <hch@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OVB432LKSV2GHU5QE2Q4ILZVILSYZ2XP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 3, 2020 at 6:12 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Aug 26, 2019 at 04:58:29PM -0400, Vivek Goyal wrote:
> > On Mon, Aug 26, 2019 at 04:33:26PM -0400, Vivek Goyal wrote:
> > > On Mon, Aug 26, 2019 at 04:53:16AM -0700, Christoph Hellwig wrote:
> > > > On Wed, Aug 21, 2019 at 01:57:03PM -0400, Vivek Goyal wrote:
> > > > > Right now dax_writeback_mapping_range() is passed a bdev and dax_dev
> > > > > is searched from that bdev name.
> > > > >
> > > > > virtio-fs does not have a bdev. So pass in dax_dev also to
> > > > > dax_writeback_mapping_range(). If dax_dev is passed in, bdev is not
> > > > > used otherwise dax_dev is searched using bdev.
> > > >
> > > > Please just pass in only the dax_device and get rid of the block device.
> > > > The callers should have one at hand easily, e.g. for XFS just call
> > > > xfs_find_daxdev_for_inode instead of xfs_find_bdev_for_inode.
> > >
> > > Sure. Here is the updated patch.
> > >
> > > This patch can probably go upstream independently. If you are fine with
> > > the patch, I can post it separately for inclusion.
> >
> > Forgot to update function declaration in case of !CONFIG_FS_DAX. Here is
> > the updated patch.
> >
> > Subject: dax: Pass dax_dev instead of bdev to dax_writeback_mapping_range()
> >
> > As of now dax_writeback_mapping_range() takes "struct block_device" as a
> > parameter and dax_dev is searched from bdev name. This also involves taking
> > a fresh reference on dax_dev and putting that reference at the end of
> > function.
> >
> > We are developing a new filesystem virtio-fs and using dax to access host
> > page cache directly. But there is no block device. IOW, we want to make
> > use of dax but want to get rid of this assumption that there is always
> > a block device associated with dax_dev.
> >
> > So pass in "struct dax_device" as parameter instead of bdev.
> >
> > ext2/ext4/xfs are current users and they already have a reference on
> > dax_device. So there is no need to take reference and drop reference to
> > dax_device on each call of this function.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>
> Hi Dan,
>
> Ping for this patch. I see christoph and Jan acked it. Can we take it. Not
> sure how to get ack from ext4 developers.

Jan counts for ext4, I just missed this. Now merged.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
