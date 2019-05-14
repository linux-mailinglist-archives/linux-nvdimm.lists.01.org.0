Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 099D21CBC6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 17:25:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2BEC821275442;
	Tue, 14 May 2019 08:25:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 930DA2194EB7F
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 08:25:21 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4A433087BB4;
 Tue, 14 May 2019 15:25:20 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A887B608A6;
 Tue, 14 May 2019 15:25:20 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 62E0118089CC;
 Tue, 14 May 2019 15:25:20 +0000 (UTC)
Date: Tue, 14 May 2019 11:25:20 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>, 
 dan j williams <dan.j.williams@intel.com>
Message-ID: <1112624345.28705248.1557847520326.JavaMail.zimbra@redhat.com>
In-Reply-To: <c22d42f6-ef94-0310-36f2-e9085d3464c2@infradead.org>
References: <20190514145422.16923-1-pagupta@redhat.com>
 <20190514145422.16923-3-pagupta@redhat.com>
 <c22d42f6-ef94-0310-36f2-e9085d3464c2@infradead.org>
Subject: Re: [Qemu-devel] [PATCH v9 2/7] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
X-Originating-IP: [10.65.16.148, 10.4.195.17]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: dlXNsat06Cmvl53reNYz3WCWYqwXeA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 14 May 2019 15:25:21 +0000 (UTC)
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
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org,
 adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org,
 aarcange@redhat.com, jstaron@google.com, linux-nvdimm@lists.01.org,
 david@redhat.com, willy@infradead.org, hch@infradead.org,
 linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org, lenb@kernel.org,
 kilobyte@angband.pl, riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>,
 stefanha@redhat.com, imammedo@redhat.com, lcapitulino@redhat.com,
 kwolf@redhat.com, nilal@redhat.com, tytso@mit.edu,
 xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
 darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


> On 5/14/19 7:54 AM, Pankaj Gupta wrote:
> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > index 35897649c24f..94bad084ebab 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -42,6 +42,17 @@ config VIRTIO_PCI_LEGACY
> >  
> >  	  If unsure, say Y.
> >  
> > +config VIRTIO_PMEM
> > +	tristate "Support for virtio pmem driver"
> > +	depends on VIRTIO
> > +	depends on LIBNVDIMM
> > +	help
> > +	This driver provides access to virtio-pmem devices, storage devices
> > +	that are mapped into the physical address space - similar to NVDIMMs
> > +	 - with a virtio-based flushing interface.
> > +
> > +	If unsure, say M.
> 
> <beep>
> from Documentation/process/coding-style.rst:
> "Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces."

ah... I changed help text and 'checkpatch' did not say anything :( .

Will wait for Dan, If its possible to add two spaces to help text while applying
the series.

Thanks,
Pankaj
  

> 
> > +
> >  config VIRTIO_BALLOON
> >  	tristate "Virtio balloon driver"
> >  	depends on VIRTIO
> 
> thanks.
> --
> ~Randy
> 
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
