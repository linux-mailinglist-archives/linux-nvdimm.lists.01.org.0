Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E41F9C0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 20:12:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DC936212735A7;
	Wed, 15 May 2019 11:12:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 451C62126CF82
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 11:12:10 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l25so1088216eda.9
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cRze2NwhKxUmrX+tzMEVzIsVCeW3eu3pdWGyD6SSofc=;
 b=oeDGU3G/EXvFp7MfI+JKrqpXLbgsT6KAvUNZwN8SvRY8NFh8phZ9eN40SJQs3yP2fF
 xQNVjFfygUwrlQzRAqlFFs3367XKy6ATqv70WcrTiffrGv7U/o3QoC81OUCvJzdZRG8p
 fqksNru7bvmonPrCDmNwVrVxLr0kycm3ve3KadWmE1UFyAX2ZtlcSctN9f0/UTLoaQED
 uqdMTABej7gKmQzFPgmWzXufN8r0wCE/82Oi8MK3COsE69Q3aMhsB5hZM2JLeEJBuvHb
 A5JnLn4InCloW4LPV1lgyTA4tT/OifK8s0UGspOPwh+TZm33S8DDhDFfnfUf5QC8KTZX
 SCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cRze2NwhKxUmrX+tzMEVzIsVCeW3eu3pdWGyD6SSofc=;
 b=rShxQS+kwgf+8pQthL6JBKC+uKgLuH257c2bUKpQGdO90+gfWkkwsQC4h6p4mcPQCC
 Td0SEAINv+fe8Shj/WlLFjfYUXcNkELABWiHV1aCev9m3KScQX1qmUqCeiHathT/MagH
 IeRAt4AxXsuEoMC1gQq0styO+lRKht4QZDCg0Hy4rCHtDCGCrIjxLNxAISomKbVsX4op
 lDilyF5fDDOXAk9FtuLTi53Roj4aNTt4M5/tYXE+PbO0NN8dh0q7PkN4nZfyOpMa+eRb
 sT7fq3XKLugXBJGhvntqaITusRdYK2bmxOQqnP2+QS1U1rT47ToAgY6dtebqrNvk+YuT
 lvSQ==
X-Gm-Message-State: APjAAAXw3278lq7Zpn2cp2/UvK5mYqGGVkRJ/TmBp+GGfzfZv/eoOzSR
 mJkmJYNNsM+oDlmf2lrBL9aDhWQyyrjON9c4aFn5ew==
X-Google-Smtp-Source: APXvYqziaXhGwhi8bJ4LWNTeRpPXVwzEAL199XnjwVbC6ahkOtixM/ml3bxeFuTijrrGJ9mfac3GS9qVcSia6Y2UUt0=
X-Received: by 2002:a17:906:5c0f:: with SMTP id
 e15mr34389391ejq.151.1557943929264; 
 Wed, 15 May 2019 11:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
 <76dfe7943f2a0ceaca73f5fd23e944dfdc0309d1.camel@intel.com>
In-Reply-To: <76dfe7943f2a0ceaca73f5fd23e944dfdc0309d1.camel@intel.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 15 May 2019 14:11:58 -0400
Message-ID: <CA+CK2bCKcJjXo7BGAVxvbQNYQFSDVLH5aB=S9yTmZWEfexOvtg@mail.gmail.com>
Subject: Re: [v5 0/3] "Hotremove" persistent memory
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
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
 "bhelgaas@google.com" <bhelgaas@google.com>, "bp@suse.de" <bp@suse.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

> Hi Pavel,
>
> I am working on adding this sort of a workflow into a new daxctl command
> (daxctl-reconfigure-device)- this will allow changing the 'mode' of a
> dax device to kmem, online the resulting memory, and with your patches,
> also attempt to offline the memory, and change back to device-dax.
>
> In running with these patches, and testing the offlining part, I ran
> into the following lockdep below.
>
> This is with just these three patches on top of -rc7.
>
>
> [  +0.004886] ======================================================
> [  +0.001576] WARNING: possible circular locking dependency detected
> [  +0.001506] 5.1.0-rc7+ #13 Tainted: G           O
> [  +0.000929] ------------------------------------------------------
> [  +0.000708] daxctl/22950 is trying to acquire lock:
> [  +0.000548] 00000000f4d397f7 (kn->count#424){++++}, at: kernfs_remove_by_name_ns+0x40/0x80
> [  +0.000922]
>               but task is already holding lock:
> [  +0.000657] 000000002aa52a9f (mem_sysfs_mutex){+.+.}, at: unregister_memory_section+0x22/0xa0

I have studied this issue, and now have a clear understanding why it
happens, I am not yet sure how to fix it, so suggestions are welcomed
:)

Here is the problem:

When we offline pages we have the following call stack:

# echo offline > /sys/devices/system/memory/memory8/state
ksys_write
 vfs_write
  __vfs_write
   kernfs_fop_write
    kernfs_get_active
     lock_acquire                       kn->count#122 (lock for
"memory8/state" kn)
    sysfs_kf_write
     dev_attr_store
      state_store
       device_offline
        memory_subsys_offline
         memory_block_action
          offline_pages
           __offline_pages
            percpu_down_write
             down_write
              lock_acquire              mem_hotplug_lock.rw_sem

When we unbind dax0.0 we have the following  stack:
# echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
drv_attr_store
 unbind_store
  device_driver_detach
   device_release_driver_internal
    dev_dax_kmem_remove
     remove_memory                      device_hotplug_lock
      try_remove_memory                 mem_hotplug_lock.rw_sem
       arch_remove_memory
        __remove_pages
         __remove_section
          unregister_memory_section
           remove_memory_section        mem_sysfs_mutex
            unregister_memory
             device_unregister
              device_del
               device_remove_attrs
                sysfs_remove_groups
                 sysfs_remove_group
                  remove_files
                   kernfs_remove_by_name
                    kernfs_remove_by_name_ns
                     __kernfs_remove    kn->count#122

So, lockdep found the ordering issue with the above two stacks:

1. kn->count#122 -> mem_hotplug_lock.rw_sem
2. mem_hotplug_lock.rw_sem -> kn->count#122
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
