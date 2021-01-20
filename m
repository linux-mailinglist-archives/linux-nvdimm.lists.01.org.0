Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D932FDBFD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 22:39:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1DB60100EBBC4;
	Wed, 20 Jan 2021 13:39:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B190B100EC1E1
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 13:39:40 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id d22so97887edy.1
        for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 13:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSf0ToA2jort2u5AL1d6u4W1M1rj7Hzrgs+Or59IlL8=;
        b=Wx00Bh5rJYoL4qGksYW4rVJ/kBgxBKt2mOLjC9TC7EeE3ZEq7q4OnnIIHafptQ73dK
         hJs8dnWkRE7Ft9iev9hpbP0dhrGvSrUgOIwvpPVUn0DEnkQntiVbhynN9+6Nrl/QMlr0
         QIzkdvK0iA7LxlsR8LWoQAktVCmDEl5Q9AD+oo/NJTKRYT25BZZ036v+RyeLrx0pf+1A
         Xf0xCxYM3WUJWkMajd8WBdhD6zvIWSVrAOoV2wNOxiuDri1pt2mSAFQ1KGXr+7q3FlH2
         I5QqfpEz/N4nnkmWNI856YGLiBkPtO9C0OZtW4O/N28KHzANFfcQlUcqFMitar8vKbRz
         PPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSf0ToA2jort2u5AL1d6u4W1M1rj7Hzrgs+Or59IlL8=;
        b=PIPbn0RJgwxFvRVrs53m75c8wysdAmC/eBesTc4jn5ZTEIMTmW169q498AhCW2gloq
         KbJmPYT2vGP0sGBr9W+6YyB20wHOGXGfMBYVh3AC6uctR3u/WoYAMBl5KokmzLoc7+qE
         d9PuRqQZN70fxLmWebnxFrFPchlVyyVlyfl3c1CdCqAsqO3ycg6WfkcsHpqShi4+Awml
         iCGxe5gxKBgBh8DK4Gn/5ffVJv5AO3g/9FnSsCfDoQhyvjXlq+32G3pkbGQmemTJnaIq
         OYzjn2C1dxHtpmEkalPudrqGQ7Hv3YCzIc+JHk2WzcF30pHU6+/qysK+qp1XNG+Zs9/k
         Z8Zg==
X-Gm-Message-State: AOAM531fWp5AmGs9SDjS/gyECIL8v44H/MZs9JZB9iTzTnkakl3msvCw
	q/iAP66P6BcmECu+Qry1A49C+vy9NjjSR3PvJI4zZg==
X-Google-Smtp-Source: ABdhPJxcE/BaYJOETLqDHllMKGvULEympsLIRRmfqU1RvhqTEPz1/TeaeZVph7DeRnSY0l0uDtErKNbemEGpEsLi3tI=
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr6643099edd.52.1611178778234;
 Wed, 20 Jan 2021 13:39:38 -0800 (PST)
MIME-Version: 1.0
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210120194609.GA3843758@infradead.org> <CAPcyv4jvGfZ1W8KLPO22oYVDBiUYius+Nf8kRNP=xmPvjg+deA@mail.gmail.com>
In-Reply-To: <CAPcyv4jvGfZ1W8KLPO22oYVDBiUYius+Nf8kRNP=xmPvjg+deA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 20 Jan 2021 13:39:31 -0800
Message-ID: <CAPcyv4g+Pd+A6Aa9uXK1GwMo726niSF9jZ=fQvEuyNocso1zcA@mail.gmail.com>
Subject: Re: [PATCH 1/3] cdev: Finish the cdev api with queued mode support
To: Christoph Hellwig <hch@infradead.org>
Message-ID-Hash: 7QVG7ANCLHDZN2FLQGSUY25XDU5FKO6F
X-Message-ID-Hash: 7QVG7ANCLHDZN2FLQGSUY25XDU5FKO6F
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Greg KH <gregkh@linuxfoundation.org>, Logan Gunthorpe <logang@deltatee.com>, Hans Verkuil <hans.verkuil@cisco.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7QVG7ANCLHDZN2FLQGSUY25XDU5FKO6F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 20, 2021 at 12:20 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Jan 20, 2021 at 11:46 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > The subject doesn't make any sense to me.
> >
> > But thn again queued sound really weird.  You just have a managed
> > API with a refcount and synchronization, right?
>
> Correct.
>
> "queue" was in reference to the way q_usage_count behaves, but yes,
> just refcount + synchronization is all this is.
>
> >
> > procfs and debugfs already support these kind of managed ops, kinda sad
> > to duplicate this concept yet another time.
>
> Oh, I didn't realize there were managed ops there, I'll go take a look
> and see if cdev can adopt that scheme.

So in both cases they are leveraging the fact that they are the
filesystems that allocated the inode and will stash the private
reference counting somewhere relative to the container_of the
vfs_inode. I don't immediately see how that scheme can be implied to
special device files that can come from an inode on any filesystem.

I do see how debugfs and procfs could be unified, but I don't think
this percpu_ref for cdev is compatible.

Other ideas?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
