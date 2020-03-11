Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7889182256
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Mar 2020 20:32:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 43B3210FC3763;
	Wed, 11 Mar 2020 12:33:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::144; helo=mail-il1-x144.google.com; envelope-from=amir73il@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4B73710FC3762
	for <linux-nvdimm@lists.01.org>; Wed, 11 Mar 2020 12:33:21 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p1so3148698ils.12
        for <linux-nvdimm@lists.01.org>; Wed, 11 Mar 2020 12:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mXGK5i6t3MsASMxT0lG83kEdxLaxyp7/VkTyiOzfWA=;
        b=Ytxtuf3QQxZWXFhnUaNGSp6HRtTjU2rvi2VTtDUKIWrIxcTF08sJcrGYYDSZ0cjYVi
         NC7Jr18qi45Tn2TxgwNtbFQJyxoGPpldN77YOO65Z1kc2htI75AljVGHwZtqXl4WFh09
         II9VBsbHtPSWuTzSj8DU2x+vAkcTNO12e6wd0JHiEtKO2fSJv+IyvIKGAf31Vwlh/6le
         fGg/uJ53yaXQU8x+y+MF9ACDtFn+SNGFV7s3uD000Qka0NXvCcWm88thMuialB2aMbeW
         LTTNeVSpoAVa+tcRkDxn2Zcdp7Mw05sgFo6hkmJTrwxWy7LCnul4OZtHXyEwSBI41s5K
         c7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mXGK5i6t3MsASMxT0lG83kEdxLaxyp7/VkTyiOzfWA=;
        b=tM1hHUpN2+kRnGoRpNfdRTzjfc8VqM3crQpL4leVzvDEsnWTx3settsOmJXryuLJrv
         OCQO7sG3F8LGpcDAkxtG+yxppKcXWM3F6Q8x1jtKHKv/dbqAW039JryvwOzFr6unsv8W
         VeRR1VgCAPjSz71LLEjtxLNjqjBELi0fSGs50XjExkxyyR22LUZv9lm5JkeAGuGBKOIJ
         6M4VEzWlzeDe6vK745oHmiIT+9mFbFdsgarrJyBcZ+c4OmQ3dvn+FK06p07nMVqyLeZq
         UkhBC4428sXJoAjr5bsHohYBzK+J2Mgn2C04o/zqkPkHB/+JCTNkznQtgZW5Y9TP+qP8
         VNdQ==
X-Gm-Message-State: ANhLgQ1YipW6Db8IuPul5udASj8PMVnRJUTHFybV4WS81WaZP9fs8S1j
	RswgTEyEWpUYMa3qR7zKrQ7OnsrXyx0O9tWHKZM=
X-Google-Smtp-Source: ADFU+vv0awZxCRaxLNBtprB5PP6XxG/N9GF146xOmYHuD2pw5NVQaGTRY7PIOTDoXzSifgO7fcQC19biON6GFFI5zP8=
X-Received: by 2002:a92:6f10:: with SMTP id k16mr4651309ilc.275.1583955149310;
 Wed, 11 Mar 2020 12:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <CAOQ4uxi_Xrf+iyP6KVugFgLOfzUvscMr0de0KxQo+jHNBCA9oA@mail.gmail.com>
 <20200311184830.GC83257@redhat.com>
In-Reply-To: <20200311184830.GC83257@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 11 Mar 2020 21:32:17 +0200
Message-ID: <CAOQ4uxjja3cReO28qOd-YGmhU-_KrLxOCaBeqZYydxPAte9_pg@mail.gmail.com>
Subject: Re: [PATCH 00/20] virtiofs: Add DAX support
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: DPJI5HDTVROTDIDOYWDJSIVU2OGH4RVS
X-Message-ID-Hash: DPJI5HDTVROTDIDOYWDJSIVU2OGH4RVS
X-MailFrom: amir73il@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DPJI5HDTVROTDIDOYWDJSIVU2OGH4RVS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 11, 2020 at 8:48 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Mar 11, 2020 at 07:22:51AM +0200, Amir Goldstein wrote:
> > On Wed, Mar 4, 2020 at 7:01 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > This patch series adds DAX support to virtiofs filesystem. This allows
> > > bypassing guest page cache and allows mapping host page cache directly
> > > in guest address space.
> > >
> > > When a page of file is needed, guest sends a request to map that page
> > > (in host page cache) in qemu address space. Inside guest this is
> > > a physical memory range controlled by virtiofs device. And guest
> > > directly maps this physical address range using DAX and hence gets
> > > access to file data on host.
> > >
> > > This can speed up things considerably in many situations. Also this
> > > can result in substantial memory savings as file data does not have
> > > to be copied in guest and it is directly accessed from host page
> > > cache.
> > >
> > > Most of the changes are limited to fuse/virtiofs. There are couple
> > > of changes needed in generic dax infrastructure and couple of changes
> > > in virtio to be able to access shared memory region.
> > >
> > > These patches apply on top of 5.6-rc4 and are also available here.
> > >
> > > https://github.com/rhvgoyal/linux/commits/vivek-04-march-2020
> > >
> > > Any review or feedback is welcome.
> > >
> > [...]
> > >  drivers/dax/super.c                |    3 +-
> > >  drivers/virtio/virtio_mmio.c       |   32 +
> > >  drivers/virtio/virtio_pci_modern.c |  107 +++
> > >  fs/dax.c                           |   66 +-
> > >  fs/fuse/dir.c                      |    2 +
> > >  fs/fuse/file.c                     | 1162 +++++++++++++++++++++++++++-
> >
> > That's a big addition to already big file.c.
> > Maybe split dax specific code to dax.c?
> > Can be a post series cleanup too.
>
> How about fs/fuse/iomap.c instead. This will have all the iomap related logic
> as well as all the dax range allocation/free logic which is required
> by iomap logic. That moves about 900 lines of code from file.c to iomap.c
>

Fine by me. I didn't take time to study the code in file.c
I just noticed is has grown a lot bigger and wasn't sure that
it made sense. Up to you. Only if you think the result would be nicer
to maintain.

Thanks,
Amir.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
