Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A45F01A
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Apr 2019 07:54:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D5B9E2122CA82;
	Mon, 29 Apr 2019 22:54:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=yuval.shaia@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B46052122C31E
 for <linux-nvdimm@lists.01.org>; Mon, 29 Apr 2019 22:54:07 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U5nB3R017607;
 Tue, 30 Apr 2019 05:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=0+Ztc7MxmMx2En7WPFjNOMWhu+FCjOzTw1+URGEyrhM=;
 b=iZ7BnNYqZTF1kIad2hVRL1QZGN1uu3Ptby/zY1nL/g+ATLcALnl2vrgWZeL0Xk+2+ook
 wfIjli7AhdZXoTNBcXW8u6Etun2w/g7rHnY+AU1b0P1ysCfjjLioAPEAjbayAK95kLEh
 6lI8VZxK8XVi/5Cvs+FMoOZoLn3N2kBNuPDgP1XkRFX0BDuUJdtZHhUQmFBeObZ/GWkw
 1Cr6mPH6P08XaAAkmN8JOavhjvtURFO9qf2W87wvkgkLfgE7dH21kNrYCONwddKLGmRb
 u1Tlh1n1EmW3db6zWj0gD3NDMslHczz3RUxor7r9yMdkHkyKhpbiJO4ootJKW+fmhMpD sA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2s5j5txyc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Apr 2019 05:53:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U5rIsv039596;
 Tue, 30 Apr 2019 05:53:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2s5u50sqyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Apr 2019 05:53:42 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3U5rbvs029036;
 Tue, 30 Apr 2019 05:53:37 GMT
Received: from lap1 (/10.175.49.49) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 29 Apr 2019 22:53:37 -0700
Date: Tue, 30 Apr 2019 08:53:19 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
To: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 2/6] virtio-pmem: Add virtio pmem driver
Message-ID: <20190430055318.GA5108@lap1>
References: <20190426050039.17460-1-pagupta@redhat.com>
 <20190426050039.17460-3-pagupta@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190426050039.17460-3-pagupta@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300040
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300039
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
 virtualization@lists.linux-foundation.org, adilger.kernel@dilger.ca,
 zwisler@kernel.org, aarcange@redhat.com, linux-nvdimm@lists.01.org,
 david@redhat.com, willy@infradead.org, hch@infradead.org,
 linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org, lenb@kernel.org,
 kilobyte@angband.pl, riel@surriel.com, stefanha@redhat.com,
 imammedo@redhat.com, lcapitulino@redhat.com, kwolf@redhat.com,
 nilal@redhat.com, tytso@mit.edu, xiaoguangrong.eric@gmail.com,
 darrick.wong@oracle.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Apr 26, 2019 at 10:30:35AM +0530, Pankaj Gupta wrote:
> This patch adds virtio-pmem driver for KVM guest.
> 
> Guest reads the persistent memory range information from
> Qemu over VIRTIO and registers it on nvdimm_bus. It also
> creates a nd_region object with the persistent memory
> range information so that existing 'nvdimm/pmem' driver
> can reserve this into system memory map. This way
> 'virtio-pmem' driver uses existing functionality of pmem
> driver to register persistent memory compatible for DAX
> capable filesystems.
> 
> This also provides function to perform guest flush over
> VIRTIO from 'pmem' driver when userspace performs flush
> on DAX memory range.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/nvdimm/virtio_pmem.c     | 114 +++++++++++++++++++++++++++++
>  drivers/virtio/Kconfig           |  10 +++
>  drivers/virtio/Makefile          |   1 +
>  drivers/virtio/pmem.c            | 118 +++++++++++++++++++++++++++++++
>  include/linux/virtio_pmem.h      |  60 ++++++++++++++++
>  include/uapi/linux/virtio_ids.h  |   1 +
>  include/uapi/linux/virtio_pmem.h |  10 +++
>  7 files changed, 314 insertions(+)
>  create mode 100644 drivers/nvdimm/virtio_pmem.c
>  create mode 100644 drivers/virtio/pmem.c
>  create mode 100644 include/linux/virtio_pmem.h
>  create mode 100644 include/uapi/linux/virtio_pmem.h
> 
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> new file mode 100644
> index 000000000000..66b582f751a3
> --- /dev/null
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * virtio_pmem.c: Virtio pmem Driver
> + *
> + * Discovers persistent memory range information
> + * from host and provides a virtio based flushing
> + * interface.
> + */
> +#include <linux/virtio_pmem.h>
> +#include "nd.h"
> +
> + /* The interrupt handler */
> +void host_ack(struct virtqueue *vq)
> +{
> +	unsigned int len;
> +	unsigned long flags;
> +	struct virtio_pmem_request *req, *req_buf;
> +	struct virtio_pmem *vpmem = vq->vdev->priv;
> +
> +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
> +	while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
> +		req->done = true;
> +		wake_up(&req->host_acked);
> +
> +		if (!list_empty(&vpmem->req_list)) {
> +			req_buf = list_first_entry(&vpmem->req_list,
> +					struct virtio_pmem_request, list);
> +			list_del(&vpmem->req_list);
> +			req_buf->wq_buf_avail = true;
> +			wake_up(&req_buf->wq_buf);
> +		}
> +	}
> +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(host_ack);
> +
> + /* The request submission function */
> +int virtio_pmem_flush(struct nd_region *nd_region)
> +{
> +	int err;
> +	unsigned long flags;
> +	struct scatterlist *sgs[2], sg, ret;
> +	struct virtio_device *vdev = nd_region->provider_data;
> +	struct virtio_pmem *vpmem = vdev->priv;
> +	struct virtio_pmem_request *req;
> +
> +	might_sleep();
> +	req = kmalloc(sizeof(*req), GFP_KERNEL);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	req->done = req->wq_buf_avail = false;
> +	strcpy(req->name, "FLUSH");
> +	init_waitqueue_head(&req->host_acked);
> +	init_waitqueue_head(&req->wq_buf);
> +	sg_init_one(&sg, req->name, strlen(req->name));
> +	sgs[0] = &sg;
> +	sg_init_one(&ret, &req->ret, sizeof(req->ret));
> +	sgs[1] = &ret;
> +
> +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
> +	err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req, GFP_ATOMIC);
> +	if (err) {
> +		dev_err(&vdev->dev, "failed to send command to virtio pmem device\n");
> +
> +		list_add_tail(&vpmem->req_list, &req->list);
> +		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +
> +		/* When host has read buffer, this completes via host_ack */
> +		wait_event(req->wq_buf, req->wq_buf_avail);
> +		spin_lock_irqsave(&vpmem->pmem_lock, flags);
> +	}
> +	err = virtqueue_kick(vpmem->req_vq);
> +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +
> +	if (!err) {
> +		err = -EIO;
> +		goto ret;
> +	}
> +	/* When host has read buffer, this completes via host_ack */
> +	wait_event(req->host_acked, req->done);
> +	err = req->ret;
> +ret:
> +	kfree(req);
> +	return err;
> +};
> +
> + /* The asynchronous flush callback function */
> +int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> +{
> +	int rc = 0;
> +
> +	/* Create child bio for asynchronous flush and chain with
> +	 * parent bio. Otherwise directly call nd_region flush.
> +	 */
> +	if (bio && bio->bi_iter.bi_sector != -1) {
> +		struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> +
> +		if (!child)
> +			return -ENOMEM;
> +		bio_copy_dev(child, bio);
> +		child->bi_opf = REQ_PREFLUSH;
> +		child->bi_iter.bi_sector = -1;
> +		bio_chain(child, bio);
> +		submit_bio(child);
> +	} else {
> +		if (virtio_pmem_flush(nd_region))
> +			rc = -EIO;
> +	}
> +
> +	return rc;
> +};
> +EXPORT_SYMBOL_GPL(async_pmem_flush);
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 35897649c24f..9f634a2ed638 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -42,6 +42,16 @@ config VIRTIO_PCI_LEGACY
>  
>  	  If unsure, say Y.
>  
> +config VIRTIO_PMEM
> +	tristate "Support for virtio pmem driver"
> +	depends on VIRTIO
> +	depends on LIBNVDIMM
> +	help
> +	This driver provides support for virtio based flushing interface
> +	for persistent memory range.
> +
> +	If unsure, say M.
> +
>  config VIRTIO_BALLOON
>  	tristate "Virtio balloon driver"
>  	depends on VIRTIO
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 3a2b5c5dcf46..143ce91eabe9 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -6,3 +6,4 @@ virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
>  virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
>  obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
>  obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
> +obj-$(CONFIG_VIRTIO_PMEM) += pmem.o ../nvdimm/virtio_pmem.o
> diff --git a/drivers/virtio/pmem.c b/drivers/virtio/pmem.c
> new file mode 100644
> index 000000000000..309788628e41
> --- /dev/null
> +++ b/drivers/virtio/pmem.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * virtio_pmem.c: Virtio pmem Driver
> + *
> + * Discovers persistent memory range information
> + * from host and registers the virtual pmem device
> + * with libnvdimm core.
> + */
> +#include <linux/virtio_pmem.h>
> +#include <../../drivers/nvdimm/nd.h>
> +
> +static struct virtio_device_id id_table[] = {
> +	{ VIRTIO_ID_PMEM, VIRTIO_DEV_ANY_ID },
> +	{ 0 },
> +};
> +
> + /* Initialize virt queue */
> +static int init_vq(struct virtio_pmem *vpmem)
> +{
> +	/* single vq */
> +	vpmem->req_vq = virtio_find_single_vq(vpmem->vdev,
> +				host_ack, "flush_queue");
> +	if (IS_ERR(vpmem->req_vq))
> +		return PTR_ERR(vpmem->req_vq);
> +
> +	spin_lock_init(&vpmem->pmem_lock);
> +	INIT_LIST_HEAD(&vpmem->req_list);
> +
> +	return 0;
> +};
> +
> +static int virtio_pmem_probe(struct virtio_device *vdev)
> +{
> +	int err = 0;
> +	struct resource res;
> +	struct virtio_pmem *vpmem;
> +	struct nd_region_desc ndr_desc = {};
> +	int nid = dev_to_node(&vdev->dev);
> +	struct nd_region *nd_region;
> +
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	vpmem = devm_kzalloc(&vdev->dev, sizeof(*vpmem), GFP_KERNEL);
> +	if (!vpmem) {
> +		err = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	vpmem->vdev = vdev;
> +	vdev->priv = vpmem;
> +	err = init_vq(vpmem);
> +	if (err)
> +		goto out_err;
> +
> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> +			start, &vpmem->start);
> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> +			size, &vpmem->size);
> +
> +	res.start = vpmem->start;
> +	res.end   = vpmem->start + vpmem->size-1;
> +	vpmem->nd_desc.provider_name = "virtio-pmem";
> +	vpmem->nd_desc.module = THIS_MODULE;
> +
> +	vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev,
> +						&vpmem->nd_desc);
> +	if (!vpmem->nvdimm_bus)
> +		goto out_vq;
> +
> +	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
> +
> +	ndr_desc.res = &res;
> +	ndr_desc.numa_node = nid;
> +	ndr_desc.flush = async_pmem_flush;
> +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
> +	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
> +
> +	if (!nd_region)
> +		goto out_nd;
> +	nd_region->provider_data =  dev_to_virtio

Delete extra space here ----------^^
I think this will let you join the two lines.

> +					(nd_region->dev.parent->parent);
> +	return 0;
> +out_nd:
> +	err = -ENXIO;
> +	nvdimm_bus_unregister(vpmem->nvdimm_bus);
> +out_vq:
> +	vdev->config->del_vqs(vdev);
> +out_err:
> +	dev_err(&vdev->dev, "failed to register virtio pmem memory\n");
> +	return err;
> +}
> +
> +static void virtio_pmem_remove(struct virtio_device *vdev)
> +{
> +	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
> +
> +	nvdimm_bus_unregister(nvdimm_bus);
> +	vdev->config->del_vqs(vdev);
> +	vdev->config->reset(vdev);
> +}
> +
> +static struct virtio_driver virtio_pmem_driver = {
> +	.driver.name		= KBUILD_MODNAME,
> +	.driver.owner		= THIS_MODULE,
> +	.id_table		= id_table,
> +	.probe			= virtio_pmem_probe,
> +	.remove			= virtio_pmem_remove,
> +};
> +
> +module_virtio_driver(virtio_pmem_driver);
> +MODULE_DEVICE_TABLE(virtio, id_table);
> +MODULE_DESCRIPTION("Virtio pmem driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/virtio_pmem.h b/include/linux/virtio_pmem.h
> new file mode 100644
> index 000000000000..ab1da877575d
> --- /dev/null
> +++ b/include/linux/virtio_pmem.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * virtio_pmem.h: virtio pmem Driver
> + *
> + * Discovers persistent memory range information
> + * from host and provides a virtio based flushing
> + * interface.
> + **/
> +
> +#ifndef _LINUX_VIRTIO_PMEM_H
> +#define _LINUX_VIRTIO_PMEM_H
> +
> +#include <linux/virtio_ids.h>
> +#include <linux/module.h>
> +#include <linux/virtio_config.h>
> +#include <uapi/linux/virtio_pmem.h>
> +#include <linux/libnvdimm.h>
> +#include <linux/spinlock.h>
> +
> +struct virtio_pmem_request {
> +	/* Host return status corresponding to flush request */
> +	int ret;
> +
> +	/* command name*/
> +	char name[16];
> +
> +	/* Wait queue to process deferred work after ack from host */
> +	wait_queue_head_t host_acked;
> +	bool done;
> +
> +	/* Wait queue to process deferred work after virt queue buffer avail */
> +	wait_queue_head_t wq_buf;
> +	bool wq_buf_avail;
> +	struct list_head list;
> +};
> +
> +struct virtio_pmem {
> +	struct virtio_device *vdev;
> +
> +	/* Virtio pmem request queue */
> +	struct virtqueue *req_vq;
> +
> +	/* nvdimm bus registers virtio pmem device */
> +	struct nvdimm_bus *nvdimm_bus;
> +	struct nvdimm_bus_descriptor nd_desc;
> +
> +	/* List to store deferred work if virtqueue is full */
> +	struct list_head req_list;
> +
> +	/* Synchronize virtqueue data */
> +	spinlock_t pmem_lock;
> +
> +	/* Memory region information */
> +	uint64_t start;
> +	uint64_t size;
> +};
> +
> +void host_ack(struct virtqueue *vq);
> +int async_pmem_flush(struct nd_region *nd_region, struct bio *bio);
> +#endif
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index 6d5c3b2d4f4d..32b2f94d1f58 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -43,5 +43,6 @@
>  #define VIRTIO_ID_INPUT        18 /* virtio input */
>  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
>  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> +#define VIRTIO_ID_PMEM         27 /* virtio pmem */
>  
>  #endif /* _LINUX_VIRTIO_IDS_H */
> diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
> new file mode 100644
> index 000000000000..fa3f7d52717a
> --- /dev/null
> +++ b/include/uapi/linux/virtio_pmem.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _UAPI_LINUX_VIRTIO_PMEM_H
> +#define _UAPI_LINUX_VIRTIO_PMEM_H
> +
> +struct virtio_pmem_config {
> +	__le64 start;
> +	__le64 size;
> +};
> +#endif

Suggesting to fix the above minor formatting error.

With this:

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>

> -- 
> 2.20.1
> 
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
