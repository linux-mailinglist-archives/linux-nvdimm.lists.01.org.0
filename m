Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AE06CEA9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 15:15:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8C9EB212CFEBD;
	Thu, 18 Jul 2019 06:18:06 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EFC6621959CB2
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 06:18:04 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6F0EA3086222;
 Thu, 18 Jul 2019 13:15:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB9395E7C0;
 Thu, 18 Jul 2019 13:15:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 76ADD2238A7; Thu, 18 Jul 2019 09:15:32 -0400 (EDT)
Date: Thu, 18 Jul 2019 09:15:32 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 18/30] virtio_fs, dax: Set up virtio_fs dax_device
Message-ID: <20190718131532.GA13883@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-19-vgoyal@redhat.com>
 <20190717192725.25c3d146.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190717192725.25c3d146.pasic@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 18 Jul 2019 13:15:35 +0000 (UTC)
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
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Sebastian Ott <sebott@linux.ibm.com>, kvm@vger.kernel.org, miklos@szeredi.hu,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, dgilbert@redhat.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org, swhiteho@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 17, 2019 at 07:27:25PM +0200, Halil Pasic wrote:
> On Wed, 15 May 2019 15:27:03 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > Setup a dax device.
> > 
> > Use the shm capability to find the cache entry and map it.
> > 
> > The DAX window is accessed by the fs/dax.c infrastructure and must have
> > struct pages (at least on x86).  Use devm_memremap_pages() to map the
> > DAX window PCI BAR and allocate struct page.
> >
> 
> Sorry for being this late. I don't see any more recent version so I will
> comment here.
> 
> I'm trying to figure out how is this supposed to work on s390. My concern
> is, that on s390 PCI memory needs to be accessed by special
> instructions. This is taken care of by the stuff defined in
> arch/s390/include/asm/io.h. E.g. we 'override' __raw_writew so it uses
> the appropriate s390 instruction. However if the code does not use the
> linux abstractions for accessing PCI memory, but assumes it can be
> accessed like RAM, we have a problem.
> 
> Looking at this patch, it seems to me, that we might end up with exactly
> the case described. For example AFAICT copy_to_iter() (3) resolves to
> the function in lib/iov_iter.c which does not seem to cater for s390
> oddities.
> 
> I didn't have the time to investigate this properly, and since virtio-fs
> is virtual, we may be able to get around what is otherwise a
> limitation on s390. My understanding of these areas is admittedly
> shallow, and since I'm not sure I'll have much more time to
> invest in the near future I decided to raise concern.
> 
> Any opinions?

Hi Halil,

I don't understand s390 and how PCI works there as well. Is there any
other transport we can use there to map IO memory directly and access
using DAX?

BTW, is DAX supported for s390.

I am also hoping somebody who knows better can chip in. Till that time,
we could still use virtio-fs on s390 without DAX.

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
