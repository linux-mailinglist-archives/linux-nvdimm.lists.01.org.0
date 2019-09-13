Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E581DB254C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 20:42:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A4741202EA406;
	Fri, 13 Sep 2019 11:42:37 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.241;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0241.hostedemail.com
 [216.40.44.241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7BCDA202EA3FF
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 11:42:36 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4ED4D801A6AF;
 Fri, 13 Sep 2019 18:42:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com,
 :::::::::::::::::::::::::::,
 RULES_HIT:1:2:41:355:379:599:800:857:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:1981:2194:2198:2199:2200:2393:2553:2559:2562:2828:2894:2896:3138:3139:3140:3141:3142:3165:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4051:4321:4605:5007:6119:6742:7903:7974:10004:10562:10848:11026:11232:11657:11658:11914:12043:12297:12438:12555:12679:12740:12760:12895:13161:13229:13439:14096:14097:14659:21080:21325:21433:21451:21627:21740:21773:21810:30054:30055:30090:30091,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:25,
 LUA_SUMMARY:none
X-HE-Tag: crook21_174f32285e930
X-Filterd-Recvd-Size: 10261
Received: from XPS-9350.home (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf03.hostedemail.com (Postfix) with ESMTPA;
 Fri, 13 Sep 2019 18:42:40 +0000 (UTC)
Message-ID: <78f67ee934f167b433517da81c6a0d3f35c4b123.camel@perches.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
From: Joe Perches <joe@perches.com>
To: Rob Herring <robherring2@gmail.com>
Date: Fri, 13 Sep 2019 11:42:38 -0700
In-Reply-To: <CAL_JsqJju36BZPK6DJab28Ne-ORpEyPpxH0H4DuymxFMabpMRQ@mail.gmail.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <yq1o8zqeqhb.fsf@oracle.com> <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
 <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
 <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org>
 <4299c79e33f22e237e42515ea436f187d8beb32e.camel@perches.com>
 <CAL_JsqJju36BZPK6DJab28Ne-ORpEyPpxH0H4DuymxFMabpMRQ@mail.gmail.com>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
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
Cc: Bart Van Assche <bvanassche@acm.org>,
 ksummit <ksummit-discuss@lists.linuxfoundation.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dmitry Vyukov <dvyukov@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Steve French <stfrench@microsoft.com>, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, 2019-09-13 at 15:26 +0100, Rob Herring wrote:
> On Fri, Sep 13, 2019 at 3:12 PM Joe Perches <joe@perches.com> wrote:
> > On Thu, 2019-09-12 at 13:01 -0700, Bart Van Assche wrote:
> > 
> > > Another argument in favor of W=1 is that the formatting of kernel-doc
> > > headers is checked only if W=1 is passed to make.
> > 
> > Actually, but for the fact there are far too many
> > to generally enable that warning right now,
> > (an x86-64 defconfig has more than 1000)
> > that sounds pretty reasonable to me.

> It's in the 1000s on arm because W=1 turns on more checks in building
> .dts files. There are lots of duplicates as most of the dts content is
> as an include file (e.g. board dts includes soc dts).

Yeah, dts[i] files in arm compilations are very noisy at W=1
so moving those message types to W=2 seems sensible.

$ { opt="ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnueabi-" ; make $opt clean ; make $opt defconfig ; make $opt W=1 -j4 ; } > arm_make.log 2>&1

$ grep -i -P 'dtsi?:.*warning' arm_make.log | wc -l
69164

Just fyi:  for an x86-64 defconfig with gcc 8.3

$ { make clean ; make defconfig ; make -j4 W=1 ; } > make.log 2>&1

There are ~300 W=1 for non kernel-doc -W<foo> warnings.

$ grep -i -P -oh '\[\-W[\w\-]+\]' make.log |sort | uniq -c | sort -rn
    163 [-Wmissing-prototypes]
     69 [-Wunused-but-set-variable]
     16 [-Wempty-body]
     10 [-Wtype-limits]
      6 [-Woverride-init]
      2 [-Wstringop-truncation]
      2 [-Wcast-function-type]
      1 [-Wunused-but-set-parameter]

And there are ~1000 kernel-doc only messages in various files

$ grep -i 'function parameter' make.log | cut -f1 -d: | sort | uniq -c
      6 arch/x86/events/intel/pt.c
      2 arch/x86/kernel/apic/apic.c
     10 arch/x86/kernel/cpu/mtrr/generic.c
      5 arch/x86/kernel/crash_dump_64.c
      1 arch/x86/kernel/i8259.c
      3 arch/x86/kernel/smpboot.c
      3 arch/x86/kernel/tsc.c
      2 arch/x86/kernel/uprobes.c
      1 arch/x86/lib/cmdline.c
      1 arch/x86/lib/insn.c
      2 arch/x86/lib/insn-eval.c
      4 arch/x86/lib/msr.c
      2 arch/x86/lib/usercopy_64.c
      1 arch/x86/mm/pat.c
     13 arch/x86/mm/pgtable.c
      1 arch/x86/pci/i386.c
      2 arch/x86/power/cpu.c
      2 arch/x86/power/hibernate.c
      8 certs/system_keyring.c
      4 crypto/asymmetric_keys/asymmetric_type.c
      3 crypto/asymmetric_keys/pkcs7_trust.c
     16 crypto/jitterentropy.c
      3 drivers/acpi/acpi_apd.c
      3 drivers/acpi/bus.c
      2 drivers/acpi/cppc_acpi.c
      5 drivers/acpi/device_sysfs.c
      2 drivers/acpi/dock.c
      2 drivers/acpi/nvs.c
      1 drivers/acpi/pci_root.c
      5 drivers/acpi/property.c
      4 drivers/acpi/sleep.c
      7 drivers/acpi/utils.c
      1 drivers/ata/libata-acpi.c
      2 drivers/ata/libata-pmp.c
      6 drivers/ata/libata-transport.c
      4 drivers/ata/pata_amd.c
      4 drivers/base/attribute_container.c
      1 drivers/base/devcon.c
      3 drivers/base/platform-msi.c
      3 drivers/base/power/runtime.c
      5 drivers/base/power/wakeup.c
      2 drivers/char/agp/backend.c
      3 drivers/char/agp/generic.c
      2 drivers/clk/clk.c
      1 drivers/clk/clk-fixed-factor.c
      1 drivers/clk/clk-fixed-rate.c
      3 drivers/connector/cn_proc.c
     31 drivers/cpufreq/cpufreq.c
      3 drivers/cpufreq/cpufreq_governor.c
      7 drivers/cpufreq/freq_table.c
      1 drivers/cpufreq/intel_pstate.c
      6 drivers/cpuidle/sysfs.c
      1 drivers/dma-buf/dma-buf.c
      1 drivers/dma-buf/dma-fence-chain.c
      6 drivers/dma/dmaengine.c
      7 drivers/firewire/init_ohci1394_dma.c
      2 drivers/firmware/efi/memmap.c
      1 drivers/firmware/efi/vars.c
     20 drivers/gpu/drm/drm_agpsupport.c
      8 drivers/hid/hid-core.c
      3 drivers/hid/hid-quirks.c
      5 drivers/hid/usbhid/hid-pidff.c
      3 drivers/input/mouse/synaptics.c
      2 drivers/iommu/amd_iommu_init.c
      2 drivers/iommu/dmar.c
      1 drivers/iommu/intel-pasid.c
      1 drivers/iommu/iommu.c
      2 drivers/leds/led-class.c
      2 drivers/mailbox/pcc.c
      6 drivers/net/ethernet/intel/e1000/e1000_hw.c
     21 drivers/net/ethernet/intel/e1000/e1000_main.c
      1 drivers/net/ethernet/intel/e1000e/80003es2lan.c
      6 drivers/net/ethernet/intel/e1000e/ich8lan.c
     42 drivers/net/ethernet/intel/e1000e/netdev.c
      3 drivers/net/ethernet/intel/e1000e/phy.c
      2 drivers/net/ethernet/intel/e1000e/ptp.c
      1 drivers/net/netconsole.c
      3 drivers/net/phy/mdio-boardinfo.c
      2 drivers/net/phy/mdio_device.c
      2 drivers/pci/ats.c
      3 drivers/pci/hotplug/acpi_pcihp.c
      4 drivers/pci/pcie/aer.c
      2 drivers/pci/pcie/pme.c
      1 drivers/pci/setup-bus.c
      1 drivers/pci/vc.c
     22 drivers/pcmcia/cistpl.c
     13 drivers/pcmcia/pcmcia_cis.c
     13 drivers/pcmcia/pcmcia_resource.c
     11 drivers/pcmcia/rsrc_nonstatic.c
      1 drivers/pnp/system.c
     11 drivers/rtc/interface.c
      3 drivers/rtc/sysfs.c
      2 drivers/thermal/step_wise.c
      2 drivers/thermal/user_space.c
      6 drivers/tty/n_tty.c
      4 drivers/tty/pty.c
      7 drivers/tty/tty_audit.c
      7 drivers/tty/tty_baudrate.c
     13 drivers/tty/tty_buffer.c
     25 drivers/tty/tty_io.c
      5 drivers/tty/tty_jobctrl.c
      6 drivers/tty/tty_ldisc.c
      6 drivers/tty/tty_port.c
      5 drivers/tty/vt/consolemap.c
      4 drivers/tty/vt/vt.c
      3 drivers/tty/vt/vt_ioctl.c
     12 drivers/usb/common/debug.c
      1 drivers/usb/host/pci-quirks.c
      1 drivers/usb/host/xhci.c
      6 drivers/usb/host/xhci-mem.c
      2 drivers/video/backlight/backlight.c
      1 drivers/video/fbdev/core/fbmon.c
      2 drivers/video/fbdev/core/fb_notify.c
      7 fs/devpts/inode.c
      4 fs/direct-io.c
      3 fs/eventpoll.c
      6 fs/fat/dir.c
      3 fs/fat/misc.c
      6 fs/fat/nfs.c
      4 fs/fs_context.c
      1 fs/fs_parser.c
      2 fs/fs-writeback.c
      5 fs/ioctl.c
      1 fs/libfs.c
      3 fs/namespace.c
      2 fs/nfs_common/grace.c
      2 fs/open.c
      3 fs/posix_acl.c
      1 fs/proc/proc_net.c
      2 fs/proc/vmcore.c
      2 fs/read_write.c
      1 fs/super.c
      5 fs/xattr.c
      2 kernel/cgroup/cpuset.c
      1 kernel/cpu.c
      4 kernel/events/core.c
      2 kernel/events/hw_breakpoint.c
      5 kernel/fork.c
     27 kernel/irq/irqdomain.c
      3 kernel/irq/matrix.c
      1 kernel/kprobes.c
      5 kernel/locking/rtmutex.c
      1 kernel/notifier.c
      3 kernel/power/main.c
      2 kernel/power/qos.c
     51 kernel/power/snapshot.c
      2 kernel/power/suspend.c
     14 kernel/power/swap.c
      1 kernel/reboot.c
      4 kernel/seccomp.c
      2 kernel/stacktrace.c
      4 kernel/time/alarmtimer.c
      1 kernel/time/clockevents.c
      4 kernel/time/posix-cpu-timers.c
      1 kernel/time/tick-broadcast.c
      6 kernel/time/tick-oneshot.c
      3 kernel/time/tick-sched.c
      3 kernel/time/timeconv.c
     23 kernel/time/timekeeping.c
      9 kernel/trace/ring_buffer.c
      8 kernel/trace/trace_events_filter.c
      2 kernel/trace/trace_events_trigger.c
      1 kernel/trace/trace_seq.c
      1 lib/argv_split.c
      1 lib/cpumask.c
      5 lib/genalloc.c
      4 lib/iov_iter.c
      2 lib/nlattr.c
      3 lib/percpu_counter.c
      6 lib/radix-tree.c
      2 lib/scatterlist.c
      3 lib/win_minmax.c
      1 mm/compaction.c
      2 mm/oom_kill.c
      1 mm/page_vma_mapped.c
      2 mm/swap_state.c
      1 mm/vmalloc.c
      1 mm/vmscan.c
      8 net/ipv4/cipso_ipv4.c
      3 net/ipv4/ipmr.c
      1 net/ipv4/tcp_input.c
      5 net/ipv4/tcp_output.c
      2 net/ipv4/tcp_timer.c
      3 net/ipv4/udp.c
      4 net/ipv6/calipso.c
      1 net/ipv6/exthdrs.c
      1 net/ipv6/ip6_output.c
      3 net/ipv6/udp.c
      1 net/mac80211/tx.c
      5 net/netlabel/netlabel_calipso.c
      2 net/netlabel/netlabel_domainhash.c
      3 net/sched/ematch.c
      1 net/socket.c
      1 net/wireless/radiotap.c
      4 net/wireless/reg.c
      6 security/commoncap.c
      1 security/lsm_audit.c
     12 security/selinux/avc.c
      7 security/selinux/netlabel.c
      2 security/selinux/netport.c
      4 security/selinux/ss/mls.c
     34 security/selinux/ss/services.c
      3 sound/hda/hdac_bus.c
      1 sound/hda/hdac_component.c
      2 sound/hda/hdac_controller.c
     10 sound/hda/hdac_device.c
      2 sound/hda/hdac_stream.c
      1 sound/pci/hda/hda_codec.c


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
