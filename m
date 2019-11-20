Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A62DC10420D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Nov 2019 18:26:31 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 30BC2100DC2AF;
	Wed, 20 Nov 2019 09:27:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B2424100DC2A8
	for <linux-nvdimm@lists.01.org>; Wed, 20 Nov 2019 09:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1574270785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7t5VREsrL6wOeWEU8/Ixa0IaxMqmj2iSmqDhC9ITcg=;
	b=QYmK3XWaY2W/y2+HAJ3wleXYM340N/qS6uESXZCQm0Lf+ZbG/EUZgxS0xLEMwE0gIYT58T
	jCb8xtNgwDSaBoPYI+KBLC6mH5625Q51zK5jsnbxhyphLhWEkDnMK2rIiv3EBuCQLCP/TF
	HuG5L6yAczzVaZVFpnJC1cBhH/zZi2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-WBAaGR23OyO_4ZjwI9cbdA-1; Wed, 20 Nov 2019 12:26:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0A5F100550E;
	Wed, 20 Nov 2019 17:26:19 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 77C885D6BE;
	Wed, 20 Nov 2019 17:26:18 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
References: <20191120092831.6198-1-pagupta@redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Wed, 20 Nov 2019 12:26:17 -0500
In-Reply-To: <20191120092831.6198-1-pagupta@redhat.com> (Pankaj Gupta's
	message of "Wed, 20 Nov 2019 14:58:31 +0530")
Message-ID: <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WBAaGR23OyO_4ZjwI9cbdA-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: W4NBT4JGNBGM2HXMEJMAS2JRXPMVFLHL
X-Message-ID-Hash: W4NBT4JGNBGM2HXMEJMAS2JRXPMVFLHL
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W4NBT4JGNBGM2HXMEJMAS2JRXPMVFLHL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Pankaj Gupta <pagupta@redhat.com> writes:

>  Remove logic to create child bio in the async flush function which
>  causes child bio to get executed after parent bio 'pmem_make_request'
>  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
>  data write request.
>
>  Instead we are performing flush from the parent bio to maintain the
>  correct order. Also, returning from function 'pmem_make_request' if
>  REQ_PREFLUSH returns an error.
>
> Reported-by: Jeff Moyer <jmoyer@redhat.com>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

There's a slight change in behavior for the error path in the
virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
converted to -EIO.  Now, they are reported as-is.  I think this is
actually an improvement.

I'll also note that the current behavior can result in data corruption,
so this should be tagged for stable.

The patch looks good to me.

Thanks!

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

> ---
>  drivers/acpi/nfit/core.c     |  4 ++--
>  drivers/nvdimm/claim.c       |  2 +-
>  drivers/nvdimm/nd.h          |  2 +-
>  drivers/nvdimm/nd_virtio.c   | 29 ++---------------------------
>  drivers/nvdimm/pmem.c        | 14 ++++++++++----
>  drivers/nvdimm/region_devs.c |  6 +++---
>  drivers/nvdimm/virtio_pmem.c |  2 +-
>  drivers/nvdimm/virtio_pmem.h |  2 +-
>  include/linux/libnvdimm.h    |  4 ++--
>  9 files changed, 23 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 14e68f202f81..afbd5e2b2ea8 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2426,7 +2426,7 @@ static void write_blk_ctl(struct nfit_blk *nfit_blk, unsigned int bw,
>  		offset = to_interleave_offset(offset, mmio);
>  
>  	writeq(cmd, mmio->addr.base + offset);
> -	nvdimm_flush(nfit_blk->nd_region, NULL);
> +	nvdimm_flush(nfit_blk->nd_region);
>  
>  	if (nfit_blk->dimm_flags & NFIT_BLK_DCR_LATCH)
>  		readq(mmio->addr.base + offset);
> @@ -2475,7 +2475,7 @@ static int acpi_nfit_blk_single_io(struct nfit_blk *nfit_blk,
>  	}
>  
>  	if (rw)
> -		nvdimm_flush(nfit_blk->nd_region, NULL);
> +		nvdimm_flush(nfit_blk->nd_region);
>  
>  	rc = read_blk_stat(nfit_blk, lane) ? -EIO : 0;
>  	return rc;
> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> index 2985ca949912..0fedb2fbfcbe 100644
> --- a/drivers/nvdimm/claim.c
> +++ b/drivers/nvdimm/claim.c
> @@ -293,7 +293,7 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
>  	}
>  
>  	memcpy_flushcache(nsio->addr + offset, buf, size);
> -	ret = nvdimm_flush(to_nd_region(ndns->dev.parent), NULL);
> +	ret = nvdimm_flush(to_nd_region(ndns->dev.parent));
>  	if (ret)
>  		rc = ret;
>  
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index ee5c04070ef9..77d8b9f0c34a 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -155,7 +155,7 @@ struct nd_region {
>  	struct badblocks bb;
>  	struct nd_interleave_set *nd_set;
>  	struct nd_percpu_lane __percpu *lane;
> -	int (*flush)(struct nd_region *nd_region, struct bio *bio);
> +	int (*flush)(struct nd_region *nd_region);
>  	struct nd_mapping mapping[0];
>  };
>  
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index 10351d5b49fa..9604ba08a68a 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -35,7 +35,7 @@ void virtio_pmem_host_ack(struct virtqueue *vq)
>  EXPORT_SYMBOL_GPL(virtio_pmem_host_ack);
>  
>   /* The request submission function */
> -static int virtio_pmem_flush(struct nd_region *nd_region)
> +int virtio_pmem_flush(struct nd_region *nd_region)
>  {
>  	struct virtio_device *vdev = nd_region->provider_data;
>  	struct virtio_pmem *vpmem  = vdev->priv;
> @@ -96,30 +96,5 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>  	kfree(req_data);
>  	return err;
>  };
> -
> -/* The asynchronous flush callback function */
> -int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> -{
> -	/*
> -	 * Create child bio for asynchronous flush and chain with
> -	 * parent bio. Otherwise directly call nd_region flush.
> -	 */
> -	if (bio && bio->bi_iter.bi_sector != -1) {
> -		struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> -
> -		if (!child)
> -			return -ENOMEM;
> -		bio_copy_dev(child, bio);
> -		child->bi_opf = REQ_PREFLUSH;
> -		child->bi_iter.bi_sector = -1;
> -		bio_chain(child, bio);
> -		submit_bio(child);
> -		return 0;
> -	}
> -	if (virtio_pmem_flush(nd_region))
> -		return -EIO;
> -
> -	return 0;
> -};
> -EXPORT_SYMBOL_GPL(async_pmem_flush);
> +EXPORT_SYMBOL_GPL(virtio_pmem_flush);
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index f9f76f6ba07b..b3ca641668a2 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -194,7 +194,13 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
>  	struct nd_region *nd_region = to_region(pmem);
>  
>  	if (bio->bi_opf & REQ_PREFLUSH)
> -		ret = nvdimm_flush(nd_region, bio);
> +		ret = nvdimm_flush(nd_region);
> +
> +	if (ret) {
> +		bio->bi_status = errno_to_blk_status(ret);
> +		bio_endio(bio);
> +		return BLK_QC_T_NONE;
> +	}
>  
>  	do_acct = nd_iostat_start(bio, &start);
>  	bio_for_each_segment(bvec, bio, iter) {
> @@ -209,7 +215,7 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
>  		nd_iostat_end(bio, start);
>  
>  	if (bio->bi_opf & REQ_FUA)
> -		ret = nvdimm_flush(nd_region, bio);
> +		ret = nvdimm_flush(nd_region);
>  
>  	if (ret)
>  		bio->bi_status = errno_to_blk_status(ret);
> @@ -549,14 +555,14 @@ static int nd_pmem_remove(struct device *dev)
>  		sysfs_put(pmem->bb_state);
>  		pmem->bb_state = NULL;
>  	}
> -	nvdimm_flush(to_nd_region(dev->parent), NULL);
> +	nvdimm_flush(to_nd_region(dev->parent));
>  
>  	return 0;
>  }
>  
>  static void nd_pmem_shutdown(struct device *dev)
>  {
> -	nvdimm_flush(to_nd_region(dev->parent), NULL);
> +	nvdimm_flush(to_nd_region(dev->parent));
>  }
>  
>  static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index ef423ba1a711..cfd96a0d52f2 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -287,7 +287,7 @@ static ssize_t deep_flush_store(struct device *dev, struct device_attribute *att
>  		return rc;
>  	if (!flush)
>  		return -EINVAL;
> -	rc = nvdimm_flush(nd_region, NULL);
> +	rc = nvdimm_flush(nd_region);
>  	if (rc)
>  		return rc;
>  
> @@ -1079,14 +1079,14 @@ struct nd_region *nvdimm_volatile_region_create(struct nvdimm_bus *nvdimm_bus,
>  }
>  EXPORT_SYMBOL_GPL(nvdimm_volatile_region_create);
>  
> -int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
> +int nvdimm_flush(struct nd_region *nd_region)
>  {
>  	int rc = 0;
>  
>  	if (!nd_region->flush)
>  		rc = generic_nvdimm_flush(nd_region);
>  	else {
> -		if (nd_region->flush(nd_region, bio))
> +		if (nd_region->flush(nd_region))
>  			rc = -EIO;
>  	}
>  
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 5e3d07b47e0c..a6234466674d 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -80,7 +80,7 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>  
>  	ndr_desc.res = &res;
>  	ndr_desc.numa_node = nid;
> -	ndr_desc.flush = async_pmem_flush;
> +	ndr_desc.flush = virtio_pmem_flush;
>  	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
>  	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
>  	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
> diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
> index 0dddefe594c4..4f9ee19aad90 100644
> --- a/drivers/nvdimm/virtio_pmem.h
> +++ b/drivers/nvdimm/virtio_pmem.h
> @@ -51,5 +51,5 @@ struct virtio_pmem {
>  };
>  
>  void virtio_pmem_host_ack(struct virtqueue *vq);
> -int async_pmem_flush(struct nd_region *nd_region, struct bio *bio);
> +int virtio_pmem_flush(struct nd_region *nd_region);
>  #endif
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index b6eddf912568..211c87edb4eb 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -130,7 +130,7 @@ struct nd_region_desc {
>  	int target_node;
>  	unsigned long flags;
>  	struct device_node *of_node;
> -	int (*flush)(struct nd_region *nd_region, struct bio *bio);
> +	int (*flush)(struct nd_region *nd_region);
>  };
>  
>  struct device;
> @@ -261,7 +261,7 @@ unsigned long nd_blk_memremap_flags(struct nd_blk_region *ndbr);
>  unsigned int nd_region_acquire_lane(struct nd_region *nd_region);
>  void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane);
>  u64 nd_fletcher64(void *addr, size_t len, bool le);
> -int nvdimm_flush(struct nd_region *nd_region, struct bio *bio);
> +int nvdimm_flush(struct nd_region *nd_region);
>  int generic_nvdimm_flush(struct nd_region *nd_region);
>  int nvdimm_has_flush(struct nd_region *nd_region);
>  int nvdimm_has_cache(struct nd_region *nd_region);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
