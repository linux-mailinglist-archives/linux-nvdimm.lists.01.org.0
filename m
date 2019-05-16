Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E514200B0
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 09:54:20 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 14C882126CFAD;
	Thu, 16 May 2019 00:54:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=pagupta@redhat.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6F11C2125F1D5
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 00:54:17 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFF97308FC5F;
 Thu, 16 May 2019 07:54:16 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 872F45D772;
 Thu, 16 May 2019 07:54:16 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 11A561806B11;
 Thu, 16 May 2019 07:54:16 +0000 (UTC)
Date: Thu, 16 May 2019 03:54:15 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <1392189898.29183015.1557993255983.JavaMail.zimbra@redhat.com>
In-Reply-To: <1d6f6964-4653-ebf3-554f-666fda3779f1@redhat.com>
References: <20190514145422.16923-1-pagupta@redhat.com>
 <20190514145422.16923-3-pagupta@redhat.com>
 <9f6b1d8e-ef90-7d8b-56da-61a426953ba3@redhat.com>
 <1d6f6964-4653-ebf3-554f-666fda3779f1@redhat.com>
Subject: Re: [PATCH v9 2/7] virtio-pmem: Add virtio pmem driver
MIME-Version: 1.0
X-Originating-IP: [10.65.16.97, 10.4.195.28]
Thread-Topic: virtio-pmem: Add virtio pmem driver
Thread-Index: QMQNE7pgfu3mBYS2GC/vovrzij4mzg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 16 May 2019 07:54:17 +0000 (UTC)
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


> >> +	vpmem->vdev = vdev;
> >> +	vdev->priv = vpmem;
> >> +	err = init_vq(vpmem);
> >> +	if (err) {
> >> +		dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
> >> +		goto out_err;
> >> +	}
> >> +
> >> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> >> +			start, &vpmem->start);
> >> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> >> +			size, &vpmem->size);
> >> +
> >> +	res.start = vpmem->start;
> >> +	res.end   = vpmem->start + vpmem->size-1;
> > 
> > nit: " - 1;"
> > 
> >> +	vpmem->nd_desc.provider_name = "virtio-pmem";
> >> +	vpmem->nd_desc.module = THIS_MODULE;
> >> +
> >> +	vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev,
> >> +						&vpmem->nd_desc);
> >> +	if (!vpmem->nvdimm_bus) {
> >> +		dev_err(&vdev->dev, "failed to register device with nvdimm_bus\n");
> >> +		err = -ENXIO;
> >> +		goto out_vq;
> >> +	}
> >> +
> >> +	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> >> +
> >> +	ndr_desc.res = &res;
> >> +	ndr_desc.numa_node = nid;
> >> +	ndr_desc.flush = async_pmem_flush;
> >> +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> >> +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> >> +	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
> >> +	if (!nd_region) {
> >> +		dev_err(&vdev->dev, "failed to create nvdimm region\n");
> >> +		err = -ENXIO;
> >> +		goto out_nd;
> >> +	}
> >> +	nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
> >> +	return 0;
> >> +out_nd:
> >> +	nvdimm_bus_unregister(vpmem->nvdimm_bus);
> >> +out_vq:
> >> +	vdev->config->del_vqs(vdev);
> >> +out_err:
> >> +	return err;
> >> +}
> >> +
> >> +static void virtio_pmem_remove(struct virtio_device *vdev)
> >> +{
> >> +	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
> >> +
> >> +	nvdimm_bus_unregister(nvdimm_bus);
> >> +	vdev->config->del_vqs(vdev);
> >> +	vdev->config->reset(vdev);
> >> +}
> >> +
> >> +static struct virtio_driver virtio_pmem_driver = {
> >> +	.driver.name		= KBUILD_MODNAME,
> >> +	.driver.owner		= THIS_MODULE,
> >> +	.id_table		= id_table,
> >> +	.probe			= virtio_pmem_probe,
> >> +	.remove			= virtio_pmem_remove,
> >> +};
> >> +
> >> +module_virtio_driver(virtio_pmem_driver);
> >> +MODULE_DEVICE_TABLE(virtio, id_table);
> >> +MODULE_DESCRIPTION("Virtio pmem driver");
> >> +MODULE_LICENSE("GPL");
> >> diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
> >> new file mode 100644
> >> index 000000000000..ab1da877575d
> >> --- /dev/null
> >> +++ b/drivers/nvdimm/virtio_pmem.h
> >> @@ -0,0 +1,60 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * virtio_pmem.h: virtio pmem Driver
> >> + *
> >> + * Discovers persistent memory range information
> >> + * from host and provides a virtio based flushing
> >> + * interface.
> >> + **/
> >> +
> >> +#ifndef _LINUX_VIRTIO_PMEM_H
> >> +#define _LINUX_VIRTIO_PMEM_H
> >> +
> >> +#include <linux/virtio_ids.h>
> >> +#include <linux/module.h>
> >> +#include <linux/virtio_config.h>
> >> +#include <uapi/linux/virtio_pmem.h>
> >> +#include <linux/libnvdimm.h>
> >> +#include <linux/spinlock.h>
> >> +
> >> +struct virtio_pmem_request {
> >> +	/* Host return status corresponding to flush request */
> >> +	int ret;
> >> +
> >> +	/* command name*/
> >> +	char name[16];
> > 
> > So ... why are we sending string commands and expect native-endianess
> > integers and don't define a proper request/response structure + request
> > types in include/uapi/linux/virtio_pmem.h like
> > 
> > struct virtio_pmem_resp {
> > 	__virtio32 ret;
> > }
> 
> FWIW, I wonder if we should even properly translate return values and
> define types like
> 
> VIRTIO_PMEM_RESP_TYPE_OK	0
> VIRTIO_PMEM_RESP_TYPE_EIO	1

Don't think these are required as only failure and success
return types easy to understand.

Thanks,
Pankaj
> 
> ..
> 
> > 
> > #define VIRTIO_PMEM_REQ_TYPE_FLUSH	1
> > struct virtio_pmem_req {
> > 	__virtio16 type;
> > }
> > 
> > ... and this way we also define a proper endianess format for exchange
> > and keep it extensible
> > 
> > @MST, what's your take on this?
> > 
> > 
> 
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
