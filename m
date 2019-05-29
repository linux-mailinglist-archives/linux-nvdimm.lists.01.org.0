Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC5A2D42D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 May 2019 05:18:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CA5902128DD36;
	Tue, 28 May 2019 20:18:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DA2BE2128A65B
 for <linux-nvdimm@lists.01.org>; Tue, 28 May 2019 20:18:43 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id l25so573401otp.8
 for <linux-nvdimm@lists.01.org>; Tue, 28 May 2019 20:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eKDVj5psfXZe43g8AEOwkF0HhonkUZa6sm4ltTmGgp4=;
 b=XKnZrAxtWtBX1a/Egr9AuQ7WxzbHoE5ApUzdm8OFyPNV5+f8nAjZfjXPHR4oWR4XNb
 iQHCtnoiiuBzOzAwnoAi/YwLBaM9aj6YikOxhO2e2NtDk+BPTpyb8vaT8VzCpXgoxbVS
 h67QV6s9YbCgMPnYC58VCsq5onj8ooh6rN9WYbP+ee3aJmLJ7xQBhqoEHYI9smKx0sTV
 GOytyAW+Q3xHuaqFTMaO0wrtg0te/fjSeI7wr7LSDOJq5DEvYyK2HABUvuaJtR4yuldX
 uVmqTo+7Kn1dBYP6ssxrV/wK0NzZa2sSPDsrfcny8ttyYMGebFm3r7DLBzABSVdZtLVj
 2L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eKDVj5psfXZe43g8AEOwkF0HhonkUZa6sm4ltTmGgp4=;
 b=Uux7/kDjuorDy7/n9kK4puB1TiE8IwYqAqRaIE3RronOiY7kl2XubA2khWWcAJ3MGa
 cjp/LVNXiOZUlmWAdgfHXHBmFDWg+FO3vc0EooHPG/2WyV2q8V61mfvcGUuqu317Mfua
 RNhyngsTZFBBgxtkjBKzQlen9FJ6ZKBB2GZqim8iIUilI3eh3OKlOPundfLKw3/NtQd5
 iY2wZb2qiKB5tLiFLLobbjr3yDT5Tz2h5+6w8zJIO6MrLvJhpMYNpU+LQ+KjkTXFz+GE
 Ba/8Xjq+81Zgga+npu2edvqy7sXgrqW2rfWgtccVUNeDEFRQRg17+VaVvXAAE5u60zuw
 vZVA==
X-Gm-Message-State: APjAAAUUCNK+mGs7qpK3bOiPYkmqyEW7dCXXkki1UaLHsrrZ1RheKkAk
 aiiHrNcFxtlg38jwRZInWMg5k1+vAhWiSmuDajgTOA==
X-Google-Smtp-Source: APXvYqxuXr5+YV6D4bSBJJBOkJRUYiY5oweBC6xtCWmhgiNhDg1Vh/FUfqniTostJnd1H0+HpgVEPBBK5PKWQWDeNv0=
X-Received: by 2002:a9d:61ca:: with SMTP id h10mr14671444otk.247.1559099922475; 
 Tue, 28 May 2019 20:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190528222440.30392-1-vishal.l.verma@intel.com>
 <20190528222440.30392-5-vishal.l.verma@intel.com>
In-Reply-To: <20190528222440.30392-5-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 28 May 2019 20:18:31 -0700
Message-ID: <CAPcyv4jFOs5ASS+apB6LA3Jy_4BLYg+U76QYhkD=h__DKULXHw@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 04/10] libdaxctl: add interfaces to get/set the
 online state for a node
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

On Tue, May 28, 2019 at 3:24 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> In preparation for converting DAX devices for use as system-ram via the
> kernel's 'kmem' facility, add libndctl helpers to manipulate the sysfs
> interfaces to get the target_node of a DAX device, and to online,
> offline, and query the state of hotplugged memory sections associated
> with a given node.
>
> This adds the following new interfaces:
>
>   daxctl_dev_get_target_node
>   daxctl_dev_online_node
>   daxctl_dev_offline_node
>   daxctl_dev_node_is_online

I'm wondering if these should s/node/memory/, or even create a
sub-object called 'memory' to start a new object-verb relationship.
I.e. daxctl_dev_get_memory() +
daxctl_memory_{online,offline,is_online}.

Otherwise functionality looks good to me, just one note about asprintf below:

>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  daxctl/lib/libdaxctl-private.h |   6 +
>  daxctl/lib/libdaxctl.c         | 228 +++++++++++++++++++++++++++++++++
>  daxctl/lib/libdaxctl.sym       |   4 +
>  daxctl/libdaxctl.h             |   4 +
>  4 files changed, 242 insertions(+)
>
> diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
> index e64d0a7..ef443aa 100644
> --- a/daxctl/lib/libdaxctl-private.h
> +++ b/daxctl/lib/libdaxctl-private.h
> @@ -33,6 +33,11 @@ static const char *dax_modules[] = {
>         [DAXCTL_DEV_MODE_RAM] = "kmem",
>  };
>
> +enum node_state {
> +       NODE_OFFLINE,
> +       NODE_ONLINE,
> +};
> +
>  /**
>   * struct daxctl_region - container for dax_devices
>   */
> @@ -63,6 +68,7 @@ struct daxctl_dev {
>         struct kmod_module *module;
>         struct kmod_list *kmod_list;
>         struct daxctl_region *region;
> +       int target_node;
>  };
>
>  static inline int check_kmod(struct kmod_ctx *kmod_ctx)
> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
> index 2890f69..46dbd63 100644
> --- a/daxctl/lib/libdaxctl.c
> +++ b/daxctl/lib/libdaxctl.c
> @@ -28,6 +28,7 @@
>  #include "libdaxctl-private.h"
>
>  static const char *attrs = "dax_region";
> +static const char *node_base = "/sys/devices/system/node";
>
>  static void free_region(struct daxctl_region *region, struct list_head *head);
>
> @@ -393,6 +394,12 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
>         if (rc == 0)
>                 dev->kmod_list = to_module_list(ctx, buf);
>
> +       sprintf(path, "%s/target_node", daxdev_base);
> +       if (sysfs_read_attr(ctx, path, buf) == 0)
> +               dev->target_node = strtol(buf, NULL, 0);
> +       else
> +               dev->target_node = -1;
> +
>         daxctl_dev_foreach(region, dev_dup)
>                 if (dev_dup->id == dev->id) {
>                         free_dev(dev, NULL);
> @@ -893,3 +900,224 @@ DAXCTL_EXPORT unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev)
>  {
>         return dev->size;
>  }
> +
> +DAXCTL_EXPORT int daxctl_dev_get_target_node(struct daxctl_dev *dev)
> +{
> +       return dev->target_node;
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
> +               return 0;
> +
> +       rc = sysfs_write_attr_quiet(ctx, path, mode);
> +       if (rc)
> +               err(ctx, "%s: Failed to online %s: %s\n",
> +                       devname, path, strerror(-rc));
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
> +       if (strncmp(buf, "offline", 6) == 0)
> +               return 0;
> +
> +       rc = sysfs_write_attr_quiet(ctx, path, mode);
> +       if (rc)
> +               err(ctx, "%s: Failed to offline %s: %s\n",
> +                       devname, path, strerror(-rc));
> +       return rc;
> +}
> +
> +static int daxctl_dev_node_set_state(struct daxctl_dev *dev,
> +               enum node_state state)
> +{
> +       struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> +       int target_node, rc, changed = 0;
> +       struct dirent *de;
> +       char *node_path;
> +       DIR *node_dir;
> +
> +       target_node = daxctl_dev_get_target_node(dev);
> +       if (target_node < 0) {
> +               err(ctx, "%s: Unable to get target node\n",
> +                       daxctl_dev_get_devname(dev));
> +               return -ENXIO;
> +       }
> +
> +       rc = asprintf(&node_path, "%s/node%d", node_base, target_node);
> +       if (rc < 0)
> +               return -ENOMEM;

To date the only usage of asprintf for path names has been in object
constructor / init paths. This tries to guarantee that all userspace
-ENOMEM errors are bypassed once you have the object established. The
thinking here is to simplify any future audit where we need to
guarantee APIs that don't allocate memory, but also to make all
allocate/free management symmetrical with object create/destroy.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
