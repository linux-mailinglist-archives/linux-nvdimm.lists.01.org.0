Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D92489E2DA
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Aug 2019 10:39:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 959D820216B63;
	Tue, 27 Aug 2019 01:42:06 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=cohuck@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D90BA20215F75
 for <linux-nvdimm@lists.01.org>; Tue, 27 Aug 2019 01:42:05 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5160F18C4272;
 Tue, 27 Aug 2019 08:39:54 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EED1E60923;
 Tue, 27 Aug 2019 08:39:45 +0000 (UTC)
Date: Tue, 27 Aug 2019 10:39:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 05/19] virtio: Implement get_shm_region for MMIO transport
Message-ID: <20190827103943.4c6c9342.cohuck@redhat.com>
In-Reply-To: <20190821175720.25901-6-vgoyal@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-6-vgoyal@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 27 Aug 2019 08:39:54 +0000 (UTC)
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
Cc: kvm@vger.kernel.org, miklos@szeredi.hu, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, dgilbert@redhat.com, virtio-fs@redhat.com,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, 21 Aug 2019 13:57:06 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> 
> On MMIO a new set of registers is defined for finding SHM
> regions.  Add their definitions and use them to find the region.
> 
> Cc: kvm@vger.kernel.org
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> ---
>  drivers/virtio/virtio_mmio.c     | 32 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_mmio.h | 11 +++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index e09edb5c5e06..5c07985c8cb8 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -500,6 +500,37 @@ static const char *vm_bus_name(struct virtio_device *vdev)
>  	return vm_dev->pdev->name;
>  }
>  
> +static bool vm_get_shm_region(struct virtio_device *vdev,
> +			      struct virtio_shm_region *region, u8 id)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	u64 len, addr;
> +
> +	/* Select the region we're interested in */
> +	writel(id, vm_dev->base + VIRTIO_MMIO_SHM_SEL);
> +
> +	/* Read the region size */
> +	len = (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_LOW);
> +	len |= (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_HIGH) << 32;
> +
> +	region->len = len;
> +
> +	/* Check if region length is -1. If that's the case, the shared memory
> +	 * region does not exist and there is no need to proceed further.
> +	 */
> +	if (len == ~(u64)0) {
> +		return false;
> +	}

I think the curly braces should be dropped here.

> +
> +	/* Read the region base address */
> +	addr = (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_LOW);
> +	addr |= (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_HIGH) << 32;
> +
> +	region->addr = addr;
> +
> +	return true;
> +}
> +
>  static const struct virtio_config_ops virtio_mmio_config_ops = {
>  	.get		= vm_get,
>  	.set		= vm_set,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
