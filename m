Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943C41FBC5
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 22:53:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B9622212794B1;
	Wed, 15 May 2019 13:53:10 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=david@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A173221268FBE
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 13:53:08 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8B8B309264F;
 Wed, 15 May 2019 20:53:07 +0000 (UTC)
Received: from [10.36.116.133] (ovpn-116-133.ams2.redhat.com [10.36.116.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C08460BE5;
 Wed, 15 May 2019 20:52:54 +0000 (UTC)
Subject: Re: [PATCH v9 2/7] virtio-pmem: Add virtio pmem driver
From: David Hildenbrand <david@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-acpi@vger.kernel.org, qemu-devel@nongnu.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, mst@redhat.com
References: <20190514145422.16923-1-pagupta@redhat.com>
 <20190514145422.16923-3-pagupta@redhat.com>
 <9f6b1d8e-ef90-7d8b-56da-61a426953ba3@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <1d6f6964-4653-ebf3-554f-666fda3779f1@redhat.com>
Date: Wed, 15 May 2019 22:52:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9f6b1d8e-ef90-7d8b-56da-61a426953ba3@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 15 May 2019 20:53:08 +0000 (UTC)
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
Cc: jack@suse.cz, jasowang@redhat.com, david@fromorbit.com,
 lcapitulino@redhat.com, adilger.kernel@dilger.ca, zwisler@kernel.org,
 aarcange@redhat.com, jstaron@google.com, darrick.wong@oracle.com,
 willy@infradead.org, hch@infradead.org, nilal@redhat.com, lenb@kernel.org,
 kilobyte@angband.pl, riel@surriel.com, yuval.shaia@oracle.com,
 stefanha@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, tytso@mit.edu,
 xiaoguangrong.eric@gmail.com, cohuck@redhat.com, rjw@rjwysocki.net,
 imammedo@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 15.05.19 22:46, David Hildenbrand wrote:
>> +	vpmem->vdev = vdev;
>> +	vdev->priv = vpmem;
>> +	err = init_vq(vpmem);
>> +	if (err) {
>> +		dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
>> +		goto out_err;
>> +	}
>> +
>> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
>> +			start, &vpmem->start);
>> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
>> +			size, &vpmem->size);
>> +
>> +	res.start = vpmem->start;
>> +	res.end   = vpmem->start + vpmem->size-1;
> 
> nit: " - 1;"
> 
>> +	vpmem->nd_desc.provider_name = "virtio-pmem";
>> +	vpmem->nd_desc.module = THIS_MODULE;
>> +
>> +	vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev,
>> +						&vpmem->nd_desc);
>> +	if (!vpmem->nvdimm_bus) {
>> +		dev_err(&vdev->dev, "failed to register device with nvdimm_bus\n");
>> +		err = -ENXIO;
>> +		goto out_vq;
>> +	}
>> +
>> +	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
>> +
>> +	ndr_desc.res = &res;
>> +	ndr_desc.numa_node = nid;
>> +	ndr_desc.flush = async_pmem_flush;
>> +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
>> +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
>> +	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
>> +	if (!nd_region) {
>> +		dev_err(&vdev->dev, "failed to create nvdimm region\n");
>> +		err = -ENXIO;
>> +		goto out_nd;
>> +	}
>> +	nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
>> +	return 0;
>> +out_nd:
>> +	nvdimm_bus_unregister(vpmem->nvdimm_bus);
>> +out_vq:
>> +	vdev->config->del_vqs(vdev);
>> +out_err:
>> +	return err;
>> +}
>> +
>> +static void virtio_pmem_remove(struct virtio_device *vdev)
>> +{
>> +	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
>> +
>> +	nvdimm_bus_unregister(nvdimm_bus);
>> +	vdev->config->del_vqs(vdev);
>> +	vdev->config->reset(vdev);
>> +}
>> +
>> +static struct virtio_driver virtio_pmem_driver = {
>> +	.driver.name		= KBUILD_MODNAME,
>> +	.driver.owner		= THIS_MODULE,
>> +	.id_table		= id_table,
>> +	.probe			= virtio_pmem_probe,
>> +	.remove			= virtio_pmem_remove,
>> +};
>> +
>> +module_virtio_driver(virtio_pmem_driver);
>> +MODULE_DEVICE_TABLE(virtio, id_table);
>> +MODULE_DESCRIPTION("Virtio pmem driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
>> new file mode 100644
>> index 000000000000..ab1da877575d
>> --- /dev/null
>> +++ b/drivers/nvdimm/virtio_pmem.h
>> @@ -0,0 +1,60 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * virtio_pmem.h: virtio pmem Driver
>> + *
>> + * Discovers persistent memory range information
>> + * from host and provides a virtio based flushing
>> + * interface.
>> + **/
>> +
>> +#ifndef _LINUX_VIRTIO_PMEM_H
>> +#define _LINUX_VIRTIO_PMEM_H
>> +
>> +#include <linux/virtio_ids.h>
>> +#include <linux/module.h>
>> +#include <linux/virtio_config.h>
>> +#include <uapi/linux/virtio_pmem.h>
>> +#include <linux/libnvdimm.h>
>> +#include <linux/spinlock.h>
>> +
>> +struct virtio_pmem_request {
>> +	/* Host return status corresponding to flush request */
>> +	int ret;
>> +
>> +	/* command name*/
>> +	char name[16];
> 
> So ... why are we sending string commands and expect native-endianess
> integers and don't define a proper request/response structure + request
> types in include/uapi/linux/virtio_pmem.h like
> 
> struct virtio_pmem_resp {
> 	__virtio32 ret;
> }

FWIW, I wonder if we should even properly translate return values and
define types like

VIRTIO_PMEM_RESP_TYPE_OK	0
VIRTIO_PMEM_RESP_TYPE_EIO	1

..

> 
> #define VIRTIO_PMEM_REQ_TYPE_FLUSH	1
> struct virtio_pmem_req {
> 	__virtio16 type;
> }
> 
> ... and this way we also define a proper endianess format for exchange
> and keep it extensible
> 
> @MST, what's your take on this?
> 
> 


-- 

Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
