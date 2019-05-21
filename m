Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512B625639
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 May 2019 18:56:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4983E21275471;
	Tue, 21 May 2019 09:56:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BE6B221275459
 for <linux-nvdimm@lists.01.org>; Tue, 21 May 2019 09:54:15 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id l17so17005277otq.1
 for <linux-nvdimm@lists.01.org>; Tue, 21 May 2019 09:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oHyxxdCulthGGKCbcuDYU1DyzLMsf7EAoBxw15HJNqA=;
 b=KmrwjgH55rKUw5bqIvpvFnD07PXHH7SJsCt1oTLDYR+Ngbo95qTBMiDayK/T72vXZN
 Avx47DGuOuF1vapQph16LlsXG1juDYSt9PIzVC+ClWmLndroDTHzFUWCacgdagkgOfKB
 RZNUEEoUbhaWH5kvICIk9zR+I59+NAep489TP336aGQG6FqPf2MTL+jNJ2GMoHDKTGUR
 t3Xc4Wf6A+/2QtsYp3wdSbw8oTBXMmxpJA4v3cI7HA5pT9zYwL6ebm8BLJuLsAKMmYzZ
 qZQmGLZqAMLzcj0iPF8/V6TgDHh0HnEDyIlIpVTw/SlnvwzNv+at8W4uxA6DmyOMLZMe
 TRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oHyxxdCulthGGKCbcuDYU1DyzLMsf7EAoBxw15HJNqA=;
 b=iR7ws3HTSwDyxUIEQ6NvTlWcBovgIrSJ/II7DNG9THW44u63/FXFJ52JZD+Dv82NHQ
 BJ/mXiH/ZCqQrPoH3rVRwTy/AhkH1Jmjhr6itKaL0zPXANmxrDaljchHLCbxFdkg/yq3
 rH/f4dhkxeJtCkCWZlLSyoyFi2uPwNJjrnjcI6MgN3ricVVhdRM4rmooab0tbxK83s+o
 Udy92YZdcenH85qEvr6nurSesthlOc0VRXCLleiDBRm0+LO2UkgHelmoCAOyoQWg2LMd
 jQi5jRv34eyE3+JXl7J4aacbeNRwtv/LlH+a534JNX0eLNzLaV8x0aSzxSvK7zLPb3g3
 8rnA==
X-Gm-Message-State: APjAAAU4/7WW7SQZvjLBkNr2JT3lyveBxyR+pgHfBqA8802pjFsZFib7
 8PBS/h00rdcpuGxTLwEl9iaOchFzZygIXYL56f4TsQ==
X-Google-Smtp-Source: APXvYqwIKt/XH22CjB9xbefxXBJf+2suHAPutL2reWSQeS/hGSPLUhtpc4EiRbPj70y29pq/8uIl/yv2T9ANELNfFz0=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr3999902otr.207.1558457654221; 
 Tue, 21 May 2019 09:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190517215438.6487-1-pasha.tatashin@soleen.com>
 <20190517215438.6487-4-pasha.tatashin@soleen.com>
In-Reply-To: <20190517215438.6487-4-pasha.tatashin@soleen.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 21 May 2019 09:54:03 -0700
Message-ID: <CAPcyv4iZ7sx6L+3yDKSXth6b+qdtCmVrLxmCvCuRAYBMbSM+Bw@mail.gmail.com>
Subject: Re: [v6 3/3] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To: Pavel Tatashin <pasha.tatashin@soleen.com>
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
Cc: Sasha Levin <sashal@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michal Hocko <mhocko@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Takashi Iwai <tiwai@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Huang, Ying" <ying.huang@intel.com>, James Morris <jmorris@namei.org>,
 David Hildenbrand <david@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Borislav Petkov <bp@suse.de>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Ross Zwisler <zwisler@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 17, 2019 at 2:54 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> It is now allowed to use persistent memory like a regular RAM, but
> currently there is no way to remove this memory until machine is
> rebooted.
>
> This work expands the functionality to also allows hotremoving
> previously hotplugged persistent memory, and recover the device for use
> for other purposes.
>
> To hotremove persistent memory, the management software must first
> offline all memory blocks of dax region, and than unbind it from
> device-dax/kmem driver. So, operations should look like this:
>
> echo offline > /sys/devices/system/memory/memoryN/state
> ...
> echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
>
> Note: if unbind is done without offlining memory beforehand, it won't be
> possible to do dax0.0 hotremove, and dax's memory is going to be part of
> System RAM until reboot.
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/dax/dax-private.h |  2 ++
>  drivers/dax/kmem.c        | 41 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index a45612148ca0..999aaf3a29b3 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -53,6 +53,7 @@ struct dax_region {
>   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
>   * @ref: pgmap reference count (driver owned)
>   * @cmp: @ref final put completion (driver owned)
> + * @dax_mem_res: physical address range of hotadded DAX memory
>   */
>  struct dev_dax {
>         struct dax_region *region;
> @@ -62,6 +63,7 @@ struct dev_dax {
>         struct dev_pagemap pgmap;
>         struct percpu_ref ref;
>         struct completion cmp;
> +       struct resource *dax_kmem_res;
>  };
>
>  static inline struct dev_dax *to_dev_dax(struct device *dev)
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 4c0131857133..3d0a7e702c94 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -71,21 +71,54 @@ int dev_dax_kmem_probe(struct device *dev)
>                 kfree(new_res);
>                 return rc;
>         }
> +       dev_dax->dax_kmem_res = new_res;
>
>         return 0;
>  }
>
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +static int dev_dax_kmem_remove(struct device *dev)
> +{
> +       struct dev_dax *dev_dax = to_dev_dax(dev);
> +       struct resource *res = dev_dax->dax_kmem_res;
> +       resource_size_t kmem_start = res->start;
> +       resource_size_t kmem_size = resource_size(res);
> +       int rc;
> +
> +       /*
> +        * We have one shot for removing memory, if some memory blocks were not
> +        * offline prior to calling this function remove_memory() will fail, and
> +        * there is no way to hotremove this memory until reboot because device
> +        * unbind will succeed even if we return failure.
> +        */
> +       rc = remove_memory(dev_dax->target_node, kmem_start, kmem_size);
> +       if (rc) {
> +               dev_err(dev,
> +                       "DAX region %pR cannot be hotremoved until the next reboot\n",
> +                       res);

Small quibbles with this error message... "DAX" is redundant since the
device name is printed by dev_err(). I'd suggest dropping "until the
next reboot" since there is no guarantee it will work then either and
the surefire mechanism to recover the memory from the kmem driver is
to not add it in the first place. Perhaps also print out the error
code in case it might specify a finer grained reason the memory is
pinned.

Other than that you can add

   Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...as it looks like Andrew will take this through -mm.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
