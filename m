Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB6C258322
	for <lists+linux-nvdimm@lfdr.de>; Mon, 31 Aug 2020 22:57:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D81F412A7F6E4;
	Mon, 31 Aug 2020 13:56:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC310123CEF50
	for <linux-nvdimm@lists.01.org>; Mon, 31 Aug 2020 13:56:57 -0700 (PDT)
IronPort-SDR: q7tLc4OtRf/JP1w9S+lZMQ2vuYitFYi7QrsfCjBkD4cz49fPGxD9uohRqf2DqBnvXl8kT+RFQ+
 t7hFV+RCkxPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="144746193"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600";
   d="scan'208";a="144746193"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 13:56:56 -0700
IronPort-SDR: t0PJjCuD1wtMFqkpi/FztVOjFZGZRijtNvTBBG6lxNyyHI/hyCERrhJlJXzQk2/5kzDmDwSPHq
 pOmLMXDREYiw==
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600";
   d="scan'208";a="445865326"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 13:56:55 -0700
Date: Mon, 31 Aug 2020 13:56:55 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [PATCH v4 1/2] memremap: rename MEMORY_DEVICE_DEVDAX to
 MEMORY_DEVICE_GENERIC
Message-ID: <20200831205655.GK1422350@iweiny-DESK2.sc.intel.com>
References: <20200811094447.31208-1-roger.pau@citrix.com>
 <20200811094447.31208-2-roger.pau@citrix.com>
 <96e34f77-8f55-d8a2-4d1f-4f4b667b0472@redhat.com>
 <20200820113741.GV828@Air-de-Roger>
 <20200831101907.GA753@Air-de-Roger>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200831101907.GA753@Air-de-Roger>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: DKWPZPUEFY3XV4EJJCVFMCK7LO3NXUPC
X-Message-ID-Hash: DKWPZPUEFY3XV4EJJCVFMCK7LO3NXUPC
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, linux-nvdimm@lists.01.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DKWPZPUEFY3XV4EJJCVFMCK7LO3NXUPC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2020 at 12:19:07PM +0200, Roger Pau Monn=E9 wrote:
> On Thu, Aug 20, 2020 at 01:37:41PM +0200, Roger Pau Monn=E9 wrote:
> > On Tue, Aug 11, 2020 at 11:07:36PM +0200, David Hildenbrand wrote:
> > > On 11.08.20 11:44, Roger Pau Monne wrote:
> > > > This is in preparation for the logic behind MEMORY_DEVICE_DEVDAX al=
so
> > > > being used by non DAX devices.
> > > >=20
> > > > No functional change intended.
> > > >=20
> > > > Signed-off-by: Roger Pau Monn=E9 <roger.pau@citrix.com>

Dan is out on leave so I'll chime in.

I can't really justify keeping this as DEVDAX if there is another user who
needs the same type of mapping.

Sorry for the delay.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> > > > ---
> > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> > > > Cc: Johannes Thumshirn <jthumshirn@suse.de>
> > > > Cc: Logan Gunthorpe <logang@deltatee.com>
> > > > Cc: linux-nvdimm@lists.01.org
> > > > Cc: xen-devel@lists.xenproject.org
> > > > Cc: linux-mm@kvack.org
> > > > ---
> > > >  drivers/dax/device.c     | 2 +-
> > > >  include/linux/memremap.h | 9 ++++-----
> > > >  mm/memremap.c            | 2 +-
> > > >  3 files changed, 6 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> > > > index 4c0af2eb7e19..1e89513f3c59 100644
> > > > --- a/drivers/dax/device.c
> > > > +++ b/drivers/dax/device.c
> > > > @@ -429,7 +429,7 @@ int dev_dax_probe(struct device *dev)
> > > >  		return -EBUSY;
> > > >  	}
> > > > =20
> > > > -	dev_dax->pgmap.type =3D MEMORY_DEVICE_DEVDAX;
> > > > +	dev_dax->pgmap.type =3D MEMORY_DEVICE_GENERIC;
> > > >  	addr =3D devm_memremap_pages(dev, &dev_dax->pgmap);
> > > >  	if (IS_ERR(addr))
> > > >  		return PTR_ERR(addr);
> > > > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > > > index 5f5b2df06e61..e5862746751b 100644
> > > > --- a/include/linux/memremap.h
> > > > +++ b/include/linux/memremap.h
> > > > @@ -46,11 +46,10 @@ struct vmem_altmap {
> > > >   * wakeup is used to coordinate physical address space management =
(ex:
> > > >   * fs truncate/hole punch) vs pinned pages (ex: device dma).
> > > >   *
> > > > - * MEMORY_DEVICE_DEVDAX:
> > > > + * MEMORY_DEVICE_GENERIC:
> > > >   * Host memory that has similar access semantics as System RAM i.e=
. DMA
> > > > - * coherent and supports page pinning. In contrast to
> > > > - * MEMORY_DEVICE_FS_DAX, this memory is access via a device-dax
> > > > - * character device.
> > > > + * coherent and supports page pinning. This is for example used by=
 DAX devices
> > > > + * that expose memory using a character device.
> > > >   *
> > > >   * MEMORY_DEVICE_PCI_P2PDMA:
> > > >   * Device memory residing in a PCI BAR intended for use with Peer-=
to-Peer
> > > > @@ -60,7 +59,7 @@ enum memory_type {
> > > >  	/* 0 is reserved to catch uninitialized type fields */
> > > >  	MEMORY_DEVICE_PRIVATE =3D 1,
> > > >  	MEMORY_DEVICE_FS_DAX,
> > > > -	MEMORY_DEVICE_DEVDAX,
> > > > +	MEMORY_DEVICE_GENERIC,
> > > >  	MEMORY_DEVICE_PCI_P2PDMA,
> > > >  };
> > > > =20
> > > > diff --git a/mm/memremap.c b/mm/memremap.c
> > > > index 03e38b7a38f1..006dace60b1a 100644
> > > > --- a/mm/memremap.c
> > > > +++ b/mm/memremap.c
> > > > @@ -216,7 +216,7 @@ void *memremap_pages(struct dev_pagemap *pgmap,=
 int nid)
> > > >  			return ERR_PTR(-EINVAL);
> > > >  		}
> > > >  		break;
> > > > -	case MEMORY_DEVICE_DEVDAX:
> > > > +	case MEMORY_DEVICE_GENERIC:
> > > >  		need_devmap_managed =3D false;
> > > >  		break;
> > > >  	case MEMORY_DEVICE_PCI_P2PDMA:
> > > >=20
> > >=20
> > > No strong opinion (@Dan?), I do wonder if a separate type would make =
sense.
> >=20
> > Gentle ping.
>=20
> Sorry to ping again, but I would rather get this out of my queue if
> possible, seeing as the other patch is OK to go in but depends on this
> one going in first.
>=20
> Thanks, Roger.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
