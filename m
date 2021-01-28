Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ED7306D0D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Jan 2021 06:41:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E1080100F2255;
	Wed, 27 Jan 2021 21:41:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DF2DD100EB845
	for <linux-nvdimm@lists.01.org>; Wed, 27 Jan 2021 21:41:52 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a10so5963562ejg.10
        for <linux-nvdimm@lists.01.org>; Wed, 27 Jan 2021 21:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6AmYy0zZuurXUxarU1y3Mn82ygO62EXHDG0mWU5ctM=;
        b=nCmHfICz8go/Q0N5kYZhrqCR/9UUQZ7SFlPI+ZWd8IJSl3F9N4P7EPgVPZr3gYO5cv
         dQS9X2mfE+ymZr9zYNKZdlQwDHuOxz9PmTbqA+So9Cm98iICBT4Ull8GfgE5e1TzhFSQ
         PunYsvu0MU9MgS0tFsJb2c/zUJN82seDcvQKiAYZ+DtqsHHuMUjwl2XYvjiVqbcHdYOh
         QSjjv7LNE17o0Zq8bh4W+Ao4Sr+GwrtnvlxeDbFhW3a/jjOCtHyke32WpQ3q4ji7b/KH
         Ee0MOzHmPJ/Jd+VGmJ0mKn0I5JeSNPux84mDr8X6xVPbtf2hVHoLmsyESybbyFxlQRg8
         lMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6AmYy0zZuurXUxarU1y3Mn82ygO62EXHDG0mWU5ctM=;
        b=jCpfTQmsn2Lnqz0W3l7ImPUjnq3JvnDIYvEXWv0YhZCVwzpti6f7rryyu6rVHvE83t
         XEefZBTiYEfNpCUB9XhBCB4xyvIzop2gxyoh1k7kP7CD8+wFZ2OLP+LNbFl5OLmltrJM
         IHh8IBJGtmk/7I8G6v3KHVGDSZtJYlCgj/+rYSAqFfWIY1/LxIzFlNMK760CT+FkjFO0
         QfRNN9BMylT2eVgsQG5oJAtLV+J1hLsm58Zd5tQ4n4SMNY06PL+82QP4tlBLBSacIGBm
         MZvyfFv4RiLHJU7i9+erpIiCgOPDC7UZ4LiqvHHW39UqCYuoizn6FetNDfLXIlakBw+A
         0yfQ==
X-Gm-Message-State: AOAM5309uAnqNDlH0DH/8294sK53sOypCV4IEx2m89/5HSqTSZEbH/a8
	fjf1M1yVxhH0UrhqBKo+VPm/aJ3I/0JNbvlgsBWqzA==
X-Google-Smtp-Source: ABdhPJwG/6xLv/hCe2jY7Wkk5XJFIAr+qQMsIdyLRovnCRfDP43cN4BrsWT7lpBopy80qILKQDjq2tXxTsROnbS3qIQ=
X-Received: by 2002:a17:906:9497:: with SMTP id t23mr9836373ejx.523.1611812511042;
 Wed, 27 Jan 2021 21:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20201214103859.2409175-1-santosh@fossix.org> <20201214103859.2409175-2-santosh@fossix.org>
In-Reply-To: <20201214103859.2409175-2-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 27 Jan 2021 21:41:49 -0800
Message-ID: <CAPcyv4ii8VbXSC4W0CPqPJeT3GzTg17DX0dSHRZnM=w=t9TSKA@mail.gmail.com>
Subject: Re: [RFC v5 1/7] testing/nvdimm: Add test module for non-nfit platforms
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: SFCHYWL7E42YEW7ON3ZRI5KM2Q5QPHSI
X-Message-ID-Hash: SFCHYWL7E42YEW7ON3ZRI5KM2Q5QPHSI
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SFCHYWL7E42YEW7ON3ZRI5KM2Q5QPHSI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 14, 2020 at 2:39 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> The current test module cannot be used for testing platforms (make check)
> that do not have support for NFIT. In order to get the ndctl tests working,
> we need a module which can emulate NVDIMM devices without relying on
> ACPI/NFIT.
>
> The aim of this proposed module is to implement a similar functionality to
> the existing module but without the ACPI dependencies.
>
> This RFC series is split into reviewable and compilable chunks.
>
> This patch adds a new driver and registers two nvdimm bus needed for ndctl
> make check.
>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  tools/testing/nvdimm/config_check.c |   3 +-
>  tools/testing/nvdimm/test/Kbuild    |   6 +-
>  tools/testing/nvdimm/test/ndtest.c  | 206 ++++++++++++++++++++++++++++
>  tools/testing/nvdimm/test/ndtest.h  |  16 +++
>  4 files changed, 229 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/nvdimm/test/ndtest.c
>  create mode 100644 tools/testing/nvdimm/test/ndtest.h
>
> diff --git a/tools/testing/nvdimm/config_check.c b/tools/testing/nvdimm/config_check.c
> index cac891028cd1..3e3a5f518864 100644
> --- a/tools/testing/nvdimm/config_check.c
> +++ b/tools/testing/nvdimm/config_check.c
> @@ -12,7 +12,8 @@ void check(void)
>         BUILD_BUG_ON(!IS_MODULE(CONFIG_ND_BTT));
>         BUILD_BUG_ON(!IS_MODULE(CONFIG_ND_PFN));
>         BUILD_BUG_ON(!IS_MODULE(CONFIG_ND_BLK));
> -       BUILD_BUG_ON(!IS_MODULE(CONFIG_ACPI_NFIT));
> +       if (IS_ENABLED(CONFIG_ACPI_NFIT))
> +               BUILD_BUG_ON(!IS_MODULE(CONFIG_ACPI_NFIT));
>         BUILD_BUG_ON(!IS_MODULE(CONFIG_DEV_DAX));
>         BUILD_BUG_ON(!IS_MODULE(CONFIG_DEV_DAX_PMEM));
>  }
> diff --git a/tools/testing/nvdimm/test/Kbuild b/tools/testing/nvdimm/test/Kbuild
> index 75baebf8f4ba..197bcb2b7f35 100644
> --- a/tools/testing/nvdimm/test/Kbuild
> +++ b/tools/testing/nvdimm/test/Kbuild
> @@ -5,5 +5,9 @@ ccflags-y += -I$(srctree)/drivers/acpi/nfit/
>  obj-m += nfit_test.o
>  obj-m += nfit_test_iomap.o
>

> -nfit_test-y := nfit.o
> +ifeq  ($(CONFIG_ACPI_NFIT),m)
> +       nfit_test-y := nfit.o
> +else
> +       nfit_test-y := ndtest.o
> +endif

So it took me a moment to figure out what happened to my
ARCH_SUPPORTS_ACPI suggestion and that you're using the "nfit_test"
name to both claim a level of compatibility, but also prevent ndtest.o
from colliding with the nfit.o implementation (i.e. they both can't be
loaded at the same time).

I think that's a reasonable change, but it sorely needs to be
documented. Especially given that this may silently swap out
nfit_test.ko with a version that passes fewer tests it needs a mention
in the ndctl README.md that there are 2 modes of the test module
possible. This lets developers of other archs that come along discover
their options.

A mechanism for how to tell which flavor of nfit_test is installed is
needed so that when someone files a github issue about a test failure
there is an unambiguous way to validate what mode is being run.
Perhaps:

MODULE_DESCRIPTION("nfit_test: compat")

MODULE_DESCRIPTION("nfit_test: native")

...in the 2 different builds? Bonus points if the ndctl tests that are
known to fail with the compat version just skip instead of fail when
detecting compat.



>  nfit_test_iomap-y := iomap.o
> diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
> new file mode 100644
> index 000000000000..f89d74fdcdee
> --- /dev/null
> +++ b/tools/testing/nvdimm/test/ndtest.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/platform_device.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/genalloc.h>
> +#include <linux/vmalloc.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/list_sort.h>
> +#include <linux/libnvdimm.h>
> +#include <linux/ndctl.h>
> +#include <nd-core.h>
> +#include <linux/printk.h>
> +#include <linux/seq_buf.h>
> +
> +#include "../watermark.h"
> +#include "nfit_test.h"
> +#include "ndtest.h"
> +
> +enum {
> +       DIMM_SIZE = SZ_32M,
> +       LABEL_SIZE = SZ_128K,
> +       NUM_INSTANCES = 2,
> +       NUM_DCR = 4,
> +};
> +
> +static struct ndtest_priv *instances[NUM_INSTANCES];
> +static struct class *ndtest_dimm_class;
> +
> +static inline struct ndtest_priv *to_ndtest_priv(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +
> +       return container_of(pdev, struct ndtest_priv, pdev);
> +}
> +
> +static int ndtest_ctl(struct nvdimm_bus_descriptor *nd_desc,
> +                     struct nvdimm *nvdimm, unsigned int cmd, void *buf,
> +                     unsigned int buf_len, int *cmd_rc)
> +{
> +       struct ndtest_dimm *dimm;
> +       int _cmd_rc;
> +
> +       if (!cmd_rc)
> +               cmd_rc = &_cmd_rc;
> +
> +       *cmd_rc = 0;
> +
> +       if (!nvdimm)
> +               return -EINVAL;
> +
> +       dimm = nvdimm_provider_data(nvdimm);
> +       if (!dimm)
> +               return -EINVAL;
> +
> +       switch (cmd) {
> +       case ND_CMD_GET_CONFIG_SIZE:
> +       case ND_CMD_GET_CONFIG_DATA:
> +       case ND_CMD_SET_CONFIG_DATA:
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int ndtest_bus_register(struct ndtest_priv *p)
> +{
> +       p->bus_desc.ndctl = ndtest_ctl;
> +       p->bus_desc.module = THIS_MODULE;
> +       p->bus_desc.provider_name = NULL;
> +
> +       p->bus = nvdimm_bus_register(&p->pdev.dev, &p->bus_desc);
> +       if (!p->bus) {
> +               dev_err(&p->pdev.dev, "Error creating nvdimm bus %pOF\n", p->dn);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static int ndtest_remove(struct platform_device *pdev)
> +{
> +       struct ndtest_priv *p = to_ndtest_priv(&pdev->dev);
> +
> +       nvdimm_bus_unregister(p->bus);
> +       return 0;
> +}
> +
> +static int ndtest_probe(struct platform_device *pdev)
> +{
> +       struct ndtest_priv *p;
> +
> +       p = to_ndtest_priv(&pdev->dev);
> +       if (ndtest_bus_register(p))
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, p);
> +
> +       return 0;
> +}
> +
> +static const struct platform_device_id ndtest_id[] = {
> +       { KBUILD_MODNAME },
> +       { },
> +};
> +
> +static struct platform_driver ndtest_driver = {
> +       .probe = ndtest_probe,
> +       .remove = ndtest_remove,
> +       .driver = {
> +               .name = KBUILD_MODNAME,
> +       },
> +       .id_table = ndtest_id,
> +};
> +
> +static void ndtest_release(struct device *dev)
> +{
> +       struct ndtest_priv *p = to_ndtest_priv(dev);
> +
> +       kfree(p);
> +}
> +
> +static void cleanup_devices(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < NUM_INSTANCES; i++)
> +               if (instances[i])
> +                       platform_device_unregister(&instances[i]->pdev);
> +
> +       nfit_test_teardown();
> +
> +       if (ndtest_dimm_class)
> +               class_destroy(ndtest_dimm_class);
> +}
> +
> +static __init int ndtest_init(void)
> +{
> +       int rc, i;
> +
> +       pmem_test();
> +       libnvdimm_test();
> +       device_dax_test();
> +       dax_pmem_test();
> +       dax_pmem_core_test();
> +#ifdef CONFIG_DEV_DAX_PMEM_COMPAT
> +       dax_pmem_compat_test();
> +#endif
> +
> +       ndtest_dimm_class = class_create(THIS_MODULE, "nfit_test_dimm");
> +       if (IS_ERR(ndtest_dimm_class)) {
> +               rc = PTR_ERR(ndtest_dimm_class);
> +               goto err_register;
> +       }
> +
> +       /* Each instance can be taken as a bus, which can have multiple dimms */
> +       for (i = 0; i < NUM_INSTANCES; i++) {
> +               struct ndtest_priv *priv;
> +               struct platform_device *pdev;
> +
> +               priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +               if (!priv) {
> +                       rc = -ENOMEM;
> +                       goto err_register;
> +               }
> +
> +               INIT_LIST_HEAD(&priv->resources);
> +               pdev = &priv->pdev;
> +               pdev->name = KBUILD_MODNAME;
> +               pdev->id = i;
> +               pdev->dev.release = ndtest_release;
> +               rc = platform_device_register(pdev);
> +               if (rc) {
> +                       put_device(&pdev->dev);
> +                       goto err_register;
> +               }
> +               get_device(&pdev->dev);
> +
> +               instances[i] = priv;
> +       }
> +
> +       rc = platform_driver_register(&ndtest_driver);
> +       if (rc)
> +               goto err_register;
> +
> +       return 0;
> +
> +err_register:
> +       pr_err("Error registering platform device\n");
> +       cleanup_devices();
> +
> +       return rc;
> +}
> +
> +static __exit void ndtest_exit(void)
> +{
> +       cleanup_devices();
> +       platform_driver_unregister(&ndtest_driver);
> +}
> +
> +module_init(ndtest_init);
> +module_exit(ndtest_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("IBM Corporation");
> diff --git a/tools/testing/nvdimm/test/ndtest.h b/tools/testing/nvdimm/test/ndtest.h
> new file mode 100644
> index 000000000000..831ac5c65f50
> --- /dev/null
> +++ b/tools/testing/nvdimm/test/ndtest.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef NDTEST_H
> +#define NDTEST_H
> +
> +#include <linux/platform_device.h>
> +#include <linux/libnvdimm.h>
> +
> +struct ndtest_priv {
> +       struct platform_device pdev;
> +       struct device_node *dn;
> +       struct list_head resources;
> +       struct nvdimm_bus_descriptor bus_desc;
> +       struct nvdimm_bus *bus;
> +};
> +
> +#endif /* NDTEST_H */
> --
> 2.26.2
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
