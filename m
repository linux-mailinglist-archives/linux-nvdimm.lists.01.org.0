Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2624219BA90
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Apr 2020 05:08:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2CBFE10FC5348;
	Wed,  1 Apr 2020 20:09:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CA13410FC5345
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 20:09:13 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id cf14so2336170edb.13
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 20:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cbl131YS54TnKhRjVqs8kSk2M/FHBT7Yhz+2JuqO7bQ=;
        b=bo19BLmEKB5mbH2GKKSkjf0Ify2vKzeAi/EDzrtspq6rQJ82vUuZmPlhkPD1yovK3l
         jMS51leWKSS51kpPtMj1ir4zbmpaNg9DDbXcQnUsXD2xHvT98jDAAql5SIGNe6tJA9Mu
         QxitgzJrOxctl3oaJViuhRbj2F3SfauTdLoZg2G2sfdrIQR9gvUJmv14xxbnfmbZRu7N
         PBEjS9Tayu5Lz45oUCjrRzSkNYyVHcG6oGHJE9EQ9x6xgjmQsZOdPwzxXWMm5+FAhNs0
         I8ctLWhN5L6pbNIXHfNJi8fLa2fLV0f09DzLZcKTssf1dI1l8zwX/OBEHI7va1bNUZNZ
         TFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cbl131YS54TnKhRjVqs8kSk2M/FHBT7Yhz+2JuqO7bQ=;
        b=mldQpC96RSPVp8gaHvroQhWUKfZMdU11Wi4q6Ure73UlwOdKczTc//7dJFtg/XrWPx
         yf/QEHJWqyOI7zhIuxUwLbY71GVMty/VgGjk95UmtidyWAXDbE7zI35PQBadn7DReXLZ
         ZqaRtsX59qV4Deg3cQ/qEXfwiyHU6Q54iMQdq0BsAiFaIHCXc90yu8zcz9Yn9Jfm3QIE
         MAfXmQSNFf9ZtrtUTBuAWAQ6FUug/5jEsPPAiuKx9eEAAhyYKALbSz+Jym6VRKVwYwaI
         qMbPBR20kQxHEoPNdKe7OYMrwohhxV3bGEv5n+HuE1SA2bT9N1HbrY4wWlf5V+KzMVR4
         0qyA==
X-Gm-Message-State: AGi0PuYdK6BUi6DNaMTaXMLKb0LM2lCmKfayXRq9Rv7B4cPrM4og4Zl0
	HfS0lFVPsKejV26BXgxT7fobAAbRUvvqSruBy0GbcA==
X-Google-Smtp-Source: APiQypJEAh4CmO9aPsI9h/J4UYYnlBR7nyPAdfLBaf7cDXQqqyOXmZy4BLDtiEDiMHMhJXFa3m20XptAp4E7f6dTCVk=
X-Received: by 2002:a17:906:dbd4:: with SMTP id yc20mr1118493ejb.335.1585796901904;
 Wed, 01 Apr 2020 20:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200331143229.306718-1-vaibhav@linux.ibm.com> <20200331143229.306718-2-vaibhav@linux.ibm.com>
In-Reply-To: <20200331143229.306718-2-vaibhav@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2020 20:08:10 -0700
Message-ID: <CAPcyv4h5Nu4u-SSSOKtHr14ERGUw97EfH5eZR77ThcnqMqxJLg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] powerpc/papr_scm: Fetch nvdimm health information
 from PHYP
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: IAF5PYBOYYNYL56BBVKC355VDLEPZITP
X-Message-ID-Hash: IAF5PYBOYYNYL56BBVKC355VDLEPZITP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <ellerman@au1.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IAF5PYBOYYNYL56BBVKC355VDLEPZITP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 31, 2020 at 7:33 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Implement support for fetching nvdimm health information via
> H_SCM_HEALTH hcall as documented in Ref[1]. The hcall returns a pair
> of 64-bit big-endian integers which are then stored in 'struct
> papr_scm_priv' and subsequently partially exposed to user-space via
> newly introduced dimm specific attribute 'papr_flags'. Also a new asm
> header named 'papr-scm.h' is added that describes the interface
> between PHYP and guest kernel.
>
> Following flags are reported via 'papr_flags' sysfs attribute contents
> of which are space separated string flags indicating various nvdimm
> states:
>
>  * "not_armed"  : Indicating that nvdimm contents wont survive a power
>                    cycle.

s/wont/will not/

>  * "save_fail"  : Indicating that nvdimm contents couldn't be flushed
>                    during last shutdown event.

In the nfit definition this description is "flush_fail". The
"save_fail" flag was specific to hybrid devices that don't have
persistent media and instead scuttle away data from DRAM to flash on
power-failure.

>  * "restore_fail": Indicating that nvdimm contents couldn't be restored
>                    during dimm initialization.
>  * "encrypted"  : Dimm contents are encrypted.

This does not seem like a health flag to me, have you considered the
libnvdimm security interface for this indicator?

>  * "smart_notify": There is health event for the nvdimm.

Are you also going to signal the sysfs attribute when this event happens?

>  * "scrubbed"   : Indicating that contents of the nvdimm have been
>                    scrubbed.

This one seems odd to me what does it mean if it is not set? What does
it mean if a new scrub has been launched. Basically, is there value in
exposing this state?

>  * "locked"     : Indicating that nvdimm contents cant be modified
>                    until next power cycle.

There is the generic NDD_LOCKED flag, can you use that? ...and in
general I wonder if we should try to unify all the common papr_scm and
nfit health flags in a generic location. It will already be the case
the ndctl needs to look somewhere papr specific for this data maybe it
all should have been generic from the beginning.


In any event, can you also add this content to a new
Documentation/ABI/testing/sysfs-bus-papr? See sysfs-bus-nfit for
comparison.

>
> [1]: commit 58b278f568f0 ("powerpc: Provide initial documentation for
> PAPR hcalls")
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
>
> v4..v5 : None
>
> v3..v4 : None
>
> v2..v3 : Removed PAPR_SCM_DIMM_HEALTH_NON_CRITICAL as a condition for
>          NVDIMM unarmed [Aneesh]
>
> v1..v2 : New patch in the series.
> ---
>  arch/powerpc/include/asm/papr_scm.h       |  48 ++++++++++
>  arch/powerpc/platforms/pseries/papr_scm.c | 105 +++++++++++++++++++++-
>  2 files changed, 151 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/papr_scm.h
>
> diff --git a/arch/powerpc/include/asm/papr_scm.h b/arch/powerpc/include/asm/papr_scm.h
> new file mode 100644
> index 000000000000..868d3360f56a
> --- /dev/null
> +++ b/arch/powerpc/include/asm/papr_scm.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Structures and defines needed to manage nvdimms for spapr guests.
> + */
> +#ifndef _ASM_POWERPC_PAPR_SCM_H_
> +#define _ASM_POWERPC_PAPR_SCM_H_
> +
> +#include <linux/types.h>
> +#include <asm/bitsperlong.h>
> +
> +/* DIMM health bitmap bitmap indicators */
> +/* SCM device is unable to persist memory contents */
> +#define PAPR_SCM_DIMM_UNARMED                  PPC_BIT(0)
> +/* SCM device failed to persist memory contents */
> +#define PAPR_SCM_DIMM_SHUTDOWN_DIRTY           PPC_BIT(1)
> +/* SCM device contents are persisted from previous IPL */
> +#define PAPR_SCM_DIMM_SHUTDOWN_CLEAN           PPC_BIT(2)
> +/* SCM device contents are not persisted from previous IPL */
> +#define PAPR_SCM_DIMM_EMPTY                    PPC_BIT(3)
> +/* SCM device memory life remaining is critically low */
> +#define PAPR_SCM_DIMM_HEALTH_CRITICAL          PPC_BIT(4)
> +/* SCM device will be garded off next IPL due to failure */
> +#define PAPR_SCM_DIMM_HEALTH_FATAL             PPC_BIT(5)
> +/* SCM contents cannot persist due to current platform health status */
> +#define PAPR_SCM_DIMM_HEALTH_UNHEALTHY         PPC_BIT(6)
> +/* SCM device is unable to persist memory contents in certain conditions */
> +#define PAPR_SCM_DIMM_HEALTH_NON_CRITICAL      PPC_BIT(7)
> +/* SCM device is encrypted */
> +#define PAPR_SCM_DIMM_ENCRYPTED                        PPC_BIT(8)
> +/* SCM device has been scrubbed and locked */
> +#define PAPR_SCM_DIMM_SCRUBBED_AND_LOCKED      PPC_BIT(9)
> +
> +/* Bits status indicators for health bitmap indicating unarmed dimm */
> +#define PAPR_SCM_DIMM_UNARMED_MASK (PAPR_SCM_DIMM_UNARMED |    \
> +                                       PAPR_SCM_DIMM_HEALTH_UNHEALTHY)
> +
> +/* Bits status indicators for health bitmap indicating unflushed dimm */
> +#define PAPR_SCM_DIMM_BAD_SHUTDOWN_MASK (PAPR_SCM_DIMM_SHUTDOWN_DIRTY)
> +
> +/* Bits status indicators for health bitmap indicating unrestored dimm */
> +#define PAPR_SCM_DIMM_BAD_RESTORE_MASK  (PAPR_SCM_DIMM_EMPTY)
> +
> +/* Bit status indicators for smart event notification */
> +#define PAPR_SCM_DIMM_SMART_EVENT_MASK (PAPR_SCM_DIMM_HEALTH_CRITICAL | \
> +                                          PAPR_SCM_DIMM_HEALTH_FATAL | \
> +                                          PAPR_SCM_DIMM_HEALTH_UNHEALTHY)
> +
> +#endif
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 0b4467e378e5..aaf2e4ab1f75 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>
>  #include <asm/plpar_wrappers.h>
> +#include <asm/papr_scm.h>
>
>  #define BIND_ANY_ADDR (~0ul)
>
> @@ -39,6 +40,13 @@ struct papr_scm_priv {
>         struct resource res;
>         struct nd_region *region;
>         struct nd_interleave_set nd_set;
> +
> +       /* Protect dimm data from concurrent access */
> +       struct mutex dimm_mutex;
> +
> +       /* Health information for the dimm */
> +       __be64 health_bitmap;
> +       __be64 health_bitmap_valid;
>  };
>
>  static int drc_pmem_bind(struct papr_scm_priv *p)
> @@ -144,6 +152,35 @@ static int drc_pmem_query_n_bind(struct papr_scm_priv *p)
>         return drc_pmem_bind(p);
>  }
>
> +static int drc_pmem_query_health(struct papr_scm_priv *p)
> +{
> +       unsigned long ret[PLPAR_HCALL_BUFSIZE];
> +       int64_t rc;
> +
> +       rc = plpar_hcall(H_SCM_HEALTH, ret, p->drc_index);
> +       if (rc != H_SUCCESS) {
> +               dev_err(&p->pdev->dev,
> +                        "Failed to query health information, Err:%lld\n", rc);
> +               return -ENXIO;
> +       }
> +
> +       /* Protect modifications to papr_scm_priv with the mutex */
> +       rc = mutex_lock_interruptible(&p->dimm_mutex);
> +       if (rc)
> +               return rc;
> +
> +       /* Store the retrieved health information in dimm platform data */
> +       p->health_bitmap = ret[0];
> +       p->health_bitmap_valid = ret[1];
> +
> +       dev_dbg(&p->pdev->dev,
> +               "Queried dimm health info. Bitmap:0x%016llx Mask:0x%016llx\n",
> +               be64_to_cpu(p->health_bitmap),
> +               be64_to_cpu(p->health_bitmap_valid));
> +
> +       mutex_unlock(&p->dimm_mutex);
> +       return 0;
> +}
>
>  static int papr_scm_meta_get(struct papr_scm_priv *p,
>                              struct nd_cmd_get_config_data_hdr *hdr)
> @@ -304,6 +341,67 @@ static inline int papr_scm_node(int node)
>         return min_node;
>  }
>
> +static ssize_t papr_flags_show(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct nvdimm *dimm = to_nvdimm(dev);
> +       struct papr_scm_priv *p = nvdimm_provider_data(dimm);
> +       __be64 health;
> +       int rc;
> +
> +       rc = drc_pmem_query_health(p);
> +       if (rc)
> +               return rc;

This attribute is user readable which means userspace can trigger and
ongoing stream of device requests. Is that desired? The nfit driver
caches this flag data, and limits attributes with device side-effects
to root-only. The expectation is that ndctl submits commands to
retrieve the up to date state especially because that payload has
other interesting data like temperature that can't be cached.

> +
> +       /* Protect against modifications to papr_scm_priv with the mutex */

What papr_scm_priv modifications are you worried about because none of
the below looks like it needs to be locked, and papr_scm_priv had
better be stable otherwise the above usages would have crashed.

> +       rc = mutex_lock_interruptible(&p->dimm_mutex);
> +       if (rc)
> +               return rc;
> +
> +       health = p->health_bitmap & p->health_bitmap_valid;
> +
> +       /* Check for various masks in bitmap and set the buffer */
> +       if (health & PAPR_SCM_DIMM_UNARMED_MASK)
> +               rc += sprintf(buf, "not_armed ");
> +
> +       if (health & PAPR_SCM_DIMM_BAD_SHUTDOWN_MASK)
> +               rc += sprintf(buf + rc, "save_fail ");
> +
> +       if (health & PAPR_SCM_DIMM_BAD_RESTORE_MASK)
> +               rc += sprintf(buf + rc, "restore_fail ");
> +
> +       if (health & PAPR_SCM_DIMM_ENCRYPTED)
> +               rc += sprintf(buf + rc, "encrypted ");
> +
> +       if (health & PAPR_SCM_DIMM_SMART_EVENT_MASK)
> +               rc += sprintf(buf + rc, "smart_notify ");
> +
> +       if (health & PAPR_SCM_DIMM_SCRUBBED_AND_LOCKED)
> +               rc += sprintf(buf + rc, "scrubbed locked ");

See above about whether we event need this here...

> +
> +       if (rc > 0)
> +               rc += sprintf(buf + rc, "\n");
> +
> +       mutex_unlock(&p->dimm_mutex);
> +       return rc;
> +}
> +DEVICE_ATTR_RO(papr_flags);

Rather than name this attribute "papr_flags", I'd prefer "papr/flags".
I.e. create a "papr" sub-directory...

> +
> +/* papr_scm specific dimm attributes */
> +static struct attribute *papr_scm_nd_attributes[] = {
> +       &dev_attr_papr_flags.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group papr_scm_nd_attribute_group = {

...here:

       .name = "papr",

> +       .attrs = papr_scm_nd_attributes,
> +};
> +

With the continued discussions this is going to need I hope you
understand that I consider this v5.8 material.

> +static const struct attribute_group *papr_scm_dimm_attr_groups[] = {
> +       &papr_scm_nd_attribute_group,
> +       NULL,
> +};
> +
>  static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  {
>         struct device *dev = &p->pdev->dev;
> @@ -330,8 +428,8 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>         dimm_flags = 0;
>         set_bit(NDD_ALIASING, &dimm_flags);
>
> -       p->nvdimm = nvdimm_create(p->bus, p, NULL, dimm_flags,
> -                                 PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
> +       p->nvdimm = nvdimm_create(p->bus, p, papr_scm_dimm_attr_groups,
> +                                 dimm_flags, PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
>         if (!p->nvdimm) {
>                 dev_err(dev, "Error creating DIMM object for %pOF\n", p->dn);
>                 goto err;
> @@ -415,6 +513,9 @@ static int papr_scm_probe(struct platform_device *pdev)
>         if (!p)
>                 return -ENOMEM;
>
> +       /* Initialize the dimm mutex */
> +       mutex_init(&p->dimm_mutex);
> +
>         /* optional DT properties */
>         of_property_read_u32(dn, "ibm,metadata-size", &metadata_size);
>
> --
> 2.25.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
