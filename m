Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EB6219B6
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 16:20:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DC3B62127545E;
	Fri, 17 May 2019 07:20:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7D3A22127420D
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 07:20:52 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w37so10848441edw.4
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=VP/eUKUuR8TLoMvlYCX2nSbX4hUIzlmOciIWsva7XC4=;
 b=YTEoLGpt3gJPpHqgPs16i1Ei3RCbZf4C8pAQyiN4tBjMhme88ezguBEaoeZnfo5FWR
 sQwLdt1Is+kzXygN84M39ZWlLh47iKBEIRClO7oef6hlgFzdEfao5LU0LnhhLgHiokz8
 2z5676sE0ghFYREKmrC340/1CSoXSlYdvtdXGqyxqh9/efcGlFFeRPv4kC9KfzAJKMYT
 +WcKD+khWbY89mkXhA7FL0j12Xs03yYBWqpZaYfd26mfew7QLpZajHBw5Umzoi7vcLyJ
 FlyOWtWrbEVxDoSb5RXGF+k1mA/dw2mg+2H0n7uJgkcvTCZWXifP5o0S4YIKBeYaKL4Y
 4m6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=VP/eUKUuR8TLoMvlYCX2nSbX4hUIzlmOciIWsva7XC4=;
 b=ISof89lqfMAkSsvBBFOBdP3XqEGUYXsNaGlnBbhIzoBH8oE4eYNmZQvL68xRrW35LC
 +Zbw3NVOb1jaXm9TzqmJ5NdiJJEyYui5bXZJHRvYNGEkqgq+G5Uez8JEubRbJaS1ZgP0
 Flk5UwaRPaya7KRNkhcGLDB0UfnsjZfklQsb4bsXyXtFKwPstI8wl/sKML8mniLg2qAX
 UIGdKZo6e5Ik+mOPcHMt0Un3FkjAlZQ2VUSZJMUN5TqpbDgjq6fP0SYkr9dNLg/0UBI9
 pDXalcY9rf1AeBaBmUQ5HovXCKAlMK7GBJv76xjJ8WFDXTDWrbvVicHA8iBNkjIgJehd
 YfnA==
X-Gm-Message-State: APjAAAUEbXgyNRo19BOJIOwacobSuzTJLCqUiPXSw5guCOiEVwfIc9v8
 +PAJyf8paIwmecABKWnhBEa+thzR4QqaCw3tSi8Kqg==
X-Google-Smtp-Source: APXvYqyBFCC2pD/8hnX5yHyYTnSwQ9dcl5Qi9Cn99mPL58e9GnCtNGgU1KalPEEF0oyxGvvSM0Jwxiz23Sgycf843Tw=
X-Received: by 2002:a50:ce5b:: with SMTP id k27mr5654685edj.48.1558102850640; 
 Fri, 17 May 2019 07:20:50 -0700 (PDT)
MIME-Version: 1.0
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 17 May 2019 10:20:38 -0400
Message-ID: <CA+CK2bBeOJPnnyWBgj0CJ7E1z9GVWVg_EJAmDs07BSJDp3PYfQ@mail.gmail.com>
Subject: NULL pointer dereference during memory hotremove
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jmorris@namei.org" <jmorris@namei.org>, 
 "tiwai@suse.de" <tiwai@suse.de>, "sashal@kernel.org" <sashal@kernel.org>, 
 "linux-mm@kvack.org" <linux-mm@kvack.org>, 
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "david@redhat.com" <david@redhat.com>, "bp@suse.de" <bp@suse.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "jglisse@redhat.com" <jglisse@redhat.com>, 
 "zwisler@kernel.org" <zwisler@kernel.org>, "mhocko@suse.com" <mhocko@suse.com>,
 "Jiang, Dave" <dave.jiang@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, 
 "Busch, Keith" <keith.busch@intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
 "Huang, Ying" <ying.huang@intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>,
 "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

This panic is unrelated to circular lock issue that I reported in a
separate thread, that also happens during memory hotremove.

xakep ~/x/linux$ git describe
v5.1-12317-ga6a4b66bd8f4

Config is attached, qemu script is following:

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
TERM=xterm ip=dhcp memmap=2G!6G loglevel=7'

The unusual case with this script is that 2G reserved for pmem device:
memmap=2G!6G. Otherwise, it is a normal layout. Unfortunately, it does
not happen every time, but I have hit it a couple times.


# QEMU 4.0.0 monitor - type 'help' for more information
(qemu) object_add memory-backend-ram,id=mem1,size=1G
(qemu) device_add pc-dimm,id=dimm1,memdev=mem1
# echo online_movable > /sys/devices/system/memory/memory79/state
[   40.219090] Built 1 zonelists, mobility grouping on.  Total pages: 1529279
[   40.223258] Policy zone: Normal
# (qemu) device_del dimm1
(qemu) [   49.624600] Offlined Pages 32768
[   49.625796] Built 1 zonelists, mobility grouping on.  Total pages: 1516352
[   49.627841] Policy zone: Normal
[   49.630932] BUG: kernel NULL pointer dereference, address: 0000000000000698
[   49.633704] #PF: supervisor read access in kernel mode
[   49.635689] #PF: error_code(0x0000) - not-present page
[   49.637620] PGD 8000000236b59067 P4D 8000000236b59067 PUD 2358fe067 PMD 0
[   49.640163] Oops: 0000 [#1] SMP PTI
[   49.641223] CPU: 0 PID: 7 Comm: kworker/u16:0 Not tainted 5.1.0_pt_pmem #38
[   49.643183] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-20181126_142135-anatol 04/01/2014
[   49.645858] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[   49.647101] RIP: 0010:__remove_pages+0x1a/0x460
[   49.648165] Code: e9 bb a9 fd ff 0f 0b 66 0f 1f 84 00 00 00 00 00
41 57 48 89 f8 49 89 ff 41 56 49 89 f6 41 55 41 54 55 53 48 89 d3 48
83 ec 50 <48> 2b 47 58 48 89 4c 24 48 48 3d 00 19 00 00 75 09 48 85 c9
0f 85
[   49.651925] RSP: 0018:ffffbd1000c8fcb8 EFLAGS: 00010286
[   49.652857] RAX: 0000000000000640 RBX: 0000000000040000 RCX: 0000000000000000
[   49.654139] RDX: 0000000000040000 RSI: 0000000000240000 RDI: 0000000000000640
[   49.655393] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000040000000
[   49.656523] R10: 0000000040000000 R11: 0000000240000000 R12: 0000000040000000
[   49.657654] R13: 0000000240000000 R14: 0000000000240000 R15: 0000000000000640
[   49.658828] FS:  0000000000000000(0000) GS:ffff9b4bf9800000(0000)
knlGS:0000000000000000
[   49.660178] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.661033] CR2: 0000000000000698 CR3: 00000002382e0006 CR4: 0000000000360ef0
[   49.662114] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   49.663172] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   49.664243] Call Trace:
[   49.664622]  ? memblock_isolate_range+0xc4/0x139
[   49.665290]  ? firmware_map_add_hotplug+0x7e/0xde
[   49.665908]  ? memblock_remove_region+0x30/0x74
[   49.666498]  arch_remove_memory+0x6f/0xa0
[   49.667012]  __remove_memory+0xab/0x130
[   49.667492]  ? walk_memory_range+0xa1/0xe0
[   49.668008]  acpi_memory_device_remove+0x67/0xe0
[   49.668595]  acpi_bus_trim+0x50/0x90
[   49.669051]  acpi_device_hotplug+0x2fa/0x3e0
[   49.669590]  acpi_hotplug_work_fn+0x15/0x20
[   49.670116]  process_one_work+0x2a0/0x650
[   49.670577]  worker_thread+0x34/0x3d0
[   49.670997]  ? process_one_work+0x650/0x650
[   49.671503]  kthread+0x118/0x130
[   49.671879]  ? kthread_create_on_node+0x60/0x60
[   49.672411]  ret_from_fork+0x3a/0x50
[   49.672836] Modules linked in:
[   49.673190] CR2: 0000000000000698
[   49.673583] ---[ end trace 6b727d3a8ce48aa1 ]---
[   49.674120] RIP: 0010:__remove_pages+0x1a/0x460
[   49.674624] Code: e9 bb a9 fd ff 0f 0b 66 0f 1f 84 00 00 00 00 00
41 57 48 89 f8 49 89 ff 41 56 49 89 f6 41 55 41 54 55 53 48 89 d3 48
83 ec 50 <48> 2b 47 58 48 89 4c 24 48 48 3d 00 19 00 00 75 09 48 85 c9
0f 85
[   49.676600] RSP: 0018:ffffbd1000c8fcb8 EFLAGS: 00010286
[   49.677159] RAX: 0000000000000640 RBX: 0000000000040000 RCX: 0000000000000000
[   49.677960] RDX: 0000000000040000 RSI: 0000000000240000 RDI: 0000000000000640
[   49.678813] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000040000000
[   49.679633] R10: 0000000040000000 R11: 0000000240000000 R12: 0000000040000000
[   49.680455] R13: 0000000240000000 R14: 0000000000240000 R15: 0000000000000640
[   49.681243] FS:  0000000000000000(0000) GS:ffff9b4bf9800000(0000)
knlGS:0000000000000000
[   49.682168] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.682813] CR2: 0000000000000698 CR3: 00000002382e0006 CR4: 0000000000360ef0
[   49.683573] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   49.684239] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   49.684901] BUG: sleeping function called from invalid context at
include/linux/percpu-rwsem.h:34
[   49.685690] in_atomic(): 0, irqs_disabled(): 1, pid: 7, name: kworker/u16:0
[   49.686314] INFO: lockdep is turned off.
[   49.686684] irq event stamp: 22546
[   49.687003] hardirqs last  enabled at (22545): [<ffffffff8c1fe5ba>]
kfree+0xba/0x230
[   49.687692] hardirqs last disabled at (22546): [<ffffffff8c001b53>]
trace_hardirqs_off_thunk+0x1a/0x1c
[   49.688561] softirqs last  enabled at (22526): [<ffffffff8ce0033e>]
__do_softirq+0x33e/0x455
[   49.689348] softirqs last disabled at (22519): [<ffffffff8c06ea36>]
irq_exit+0xb6/0xc0
[   49.690088] CPU: 0 PID: 7 Comm: kworker/u16:0 Tainted: G      D
      5.1.0_pt_pmem #38
[   49.690811] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-20181126_142135-anatol 04/01/2014
[   49.691704] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[   49.692185] Call Trace:
[   49.692398]  dump_stack+0x67/0x90
[   49.692690]  ___might_sleep.cold.87+0x9f/0xaf
[   49.693099]  exit_signals+0x2b/0x240
[   49.693453]  do_exit+0xab/0xc10
[   49.693770]  ? process_one_work+0x650/0x650
[   49.694160]  ? kthread+0x118/0x130
[   49.694487]  rewind_stack_do_exit+0x17/0x20
[   77.418619] random: fast init done
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
