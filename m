Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D787E6D035
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 16:47:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 97A27212CFEC6;
	Thu, 18 Jul 2019 07:49:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=cohuck@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8E863212C01EE
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 07:49:48 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 65C6A89AD0;
 Thu, 18 Jul 2019 14:47:19 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 489261001B0C;
 Thu, 18 Jul 2019 14:47:10 +0000 (UTC)
Date: Thu, 18 Jul 2019 16:47:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 18/30] virtio_fs, dax: Set up virtio_fs dax_device
Message-ID: <20190718164707.76d60fdc.cohuck@redhat.com>
In-Reply-To: <20190718132049.37bea675.pasic@linux.ibm.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-19-vgoyal@redhat.com>
 <20190717192725.25c3d146.pasic@linux.ibm.com>
 <20190718110417.561f6475.cohuck@redhat.com>
 <20190718132049.37bea675.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 18 Jul 2019 14:47:19 +0000 (UTC)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Collin Walling <walling@linux.ibm.com>,
 Sebastian Ott <sebott@linux.ibm.com>, kvm@vger.kernel.org, miklos@szeredi.hu,
 linux-nvdimm@lists.01.org, David Hildenbrand <david@redhat.com>,
 linux-kernel@vger.kernel.org, dgilbert@redhat.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org, swhiteho@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, 18 Jul 2019 13:20:49 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 18 Jul 2019 11:04:17 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Wed, 17 Jul 2019 19:27:25 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:

> > > I'm trying to figure out how is this supposed to work on s390. My concern
> > > is, that on s390 PCI memory needs to be accessed by special
> > > instructions. This is taken care of by the stuff defined in
> > > arch/s390/include/asm/io.h. E.g. we 'override' __raw_writew so it uses
> > > the appropriate s390 instruction. However if the code does not use the
> > > linux abstractions for accessing PCI memory, but assumes it can be
> > > accessed like RAM, we have a problem.
> > > 
> > > Looking at this patch, it seems to me, that we might end up with exactly
> > > the case described. For example AFAICT copy_to_iter() (3) resolves to
> > > the function in lib/iov_iter.c which does not seem to cater for s390
> > > oddities.  
> > 
> > What about the new pci instructions recently introduced? Not sure how
> > they differ from the old ones (which are currently the only ones
> > supported in QEMU...), but I'm pretty sure they are supposed to solve
> > an issue :)
> >   
> 
> I'm struggling to find the connection between this topic and the new pci
> instructions. Can you please explain in more detail?

The problem is that I'm lacking detail myself... if the new approach is
handling some things substantially differently (e.g. you set up
something and then do read/writes instead of going through
instructions), things will probably work out differently.

> 
> > > 
> > > I didn't have the time to investigate this properly, and since virtio-fs
> > > is virtual, we may be able to get around what is otherwise a
> > > limitation on s390. My understanding of these areas is admittedly
> > > shallow, and since I'm not sure I'll have much more time to
> > > invest in the near future I decided to raise concern.
> > > 
> > > Any opinions?  
> > 
> > Let me point to the thread starting at
> > https://marc.info/?l=linux-s390&m=155048406205221&w=2 as well. That
> > memory region stuff is still unsolved for ccw, and I'm not sure if we
> > need to do something for zpci as well.
> >   
> 
> Right virtio-ccw is another problem, but at least there we don't have the
> need to limit ourselves to a very specific set of instructions (for
> accessing memory).
> 
> zPCI i.e. virtio-pci on z should require much less dedicated love if any

s/virtio-pci/pci/

> at all. Unfortunately I'm not very knowledgeable on either PCI in general
> or its s390 variant.

Right, the biggest issue with zpci and shared regions is the
interaction with ccw using shared regions as well.

Unfortunately, I can't judge any zpci details from here, either :(

If virtio-fs is working in its non-dax version, we'll at least have
something on s390. (Has anyone tried that, btw?) It seems that s390 is
only supporting a limited subset of dax anyway.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
