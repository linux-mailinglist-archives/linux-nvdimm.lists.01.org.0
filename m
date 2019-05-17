Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0BB21998
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 16:10:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A40BD212746EE;
	Fri, 17 May 2019 07:10:11 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8DA3821274213
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 07:10:10 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id f37so10716663edb.13
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JEZenaNx5fOofw5xT3FstUM+mIDA6wVaU4AMUffgStE=;
 b=WwhxwOjBydlnbkyKIrlRzf+UwIiH0mmzCOUeljVXeICuPhqG4zeihVPeB2+kwGDIuv
 1nT7KB02aYUC1f+/ulLo55c2pydWxkm1phpSUkk5WUWme9j/pO9mplihH/VRAPm5nAZ3
 yZMQ6Pb/+vqbQFo0zcdyvY+eaSsrwG1Z9VoSsMV+MgHQh+wS2FaI2L/UlrFE710sOj7Q
 iZ5LExbpKFRkB6zoEYGfwx8oyuxlAj5AQzsvuXCEgegrJn2hvjGRTVtKu430D+VVBtFA
 vrFjvInV4yIkVDyPr79xMoHiMLylDOEt3Fg1EMO/uY8Gqc7Q0Sig14/RMsSaQW0Mc/EY
 xdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JEZenaNx5fOofw5xT3FstUM+mIDA6wVaU4AMUffgStE=;
 b=P+fslotJ0c2MYuSFg0Tzvqk/znDS6XelA+54DResWFuuUomXaNGsjvKVd12lHSxO/E
 9jiPMn6M/0G5JbORco5jCSkjiokQZ9IvSFH3O0K9H6rMkatWcCm8foVKTa2/vGgRvhlF
 SipFfdaArKl7xCbq5JBDN0U85sY9i1HsDn3cgczxy1xhFMswXEIDHVbDO9jcOc6xnALn
 ZtUndOSuvhvYegQleJb1MVq9bn2WlR9Wwxz0PVHPcK79XpS7Fg2yE5OET3uI9LyRTyHa
 3g0ZgQqoLT1S/zcNQXPr/+sCz649E8xtBsN7Y9fbbifSbx4jG4aQCdRDgJ5FCMZt8siL
 fgrg==
X-Gm-Message-State: APjAAAW6W5UN/uW4nMSdlpV2sR+9KIVXCEPaMRkqjaxyhv9WJySk2SEA
 oisDWzN22VXDsEVYJ3pjNM5Ez7D917N2u1by8jYbfw==
X-Google-Smtp-Source: APXvYqxwta1bBnW9ibZmkle7cwDOWu2IVfiPzm5lx2a8ut0ru2ou6qHINZEsDNJJvK4LwRSWaa03W5v/iaPf6/ltI80=
X-Received: by 2002:a50:ce5b:: with SMTP id k27mr5578731edj.48.1558102208394; 
 Fri, 17 May 2019 07:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
 <76dfe7943f2a0ceaca73f5fd23e944dfdc0309d1.camel@intel.com>
 <CA+CK2bCKcJjXo7BGAVxvbQNYQFSDVLH5aB=S9yTmZWEfexOvtg@mail.gmail.com>
 <CAPcyv4jj557QNNwyQ7ez+=PnURsnXk9cGZ11Mmihmtem2bJ-3A@mail.gmail.com>
In-Reply-To: <CAPcyv4jj557QNNwyQ7ez+=PnURsnXk9cGZ11Mmihmtem2bJ-3A@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 17 May 2019 10:09:57 -0400
Message-ID: <CA+CK2bBLAD58Q545r6W9eSwKJ3-BgzUF5oLAn6wHUcDi=jBpdw@mail.gmail.com>
Subject: Re: [v5 0/3] "Hotremove" persistent memory
To: Dan Williams <dan.j.williams@intel.com>
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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

>
> I would think that ACPI hotplug would have a similar problem, but it does this:
>
>                 acpi_unbind_memory_blocks(info);
>                 __remove_memory(nid, info->start_addr, info->length);

ACPI does have exactly the same problem, so this is not a bug for this
series, I will submit a new version of my series with comments
addressed, but without fix for this issue.

I was able to reproduce this issue on the current mainline kernel.
Also, I been thinking more about how to fix it, and there is no easy
fix without a major hotplug redesign. Basically, we have to remove
sysfs memory entries before or after memory is hotplugged/hotremoved.
But, we also have to guarantee that hotplug/hotremove will succeed or
reinstate sysfs entries.

Qemu script:

qemu-system-x86_64                                                      \
        -enable-kvm                                                     \
        -cpu host                                                       \
        -parallel none                                                  \
        -echr 1                                                         \
        -serial none                                                    \
        -chardev stdio,id=console,signal=off,mux=on                     \
        -serial chardev:console                                         \
        -mon chardev=console                                            \
        -vga none                                                       \
        -display none                                                   \
        -kernel pmem/native/arch/x86/boot/bzImage                       \
        -m 8G,slots=1,maxmem=16G                                        \
        -smp 8                                                          \
        -fsdev local,id=virtfs1,path=/,security_model=none              \
        -device virtio-9p-pci,fsdev=virtfs1,mount_tag=hostfs            \
        -append 'earlyprintk=serial,ttyS0,115200 console=ttyS0
TERM=xterm ip=dhcp loglevel=7'

Config is attached.

Steps to reproduce:
#
# QEMU 4.0.0 monitor - type 'help' for more information
(qemu) object_add memory-backend-ram,id=mem1,size=1G
(qemu) device_add pc-dimm,id=dimm1,memdev=mem1
(qemu)

# echo online_movable > /sys/devices/system/memory/memory79/state
[   23.029552] Built 1 zonelists, mobility grouping on.  Total pages: 2045370
[   23.032591] Policy zone: Normal
# (qemu) device_del dimm1
(qemu) [   32.013950] Offlined Pages 32768
[   32.014307] Built 1 zonelists, mobility grouping on.  Total pages: 2031022
[   32.014843] Policy zone: Normal
[   32.015733]
[   32.015881] ======================================================
[   32.016390] WARNING: possible circular locking dependency detected
[   32.016881] 5.1.0_pt_pmem #38 Not tainted
[   32.017202] ------------------------------------------------------
[   32.017680] kworker/u16:4/380 is trying to acquire lock:
[   32.018096] 00000000675cc7e1 (kn->count#18){++++}, at:
kernfs_remove_by_name_ns+0x3b/0x80
[   32.018745]
[   32.018745] but task is already holding lock:
[   32.019201] 0000000053e50a99 (mem_sysfs_mutex){+.+.}, at:
unregister_memory_section+0x1d/0xa0
[   32.019859]
[   32.019859] which lock already depends on the new lock.
[   32.019859]
[   32.020499]
[   32.020499] the existing dependency chain (in reverse order) is:
[   32.021080]
[   32.021080] -> #4 (mem_sysfs_mutex){+.+.}:
[   32.021522]        __mutex_lock+0x8b/0x900
[   32.021843]        hotplug_memory_register+0x26/0xa0
[   32.022231]        __add_pages+0xe7/0x160
[   32.022545]        add_pages+0xd/0x60
[   32.022835]        add_memory_resource+0xc3/0x1d0
[   32.023207]        __add_memory+0x57/0x80
[   32.023530]        acpi_memory_device_add+0x13a/0x2d0
[   32.023928]        acpi_bus_attach+0xf1/0x200
[   32.024272]        acpi_bus_scan+0x3e/0x90
[   32.024597]        acpi_device_hotplug+0x284/0x3e0
[   32.024972]        acpi_hotplug_work_fn+0x15/0x20
[   32.025342]        process_one_work+0x2a0/0x650
[   32.025755]        worker_thread+0x34/0x3d0
[   32.026077]        kthread+0x118/0x130
[   32.026442]        ret_from_fork+0x3a/0x50
[   32.026766]
[   32.026766] -> #3 (mem_hotplug_lock.rw_sem){++++}:
[   32.027261]        get_online_mems+0x39/0x80
[   32.027600]        kmem_cache_create_usercopy+0x29/0x2c0
[   32.028019]        kmem_cache_create+0xd/0x10
[   32.028367]        ptlock_cache_init+0x1b/0x23
[   32.028724]        start_kernel+0x1d2/0x4b8
[   32.029060]        secondary_startup_64+0xa4/0xb0
[   32.029447]
[   32.029447] -> #2 (cpu_hotplug_lock.rw_sem){++++}:
[   32.030007]        cpus_read_lock+0x39/0x80
[   32.030360]        __offline_pages+0x32/0x790
[   32.030709]        memory_subsys_offline+0x3a/0x60
[   32.031089]        device_offline+0x7e/0xb0
[   32.031425]        acpi_bus_offline+0xd8/0x140
[   32.031821]        acpi_device_hotplug+0x1b2/0x3e0
[   32.032202]        acpi_hotplug_work_fn+0x15/0x20
[   32.032576]        process_one_work+0x2a0/0x650
[   32.032942]        worker_thread+0x34/0x3d0
[   32.033283]        kthread+0x118/0x130
[   32.033588]        ret_from_fork+0x3a/0x50
[   32.033919]
[   32.033919] -> #1 (&device->physical_node_lock){+.+.}:
[   32.034450]        __mutex_lock+0x8b/0x900
[   32.034784]        acpi_get_first_physical_node+0x16/0x60
[   32.035217]        acpi_companion_match+0x3b/0x60
[   32.035594]        acpi_device_uevent_modalias+0x9/0x20
[   32.036012]        platform_uevent+0xd/0x40
[   32.036352]        dev_uevent+0x85/0x1c0
[   32.036674]        kobject_uevent_env+0x1e2/0x640
[   32.037044]        kobject_synth_uevent+0x2b7/0x324
[   32.037428]        uevent_store+0x17/0x30
[   32.037752]        kernfs_fop_write+0xeb/0x1a0
[   32.038112]        vfs_write+0xb2/0x1b0
[   32.038417]        ksys_write+0x57/0xd0
[   32.038721]        do_syscall_64+0x4b/0x1a0
[   32.039053]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   32.039491]
[   32.039491] -> #0 (kn->count#18){++++}:
[   32.039913]        lock_acquire+0xaa/0x180
[   32.040242]        __kernfs_remove+0x244/0x2d0
[   32.040593]        kernfs_remove_by_name_ns+0x3b/0x80
[   32.040991]        device_del+0x14a/0x370
[   32.041309]        device_unregister+0x9/0x20
[   32.041653]        unregister_memory_section+0x69/0xa0
[   32.042059]        __remove_pages+0x112/0x460
[   32.042402]        arch_remove_memory+0x6f/0xa0
[   32.042758]        __remove_memory+0xab/0x130
[   32.043103]        acpi_memory_device_remove+0x67/0xe0
[   32.043537]        acpi_bus_trim+0x50/0x90
[   32.043889]        acpi_device_hotplug+0x2fa/0x3e0
[   32.044300]        acpi_hotplug_work_fn+0x15/0x20
[   32.044686]        process_one_work+0x2a0/0x650
[   32.045044]        worker_thread+0x34/0x3d0
[   32.045381]        kthread+0x118/0x130
[   32.045679]        ret_from_fork+0x3a/0x50
[   32.046005]
[   32.046005] other info that might help us debug this:
[   32.046005]
[   32.046636] Chain exists of:
[   32.046636]   kn->count#18 --> mem_hotplug_lock.rw_sem --> mem_sysfs_mutex
[   32.046636]
[   32.047514]  Possible unsafe locking scenario:
[   32.047514]
[   32.047976]        CPU0                    CPU1
[   32.048337]        ----                    ----
[   32.048697]   lock(mem_sysfs_mutex);
[   32.048983]                                lock(mem_hotplug_lock.rw_sem);
[   32.049519]                                lock(mem_sysfs_mutex);
[   32.050004]   lock(kn->count#18);
[   32.050270]
[   32.050270]  *** DEADLOCK ***
[   32.050270]
[   32.050736] 7 locks held by kworker/u16:4/380:
[   32.051087]  #0: 00000000a22fe78e
((wq_completion)kacpi_hotplug){+.+.}, at: process_one_work+0x21e/0x650
[   32.051830]  #1: 00000000944f2dca
((work_completion)(&hpw->work)){+.+.}, at:
process_one_work+0x21e/0x650
[   32.052577]  #2: 0000000024bbe147 (device_hotplug_lock){+.+.}, at:
acpi_device_hotplug+0x2e/0x3e0
[   32.053271]  #3: 000000005cb50027 (acpi_scan_lock){+.+.}, at:
acpi_device_hotplug+0x3c/0x3e0
[   32.053916]  #4: 00000000b8d06992 (cpu_hotplug_lock.rw_sem){++++},
at: __remove_memory+0x3b/0x130
[   32.054602]  #5: 00000000897f0ef4 (mem_hotplug_lock.rw_sem){++++},
at: percpu_down_write+0x1d/0x110
[   32.055315]  #6: 0000000053e50a99 (mem_sysfs_mutex){+.+.}, at:
unregister_memory_section+0x1d/0xa0
[   32.056016]
[   32.056016] stack backtrace:
[   32.056355] CPU: 4 PID: 380 Comm: kworker/u16:4 Not tainted 5.1.0_pt_pmem #38
[   32.056923] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-20181126_142135-anatol 04/01/2014
[   32.057720] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[   32.058144] Call Trace:
[   32.058344]  dump_stack+0x67/0x90
[   32.058604]  print_circular_bug.cold.60+0x15c/0x195
[   32.058989]  __lock_acquire+0x17de/0x1d30
[   32.059308]  ? find_held_lock+0x2d/0x90
[   32.059611]  ? __kernfs_remove+0x199/0x2d0
[   32.059937]  lock_acquire+0xaa/0x180
[   32.060223]  ? kernfs_remove_by_name_ns+0x3b/0x80
[   32.060596]  __kernfs_remove+0x244/0x2d0
[   32.060908]  ? kernfs_remove_by_name_ns+0x3b/0x80
[   32.061283]  ? kernfs_name_hash+0xd/0x80
[   32.061596]  ? kernfs_find_ns+0x68/0xf0
[   32.061907]  kernfs_remove_by_name_ns+0x3b/0x80
[   32.062266]  device_del+0x14a/0x370
[   32.062548]  ? unregister_mem_sect_under_nodes+0x4f/0xc0
[   32.062973]  device_unregister+0x9/0x20
[   32.063285]  unregister_memory_section+0x69/0xa0
[   32.063651]  __remove_pages+0x112/0x460
[   32.063949]  arch_remove_memory+0x6f/0xa0
[   32.064271]  __remove_memory+0xab/0x130
[   32.064579]  ? walk_memory_range+0xa1/0xe0
[   32.064907]  acpi_memory_device_remove+0x67/0xe0
[   32.065274]  acpi_bus_trim+0x50/0x90
[   32.065560]  acpi_device_hotplug+0x2fa/0x3e0
[   32.065900]  acpi_hotplug_work_fn+0x15/0x20
[   32.066249]  process_one_work+0x2a0/0x650
[   32.066591]  worker_thread+0x34/0x3d0
[   32.066925]  ? process_one_work+0x650/0x650
[   32.067275]  kthread+0x118/0x130
[   32.067542]  ? kthread_create_on_node+0x60/0x60
[   32.067909]  ret_from_fork+0x3a/0x50

>
> I wonder if that ordering prevents going too deep into the
> device_unregister() call stack that you highlighted below.
>
>
> >
> > Here is the problem:
> >
> > When we offline pages we have the following call stack:
> >
> > # echo offline > /sys/devices/system/memory/memory8/state
> > ksys_write
> >  vfs_write
> >   __vfs_write
> >    kernfs_fop_write
> >     kernfs_get_active
> >      lock_acquire                       kn->count#122 (lock for
> > "memory8/state" kn)
> >     sysfs_kf_write
> >      dev_attr_store
> >       state_store
> >        device_offline
> >         memory_subsys_offline
> >          memory_block_action
> >           offline_pages
> >            __offline_pages
> >             percpu_down_write
> >              down_write
> >               lock_acquire              mem_hotplug_lock.rw_sem
> >
> > When we unbind dax0.0 we have the following  stack:
> > # echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
> > drv_attr_store
> >  unbind_store
> >   device_driver_detach
> >    device_release_driver_internal
> >     dev_dax_kmem_remove
> >      remove_memory                      device_hotplug_lock
> >       try_remove_memory                 mem_hotplug_lock.rw_sem
> >        arch_remove_memory
> >         __remove_pages
> >          __remove_section
> >           unregister_memory_section
> >            remove_memory_section        mem_sysfs_mutex
> >             unregister_memory
> >              device_unregister
> >               device_del
> >                device_remove_attrs
> >                 sysfs_remove_groups
> >                  sysfs_remove_group
> >                   remove_files
> >                    kernfs_remove_by_name
> >                     kernfs_remove_by_name_ns
> >                      __kernfs_remove    kn->count#122
> >
> > So, lockdep found the ordering issue with the above two stacks:
> >
> > 1. kn->count#122 -> mem_hotplug_lock.rw_sem
> > 2. mem_hotplug_lock.rw_sem -> kn->count#122
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
