Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0643A175383
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Mar 2020 07:06:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF2B210FC3594;
	Sun,  1 Mar 2020 22:07:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6B39710FC3592
	for <linux-nvdimm@lists.01.org>; Sun,  1 Mar 2020 22:07:04 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022651PA192325
	for <linux-nvdimm@lists.01.org>; Mon, 2 Mar 2020 01:06:12 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2yfn15k01q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 02 Mar 2020 01:06:11 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Mon, 2 Mar 2020 06:06:09 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 2 Mar 2020 06:06:02 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 022661DR42926082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2020 06:06:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F7E5AE057;
	Mon,  2 Mar 2020 06:06:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BF9EAE04D;
	Mon,  2 Mar 2020 06:06:00 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2020 06:06:00 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id CABC3A00BE;
	Mon,  2 Mar 2020 17:05:55 +1100 (AEDT)
Subject: Re: [PATCH v3 16/27] powerpc/powernv/pmem: Register a character
 device for userspace to interact with
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Andrew Donnellan <ajd@linux.ibm.com>
Date: Mon, 02 Mar 2020 17:05:59 +1100
In-Reply-To: <1e980dc7-109a-d96f-1329-1c38918e2bba@linux.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
	 <20200221032720.33893-17-alastair@au1.ibm.com>
	 <1e980dc7-109a-d96f-1329-1c38918e2bba@linux.ibm.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20030206-0016-0000-0000-000002EC1123
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030206-0017-0000-0000-0000334F5136
Message-Id: <8cff2a36a2d9f50725c7df1292c4c6df79a1711d.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_01:2020-02-28,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=2 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003020046
Message-ID-Hash: A23UEDEYAB277J2H24S757PXJFJHCTXJ
X-Message-ID-Hash: A23UEDEYAB277J2H24S757PXJFJHCTXJ
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxp
 pc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A23UEDEYAB277J2H24S757PXJFJHCTXJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2020-03-02 at 16:34 +1100, Andrew Donnellan wrote:
> On 21/2/20 2:27 pm, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > This patch introduces a character device (/dev/ocxl-scmX) which
> > further
> > patches will use to interact with userspace.
> 
> As with the comments on other patches in this series, this commit 
> message is lacking in explanation. What's the purpose of this device?
> 

I'll reword this for v4.

> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >   arch/powerpc/platforms/powernv/pmem/ocxl.c    | 116
> > +++++++++++++++++-
> >   .../platforms/powernv/pmem/ocxl_internal.h    |   2 +
> >   2 files changed, 116 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c
> > b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> > index b8bd7e703b19..63109a870d2c 100644
> > --- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
> > +++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> > @@ -10,6 +10,7 @@
> >   #include <misc/ocxl.h>
> >   #include <linux/delay.h>
> >   #include <linux/ndctl.h>
> > +#include <linux/fs.h>
> >   #include <linux/mm_types.h>
> >   #include <linux/memory_hotplug.h>
> >   #include "ocxl_internal.h"
> > @@ -339,6 +340,9 @@ static void free_ocxlpmem(struct ocxlpmem
> > *ocxlpmem)
> >   
> >   	free_minor(ocxlpmem);
> >   
> > +	if (ocxlpmem->cdev.owner)
> > +		cdev_del(&ocxlpmem->cdev);
> > +
> >   	if (ocxlpmem->metadata_addr)
> >   		devm_memunmap(&ocxlpmem->dev, ocxlpmem->metadata_addr);
> >   
> > @@ -396,6 +400,70 @@ static int ocxlpmem_register(struct ocxlpmem
> > *ocxlpmem)
> >   	return device_register(&ocxlpmem->dev);
> >   }
> >   
> > +static void ocxlpmem_put(struct ocxlpmem *ocxlpmem)
> > +{
> > +	put_device(&ocxlpmem->dev);
> > +}
> > +
> > +static struct ocxlpmem *ocxlpmem_get(struct ocxlpmem *ocxlpmem)
> > +{
> > +	return (get_device(&ocxlpmem->dev) == NULL) ? NULL : ocxlpmem;
> > +}
> > +
> > +static struct ocxlpmem *find_and_get_ocxlpmem(dev_t devno)
> > +{
> > +	struct ocxlpmem *ocxlpmem;
> > +	int minor = MINOR(devno);
> > +	/*
> > +	 * We don't declare an RCU critical section here, as our AFU
> > +	 * is protected by a re0ference counter on the device. By the
> > time the
> > +	 * minor number of a device is removed from the idr, the ref
> > count of
> > +	 * the device is already at 0, so no user API will access that
> > AFU and
> > +	 * this function can't return it.
> > +	 */
> > +	ocxlpmem = idr_find(&minors_idr, minor);
> > +	if (ocxlpmem)
> > +		ocxlpmem_get(ocxlpmem);
> > +	return ocxlpmem;
> > +}
> > +
> > +static int file_open(struct inode *inode, struct file *file)
> > +{
> > +	struct ocxlpmem *ocxlpmem;
> > +
> > +	ocxlpmem = find_and_get_ocxlpmem(inode->i_rdev);
> > +	if (!ocxlpmem)
> > +		return -ENODEV;
> > +
> > +	file->private_data = ocxlpmem;
> > +	return 0;
> > +}
> > +
> > +static int file_release(struct inode *inode, struct file *file)
> > +{
> > +	struct ocxlpmem *ocxlpmem = file->private_data;
> > +
> > +	ocxlpmem_put(ocxlpmem);
> > +	return 0;
> > +}
> > +
> > +static const struct file_operations fops = {
> > +	.owner		= THIS_MODULE,
> > +	.open		= file_open,
> > +	.release	= file_release,
> > +};
> > +
> > +/**
> > + * create_cdev() - Create the chardev in /dev for the device
> > + * @ocxlpmem: the SCM metadata
> > + * Return: 0 on success, negative on failure
> > + */
> > +static int create_cdev(struct ocxlpmem *ocxlpmem)
> > +{
> > +	cdev_init(&ocxlpmem->cdev, &fops);
> > +	return cdev_add(&ocxlpmem->cdev, ocxlpmem->dev.devt, 1);
> > +}
> > +
> >   /**
> >    * ocxlpmem_remove() - Free an OpenCAPI persistent memory device
> >    * @pdev: the PCI device information struct
> > @@ -572,6 +640,11 @@ static int probe(struct pci_dev *pdev, const
> > struct pci_device_id *ent)
> >   		goto err;
> >   	}
> >   
> > +	if (create_cdev(ocxlpmem)) {
> > +		dev_err(&pdev->dev, "Could not create character
> > device\n");
> > +		goto err;
> > +	}
> > +
> >   	elapsed = 0;
> >   	timeout = ocxlpmem->readiness_timeout + ocxlpmem-
> > >memory_available_timeout;
> >   	while (!is_usable(ocxlpmem, false)) {
> > @@ -613,20 +686,59 @@ static struct pci_driver pci_driver = {
> >   	.shutdown = ocxlpmem_remove,
> >   };
> >   
> > +static int file_init(void)
> > +{
> > +	int rc;
> > +
> > +	mutex_init(&minors_idr_lock);
> > +	idr_init(&minors_idr);
> > +
> > +	rc = alloc_chrdev_region(&ocxlpmem_dev, 0, NUM_MINORS, "ocxl-
> > pmem");
> 
> If the driver is going to be called "ocxlpmem" can we standardise on 
> that without the extra hyphen?

Ok

> > +	if (rc) {
> > +		idr_destroy(&minors_idr);
> > +		pr_err("Unable to allocate OpenCAPI persistent memory
> > major number: %d\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	ocxlpmem_class = class_create(THIS_MODULE, "ocxl-pmem");
> > +	if (IS_ERR(ocxlpmem_class)) {
> > +		idr_destroy(&minors_idr);
> > +		pr_err("Unable to create ocxl-pmem class\n");
> > +		unregister_chrdev_region(ocxlpmem_dev, NUM_MINORS);
> > +		return PTR_ERR(ocxlpmem_class);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void file_exit(void)
> > +{
> > +	class_destroy(ocxlpmem_class);
> > +	unregister_chrdev_region(ocxlpmem_dev, NUM_MINORS);
> > +	idr_destroy(&minors_idr);
> > +}
> > +
> >   static int __init ocxlpmem_init(void)
> >   {
> > -	int rc = 0;
> > +	int rc;
> >   
> > -	rc = pci_register_driver(&pci_driver);
> > +	rc = file_init();
> >   	if (rc)
> >   		return rc;
> >   
> > +	rc = pci_register_driver(&pci_driver);
> > +	if (rc) {
> > +		file_exit();
> > +		return rc;
> > +	}
> > +
> >   	return 0;
> >   }
> >   
> >   static void ocxlpmem_exit(void)
> >   {
> >   	pci_unregister_driver(&pci_driver);
> > +	file_exit();
> >   }
> >   
> >   module_init(ocxlpmem_init);
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
