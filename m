Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5219E17D18
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 May 2019 17:23:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 750532124B907;
	Wed,  8 May 2019 08:23:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5B943211F9D4A
 for <linux-nvdimm@lists.01.org>; Wed,  8 May 2019 08:23:34 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 924EB3007149;
 Wed,  8 May 2019 15:23:33 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BE972E09B;
 Wed,  8 May 2019 15:23:33 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id B6B4B41F56;
 Wed,  8 May 2019 15:23:32 +0000 (UTC)
Date: Wed, 8 May 2019 11:23:32 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Jakub =?utf-8?Q?Staro=C5=84?= <jstaron@google.com>
Message-ID: <1482604497.27348783.1557329012320.JavaMail.zimbra@redhat.com>
In-Reply-To: <1555943483.27247564.1557313967518.JavaMail.zimbra@redhat.com>
References: <20190426050039.17460-1-pagupta@redhat.com>
 <20190426050039.17460-3-pagupta@redhat.com>
 <3d6479ae-6c39-d614-f1d9-aa1978e2e438@google.com>
 <1555943483.27247564.1557313967518.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 2/6] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
X-Originating-IP: [10.67.116.32, 10.4.195.26]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: PGqRBxt7ac04jwyhY+CEFoY6aRdKvNGTIbxd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 08 May 2019 15:23:33 +0000 (UTC)
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
 adilger kernel <adilger.kernel@dilger.ca>, smbarber@google.com,
 zwisler@kernel.org, aarcange@redhat.com, linux-nvdimm@lists.01.org,
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


> > 
> > > +int virtio_pmem_flush(struct nd_region *nd_region)
> > > +{
> > > +        int err;
> > > +        unsigned long flags;
> > > +        struct scatterlist *sgs[2], sg, ret;
> > > +        struct virtio_device *vdev = nd_region->provider_data;
> > > +        struct virtio_pmem *vpmem = vdev->priv;
> > > +        struct virtio_pmem_request *req;
> > > +
> > > +        might_sleep();
> > > +        req = kmalloc(sizeof(*req), GFP_KERNEL);
> > > +        if (!req)
> > > +                return -ENOMEM;
> > > +
> > > +        req->done = req->wq_buf_avail = false;
> > > +        strcpy(req->name, "FLUSH");
> > > +        init_waitqueue_head(&req->host_acked);
> > > +        init_waitqueue_head(&req->wq_buf);
> > > +        sg_init_one(&sg, req->name, strlen(req->name));
> > > +        sgs[0] = &sg;
> > > +        sg_init_one(&ret, &req->ret, sizeof(req->ret));
> > > +        sgs[1] = &ret;
> > > +
> > > +        spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > > +        err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req, GFP_ATOMIC);
> > > +        if (err) {
> > > +                dev_err(&vdev->dev, "failed to send command to virtio pmem device\n");
> > > +
> > > +                list_add_tail(&vpmem->req_list, &req->list);
> > > +                spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > > +
> > > +                /* When host has read buffer, this completes via host_ack */
> > > +                wait_event(req->wq_buf, req->wq_buf_avail);
> > > +                spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > > +        }
> > 
> > Aren't the arguments in `list_add_tail` swapped? The element we are adding
> 

Yes, arguments for 'list_add_tail' should be swapped.

list_add_tail(&req->list, &vpmem->req_list);


Thank you,
Pankaj
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
