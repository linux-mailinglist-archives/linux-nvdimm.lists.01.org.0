Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD26336945
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Mar 2021 01:53:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6080E100F2249;
	Wed, 10 Mar 2021 16:53:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C3C70100EB85D
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 16:53:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id bf3so251655edb.6
        for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 16:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q4/XB1NjVzkcassvGF9k8OOkOtHMefsYgpLIOhbHN44=;
        b=VytBblI4nb9JtqHcpg5PYs38jajnTR0u0JS6jpl3x32VbN+1FmkpQKztC6QGh/owq5
         OKZtrVWvRSAAgZSa52MpRCKaSLrn8M/wS7+lpN3thB2qy4x5ASseSLbpttO55PtkZRcg
         Usu+VKGsxFUTs0UMAmVvtsOBETR54kARgVDHg+jieLrIMe5HoGU7jO+WFaXqB1/Shadj
         acLiBoL+9rXMHYN4h5kBD34GepJ6XoGwLlBU74peSFTH4olLLWwe877BUouMrPF9vqxz
         iTkHZTfI/P5BPtXD8Ih2GVWaZnwQK2AMiro/XIrqqU/ujd/Qp2vrSZYPEp61VpSaQc8f
         2Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4/XB1NjVzkcassvGF9k8OOkOtHMefsYgpLIOhbHN44=;
        b=dquFkYJVwdoA4gKc9rOY9FhdXzu7VXiWIIPb7iwT+j8tpAJSvPAWsMyc9R7iQHL+aZ
         DMnwjEY/R7o7b57SkgEwJX7iQNmJGtPCQIZREgZ/dPKyqNxAe4ekRPxbejbjb1qR99H8
         4L+r9f6/LA8EGicDbK176pztFcXc8dSZ+cFbjNQMGHN3o87XDZOjnvUM4ojJIj9H0p8A
         nGQxw7bSPQUgyy0ORGbFPI08qiULLO7p47xsqBTwSfrx39xxRqEp4Y5VitrMO//QWIuT
         qXr/h6Ru8jwB5MgbVVfvNFFvMoG4Hh9sIluzb+Lrhkbhgdl5fNvaHtZKNtmgolQm2hiZ
         byeQ==
X-Gm-Message-State: AOAM533104vaee86SzsJ75GreSkjbP44A7FH6GcAoCo/Gfxl+7F6Pvxm
	ThuT/gpVb0R2fgGQgHd3OwCNFjNhRUoi/1PMZHbFRg==
X-Google-Smtp-Source: ABdhPJypQ8GemOXeRAlB5nBwa/LaXTEzwLO62LM4I6+2OuCpeLVCa5nLj+566PgoZJjKJzgw0+xwotjje7pT9PlLG2A=
X-Received: by 2002:aa7:dd05:: with SMTP id i5mr6011841edv.300.1615424006716;
 Wed, 10 Mar 2021 16:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org> <20210310142159.kudk7q2ogp4yqn36@fiona>
 <20210310142643.GQ3479805@casper.infradead.org>
In-Reply-To: <20210310142643.GQ3479805@casper.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 10 Mar 2021 16:53:15 -0800
Message-ID: <CAPcyv4i80GXjjoAD9G0AaRDWPbcTSLogJE9NokO4Eqpzt6UMkA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
To: Matthew Wilcox <willy@infradead.org>
Message-ID-Hash: YK2TLOL3LHAV4Z5ZKXPCMZCXFQW5NDVP
X-Message-ID-Hash: YK2TLOL3LHAV4Z5ZKXPCMZCXFQW5NDVP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Goldwyn Rodrigues <rgoldwyn@suse.de>, Neal Gompa <ngompa13@gmail.com>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, ocfs2-devel@oss.oracle.com, david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YK2TLOL3LHAV4Z5ZKXPCMZCXFQW5NDVP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 10, 2021 at 6:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Mar 10, 2021 at 08:21:59AM -0600, Goldwyn Rodrigues wrote:
> > On 13:02 10/03, Matthew Wilcox wrote:
> > > On Wed, Mar 10, 2021 at 07:30:41AM -0500, Neal Gompa wrote:
> > > > Forgive my ignorance, but is there a reason why this isn't wired up to
> > > > Btrfs at the same time? It seems weird to me that adding a feature
> > >
> > > btrfs doesn't support DAX.  only ext2, ext4, XFS and FUSE have DAX support.
> > >
> > > If you think about it, btrfs and DAX are diametrically opposite things.
> > > DAX is about giving raw access to the hardware.  btrfs is about offering
> > > extra value (RAID, checksums, ...), none of which can be done if the
> > > filesystem isn't in the read/write path.
> > >
> > > That's why there's no DAX support in btrfs.  If you want DAX, you have
> > > to give up all the features you like in btrfs.  So you may as well use
> > > a different filesystem.
> >
> > DAX on btrfs has been attempted[1]. Of course, we could not
>
> But why?  A completeness fetish?  I don't understand why you decided
> to do this work.

Isn't DAX useful for pagecache minimization on read even if it is
awkward for a copy-on-write fs?

Seems it would be a useful case to have COW'd VM images on BTRFS that
don't need superfluous page cache allocations.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
