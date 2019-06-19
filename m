Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C514C378
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Jun 2019 00:22:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B9DEB21962301;
	Wed, 19 Jun 2019 15:22:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7164A21962301
 for <linux-nvdimm@lists.01.org>; Wed, 19 Jun 2019 15:22:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id j19so711995otq.2
 for <linux-nvdimm@lists.01.org>; Wed, 19 Jun 2019 15:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JLIWBv2X26k8ET42TKlMXMS1gXCjDGiwK0UYPP+FX7I=;
 b=FIvxrSVw1kZBeTDVRhnpAgI9P09riLeW4exb5kAJlwidooK4IEmuvVZ6P3a/vf4+dj
 5HJSDkQba9G4aXf93voOMNwNnsBabP3nI6uD85lk9TqqzOE3fjY7L24cHvmKv9SUAJep
 XGtOmZJ8f6SGKkaVc83FYTj0cN6YpT59uuCncA4C2nQU/jBElDYUUSViuAzdrWTmXZeK
 SGB+d/0Rq4x9FU6GsfLjHDlNc3MN8XF6aNH1iSNLO2wPHfuRSfVd2jPdlEE5OVPhx3jW
 GRNb+wKgZ4uNEKQW3V9Cu2r2Ilh8QsomtjEhuaMCUWajlTIpmGLot2/oG6+XThLyfoPr
 0N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JLIWBv2X26k8ET42TKlMXMS1gXCjDGiwK0UYPP+FX7I=;
 b=kOPqSrYteYRPjJ0/+KYKja+nfz3ajGru8MrJQ3AIdRZZXA77gZqeTcMqLdJhFq+j+U
 nUObRTd67VlJ6eMTZThe0daYlh1yYH8n4T0DfeVlTsyakRr//fU24S0HIg96SFjW4AN4
 smM4IJdaaP/Njrx6sV6K/6BPD8ZZPIsPvpm3c/5VroazIFnRnIZ2fCyLzZAFyrAIPDbm
 Q/MtuqKyarcZjhmwECgoyMDO1WF5xAhQe3cASBCiRhZ8rcYAwXdl6n+D3pQhlBjXQTmn
 ArokhuzMcJNqj/+7KTY5GMu93iexg2fYeuZIwfPzvrbrCke8jlY7Z0rhxjZqR2V8kCSc
 11aw==
X-Gm-Message-State: APjAAAVMKX+O830LHi/BMGVCNqoph+6r0np8z0cqINcUTF21qjpqfakR
 zCjeXEjmjg1xOMLKEv8XI9GA0RcAaBXqGHMEtp+eIT2N
X-Google-Smtp-Source: APXvYqzWz4PTeeep52mtiAR3x+8qT9316cMGYH2B8qxpP0ZZ/7FW4dXOAhxWVAH1EVnWAa8xLhGw2qLQOOWebXKJJd4=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr36684261otf.126.1560982929611; 
 Wed, 19 Jun 2019 15:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <156029554317.419799.1324389595953183385.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156029557585.419799.11741877483838451695.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156029557585.419799.11741877483838451695.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 19 Jun 2019 15:21:58 -0700
Message-ID: <CAPcyv4h8QZBAC4kY3=mJVq0J8-W3aTLoT6h2b0WXFtymzToH-Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] driver-core, libnvdimm: Let device subsystems add
 local lockdep coverage
To: linux-nvdimm <linux-nvdimm@lists.01.org>
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
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jun 11, 2019 at 4:40 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> For good reason, the standard device_lock() is marked
> lockdep_set_novalidate_class() because there is simply no sane way to
> describe the myriad ways the device_lock() ordered with other locks.
> However, that leaves subsystems that know their own local device_lock()
> ordering rules to find lock ordering mistakes manually. Instead,
> introduce an optional / additional lockdep-enabled lock that a subsystem
> can acquire in all the same paths that the device_lock() is acquired.
>
> A conversion of the NFIT driver and NVDIMM subsystem to a
> lockdep-validate device_lock() scheme is included. The
> debug_nvdimm_lock() implementation implements the correct lock-class and
> stacking order for the libnvdimm device topology hierarchy.

Greg, Peter,

Any thoughts on carrying this debug hack upstream? The idea being that
it's impossible to enable lockdep for the device_lock() globally, but
a constrained usage of the proposed lockdep_mutex has proven enough to
flush out device_lock deadlocks from libnvdimm.

It appears one aspect that is missing from this patch proposal is a
mechanism / convention to make sure that lockdep_mutex has constrained
usage for a given kernel build, otherwise it's obviously just as
problematic as device_lock(). Other concerns?

> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/nfit/core.c        |   28 ++++++++--------
>  drivers/acpi/nfit/nfit.h        |   24 ++++++++++++++
>  drivers/base/core.c             |    3 ++
>  drivers/nvdimm/btt_devs.c       |   16 +++++----
>  drivers/nvdimm/bus.c            |   28 ++++++++++------
>  drivers/nvdimm/core.c           |   10 +++---
>  drivers/nvdimm/dimm_devs.c      |    4 +-
>  drivers/nvdimm/namespace_devs.c |   36 ++++++++++-----------
>  drivers/nvdimm/nd-core.h        |   68 +++++++++++++++++++++++++++++++++++++++
>  drivers/nvdimm/pfn_devs.c       |   24 +++++++-------
>  drivers/nvdimm/pmem.c           |    4 +-
>  drivers/nvdimm/region.c         |    2 +
>  drivers/nvdimm/region_devs.c    |   16 +++++----
>  include/linux/device.h          |    5 +++
>  14 files changed, 187 insertions(+), 81 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 23022cf20d26..f22139458ce1 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1282,7 +1282,7 @@ static ssize_t hw_error_scrub_store(struct device *dev,
>         if (rc)
>                 return rc;
>
> -       device_lock(dev);
> +       nfit_device_lock(dev);
>         nd_desc = dev_get_drvdata(dev);
>         if (nd_desc) {
>                 struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
> @@ -1299,7 +1299,7 @@ static ssize_t hw_error_scrub_store(struct device *dev,
>                         break;
>                 }
>         }
> -       device_unlock(dev);
> +       nfit_device_unlock(dev);
>         if (rc)
>                 return rc;
>         return size;
> @@ -1319,7 +1319,7 @@ static ssize_t scrub_show(struct device *dev,
>         ssize_t rc = -ENXIO;
>         bool busy;
>
> -       device_lock(dev);
> +       nfit_device_lock(dev);
>         nd_desc = dev_get_drvdata(dev);
>         if (!nd_desc) {
>                 device_unlock(dev);
> @@ -1339,7 +1339,7 @@ static ssize_t scrub_show(struct device *dev,
>         }
>
>         mutex_unlock(&acpi_desc->init_mutex);
> -       device_unlock(dev);
> +       nfit_device_unlock(dev);
>         return rc;
>  }
>
> @@ -1356,14 +1356,14 @@ static ssize_t scrub_store(struct device *dev,
>         if (val != 1)
>                 return -EINVAL;
>
> -       device_lock(dev);
> +       nfit_device_lock(dev);
>         nd_desc = dev_get_drvdata(dev);
>         if (nd_desc) {
>                 struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>
>                 rc = acpi_nfit_ars_rescan(acpi_desc, ARS_REQ_LONG);
>         }
> -       device_unlock(dev);
> +       nfit_device_unlock(dev);
>         if (rc)
>                 return rc;
>         return size;
> @@ -1749,9 +1749,9 @@ static void acpi_nvdimm_notify(acpi_handle handle, u32 event, void *data)
>         struct acpi_device *adev = data;
>         struct device *dev = &adev->dev;
>
> -       device_lock(dev->parent);
> +       nfit_device_lock(dev->parent);
>         __acpi_nvdimm_notify(dev, event);
> -       device_unlock(dev->parent);
> +       nfit_device_unlock(dev->parent);
>  }
>
>  static bool acpi_nvdimm_has_method(struct acpi_device *adev, char *method)
> @@ -3457,8 +3457,8 @@ static int acpi_nfit_flush_probe(struct nvdimm_bus_descriptor *nd_desc)
>         struct device *dev = acpi_desc->dev;
>
>         /* Bounce the device lock to flush acpi_nfit_add / acpi_nfit_notify */
> -       device_lock(dev);
> -       device_unlock(dev);
> +       nfit_device_lock(dev);
> +       nfit_device_unlock(dev);
>
>         /* Bounce the init_mutex to complete initial registration */
>         mutex_lock(&acpi_desc->init_mutex);
> @@ -3602,8 +3602,8 @@ void acpi_nfit_shutdown(void *data)
>          * acpi_nfit_ars_rescan() submissions have had a chance to
>          * either submit or see ->cancel set.
>          */
> -       device_lock(bus_dev);
> -       device_unlock(bus_dev);
> +       nfit_device_lock(bus_dev);
> +       nfit_device_unlock(bus_dev);
>
>         flush_workqueue(nfit_wq);
>  }
> @@ -3746,9 +3746,9 @@ EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
>
>  static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
>  {
> -       device_lock(&adev->dev);
> +       nfit_device_lock(&adev->dev);
>         __acpi_nfit_notify(&adev->dev, adev->handle, event);
> -       device_unlock(&adev->dev);
> +       nfit_device_unlock(&adev->dev);
>  }
>
>  static const struct acpi_device_id acpi_nfit_ids[] = {
> diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
> index 6ee2b02af73e..24241941181c 100644
> --- a/drivers/acpi/nfit/nfit.h
> +++ b/drivers/acpi/nfit/nfit.h
> @@ -312,6 +312,30 @@ static inline struct acpi_nfit_desc *to_acpi_desc(
>         return container_of(nd_desc, struct acpi_nfit_desc, nd_desc);
>  }
>
> +#ifdef CONFIG_PROVE_LOCKING
> +static inline void nfit_device_lock(struct device *dev)
> +{
> +       device_lock(dev);
> +       mutex_lock(&dev->lockdep_mutex);
> +}
> +
> +static inline void nfit_device_unlock(struct device *dev)
> +{
> +       mutex_unlock(&dev->lockdep_mutex);
> +       device_unlock(dev);
> +}
> +#else
> +static inline void nfit_device_lock(struct device *dev)
> +{
> +       device_lock(dev);
> +}
> +
> +static inline void nfit_device_unlock(struct device *dev)
> +{
> +       device_unlock(dev);
> +}
> +#endif
> +
>  const guid_t *to_nfit_uuid(enum nfit_uuids id);
>  int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, void *nfit, acpi_size sz);
>  void acpi_nfit_shutdown(void *data);
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index eaf3aa0cb803..4825949d6547 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1663,6 +1663,9 @@ void device_initialize(struct device *dev)
>         kobject_init(&dev->kobj, &device_ktype);
>         INIT_LIST_HEAD(&dev->dma_pools);
>         mutex_init(&dev->mutex);
> +#ifdef CONFIG_PROVE_LOCKING
> +       mutex_init(&dev->lockdep_mutex);
> +#endif
>         lockdep_set_novalidate_class(&dev->mutex);
>         spin_lock_init(&dev->devres_lock);
>         INIT_LIST_HEAD(&dev->devres_head);
> diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
> index 62d00fffa4af..3508a79110c7 100644
> --- a/drivers/nvdimm/btt_devs.c
> +++ b/drivers/nvdimm/btt_devs.c
> @@ -62,14 +62,14 @@ static ssize_t sector_size_store(struct device *dev,
>         struct nd_btt *nd_btt = to_nd_btt(dev);
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         rc = nd_size_select_store(dev, buf, &nd_btt->lbasize,
>                         btt_lbasize_supported);
>         dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
>                         buf[len - 1] == '\n' ? "" : "\n");
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc ? rc : len;
>  }
> @@ -91,11 +91,11 @@ static ssize_t uuid_store(struct device *dev,
>         struct nd_btt *nd_btt = to_nd_btt(dev);
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         rc = nd_uuid_store(dev, &nd_btt->uuid, buf, len);
>         dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
>                         buf[len - 1] == '\n' ? "" : "\n");
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc ? rc : len;
>  }
> @@ -120,13 +120,13 @@ static ssize_t namespace_store(struct device *dev,
>         struct nd_btt *nd_btt = to_nd_btt(dev);
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         rc = nd_namespace_store(dev, &nd_btt->ndns, buf, len);
>         dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
>                         buf[len - 1] == '\n' ? "" : "\n");
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc;
>  }
> @@ -138,14 +138,14 @@ static ssize_t size_show(struct device *dev,
>         struct nd_btt *nd_btt = to_nd_btt(dev);
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         if (dev->driver)
>                 rc = sprintf(buf, "%llu\n", nd_btt->size);
>         else {
>                 /* no size to convey if the btt instance is disabled */
>                 rc = -ENXIO;
>         }
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc;
>  }
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index c1d26fca9c4c..39700f6c8840 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -26,7 +26,7 @@
>
>  int nvdimm_major;
>  static int nvdimm_bus_major;
> -static struct class *nd_class;
> +struct class *nd_class;
>  static DEFINE_IDA(nd_ida);
>
>  static int to_nd_device_type(struct device *dev)
> @@ -91,7 +91,10 @@ static int nvdimm_bus_probe(struct device *dev)
>                         dev->driver->name, dev_name(dev));
>
>         nvdimm_bus_probe_start(nvdimm_bus);
> +       debug_nvdimm_lock(dev);
>         rc = nd_drv->probe(dev);
> +       debug_nvdimm_unlock(dev);
> +
>         if (rc == 0)
>                 nd_region_probe_success(nvdimm_bus, dev);
>         else
> @@ -113,8 +116,11 @@ static int nvdimm_bus_remove(struct device *dev)
>         struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
>         int rc = 0;
>
> -       if (nd_drv->remove)
> +       if (nd_drv->remove) {
> +               debug_nvdimm_lock(dev);
>                 rc = nd_drv->remove(dev);
> +               debug_nvdimm_unlock(dev);
> +       }
>         nd_region_disable(nvdimm_bus, dev);
>
>         dev_dbg(&nvdimm_bus->dev, "%s.remove(%s) = %d\n", dev->driver->name,
> @@ -140,7 +146,7 @@ static void nvdimm_bus_shutdown(struct device *dev)
>
>  void nd_device_notify(struct device *dev, enum nvdimm_event event)
>  {
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         if (dev->driver) {
>                 struct nd_device_driver *nd_drv;
>
> @@ -148,7 +154,7 @@ void nd_device_notify(struct device *dev, enum nvdimm_event event)
>                 if (nd_drv->notify)
>                         nd_drv->notify(dev, event);
>         }
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>  }
>  EXPORT_SYMBOL(nd_device_notify);
>
> @@ -296,7 +302,7 @@ static void nvdimm_bus_release(struct device *dev)
>         kfree(nvdimm_bus);
>  }
>
> -static bool is_nvdimm_bus(struct device *dev)
> +bool is_nvdimm_bus(struct device *dev)
>  {
>         return dev->release == nvdimm_bus_release;
>  }
> @@ -575,9 +581,9 @@ void nd_device_unregister(struct device *dev, enum nd_async_mode mode)
>                  * or otherwise let the async path handle it if the
>                  * unregistration was already queued.
>                  */
> -               device_lock(dev);
> +               nd_device_lock(dev);
>                 killed = kill_device(dev);
> -               device_unlock(dev);
> +               nd_device_unlock(dev);
>
>                 if (!killed)
>                         return;
> @@ -888,10 +894,10 @@ void wait_nvdimm_bus_probe_idle(struct device *dev)
>                 if (nvdimm_bus->probe_active == 0)
>                         break;
>                 nvdimm_bus_unlock(dev);
> -               device_unlock(dev);
> +               nd_device_unlock(dev);
>                 wait_event(nvdimm_bus->wait,
>                                 nvdimm_bus->probe_active == 0);
> -               device_lock(dev);
> +               nd_device_lock(dev);
>                 nvdimm_bus_lock(dev);
>         } while (true);
>  }
> @@ -1090,7 +1096,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
>                 goto out;
>         }
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         rc = nd_cmd_clear_to_send(nvdimm_bus, nvdimm, func, buf);
>         if (rc)
> @@ -1107,7 +1113,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
>                                 clear_err->cleared);
>         }
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         if (copy_to_user(p, buf, buf_len))
>                 rc = -EFAULT;
> diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
> index 5e1f060547bf..9204f1e9fd14 100644
> --- a/drivers/nvdimm/core.c
> +++ b/drivers/nvdimm/core.c
> @@ -246,7 +246,7 @@ static int nd_uuid_parse(struct device *dev, u8 *uuid_out, const char *buf,
>   *
>   * Enforce that uuids can only be changed while the device is disabled
>   * (driver detached)
> - * LOCKING: expects device_lock() is held on entry
> + * LOCKING: expects nd_device_lock() is held on entry
>   */
>  int nd_uuid_store(struct device *dev, u8 **uuid_out, const char *buf,
>                 size_t len)
> @@ -347,15 +347,15 @@ static DEVICE_ATTR_RO(provider);
>
>  static int flush_namespaces(struct device *dev, void *data)
>  {
> -       device_lock(dev);
> -       device_unlock(dev);
> +       nd_device_lock(dev);
> +       nd_device_unlock(dev);
>         return 0;
>  }
>
>  static int flush_regions_dimms(struct device *dev, void *data)
>  {
> -       device_lock(dev);
> -       device_unlock(dev);
> +       nd_device_lock(dev);
> +       nd_device_unlock(dev);
>         device_for_each_child(dev, NULL, flush_namespaces);
>         return 0;
>  }
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index dfecd6e17043..29a065e769ea 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -484,12 +484,12 @@ static ssize_t security_store(struct device *dev,
>          * done while probing is idle and the DIMM is not in active use
>          * in any region.
>          */
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         wait_nvdimm_bus_probe_idle(dev);
>         rc = __security_store(dev, buf, len);
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc;
>  }
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index a434a5964cb9..92cd809d7e43 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -410,7 +410,7 @@ static ssize_t alt_name_store(struct device *dev,
>         struct nd_region *nd_region = to_nd_region(dev->parent);
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         wait_nvdimm_bus_probe_idle(dev);
>         rc = __alt_name_store(dev, buf, len);
> @@ -418,7 +418,7 @@ static ssize_t alt_name_store(struct device *dev,
>                 rc = nd_namespace_label_update(nd_region, dev);
>         dev_dbg(dev, "%s(%zd)\n", rc < 0 ? "fail " : "", rc);
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc < 0 ? rc : len;
>  }
> @@ -1077,7 +1077,7 @@ static ssize_t size_store(struct device *dev,
>         if (rc)
>                 return rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         wait_nvdimm_bus_probe_idle(dev);
>         rc = __size_store(dev, val);
> @@ -1103,7 +1103,7 @@ static ssize_t size_store(struct device *dev,
>         dev_dbg(dev, "%llx %s (%d)\n", val, rc < 0 ? "fail" : "success", rc);
>
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc < 0 ? rc : len;
>  }
> @@ -1286,7 +1286,7 @@ static ssize_t uuid_store(struct device *dev,
>         } else
>                 return -ENXIO;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         wait_nvdimm_bus_probe_idle(dev);
>         if (to_ndns(dev)->claim)
> @@ -1302,7 +1302,7 @@ static ssize_t uuid_store(struct device *dev,
>         dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
>                         buf[len - 1] == '\n' ? "" : "\n");
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc < 0 ? rc : len;
>  }
> @@ -1376,7 +1376,7 @@ static ssize_t sector_size_store(struct device *dev,
>         } else
>                 return -ENXIO;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         if (to_ndns(dev)->claim)
>                 rc = -EBUSY;
> @@ -1387,7 +1387,7 @@ static ssize_t sector_size_store(struct device *dev,
>         dev_dbg(dev, "result: %zd %s: %s%s", rc, rc < 0 ? "tried" : "wrote",
>                         buf, buf[len - 1] == '\n' ? "" : "\n");
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc ? rc : len;
>  }
> @@ -1502,9 +1502,9 @@ static ssize_t holder_show(struct device *dev,
>         struct nd_namespace_common *ndns = to_ndns(dev);
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         rc = sprintf(buf, "%s\n", ndns->claim ? dev_name(ndns->claim) : "");
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc;
>  }
> @@ -1541,7 +1541,7 @@ static ssize_t holder_class_store(struct device *dev,
>         struct nd_region *nd_region = to_nd_region(dev->parent);
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         wait_nvdimm_bus_probe_idle(dev);
>         rc = __holder_class_store(dev, buf);
> @@ -1549,7 +1549,7 @@ static ssize_t holder_class_store(struct device *dev,
>                 rc = nd_namespace_label_update(nd_region, dev);
>         dev_dbg(dev, "%s(%zd)\n", rc < 0 ? "fail " : "", rc);
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc < 0 ? rc : len;
>  }
> @@ -1560,7 +1560,7 @@ static ssize_t holder_class_show(struct device *dev,
>         struct nd_namespace_common *ndns = to_ndns(dev);
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         if (ndns->claim_class == NVDIMM_CCLASS_NONE)
>                 rc = sprintf(buf, "\n");
>         else if ((ndns->claim_class == NVDIMM_CCLASS_BTT) ||
> @@ -1572,7 +1572,7 @@ static ssize_t holder_class_show(struct device *dev,
>                 rc = sprintf(buf, "dax\n");
>         else
>                 rc = sprintf(buf, "<unknown>\n");
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc;
>  }
> @@ -1586,7 +1586,7 @@ static ssize_t mode_show(struct device *dev,
>         char *mode;
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         claim = ndns->claim;
>         if (claim && is_nd_btt(claim))
>                 mode = "safe";
> @@ -1599,7 +1599,7 @@ static ssize_t mode_show(struct device *dev,
>         else
>                 mode = "raw";
>         rc = sprintf(buf, "%s\n", mode);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc;
>  }
> @@ -1703,8 +1703,8 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
>                  * Flush any in-progess probes / removals in the driver
>                  * for the raw personality of this namespace.
>                  */
> -               device_lock(&ndns->dev);
> -               device_unlock(&ndns->dev);
> +               nd_device_lock(&ndns->dev);
> +               nd_device_unlock(&ndns->dev);
>                 if (ndns->dev.driver) {
>                         dev_dbg(&ndns->dev, "is active, can't bind %s\n",
>                                         dev_name(dev));
> diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
> index 6cd470547106..0ac52b6eb00e 100644
> --- a/drivers/nvdimm/nd-core.h
> +++ b/drivers/nvdimm/nd-core.h
> @@ -9,6 +9,7 @@
>  #include <linux/sizes.h>
>  #include <linux/mutex.h>
>  #include <linux/nd.h>
> +#include "nd.h"
>
>  extern struct list_head nvdimm_bus_list;
>  extern struct mutex nvdimm_bus_list_mutex;
> @@ -182,4 +183,71 @@ ssize_t nd_namespace_store(struct device *dev,
>                 struct nd_namespace_common **_ndns, const char *buf,
>                 size_t len);
>  struct nd_pfn *to_nd_pfn_safe(struct device *dev);
> +bool is_nvdimm_bus(struct device *dev);
> +
> +#ifdef CONFIG_PROVE_LOCKING
> +extern struct class *nd_class;
> +
> +enum {
> +       LOCK_BUS,
> +       LOCK_NDCTL,
> +       LOCK_REGION,
> +       LOCK_DIMM = LOCK_REGION,
> +       LOCK_NAMESPACE,
> +       LOCK_CLAIM,
> +};
> +
> +static inline void debug_nvdimm_lock(struct device *dev)
> +{
> +       if (is_nd_region(dev))
> +               mutex_lock_nested(&dev->lockdep_mutex, LOCK_REGION);
> +       else if (is_nvdimm(dev))
> +               mutex_lock_nested(&dev->lockdep_mutex, LOCK_DIMM);
> +       else if (is_nd_btt(dev) || is_nd_pfn(dev) || is_nd_dax(dev))
> +               mutex_lock_nested(&dev->lockdep_mutex, LOCK_CLAIM);
> +       else if (dev->parent && (is_nd_region(dev->parent)))
> +               mutex_lock_nested(&dev->lockdep_mutex, LOCK_NAMESPACE);
> +       else if (is_nvdimm_bus(dev))
> +               mutex_lock_nested(&dev->lockdep_mutex, LOCK_BUS);
> +       else if (dev->class && dev->class == nd_class)
> +               mutex_lock_nested(&dev->lockdep_mutex, LOCK_NDCTL);
> +       else
> +               dev_WARN(dev, "unknown lock level\n");
> +}
> +
> +static inline void debug_nvdimm_unlock(struct device *dev)
> +{
> +       mutex_unlock(&dev->lockdep_mutex);
> +}
> +
> +static inline void nd_device_lock(struct device *dev)
> +{
> +       device_lock(dev);
> +       debug_nvdimm_lock(dev);
> +}
> +
> +static inline void nd_device_unlock(struct device *dev)
> +{
> +       debug_nvdimm_unlock(dev);
> +       device_unlock(dev);
> +}
> +#else
> +static inline void nd_device_lock(struct device *dev)
> +{
> +       device_lock(dev);
> +}
> +
> +static inline void nd_device_unlock(struct device *dev)
> +{
> +       device_unlock(dev);
> +}
> +
> +static inline void debug_nvdimm_lock(struct device *dev)
> +{
> +}
> +
> +static inline void debug_nvdimm_unlock(struct device *dev)
> +{
> +}
> +#endif
>  #endif /* __ND_CORE_H__ */
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 0f81fc56bbfd..9b09fe18e666 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -67,7 +67,7 @@ static ssize_t mode_store(struct device *dev,
>         struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
>         ssize_t rc = 0;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         if (dev->driver)
>                 rc = -EBUSY;
> @@ -89,7 +89,7 @@ static ssize_t mode_store(struct device *dev,
>         dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
>                         buf[len - 1] == '\n' ? "" : "\n");
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc ? rc : len;
>  }
> @@ -132,14 +132,14 @@ static ssize_t align_store(struct device *dev,
>         struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         rc = nd_size_select_store(dev, buf, &nd_pfn->align,
>                         nd_pfn_supported_alignments());
>         dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
>                         buf[len - 1] == '\n' ? "" : "\n");
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc ? rc : len;
>  }
> @@ -161,11 +161,11 @@ static ssize_t uuid_store(struct device *dev,
>         struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         rc = nd_uuid_store(dev, &nd_pfn->uuid, buf, len);
>         dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
>                         buf[len - 1] == '\n' ? "" : "\n");
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc ? rc : len;
>  }
> @@ -190,13 +190,13 @@ static ssize_t namespace_store(struct device *dev,
>         struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         rc = nd_namespace_store(dev, &nd_pfn->ndns, buf, len);
>         dev_dbg(dev, "result: %zd wrote: %s%s", rc, buf,
>                         buf[len - 1] == '\n' ? "" : "\n");
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc;
>  }
> @@ -208,7 +208,7 @@ static ssize_t resource_show(struct device *dev,
>         struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         if (dev->driver) {
>                 struct nd_pfn_sb *pfn_sb = nd_pfn->pfn_sb;
>                 u64 offset = __le64_to_cpu(pfn_sb->dataoff);
> @@ -222,7 +222,7 @@ static ssize_t resource_show(struct device *dev,
>                 /* no address to convey if the pfn instance is disabled */
>                 rc = -ENXIO;
>         }
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc;
>  }
> @@ -234,7 +234,7 @@ static ssize_t size_show(struct device *dev,
>         struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         if (dev->driver) {
>                 struct nd_pfn_sb *pfn_sb = nd_pfn->pfn_sb;
>                 u64 offset = __le64_to_cpu(pfn_sb->dataoff);
> @@ -250,7 +250,7 @@ static ssize_t size_show(struct device *dev,
>                 /* no size to convey if the pfn instance is disabled */
>                 rc = -ENXIO;
>         }
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc;
>  }
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 28cb44c61d4a..53797e7be18a 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -520,8 +520,8 @@ static int nd_pmem_remove(struct device *dev)
>                 nvdimm_namespace_detach_btt(to_nd_btt(dev));
>         else {
>                 /*
> -                * Note, this assumes device_lock() context to not race
> -                * nd_pmem_notify()
> +                * Note, this assumes nd_device_lock() context to not
> +                * race nd_pmem_notify()
>                  */
>                 sysfs_put(pmem->bb_state);
>                 pmem->bb_state = NULL;
> diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
> index 488c47ac4c4a..37bf8719a2a4 100644
> --- a/drivers/nvdimm/region.c
> +++ b/drivers/nvdimm/region.c
> @@ -102,7 +102,7 @@ static int nd_region_remove(struct device *dev)
>         nvdimm_bus_unlock(dev);
>
>         /*
> -        * Note, this assumes device_lock() context to not race
> +        * Note, this assumes nd_device_lock() context to not race
>          * nd_region_notify()
>          */
>         sysfs_put(nd_region->bb_state);
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index a15276cdec7d..91b5a7ade0d5 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -329,7 +329,7 @@ static ssize_t set_cookie_show(struct device *dev,
>          * the v1.1 namespace label cookie definition. To read all this
>          * data we need to wait for probing to settle.
>          */
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         wait_nvdimm_bus_probe_idle(dev);
>         if (nd_region->ndr_mappings) {
> @@ -346,7 +346,7 @@ static ssize_t set_cookie_show(struct device *dev,
>                 }
>         }
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         if (rc)
>                 return rc;
> @@ -422,12 +422,12 @@ static ssize_t available_size_show(struct device *dev,
>          * memory nvdimm_bus_lock() is dropped, but that's userspace's
>          * problem to not race itself.
>          */
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         wait_nvdimm_bus_probe_idle(dev);
>         available = nd_region_available_dpa(nd_region);
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return sprintf(buf, "%llu\n", available);
>  }
> @@ -439,12 +439,12 @@ static ssize_t max_available_extent_show(struct device *dev,
>         struct nd_region *nd_region = to_nd_region(dev);
>         unsigned long long available = 0;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         nvdimm_bus_lock(dev);
>         wait_nvdimm_bus_probe_idle(dev);
>         available = nd_region_allocatable_dpa(nd_region);
>         nvdimm_bus_unlock(dev);
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return sprintf(buf, "%llu\n", available);
>  }
> @@ -563,12 +563,12 @@ static ssize_t region_badblocks_show(struct device *dev,
>         struct nd_region *nd_region = to_nd_region(dev);
>         ssize_t rc;
>
> -       device_lock(dev);
> +       nd_device_lock(dev);
>         if (dev->driver)
>                 rc = badblocks_show(&nd_region->bb, buf, 0);
>         else
>                 rc = -ENXIO;
> -       device_unlock(dev);
> +       nd_device_unlock(dev);
>
>         return rc;
>  }
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 0da5c67f6be1..9237b857b598 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -909,6 +909,8 @@ struct dev_links_info {
>   *             This identifies the device type and carries type-specific
>   *             information.
>   * @mutex:     Mutex to synchronize calls to its driver.
> + * @lockdep_mutex: An optional debug lock that a subsystem can use as a
> + *             peer lock to gain localized lockdep coverage of the device_lock.
>   * @bus:       Type of bus device is on.
>   * @driver:    Which driver has allocated this
>   * @platform_data: Platform data specific to the device.
> @@ -991,6 +993,9 @@ struct device {
>                                            core doesn't touch it */
>         void            *driver_data;   /* Driver data, set and get with
>                                            dev_set_drvdata/dev_get_drvdata */
> +#ifdef CONFIG_PROVE_LOCKING
> +       struct mutex            lockdep_mutex;
> +#endif
>         struct mutex            mutex;  /* mutex to synchronize calls to
>                                          * its driver.
>                                          */
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
