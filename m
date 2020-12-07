Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 219802D1C92
	for <lists+linux-nvdimm@lfdr.de>; Mon,  7 Dec 2020 23:00:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 52BFD100EBB7C;
	Mon,  7 Dec 2020 14:00:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 73497100EBB6F
	for <linux-nvdimm@lists.01.org>; Mon,  7 Dec 2020 14:00:48 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id b9so11404647ejy.0
        for <linux-nvdimm@lists.01.org>; Mon, 07 Dec 2020 14:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgMYI4QXRKWj+L3OZ6Sn2x4X8PcUSku5pcLM8tQC/V8=;
        b=BGLdRfUJogolaO7zbkwkfiWlitcJJG+o5cLxlMfmayPGLYtjeChiS51PRfMwPj1KLT
         +N5LRJG/6iiHbywZph+Vmr72uovjwTqa4y+yhT1SZDFe3g3ldaym8ru7Up5cSgD6uu0N
         O+3dGfd4tYsKcUGtOuTSdNrh3vXR1cHIT/C//BoFJ6+GQmYRpZgFm43zbMslPyjP1JXd
         FR3TCWhIj3XTWNqlRnJbGpLgTR6H0RTmnSj7ZoVTgmD9IqsuCCHOmIlinXdAakX54QWX
         sOZTMbDMLdFyww9TlPIXGIsVfscqaipz0Z/1eX4vvHRLT6QWBsBz+0KQIZ/N9lHRyGWD
         Im9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgMYI4QXRKWj+L3OZ6Sn2x4X8PcUSku5pcLM8tQC/V8=;
        b=AvHo2U2XcO+OrTBmYwGiKGP9YbCaJts/39DwURiSbPOK+FDi2IWTFM4LC3NcUKuAg7
         xaZ+rkylL6/J7rfnAo/91+H6ktEU+6Fz7D3wxdgwj+1BlSE0ccYCK8YM9pJJaMM2APLu
         NDivHB32BNz0f5r8YPR0nqNVzBwuCxAAtu8d6O1NxkgkacYNPj6kwoZlpNxU22u78Osb
         PNcJUQRL9uJeq2VEr4atHs2NVwHCI3qo05XAER3lpfR575MDYWg8mV0TX57Pjp87i7lo
         GbL1lKkAP9ao6So0cpNcPYpYemkQcu2L1bQ8RdXDTsD5/M6JRALOsCGro51NNSjlGObn
         7HNg==
X-Gm-Message-State: AOAM532jf8IutC0uxnSqtpDuKSyT/4vP+zr1skd35hD83OoliMTYkII1
	9Qav5Iiw85WlkFncG/70nDwtB26elnSdtEhtMEHn+w==
X-Google-Smtp-Source: ABdhPJzLweZ2gWVrJX3YSDveiu6zw2BvFRBT9aUGH49fJ7IRtaC1BrHxClMnAX1i1/Q07nT3OKxLFXdQmGgCcg93mP8=
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr19942455ejb.264.1607378445657;
 Mon, 07 Dec 2020 14:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20201006010013.848302-1-santosh@fossix.org>
In-Reply-To: <20201006010013.848302-1-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 7 Dec 2020 14:00:43 -0800
Message-ID: <CAPcyv4jEpw2Yvj1eVNaW6z7D=pf31w1cQXuF9ymqxckhxANeCQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3] testing/nvdimm: Add test module for non-nfit platforms
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: RUHUFF2LPNXV6JEG722PXWS7TCZXNVKC
X-Message-ID-Hash: RUHUFF2LPNXV6JEG722PXWS7TCZXNVKC
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux NVDIMM <linux-nvdimm@lists.01.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RUHUFF2LPNXV6JEG722PXWS7TCZXNVKC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 5, 2020 at 6:01 PM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> The current test module cannot be used for testing platforms (make check)
> that do no have support for NFIT. In order to get the ndctl tests working,
> we need a module which can emulate NVDIMM devices without relying on
> ACPI/NFIT.
>
> The aim of this proposed module is to implement a similar functionality to the
> existing module but without the ACPI dependencies. Currently interleaving and
> error injection are not implemented.
>
> Corresponding changes for ndctl is also required, to skip tests that depend
> on nfit attributes, which will be sent as a reply to this.

Looks pretty good to me. Some minor comments below. Probably the
biggest feedback is that I'd like to be able to run tests against
nfit_test.ko and ndtest.ko without reconfiguring/recompiling. I.e. on
x86 run both tests, on non-ACPI-NFIT, just run ndtest.

>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  tools/testing/nvdimm/config_check.c |   3 +-
>  tools/testing/nvdimm/test/Kbuild    |   6 +-
>  tools/testing/nvdimm/test/ndtest.c  | 819 ++++++++++++++++++++++++++++
>  tools/testing/nvdimm/test/ndtest.h  |  65 +++
>  4 files changed, 891 insertions(+), 2 deletions(-)
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

This defeats the purpose of having a safety check for nfit_test.ko.
So, I think this wants to be split into a config_check for
nfit_test.ko builds and a separate one for ndtest.ko builds.

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

Rather than an if-else I'd prefer to always build ndtest.ko and
optionally build nfit_test.ko.

>  nfit_test_iomap-y := iomap.o
> diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
> new file mode 100644
> index 000000000000..415a40345584
> --- /dev/null
> +++ b/tools/testing/nvdimm/test/ndtest.c
> @@ -0,0 +1,819 @@
> +// SPDX-License-Identifier: GPL-2.0-only
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
> +#define NFIT_DIMM_HANDLE(node, socket, imc, chan, dimm)         \
> +       (((node & 0xfff) << 16) | ((socket & 0xf) << 12) \
> +        | ((imc & 0xf) << 8) | ((chan & 0xf) << 4) | (dimm & 0xf))
> +
> +static struct ndtest_dimm dimm_group1[] = {
> +       {
> +               .type = NDTEST_REGION_TYPE_BLK | NDTEST_REGION_TYPE_PMEM,
> +               .size = DIMM_SIZE,
> +               .handle = NFIT_DIMM_HANDLE(0, 0, 0, 0, 0),
> +               .uuid_str = "1e5c75d2-b618-11ea-9aa3-507b9ddc0f72",
> +               .physical_id = 0,
> +       },
> +       {
> +               .type = NDTEST_REGION_TYPE_PMEM,
> +               .size = DIMM_SIZE,
> +               .handle = NFIT_DIMM_HANDLE(0, 0, 0, 0, 1),
> +               .uuid_str = "1c4d43ac-b618-11ea-be80-507b9ddc0f72",
> +               .physical_id = 1,
> +       },
> +       {
> +               .type = NDTEST_REGION_TYPE_PMEM,
> +               .size = DIMM_SIZE * 2,
> +               .handle = NFIT_DIMM_HANDLE(0, 0, 1, 0, 0),
> +               .uuid_str = "a9f17ffc-b618-11ea-b36d-507b9ddc0f72",
> +               .physical_id = 2,
> +       },
> +       {
> +               .type = NDTEST_REGION_TYPE_BLK,
> +               .size = DIMM_SIZE,
> +               .handle = NFIT_DIMM_HANDLE(0, 0, 1, 0, 1),
> +               .uuid_str = "b6b83b22-b618-11ea-8aae-507b9ddc0f72",
> +               .physical_id = 3,
> +       },
> +       {
> +               .type = NDTEST_REGION_TYPE_PMEM,
> +               .size = DIMM_SIZE,
> +               .handle = NFIT_DIMM_HANDLE(0, 1, 0, 0, 0),
> +               .uuid_str = "bf9baaee-b618-11ea-b181-507b9ddc0f72",
> +               .physical_id = 4,
> +       },
> +};
> +
> +static struct ndtest_dimm dimm_group2[] = {
> +       {
> +               .type = NDTEST_REGION_TYPE_PMEM,
> +               .size = DIMM_SIZE,
> +               .handle = NFIT_DIMM_HANDLE(1, 0, 0, 0, 0),
> +               .uuid_str = "ca0817e2-b618-11ea-9db3-507b9ddc0f72",
> +               .physical_id = 0,
> +       },
> +};
> +
> +static struct ndtest_config bus_configs[NUM_INSTANCES] = {
> +       /* bus 1 */
> +       {
> +               .dimm_start = 0,
> +               .dimm_count = ARRAY_SIZE(dimm_group1),
> +               .dimm = dimm_group1,
> +       },
> +       /* bus 2 */
> +       {
> +               .dimm_start = ARRAY_SIZE(dimm_group1),
> +               .dimm_count = ARRAY_SIZE(dimm_group2),
> +               .dimm = dimm_group2,
> +       },
> +};
> +
> +static DEFINE_SPINLOCK(ndtest_lock);
> +static struct ndtest_priv *instances[NUM_INSTANCES];
> +static struct class *ndtest_dimm_class;
> +static struct gen_pool *ndtest_pool;
> +
> +static inline struct ndtest_priv *to_ndtest_priv(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +
> +       return container_of(pdev, struct ndtest_priv, pdev);
> +}
> +
> +static int ndtest_config_get(struct ndtest_dimm *p, unsigned int buf_len,
> +                            struct nd_cmd_get_config_data_hdr *hdr)
> +{
> +       unsigned int len;
> +
> +       if ((hdr->in_offset + hdr->in_length) > LABEL_SIZE)
> +               return -EINVAL;
> +
> +       hdr->status = 0;
> +       len = min(hdr->in_length, LABEL_SIZE - hdr->in_offset);
> +       memcpy(hdr->out_buf, p->label_area + hdr->in_offset, len);
> +
> +       return buf_len - len;
> +}
> +
> +static int ndtest_config_set(struct ndtest_dimm *p, unsigned int buf_len,
> +                            struct nd_cmd_set_config_hdr *hdr)
> +{
> +       unsigned int len;
> +
> +       if ((hdr->in_offset + hdr->in_length) > LABEL_SIZE)
> +               return -EINVAL;
> +
> +       len = min(hdr->in_length, LABEL_SIZE - hdr->in_offset);
> +       memcpy(p->label_area + hdr->in_offset, hdr->in_buf, len);
> +
> +       return buf_len - len;
> +}
> +
> +static int ndtest_ctl(struct nvdimm_bus_descriptor *nd_desc,
> +                    struct nvdimm *nvdimm, unsigned int cmd, void *buf,
> +                    unsigned int buf_len, int *cmd_rc)
> +{
> +       struct nd_cmd_get_config_size *size;
> +       struct ndtest_dimm *p;
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
> +       p = nvdimm_provider_data(nvdimm);
> +       if (!p)
> +               return -EINVAL;
> +
> +       /* Failures for a DIMM can be injected using fail_cmd and
> +        * fail_cmd_code, see the device attributes below
> +        */
> +       if (p->fail_cmd)
> +               return p->fail_cmd_code ? p->fail_cmd_code : -EIO;
> +
> +       switch (cmd) {
> +       case ND_CMD_GET_CONFIG_SIZE:
> +               size = (struct nd_cmd_get_config_size *) buf;
> +               size->status = 0;
> +               size->max_xfer = 8;
> +               size->config_size = p->config_size;
> +               *cmd_rc = 0;
> +               break;
> +
> +       case ND_CMD_GET_CONFIG_DATA:
> +               *cmd_rc = ndtest_config_get(p, buf_len, buf);
> +               break;
> +
> +       case ND_CMD_SET_CONFIG_DATA:
> +               *cmd_rc = ndtest_config_set(p, buf_len, buf);
> +               break;
> +       default:
> +               dev_dbg(p->dev, "invalid command %u\n", cmd);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static ssize_t handle_show(struct device *dev, struct device_attribute *attr,
> +               char *buf)
> +{
> +       struct ndtest_dimm *dimm = dev_get_drvdata(dev);
> +
> +       return sprintf(buf, "%#x\n", dimm->handle);
> +}
> +static DEVICE_ATTR_RO(handle);
> +
> +static ssize_t fail_cmd_show(struct device *dev, struct device_attribute *attr,
> +               char *buf)
> +{
> +       struct ndtest_dimm *dimm = dev_get_drvdata(dev);
> +
> +       return sprintf(buf, "%#lx\n", dimm->fail_cmd);
> +}
> +
> +static ssize_t fail_cmd_store(struct device *dev, struct device_attribute *attr,
> +               const char *buf, size_t size)
> +{
> +       struct ndtest_dimm *dimm = dev_get_drvdata(dev);
> +       unsigned long val;
> +       ssize_t rc;
> +
> +       rc = kstrtol(buf, 0, &val);
> +       if (rc)
> +               return rc;
> +
> +       dimm->fail_cmd = val;
> +       return size;
> +}
> +static DEVICE_ATTR_RW(fail_cmd);
> +
> +static ssize_t fail_cmd_code_show(struct device *dev, struct device_attribute *attr,
> +               char *buf)
> +{
> +       struct ndtest_dimm *dimm = dev_get_drvdata(dev);
> +
> +       return sprintf(buf, "%d\n", dimm->fail_cmd_code);
> +}
> +
> +static ssize_t fail_cmd_code_store(struct device *dev, struct device_attribute *attr,
> +               const char *buf, size_t size)
> +{
> +       struct ndtest_dimm *dimm = dev_get_drvdata(dev);
> +       unsigned long val;
> +       ssize_t rc;
> +
> +       rc = kstrtol(buf, 0, &val);
> +       if (rc)
> +               return rc;
> +
> +       dimm->fail_cmd_code = val;
> +       return size;
> +}
> +static DEVICE_ATTR_RW(fail_cmd_code);
> +
> +static struct attribute *dimm_attributes[] = {
> +       &dev_attr_handle.attr,
> +       &dev_attr_fail_cmd.attr,
> +       &dev_attr_fail_cmd_code.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group dimm_attribute_group = {
> +       .attrs = dimm_attributes,
> +};
> +
> +static const struct attribute_group *dimm_attribute_groups[] = {
> +       &dimm_attribute_group,
> +       NULL,
> +};
> +
> +static void put_dimms(void *data)
> +{
> +       struct ndtest_priv *p = data;
> +       int i;
> +
> +       for (i = 0; i < p->config->dimm_count; i++)
> +               if (p->config->dimm[i].dev) {
> +                       device_unregister(p->config->dimm[i].dev);
> +                       p->config->dimm[i].dev = NULL;
> +               }
> +}
> +
> +#define NDTEST_SCM_DIMM_CMD_MASK          \
> +       ((1ul << ND_CMD_GET_CONFIG_SIZE) | \
> +        (1ul << ND_CMD_GET_CONFIG_DATA) | \
> +        (1ul << ND_CMD_SET_CONFIG_DATA))
> +
> +static ssize_t phys_id_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct nvdimm *nvdimm = to_nvdimm(dev);
> +       struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
> +
> +       return sprintf(buf, "%#x\n", dimm->physical_id);
> +}
> +static DEVICE_ATTR_RO(phys_id);
> +
> +static ssize_t vendor_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "0x1234567\n");
> +}
> +static DEVICE_ATTR_RO(vendor);
> +
> +static ssize_t id_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct nvdimm *nvdimm = to_nvdimm(dev);
> +       struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
> +
> +       return sprintf(buf, "%04x-%02x-%04x-%08x", 0xabcd,
> +                      0xa, 2016, ~(dimm->handle));
> +}
> +static DEVICE_ATTR_RO(id);
> +
> +static ssize_t nvdimm_handle_show(struct device *dev,
> +                                 struct device_attribute *attr, char *buf)
> +{
> +       struct nvdimm *nvdimm = to_nvdimm(dev);
> +       struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
> +
> +       return sprintf(buf, "%#x\n", dimm->handle);
> +}
> +
> +static struct device_attribute dev_attr_nvdimm_show_handle =  {
> +       .attr   = { .name = "handle", .mode = 0444 },
> +       .show   = nvdimm_handle_show,
> +};
> +
> +static ssize_t subsystem_vendor_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "0x%04x\n", 0);
> +}
> +static DEVICE_ATTR_RO(subsystem_vendor);
> +
> +static ssize_t dirty_shutdown_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%d\n", 42);
> +}
> +static DEVICE_ATTR_RO(dirty_shutdown);
> +
> +static struct attribute *ndtest_nvdimm_attributes[] = {
> +       &dev_attr_nvdimm_show_handle.attr,
> +       &dev_attr_vendor.attr,
> +       &dev_attr_id.attr,
> +       &dev_attr_phys_id.attr,
> +       &dev_attr_subsystem_vendor.attr,
> +       &dev_attr_dirty_shutdown.attr,
> +       NULL,
> +};
> +
> +static umode_t ndtest_nvdimm_attr_visible(struct kobject *kobj,
> +                                       struct attribute *a, int n)
> +{
> +       return a->mode;
> +}
> +
> +static const struct attribute_group ndtest_nvdimm_attribute_group = {
> +       .attrs = ndtest_nvdimm_attributes,
> +       .is_visible = ndtest_nvdimm_attr_visible,
> +};
> +
> +static const struct attribute_group *ndtest_nvdimm_attribute_groups[] = {
> +       &ndtest_nvdimm_attribute_group,
> +       NULL,
> +};
> +
> +static int ndtest_blk_do_io(struct nd_blk_region *ndbr, resource_size_t dpa,
> +               void *iobuf, u64 len, int rw)
> +{
> +       struct ndtest_dimm *dimm = ndbr->blk_provider_data;
> +       struct ndtest_blk_mmio *mmio = dimm->mmio;
> +       struct nd_region *nd_region = &ndbr->nd_region;
> +       unsigned int lane;
> +
> +       lane = nd_region_acquire_lane(nd_region);
> +
> +       if (rw)
> +               memcpy(mmio->base + dpa, iobuf, len);
> +       else {
> +               memcpy(iobuf, mmio->base + dpa, len);
> +               arch_invalidate_pmem(mmio->base + dpa, len);
> +       }
> +
> +       nd_region_release_lane(nd_region, lane);
> +
> +       return 0;
> +}
> +
> +static int ndtest_blk_region_enable(struct nvdimm_bus *nvdimm_bus,
> +                                   struct device *dev)
> +{
> +       struct nd_blk_region *ndbr = to_nd_blk_region(dev);
> +       struct nvdimm *nvdimm;
> +       struct ndtest_dimm *p;
> +       struct ndtest_blk_mmio *mmio;
> +
> +       nvdimm = nd_blk_region_to_dimm(ndbr);
> +       p = nvdimm_provider_data(nvdimm);
> +
> +       nd_blk_region_set_provider_data(ndbr, p);
> +       p->region = to_nd_region(dev);
> +
> +       mmio = devm_kzalloc(dev, sizeof(struct ndtest_blk_mmio), GFP_KERNEL);
> +       if (!mmio)
> +               return -ENOMEM;
> +
> +       mmio->base = devm_nvdimm_memremap(dev, p->address, 12,
> +                                        nd_blk_memremap_flags(ndbr));
> +       if (!mmio->base) {
> +               dev_err(dev, "%s failed to map blk dimm\n", nvdimm_name(nvdimm));
> +               return -ENOMEM;
> +       }
> +
> +       p->mmio = mmio;
> +
> +       return 0;
> +}

Are there any ppc nvdimm that will use BLK mode? As far as I know
BLK-mode is only an abandoned mechanism in the ACPI specification, not
anything that has made it into a shipping implementation. I'd prefer
to not extend it if it's not necessary.

> +
> +static struct nfit_test_resource *ndtest_resource_lookup(resource_size_t addr)
> +{
> +       int i;
> +
> +       for (i = 0; i < NUM_INSTANCES; i++) {
> +               struct nfit_test_resource *n, *nfit_res = NULL;
> +               struct ndtest_priv *t = instances[i];
> +
> +               if (!t)
> +                       continue;
> +               spin_lock(&ndtest_lock);
> +               list_for_each_entry(n, &t->resources, list) {
> +                       if (addr >= n->res.start && (addr < n->res.start
> +                                               + resource_size(&n->res))) {
> +                               nfit_res = n;
> +                               break;
> +                       } else if (addr >= (unsigned long) n->buf
> +                                       && (addr < (unsigned long) n->buf
> +                                               + resource_size(&n->res))) {
> +                               nfit_res = n;
> +                               break;
> +                       }
> +               }
> +               spin_unlock(&ndtest_lock);
> +               if (nfit_res)
> +                       return nfit_res;
> +       }
> +
> +       pr_warn("Failed to get resource\n");
> +
> +       return NULL;
> +}
> +
> +static void ndtest_release_resource(void *data)
> +{
> +       struct nfit_test_resource *res  = data;
> +
> +       spin_lock(&ndtest_lock);
> +       list_del(&res->list);
> +       spin_unlock(&ndtest_lock);
> +
> +       if (resource_size(&res->res) >= DIMM_SIZE)
> +               gen_pool_free(ndtest_pool, res->res.start,
> +                               resource_size(&res->res));
> +       vfree(res->buf);
> +       kfree(res);
> +}
> +
> +static void *ndtest_alloc_resource(struct ndtest_priv *p, size_t size,
> +                                  dma_addr_t *dma)
> +{
> +       dma_addr_t __dma;
> +       void *buf;
> +       struct nfit_test_resource *res;
> +       struct genpool_data_align data = {
> +               .align = SZ_128M,
> +       };
> +
> +       res = kzalloc(sizeof(*res), GFP_KERNEL);
> +       if (!res)
> +               return NULL;
> +
> +       buf = vmalloc(size);
> +       if (size >= DIMM_SIZE)
> +               __dma = gen_pool_alloc_algo(ndtest_pool, size,
> +                                         gen_pool_first_fit_align, &data);
> +       else
> +               __dma = (unsigned long) buf;
> +
> +       if (!__dma)
> +               goto buf_err;
> +
> +       INIT_LIST_HEAD(&res->list);
> +       res->dev = &p->pdev.dev;
> +       res->buf = buf;
> +       res->res.start = __dma;
> +       res->res.end = __dma + size - 1;
> +       res->res.name = "NFIT";
> +       spin_lock_init(&res->lock);
> +       INIT_LIST_HEAD(&res->requests);
> +       spin_lock(&ndtest_lock);
> +       list_add(&res->list, &p->resources);
> +       spin_unlock(&ndtest_lock);
> +
> +       if (dma)
> +               *dma = __dma;
> +
> +       if (!devm_add_action(&p->pdev.dev, ndtest_release_resource, res))
> +               return res->buf;
> +
> +buf_err:
> +       if (__dma && size >= DIMM_SIZE)
> +               gen_pool_free(ndtest_pool, __dma, size);
> +       if (buf)
> +               vfree(buf);
> +       kfree(res);
> +
> +       return NULL;
> +}
> +
> +static int ndtest_dimm_register(struct ndtest_priv *priv,
> +                               struct ndtest_dimm *dimm, int id)
> +{
> +       struct device *dev = &priv->pdev.dev;
> +       struct nd_mapping_desc mapping;
> +       struct nd_region_desc *ndr_desc;
> +       struct nd_blk_region_desc ndbr_desc;
> +       unsigned long dimm_flags = 0;
> +
> +       if (dimm->type == NDTEST_REGION_TYPE_PMEM) {
> +               set_bit(NDD_ALIASING, &dimm_flags);
> +               if (priv->pdev.id == 0)
> +                       set_bit(NDD_LABELING, &dimm_flags);
> +       }
> +
> +       dimm->nvdimm = nvdimm_create(priv->bus, dimm,
> +                                   ndtest_nvdimm_attribute_groups, dimm_flags,
> +                                   NDTEST_SCM_DIMM_CMD_MASK, 0, NULL);
> +       if (!dimm->nvdimm) {
> +               dev_err(dev, "Error creating DIMM object for %pOF\n", priv->dn);
> +               return -ENXIO;
> +       }
> +
> +       memset(&mapping, 0, sizeof(mapping));
> +       memset(&ndbr_desc, 0, sizeof(ndbr_desc));
> +
> +       /* now add the region */
> +       memset(&mapping, 0, sizeof(mapping));
> +       mapping.nvdimm = dimm->nvdimm;
> +       mapping.start = dimm->res.start;
> +       mapping.size = dimm->size;
> +
> +       ndr_desc = &ndbr_desc.ndr_desc;
> +       memset(ndr_desc, 0, sizeof(*ndr_desc));
> +       ndr_desc->res = &dimm->res;
> +       ndr_desc->provider_data = dimm;
> +       ndr_desc->mapping = &mapping;
> +       ndr_desc->num_mappings = 1;
> +       ndr_desc->nd_set = &dimm->nd_set;
> +       ndr_desc->num_lanes = 1;
> +
> +       if (dimm->type & NDTEST_REGION_TYPE_BLK) {
> +               ndbr_desc.enable = ndtest_blk_region_enable;
> +               ndbr_desc.do_io = ndtest_blk_do_io;
> +               dimm->region = nvdimm_blk_region_create(priv->bus, ndr_desc);
> +       } else
> +               dimm->region = nvdimm_pmem_region_create(priv->bus, ndr_desc);
> +
> +       if (!dimm->region) {
> +               dev_err(dev, "Error registering region %pR\n", ndr_desc->res);
> +               return -ENXIO;
> +       }
> +
> +       dimm->dev = device_create_with_groups(ndtest_dimm_class,
> +                                            &priv->pdev.dev,
> +                                            0, dimm, dimm_attribute_groups,
> +                                            "test_dimm%d", id);
> +       if (!dimm->dev)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +static int ndtest_nvdimm_init(struct ndtest_priv *p)
> +{
> +       struct ndtest_dimm *d;
> +       u64 uuid[2];
> +       void *res;
> +       int i, id;
> +
> +       for (i = 0; i < p->config->dimm_count; i++) {
> +               d = &p->config->dimm[i];
> +               d->id = id = p->config->dimm_start + i;
> +               res = ndtest_alloc_resource(p, LABEL_SIZE, NULL);
> +               if (!res)
> +                       return -ENOMEM;
> +
> +               d->label_area = res;
> +               sprintf(d->label_area, "label%d", id);
> +               d->config_size = LABEL_SIZE;
> +               d->res.name = p->pdev.name;
> +
> +               if (uuid_parse(d->uuid_str, (uuid_t *) uuid))
> +                       pr_err("failed to parse UUID\n");
> +
> +               d->nd_set.cookie1 = cpu_to_le64(uuid[0]);
> +               d->nd_set.cookie2 = cpu_to_le64(uuid[1]);
> +
> +               switch (d->type) {
> +               case NDTEST_REGION_TYPE_PMEM:
> +                       /* setup the resource */
> +                       res = ndtest_alloc_resource(p, d->size,
> +                                                   &d->res.start);
> +                       if (!res)
> +                               return -ENOMEM;
> +
> +                       d->res.end = d->res.start + d->size - 1;
> +                       break;
> +               case NDTEST_REGION_TYPE_BLK:
> +                       WARN_ON(p->nblks > NUM_DCR);
> +
> +                       if (!ndtest_alloc_resource(p, d->size,
> +                                                  &p->dimm_dma[p->nblks]))
> +                               return -ENOMEM;
> +
> +                       if (!ndtest_alloc_resource(p, LABEL_SIZE,
> +                                   &p->label_dma[p->nblks]))
> +                               return -ENOMEM;
> +
> +                       if (!ndtest_alloc_resource(p, LABEL_SIZE,
> +                                   &p->dcr_dma[p->nblks]))
> +                               return -ENOMEM;
> +
> +                       d->address = p->dimm_dma[p->nblks];
> +                       p->nblks++;
> +
> +                       break;
> +               }
> +
> +               ndtest_dimm_register(p, d, id);
> +       }
> +
> +       return 0;
> +}
> +
> +static int ndtest_bus_register(struct ndtest_priv *p,
> +                              struct ndtest_config *config)
> +{
> +       p->config = &config[p->pdev.id];
> +
> +       p->bus_desc.ndctl = ndtest_ctl;
> +       p->bus_desc.module = THIS_MODULE;
> +       p->bus_desc.provider_name = NULL;
> +       p->bus_desc.cmd_mask =
> +               1UL << ND_CMD_ARS_CAP | 1UL << ND_CMD_ARS_START |
> +               1UL << ND_CMD_ARS_STATUS | 1UL << ND_CMD_CLEAR_ERROR |
> +               1UL << ND_CMD_CALL;
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
> +static int ndtest_probe(struct platform_device *pdev)
> +{
> +       struct ndtest_priv *p;
> +       int rc;
> +
> +       p = to_ndtest_priv(&pdev->dev);
> +       ndtest_bus_register(p, bus_configs);
> +
> +       p->dcr_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
> +                                sizeof(dma_addr_t), GFP_KERNEL);
> +       p->label_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
> +                                  sizeof(dma_addr_t), GFP_KERNEL);
> +       p->dimm_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
> +                                 sizeof(dma_addr_t), GFP_KERNEL);
> +
> +       rc = ndtest_nvdimm_init(p);
> +       if (rc)
> +               goto err;
> +
> +       rc = devm_add_action_or_reset(&pdev->dev, put_dimms, p);
> +       if (rc)
> +               goto err;
> +
> +       platform_set_drvdata(pdev, p);
> +
> +       return 0;
> +
> +err:
> +       nvdimm_bus_unregister(p->bus);
> +       kfree(p->bus_desc.provider_name);
> +       put_device(&pdev->dev);
> +       kfree(p);
> +       return rc;
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
> +       nfit_test_setup(ndtest_resource_lookup, NULL);

Since this is now generic shared infrastructure between the 2
implementations nfit_test_setup() wants an ndtest_setup() rename.
Anything that is shared between ndtest and nfit_test can just be
called ndtest.

> +
> +       ndtest_dimm_class = class_create(THIS_MODULE, "nfit_test_dimm");
> +       if (IS_ERR(ndtest_dimm_class)) {
> +               rc = PTR_ERR(ndtest_dimm_class);
> +               goto err_register;
> +       }
> +
> +       ndtest_pool = gen_pool_create(ilog2(SZ_4M), NUMA_NO_NODE);
> +       if (!ndtest_pool) {
> +               rc = -ENOMEM;
> +               goto err_register;
> +       }
> +
> +       if (gen_pool_add(ndtest_pool, SZ_4G, SZ_4G, NUMA_NO_NODE)) {
> +               rc = -ENOMEM;
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
> +       if (ndtest_pool)
> +               gen_pool_destroy(ndtest_pool);
> +
> +       for (i = 0; i < NUM_INSTANCES; i++)
> +               if (instances[i])
> +                       platform_device_unregister(&instances[i]->pdev);
> +
> +       nfit_test_teardown();
> +       for (i = 0; i < NUM_INSTANCES; i++)
> +               if (instances[i])
> +                       put_device(&instances[i]->pdev.dev);
> +
> +       return rc;
> +}
> +
> +static __exit void ndtest_exit(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < NUM_INSTANCES; i++)
> +               platform_device_unregister(&instances[i]->pdev);
> +
> +       platform_driver_unregister(&ndtest_driver);
> +       nfit_test_teardown();
> +
> +       gen_pool_destroy(ndtest_pool);
> +
> +       for (i = 0; i < NUM_INSTANCES; i++)
> +               put_device(&instances[i]->pdev.dev);
> +       class_destroy(ndtest_dimm_class);
> +}
> +
> +module_init(ndtest_init);
> +module_exit(ndtest_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("IBM Corporation");
> diff --git a/tools/testing/nvdimm/test/ndtest.h b/tools/testing/nvdimm/test/ndtest.h
> new file mode 100644
> index 000000000000..2e8ff749e2f4
> --- /dev/null
> +++ b/tools/testing/nvdimm/test/ndtest.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef NDTEST_H
> +#define NDTEST_H
> +
> +#include <linux/platform_device.h>
> +#include <linux/libnvdimm.h>
> +
> +enum dimm_type {
> +       NDTEST_REGION_TYPE_PMEM = 0x0,
> +       NDTEST_REGION_TYPE_BLK = 0x1,
> +};
> +
> +struct ndtest_priv {
> +       struct platform_device pdev;
> +       struct device_node *dn;
> +       struct list_head resources;
> +       struct nvdimm_bus_descriptor bus_desc;
> +       struct nvdimm_bus *bus;
> +       struct ndtest_config *config;
> +
> +       dma_addr_t *dcr_dma;
> +       dma_addr_t *label_dma;
> +       dma_addr_t *dimm_dma;
> +       bool is_volatile;
> +       unsigned int flags;
> +       unsigned int nblks;
> +};
> +
> +struct ndtest_blk_mmio {
> +       void __iomem *base;
> +       u64 size;
> +       u64 base_offset;
> +       u32 line_size;
> +       u32 num_lines;
> +       u32 table_size;
> +};
> +
> +struct ndtest_dimm {
> +       struct resource res;
> +       struct device *dev;
> +       struct nvdimm *nvdimm;
> +       struct nd_region *region;
> +       struct nd_interleave_set nd_set;
> +       struct ndtest_blk_mmio *mmio;
> +
> +       dma_addr_t address;
> +       unsigned long config_size;
> +       unsigned long fail_cmd;
> +       void *label_area;
> +       char *uuid_str;

I'm curious, what is the role of this UUID?

> +       enum dimm_type type;
> +       unsigned int size;
> +       unsigned int handle;
> +       unsigned int physical_id;
> +       int id;
> +       int fail_cmd_code;
> +};
> +
> +struct ndtest_config {
> +       unsigned int dimm_count;
> +       unsigned int dimm_start;
> +       struct ndtest_dimm *dimm;
> +};
> +
> +#endif /* NDTEST_H */
> --
> 2.26.2
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
