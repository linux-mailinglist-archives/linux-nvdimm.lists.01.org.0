Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E91BE163A52
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 03:39:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6387F10FC358F;
	Tue, 18 Feb 2020 18:40:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EDEB010FC3585
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 18:40:04 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01J2YuHE005819
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 21:39:11 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubesbh5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 21:39:11 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Wed, 19 Feb 2020 02:39:09 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 19 Feb 2020 02:39:03 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01J2d2Gg36503836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2020 02:39:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 116B052050;
	Wed, 19 Feb 2020 02:39:02 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 646D35204E;
	Wed, 19 Feb 2020 02:39:01 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id D431FA00DF;
	Wed, 19 Feb 2020 13:38:56 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date: Wed, 19 Feb 2020 13:39:00 +1100
In-Reply-To: <20200203124942.00003b68@Huawei.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
	 <20191203034655.51561-8-alastair@au1.ibm.com>
	 <20200203124942.00003b68@Huawei.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20021902-4275-0000-0000-000003A34DCB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021902-4276-0000-0000-000038B75661
Message-Id: <d8c4cbeb65ad87d6ca5a3867bbd94852f8a404f1.camel@au1.ibm.com>
Subject: RE: [PATCH v2 07/27] ocxl: Add functions to map/unmap LPC memory
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_08:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190017
Message-ID-Hash: QEO36NNMH6YOMGUVLRTAFNYGXEFFBE2Y
X-Message-ID-Hash: QEO36NNMH6YOMGUVLRTAFNYGXEFFBE2Y
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.
 ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QEO36NNMH6YOMGUVLRTAFNYGXEFFBE2Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2020-02-03 at 12:49 +0000, Jonathan Cameron wrote:
> On Tue, 3 Dec 2019 14:46:35 +1100
> Alastair D'Silva <alastair@au1.ibm.com> wrote:
> 
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > Add functions to map/unmap LPC memory
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >  drivers/misc/ocxl/config.c        |  4 +++
> >  drivers/misc/ocxl/core.c          | 50
> > +++++++++++++++++++++++++++++++
> >  drivers/misc/ocxl/ocxl_internal.h |  3 ++
> >  include/misc/ocxl.h               | 18 +++++++++++
> >  4 files changed, 75 insertions(+)
> > 
> > diff --git a/drivers/misc/ocxl/config.c
> > b/drivers/misc/ocxl/config.c
> > index c8e19bfb5ef9..fb0c3b6f8312 100644
> > --- a/drivers/misc/ocxl/config.c
> > +++ b/drivers/misc/ocxl/config.c
> > @@ -568,6 +568,10 @@ static int read_afu_lpc_memory_info(struct
> > pci_dev *dev,
> >  		afu->special_purpose_mem_size =
> >  			total_mem_size - lpc_mem_size;
> >  	}
> > +
> > +	dev_info(&dev->dev, "Probed LPC memory of %#llx bytes and
> > special purpose memory of %#llx bytes\n",
> > +		afu->lpc_mem_size, afu->special_purpose_mem_size);
> > +
> 
> If we are being fussy, this block has nothing todo with the rest of
> the patch
> so we should be seeing it here.

Agreed

> 
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/misc/ocxl/core.c b/drivers/misc/ocxl/core.c
> > index 2531c6cf19a0..98611faea219 100644
> > --- a/drivers/misc/ocxl/core.c
> > +++ b/drivers/misc/ocxl/core.c
> > @@ -210,6 +210,55 @@ static void unmap_mmio_areas(struct ocxl_afu
> > *afu)
> >  	release_fn_bar(afu->fn, afu->config.global_mmio_bar);
> >  }
> >  
> > +int ocxl_afu_map_lpc_mem(struct ocxl_afu *afu)
> > +{
> > +	struct pci_dev *dev = to_pci_dev(afu->fn->dev.parent);
> > +
> > +	if ((afu->config.lpc_mem_size + afu-
> > >config.special_purpose_mem_size) == 0)
> > +		return 0;
> > +
> > +	afu->lpc_base_addr = ocxl_link_lpc_map(afu->fn->link, dev);
> > +	if (afu->lpc_base_addr == 0)
> > +		return -EINVAL;
> > +
> > +	if (afu->config.lpc_mem_size) {
> 
> I was happy with the explicit check on 0 above, but we should be
> consistent.  Either
> we make use of 0 == false, or we don't and explicitly check vs 0.
> 
> Hence
> 
> if (afu->config.pc_mem_size != 0) { 
> 
> here or
> 
> if (!(afu->config.pc_mem_size + afu-
> >config.special_purpose_mem_size))
> 	return 0;
> 
> above.

This feels a bit niggly, but sure, changed to a '> 0' check.

> 
> > +		afu->lpc_res.start = afu->lpc_base_addr + afu-
> > >config.lpc_mem_offset;
> > +		afu->lpc_res.end = afu->lpc_res.start + afu-
> > >config.lpc_mem_size - 1;
> > +	}
> > +
> > +	if (afu->config.special_purpose_mem_size) {
> > +		afu->special_purpose_res.start = afu->lpc_base_addr +
> > +						 afu-
> > >config.special_purpose_mem_offset;
> > +		afu->special_purpose_res.end = afu-
> > >special_purpose_res.start +
> > +					       afu-
> > >config.special_purpose_mem_size - 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(ocxl_afu_map_lpc_mem);
> > +
> > +struct resource *ocxl_afu_lpc_mem(struct ocxl_afu *afu)
> > +{
> > +	return &afu->lpc_res;
> > +}
> > +EXPORT_SYMBOL_GPL(ocxl_afu_lpc_mem);
> > +
> > +static void unmap_lpc_mem(struct ocxl_afu *afu)
> > +{
> > +	struct pci_dev *dev = to_pci_dev(afu->fn->dev.parent);
> > +
> > +	if (afu->lpc_res.start || afu->special_purpose_res.start) {
> > +		void *link = afu->fn->link;
> > +
> > +		ocxl_link_lpc_release(link, dev);
> > +
> > +		afu->lpc_res.start = 0;
> > +		afu->lpc_res.end = 0;
> > +		afu->special_purpose_res.start = 0;
> > +		afu->special_purpose_res.end = 0;
> > +	}
> > +}
> > +
> >  static int configure_afu(struct ocxl_afu *afu, u8 afu_idx, struct
> > pci_dev *dev)
> >  {
> >  	int rc;
> > @@ -251,6 +300,7 @@ static int configure_afu(struct ocxl_afu *afu,
> > u8 afu_idx, struct pci_dev *dev)
> >  
> >  static void deconfigure_afu(struct ocxl_afu *afu)
> >  {
> > +	unmap_lpc_mem(afu);
> 
> Hmm. This breaks the existing balance between configure_afu and
> deconfigure_afu.
> 
> Given comments below on why we don't do map_lpc_mem in the afu bring
> up
> (as it's a shared operation) it seems to me that we should be doing
> this
> outside of the afu deconfigure.  Perhaps ocxl_function_close is
> appropriate?
> I don't know this infrastructure well enough to be sure.
> 
> If it does need to be here, then a comment to give more info on
> why would be great!
> 

Sure, I've added a comment in unmap_lpc_mem explaining that lpc_release
only releases the memory on the link when the last consumer calls
release.

It's in deconfigure_afu as the LPC memory is registered and reported
per-AFU (even though it has to be allocated all at once across the
link).

> >  	unmap_mmio_areas(afu);
> >  	reclaim_afu_pasid(afu);
> >  	reclaim_afu_actag(afu);
> > diff --git a/drivers/misc/ocxl/ocxl_internal.h
> > b/drivers/misc/ocxl/ocxl_internal.h
> > index 20b417e00949..9f4b47900e62 100644
> > --- a/drivers/misc/ocxl/ocxl_internal.h
> > +++ b/drivers/misc/ocxl/ocxl_internal.h
> > @@ -52,6 +52,9 @@ struct ocxl_afu {
> >  	void __iomem *global_mmio_ptr;
> >  	u64 pp_mmio_start;
> >  	void *private;
> > +	u64 lpc_base_addr; /* Covers both LPC & special purpose memory
> > */
> > +	struct resource lpc_res;
> > +	struct resource special_purpose_res;
> >  };
> >  
> >  enum ocxl_context_status {
> > diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> > index 06dd5839e438..6f7c02f0d5e3 100644
> > --- a/include/misc/ocxl.h
> > +++ b/include/misc/ocxl.h
> > @@ -212,6 +212,24 @@ int ocxl_irq_set_handler(struct ocxl_context
> > *ctx, int irq_id,
> >  
> >  // AFU Metadata
> >  
> > +/**
> > + * Map the LPC system & special purpose memory for an AFU
> > + *
> > + * Do not call this during device discovery, as there may me
> > multiple
> > + * devices on a link, and the memory is mapped for the whole link,
> > not
> > + * just one device. It should only be called after all devices
> > have
> > + * registered their memory on the link.
> > + *
> > + * afu: The AFU that has the LPC memory to map
> Run kernel-doc over these files and fix all the errors + warnings.
> 
Ok.

> @afu: ..
> 
> and missing function name etc.
> 
> 
> > + */
> > +extern int ocxl_afu_map_lpc_mem(struct ocxl_afu *afu);
> > +
> > +/**
> > + * Get the physical address range of LPC memory for an AFU
> > + * afu: The AFU associated with the LPC memory
> > + */
> > +extern struct resource *ocxl_afu_lpc_mem(struct ocxl_afu *afu);
> > +
> >  /**
> >   * Get a pointer to the config for an AFU
> >   *
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
