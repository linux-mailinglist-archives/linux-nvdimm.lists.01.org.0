Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A53F62AAF8C
	for <lists+linux-nvdimm@lfdr.de>; Mon,  9 Nov 2020 03:38:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AFED7165EABE6;
	Sun,  8 Nov 2020 18:38:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=yizhan@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 465271655E743
	for <linux-nvdimm@lists.01.org>; Sun,  8 Nov 2020 18:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1604889510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=NlK/YRJbtseBaFf6fQkhDngNRhp91fQ9U+8fwBU3Ko4=;
	b=GwBsR3gSbJ9MaS4F9zaY2g1KzkZ9PyQzXaDjXsFnRsXkqWZ/wuEVWCCszKN/uEjjLde530
	KpZdyo4qe4FentZ9IFY19fOwVctTGew1w1Cl9BV/4TDEnssE6wCsBdyPlw83BEcrNLl9qP
	sAsE5ZeVCBola3QIyt4bi/phGZ6xj0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-pbx2A4nePr2I-ZYwvlHlZw-1; Sun, 08 Nov 2020 21:38:28 -0500
X-MC-Unique: pbx2A4nePr2I-ZYwvlHlZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD8EB1007468;
	Mon,  9 Nov 2020 02:38:27 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4DDA5577A;
	Mon,  9 Nov 2020 02:38:27 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id B4646CF4C;
	Mon,  9 Nov 2020 02:38:27 +0000 (UTC)
Date: Sun, 8 Nov 2020 21:38:26 -0500 (EST)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com
Message-ID: <1687234809.1086398.1604889506963.JavaMail.zimbra@redhat.com>
In-Reply-To: <1934921834.1085815.1604889035798.JavaMail.zimbra@redhat.com>
Subject: regression from 5.10.0-rc3: BUG: Bad page state in process
 kworker/41:0  pfn:891066 during fio on devdax
MIME-Version: 1.0
X-Originating-IP: [10.68.5.41, 10.4.195.1]
Thread-Topic: regression from 5.10.0-rc3: BUG: Bad page state in process kworker/41:0 pfn:891066 during fio on devdax
Thread-Index: /Xy61bIv6eIjVwiw7/4YjzM/n30zFA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: IS4NVFHDVCFMYXEKPUFG4KQ5XXNFA2XC
X-Message-ID-Hash: IS4NVFHDVCFMYXEKPUFG4KQ5XXNFA2XC
X-MailFrom: yizhan@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IS4NVFHDVCFMYXEKPUFG4KQ5XXNFA2XC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello

I found this regression during devdax fio test on 5.10.0-rc3, could anyone help check it, thanks.

[  303.441089] memmap_init_zone_device initialised 2063872 pages in 34ms
[  303.501085] memmap_init_zone_device initialised 2063872 pages in 34ms
[  303.556891] memmap_init_zone_device initialised 2063872 pages in 24ms
[  303.612790] memmap_init_zone_device initialised 2063872 pages in 24ms
[  326.779920] perf: interrupt took too long (2714 > 2500), lowering kernel.perf_event_max_sample_rate to 73000
[  334.857133] perf: interrupt took too long (3737 > 3392), lowering kernel.perf_event_max_sample_rate to 53000
[  366.202597] memmap_init_zone_device initialised 1835008 pages in 21ms
[  366.255031] memmap_init_zone_device initialised 1835008 pages in 22ms
[  366.317048] memmap_init_zone_device initialised 1835008 pages in 31ms
[  366.377970] memmap_init_zone_device initialised 1835008 pages in 32ms
[  368.785285] BUG: Bad page state in process kworker/41:0  pfn:891066
[  368.818471] page:00000000581ab220 refcount:0 mapcount:-1024 mapping:0000000000000000 index:0x0 pfn:0x891066
[  368.865117] flags: 0x57ffffc0000000()
[  368.882138] raw: 0057ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[  368.917429] raw: 0000000000000000 0000000000000000 00000000fffffbff 0000000000000000
[  368.952788] page dumped because: nonzero mapcount
[  368.974190] Modules linked in: rfkill sunrpc vfat fat dm_multipath intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp mgag200 ipmi_ssif i2c_algo_bit kvm_intel drm_kms_helper syscopyarea acpi_ipmi sysfillrect kvm sysimgblt ipmi_si fb_sys_fops iTCO_wdt iTCO_vendor_support ipmi_devintf drm irqbypass crct10dif_pclmul ipmi_msghandler crc32_pclmul i2c_i801 ghash_clmulni_intel dax_pmem_compat rapl device_dax i2c_smbus intel_cstate ioatdma intel_uncore joydev hpilo dax_pmem_core pcspkr acpi_tad hpwdt lpc_ich dca acpi_power_meter ip_tables xfs sr_mod cdrom sd_mod t10_pi sg nd_pmem nd_btt ahci nfit bnx2x libahci libata tg3 libnvdimm hpsa mdio libcrc32c scsi_transport_sas wmi crc32c_intel dm_mirror dm_region_hash dm_log dm_mod
[  369.281195] CPU: 41 PID: 3258 Comm: kworker/41:0 Tainted: G S                5.10.0-rc3 #1
[  369.321037] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 10/05/2016
[  369.363640] Workqueue: mm_percpu_wq vmstat_update
[  369.385044] Call Trace:
[  369.388275] perf: interrupt took too long (5477 > 4671), lowering kernel.perf_event_max_sample_rate to 36000
[  369.396225]  dump_stack+0x57/0x6a
[  369.411391]  bad_page.cold.114+0x9b/0xa0
[  369.429316]  free_pcppages_bulk+0x538/0x760
[  369.448465]  drain_zone_pages+0x1f/0x30
[  369.466027]  refresh_cpu_vm_stats+0x1ea/0x2b0
[  369.485972]  vmstat_update+0xf/0x50
[  369.502064]  process_one_work+0x1a4/0x340
[  369.520412]  ? process_one_work+0x340/0x340
[  369.539510]  worker_thread+0x30/0x370
[  369.555744]  ? process_one_work+0x340/0x340
[  369.574765]  kthread+0x116/0x130
[  369.589612]  ? kthread_park+0x80/0x80
[  369.606231]  ret_from_fork+0x22/0x30
[  369.622910] Disabling lock debugging due to kernel taint
[  393.619285] perf: interrupt took too long (6874 > 6846), lowering kernel.perf_event_max_sample_rate to 29000
[  397.904036] BUG: Bad page state in process kworker/57:1  pfn:189525
[  397.936971] page:00000000be782875 refcount:0 mapcount:-1024 mapping:0000000000000000 index:0x0 pfn:0x189525
[  397.984722] flags: 0x17ffffc0000000()
[  398.002324] raw: 0017ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[  398.039032] raw: 0000000000000000 0000000000000000 00000000fffffbff 0000000000000000
[  398.075804] page dumped because: nonzero mapcount
[  398.098130] Modules linked in: rfkill sunrpc vfat fat dm_multipath intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp mgag200 ipmi_ssif i2c_algo_bit kvm_intel drm_kms_helper syscopyarea acpi_ipmi sysfillrect kvm sysimgblt ipmi_si fb_sys_fops iTCO_wdt iTCO_vendor_support ipmi_devintf drm irqbypass crct10dif_pclmul ipmi_msghandler crc32_pclmul i2c_i801 ghash_clmulni_intel dax_pmem_compat rapl device_dax i2c_smbus intel_cstate ioatdma intel_uncore joydev hpilo dax_pmem_core pcspkr acpi_tad hpwdt lpc_ich dca acpi_power_meter ip_tables xfs sr_mod cdrom sd_mod t10_pi sg nd_pmem nd_btt ahci nfit bnx2x libahci libata tg3 libnvdimm hpsa mdio libcrc32c scsi_transport_sas wmi crc32c_intel dm_mirror dm_region_hash dm_log dm_mod
[  398.413042] CPU: 57 PID: 587 Comm: kworker/57:1 Tainted: G S  B             5.10.0-rc3 #1
[  398.455914] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 10/05/2016
[  398.496657] Workqueue: mm_percpu_wq vmstat_update
[  398.518938] Call Trace:
[  398.530673]  dump_stack+0x57/0x6a
[  398.546463]  bad_page.cold.114+0x9b/0xa0
[  398.564977]  free_pcppages_bulk+0x538/0x760
[  398.584697]  drain_zone_pages+0x1f/0x30
[  398.602907]  refresh_cpu_vm_stats+0x1ea/0x2b0
[  398.623681]  vmstat_update+0xf/0x50
[  398.640415]  process_one_work+0x1a4/0x340
[  398.659517]  ? process_one_work+0x340/0x340
[  398.678659]  worker_thread+0x30/0x370
[  398.695506]  ? process_one_work+0x340/0x340
[  398.715204]  kthread+0x116/0x130
[  398.730572]  ? kthread_park+0x80/0x80
[  398.747761]  ret_from_fork+0x22/0x30




Best Regards,
  Yi Zhang

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
