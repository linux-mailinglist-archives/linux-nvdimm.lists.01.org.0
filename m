Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A41CFCCA
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 May 2020 20:05:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF94E11AB2D47;
	Tue, 12 May 2020 11:03:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CFDAB11AB2D47
	for <linux-nvdimm@lists.01.org>; Tue, 12 May 2020 11:03:20 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h15so9591517edv.2
        for <linux-nvdimm@lists.01.org>; Tue, 12 May 2020 11:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ms+okw9kISTy8DxIfTUPcDhLDVdj6HKJmn7lPs1OmaM=;
        b=ANCJuXtIhopMe6qzWtsRo4zE5GwXPL2Fk27jlFtblD32o31TKkPi9JrM5YQ1FRbGGw
         eUtReQNx7ZPWVJCKKQmQY2x0qhNdY7aYRrWAsjuzQxh6CiTwxUZpPj5a46bbJ+YN/W6S
         EaFhcHxM9nKISssN9RIwNV899HAGlfqKPJnoTNYq1Fb80oz7XTtEdYi3fleThbrxE0xy
         0CahD8l36d+6vvBQqimotY6M7DQ+oVXdXc5mac54/80ZYTFUquUawLnxcvp9/mt/a/+t
         qK8SvbNUN+9noprcr64PsqZd+VNSIInGJ/r4pfEjT6HYDFdQ2N8EYMx69342UTZ7tuS2
         JWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ms+okw9kISTy8DxIfTUPcDhLDVdj6HKJmn7lPs1OmaM=;
        b=C/0rOCpOqg/EAu87YvbV+9yZoY/CAoLc7tbW5WnQj11rD6eeb5sjS4+RLCyUea8Uhe
         PahZ7zR5qynuQGaF0q8Dn1LiZRJp6b9Bb4E6n2CLCk3YH5nl3KZJ+l4FM0H8Mp5kstPr
         RBpIAi2F8eDcyhGuEdJQd9645KFrEHyPU2pWoX4SzmjMJiUFcdu0gMDDvoL0AND/DnUD
         +ZZ1nTfMitns2LZXG4o0IvzGVDLX2RrozjZ6HH4j26qG7SB6yUB5OHKdqOd2LXnsnMLy
         qX8qOZCJsLnu1I3Pfw7ruO1GqENmJUFsXaJ1rfA4MxWBD87su5pIXhOPYoa4eD1W4BoA
         OG1g==
X-Gm-Message-State: AGi0PuZFWr9TZggPVsZWC8lPj2QD1ZSZS9VOZsPcdzCSO8pXFT3OHXaD
	s05kLRxk+uUyimIm0Txf3JXRTvWteYogpZn6p5yI3g==
X-Google-Smtp-Source: APiQypJvskxmjKTDhmdLSx2Yht+zHg5JvLy1YSbPTEhuJJQB3XuwpQtA+29OJIhchXZ77/rOOIYdHdsZrcyGLApzwck=
X-Received: by 2002:a50:bb6b:: with SMTP id y98mr18400434ede.296.1589306750124;
 Tue, 12 May 2020 11:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200511090034.GX5770@shao2-debian> <440dae1b-9146-0bc3-e8f2-bd3cb3aa89bb@intel.com>
In-Reply-To: <440dae1b-9146-0bc3-e8f2-bd3cb3aa89bb@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 12 May 2020 11:05:38 -0700
Message-ID: <CAPcyv4jKZp2bOZZ+ZMrcbFw9fPzeDu8waqwG6mBVpWwGq2DGtw@mail.gmail.com>
Subject: Re: [ACPI] b13663bdf9: BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID-Hash: L6GZXJCOLVRVP3BERLOPTLYEHNHZPUZ5
X-Message-ID-Hash: L6GZXJCOLVRVP3BERLOPTLYEHNHZPUZ5
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: kernel test robot <rong.a.chen@intel.com>, stable <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Erik Kaneda <erik.kaneda@intel.com>, Myron Stowe <myron.stowe@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, lkp@lists.01.org, Linux ACPI <linux-acpi@vger.kernel.org>, "Huang, Ying" <ying.huang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L6GZXJCOLVRVP3BERLOPTLYEHNHZPUZ5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 12, 2020 at 9:28 AM Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
>
> On 5/11/2020 11:00 AM, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-7):
> >
> > commit: b13663bdf9701c8896bebcc7ee998f8656c1ea37 ("[PATCH] ACPI: Drop rcu usage for MMIO mappings")
> > url: https://github.com/0day-ci/linux/commits/Dan-Williams/ACPI-Drop-rcu-usage-for-MMIO-mappings/20200507-075930
> > base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
> >
> > in testcase: v4l2
> > with following parameters:
> >
> >       test: device
> >       ucode: 0x43
> >
> >
> >
> > on test machine: 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz with 256G memory
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
>
> Dan,
>
> Has this been addressed in the v2?

No, this looks like a case I was concerned about, i.e. the GHES code
is not being completely careful to avoid calling potentially sleeping
functions with interrupts disabled. There is the nice comment that
indicates that the fixmap should be used when ghes_notify_lock_irq()
is held, but there seems to be no infrastructure to use / divert to
the fixmap in the ghes_proc() path. That needs to be reworked first.
It seems the implementation was getting lucky before to hit the cached
acpi_ioremap in this path under rcu_read_lock(), but it appears it
should have always been using the fixmap. Ying, James, is my read
correct?

/*
 * Because the memory area used to transfer hardware error information
 * from BIOS to Linux can be determined only in NMI, IRQ or timer
 * handler, but general ioremap can not be used in atomic context, so
 * the fixmap is used instead.
 *
 * This spinlock is used to prevent the fixmap entry from being used
 * simultaneously.
 */
static DEFINE_SPINLOCK(ghes_notify_lock_irq);


> > [   21.012858] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:281
> > [   21.013816] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
> > [   21.029953] tsc: Refined TSC clocksource calibration: 2294.686 MHz
> > [   21.013816] CPU: 55 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc3-00025-gb13663bdf9701c #1
> > [   21.013816] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS SE5C610.86B.01.01.0008.021120151325 02/11/2015
> > [   21.013816] Call Trace:
> > [   21.042037] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x211399552f8, max_idle_ns: 440795292447 ns
> > [   21.013816]  dump_stack+0x66/0x8b
> > [   21.064421]  ___might_sleep+0x102/0x120
> > [   21.064421]  mutex_lock+0x1c/0x40
> > [   21.064421]  acpi_os_rw_map+0x37/0xe0
> > [   21.064421]  acpi_os_read_memory+0x34/0xc0
> > [   21.064421]  ? acpi_match_platform_list+0x84/0x100
> > [   21.064421]  apei_read+0x97/0xb0
> > [   21.064421]  __ghes_peek_estatus+0x27/0xc0
> > [   21.064421]  ghes_proc+0x37/0x120
> > [   21.064421]  ghes_probe+0x1d0/0x460
> > [   21.064421]  platform_drv_probe+0x37/0x90
> > [   21.064421]  really_probe+0xef/0x430
> > [   21.064421]  driver_probe_device+0x110/0x120
> > [   21.064421]  device_driver_attach+0x4f/0x60
> > [   21.064421]  __driver_attach+0x9a/0x140
> > [   21.064421]  ? device_driver_attach+0x60/0x60
> > [   21.064421]  bus_for_each_dev+0x76/0xc0
> > [   21.064421]  ? klist_add_tail+0x3b/0x70
> > [   21.064421]  bus_add_driver+0x144/0x220
> > [   21.064421]  ? bert_init+0x229/0x229
> > [   21.064421]  driver_register+0x5b/0xf0
> > [   21.064421]  ? bert_init+0x229/0x229
> > [   21.064421]  ghes_init+0x83/0xde
> > [   21.064421]  do_one_initcall+0x46/0x220
> > [   21.064421]  kernel_init_freeable+0x206/0x280
> > [   21.064421]  ? rest_init+0xd0/0xd0
> > [   21.064421]  kernel_init+0xa/0x110
> > [   21.064421]  ret_from_fork+0x35/0x40
> > [   21.211518] clocksource: Switched to clocksource tsc
> > [   21.212408] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
> > [   21.227478] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> > [   21.235019] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> > [   21.244105] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> > [   21.254257] Non-volatile memory driver v1.3
> > [   21.259421] Linux agpgart interface v0.103
> > [   21.272262] rdac: device handler registered
> > [   21.277466] hp_sw: device handler registered
> > [   21.282671] emc: device handler registered
> > [   21.288039] alua: device handler registered
> > [   21.293154] MACsec IEEE 802.1AE
> > [   21.297325] libphy: Fixed MDIO Bus: probed
> > [   21.302666] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> > [   21.310980] e1000: Copyright (c) 1999-2006 Intel Corporation.
> > [   21.317926] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> > [   21.324883] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> > [   21.332069] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.0-k
> > [   21.340297] igb: Copyright (c) 2007-2014 Intel Corporation.
> > [   21.347058] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
> > [   21.356399] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> > [   21.363577] IOAPIC[9]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:002C SQ:0 SVT:1)
> > [   21.379417] IOAPIC[1]: Set routing entry (9-13 -> 0xef -> IRQ 38 Mode:1 Active:1 Dest:1)
> > [   21.665318] ixgbe 0000:03:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
> > [   21.761727] ixgbe 0000:03:00.0: 32.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x8 link)
> > [   21.795985] ixgbe 0000:03:00.0: MAC: 3, PHY: 0, PBA No: 000000-000
> > [   21.803321] ixgbe 0000:03:00.0: 00:1e:67:f7:44:b3
> > [   21.957977] ixgbe 0000:03:00.0: Intel(R) 10 Gigabit Network Connection
> > [   21.965867] libphy: ixgbe-mdio: probed
> > [   21.970646] IOAPIC[9]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:002C SQ:0 SVT:1)
> > [   21.986482] IOAPIC[1]: Set routing entry (9-10 -> 0xef -> IRQ 105 Mode:1 Active:1 Dest:1)
> > [   22.265269] ixgbe 0000:03:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
> > [   22.361656] ixgbe 0000:03:00.1: 32.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x8 link)
> > [   22.395908] ixgbe 0000:03:00.1: MAC: 3, PHY: 0, PBA No: 000000-000
> > [   22.403235] ixgbe 0000:03:00.1: 00:1e:67:f7:44:b4
> > [   22.556985] ixgbe 0000:03:00.1: Intel(R) 10 Gigabit Network Connection
> > [   22.564864] libphy: ixgbe-mdio: probed
> > [   22.569541] i40e: Intel(R) Ethernet Connection XL710 Network Driver - version 2.8.20-k
> > [   22.579179] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
> > [   22.586811] usbcore: registered new interface driver catc
> > [   22.593299] usbcore: registered new interface driver kaweth
> > [   22.599957] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
> > [   22.609017] usbcore: registered new interface driver pegasus
> > [   22.615784] usbcore: registered new interface driver rtl8150
> > [   22.622550] usbcore: registered new interface driver asix
> > [   22.629029] usbcore: registered new interface driver cdc_ether
> > [   22.635987] usbcore: registered new interface driver cdc_eem
> > [   22.642749] usbcore: registered new interface driver dm9601
> > [   22.649423] usbcore: registered new interface driver smsc75xx
> > [   22.656294] usbcore: registered new interface driver smsc95xx
> > [   22.663163] usbcore: registered new interface driver gl620a
> > [   22.669828] usbcore: registered new interface driver net1080
> > [   22.676587] usbcore: registered new interface driver plusb
> > [   22.683162] usbcore: registered new interface driver rndis_host
> > [   22.690218] usbcore: registered new interface driver cdc_subset
> > [   22.697285] usbcore: registered new interface driver zaurus
> > [   22.703954] usbcore: registered new interface driver MOSCHIP usb-ethernet driver
> > [   22.713005] usbcore: registered new interface driver int51x1
> > [   22.719770] usbcore: registered new interface driver ipheth
> > [   22.726439] usbcore: registered new interface driver sierra_net
> > [   22.733563] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> > [   22.741292] ehci-pci: EHCI PCI platform driver
> > [   22.746931] IOAPIC[8]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0FF SQ:0 SVT:1)
> > [   22.762784] IOAPIC[0]: Set routing entry (8-18 -> 0xef -> IRQ 18 Mode:1 Active:1 Dest:1)
> > [   22.772881] ehci-pci 0000:00:1a.0: EHCI Host Controller
> > [   22.779227] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
> >
> >
> > To reproduce:
> >
> >          git clone https://github.com/intel/lkp-tests.git
> >          cd lkp-tests
> >          bin/lkp install job.yaml  # job file is attached in this email
> >          bin/lkp run     job.yaml
> >
> >
> >
> > Thanks,
> > Rong Chen
> >
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
