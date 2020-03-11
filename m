Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8C7180FC6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Mar 2020 06:23:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F0D2210FC3611;
	Tue, 10 Mar 2020 22:23:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d42; helo=mail-io1-xd42.google.com; envelope-from=amir73il@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9010E1007B1F6
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 22:23:54 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d8so621854ion.7
        for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 22:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhWEqnexHgncpvxDS2l8sBNTUU1im25PrBPC7w+tOLk=;
        b=FQioROWeCZRT5RbT70b6aS3L4z5A8Xh9+TkXcRo1x7CAqq0IA0ua0MEGE5Uykqe0FL
         s7mGcH8etLLtylbbbK6FSbTb6IJjRhs43A8ysMHl6swkDiSbevywH8PsYFGAc5tuTu4F
         hx5OcZDYIvjseSVuRKJfka41SHIGYvXKH88DsabLaszJEEo8W3EyzPcO//PwBEE3M3gH
         e8lIZX3B3ofO7IvWP08ivloJcQzyEW6krILi2rllnwhYD/9lqaIRca+M2m313QFn0KyF
         ArCoRx8xQTINJyLzKbBhKUuuPeE0059amPOESX5qE3B8OeqEICFbnYjaivOd08jIc7RP
         nwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhWEqnexHgncpvxDS2l8sBNTUU1im25PrBPC7w+tOLk=;
        b=D/etFK1saf5EOtGUkzCWrJIz/6v8/U5NAs/ERu0ju14u6NiZ+rVQTPMI9psbs6GVwz
         5wfr2BcWb4gQE6zmvTf/P8bPjcEimaPmbZc53k37/IoP0Bq6NmJR0UMbNviHml0vHTT+
         DEIHOfTRSq1jx4GqYM/gIKiOfvF+PuwFmfWxCNT0f8T+VNCaNvBOtUUyOujNMAhVHZl7
         RfAxIFr8JCcTW7G8owD6x9ECXEeah+VpVKDI76MuHOD2G3HwhQS7hGTCJU+FVbu91HU6
         wVqhz7fdM5N4FyNgejGPls5HmyBNxwyjACim9oHsOYbHr0sWcq+pI24i3IGbYS5agaob
         IbKA==
X-Gm-Message-State: ANhLgQ3Ag4eLn0Mg70lYB3d7gNwBAJPYJV8RuM+e5vi/IZCW9LLT02IS
	4YHWI80YDfaNPE6dESh8DMS67XcyfKWwtsnN7VI=
X-Google-Smtp-Source: ADFU+vtANanN8/PEuGjCzSXszWB2s1uvEicvF+tk9dez9cHRd+Aa9rbD4VGIuhF4w32MFOQw+Ll20yj+6BJ6OuZClyY=
X-Received: by 2002:a6b:784a:: with SMTP id h10mr1383631iop.64.1583904182703;
 Tue, 10 Mar 2020 22:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 11 Mar 2020 07:22:51 +0200
Message-ID: <CAOQ4uxi_Xrf+iyP6KVugFgLOfzUvscMr0de0KxQo+jHNBCA9oA@mail.gmail.com>
Subject: Re: [PATCH 00/20] virtiofs: Add DAX support
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: RSSLV43ZQB2IZLPLYYTRFUPJUIJLUPUE
X-Message-ID-Hash: RSSLV43ZQB2IZLPLYYTRFUPJUIJLUPUE
X-MailFrom: amir73il@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RSSLV43ZQB2IZLPLYYTRFUPJUIJLUPUE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 4, 2020 at 7:01 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi,
>
> This patch series adds DAX support to virtiofs filesystem. This allows
> bypassing guest page cache and allows mapping host page cache directly
> in guest address space.
>
> When a page of file is needed, guest sends a request to map that page
> (in host page cache) in qemu address space. Inside guest this is
> a physical memory range controlled by virtiofs device. And guest
> directly maps this physical address range using DAX and hence gets
> access to file data on host.
>
> This can speed up things considerably in many situations. Also this
> can result in substantial memory savings as file data does not have
> to be copied in guest and it is directly accessed from host page
> cache.
>
> Most of the changes are limited to fuse/virtiofs. There are couple
> of changes needed in generic dax infrastructure and couple of changes
> in virtio to be able to access shared memory region.
>
> These patches apply on top of 5.6-rc4 and are also available here.
>
> https://github.com/rhvgoyal/linux/commits/vivek-04-march-2020
>
> Any review or feedback is welcome.
>
[...]
>  drivers/dax/super.c                |    3 +-
>  drivers/virtio/virtio_mmio.c       |   32 +
>  drivers/virtio/virtio_pci_modern.c |  107 +++
>  fs/dax.c                           |   66 +-
>  fs/fuse/dir.c                      |    2 +
>  fs/fuse/file.c                     | 1162 +++++++++++++++++++++++++++-

That's a big addition to already big file.c.
Maybe split dax specific code to dax.c?
Can be a post series cleanup too.

Thanks,
Amir.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
