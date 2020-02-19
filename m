Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA553163C1E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 05:47:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8158C10FC3593;
	Tue, 18 Feb 2020 20:48:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 039ED10FC3593
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 20:48:04 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01J4jACV138396
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 23:47:12 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubwmcgd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 23:47:11 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Wed, 19 Feb 2020 04:47:09 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 19 Feb 2020 04:47:02 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01J4l0AK55312638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2020 04:47:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E428BAE045;
	Wed, 19 Feb 2020 04:47:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FBDEAE058;
	Wed, 19 Feb 2020 04:47:00 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2020 04:47:00 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A33F1A00DF;
	Wed, 19 Feb 2020 15:46:55 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date: Wed, 19 Feb 2020 15:46:58 +1100
In-Reply-To: <20200203132351.00005281@Huawei.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
	 <20191203034655.51561-13-alastair@au1.ibm.com>
	 <20200203132351.00005281@Huawei.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20021904-0016-0000-0000-000002E8238E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021904-0017-0000-0000-0000334B3A2C
Message-Id: <6c7e944c0370663a00aca33538957248f29e027d.camel@au1.ibm.com>
Subject: RE: [PATCH v2 12/27] nvdimm/ocxl: Read the capability registers & wait for
 device ready
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_08:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190031
Message-ID-Hash: ELFRXAF3T6XL2RKS24TBSQIBBDUR5T6U
X-Message-ID-Hash: ELFRXAF3T6XL2RKS24TBSQIBBDUR5T6U
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.
 ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ELFRXAF3T6XL2RKS24TBSQIBBDUR5T6U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2020-02-03 at 13:23 +0000, Jonathan Cameron wrote:
> On Tue, 3 Dec 2019 14:46:40 +1100
> Alastair D'Silva <alastair@au1.ibm.com> wrote:
> 
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > This patch reads timeouts & firmware version from the controller,
> > and
> > uses those timeouts to wait for the controller to report that it is
> > ready
> > before handing the memory over to libnvdimm.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >  drivers/nvdimm/ocxl/Makefile       |  2 +-
> >  drivers/nvdimm/ocxl/scm.c          | 84
> > ++++++++++++++++++++++++++++++
> >  drivers/nvdimm/ocxl/scm_internal.c | 19 +++++++
> >  drivers/nvdimm/ocxl/scm_internal.h | 24 +++++++++
> >  4 files changed, 128 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/nvdimm/ocxl/scm_internal.c
> > 
> > diff --git a/drivers/nvdimm/ocxl/Makefile
> > b/drivers/nvdimm/ocxl/Makefile
> > index 74a1bd98848e..9b6e31f0eb3e 100644
> > --- a/drivers/nvdimm/ocxl/Makefile
> > +++ b/drivers/nvdimm/ocxl/Makefile
> > @@ -4,4 +4,4 @@ ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
> >  
> >  obj-$(CONFIG_OCXL_SCM) += ocxlscm.o
> >  
> > -ocxlscm-y := scm.o
> > +ocxlscm-y := scm.o scm_internal.o
> > diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
> > index 571058a9e7b8..8088f65c289e 100644
> > --- a/drivers/nvdimm/ocxl/scm.c
> > +++ b/drivers/nvdimm/ocxl/scm.c
> > @@ -7,6 +7,7 @@
> >  
> >  #include <linux/module.h>
> >  #include <misc/ocxl.h>
> > +#include <linux/delay.h>
> >  #include <linux/ndctl.h>
> >  #include <linux/mm_types.h>
> >  #include <linux/memory_hotplug.h>
> > @@ -266,6 +267,30 @@ static int scm_register_lpc_mem(struct
> > scm_data *scm_data)
> >  	return 0;
> >  }
> >  
> > +/**
> > + * scm_is_usable() - Is a controller usable?
> > + * @scm_data: a pointer to the SCM device data
> > + * Return: true if the controller is usable
> > + */
> > +static bool scm_is_usable(const struct scm_data *scm_data)
> > +{
> > +	u64 chi = 0;
> > +	int rc = scm_chi(scm_data, &chi);
> > +
> > +	if (!(chi & GLOBAL_MMIO_CHI_CRDY)) {
> > +		dev_err(&scm_data->dev, "SCM controller is not
> > ready.\n");
> > +		return false;
> > +	}
> > +
> > +	if (!(chi & GLOBAL_MMIO_CHI_MA)) {
> > +		dev_err(&scm_data->dev,
> > +			"SCM controller does not have memory
> > available.\n");
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> >  /**
> >   * allocate_scm_minor() - Allocate a minor number to use for an
> > SCM device
> >   * @scm_data: The SCM device to associate the minor with
> > @@ -380,6 +405,48 @@ static void scm_remove(struct pci_dev *pdev)
> >  	}
> >  }
> >  
> > +/**
> > + * read_device_metadata() - Retrieve config information from the
> > AFU and save it for future use
> > + * @scm_data: the SCM metadata
> > + * Return: 0 on success, negative on failure
> > + */
> > +static int read_device_metadata(struct scm_data *scm_data)
> > +{
> > +	u64 val;
> > +	int rc;
> > +
> > +	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
> > GLOBAL_MMIO_CCAP0,
> > +				     OCXL_LITTLE_ENDIAN, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	scm_data->scm_revision = val & 0xFFFF;
> > +	scm_data->read_latency = (val >> 32) & 0xFF;
> > +	scm_data->readiness_timeout = (val >> 48) & 0xff;
> > +	scm_data->memory_available_timeout = val >> 52;
> 
> This overlaps with the masked region for readiness_timeout.  I'll
> guess the maks
> on that should be 0xF.
> 
Good catch, you're correct.

> > +
> > +	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
> > GLOBAL_MMIO_CCAP1,
> > +				     OCXL_LITTLE_ENDIAN, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	scm_data->max_controller_dump_size = val & 0xFFFFFFFF;
> > +
> > +	// Extract firmware version text
> > +	rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
> > GLOBAL_MMIO_FWVER,
> > +				     OCXL_HOST_ENDIAN, (u64 *)scm_data-
> > >fw_version);
> > +	if (rc)
> > +		return rc;
> > +
> > +	scm_data->fw_version[8] = '\0';
> > +
> > +	dev_info(&scm_data->dev,
> > +		 "Firmware version '%s' SCM revision %d:%d\n",
> > scm_data->fw_version,
> > +		 scm_data->scm_revision >> 4, scm_data->scm_revision &
> > 0x0F);
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * scm_probe_function_0 - Set up function 0 for an OpenCAPI
> > Storage Class Memory device
> >   * This is important as it enables templates higher than 0 across
> > all other functions,
> > @@ -420,6 +487,8 @@ static int scm_probe_function_0(struct pci_dev
> > *pdev)
> >  static int scm_probe(struct pci_dev *pdev, const struct
> > pci_device_id *ent)
> >  {
> >  	struct scm_data *scm_data = NULL;
> > +	int elapsed;
> > +	u16 timeout;
> >  
> >  	if (PCI_FUNC(pdev->devfn) == 0)
> >  		return scm_probe_function_0(pdev);
> > @@ -469,6 +538,21 @@ static int scm_probe(struct pci_dev *pdev,
> > const struct pci_device_id *ent)
> >  		goto err;
> >  	}
> >  
> > +	if (read_device_metadata(scm_data)) {
> > +		dev_err(&pdev->dev, "Could not read SCM device
> > metadata\n");
> > +		goto err;
> > +	}
> > +
> > +	elapsed = 0;
> > +	timeout = scm_data->readiness_timeout + scm_data-
> > >memory_available_timeout;
> > +	while (!scm_is_usable(scm_data)) {
> > +		if (elapsed++ > timeout) {
> > +			dev_warn(&scm_data->dev, "SCM ready
> > timeout.\n");
> > +			goto err;
> > +		}
> > +
> > +		msleep(1000);
> > +	}
> >  	if (scm_register_lpc_mem(scm_data)) {
> >  		dev_err(&pdev->dev, "Could not register OCXL SCM memory
> > with libnvdimm\n");
> >  		goto err;
> > diff --git a/drivers/nvdimm/ocxl/scm_internal.c
> > b/drivers/nvdimm/ocxl/scm_internal.c
> > new file mode 100644
> > index 000000000000..72d3c0e7d846
> > --- /dev/null
> > +++ b/drivers/nvdimm/ocxl/scm_internal.c
> > @@ -0,0 +1,19 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +// Copyright 2019 IBM Corp.
> > +
> > +#include <misc/ocxl.h>
> > +#include <linux/delay.h>
> > +#include "scm_internal.h"
> > +
> > +int scm_chi(const struct scm_data *scm_data, u64 *chi)
> > +{
> > +	u64 val;
> > +	int rc = ocxl_global_mmio_read64(scm_data->ocxl_afu,
> > GLOBAL_MMIO_CHI,
> > +					 OCXL_LITTLE_ENDIAN, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	*chi = val;
> > +
> > +	return 0;
> > +}
> > diff --git a/drivers/nvdimm/ocxl/scm_internal.h
> > b/drivers/nvdimm/ocxl/scm_internal.h
> > index d6ab361f5de9..584450f55e30 100644
> > --- a/drivers/nvdimm/ocxl/scm_internal.h
> > +++ b/drivers/nvdimm/ocxl/scm_internal.h
> > @@ -97,4 +97,28 @@ struct scm_data {
> >  	void *metadata_addr;
> >  	struct resource scm_res;
> >  	struct nd_region *nd_region;
> > +	char fw_version[8+1];
> > +
> > +	u32 max_controller_dump_size;
> > +	u16 scm_revision; // major/minor
> > +	u8 readiness_timeout;  /* The worst case time (in seconds) that
> > the host shall
> > +				* wait for the controller to become
> > operational following a reset (CHI.CRDY).
> > +				*/
> > +	u8 memory_available_timeout;   /* The worst case time (in
> > seconds) that the host shall
> > +					* wait for memory to become
> > available following a reset (CHI.MA).
> > +					*/
> > +
> > +	u16 read_latency; /* The nominal measure of latency (in
> > nanoseconds)
> > +			   * associated with an unassisted read of a
> > memory block.
> > +			   * This represents the capability of the raw
> > media technology without assistance
> > +			   */
> >  };
> > +
> > +/**
> > + * scm_chi() - Get the value of the CHI register
> > + * @scm_data: The SCM metadata
> > + * @chi: returns the CHI value
> > + *
> > + * Returns 0 on success, negative on error
> > + */
> > +int scm_chi(const struct scm_data *scm_data, u64 *chi);
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
