Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DE61FCE2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 02:42:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A63DE212794C4;
	Wed, 15 May 2019 17:42:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 01CC0212794BB
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 17:42:54 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id j49so1775390otc.13
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 17:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4wF4B/XO+LFCzisDrNsMqmlSL+kOk21IiP/4p8K0X7U=;
 b=U/Y22/bCzRIzE1Xsqh5f3+RBvJUV1RMz+pVgOjqYlQhz4iQqdrUPBRWbWciAaasKQe
 vf8QyeNFoGsz8yqkGygyREx7lhw9HstPaMuVrr27/KyitIfiP0TnNsEbh+rsCCGBoUDY
 irfkr7iszBcaj4LIg2eFjALBbAw0LyVbqSAuaajKOP0NsaCv5sTe9zXHbxvKAFhfARk0
 7L4havjtTmMCm3Md5Y9rr5ig4PFYphhp95oMlWixzxiSkNqTP59gYvQk/rhziKM7Zrrm
 VAtwNZsGyNLgm0GA15nZVzk8++wQz8D0asXbsKwS3EQzV03FdRgsSypZRh/sKEIYDtVc
 9H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4wF4B/XO+LFCzisDrNsMqmlSL+kOk21IiP/4p8K0X7U=;
 b=dmS6VqZNBF170RKy8hiKcvwbeOrkeLf9IJUCLAMZDBBiNzvUQ3zNxXJD6qMxgB++B2
 icXz8zMB5awDpsve3GdmMfMJ9ewBA9urepcAF60fXwjbV+icz/+V9Gr4Wgzd34voQHUD
 Hg2In2vaeK2LnkyYslXEQJvL3wUEvciOGjo2ahLoP1ppnhWKhbXvEZ/R5mIj5KcvVPV1
 BocGTfMRqSqHQHC0lxPkp05cb4f5Q/6/2Ig/PQ5HIeTNa7P5PaH7ypUvfi8V2pFob+Wm
 C1NVyMa0rCiQCs4icrkHGAKWZVnMSubRek6HNH3MivYGJYA4RRyPHLhgx+Av8Dbne4hf
 PsMQ==
X-Gm-Message-State: APjAAAWnJqwfvRKtUKHGwrvuJZ5KXIny5drZZUR2RpoqnUKWN8Cy75mr
 tOnpTpzM+dyBZWtAHWVpZ1LuafTdvRsBUvUL0ZmZVw==
X-Google-Smtp-Source: APXvYqxHHdBhJkGMx5fiIIlPrJsnSR6+qYmBOEInSq5ilrexTUGafywN2clUkUaBI+pWKFUlTJBtGXaBRq9YnBc8yJ0=
X-Received: by 2002:a9d:d09:: with SMTP id 9mr28295683oti.82.1557967372879;
 Wed, 15 May 2019 17:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
 <76dfe7943f2a0ceaca73f5fd23e944dfdc0309d1.camel@intel.com>
 <CA+CK2bCKcJjXo7BGAVxvbQNYQFSDVLH5aB=S9yTmZWEfexOvtg@mail.gmail.com>
In-Reply-To: <CA+CK2bCKcJjXo7BGAVxvbQNYQFSDVLH5aB=S9yTmZWEfexOvtg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 15 May 2019 17:42:42 -0700
Message-ID: <CAPcyv4jj557QNNwyQ7ez+=PnURsnXk9cGZ11Mmihmtem2bJ-3A@mail.gmail.com>
Subject: Re: [v5 0/3] "Hotremove" persistent memory
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
Cc: "sashal@kernel.org" <sashal@kernel.org>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "mhocko@suse.com" <mhocko@suse.com>, "david@redhat.com" <david@redhat.com>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Huang,
 Ying" <ying.huang@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jmorris@namei.org" <jmorris@namei.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "jglisse@redhat.com" <jglisse@redhat.com>, "Wu,
 Fengguang" <fengguang.wu@intel.com>,
 "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>,
 "zwisler@kernel.org" <zwisler@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "bp@suse.de" <bp@suse.de>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 15, 2019 at 11:12 AM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > Hi Pavel,
> >
> > I am working on adding this sort of a workflow into a new daxctl command
> > (daxctl-reconfigure-device)- this will allow changing the 'mode' of a
> > dax device to kmem, online the resulting memory, and with your patches,
> > also attempt to offline the memory, and change back to device-dax.
> >
> > In running with these patches, and testing the offlining part, I ran
> > into the following lockdep below.
> >
> > This is with just these three patches on top of -rc7.
> >
> >
> > [  +0.004886] ======================================================
> > [  +0.001576] WARNING: possible circular locking dependency detected
> > [  +0.001506] 5.1.0-rc7+ #13 Tainted: G           O
> > [  +0.000929] ------------------------------------------------------
> > [  +0.000708] daxctl/22950 is trying to acquire lock:
> > [  +0.000548] 00000000f4d397f7 (kn->count#424){++++}, at: kernfs_remove_by_name_ns+0x40/0x80
> > [  +0.000922]
> >               but task is already holding lock:
> > [  +0.000657] 000000002aa52a9f (mem_sysfs_mutex){+.+.}, at: unregister_memory_section+0x22/0xa0
>
> I have studied this issue, and now have a clear understanding why it
> happens, I am not yet sure how to fix it, so suggestions are welcomed
> :)

I would think that ACPI hotplug would have a similar problem, but it does this:

                acpi_unbind_memory_blocks(info);
                __remove_memory(nid, info->start_addr, info->length);

I wonder if that ordering prevents going too deep into the
device_unregister() call stack that you highlighted below.


>
> Here is the problem:
>
> When we offline pages we have the following call stack:
>
> # echo offline > /sys/devices/system/memory/memory8/state
> ksys_write
>  vfs_write
>   __vfs_write
>    kernfs_fop_write
>     kernfs_get_active
>      lock_acquire                       kn->count#122 (lock for
> "memory8/state" kn)
>     sysfs_kf_write
>      dev_attr_store
>       state_store
>        device_offline
>         memory_subsys_offline
>          memory_block_action
>           offline_pages
>            __offline_pages
>             percpu_down_write
>              down_write
>               lock_acquire              mem_hotplug_lock.rw_sem
>
> When we unbind dax0.0 we have the following  stack:
> # echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
> drv_attr_store
>  unbind_store
>   device_driver_detach
>    device_release_driver_internal
>     dev_dax_kmem_remove
>      remove_memory                      device_hotplug_lock
>       try_remove_memory                 mem_hotplug_lock.rw_sem
>        arch_remove_memory
>         __remove_pages
>          __remove_section
>           unregister_memory_section
>            remove_memory_section        mem_sysfs_mutex
>             unregister_memory
>              device_unregister
>               device_del
>                device_remove_attrs
>                 sysfs_remove_groups
>                  sysfs_remove_group
>                   remove_files
>                    kernfs_remove_by_name
>                     kernfs_remove_by_name_ns
>                      __kernfs_remove    kn->count#122
>
> So, lockdep found the ordering issue with the above two stacks:
>
> 1. kn->count#122 -> mem_hotplug_lock.rw_sem
> 2. mem_hotplug_lock.rw_sem -> kn->count#122
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
