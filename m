Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D6CDCF3F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 21:26:21 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 456E910FCB39E;
	Fri, 18 Oct 2019 12:28:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1CC9710FCB39E
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 12:28:22 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t84so6124640oih.10
        for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 12:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3f40XLA0PVJw/iy/X9b99HrOPJO309mF75KF41ViMEE=;
        b=nvGFvANdexx1g6xglNvfhCKM9MRblUwKydVvUVPRUcy07vQeUPU+GzI6m+2BFsFwrd
         DchBJ66cyDIuwsjnX+4iIMWOgp5bcBFlh6nZvA6k1BhM9tNNYvy5Y114n4lRnwZgE57X
         hCeIhiY6ENJ31RC3R0sLC6eaqeNHS0ZOvZRttcZ/Fry9ND1aPozBmhzHYbhmSxhAaQ22
         mIn33GlFlAkOuK6cwG5C7GsYFetP512ccQgPYNssuOsgbGn5JmWouQ0Rcyca6QZ1QWOC
         F+H+VpKq4qSizYsrpczVfDUPVMi74m8blTApAG7/btJbjoGcHMIwkbKPzJh7PDWwZKwq
         u3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3f40XLA0PVJw/iy/X9b99HrOPJO309mF75KF41ViMEE=;
        b=k1TwA6m/zmlLwfFYgNmb3tnz7JhJSdeDzDER0cBZzOF0IZQq1+uxxkBQbwISrrgn6R
         F/6B6OIpGUeIkO3HcZ8cBe7kCxrrcnUaDp/5cDOhpInyQ4XTNoFgR3uRwV/H/Jkf7W+9
         KdblpY7KiLOnke6ROhsQhQTrXpqoUU61bZnwiJ99rEGxNdUm1DyX5BXoawFEGq/GnUr/
         xD2Gx9Ef73nTPLNwes/5+LtkEh3LGnPplvA3mQyD6wDJyifnpG7NOZsYbytaNoJKc1ur
         MP/G6iJN75NQ/FAr+4PZXCSSy25hM6RvTUr4tCLHJr1HGuprcQ1ae0RaOjeW7p4qcm1c
         j0Gg==
X-Gm-Message-State: APjAAAWOoMZY0+cb6mpJScfcs2z6EDa9FBu0cTyVY3Ugl3RRSTdQ1fch
	NOZ34An6MmBlD76+gApAgn3/af20ktv6ckaaopDGNKBA
X-Google-Smtp-Source: APXvYqwr3sJ7AE4ZB54v90/WCNFTbLdALUzGOQoNmOT78A7qhwOxDjn72hODWaBxeI5SIqwcGEhBtZ00b/9hsbXCmI0=
X-Received: by 2002:aca:6087:: with SMTP id u129mr9678870oib.149.1571426776309;
 Fri, 18 Oct 2019 12:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191002234925.9190-1-vishal.l.verma@intel.com> <20191002234925.9190-8-vishal.l.verma@intel.com>
In-Reply-To: <20191002234925.9190-8-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Oct 2019 12:26:05 -0700
Message-ID: <CAPcyv4jDwRkm7XigA1VKWt-OSd_jOmLqhiBXw2T1JRStOMNzqA@mail.gmail.com>
Subject: Re: [ndctl PATCH 07/10] daxctl: detect races when onlining memory blocks
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: YYR2SIMURJLTXNB42KHAIGCE4QWJFC2S
X-Message-ID-Hash: YYR2SIMURJLTXNB42KHAIGCE4QWJFC2S
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Dave Hansen <dave.hansen@linux.intel.com>, Ben Olson <ben.olson@intel.com>, Michal Biesek <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YYR2SIMURJLTXNB42KHAIGCE4QWJFC2S/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2019 at 4:49 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Sometimes, system configuration can result in new memory blocks getting
> onlined automatically. Often, these auto-onlining mechanisms don't
> provide a choice or configurability in the matter of which zone is used
> for these new blocks, and they just end up in ZONE_NORMAL.
>
> Usually, for hot-plugged memory, ZONE_NORMAL is undesirable because:
>  - An application might want total control over this memory
>  - ZONE_NORMAL precludes hot-removal of this memory
>  - Having kernel data structures in this memory, especially performance
>    sensitive ones, such as page tables, may be undesirable.
>
> Thus report if a race condition is encountered while onlining memory,
> and provide the user options to remedy it.
>
> Clarify the default zone expectations, and the race detection behavior
> in the daxctl-reconfigure-device man page, and move the relevant section
> under the 'Description' header, instead of hidden away under the
> '--no-online' option.
>
> Cc: Ben Olson <ben.olson@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  daxctl/device.c        |  9 ++++++
>  daxctl/lib/libdaxctl.c | 62 +++++++++++++++++++++++++++++-------------
>  2 files changed, 52 insertions(+), 19 deletions(-)
>
> diff --git a/daxctl/device.c b/daxctl/device.c
> index 920efc6..28698bf 100644
> --- a/daxctl/device.c
> +++ b/daxctl/device.c
> @@ -174,6 +174,15 @@ static int dev_online_memory(struct daxctl_dev *dev)
>                         devname, strerror(-num_on));
>                 return num_on;
>         }
> +       if (num_on)
> +               fprintf(stderr,
> +                   "%s:\n  WARNING: detected a race while onlining memory\n"
> +                   "  Some memory may not be in the expected zone. It is\n"
> +                   "  recommended to disable any other onlining mechanisms,\n"
> +                   "  and retry. If onlining is to be left to other agents,\n"
> +                   "  use the --no-online option to suppress this warning\n",
> +                   devname);
> +
>         if (num_on == num_sections) {
>                 fprintf(stderr, "%s: all memory sections (%d) already online\n",
>                         devname, num_on);
> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
> index 617887c..5a7e37c 100644
> --- a/daxctl/lib/libdaxctl.c
> +++ b/daxctl/lib/libdaxctl.c
> @@ -1079,10 +1079,10 @@ static int memblock_is_online(struct daxctl_memory *mem, char *memblock)
>         return 0;
>  }
>
> -static int online_one_memblock(struct daxctl_memory *mem, char *memblock)
> +static int online_one_memblock(struct daxctl_memory *mem, char *memblock,
> +               int *status)
>  {
>         struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
> -       const char *devname = daxctl_dev_get_devname(dev);
>         struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
>         const char *mode = "online_movable";
>         int len = mem->buf_len, rc;
> @@ -1097,10 +1097,6 @@ static int online_one_memblock(struct daxctl_memory *mem, char *memblock)
>         if (rc < 0)
>                 return -ENOMEM;
>
> -       /*
> -        * if already online, possibly due to kernel config or a udev rule,
> -        * there is nothing to do and we can skip over the memblock
> -        */
>         rc = memblock_is_online(mem, memblock);
>         if (rc)
>                 return rc;
> @@ -1108,18 +1104,14 @@ static int online_one_memblock(struct daxctl_memory *mem, char *memblock)
>         rc = sysfs_write_attr_quiet(ctx, path, mode);
>         if (rc) {
>                 /*
> -                * While we performed an already-online check above, there
> -                * is still a TOCTOU hole where someone (such as a udev rule)
> -                * may have raced to online the memory. In such a case,
> -                * the sysfs store will fail, however we can check for this
> -                * by simply reading the state again. If it changed to the
> -                * desired state, then we don't have to error out.
> +                * If the block got onlined, potentially by some other agent,
> +                * do nothing for now. There will be a full scan for zone
> +                * correctness later.
>                  */
> -               if (memblock_is_online(mem, memblock))
> -                       return 1;
> -               err(ctx, "%s: Failed to online %s: %s\n",
> -                       devname, path, strerror(-rc));
> +               if (memblock_is_online(mem, memblock) == 1)
> +                       return 0;
>         }
> +
>         return rc;
>  }
>
> @@ -1150,7 +1142,7 @@ static int offline_one_memblock(struct daxctl_memory *mem, char *memblock)
>
>         rc = sysfs_write_attr_quiet(ctx, path, mode);
>         if (rc) {
> -               /* Close the TOCTOU hole like in online_one_memblock() above */
> +               /* check if something raced us to offline (unlikely) */
>                 if (!memblock_is_online(mem, memblock))
>                         return 1;
>                 err(ctx, "%s: Failed to offline %s: %s\n",
> @@ -1274,7 +1266,7 @@ static int op_for_one_memblock(struct daxctl_memory *mem, char *memblock,
>
>         switch (op) {
>         case MEM_SET_ONLINE:
> -               return online_one_memblock(mem, memblock);
> +               return online_one_memblock(mem, memblock, status);
>         case MEM_SET_OFFLINE:
>                 return offline_one_memblock(mem, memblock);
>         case MEM_IS_ONLINE:
> @@ -1349,9 +1341,41 @@ out_dir:
>         return rc;
>  }
>
> +/*
> + * daxctl_memory_online() will online to ZONE_MOVABLE by default
> + */
>  DAXCTL_EXPORT int daxctl_memory_online(struct daxctl_memory *mem)
>  {
> -       return daxctl_memory_op(mem, MEM_SET_ONLINE);
> +       struct daxctl_dev *dev = daxctl_memory_get_dev(mem);
> +       const char *devname = daxctl_dev_get_devname(dev);
> +       struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> +       int rc;
> +
> +       rc = daxctl_memory_op(mem, MEM_SET_ONLINE);
> +       if (rc)
> +               return rc;
> +
> +       /*
> +        * Detect any potential races when blocks were being brought online by
> +        * checking the zone in which the memory blocks are at this point. If
> +        * any of the blocks are not in ZONE_MOVABLE, emit a warning.
> +        */
> +       mem->zone = 0;
> +       rc = daxctl_memory_op(mem, MEM_FIND_ZONE);
> +       if (rc)
> +               return rc;
> +       if (mem->zone != MEM_ZONE_MOVABLE) {
> +               err(ctx,
> +                   "%s:\n  WARNING: detected a race while onlining memory\n"
> +                   "  Some memory may not be in the expected zone. It is\n"
> +                   "  recommended to disable any other onlining mechanisms,\n"
> +                   "  and retry. If onlining is to be left to other agents,\n"
> +                   "  use the --no-online option to suppress this warning\n",
> +                   devname);

Rather than duplicate this largish warning message what about a
smaller one that references the man page about remediation
possibilities. Then you can also name distro udev rule as one of the
usual suspects that causes this.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
