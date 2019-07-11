Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A1E65FA9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Jul 2019 20:46:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 977E6212B6D46;
	Thu, 11 Jul 2019 11:48:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A3C31212B5F1A
 for <linux-nvdimm@lists.01.org>; Thu, 11 Jul 2019 11:48:39 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 63C2130832E9;
 Thu, 11 Jul 2019 18:46:12 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E05A5D720;
 Thu, 11 Jul 2019 18:46:12 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 3C4B51818485;
 Thu, 11 Jul 2019 18:46:12 +0000 (UTC)
Date: Thu, 11 Jul 2019 14:46:11 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1464566100.41069898.1562870771867.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190711134648-mutt-send-email-mst@kernel.org>
References: <20190710175832.17252-1-pagupta@redhat.com>
 <20190711134648-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH v2] virtio_pmem: fix sparse warning
MIME-Version: 1.0
X-Originating-IP: [10.67.116.73, 10.4.195.27]
Thread-Topic: virtio_pmem: fix sparse warning
Thread-Index: VglBfntAUfpmr8NxVnObWKSCyUc5eA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 11 Jul 2019 18:46:12 +0000 (UTC)
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
Cc: linux-nvdimm@lists.01.org, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 yuval shaia <yuval.shaia@oracle.com>,
 virtualization@lists.linux-foundation.org, lcapitulino@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


> 
> On Wed, Jul 10, 2019 at 11:28:32PM +0530, Pankaj Gupta wrote:
> > This patch fixes below sparse warning related to __virtio
> > type in virtio pmem driver. This is reported by Intel test
> > bot on linux-next tree.
> > 
> > nd_virtio.c:56:28: warning: incorrect type in assignment
> > 				(different base types)
> > nd_virtio.c:56:28:    expected unsigned int [unsigned] [usertype] type
> > nd_virtio.c:56:28:    got restricted __virtio32
> > nd_virtio.c:93:59: warning: incorrect type in argument 2
> > 				(different base types)
> > nd_virtio.c:93:59:    expected restricted __virtio32 [usertype] val
> > nd_virtio.c:93:59:    got unsigned int [unsigned] [usertype] ret
> > 
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> > 
> > This fixes a warning, so submitting it as a separate
> > patch on top of virtio pmem series.
> > 
> >  include/uapi/linux/virtio_pmem.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/uapi/linux/virtio_pmem.h
> > b/include/uapi/linux/virtio_pmem.h
> > index efcd72f2d20d..7a7435281362 100644
> > --- a/include/uapi/linux/virtio_pmem.h
> > +++ b/include/uapi/linux/virtio_pmem.h
> > @@ -10,7 +10,7 @@
> >  #ifndef _UAPI_LINUX_VIRTIO_PMEM_H
> >  #define _UAPI_LINUX_VIRTIO_PMEM_H
> >  
> > -#include <linux/types.h>
> > +#include <linux/virtio_types.h>
> >  #include <linux/virtio_ids.h>
> >  #include <linux/virtio_config.h>
> >  
> > @@ -23,12 +23,12 @@ struct virtio_pmem_config {
> >  
> >  struct virtio_pmem_resp {
> >  	/* Host return status corresponding to flush request */
> > -	__u32 ret;
> > +	__virtio32 ret;
> >  };
> >  
> >  struct virtio_pmem_req {
> >  	/* command type */
> > -	__u32 type;
> > +	__virtio32 type;
> >  };
> >  
> >  #endif
> 
> Same comment as previously: pls use __le and fix accessors.

Now, I think I got it. 

__virtio is for legacy devices to solve the endianess. 
By default virtio 1.0 and later are little endian.
Will send updated patch soon.

Thank you,
Pankaj

> 
> > --
> > 2.20.1
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
