Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C78422FE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Jun 2019 12:50:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 348DB21295CB9;
	Wed, 12 Jun 2019 03:50:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F0AD021295CAA
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 03:50:50 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6E5BBC057F2C;
 Wed, 12 Jun 2019 10:50:39 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C07D795AD;
 Wed, 12 Jun 2019 10:50:37 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id BDF7E1806B16;
 Wed, 12 Jun 2019 10:50:34 +0000 (UTC)
Date: Wed, 12 Jun 2019 06:50:34 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <977172256.34591602.1560336634257.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190612083711.2c0cfd7e.cohuck@redhat.com>
References: <20190611163802.25352-1-pagupta@redhat.com>
 <20190611163802.25352-3-pagupta@redhat.com>
 <20190611190209.0b25033e.cohuck@redhat.com>
 <1003601865.34513553.1560310490030.JavaMail.zimbra@redhat.com>
 <20190612083711.2c0cfd7e.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 2/7] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
X-Originating-IP: [10.67.116.228, 10.4.195.25]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: JA2T0z0G1tIHKmlJmlUYn7dmJ8rB0Q==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 12 Jun 2019 10:50:44 +0000 (UTC)
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
Cc: jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 david@fromorbit.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
 adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org,
 aarcange@redhat.com, jstaron@google.com, linux-nvdimm@lists.01.org,
 david@redhat.com, willy@infradead.org, hch@infradead.org,
 linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org, lenb@kernel.org,
 kilobyte@angband.pl, riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>,
 stefanha@redhat.com, imammedo@redhat.com, lcapitulino@redhat.com,
 kwolf@redhat.com, nilal@redhat.com, tytso@mit.edu,
 xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, snitzer@redhat.com,
 rdunlap@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, pbonzini@redhat.com,
 darrick wong <darrick.wong@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


> 
> Hi Pankaj,
> 
> On Tue, 11 Jun 2019 23:34:50 -0400 (EDT)
> Pankaj Gupta <pagupta@redhat.com> wrote:
> 
> > Hi Cornelia,
> > 
> > > On Tue, 11 Jun 2019 22:07:57 +0530
> > > Pankaj Gupta <pagupta@redhat.com> wrote:
> 
> 
> > > > +	err1 = virtqueue_kick(vpmem->req_vq);
> > > > +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > > > +	/*
> > > > +	 * virtqueue_add_sgs failed with error different than -ENOSPC, we
> > > > can't
> > > > +	 * do anything about that.
> > > > +	 */
> > > 
> > > Does it make sense to kick if you couldn't add at all?
> > 
> > When we could not add because of -ENOSPC we are waiting and when buffer is
> > added
> > then only we do a kick. For any other error which might be a rare
> > occurrence, I think
> > kick is harmless here and keeps the code clean?
> 
> Yes, I agree it does not hurt. Let's keep it as-is.

Sure.

> 
> 
> > Sure, Thank you. Attaching below on top changes on current patch2 based on
> > your suggestions. Let me know if these are okay and then will send official
> > v13 to for upstream merging.
> 
> Looks good to me, except for one change.

Sure. Will send v13 shortly.

> 
> [Again sorry for the late review, did not want to get the version
> numbers up :)]

Thank you :)

> 
> > 
> > Thanks,
> > Pankaj
> > 
> > ===============
> > 
> > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > index efc535723517..5b8d2367da0b 100644
> > --- a/drivers/nvdimm/nd_virtio.c
> > +++ b/drivers/nvdimm/nd_virtio.c
> > @@ -10,7 +10,7 @@
> >  #include "nd.h"
> >  
> >   /* The interrupt handler */
> > -void host_ack(struct virtqueue *vq)
> > +void virtio_pmem_host_ack(struct virtqueue *vq)
> >  {
> >         struct virtio_pmem *vpmem = vq->vdev->priv;
> >         struct virtio_pmem_request *req_data, *req_buf;
> > @@ -32,10 +32,10 @@ void host_ack(struct virtqueue *vq)
> >         }
> >         spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> >  }
> > -EXPORT_SYMBOL_GPL(host_ack);
> > +EXPORT_SYMBOL_GPL(virtio_pmem_host_ack);
> >  
> >   /* The request submission function */
> > -int virtio_pmem_flush(struct nd_region *nd_region)
> > +static int virtio_pmem_flush(struct nd_region *nd_region)
> >  {
> >         struct virtio_device *vdev = nd_region->provider_data;
> >         struct virtio_pmem *vpmem  = vdev->priv;
> > @@ -69,7 +69,7 @@ int virtio_pmem_flush(struct nd_region *nd_region)
> >         while ((err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req_data,
> >                                         GFP_ATOMIC)) == -ENOSPC) {
> >  
> > -               dev_err(&vdev->dev, "failed to send command to virtio pmem
> > device, no free slots in the virtqueue\n");
> > +               dev_info(&vdev->dev, "failed to send command to virtio pmem
> > device, no free slots in the virtqueue\n");
> >                 req_data->wq_buf_avail = false;
> >                 list_add_tail(&req_data->list, &vpmem->req_list);
> >                 spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > @@ -90,7 +90,8 @@ int virtio_pmem_flush(struct nd_region *nd_region)
> >         } else {
> >                 /* A host repsonse results in "host_ack" getting called */
> >                 wait_event(req_data->host_acked, req_data->done);
> > -               err = virtio32_to_cpu(vdev, req_data->resp.ret);
> > +               if ((err = virtio32_to_cpu(vdev, req_data->resp.ret)))
> > +                       err = -EIO;
> 
> Hm, why are you making this change? I think the previous code was fine.

Yes, Something came to my mind while making the change but I agree will keep
this as it was before.

> 
> >         }
> >  
> >         kfree(req_data);
> > @@ -100,7 +101,8 @@ int virtio_pmem_flush(struct nd_region *nd_region)
> >  /* The asynchronous flush callback function */
> >  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> >  {
> > -       /* Create child bio for asynchronous flush and chain with
> > +       /*
> > +        * Create child bio for asynchronous flush and chain with
> >          * parent bio. Otherwise directly call nd_region flush.
> >          */
> >         if (bio && bio->bi_iter.bi_sector != -1) {
> > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> > index b60ebd8cd2fd..5e3d07b47e0c 100644
> > --- a/drivers/nvdimm/virtio_pmem.c
> > +++ b/drivers/nvdimm/virtio_pmem.c
> > @@ -19,7 +19,7 @@ static int init_vq(struct virtio_pmem *vpmem)
> >  {
> >         /* single vq */
> >         vpmem->req_vq = virtio_find_single_vq(vpmem->vdev,
> > -                                               host_ack, "flush_queue");
> > +                                       virtio_pmem_host_ack,
> > "flush_queue");
> >         if (IS_ERR(vpmem->req_vq))
> >                 return PTR_ERR(vpmem->req_vq);
> >  
> > diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
> > index 6e47521be158..998efbc7660c 100644
> > --- a/drivers/nvdimm/virtio_pmem.h
> > +++ b/drivers/nvdimm/virtio_pmem.h
> > @@ -50,6 +50,6 @@ struct virtio_pmem {
> >         uint64_t size;
> >  };
> >  
> > -void host_ack(struct virtqueue *vq);
> > +void virtio_pmem_host_ack(struct virtqueue *vq);
> >  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio);
> >  #endif
> 
> 
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
