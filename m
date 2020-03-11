Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B07E01822A6
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Mar 2020 20:40:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1227F10FC3769;
	Wed, 11 Mar 2020 12:40:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CD52010FC3765
	for <linux-nvdimm@lists.01.org>; Wed, 11 Mar 2020 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583955599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0iJaznCc2W6ynUzCi8XYKyKVbQgxJcuIbZRmVPm98Cs=;
	b=FDYbUc5Fb0l3MoVWXKjoymfbE5lhKYehKWVVN/q9/W+N0zFtrSX5DheAUDual40LZjFmLv
	6yz5JAU7oSJBKOyHAuiiTh3FkG6RFPcSCmh/YYNmSwFFrkMJxc+ycVbcONWeATJp9iiVyh
	vH8vkqouhyqpOf8Futc7QqDfaXASe7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-3ir9tEcdPryhDjRmk-jl7w-1; Wed, 11 Mar 2020 15:39:53 -0400
X-MC-Unique: 3ir9tEcdPryhDjRmk-jl7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9D85190D340;
	Wed, 11 Mar 2020 19:39:51 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0ECDA92D24;
	Wed, 11 Mar 2020 19:39:44 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 9763222021D; Wed, 11 Mar 2020 15:39:43 -0400 (EDT)
Date: Wed, 11 Mar 2020 15:39:43 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 00/20] virtiofs: Add DAX support
Message-ID: <20200311193943.GE83257@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <CAOQ4uxi_Xrf+iyP6KVugFgLOfzUvscMr0de0KxQo+jHNBCA9oA@mail.gmail.com>
 <20200311184830.GC83257@redhat.com>
 <CAOQ4uxjja3cReO28qOd-YGmhU-_KrLxOCaBeqZYydxPAte9_pg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjja3cReO28qOd-YGmhU-_KrLxOCaBeqZYydxPAte9_pg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: NMLVKJUPVOVLOC5K265DHBUZQ6UMVMWW
X-Message-ID-Hash: NMLVKJUPVOVLOC5K265DHBUZQ6UMVMWW
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NMLVKJUPVOVLOC5K265DHBUZQ6UMVMWW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 11, 2020 at 09:32:17PM +0200, Amir Goldstein wrote:
> On Wed, Mar 11, 2020 at 8:48 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Mar 11, 2020 at 07:22:51AM +0200, Amir Goldstein wrote:
> > > On Wed, Mar 4, 2020 at 7:01 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > This patch series adds DAX support to virtiofs filesystem. This allows
> > > > bypassing guest page cache and allows mapping host page cache directly
> > > > in guest address space.
> > > >
> > > > When a page of file is needed, guest sends a request to map that page
> > > > (in host page cache) in qemu address space. Inside guest this is
> > > > a physical memory range controlled by virtiofs device. And guest
> > > > directly maps this physical address range using DAX and hence gets
> > > > access to file data on host.
> > > >
> > > > This can speed up things considerably in many situations. Also this
> > > > can result in substantial memory savings as file data does not have
> > > > to be copied in guest and it is directly accessed from host page
> > > > cache.
> > > >
> > > > Most of the changes are limited to fuse/virtiofs. There are couple
> > > > of changes needed in generic dax infrastructure and couple of changes
> > > > in virtio to be able to access shared memory region.
> > > >
> > > > These patches apply on top of 5.6-rc4 and are also available here.
> > > >
> > > > https://github.com/rhvgoyal/linux/commits/vivek-04-march-2020
> > > >
> > > > Any review or feedback is welcome.
> > > >
> > > [...]
> > > >  drivers/dax/super.c                |    3 +-
> > > >  drivers/virtio/virtio_mmio.c       |   32 +
> > > >  drivers/virtio/virtio_pci_modern.c |  107 +++
> > > >  fs/dax.c                           |   66 +-
> > > >  fs/fuse/dir.c                      |    2 +
> > > >  fs/fuse/file.c                     | 1162 +++++++++++++++++++++++++++-
> > >
> > > That's a big addition to already big file.c.
> > > Maybe split dax specific code to dax.c?
> > > Can be a post series cleanup too.
> >
> > How about fs/fuse/iomap.c instead. This will have all the iomap related logic
> > as well as all the dax range allocation/free logic which is required
> > by iomap logic. That moves about 900 lines of code from file.c to iomap.c
> >
> 
> Fine by me. I didn't take time to study the code in file.c
> I just noticed is has grown a lot bigger and wasn't sure that
> it made sense. Up to you. Only if you think the result would be nicer
> to maintain.

I am happy to move this code to a separate file. In fact I think we could
probably break it further into another file say dax-mapping.c or something
like that where all the memory range allocation/reclaim logic goes and
iomap logic remains in iomap.c.

But that's probably a future cleanup if code in this file continues to grow.

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
