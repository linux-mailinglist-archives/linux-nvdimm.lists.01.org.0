Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E2917F5D5
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Mar 2020 12:12:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C1F010FC3608;
	Tue, 10 Mar 2020 04:13:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5640B10FC3605
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 04:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583838757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6l9FFbUnISRh3VrKLLJGrNWwowkUph4uFBmL5LiXs/0=;
	b=KfnnZvzMqHqHk6gUbeCEIQWHsslOy8qsEctcc6OsfoFVmVM+/LKtxerkRWI5t6YcW4B179
	3IPmLcZ9TTWjirGvI40JuNwb02oa0F1dPd6/7O+WoegrgeAhRMzmt1nNOkNXqQZ5Dp7x8r
	c6CGdKmTDgz5F2a8RGLekh7oEvw6los=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-WkFEqFalNVeSTYqWH6UsLg-1; Tue, 10 Mar 2020 07:12:33 -0400
X-MC-Unique: WkFEqFalNVeSTYqWH6UsLg-1
Received: by mail-qv1-f69.google.com with SMTP id m12so8835392qvp.4
        for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 04:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=axpVG1V/qjT3loDwbt+JJkZn/lElqcRQbdYlgx1uCXo=;
        b=NKuKfsmNpOn+d2fFt83eE04u4QzRFl76a50V1RFIpw4UGHnhaPaNZrmW85HBSMQTN4
         FYOIhkqJlEzSYtantbO42IDsg0Z6dMUw/fg36a91HDRxqS/HqkvtuMAyiejTMMcsojM5
         71Tyw41loSzEgOQJitnSq6aShnWexC15vLYwteTNE/A6HYEzw05XxAz3cfmBBLCE7kqg
         jeJt0rAR33h0fnDb3RwaBFLHoQhcrI2Kr5bPgAiTnkrc31jl1WLZtMlFgW2YUgzO9rTu
         k6E9eurNz8SfaSoYHpLkhSqkfiWXn8l0rMdh0/jjlko7Y3T2Yi3cmho7T6PYXTyUT0mo
         uP0Q==
X-Gm-Message-State: ANhLgQ3gJ76F1TDarjJRH4o/TWiLuPsn58A8m3uBa6+q4xa9c4B2wkdI
	H0Bi5rJdNSCoT9OTl8J5bCcDwpk61mK0XYrDafztUPmJ5BN3QZoQ6KxW1S5e1JmYaGkFvrTes7m
	UK78UdmeWiZ+T2XvyyKT4
X-Received: by 2002:aed:2591:: with SMTP id x17mr6733476qtc.380.1583838752652;
        Tue, 10 Mar 2020 04:12:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vutTgn6crJxCQfwGwj+7cZGf1ntMnVj+EoHAqemBucZaiqkgmtSkvFtwxvMhZzKEPjBUqZi+Q==
X-Received: by 2002:aed:2591:: with SMTP id x17mr6733431qtc.380.1583838752300;
        Tue, 10 Mar 2020 04:12:32 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id y5sm6737555qkb.123.2020.03.10.04.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 04:12:31 -0700 (PDT)
Date: Tue, 10 Mar 2020 07:12:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 04/20] virtio: Implement get_shm_region for PCI transport
Message-ID: <20200310071043-mutt-send-email-mst@kernel.org>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-5-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200304165845.3081-5-vgoyal@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Message-ID-Hash: 6KU5POYFOL5BX7FWV3NW7SNZG2CIFLE6
X-Message-ID-Hash: 6KU5POYFOL5BX7FWV3NW7SNZG2CIFLE6
X-MailFrom: mst@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>, kbuild test robot <lkp@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6KU5POYFOL5BX7FWV3NW7SNZG2CIFLE6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 04, 2020 at 11:58:29AM -0500, Vivek Goyal wrote:
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> 
> On PCI the shm regions are found using capability entries;
> find a region by searching for the capability.
> 
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 107 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_pci.h    |  11 ++-
>  2 files changed, 117 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 7abcc50838b8..52f179411015 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -443,6 +443,111 @@ static void del_vq(struct virtio_pci_vq_info *info)
>  	vring_del_virtqueue(vq);
>  }
>  
> +static int virtio_pci_find_shm_cap(struct pci_dev *dev,
> +                                   u8 required_id,
> +                                   u8 *bar, u64 *offset, u64 *len)
> +{
> +	int pos;
> +
> +        for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
> +             pos > 0;
> +             pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> +		u8 type, cap_len, id;
> +                u32 tmp32;
> +                u64 res_offset, res_length;
> +
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +                                                         cfg_type),
> +                                     &type);
> +                if (type != VIRTIO_PCI_CAP_SHARED_MEMORY_CFG)
> +                        continue;
> +
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +                                                         cap_len),
> +                                     &cap_len);
> +		if (cap_len != sizeof(struct virtio_pci_cap64)) {
> +		        printk(KERN_ERR "%s: shm cap with bad size offset: %d size: %d\n",
> +                               __func__, pos, cap_len);
> +                        continue;
> +                }
> +
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +                                                         id),
> +                                     &id);
> +                if (id != required_id)
> +                        continue;
> +
> +                /* Type, and ID match, looks good */
> +                pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +                                                         bar),
> +                                     bar);
> +
> +                /* Read the lower 32bit of length and offset */
> +                pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap, offset),
> +                                      &tmp32);
> +                res_offset = tmp32;
> +                pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap, length),
> +                                      &tmp32);
> +                res_length = tmp32;
> +
> +                /* and now the top half */
> +                pci_read_config_dword(dev,
> +                                      pos + offsetof(struct virtio_pci_cap64,
> +                                                     offset_hi),
> +                                      &tmp32);
> +                res_offset |= ((u64)tmp32) << 32;
> +                pci_read_config_dword(dev,
> +                                      pos + offsetof(struct virtio_pci_cap64,
> +                                                     length_hi),
> +                                      &tmp32);
> +                res_length |= ((u64)tmp32) << 32;
> +
> +                *offset = res_offset;
> +                *len = res_length;
> +
> +                return pos;
> +        }
> +        return 0;
> +}
> +
> +static bool vp_get_shm_region(struct virtio_device *vdev,
> +			      struct virtio_shm_region *region, u8 id)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> +	u8 bar;
> +	u64 offset, len;
> +	phys_addr_t phys_addr;
> +	size_t bar_len;
> +	int ret;
> +
> +	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> +		return false;
> +	}
> +
> +	ret = pci_request_region(pci_dev, bar, "virtio-pci-shm");
> +	if (ret < 0) {
> +		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> +			__func__);
> +		return false;
> +	}
> +
> +	phys_addr = pci_resource_start(pci_dev, bar);
> +	bar_len = pci_resource_len(pci_dev, bar);
> +
> +        if (offset + len > bar_len) {
> +                dev_err(&pci_dev->dev,
> +                        "%s: bar shorter than cap offset+len\n",
> +                        __func__);
> +                return false;
> +        }
> +

Something wrong with indentation here.
Also as long as you are validating things, it's worth checking
offset + len does not overflow.

> +	region->len = len;
> +	region->addr = (u64) phys_addr + offset;
> +
> +	return true;
> +}
> +
>  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.get		= NULL,
>  	.set		= NULL,
> @@ -457,6 +562,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>  	.bus_name	= vp_bus_name,
>  	.set_vq_affinity = vp_set_vq_affinity,
>  	.get_vq_affinity = vp_get_vq_affinity,
> +	.get_shm_region  = vp_get_shm_region,
>  };
>  
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -473,6 +579,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>  	.bus_name	= vp_bus_name,
>  	.set_vq_affinity = vp_set_vq_affinity,
>  	.get_vq_affinity = vp_get_vq_affinity,
> +	.get_shm_region  = vp_get_shm_region,
>  };
>  
>  /**
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index 90007a1abcab..fe9f43680a1d 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -113,6 +113,8 @@
>  #define VIRTIO_PCI_CAP_DEVICE_CFG	4
>  /* PCI configuration access */
>  #define VIRTIO_PCI_CAP_PCI_CFG		5
> +/* Additional shared memory capability */
> +#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
>  
>  /* This is the PCI capability header: */
>  struct virtio_pci_cap {
> @@ -121,11 +123,18 @@ struct virtio_pci_cap {
>  	__u8 cap_len;		/* Generic PCI field: capability length */
>  	__u8 cfg_type;		/* Identifies the structure. */
>  	__u8 bar;		/* Where to find it. */
> -	__u8 padding[3];	/* Pad to full dword. */
> +	__u8 id;		/* Multiple capabilities of the same type */
> +	__u8 padding[2];	/* Pad to full dword. */
>  	__le32 offset;		/* Offset within bar. */
>  	__le32 length;		/* Length of the structure, in bytes. */
>  };
>  
> +struct virtio_pci_cap64 {
> +       struct virtio_pci_cap cap;
> +       __le32 offset_hi;             /* Most sig 32 bits of offset */
> +       __le32 length_hi;             /* Most sig 32 bits of length */
> +};
> +
>  struct virtio_pci_notify_cap {
>  	struct virtio_pci_cap cap;
>  	__le32 notify_off_multiplier;	/* Multiplier for queue_notify_off. */
> -- 
> 2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
