Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A71C652
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 11:47:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6040E21275442;
	Tue, 14 May 2019 02:47:26 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 18B0E21CB74A4
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 02:47:23 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D76F308427C;
 Tue, 14 May 2019 09:47:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CA275D6A6;
 Tue, 14 May 2019 09:47:23 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id BDAEA18089CC;
 Tue, 14 May 2019 09:47:22 +0000 (UTC)
Date: Tue, 14 May 2019 05:47:22 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <712871093.28555872.1557827242385.JavaMail.zimbra@redhat.com>
In-Reply-To: <86298c2c-cc7c-5b97-0f11-335d7da8c450@redhat.com>
References: <20190510155202.14737-1-pagupta@redhat.com>
 <20190510155202.14737-3-pagupta@redhat.com>
 <f2ea35a6-ec98-447c-44fe-0cb3ab309340@redhat.com>
 <752392764.28554139.1557826022323.JavaMail.zimbra@redhat.com>
 <86298c2c-cc7c-5b97-0f11-335d7da8c450@redhat.com>
Subject: Re: [PATCH v8 2/6] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
X-Originating-IP: [10.65.16.148, 10.4.195.13]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: 8wNBImudyN2CQ1nMcWyCrDq+wnVDqg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 14 May 2019 09:47:23 +0000 (UTC)
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
 willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org,
 linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl,
 riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com,
 pbonzini@redhat.com, lcapitulino@redhat.com, kwolf@redhat.com,
 nilal@redhat.com, tytso@mit.edu,
 xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
 darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, imammedo@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


> 
> >>
> >>> +	}
> >>> +
> >>> +	/* When host has read buffer, this completes via host_ack */
> >>
> >> "A host repsonse results in "host_ack" getting called" ... ?
> >>
> >>> +	wait_event(req->host_acked, req->done);
> >>> +	err = req->ret;
> >>> +ret:
> >>> +	kfree(req);
> >>> +	return err;
> >>> +};
> >>> +
> >>> +/* The asynchronous flush callback function */
> >>> +int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> >>> +{
> >>> +	int rc = 0;
> >>> +
> >>> +	/* Create child bio for asynchronous flush and chain with
> >>> +	 * parent bio. Otherwise directly call nd_region flush.
> >>> +	 */
> >>> +	if (bio && bio->bi_iter.bi_sector != -1) {
> >>> +		struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> >>> +
> >>> +		if (!child)
> >>> +			return -ENOMEM;
> >>> +		bio_copy_dev(child, bio);
> >>> +		child->bi_opf = REQ_PREFLUSH;
> >>> +		child->bi_iter.bi_sector = -1;
> >>> +		bio_chain(child, bio);
> >>> +		submit_bio(child);
> >>
> >> return 0;
> >>
> >> Then, drop the "else" case and "int rc" and do directly
> >>
> >> if (virtio_pmem_flush(nd_region))
> >> 	return -EIO;
> > 
> > and another 'return 0' here :)
> > 
> > I don't like return from multiple places instead I prefer
> > single exit point from function.
> 
> Makes this function more complicated than necessary. I agree when there
> are locks involved.

o.k. I will change as you suggest :)

> 
> >  
> >>
> >>> +
> >>> +	return 0;
> >>> +};
> >>> +
> >>> +static int virtio_pmem_probe(struct virtio_device *vdev)
> >>> +{
> >>> +	int err = 0;
> >>> +	struct resource res;
> >>> +	struct virtio_pmem *vpmem;
> >>> +	struct nd_region_desc ndr_desc = {};
> >>> +	int nid = dev_to_node(&vdev->dev);
> >>> +	struct nd_region *nd_region;
> >>
> >> Nit: use reverse Christmas tree layout :)
> > 
> > Done.
> > 
> >>
> >>> +
> >>> +	if (!vdev->config->get) {
> >>> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> >>> +			__func__);
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	vpmem = devm_kzalloc(&vdev->dev, sizeof(*vpmem), GFP_KERNEL);
> >>> +	if (!vpmem) {
> >>> +		err = -ENOMEM;
> >>> +		goto out_err;
> >>> +	}
> >>> +
> >>> +	vpmem->vdev = vdev;
> >>> +	vdev->priv = vpmem;
> >>> +	err = init_vq(vpmem);
> >>> +	if (err)
> >>> +		goto out_err;
> >>> +
> >>> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> >>> +			start, &vpmem->start);
> >>> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> >>> +			size, &vpmem->size);
> >>> +
> >>> +	res.start = vpmem->start;
> >>> +	res.end   = vpmem->start + vpmem->size-1;
> >>> +	vpmem->nd_desc.provider_name = "virtio-pmem";
> >>> +	vpmem->nd_desc.module = THIS_MODULE;
> >>> +
> >>> +	vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev,
> >>> +						&vpmem->nd_desc);
> >>> +	if (!vpmem->nvdimm_bus)
> >>> +		goto out_vq;
> >>> +
> >>> +	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> >>> +
> >>> +	ndr_desc.res = &res;
> >>> +	ndr_desc.numa_node = nid;
> >>> +	ndr_desc.flush = async_pmem_flush;
> >>> +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> >>> +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> >>> +	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
> >>> +
> >>
> >> I'd drop this empty line.
> > 
> > hmm.
> > 
> 
> The common pattern after allocating something, immediately check for it
> in the next line (like you do throughout this patch ;) )

Right. But rare times when I see space will beauty the code I tend to
add it. Maybe I should not :)

> 
> ...
> >> You are not freeing "vdev->priv".
> > 
> > vdev->priv is vpmem which is allocated using devm API.
> 
> I'm confused. Looking at drivers/virtio/virtio_balloon.c:
> 
> static void virtballoon_remove(struct virtio_device *vdev)
> {
> 	struct virtio_balloon *vb = vdev->priv;
> 
> 	...
> 
> 	kfree(vb);
> }
> 
> I think you should do the same here, vdev->priv is allocated in
> virtio_pmem_probe.
> 
> But maybe I am missing something important here :)

Because virtio_balloon use "kzalloc" for allocation and needs to be freed. 
But virtio pmem uses "devm_kzalloc" which takes care of automatically deleting 
the device memory when associated device is detached.

Thanks,
Pankaj
> 
> >>
> >>> +	nvdimm_bus_unregister(nvdimm_bus);
> >>> +	vdev->config->del_vqs(vdev);
> >>> +	vdev->config->reset(vdev);
> >>> +}
> >>> +
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
