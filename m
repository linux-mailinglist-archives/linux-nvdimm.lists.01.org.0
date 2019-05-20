Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3758B22D7B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 May 2019 09:58:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3BFA221260A78;
	Mon, 20 May 2019 00:58:49 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=david@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 718462125ADC7
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 00:58:46 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 58678308FC4D;
 Mon, 20 May 2019 07:58:45 +0000 (UTC)
Received: from [10.36.117.43] (ovpn-117-43.ams2.redhat.com [10.36.117.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 149B21001DC7;
 Mon, 20 May 2019 07:57:40 +0000 (UTC)
Subject: Re: [v5 0/3] "Hotremove" persistent memory
To: Pavel Tatashin <pasha.tatashin@soleen.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
 <76dfe7943f2a0ceaca73f5fd23e944dfdc0309d1.camel@intel.com>
 <CA+CK2bCKcJjXo7BGAVxvbQNYQFSDVLH5aB=S9yTmZWEfexOvtg@mail.gmail.com>
 <CAPcyv4jj557QNNwyQ7ez+=PnURsnXk9cGZ11Mmihmtem2bJ-3A@mail.gmail.com>
 <CA+CK2bBLAD58Q545r6W9eSwKJ3-BgzUF5oLAn6wHUcDi=jBpdw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <918bb4d5-1830-a283-1d38-70fc2f3bafb1@redhat.com>
Date: Mon, 20 May 2019 09:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBLAD58Q545r6W9eSwKJ3-BgzUF5oLAn6wHUcDi=jBpdw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 20 May 2019 07:58:46 +0000 (UTC)
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
 "mhocko@suse.com" <mhocko@suse.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
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
 "bp@suse.de" <bp@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 17.05.19 16:09, Pavel Tatashin wrote:
>>
>> I would think that ACPI hotplug would have a similar problem, but it does this:
>>
>>                 acpi_unbind_memory_blocks(info);
>>                 __remove_memory(nid, info->start_addr, info->length);
> 
> ACPI does have exactly the same problem, so this is not a bug for this
> series, I will submit a new version of my series with comments
> addressed, but without fix for this issue.
> 
> I was able to reproduce this issue on the current mainline kernel.
> Also, I been thinking more about how to fix it, and there is no easy
> fix without a major hotplug redesign. Basically, we have to remove
> sysfs memory entries before or after memory is hotplugged/hotremoved.
> But, we also have to guarantee that hotplug/hotremove will succeed or
> reinstate sysfs entries.
> 
> Qemu script:
> 
> qemu-system-x86_64                                                      \
>         -enable-kvm                                                     \
>         -cpu host                                                       \
>         -parallel none                                                  \
>         -echr 1                                                         \
>         -serial none                                                    \
>         -chardev stdio,id=console,signal=off,mux=on                     \
>         -serial chardev:console                                         \
>         -mon chardev=console                                            \
>         -vga none                                                       \
>         -display none                                                   \
>         -kernel pmem/native/arch/x86/boot/bzImage                       \
>         -m 8G,slots=1,maxmem=16G                                        \
>         -smp 8                                                          \
>         -fsdev local,id=virtfs1,path=/,security_model=none              \
>         -device virtio-9p-pci,fsdev=virtfs1,mount_tag=hostfs            \
>         -append 'earlyprintk=serial,ttyS0,115200 console=ttyS0
> TERM=xterm ip=dhcp loglevel=7'
> 
> Config is attached.
> 
> Steps to reproduce:
> #
> # QEMU 4.0.0 monitor - type 'help' for more information
> (qemu) object_add memory-backend-ram,id=mem1,size=1G
> (qemu) device_add pc-dimm,id=dimm1,memdev=mem1
> (qemu)
> 
> # echo online_movable > /sys/devices/system/memory/memory79/state
> [   23.029552] Built 1 zonelists, mobility grouping on.  Total pages: 2045370
> [   23.032591] Policy zone: Normal
> # (qemu) device_del dimm1
> (qemu) [   32.013950] Offlined Pages 32768
> [   32.014307] Built 1 zonelists, mobility grouping on.  Total pages: 2031022
> [   32.014843] Policy zone: Normal
> [   32.015733]
> [   32.015881] ======================================================
> [   32.016390] WARNING: possible circular locking dependency detected
> [   32.016881] 5.1.0_pt_pmem #38 Not tainted
> [   32.017202] ------------------------------------------------------
> [   32.017680] kworker/u16:4/380 is trying to acquire lock:
> [   32.018096] 00000000675cc7e1 (kn->count#18){++++}, at:
> kernfs_remove_by_name_ns+0x3b/0x80
> [   32.018745]
> [   32.018745] but task is already holding lock:
> [   32.019201] 0000000053e50a99 (mem_sysfs_mutex){+.+.}, at:
> unregister_memory_section+0x1d/0xa0
> [   32.019859]
> [   32.019859] which lock already depends on the new lock.
> [   32.019859]
> [   32.020499]
> [   32.020499] the existing dependency chain (in reverse order) is:
> [   32.021080]
> [   32.021080] -> #4 (mem_sysfs_mutex){+.+.}:
> [   32.021522]        __mutex_lock+0x8b/0x900
> [   32.021843]        hotplug_memory_register+0x26/0xa0
> [   32.022231]        __add_pages+0xe7/0x160
> [   32.022545]        add_pages+0xd/0x60
> [   32.022835]        add_memory_resource+0xc3/0x1d0
> [   32.023207]        __add_memory+0x57/0x80
> [   32.023530]        acpi_memory_device_add+0x13a/0x2d0
> [   32.023928]        acpi_bus_attach+0xf1/0x200
> [   32.024272]        acpi_bus_scan+0x3e/0x90
> [   32.024597]        acpi_device_hotplug+0x284/0x3e0
> [   32.024972]        acpi_hotplug_work_fn+0x15/0x20
> [   32.025342]        process_one_work+0x2a0/0x650
> [   32.025755]        worker_thread+0x34/0x3d0
> [   32.026077]        kthread+0x118/0x130
> [   32.026442]        ret_from_fork+0x3a/0x50
> [   32.026766]
> [   32.026766] -> #3 (mem_hotplug_lock.rw_sem){++++}:
> [   32.027261]        get_online_mems+0x39/0x80
> [   32.027600]        kmem_cache_create_usercopy+0x29/0x2c0
> [   32.028019]        kmem_cache_create+0xd/0x10
> [   32.028367]        ptlock_cache_init+0x1b/0x23
> [   32.028724]        start_kernel+0x1d2/0x4b8
> [   32.029060]        secondary_startup_64+0xa4/0xb0
> [   32.029447]
> [   32.029447] -> #2 (cpu_hotplug_lock.rw_sem){++++}:
> [   32.030007]        cpus_read_lock+0x39/0x80
> [   32.030360]        __offline_pages+0x32/0x790
> [   32.030709]        memory_subsys_offline+0x3a/0x60
> [   32.031089]        device_offline+0x7e/0xb0
> [   32.031425]        acpi_bus_offline+0xd8/0x140
> [   32.031821]        acpi_device_hotplug+0x1b2/0x3e0
> [   32.032202]        acpi_hotplug_work_fn+0x15/0x20
> [   32.032576]        process_one_work+0x2a0/0x650
> [   32.032942]        worker_thread+0x34/0x3d0
> [   32.033283]        kthread+0x118/0x130
> [   32.033588]        ret_from_fork+0x3a/0x50
> [   32.033919]
> [   32.033919] -> #1 (&device->physical_node_lock){+.+.}:
> [   32.034450]        __mutex_lock+0x8b/0x900
> [   32.034784]        acpi_get_first_physical_node+0x16/0x60
> [   32.035217]        acpi_companion_match+0x3b/0x60
> [   32.035594]        acpi_device_uevent_modalias+0x9/0x20
> [   32.036012]        platform_uevent+0xd/0x40
> [   32.036352]        dev_uevent+0x85/0x1c0
> [   32.036674]        kobject_uevent_env+0x1e2/0x640
> [   32.037044]        kobject_synth_uevent+0x2b7/0x324
> [   32.037428]        uevent_store+0x17/0x30
> [   32.037752]        kernfs_fop_write+0xeb/0x1a0
> [   32.038112]        vfs_write+0xb2/0x1b0
> [   32.038417]        ksys_write+0x57/0xd0
> [   32.038721]        do_syscall_64+0x4b/0x1a0
> [   32.039053]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   32.039491]
> [   32.039491] -> #0 (kn->count#18){++++}:
> [   32.039913]        lock_acquire+0xaa/0x180
> [   32.040242]        __kernfs_remove+0x244/0x2d0
> [   32.040593]        kernfs_remove_by_name_ns+0x3b/0x80
> [   32.040991]        device_del+0x14a/0x370
> [   32.041309]        device_unregister+0x9/0x20
> [   32.041653]        unregister_memory_section+0x69/0xa0
> [   32.042059]        __remove_pages+0x112/0x460
> [   32.042402]        arch_remove_memory+0x6f/0xa0
> [   32.042758]        __remove_memory+0xab/0x130
> [   32.043103]        acpi_memory_device_remove+0x67/0xe0
> [   32.043537]        acpi_bus_trim+0x50/0x90
> [   32.043889]        acpi_device_hotplug+0x2fa/0x3e0
> [   32.044300]        acpi_hotplug_work_fn+0x15/0x20
> [   32.044686]        process_one_work+0x2a0/0x650
> [   32.045044]        worker_thread+0x34/0x3d0
> [   32.045381]        kthread+0x118/0x130
> [   32.045679]        ret_from_fork+0x3a/0x50
> [   32.046005]
> [   32.046005] other info that might help us debug this:
> [   32.046005]
> [   32.046636] Chain exists of:
> [   32.046636]   kn->count#18 --> mem_hotplug_lock.rw_sem --> mem_sysfs_mutex
> [   32.046636]
> [   32.047514]  Possible unsafe locking scenario:
> [   32.047514]
> [   32.047976]        CPU0                    CPU1
> [   32.048337]        ----                    ----
> [   32.048697]   lock(mem_sysfs_mutex);
> [   32.048983]                                lock(mem_hotplug_lock.rw_sem);
> [   32.049519]                                lock(mem_sysfs_mutex);
> [   32.050004]   lock(kn->count#18);
> [   32.050270]
> [   32.050270]  *** DEADLOCK ***
> [   32.050270]
> [   32.050736] 7 locks held by kworker/u16:4/380:
> [   32.051087]  #0: 00000000a22fe78e
> ((wq_completion)kacpi_hotplug){+.+.}, at: process_one_work+0x21e/0x650
> [   32.051830]  #1: 00000000944f2dca
> ((work_completion)(&hpw->work)){+.+.}, at:
> process_one_work+0x21e/0x650
> [   32.052577]  #2: 0000000024bbe147 (device_hotplug_lock){+.+.}, at:
> acpi_device_hotplug+0x2e/0x3e0
> [   32.053271]  #3: 000000005cb50027 (acpi_scan_lock){+.+.}, at:
> acpi_device_hotplug+0x3c/0x3e0
> [   32.053916]  #4: 00000000b8d06992 (cpu_hotplug_lock.rw_sem){++++},
> at: __remove_memory+0x3b/0x130
> [   32.054602]  #5: 00000000897f0ef4 (mem_hotplug_lock.rw_sem){++++},
> at: percpu_down_write+0x1d/0x110
> [   32.055315]  #6: 0000000053e50a99 (mem_sysfs_mutex){+.+.}, at:
> unregister_memory_section+0x1d/0xa0
> [   32.056016]
> [   32.056016] stack backtrace:
> [   32.056355] CPU: 4 PID: 380 Comm: kworker/u16:4 Not tainted 5.1.0_pt_pmem #38
> [   32.056923] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.12.0-20181126_142135-anatol 04/01/2014
> [   32.057720] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> [   32.058144] Call Trace:
> [   32.058344]  dump_stack+0x67/0x90
> [   32.058604]  print_circular_bug.cold.60+0x15c/0x195
> [   32.058989]  __lock_acquire+0x17de/0x1d30
> [   32.059308]  ? find_held_lock+0x2d/0x90
> [   32.059611]  ? __kernfs_remove+0x199/0x2d0
> [   32.059937]  lock_acquire+0xaa/0x180
> [   32.060223]  ? kernfs_remove_by_name_ns+0x3b/0x80
> [   32.060596]  __kernfs_remove+0x244/0x2d0
> [   32.060908]  ? kernfs_remove_by_name_ns+0x3b/0x80
> [   32.061283]  ? kernfs_name_hash+0xd/0x80
> [   32.061596]  ? kernfs_find_ns+0x68/0xf0
> [   32.061907]  kernfs_remove_by_name_ns+0x3b/0x80
> [   32.062266]  device_del+0x14a/0x370
> [   32.062548]  ? unregister_mem_sect_under_nodes+0x4f/0xc0
> [   32.062973]  device_unregister+0x9/0x20
> [   32.063285]  unregister_memory_section+0x69/0xa0
> [   32.063651]  __remove_pages+0x112/0x460
> [   32.063949]  arch_remove_memory+0x6f/0xa0
> [   32.064271]  __remove_memory+0xab/0x130
> [   32.064579]  ? walk_memory_range+0xa1/0xe0
> [   32.064907]  acpi_memory_device_remove+0x67/0xe0
> [   32.065274]  acpi_bus_trim+0x50/0x90
> [   32.065560]  acpi_device_hotplug+0x2fa/0x3e0
> [   32.065900]  acpi_hotplug_work_fn+0x15/0x20
> [   32.066249]  process_one_work+0x2a0/0x650
> [   32.066591]  worker_thread+0x34/0x3d0
> [   32.066925]  ? process_one_work+0x650/0x650
> [   32.067275]  kthread+0x118/0x130
> [   32.067542]  ? kthread_create_on_node+0x60/0x60
> [   32.067909]  ret_from_fork+0x3a/0x50
> 
>>
>> I wonder if that ordering prevents going too deep into the
>> device_unregister() call stack that you highlighted below.
>>
>>
>>>
>>> Here is the problem:
>>>
>>> When we offline pages we have the following call stack:
>>>
>>> # echo offline > /sys/devices/system/memory/memory8/state
>>> ksys_write
>>>  vfs_write
>>>   __vfs_write
>>>    kernfs_fop_write
>>>     kernfs_get_active
>>>      lock_acquire                       kn->count#122 (lock for
>>> "memory8/state" kn)
>>>     sysfs_kf_write
>>>      dev_attr_store
>>>       state_store
>>>        device_offline
>>>         memory_subsys_offline
>>>          memory_block_action
>>>           offline_pages
>>>            __offline_pages
>>>             percpu_down_write
>>>              down_write
>>>               lock_acquire              mem_hotplug_lock.rw_sem
>>>
>>> When we unbind dax0.0 we have the following  stack:
>>> # echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
>>> drv_attr_store
>>>  unbind_store
>>>   device_driver_detach
>>>    device_release_driver_internal
>>>     dev_dax_kmem_remove
>>>      remove_memory                      device_hotplug_lock
>>>       try_remove_memory                 mem_hotplug_lock.rw_sem
>>>        arch_remove_memory
>>>         __remove_pages
>>>          __remove_section
>>>           unregister_memory_section
>>>            remove_memory_section        mem_sysfs_mutex
>>>             unregister_memory
>>>              device_unregister
>>>               device_del
>>>                device_remove_attrs
>>>                 sysfs_remove_groups
>>>                  sysfs_remove_group
>>>                   remove_files
>>>                    kernfs_remove_by_name
>>>                     kernfs_remove_by_name_ns
>>>                      __kernfs_remove    kn->count#122
>>>
>>> So, lockdep found the ordering issue with the above two stacks:
>>>
>>> 1. kn->count#122 -> mem_hotplug_lock.rw_sem
>>> 2. mem_hotplug_lock.rw_sem -> kn->count#122

I once documented locking behavior in

Documentation/core-api/memory-hotplug.rst

Both, device_online() and __remove_memory() always have to be called
holding the device_hotplug_lock(), to avoid such races.

# echo offline > /sys/devices/system/memory/memory8/state
and
# echo 0 > /sys/devices/system/memory/memory8/online

either end up in:

-> online_store()
-- lock_device_hotplug_sysfs();
-- device_offline(dev)

-> state_store()
-- lock_device_hotplug_sysfs();
--  device_online(&mem->dev);

So the device_hotplug_lock prohibits the race you describe.

BUT

There is a possible race between the device_hotplug_lock and the
kn->count#122. However, that race can never trigger, as userspace
properly backs off in case it cannot get grip of the device_hotplug_lock.

(lock_device_hotplug_sysfs does a mutex_trylock(&device_hotplug_lock))

-- 

Thanks,

David / dhildenb
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
