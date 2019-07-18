Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 617E16D730
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Jul 2019 01:19:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4AB81212D2756;
	Thu, 18 Jul 2019 16:22:21 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 24D1421959CB2
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 16:22:19 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id l15so30866527otn.9
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 16:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h1Tv6G/QLhR7GemG290wVKzM4CQqfmSA0dkVPy7WEsE=;
 b=ehbWRSGTRcIpSe3lT/JdQltJbIDXA0aGfpzyb4pLLP1S1DIWHOF5grd2pserOBjEAa
 bFwv8mPG3HnLE5uMBwbLnI/jx846h/UQI39o8XlvctFOUFDLxQPQK5pV3+HYzjuvnbKY
 XFDTIOEaCNf/YFWXaJ/v+e3rGl0eUJDVkQHkyHZZsvq50wuvqNiMWwa0QDFbrKAqa2mS
 L6dU65EBA9h2S9PQ7UClJgA/z3at+iA1wDnqzdWyB2HVuz6KzDsBXTxhBeiZaAikw8bl
 HXJab1cBqpBbRBpjnYF4pHt2qXPoYSq73/uB3rBXO1LNxFjOS2jfeRFowKtBQuctKr+l
 gngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h1Tv6G/QLhR7GemG290wVKzM4CQqfmSA0dkVPy7WEsE=;
 b=CfNWaZUegiIeahAp/kW0nYHIWeWGvIra1Q79BeLde1IKLfuO9c/aiusZmWC7yqhW9V
 M1ojVBNSdUr374MIbhkGq8vXSBfOzgZT3562tmdqrRAJcyOq5ZiD1um+l73GJ+Y1eXgJ
 7c6pqtoMj5jGtYR1EUFq3R/x5tdD5Nr1U3lqojs13YSvdBH3pmoE5LWkvyPL3YO1mfhc
 67x63BWe2FFnPirbKZ+zTJyT+B6Jb21LrxBu8qI29wLcco39Rv4lVjS68iBGYpbcAtM5
 TT6m34/dgw2RFyAk0BskRjHI94yhOFXM8x7ruQ8s7SZP74OXIAVbB3EvuElq/tbf+q7b
 gHoQ==
X-Gm-Message-State: APjAAAVC6kM/qexld/DnFRKgYp2QC0w/r4bDsK6uYGRDPeDekUm9LVfu
 tR/gMW+3dp6yEXimWaznT+nI7LqGvx4C+O3n8iIztQ==
X-Google-Smtp-Source: APXvYqwc7H2FQuxhrkoxUZd+dlRPzvBE+9No8qnwwP0+GMIbvsn1FeUYsiCs5V0mJfi/l9yUDfaxEH/7R1wkeVDgRFo=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr10839598oto.207.1563491992210; 
 Thu, 18 Jul 2019 16:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190717225400.9494-1-vishal.l.verma@intel.com>
 <20190717225400.9494-5-vishal.l.verma@intel.com>
In-Reply-To: <20190717225400.9494-5-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 18 Jul 2019 16:19:40 -0700
Message-ID: <CAPcyv4grJ6-UAUhY55WeTBdv1xtkTYe=xSL-ae_bKDXW8DY9zQ@mail.gmail.com>
Subject: Re: [ndctl PATCH v6 04/13] libdaxctl: add a 'daxctl_memory' object
 for memory based operations
To: Vishal Verma <vishal.l.verma@intel.com>
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

A couple minor comments...

On Wed, Jul 17, 2019 at 3:54 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Introduce a new 'daxctl_memory' object, which will be used for
> operations related to managing dax devices in 'system-memory' modes.
>
> Add libdaxctl APIs to get the target_node of a DAX device, and to
> online, offline, and query the state of hotplugged memory sections
> associated with a given device.
>
> This adds the following new interfaces:
>
>   daxctl_dev_get_target_node
>   daxctl_dev_get_memory;
>   daxctl_memory_get_dev;
>   daxctl_memory_get_node_path;
>   daxctl_memory_get_block_size;
>   daxctl_memory_set_online
>   daxctl_memory_set_offline
>   daxctl_memory_is_online
>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> [for the memblock-already-online TOCTOU hole]
> Reported-by: Fan Du <fan.du@intel.com>
> Tested-by: Fan Du <fan.du@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  daxctl/lib/libdaxctl-private.h |  14 ++
>  daxctl/lib/libdaxctl.c         | 352 +++++++++++++++++++++++++++++++++
>  daxctl/lib/libdaxctl.sym       |   8 +
>  daxctl/libdaxctl.h             |  10 +
>  4 files changed, 384 insertions(+)
>
> diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
> index eb7c1ec..673be0f 100644
> --- a/daxctl/lib/libdaxctl-private.h
> +++ b/daxctl/lib/libdaxctl-private.h
> @@ -33,6 +33,11 @@ static const char *dax_modules[] = {
>         [DAXCTL_DEV_MODE_RAM] = "kmem",
>  };
>
> +enum memory_state {
> +       MEM_OFFLINE,
> +       MEM_ONLINE,
> +};
> +
>  /**
>   * struct daxctl_region - container for dax_devices
>   */
> @@ -64,8 +69,17 @@ struct daxctl_dev {
>         struct kmod_module *module;
>         struct kmod_list *kmod_list;
>         struct daxctl_region *region;
> +       struct daxctl_memory *mem;
> +       int target_node;
>  };
>
> +struct daxctl_memory {
> +struct daxctl_dev *dev;
> +       char *node_path;
> +       unsigned long block_size;
> +};
> +
> +
>  static inline int check_kmod(struct kmod_ctx *kmod_ctx)
>  {
>         return kmod_ctx ? 0 : -ENXIO;
> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
> index 5431063..4c1cbf3 100644
> --- a/daxctl/lib/libdaxctl.c
> +++ b/daxctl/lib/libdaxctl.c
> @@ -200,6 +200,12 @@ DAXCTL_EXPORT void daxctl_region_get_uuid(struct daxctl_region *region, uuid_t u
>         uuid_copy(uu, region->uuid);
>  }
>
> +static void free_mem(struct daxctl_memory *mem)
> +{
> +       free(mem->node_path);
> +       free(mem);
> +}
> +
>  static void free_dev(struct daxctl_dev *dev, struct list_head *head)
>  {
>         if (head)
> @@ -207,6 +213,7 @@ static void free_dev(struct daxctl_dev *dev, struct list_head *head)
>         kmod_module_unref_list(dev->kmod_list);
>         free(dev->dev_buf);
>         free(dev->dev_path);
> +       free_mem(dev->mem);
>         free(dev);
>  }
>
> @@ -343,6 +350,44 @@ static struct kmod_list *to_module_list(struct daxctl_ctx *ctx,
>         return list;
>  }
>
> +static struct daxctl_memory *daxctl_dev_init_mem(struct daxctl_dev *dev)
> +{
> +       const char *size_path = "/sys/devices/system/memory/block_size_bytes";
> +       const char *node_base = "/sys/devices/system/node/node";
> +       const char *devname = daxctl_dev_get_devname(dev);
> +       struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> +       struct daxctl_memory *mem;
> +       char buf[SYSFS_ATTR_SIZE];
> +       int node_num;
> +
> +       mem = calloc(1, sizeof(*mem));
> +       if (!mem)
> +               return NULL;
> +
> +       mem->dev = dev;
> +
> +       /*
> +        * Everything here is best-effort, we won't fail the device add
> +        * for anything other than the ENOMEM case above.
> +        */
> +       if (sysfs_read_attr(ctx, size_path, buf) == 0) {
> +               mem->block_size = strtoul(buf, NULL, 16);
> +               if (mem->block_size == 0 || mem->block_size == ULONG_MAX) {
> +                       err(ctx, "%s: Unable to determine memblock size: %s\n",
> +                               devname, strerror(errno));
> +                       mem->block_size = 0;
> +               }
> +       }
> +
> +       node_num = daxctl_dev_get_target_node(dev);
> +       if (node_num >= 0) {
> +               if (asprintf(&mem->node_path, "%s%d", node_base, node_num) < 0)
> +                       err(ctx, "%s: Unable to set node_path\n", devname);
> +       }
> +
> +       return mem;
> +}
> +
>  static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
>  {
>         const char *devname = devpath_to_devname(daxdev_base);
> @@ -398,6 +443,16 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
>         if (rc == 0)
>                 dev->kmod_list = to_module_list(ctx, buf);
>
> +       sprintf(path, "%s/target_node", daxdev_base);
> +       if (sysfs_read_attr(ctx, path, buf) == 0)
> +               dev->target_node = strtol(buf, NULL, 0);
> +       else
> +               dev->target_node = -1;
> +
> +       dev->mem = daxctl_dev_init_mem(dev);
> +       if (!dev->mem)
> +               goto err_read;
> +

Should this initialization wait until the first
daxctl_dev_get_memory() and validate the device is in "system-ram"
mode at that point?

I'm otherwise wondering what it means for daxctl_dev_get_memory() to
succeed on a device in "device-dax" mode. I think I would naturally
use daxctl_dev_get_memory() as a mode check.



>         daxctl_dev_foreach(region, dev_dup)
>                 if (dev_dup->id == dev->id) {
>                         free_dev(dev, NULL);
> @@ -894,3 +949,300 @@ DAXCTL_EXPORT unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev)
>  {
>         return dev->size;
>  }
> +
> +DAXCTL_EXPORT int daxctl_dev_get_target_node(struct daxctl_dev *dev)
> +{
> +       return dev->target_node;
> +}
> +
> +DAXCTL_EXPORT struct daxctl_memory *daxctl_dev_get_memory(struct daxctl_dev *dev)
> +{
> +       return dev->mem;
> +}
> +
> +DAXCTL_EXPORT struct daxctl_dev *daxctl_memory_get_dev(struct daxctl_memory *mem)
> +{
> +       return mem->dev;
> +}
> +
> +DAXCTL_EXPORT const char *daxctl_memory_get_node_path(struct daxctl_memory *mem)
> +{
> +       return mem->node_path;
> +}
> +
> +DAXCTL_EXPORT unsigned long daxctl_memory_get_block_size(struct daxctl_memory *mem)
> +{
> +       return mem->block_size;
> +}
> +
> +static int online_one_memblock(struct daxctl_dev *dev, char *path)
> +{
> +       const char *devname = daxctl_dev_get_devname(dev);
> +       struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> +       const char *mode = "online_movable";
> +       char buf[SYSFS_ATTR_SIZE];
> +       int rc;
> +
> +       rc = sysfs_read_attr(ctx, path, buf);
> +       if (rc) {
> +               err(ctx, "%s: Failed to read %s: %s\n",
> +                       devname, path, strerror(-rc));
> +               return rc;
> +       }
> +
> +       /*
> +        * if already online, possibly due to kernel config or a udev rule,
> +        * there is nothing to do and we can skip over the memblock
> +        */
> +       if (strncmp(buf, "online", 6) == 0)
> +               return 1;
> +
> +       rc = sysfs_write_attr_quiet(ctx, path, mode);
> +       if (rc) {
> +               /*
> +                * While we performed an already-online check above, there
> +                * is still a TOCTOU hole where someone (such as a udev rule)
> +                * may have raced to online the memory. In such a case,
> +                * the sysfs store will fail, however we can check for this
> +                * by simply reading the state again. If it changed to the
> +                * desired state, then we don't have to error out.
> +                */
> +               if(sysfs_read_attr(ctx, path, buf) == 0) {
> +                       if (strncmp(buf, "online", 6) == 0)
> +                               return 1;
> +               }
> +               err(ctx, "%s: Failed to online %s: %s\n",
> +                       devname, path, strerror(-rc));
> +       }
> +       return rc;
> +}
> +
> +static int offline_one_memblock(struct daxctl_dev *dev, char *path)
> +{
> +       const char *devname = daxctl_dev_get_devname(dev);
> +       struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> +       const char *mode = "offline";
> +       char buf[SYSFS_ATTR_SIZE];
> +       int rc;
> +
> +       rc = sysfs_read_attr(ctx, path, buf);
> +       if (rc) {
> +               err(ctx, "%s: Failed to read %s: %s\n",
> +                       devname, path, strerror(-rc));
> +               return rc;
> +       }
> +
> +       /* if already offline, there is nothing to do */
> +       if (strncmp(buf, "offline", 7) == 0)
> +               return 1;
> +
> +       rc = sysfs_write_attr_quiet(ctx, path, mode);
> +       if (rc) {
> +               /* Close the TOCTOU hole like in online_one_memblock() above */
> +               if(sysfs_read_attr(ctx, path, buf) == 0) {

Ah, this also copied the missing space between 'if' and '(' my eyes
didn't catch it the first time.

> +                       if (strncmp(buf, "offline", 7) == 0)
> +                               return 1;
> +               }
> +               err(ctx, "%s: Failed to offline %s: %s\n",
> +                       devname, path, strerror(-rc));
> +       }
> +       return rc;
> +}
> +
> +static bool memblock_in_dev(struct daxctl_dev *dev, const char *memblock)
> +{
> +       struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
> +       const char *mem_base = "/sys/devices/system/memory/";
> +       unsigned long long memblock_res, dev_start, dev_end;
> +       const char *devname = daxctl_dev_get_devname(dev);
> +       struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> +       unsigned long memblock_size;
> +       char buf[SYSFS_ATTR_SIZE];
> +       unsigned long phys_index;
> +       char *index_path;
> +
> +       if (asprintf(&index_path, "%s/%s/phys_index", mem_base, memblock) < 0)
> +               return false;
> +
> +       if (sysfs_read_attr(ctx, index_path, buf) == 0) {
> +               phys_index = strtoul(buf, NULL, 16);
> +               if (phys_index == 0 || phys_index == ULONG_MAX) {
> +                       err(ctx, "%s: %s: Unable to determine phys_index: %s\n",
> +                               devname, memblock, strerror(errno));
> +                       goto out_err;
> +               }
> +       } else {
> +               err(ctx, "%s: %s: Unable to determine phys_index: %s\n",
> +                       devname, memblock, strerror(errno));
> +               goto out_err;
> +       }
> +
> +       dev_start = daxctl_dev_get_resource(dev);
> +       if (!dev_start) {
> +               err(ctx, "%s: Unable to determine resource\n", devname);
> +               goto out_err;
> +       }
> +       dev_end = dev_start + daxctl_dev_get_size(dev);
> +
> +       memblock_size = daxctl_memory_get_block_size(mem);
> +       if (!memblock_size) {
> +               err(ctx, "%s: Unable to determine memory block size\n",
> +                       devname);
> +               goto out_err;
> +       }
> +       memblock_res = phys_index * memblock_size;
> +
> +       if (memblock_res >= dev_start && memblock_res <= dev_end) {
> +               free(index_path);
> +               return true;
> +       }
> +
> +out_err:
> +       free(index_path);
> +       return false;
> +}
> +
> +static int daxctl_memory_set_state(struct daxctl_memory *mem,
> +               enum memory_state state)
> +{
> +       struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
> +       const char *devname = daxctl_dev_get_devname(dev);
> +       struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> +       const char *node_path;
> +       int rc, changed = 0;
> +       struct dirent *de;
> +       DIR *node_dir;
> +
> +       node_path = daxctl_memory_get_node_path(mem);
> +       if (!node_path) {
> +               err(ctx, "%s: Failed to get node_path\n", devname);
> +               return -ENXIO;
> +       }
> +
> +       node_dir = opendir(node_path);
> +       if (!node_dir)
> +               return -errno;
> +
> +       errno = 0;
> +       while ((de = readdir(node_dir)) != NULL) {
> +               char *mem_path;
> +
> +               if (strncmp(de->d_name, "memory", 6) == 0) {
> +                       if (!memblock_in_dev(dev, de->d_name))
> +                               continue;
> +                       rc = asprintf(&mem_path, "%s/%s/state",
> +                               node_path, de->d_name);
> +                       if (rc < 0) {
> +                               rc = -ENOMEM;
> +                               goto out_dir;
> +                       }
> +                       if (state == MEM_ONLINE)
> +                               rc = online_one_memblock(dev, mem_path);
> +                       else if (state == MEM_OFFLINE)
> +                               rc = offline_one_memblock(dev, mem_path);
> +                       else
> +                               rc = -EINVAL;
> +                       free(mem_path);
> +                       if (rc < 0)
> +                               goto out_dir;
> +                       if (rc == 0)
> +                               changed++;
> +               }
> +               errno = 0;
> +       }
> +       if (errno) {
> +               rc = -errno;
> +               goto out_dir;
> +       }
> +       rc = changed;
> +
> +out_dir:
> +       closedir(node_dir);
> +       return rc;
> +}
> +
> +DAXCTL_EXPORT int daxctl_memory_set_online(struct daxctl_memory *mem)
> +{
> +       return daxctl_memory_set_state(mem, MEM_ONLINE);
> +}
> +
> +DAXCTL_EXPORT int daxctl_memory_set_offline(struct daxctl_memory *mem)
> +{
> +       return daxctl_memory_set_state(mem, MEM_OFFLINE);
> +}
> +
> +static int memblock_is_online(struct daxctl_dev *dev, char *path)
> +{
> +       const char *devname = daxctl_dev_get_devname(dev);
> +       struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> +       char buf[SYSFS_ATTR_SIZE];
> +       int rc;
> +
> +       rc = sysfs_read_attr(ctx, path, buf);
> +       if (rc) {
> +               err(ctx, "%s: Failed to read %s: %s\n",
> +                       devname, path, strerror(-rc));
> +               return rc;
> +       }
> +
> +       if (strncmp(buf, "online", 6) == 0)
> +               return 1;
> +
> +       return 0;
> +}
> +
> +DAXCTL_EXPORT int daxctl_memory_is_online(struct daxctl_memory *mem)
> +{
> +       struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
> +       const char *devname = daxctl_dev_get_devname(dev);
> +       struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> +       int rc, num_online = 0;
> +       const char *node_path;
> +       struct dirent *de;
> +       DIR *node_dir;
> +
> +       node_path = daxctl_memory_get_node_path(mem);
> +       if (!node_path) {
> +               err(ctx, "%s: Failed to get node_path\n", devname);
> +               return -ENXIO;
> +       }
> +
> +       node_dir = opendir(node_path);
> +       if (!node_dir)
> +               return -errno;
> +
> +       errno = 0;
> +       while ((de = readdir(node_dir)) != NULL) {
> +               char *mem_path;
> +
> +               if (strncmp(de->d_name, "memory", 6) == 0) {
> +                       if (!memblock_in_dev(dev, de->d_name))
> +                               continue;
> +                       rc = asprintf(&mem_path, "%s/%s/state",
> +                               node_path, de->d_name);
> +                       if (rc < 0) {
> +                               rc = -ENOMEM;
> +                               goto out_dir;
> +                       }
> +                       rc = memblock_is_online(dev, mem_path);
> +                       if (rc < 0) {
> +                               err(ctx, "%s: Unable to determine state: %s\n",
> +                                       devname, mem_path);
> +                               goto out_dir;
> +                       }
> +                       if (rc > 0)
> +                               num_online++;
> +                       free(mem_path);
> +               }
> +               errno = 0;
> +       }
> +       if (errno) {
> +               rc = -errno;
> +               goto out_dir;
> +       }
> +       rc = num_online;
> +
> +out_dir:
> +       closedir(node_dir);
> +       return rc;
> +}
> diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
> index 1692624..53eb700 100644
> --- a/daxctl/lib/libdaxctl.sym
> +++ b/daxctl/lib/libdaxctl.sym
> @@ -59,4 +59,12 @@ global:
>         daxctl_dev_enable_devdax;
>         daxctl_dev_enable_ram;
>         daxctl_dev_get_resource;
> +       daxctl_dev_get_target_node;
> +       daxctl_dev_get_memory;
> +       daxctl_memory_get_dev;
> +       daxctl_memory_get_node_path;
> +       daxctl_memory_get_block_size;
> +       daxctl_memory_set_online;
> +       daxctl_memory_set_offline;
> +       daxctl_memory_is_online;
>  } LIBDAXCTL_5;
> diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
> index 7214cd3..a5a2bab 100644
> --- a/daxctl/libdaxctl.h
> +++ b/daxctl/libdaxctl.h
> @@ -73,6 +73,16 @@ int daxctl_dev_is_enabled(struct daxctl_dev *dev);
>  int daxctl_dev_disable(struct daxctl_dev *dev);
>  int daxctl_dev_enable_devdax(struct daxctl_dev *dev);
>  int daxctl_dev_enable_ram(struct daxctl_dev *dev);
> +int daxctl_dev_get_target_node(struct daxctl_dev *dev);
> +
> +struct daxctl_memory;
> +struct daxctl_memory *daxctl_dev_get_memory(struct daxctl_dev *dev);
> +struct daxctl_dev *daxctl_memory_get_dev(struct daxctl_memory *mem);
> +const char *daxctl_memory_get_node_path(struct daxctl_memory *mem);
> +unsigned long daxctl_memory_get_block_size(struct daxctl_memory *mem);
> +int daxctl_memory_set_online(struct daxctl_memory *mem);
> +int daxctl_memory_set_offline(struct daxctl_memory *mem);
> +int daxctl_memory_is_online(struct daxctl_memory *mem);
>
>  #define daxctl_dev_foreach(region, dev) \
>          for (dev = daxctl_dev_get_first(region); \
> --
> 2.20.1
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
