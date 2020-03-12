Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F241833F3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Mar 2020 15:59:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C4CF110FC3786;
	Thu, 12 Mar 2020 08:00:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=lukasz.dorau@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4B41210FC36E4
	for <linux-nvdimm@lists.01.org>; Thu, 12 Mar 2020 08:00:38 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 07:59:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400";
   d="scan'208";a="389627512"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2020 07:59:47 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 07:59:46 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Mar 2020 07:59:46 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Mar 2020 07:59:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 07:59:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GStKtU3P7efWnQAvnb0DlS4xzdYyRSGnf/OS8VIgjw8pj8qm+yw4GM5XrSdfNYuJZZHbP+T4FU20QcQ69Ciqrm1STpzUsdqpwonVq9UONgCBwRsB0D2kipJFmWaXz73WEmaNAeIMtCV0MqvriI+G0h1siQqi1bNXvqrvN8UWhwVvGtrIUcHhWrXyC0vhtmJaKbChMndoY5nb9OYE7jMw/SFLf0ru/ypegS6cdeptRwEZJvGMwf61yc8XnHPwbf9BdTMpmzp+usBTCgYiUnjqgpw3WMqibO2lVM84W+Q5vDkc09eRqDW9MevdqMyJQK09S6GaXPzO+/piGqvsBwldmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RY0ni6eNKb4Uog1aAaoq836gC8XU36Fyz+iPocFGvQc=;
 b=DIQZwvCJPiPk1Bhj64RsAUYTucoNonu+gET0KmiWTAegH9RfXyQP1DeuElWHP6u8C75JP4e9/iNflOEVEtXsImAsA0++IEObC2DFrdZobpnPaNzc6JG4uaXnYaXp7FSbtwJP9dOMS3P1QUZTqytW24sX2azVdtbGYhvQ6wBy9dRIBS/kgNKrBfJ+g1sxzIcL9JIgNDFhaH+uhb9gKAJ9EnAXyFnheKD+NNsUEsEJQTvzJaO4yPw0tXLHoE+O9aCWe753OAafW7nsQmP6M3nRqkpJHwH/AmcpfScy3634rTcL5OYLWun8HxoZ8sWIJElgfxYoZYgTCOZU7MjgSXB5Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RY0ni6eNKb4Uog1aAaoq836gC8XU36Fyz+iPocFGvQc=;
 b=oBOar+f17IexKhMGdypMvx2Xv8s7bp2jrkv5Q/VadVUug7zuW+UUDWtXzhrTpJNsn3ggWe4B0JNIAT86Dz1aMWZcrrEuJJWc4RtpOLPv300DtSu1t90UsxJe1Pb0dpvAF9llsiwJljslxaTgWTaxwvKwoGqKcUOyAU5BClCWWA0=
Received: from SN6PR11MB2864.namprd11.prod.outlook.com (2603:10b6:805:63::26)
 by SN6PR11MB3407.namprd11.prod.outlook.com (2603:10b6:805:bd::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Thu, 12 Mar
 2020 14:59:41 +0000
Received: from SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3]) by SN6PR11MB2864.namprd11.prod.outlook.com
 ([fe80::fd11:322:84c8:a4e3%5]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 14:59:40 +0000
From: "Dorau, Lukasz" <lukasz.dorau@intel.com>
To: linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: nfit_test: issue #3: BUG: kernel NULL pointer dereference, address:
 0000000000000018
Thread-Topic: nfit_test: issue #3: BUG: kernel NULL pointer dereference,
 address: 0000000000000018
Thread-Index: AdX4ff9vRi+83PXwTQC0PvRaS9yWHA==
Date: Thu, 12 Mar 2020 14:59:40 +0000
Message-ID: <SN6PR11MB28641D4A1AF433086764A98D96FD0@SN6PR11MB2864.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lukasz.dorau@intel.com;
x-originating-ip: [134.191.221.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a8e57be-731d-4d2e-8bf3-08d7c695fdfd
x-ms-traffictypediagnostic: SN6PR11MB3407:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3407958E0EA133F2AB4C44F396FD0@SN6PR11MB3407.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(81166006)(76116006)(66446008)(45080400002)(33656002)(26005)(66946007)(66476007)(66556008)(64756008)(107886003)(478600001)(186003)(316002)(54906003)(86362001)(5660300002)(8676002)(6916009)(71200400001)(81156014)(8936002)(55016002)(2906002)(4326008)(52536014)(6506007)(9686003)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3407;H:SN6PR11MB2864.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4D2V7NIwR5idi2w0Id3Z6VJRt9G0FX1mztFrv9CzfRHOLu3PRMhvghqTOsJ8EE/PmG7zZfaeomX68fGJmV111Aa5FVmQ0pZKIdvR6NONcNKYGrgzuA7Ja+xMrlRXWHBKvIR4+uSZZ/ItWMmJcdj6D9Tcobuxg7X0zXD6WffITc921gZRXgVaZ6y9dEZGUA3I3YrlHx02Pv2Ws77qe/dml/Kz5oH8fR3qurAjFVm330etwNKbTSj0vdDbYfPeq1MnEU4nofwSyIlNu1Wdsb7BKs1oP9NLdBjh3DCenF8ApfDd+tvG+k/28AZHxyehI+o2fsZJBqtQ8W3DQILBk3wUDiGEQbnAFfcAgeCkOlrIs+es6InZGzo4hBQ3X3XcVsQIygOy4lPOUZVBnLeU7XzevJd8gDxywQ0HraMyiql/dKihlVbLNuRNOomm4oqmBoWZ
x-ms-exchange-antispam-messagedata: ZO6BF+1gNG6r/zG+al+f5kTphSzFxtEeY/kBI0Z+izFa595CIkr/r/rEwO+ZwiSMK0B3/MSEoYZGRLE26q5EBSw8Rq3k+1jQ37ZiQLdtJZIY3WAzzgbEZdBMxqGdXi4/HSeFF57r/MKVshmHCutGVg==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8e57be-731d-4d2e-8bf3-08d7c695fdfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 14:59:40.7884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQkYMcmHXxvscrVeIoWAFnfMYw669FV/LWBkPin92s+ArfcOQ07jNEuS5CD9Ve+uPPcbxURYJsN2lDuyKM5ryA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3407
X-OriginatorOrg: intel.com
Message-ID-Hash: O37AP64NN42MZONOMBMASM22LGOKYP7N
X-Message-ID-Hash: O37AP64NN42MZONOMBMASM22LGOKYP7N
X-MailFrom: lukasz.dorau@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Slusarz, Marcin" <marcin.slusarz@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O37AP64NN42MZONOMBMASM22LGOKYP7N/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

Hi,

I have inserted the 'nfit_test' module, removed it and reinserted it again (like in the previous e-mail " nfit_test: issue #2: modprobe: ERROR: could not insert 'nfit_test': Unknown symbol in module, or unknown parameter ") and called:
$ ndctl disable-region all
And got the following oops:

[ 3079.971649] nfit_test: mcsafe_test: disabled, skip.
[ 3080.030189] nfit_test nfit_test.0: failed to evaluate _FIT
[ 3080.039150] nfit_test nfit_test.1: Error found in NVDIMM nmem4 flags: save_fail restore_fail flush_fail not_armed
[ 3080.039159] nfit_test nfit_test.1: Error found in NVDIMM nmem5 flags: map_fail
[ 3080.039696] nd_pmem namespace6.0: region6 read-only, marking pmem6 read-only
[ 3080.039805] pmem6: detected capacity change from 0 to 33554432
[ 3080.039806] pmem7: detected capacity change from 0 to 4194304
[ 3080.243372] pmem7: detected capacity change from 0 to 4194304
[ 3080.251781] nd_pmem namespace6.0: region6 read-only, marking pmem6 read-only
[ 3080.251871] pmem6: detected capacity change from 0 to 33554432
[ 3080.508112] BUG: kernel NULL pointer dereference, address: 0000000000000018
[ 3080.508117] #PF: supervisor read access in kernel mode
[ 3080.508118] #PF: error_code(0x0000) - not-present page
[ 3080.508120] PGD 0 P4D 0 
[ 3080.508123] Oops: 0000 [#1] PREEMPT SMP PTI
[ 3080.508126] CPU: 3 PID: 80123 Comm: pmempool Tainted: G           O      5.5.8-arch1-1-bb #1
[ 3080.508128] Hardware name: System manufacturer System Product Name/RAMPAGE IV EXTREME, BIOS 4701 11/18/2013
[ 3080.508133] RIP: 0010:dev_dax_huge_fault+0x2b3/0x570 [device_dax]
[ 3080.508136] Code: 37 48 c1 ee 0c 48 01 f0 48 ba ff ff ff ff ff ff 0f 00 49 c1 ef 0c 48 21 d3 49 01 c7 48 c1 e3 06 48 03 1d 98 54 0d db 48 89 da <48> 83 7a 18 00 75 10 49 8b 8c 24 f0 00 00 00 48 89 42 20 48 89 4a
[ 3080.508137] RSP: 0000:ffffb44406bdfdb0 EFLAGS: 00010247
[ 3080.508139] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 3080.508141] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff924c3d789900
[ 3080.508142] RBP: ffffb44406bdfe28 R08: 000709b000000000 R09: 00000000001baf04
[ 3080.508144] R10: ffff924cbfffc000 R11: 0000000000033160 R12: ffff924c48dd4200
[ 3080.508145] R13: 0000000000000001 R14: 0000000000000100 R15: 0000000000000001
[ 3080.508147] FS:  00007fb40da5c900(0000) GS:ffff924cafac0000(0000) knlGS:0000000000000000
[ 3080.508149] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3080.508151] CR2: 0000000000000018 CR3: 00000003cab58003 CR4: 00000000000606e0
[ 3080.508152] Call Trace:
[ 3080.508161]  __do_fault+0x38/0x120
[ 3080.508165]  __handle_mm_fault+0xff2/0x1580
[ 3080.508170]  ? big_key_read+0x1b0/0x1b0
[ 3080.508174]  handle_mm_fault+0xce/0x200
[ 3080.508178]  do_user_addr_fault+0x1ef/0x470
[ 3080.508184]  page_fault+0x34/0x40
[ 3080.508187] RIP: 0033:0x7fb40de6cb7c
[ 3080.508189] Code: c3 48 81 fa 00 08 00 00 77 a1 48 83 fa 40 77 16 f3 0f 7f 07 f3 0f 7f 47 10 f3 0f 7f 44 17 f0 f3 0f 7f 44 17 e0 c3 48 8d 4f 40 <f3> 0f 7f 07 48 83 e1 c0 f3 0f 7f 44 17 f0 f3 0f 7f 47 10 f3 0f 7f
[ 3080.508190] RSP: 002b:00007ffe85e8e758 EFLAGS: 00010206
[ 3080.508192] RAX: 00007fb40ba00000 RBX: 0000000000000000 RCX: 00007fb40ba00040
[ 3080.508193] RDX: 0000000000200000 RSI: 0000000000000000 RDI: 00007fb40ba00000
[ 3080.508195] RBP: 0000000001e00000 R08: 000000000000000a R09: 0000000000000000
[ 3080.508196] R10: 0000000000000001 R11: 0000000000000206 R12: 000000000000000a
[ 3080.508197] R13: 0000000000000000 R14: 00007fb40ba00000 R15: 0000000000000000
[ 3080.508201] Modules linked in: kmem nfit_test(O) nfit(O) nd_blk dax_pmem_compat(O) device_dax(O) dax_pmem(O) dax_pmem_core(O) nd_pmem(O) nd_btt(O) libnvdimm(O) nfit_test_iomap(O) encrypted_keys trusted tpm rng_core fuse xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c br_netfilter bridge stp llc overlay intel_rapl_msr intel_rapl_common snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm snd_hda_codec_realtek snd_hda_codec_generic irqbypass nouveau ledtrig_audio eeepc_wmi snd_hda_intel btusb asus_wmi snd_intel_dspcfg btrtl iTCO_wdt battery crct10dif_pclmul crc32_pclmul btbcm snd_hda_codec iTCO_vendor_support sparse_keymap btintel wmi_bmof ghash_clmulni_intel bluetooth mxm_wmi aesni_intel snd_hda_core crypto_simd i2c_algo_bit cryptd ttm glue_helper intel_cstate snd_hwdep intel_uncore ecdh_generic dm_mod input_leds intel_rapl_perf
  snd_pcm
[ 3080.508235]  joydev mousedev rfkill drm_kms_helper pcspkr i2c_i801 ecc snd_timer lpc_ich e1000e snd mei_me syscopyarea sysfillrect sysimgblt mei fb_sys_fops soundcore wmi evdev mac_hid drm sg crypto_user agpgart ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 hid_generic usbhid hid sr_mod cdrom sd_mod ahci libahci libata crc32c_intel xhci_pci scsi_mod xhci_hcd ehci_pci ehci_hcd [last unloaded: nfit]
[ 3080.508258] CR2: 0000000000000018
[ 3080.508260] ---[ end trace 4485b40fc6cb1bcb ]---
[ 3080.508264] RIP: 0010:dev_dax_huge_fault+0x2b3/0x570 [device_dax]
[ 3080.508266] Code: 37 48 c1 ee 0c 48 01 f0 48 ba ff ff ff ff ff ff 0f 00 49 c1 ef 0c 48 21 d3 49 01 c7 48 c1 e3 06 48 03 1d 98 54 0d db 48 89 da <48> 83 7a 18 00 75 10 49 8b 8c 24 f0 00 00 00 48 89 42 20 48 89 4a
[ 3080.508268] RSP: 0000:ffffb44406bdfdb0 EFLAGS: 00010247
[ 3080.508270] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 3080.508271] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff924c3d789900
[ 3080.508272] RBP: ffffb44406bdfe28 R08: 000709b000000000 R09: 00000000001baf04
[ 3080.508274] R10: ffff924cbfffc000 R11: 0000000000033160 R12: ffff924c48dd4200
[ 3080.508275] R13: 0000000000000001 R14: 0000000000000100 R15: 0000000000000001
[ 3080.508277] FS:  00007fb40da5c900(0000) GS:ffff924cafac0000(0000) knlGS:0000000000000000
[ 3080.508279] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3080.508280] CR2: 0000000000000018 CR3: 00000003cab58003 CR4: 00000000000606e0

$ ps aux | grep ndctl
root       25958  0.0  0.0   6396  1732 pts/0    D+   15:40   0:00 ndctl disable-region all
root       26409  0.0  0.0   6396  1800 pts/0    D+   15:43   0:00 ndctl disable-region all

$ sudo cat /proc/25958/stack
[<0>] __synchronize_srcu+0x8e/0xc0
[<0>] kill_dax+0x22/0x70
[<0>] pmem_release_disk+0x12/0x40 [nd_pmem]
[<0>] release_nodes+0x19b/0x1e0
[<0>] device_release_driver_internal+0xf4/0x1c0
[<0>] unbind_store+0xef/0x120
[<0>] kernfs_fop_write+0xce/0x1b0
[<0>] vfs_write+0xb6/0x1a0
[<0>] ksys_write+0x67/0xe0
[<0>] do_syscall_64+0x4e/0x150
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

$ sudo cat /proc/26409/stack
[<0>] flush_namespaces+0x15/0x30 [libnvdimm]
[<0>] device_for_each_child+0x69/0xa0
[<0>] flush_regions_dimms+0x33/0x40 [libnvdimm]
[<0>] device_for_each_child+0x69/0xa0
[<0>] wait_probe_show+0x3d/0x60 [libnvdimm]
[<0>] dev_attr_show+0x19/0x40
[<0>] sysfs_kf_seq_show+0x9b/0xf0
[<0>] seq_read+0xcd/0x440
[<0>] vfs_read+0x9d/0x150
[<0>] ksys_read+0x67/0xe0
[<0>] do_syscall_64+0x4e/0x150
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
 
--
Lukasz
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
