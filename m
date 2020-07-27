Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C6122EC4D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 Jul 2020 14:37:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E25FF123B11D5;
	Mon, 27 Jul 2020 05:37:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.67; helo=mail-ot1-f67.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AC9DB123B11C6
	for <linux-nvdimm@lists.01.org>; Mon, 27 Jul 2020 05:37:53 -0700 (PDT)
Received: by mail-ot1-f67.google.com with SMTP id r21so1650934ota.10
        for <linux-nvdimm@lists.01.org>; Mon, 27 Jul 2020 05:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQ9Ihi8yci7XalNb+gu41lSl31GNAge/uRi0+LA+Z6Q=;
        b=ZosI6qnqYnHRweXCp5aKtYPnF8My8NI+Lo+4VoYylIcLOA3+ZHrszIZxHFJfcB7PwS
         rPLgLLfcOYEqt8e3ewaK3mAWZcSLiQqxUHDjYhK2MCzo1SNMRb6Rxr9rGxAD+Tiqyrwl
         qxziXVLFVG4DR9bLzxqH2XOxVch6io3MDU17l1OeymGJD93AG2xbWQCn9M9+2zvTgXbp
         Tn4G99aEUDpOtjZ/rIsRVJCe0mbgVifIbTWvk6JYlMH06pEFiwnYXH8mPx1SPleEC5e9
         PTskckFpwVU2qelcs8KhHkQjlvkFFQUIzSE+4ruYBUUWl3B0So8ayfSpzK5weN2NJ9x1
         z4DQ==
X-Gm-Message-State: AOAM533MRJDGNcRQVxbb0bWa15OPN9TPLGTsda1ZwdcMtVv/SBxtU2JY
	Kr9Dx8tOsk7LFrWkcpS0itK7FFdudmPjl24Ffnc=
X-Google-Smtp-Source: ABdhPJylGzZI7/B9p97/nvY8bNrX90zXNqY/Y15tkwTJz6I0qvmVHspGxJ8dyC+tzNQnE3PqB9ZBfQF6fUpv9yJV5bc=
X-Received: by 2002:a9d:306:: with SMTP id 6mr10329744otv.167.1595853472512;
 Mon, 27 Jul 2020 05:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Jul 2020 14:37:41 +0200
Message-ID: <CAJZ5v0jb87PnwVXKuvgFeP=c-BGstc4YmANGpbOOnXi-b1oL8w@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] PM, libnvdimm: Add runtime firmware activation support
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: 4MUESACBXGT4SEP2OIG7TOCB7SLW77XW
X-Message-ID-Hash: 4MUESACBXGT4SEP2OIG7TOCB7SLW77XW
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4MUESACBXGT4SEP2OIG7TOCB7SLW77XW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 21, 2020 at 12:24 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Abstract platform specific mechanics for nvdimm firmware activation
> behind a handful of generic ops. At the bus level ->activate_state()
> indicates the unified state (idle, busy, armed) of all DIMMs on the bus,
> and ->capability() indicates the system state expectations for activate.
> At the DIMM level ->activate_state() indicates the per-DIMM state,
> ->activate_result() indicates the outcome of the last activation
> attempt, and ->arm() attempts to transition the DIMM from 'idle' to
> 'armed'.
>
> A new hibernate_quiet_exec() facility is added to support firmware
> activation in an OS defined system quiesce state. It leverages the fact
> that the hibernate-freeze state wants to assert that a memory
> hibernation snapshot can be taken. This is in contrast to a platform
> firmware defined quiesce state that may forcefully quiet the memory
> controller independent of whether an individual device-driver properly
> supports hibernate-freeze.
>
> The libnvdimm sysfs interface is extended to support detection of a
> firmware activate capability. The mechanism supports enumeration and
> triggering of firmware activate, optionally in the
> hibernate_quiet_exec() context.
>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> [rafael: hibernate_quiet_exec() proposal]
> Co-developed-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>

IMO it's better to change this to

Co-developed-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

and please to add

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to it as per the development process documentation.

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-nvdimm         |    2
>  .../driver-api/nvdimm/firmware-activate.rst        |   86 ++++++++++++
>  drivers/nvdimm/core.c                              |  149 ++++++++++++++++++++
>  drivers/nvdimm/dimm_devs.c                         |  115 +++++++++++++++
>  drivers/nvdimm/nd-core.h                           |    1
>  include/linux/libnvdimm.h                          |   44 ++++++
>  include/linux/suspend.h                            |    6 +
>  kernel/power/hibernate.c                           |   97 +++++++++++++
>  8 files changed, 500 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-nvdimm
>  create mode 100644 Documentation/driver-api/nvdimm/firmware-activate.rst
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
> new file mode 100644
> index 000000000000..d64380262be8
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
> @@ -0,0 +1,2 @@
> +The libnvdimm sub-system implements a common sysfs interface for
> +platform nvdimm resources. See Documentation/driver-api/nvdimm/.
> diff --git a/Documentation/driver-api/nvdimm/firmware-activate.rst b/Documentation/driver-api/nvdimm/firmware-activate.rst
> new file mode 100644
> index 000000000000..9eb98aa833c5
> --- /dev/null
> +++ b/Documentation/driver-api/nvdimm/firmware-activate.rst
> @@ -0,0 +1,86 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
> +NVDIMM Runtime Firmware Activation
> +==================================
> +
> +Some persistent memory devices run a firmware locally on the device /
> +"DIMM" to perform tasks like media management, capacity provisioning,
> +and health monitoring. The process of updating that firmware typically
> +involves a reboot because it has implications for in-flight memory
> +transactions. However, reboots are disruptive and at least the Intel
> +persistent memory platform implementation, described by the Intel ACPI
> +DSM specification [1], has added support for activating firmware at
> +runtime.
> +
> +A native sysfs interface is implemented in libnvdimm to allow platform
> +to advertise and control their local runtime firmware activation
> +capability.
> +
> +The libnvdimm bus object, ndbusX, implements an ndbusX/firmware/activate
> +attribute that shows the state of the firmware activation as one of 'idle',
> +'armed', 'overflow', and 'busy'.
> +
> +- idle:
> +  No devices are set / armed to activate firmware
> +
> +- armed:
> +  At least one device is armed
> +
> +- busy:
> +  In the busy state armed devices are in the process of transitioning
> +  back to idle and completing an activation cycle.
> +
> +- overflow:
> +  If the platform has a concept of incremental work needed to perform
> +  the activation it could be the case that too many DIMMs are armed for
> +  activation. In that scenario the potential for firmware activation to
> +  timeout is indicated by the 'overflow' state.
> +
> +The 'ndbusX/firmware/activate' property can be written with a value of
> +either 'live', or 'quiesce'. A value of 'quiesce' triggers the kernel to
> +run firmware activation from within the equivalent of the hibernation
> +'freeze' state where drivers and applications are notified to stop their
> +modifications of system memory. A value of 'live' attempts
> +firmware-activation without this hibernation cycle. The
> +'ndbusX/firmware/activate' property will be elided completely if no
> +firmware activation capability is detected.
> +
> +Another property 'ndbusX/firmware/capability' indicates a value of
> +'live', or 'quiesce'. Where 'live' indicates that the firmware
> +does not require or inflict any quiesce period on the system to update
> +firmware. A capability value of 'quiesce' indicates that firmware does
> +expect and injects a quiet period for the memory controller, but 'live'
> +may still be written to 'ndbusX/firmware/activate' as an override to
> +assume the risk of racing firmware update with in-flight device and
> +application activity. The 'ndbusX/firmware/capability' property will be
> +elided completely if no firmware activation capability is detected.
> +
> +The libnvdimm memory-device / DIMM object, nmemX, implements
> +'nmemX/firmware/activate' and 'nmemX/firmware/result' attributes to
> +communicate the per-device firmware activation state. Similar to the
> +'ndbusX/firmware/activate' attribute, the 'nmemX/firmware/activate'
> +attribute indicates 'idle', 'armed', or 'busy'. The state transitions
> +from 'armed' to 'idle' when the system is prepared to activate firmware,
> +firmware staged + state set to armed, and 'ndbusX/firmware/activate' is
> +triggered. After that activation event the nmemX/firmware/result
> +attribute reflects the state of the last activation as one of:
> +
> +- none:
> +  No runtime activation triggered since the last time the device was reset
> +
> +- success:
> +  The last runtime activation completed successfully.
> +
> +- fail:
> +  The last runtime activation failed for device-specific reasons.
> +
> +- not_staged:
> +  The last runtime activation failed due to a sequencing error of the
> +  firmware image not being staged.
> +
> +- need_reset:
> +  Runtime firmware activation failed, but the firmware can still be
> +  activated via the legacy method of power-cycling the system.
> +
> +[1]: https://docs.pmem.io/persistent-memory/
> diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
> index fe9bd6febdd2..c21ba0602029 100644
> --- a/drivers/nvdimm/core.c
> +++ b/drivers/nvdimm/core.c
> @@ -4,6 +4,7 @@
>   */
>  #include <linux/libnvdimm.h>
>  #include <linux/badblocks.h>
> +#include <linux/suspend.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/blkdev.h>
> @@ -389,8 +390,156 @@ static const struct attribute_group nvdimm_bus_attribute_group = {
>         .attrs = nvdimm_bus_attributes,
>  };
>
> +static ssize_t capability_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
> +       struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
> +       enum nvdimm_fwa_capability cap;
> +
> +       if (!nd_desc->fw_ops)
> +               return -EOPNOTSUPP;
> +
> +       nvdimm_bus_lock(dev);
> +       cap = nd_desc->fw_ops->capability(nd_desc);
> +       nvdimm_bus_unlock(dev);
> +
> +       switch (cap) {
> +       case NVDIMM_FWA_CAP_QUIESCE:
> +               return sprintf(buf, "quiesce\n");
> +       case NVDIMM_FWA_CAP_LIVE:
> +               return sprintf(buf, "live\n");
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +}
> +
> +static DEVICE_ATTR_RO(capability);
> +
> +static ssize_t activate_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
> +       struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
> +       enum nvdimm_fwa_capability cap;
> +       enum nvdimm_fwa_state state;
> +
> +       if (!nd_desc->fw_ops)
> +               return -EOPNOTSUPP;
> +
> +       nvdimm_bus_lock(dev);
> +       cap = nd_desc->fw_ops->capability(nd_desc);
> +       state = nd_desc->fw_ops->activate_state(nd_desc);
> +       nvdimm_bus_unlock(dev);
> +
> +       if (cap < NVDIMM_FWA_CAP_QUIESCE)
> +               return -EOPNOTSUPP;
> +
> +       switch (state) {
> +       case NVDIMM_FWA_IDLE:
> +               return sprintf(buf, "idle\n");
> +       case NVDIMM_FWA_BUSY:
> +               return sprintf(buf, "busy\n");
> +       case NVDIMM_FWA_ARMED:
> +               return sprintf(buf, "armed\n");
> +       case NVDIMM_FWA_ARM_OVERFLOW:
> +               return sprintf(buf, "overflow\n");
> +       default:
> +               return -ENXIO;
> +       }
> +}
> +
> +static int exec_firmware_activate(void *data)
> +{
> +       struct nvdimm_bus_descriptor *nd_desc = data;
> +
> +       return nd_desc->fw_ops->activate(nd_desc);
> +}
> +
> +static ssize_t activate_store(struct device *dev,
> +               struct device_attribute *attr, const char *buf, size_t len)
> +{
> +       struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
> +       struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
> +       enum nvdimm_fwa_state state;
> +       bool quiesce;
> +       ssize_t rc;
> +
> +       if (!nd_desc->fw_ops)
> +               return -EOPNOTSUPP;
> +
> +       if (sysfs_streq(buf, "live"))
> +               quiesce = false;
> +       else if (sysfs_streq(buf, "quiesce"))
> +               quiesce = true;
> +       else
> +               return -EINVAL;
> +
> +       nvdimm_bus_lock(dev);
> +       state = nd_desc->fw_ops->activate_state(nd_desc);
> +
> +       switch (state) {
> +       case NVDIMM_FWA_BUSY:
> +               rc = -EBUSY;
> +               break;
> +       case NVDIMM_FWA_ARMED:
> +       case NVDIMM_FWA_ARM_OVERFLOW:
> +               if (quiesce)
> +                       rc = hibernate_quiet_exec(exec_firmware_activate, nd_desc);
> +               else
> +                       rc = nd_desc->fw_ops->activate(nd_desc);
> +               break;
> +       case NVDIMM_FWA_IDLE:
> +       default:
> +               rc = -ENXIO;
> +       }
> +       nvdimm_bus_unlock(dev);
> +
> +       if (rc == 0)
> +               rc = len;
> +       return rc;
> +}
> +
> +static DEVICE_ATTR_ADMIN_RW(activate);
> +
> +static umode_t nvdimm_bus_firmware_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +       struct device *dev = container_of(kobj, typeof(*dev), kobj);
> +       struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
> +       struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
> +       enum nvdimm_fwa_capability cap;
> +
> +       /*
> +        * Both 'activate' and 'capability' disappear when no ops
> +        * detected, or a negative capability is indicated.
> +        */
> +       if (!nd_desc->fw_ops)
> +               return 0;
> +
> +       nvdimm_bus_lock(dev);
> +       cap = nd_desc->fw_ops->capability(nd_desc);
> +       nvdimm_bus_unlock(dev);
> +
> +       if (cap < NVDIMM_FWA_CAP_QUIESCE)
> +               return 0;
> +
> +       return a->mode;
> +}
> +static struct attribute *nvdimm_bus_firmware_attributes[] = {
> +       &dev_attr_activate.attr,
> +       &dev_attr_capability.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group nvdimm_bus_firmware_attribute_group = {
> +       .name = "firmware",
> +       .attrs = nvdimm_bus_firmware_attributes,
> +       .is_visible = nvdimm_bus_firmware_visible,
> +};
> +
>  const struct attribute_group *nvdimm_bus_attribute_groups[] = {
>         &nvdimm_bus_attribute_group,
> +       &nvdimm_bus_firmware_attribute_group,
>         NULL,
>  };
>
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index b7b77e8d9027..85b53a7f44f2 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -446,9 +446,124 @@ static const struct attribute_group nvdimm_attribute_group = {
>         .is_visible = nvdimm_visible,
>  };
>
> +static ssize_t result_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       struct nvdimm *nvdimm = to_nvdimm(dev);
> +       enum nvdimm_fwa_result result;
> +
> +       if (!nvdimm->fw_ops)
> +               return -EOPNOTSUPP;
> +
> +       nvdimm_bus_lock(dev);
> +       result = nvdimm->fw_ops->activate_result(nvdimm);
> +       nvdimm_bus_unlock(dev);
> +
> +       switch (result) {
> +       case NVDIMM_FWA_RESULT_NONE:
> +               return sprintf(buf, "none\n");
> +       case NVDIMM_FWA_RESULT_SUCCESS:
> +               return sprintf(buf, "success\n");
> +       case NVDIMM_FWA_RESULT_FAIL:
> +               return sprintf(buf, "fail\n");
> +       case NVDIMM_FWA_RESULT_NOTSTAGED:
> +               return sprintf(buf, "not_staged\n");
> +       case NVDIMM_FWA_RESULT_NEEDRESET:
> +               return sprintf(buf, "need_reset\n");
> +       default:
> +               return -ENXIO;
> +       }
> +}
> +static DEVICE_ATTR_ADMIN_RO(result);
> +
> +static ssize_t activate_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       struct nvdimm *nvdimm = to_nvdimm(dev);
> +       enum nvdimm_fwa_state state;
> +
> +       if (!nvdimm->fw_ops)
> +               return -EOPNOTSUPP;
> +
> +       nvdimm_bus_lock(dev);
> +       state = nvdimm->fw_ops->activate_state(nvdimm);
> +       nvdimm_bus_unlock(dev);
> +
> +       switch (state) {
> +       case NVDIMM_FWA_IDLE:
> +               return sprintf(buf, "idle\n");
> +       case NVDIMM_FWA_BUSY:
> +               return sprintf(buf, "busy\n");
> +       case NVDIMM_FWA_ARMED:
> +               return sprintf(buf, "armed\n");
> +       default:
> +               return -ENXIO;
> +       }
> +}
> +
> +static ssize_t activate_store(struct device *dev, struct device_attribute *attr,
> +               const char *buf, size_t len)
> +{
> +       struct nvdimm *nvdimm = to_nvdimm(dev);
> +       enum nvdimm_fwa_trigger arg;
> +       int rc;
> +
> +       if (!nvdimm->fw_ops)
> +               return -EOPNOTSUPP;
> +
> +       if (sysfs_streq(buf, "arm"))
> +               arg = NVDIMM_FWA_ARM;
> +       else if (sysfs_streq(buf, "disarm"))
> +               arg = NVDIMM_FWA_DISARM;
> +       else
> +               return -EINVAL;
> +
> +       nvdimm_bus_lock(dev);
> +       rc = nvdimm->fw_ops->arm(nvdimm, arg);
> +       nvdimm_bus_unlock(dev);
> +
> +       if (rc < 0)
> +               return rc;
> +       return len;
> +}
> +static DEVICE_ATTR_ADMIN_RW(activate);
> +
> +static struct attribute *nvdimm_firmware_attributes[] = {
> +       &dev_attr_activate.attr,
> +       &dev_attr_result.attr,
> +};
> +
> +static umode_t nvdimm_firmware_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +       struct device *dev = container_of(kobj, typeof(*dev), kobj);
> +       struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
> +       struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
> +       struct nvdimm *nvdimm = to_nvdimm(dev);
> +       enum nvdimm_fwa_capability cap;
> +
> +       if (!nd_desc->fw_ops)
> +               return 0;
> +       if (!nvdimm->fw_ops)
> +               return 0;
> +
> +       nvdimm_bus_lock(dev);
> +       cap = nd_desc->fw_ops->capability(nd_desc);
> +       nvdimm_bus_unlock(dev);
> +
> +       if (cap < NVDIMM_FWA_CAP_QUIESCE)
> +               return 0;
> +
> +       return a->mode;
> +}
> +
> +static const struct attribute_group nvdimm_firmware_attribute_group = {
> +       .name = "firmware",
> +       .attrs = nvdimm_firmware_attributes,
> +       .is_visible = nvdimm_firmware_visible,
> +};
> +
>  static const struct attribute_group *nvdimm_attribute_groups[] = {
>         &nd_device_attribute_group,
>         &nvdimm_attribute_group,
> +       &nvdimm_firmware_attribute_group,
>         NULL,
>  };
>
> diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
> index ddb9d97d9129..564faa36a3ca 100644
> --- a/drivers/nvdimm/nd-core.h
> +++ b/drivers/nvdimm/nd-core.h
> @@ -45,6 +45,7 @@ struct nvdimm {
>                 struct kernfs_node *overwrite_state;
>         } sec;
>         struct delayed_work dwork;
> +       const struct nvdimm_fw_ops *fw_ops;
>  };
>
>  static inline unsigned long nvdimm_security_flags(
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index ad9898ece7d3..15dbcb718316 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -86,6 +86,7 @@ struct nvdimm_bus_descriptor {
>         int (*flush_probe)(struct nvdimm_bus_descriptor *nd_desc);
>         int (*clear_to_send)(struct nvdimm_bus_descriptor *nd_desc,
>                         struct nvdimm *nvdimm, unsigned int cmd, void *data);
> +       const struct nvdimm_bus_fw_ops *fw_ops;
>  };
>
>  struct nd_cmd_desc {
> @@ -200,6 +201,49 @@ struct nvdimm_security_ops {
>         int (*query_overwrite)(struct nvdimm *nvdimm);
>  };
>
> +enum nvdimm_fwa_state {
> +       NVDIMM_FWA_INVALID,
> +       NVDIMM_FWA_IDLE,
> +       NVDIMM_FWA_ARMED,
> +       NVDIMM_FWA_BUSY,
> +       NVDIMM_FWA_ARM_OVERFLOW,
> +};
> +
> +enum nvdimm_fwa_trigger {
> +       NVDIMM_FWA_ARM,
> +       NVDIMM_FWA_DISARM,
> +};
> +
> +enum nvdimm_fwa_capability {
> +       NVDIMM_FWA_CAP_INVALID,
> +       NVDIMM_FWA_CAP_NONE,
> +       NVDIMM_FWA_CAP_QUIESCE,
> +       NVDIMM_FWA_CAP_LIVE,
> +};
> +
> +enum nvdimm_fwa_result {
> +       NVDIMM_FWA_RESULT_INVALID,
> +       NVDIMM_FWA_RESULT_NONE,
> +       NVDIMM_FWA_RESULT_SUCCESS,
> +       NVDIMM_FWA_RESULT_NOTSTAGED,
> +       NVDIMM_FWA_RESULT_NEEDRESET,
> +       NVDIMM_FWA_RESULT_FAIL,
> +};
> +
> +struct nvdimm_bus_fw_ops {
> +       enum nvdimm_fwa_state (*activate_state)
> +               (struct nvdimm_bus_descriptor *nd_desc);
> +       enum nvdimm_fwa_capability (*capability)
> +               (struct nvdimm_bus_descriptor *nd_desc);
> +       int (*activate)(struct nvdimm_bus_descriptor *nd_desc);
> +};
> +
> +struct nvdimm_fw_ops {
> +       enum nvdimm_fwa_state (*activate_state)(struct nvdimm *nvdimm);
> +       enum nvdimm_fwa_result (*activate_result)(struct nvdimm *nvdimm);
> +       int (*arm)(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arg);
> +};
> +
>  void badrange_init(struct badrange *badrange);
>  int badrange_add(struct badrange *badrange, u64 addr, u64 length);
>  void badrange_forget(struct badrange *badrange, phys_addr_t start,
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index b960098acfb0..045499699b86 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -453,6 +453,8 @@ extern bool hibernation_available(void);
>  asmlinkage int swsusp_save(void);
>  extern struct pbe *restore_pblist;
>  int pfn_is_nosave(unsigned long pfn);
> +
> +int hibernate_quiet_exec(int (*func)(void *data), void *data);
>  #else /* CONFIG_HIBERNATION */
>  static inline void register_nosave_region(unsigned long b, unsigned long e) {}
>  static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
> @@ -464,6 +466,10 @@ static inline void hibernation_set_ops(const struct platform_hibernation_ops *op
>  static inline int hibernate(void) { return -ENOSYS; }
>  static inline bool system_entering_hibernation(void) { return false; }
>  static inline bool hibernation_available(void) { return false; }
> +
> +static inline hibernate_quiet_exec(int (*func)(void *data), void *data) {

This needs to be "static inline int".

Thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
