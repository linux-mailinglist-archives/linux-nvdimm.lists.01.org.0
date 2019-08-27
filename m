Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0639E70F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Aug 2019 13:53:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D2FAA20216B6E;
	Tue, 27 Aug 2019 04:55:34 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4EA8E20212C8D
 for <linux-nvdimm@lists.01.org>; Tue, 27 Aug 2019 04:55:33 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1683F3082A8D;
 Tue, 27 Aug 2019 11:53:23 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0387360A35;
 Tue, 27 Aug 2019 11:53:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 745D822017B; Tue, 27 Aug 2019 07:53:17 -0400 (EDT)
Date: Tue, 27 Aug 2019 07:53:17 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 04/19] virtio: Implement get_shm_region for PCI transport
Message-ID: <20190827115317.GA30873@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-5-vgoyal@redhat.com>
 <20190827103457.35927d9d.cohuck@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190827103457.35927d9d.cohuck@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 27 Aug 2019 11:53:23 +0000 (UTC)
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
Cc: kbuild test robot <lkp@intel.com>, kvm@vger.kernel.org, miklos@szeredi.hu,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, dgilbert@redhat.com,
 virtio-fs@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Aug 27, 2019 at 10:34:57AM +0200, Cornelia Huck wrote:
> On Wed, 21 Aug 2019 13:57:05 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > 
> > On PCI the shm regions are found using capability entries;
> > find a region by searching for the capability.
> > 
> > Cc: kvm@vger.kernel.org
> > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: kbuild test robot <lkp@intel.com>
> 
> An s-o-b by a test robot looks a bit odd.

I think one of the fixes came from the robot and that's why I put s-o-b
from the robot as well. 

I will review the whole patch and fix all the intendation issues.

Vivek

> 
> > ---
> >  drivers/virtio/virtio_pci_modern.c | 108 +++++++++++++++++++++++++++++
> >  include/uapi/linux/virtio_pci.h    |  11 ++-
> >  2 files changed, 118 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 7abcc50838b8..1cdedd93f42a 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -443,6 +443,112 @@ static void del_vq(struct virtio_pci_vq_info *info)
> >  	vring_del_virtqueue(vq);
> >  }
> >  
> > +static int virtio_pci_find_shm_cap(struct pci_dev *dev,
> > +                                   u8 required_id,
> > +                                   u8 *bar, u64 *offset, u64 *len)
> > +{
> > +	int pos;
> > +
> > +        for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
> 
> Indentation looks a bit off here.
> 
> > +             pos > 0;
> > +             pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> > +		u8 type, cap_len, id;
> > +                u32 tmp32;
> 
> Here as well.
> 
> > +                u64 res_offset, res_length;
> > +
> > +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > +                                                         cfg_type),
> > +                                     &type);
> > +                if (type != VIRTIO_PCI_CAP_SHARED_MEMORY_CFG)
> 
> And here.
> 
> > +                        continue;
> > +
> > +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > +                                                         cap_len),
> > +                                     &cap_len);
> > +		if (cap_len != sizeof(struct virtio_pci_cap64)) {
> > +		        printk(KERN_ERR "%s: shm cap with bad size offset: %d size: %d\n",
> > +                               __func__, pos, cap_len);
> 
> Probably better to use dev_warn() instead of printk.
> 
> > +                        continue;
> > +                }
> 
> Indentation looks off again (might be a space vs tabs issue; maybe
> check the whole patch for indentation problems?)
> 
> > +
> > +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > +                                                         id),
> > +                                     &id);
> > +                if (id != required_id)
> > +                        continue;
> > +
> > +                /* Type, and ID match, looks good */
> > +                pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > +                                                         bar),
> > +                                     bar);
> > +
> > +                /* Read the lower 32bit of length and offset */
> > +                pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap, offset),
> > +                                      &tmp32);
> > +                res_offset = tmp32;
> > +                pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap, length),
> > +                                      &tmp32);
> > +                res_length = tmp32;
> > +
> > +                /* and now the top half */
> > +                pci_read_config_dword(dev,
> > +                                      pos + offsetof(struct virtio_pci_cap64,
> > +                                                     offset_hi),
> > +                                      &tmp32);
> > +                res_offset |= ((u64)tmp32) << 32;
> > +                pci_read_config_dword(dev,
> > +                                      pos + offsetof(struct virtio_pci_cap64,
> > +                                                     length_hi),
> > +                                      &tmp32);
> > +                res_length |= ((u64)tmp32) << 32;
> > +
> > +                *offset = res_offset;
> > +                *len = res_length;
> > +
> > +                return pos;
> > +        }
> > +        return 0;
> > +}
> > +
> > +static bool vp_get_shm_region(struct virtio_device *vdev,
> > +			      struct virtio_shm_region *region, u8 id)
> > +{
> > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> 
> This whole function looks like it is indented incorrectly.
> 
> > +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> > +	u8 bar;
> > +	u64 offset, len;
> > +	phys_addr_t phys_addr;
> > +	size_t bar_len;
> > +	char *bar_name;
> > +	int ret;
> > +
> > +	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> > +		return false;
> > +	}
> 
> You can drop the curly braces.
> 
> > +
> > +	ret = pci_request_region(pci_dev, bar, "virtio-pci-shm");
> > +	if (ret < 0) {
> > +		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> > +			__func__);
> > +		return false;
> > +	}
> > +
> > +	phys_addr = pci_resource_start(pci_dev, bar);
> > +	bar_len = pci_resource_len(pci_dev, bar);
> > +
> > +        if (offset + len > bar_len) {
> > +                dev_err(&pci_dev->dev,
> > +                        "%s: bar shorter than cap offset+len\n",
> > +                        __func__);
> > +                return false;
> > +        }
> > +
> > +	region->len = len;
> > +	region->addr = (u64) phys_addr + offset;
> > +
> > +	return true;
> > +}
> > +
> >  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> >  	.get		= NULL,
> >  	.set		= NULL,
> 
> Apart from the coding style nits, the logic of the patch looks sane to
> me.
> 
> (...)
> 
> As does the rest of the patch.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
