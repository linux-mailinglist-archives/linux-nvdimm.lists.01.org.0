Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CF819B985
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Apr 2020 02:28:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1134C10FC48CD;
	Wed,  1 Apr 2020 17:28:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8D6C610FC48C9
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 17:28:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o1so2116367edv.1
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 17:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rMoG139BAS3vSwnWNPt9NkvE0YK9VqiQxacpdg4y9C8=;
        b=b6uKoVWD6Cr/lKr0YKKqMS9MF7tOH9aunCZBAsMTrUwvYWsPp1CQ7F2m6pUvgy7vnC
         7RoP8LQla92LBHCgkc2g8QdtBVJnzc0090CjTAM1Qi72DURzMZxg+e3varCSqD1vdYPW
         M/J9cDqpOhDIQV8pOvn/Wi9N2bh1HIWmlCL9gpU0A+E2OcO1vE/3E9uIvB/gKd1dzfw9
         cOKT2ahz2TY5AoDZtiyTHFtltYl4sHWpADTGK37DpLuiTdhIl4j/T+eRkmatFe2Dxpsa
         kI6IxAFqojnBZm1JIGXsGk8QJgQIoQVNjJWwM41Euv2WGnSLotJt/HR6pWfn0S80QoFK
         FCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rMoG139BAS3vSwnWNPt9NkvE0YK9VqiQxacpdg4y9C8=;
        b=EGGMXs/zURIXtKd2li4eTIwfDjS8HLWO7yD/UcRVp2ITqtgzK8FUvzlymf5LHO4Yi+
         beAxABuFXFmGiWHDb7zbg1tRl3qZMC3EUiFYSDF7H9q4cSBdikBMJgkXeuFq1Ctk58aN
         g8xVaCz1c3Rss553oniEdSx9JVfu272MfVhqeL47Y8KlMVhtMsFoiCy/obmdBq6rORi+
         GlG6atGLJuutsBMdTbaA8/AcjZI7BvgONozC6lQtLNjOMgOY0KeJdmEb99UfpvPKoxur
         CNleRCT3LUIId2ybZDwaqfc3BphhgujuBY0a9CHuEvl1AaRNXCxWuGAwBTa5ouzTtjFn
         szQQ==
X-Gm-Message-State: AGi0PuZvpIHnx3Vphhyzat7UnusWUxgNBN3seQp3ZGugzXZG6CmGOSNE
	kDXnEXWmdwdDk0Bq04G148w7G/c1g17Aj7vshNpm0A==
X-Google-Smtp-Source: APiQypK1MdubaXDzXDW0OryS7Btp1yg8dmm5kamYFesYesYpOR0BQWhTUFKcfXpacPdBoNYqNEriI3UdkexV9JqGWrM=
X-Received: by 2002:a17:906:dbd4:: with SMTP id yc20mr703878ejb.335.1585787276297;
 Wed, 01 Apr 2020 17:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-16-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-16-alastair@d-silva.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2020 17:27:45 -0700
Message-ID: <CAPcyv4hvg_tizkOWkm2nSpR841m8X2Kh54KzU-qX=kvJuGJ9fg@mail.gmail.com>
Subject: Re: [PATCH v4 15/25] nvdimm/ocxl: Register a character device for
 userspace to interact with
To: "Alastair D'Silva" <alastair@d-silva.org>
Message-ID-Hash: USGGE3C5HEW5SF374W35BYBI4UNYDAM3
X-Message-ID-Hash: USGGE3C5HEW5SF374W35BYBI4UNYDAM3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/USGGE3C5HEW5SF374W35BYBI4UNYDAM3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 29, 2020 at 10:53 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> This patch introduces a character device (/dev/ocxlpmemX) which further
> patches will use to interact with userspace, such as error logs,
> controller stats and card debug functionality.

This was asked earlier, but I'll reiterate, I do not see what
justifies an ocxlpmemX private device ABI vs routing through the
existing generic character ndbusX and nmemX character devices.

>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/nvdimm/ocxl/main.c     | 117 ++++++++++++++++++++++++++++++++-
>  drivers/nvdimm/ocxl/ocxlpmem.h |   2 +
>  2 files changed, 117 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvdimm/ocxl/main.c b/drivers/nvdimm/ocxl/main.c
> index 8db573036423..9b85fcd3f1c9 100644
> --- a/drivers/nvdimm/ocxl/main.c
> +++ b/drivers/nvdimm/ocxl/main.c
> @@ -10,6 +10,7 @@
>  #include <misc/ocxl.h>
>  #include <linux/delay.h>
>  #include <linux/ndctl.h>
> +#include <linux/fs.h>
>  #include <linux/mm_types.h>
>  #include <linux/memory_hotplug.h>
>  #include "ocxlpmem.h"
> @@ -356,6 +357,67 @@ static int ocxlpmem_register(struct ocxlpmem *ocxlpmem)
>         return device_register(&ocxlpmem->dev);
>  }
>
> +static void ocxlpmem_put(struct ocxlpmem *ocxlpmem)
> +{
> +       put_device(&ocxlpmem->dev);
> +}
> +
> +static struct ocxlpmem *ocxlpmem_get(struct ocxlpmem *ocxlpmem)
> +{
> +       return (!get_device(&ocxlpmem->dev)) ? NULL : ocxlpmem;
> +}
> +
> +static struct ocxlpmem *find_and_get_ocxlpmem(dev_t devno)
> +{
> +       struct ocxlpmem *ocxlpmem;
> +       int minor = MINOR(devno);
> +
> +       mutex_lock(&minors_idr_lock);
> +       ocxlpmem = idr_find(&minors_idr, minor);
> +       if (ocxlpmem)
> +               ocxlpmem_get(ocxlpmem);
> +       mutex_unlock(&minors_idr_lock);
> +
> +       return ocxlpmem;
> +}
> +
> +static int file_open(struct inode *inode, struct file *file)
> +{
> +       struct ocxlpmem *ocxlpmem;
> +
> +       ocxlpmem = find_and_get_ocxlpmem(inode->i_rdev);
> +       if (!ocxlpmem)
> +               return -ENODEV;
> +
> +       file->private_data = ocxlpmem;
> +       return 0;
> +}
> +
> +static int file_release(struct inode *inode, struct file *file)
> +{
> +       struct ocxlpmem *ocxlpmem = file->private_data;
> +
> +       ocxlpmem_put(ocxlpmem);
> +       return 0;
> +}
> +
> +static const struct file_operations fops = {
> +       .owner          = THIS_MODULE,
> +       .open           = file_open,
> +       .release        = file_release,
> +};
> +
> +/**
> + * create_cdev() - Create the chardev in /dev for the device
> + * @ocxlpmem: the SCM metadata
> + * Return: 0 on success, negative on failure
> + */
> +static int create_cdev(struct ocxlpmem *ocxlpmem)
> +{
> +       cdev_init(&ocxlpmem->cdev, &fops);
> +       return cdev_add(&ocxlpmem->cdev, ocxlpmem->dev.devt, 1);
> +}
> +
>  /**
>   * ocxlpmem_remove() - Free an OpenCAPI persistent memory device
>   * @pdev: the PCI device information struct
> @@ -376,6 +438,13 @@ static void remove(struct pci_dev *pdev)
>                 if (ocxlpmem->nvdimm_bus)
>                         nvdimm_bus_unregister(ocxlpmem->nvdimm_bus);
>
> +               /*
> +                * Remove the cdev early to prevent a race against userspace
> +                * via the char dev
> +                */
> +               if (ocxlpmem->cdev.owner)
> +                       cdev_del(&ocxlpmem->cdev);
> +
>                 device_unregister(&ocxlpmem->dev);
>         }
>  }
> @@ -527,11 +596,18 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>                 goto err;
>         }
>
> -       if (setup_command_metadata(ocxlpmem)) {
> +       rc = setup_command_metadata(ocxlpmem);
> +       if (rc) {
>                 dev_err(&pdev->dev, "Could not read command metadata\n");
>                 goto err;
>         }
>
> +       rc = create_cdev(ocxlpmem);
> +       if (rc) {
> +               dev_err(&pdev->dev, "Could not create character device\n");
> +               goto err;
> +       }
> +
>         elapsed = 0;
>         timeout = ocxlpmem->readiness_timeout +
>                   ocxlpmem->memory_available_timeout;
> @@ -599,6 +675,36 @@ static struct pci_driver pci_driver = {
>         .shutdown = remove,
>  };
>
> +static int file_init(void)
> +{
> +       int rc;
> +
> +       rc = alloc_chrdev_region(&ocxlpmem_dev, 0, NUM_MINORS, "ocxlpmem");
> +       if (rc) {
> +               idr_destroy(&minors_idr);
> +               pr_err("Unable to allocate OpenCAPI persistent memory major number: %d\n",
> +                      rc);
> +               return rc;
> +       }
> +
> +       ocxlpmem_class = class_create(THIS_MODULE, "ocxlpmem");
> +       if (IS_ERR(ocxlpmem_class)) {
> +               idr_destroy(&minors_idr);
> +               pr_err("Unable to create ocxlpmem class\n");
> +               unregister_chrdev_region(ocxlpmem_dev, NUM_MINORS);
> +               return PTR_ERR(ocxlpmem_class);
> +       }
> +
> +       return 0;
> +}
> +
> +static void file_exit(void)
> +{
> +       class_destroy(ocxlpmem_class);
> +       unregister_chrdev_region(ocxlpmem_dev, NUM_MINORS);
> +       idr_destroy(&minors_idr);
> +}
> +
>  static int __init ocxlpmem_init(void)
>  {
>         int rc;
> @@ -606,16 +712,23 @@ static int __init ocxlpmem_init(void)
>         mutex_init(&minors_idr_lock);
>         idr_init(&minors_idr);
>
> -       rc = pci_register_driver(&pci_driver);
> +       rc = file_init();
>         if (rc)
>                 return rc;
>
> +       rc = pci_register_driver(&pci_driver);
> +       if (rc) {
> +               file_exit();
> +               return rc;
> +       }
> +
>         return 0;
>  }
>
>  static void ocxlpmem_exit(void)
>  {
>         pci_unregister_driver(&pci_driver);
> +       file_exit();
>  }
>
>  module_init(ocxlpmem_init);
> diff --git a/drivers/nvdimm/ocxl/ocxlpmem.h b/drivers/nvdimm/ocxl/ocxlpmem.h
> index b72b3f909fc3..ee3bd651f254 100644
> --- a/drivers/nvdimm/ocxl/ocxlpmem.h
> +++ b/drivers/nvdimm/ocxl/ocxlpmem.h
> @@ -2,6 +2,7 @@
>  // Copyright 2020 IBM Corp.
>
>  #include <linux/pci.h>
> +#include <linux/cdev.h>
>  #include <misc/ocxl.h>
>  #include <linux/libnvdimm.h>
>  #include <linux/mm.h>
> @@ -103,6 +104,7 @@ struct command_metadata {
>  struct ocxlpmem {
>         struct device dev;
>         struct pci_dev *pdev;
> +       struct cdev cdev;
>         struct ocxl_fn *ocxl_fn;
>         struct nd_interleave_set nd_set;
>         struct nvdimm_bus_descriptor bus_desc;
> --
> 2.24.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
