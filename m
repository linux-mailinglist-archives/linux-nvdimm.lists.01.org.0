Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1CB13617D
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jan 2020 21:03:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 792D410097DC6;
	Thu,  9 Jan 2020 12:06:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC52510097DFB
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jan 2020 12:06:31 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id c16so7022466oic.3
        for <linux-nvdimm@lists.01.org>; Thu, 09 Jan 2020 12:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aEPP3QvZTscWYv3Miihx0fBYyJilXweNv6Guj9B9KD8=;
        b=tavN+wgvdGNcOGcjKHqkAn5BjiXAReV94+OSH9Ri1PEiPT4LHVwg6b1hXbJyjtNOio
         yt+3CISS4TMH86U9kKgU8YPArehaT0FusWvpSVefSqnA63GewXNc+iMnr6ZN89GHlxNa
         I9xtBLZtZiieLaHNV/YWCS5IF2kdx6cBLmi6/YRneC/5UTcL8YKTe0qVGWfehSZnrWv9
         YsnAn85tdplqslZaJiAyOUvkKc3WlQ6ZG+UvCzJ00JIQxKAKUKINJoyIUTQOONSw3QOj
         1W72+PiwSitSGIes31XNdQt0P0T6DKzDvCP6YPxL/5GB664MG6OsTA5BfZF4LBGWHzr7
         Jvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aEPP3QvZTscWYv3Miihx0fBYyJilXweNv6Guj9B9KD8=;
        b=r461pAbhaxbJgdY5Md6QY4Gragkt0o4MqJS/A3XJBnzCdE7JtM+BJu/MVjzYYNfd14
         AzoO1AzZHYpWfdkPQv6kNIl5hAUsL4iwF4x9S9m7A9ngD49mXSjS0lc0PLHfIYdSRQ8H
         6aHRr6r+767GhaPleSsYIKTJ4D3d3pHiyAURFtMMiEgg5IB7JLYLcnXePCN8o8cZNjco
         c9xCMzKNiPzKRsGYN0MTsOJ+zlRq8t+/BUT3+07PwwaPRFjjVPi0Gs8dKv1ZmWnGAoiX
         GI2KkvLbruM11Z0eRiON3ERhT0NwRsziqUcAev8PE5Sdte2ZqoVwu0BfdEKApAreP/8K
         fsWg==
X-Gm-Message-State: APjAAAVvE9ZV5M4qIEqaxedZzBsAVgKJWqvYT14Ip6iBX6N1SQNdvC/Y
	qb0RvT8HF8bGpxTo3maX5PbiTvWFkqNrIko7bCLVmQ==
X-Google-Smtp-Source: APXvYqy8zIIpMCxwYPaK1lH7NGY047llhJ6X2TGv4+wlxidYTW8JIfkG1ylN1wkgzWx+t/HR+ipJvvJ3iI320Zd/2yQ=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr4809955oij.0.1578600191907;
 Thu, 09 Jan 2020 12:03:11 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com> <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia> <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com> <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200109112447.GG27035@quack2.suse.cz>
In-Reply-To: <20200109112447.GG27035@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 9 Jan 2020 12:03:01 -0800
Message-ID: <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To: Jan Kara <jack@suse.cz>
Message-ID-Hash: ZHA6ZSB2ETKLAKXAWPBOV2SZU4VLBGJN
X-Message-ID-Hash: ZHA6ZSB2ETKLAKXAWPBOV2SZU4VLBGJN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZHA6ZSB2ETKLAKXAWPBOV2SZU4VLBGJN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 9, 2020 at 3:27 AM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 07-01-20 10:49:55, Dan Williams wrote:
> > On Tue, Jan 7, 2020 at 10:33 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > W.r.t partitioning, bdev_dax_pgoff() seems to be the pain point where
> > > dax code refers back to block device to figure out partition offset in
> > > dax device. If we create a dax object corresponding to "struct block_device"
> > > and store sector offset in that, then we could pass that object to dax
> > > code and not worry about referring back to bdev. I have written some
> > > proof of concept code and called that object "dax_handle". I can post
> > > that code if there is interest.
> >
> > I don't think it's worth it in the end especially considering
> > filesystems are looking to operate on /dev/dax devices directly and
> > remove block entanglements entirely.
> >
> > > IMHO, it feels useful to be able to partition and use a dax capable
> > > block device in same way as non-dax block device. It will be really
> > > odd to think that if filesystem is on /dev/pmem0p1, then dax can't
> > > be enabled but if filesystem is on /dev/mapper/pmem0p1, then dax
> > > will work.
> >
> > That can already happen today. If you do not properly align the
> > partition then dax operations will be disabled. This proposal just
> > extends that existing failure domain to make all partitions fail to
> > support dax.
>
> Well, I have some sympathy with the sysadmin that has /dev/pmem0 device,
> decides to create partitions on it for whatever (possibly misguided)
> reason and then ponders why the hell DAX is not working? And PAGE_SIZE
> partition alignment is so obvious and widespread that I don't count it as a
> realistic error case sysadmins would be pondering about currently.
>
> So I'd find two options reasonably consistent:
> 1) Keep status quo where partitions are created and support DAX.
> 2) Stop partition creation altogether, if anyones wants to split pmem
> device further, he can use dm-linear for that (i.e., kpartx).
>
> But I'm not sure if the ship hasn't already sailed for option 2) to be
> feasible without angry users and Linus reverting the change.

Christoph? I feel myself leaning more and more to the "keep pmem
partitions" camp.

I don't see "drop partition support" effort ending well given the long
standing "ext4 fails to mount when dax is not available" precedent.

I think the next least bad option is to have a dax_get_by_host()
variant that passes an offset and length pair rather than requiring a
later bdev_dax_pgoff() to recall the offset. This also prevents
needing to add another dax-device object representation.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
