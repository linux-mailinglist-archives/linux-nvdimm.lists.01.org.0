Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4CB293643
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Oct 2020 09:56:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DC10A159AD607;
	Tue, 20 Oct 2020 00:56:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EE055159AD607
	for <linux-nvdimm@lists.01.org>; Tue, 20 Oct 2020 00:56:10 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09K7boPh078871;
	Tue, 20 Oct 2020 03:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=pp1;
 bh=RT4go1AnuXIs4NtrMEnHK56tN9LaZcH8HtYJ9TTpHPk=;
 b=juhoIPRe4gGJGTlxRS4XSM1LAxuggdj8oeNg5k3uli31rxKjKe3nzOYxikg/StHJ52yq
 2qP70r5Krqz2iRl/YFTzzTd+ovUpTjjk8PvxPvnbEjO2bb6vaEkLY9bm2MWA4HlKU0LB
 6ENrzLm1linN2ABfq3VZ/Hl/Lpeh+MhcPDwpoWEn8SkHEGA0hAhqydYnsFXih1JsEXBJ
 UaGIeAi/zk2Nt1jA91EDPo9r3oAo81T6eVbJHXuoIqM0bImMq28PJGdFKE/rVicZRW6x
 eEVz21pZs2MbKE07G0+JsaKD3oTQPzqcnrxFrdcgbsxREp1UEoeBe2jZ2kqMHblNkkw8 Ig==
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0b-001b2d01.pphosted.com with ESMTP id 349r2bnx1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2020 03:55:59 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09K7pA6k021087;
	Tue, 20 Oct 2020 07:55:59 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by ppma03wdc.us.ibm.com with ESMTP id 347r88x4fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2020 07:55:59 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09K7trge28246732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2020 07:55:53 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F24A56A04D;
	Tue, 20 Oct 2020 07:55:57 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FE586A047;
	Tue, 20 Oct 2020 07:55:56 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.92.7])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2020 07:55:55 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
Subject: negative count with static key devmap_managed_key
Date: Tue, 20 Oct 2020 13:25:51 +0530
Message-ID: <87wnzljpq0.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-20_03:2020-10-16,2020-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=567
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200044
Message-ID-Hash: TIQVTLU6W3LKVKUDJKQK5PATTT4CRHF4
X-Message-ID-Hash: TIQVTLU6W3LKVKUDJKQK5PATTT4CRHF4
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TIQVTLU6W3LKVKUDJKQK5PATTT4CRHF4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi Christoph,

commit 6f42193fd86e ("memremap: don't use a separate devm action for
devmap_managed_enable_get") changed the static key updates such that we
are now calling	devmap_managed_enable_put() without doing the equivalent
devmap_managed_enable_get().

devmap_managed_enable_get() is only called for MEMORY_DEVICE_PRIVATE and
MEMORY_DEVICE_FS_DAX, But memunmap_pages() get called for other pgmap
types too. This result in the below. I can recreate this by repeatedly
switching between system-ram and devdax mode for devdax namespace. 


[ 4399.892395] ------------[ cut here ]------------
[ 4399.892398] jump label: negative count!
[ 4399.892415] WARNING: CPU: 52 PID: 1335 at kernel/jump_label.c:235 static_key_slow_try_dec+0x88/0xa0
[ 4399.892417] Modules linked in:
[ 4399.892424] CPU: 52 PID: 1335 Comm: ndctl Not tainted 5.9.0-12063-g270315b8235e-dirty #332
[ 4399.892427] NIP:  c000000000433318 LR: c000000000433314 CTR: 0000000000000000
[ 4399.892430] REGS: c000000025c1f3d0 TRAP: 0700   Not tainted  (5.9.0-12063-g270315b8235e-dirty)
[ 4399.892432] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28088284  XER: 00000000
[ 4399.892456] CFAR: c00000000017bb30 IRQMASK: 0
               GPR00: c000000000433314 c000000025c1f660 c000000002610c00 000000000000001b
               GPR04: c00000000221aa50 0000000000000005 0000000000000027 c000000c79c0cf98
               GPR08: 0000000000000023 0000000000000000 c0000000238b5480 c00000000265da28
               GPR12: 0000000000008000 c00000001ec4e400 0000000000000000 0000000000000000
               GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
               GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
               GPR24: 0000000000000000 0000000000000000 0000000000000001 0000000101204000
               GPR28: c00000000896f1c0 c0000000027118b8 0000000000000001 0000000000000001
[ 4399.892530] NIP [c000000000433318] static_key_slow_try_dec+0x88/0xa0
[ 4399.892533] LR [c000000000433314] static_key_slow_try_dec+0x84/0xa0
[ 4399.892535] Call Trace:
[ 4399.892539] [c000000025c1f660] [c000000000433314] static_key_slow_try_dec+0x84/0xa0 (unreliable)
[ 4399.892546] [c000000025c1f6d0] [c000000000433664] __static_key_slow_dec_cpuslocked+0x34/0xd0
[ 4399.892551] [c000000025c1f700] [c0000000004337a4] static_key_slow_dec+0x54/0xf0
[ 4399.892557] [c000000025c1f770] [c00000000059c49c] memunmap_pages+0x36c/0x500
[ 4399.892562] [c000000025c1f820] [c000000000d91d10] devm_action_release+0x30/0x50
[ 4399.892568] [c000000025c1f840] [c000000000d92e34] release_nodes+0x2f4/0x3e0
[ 4399.892573] [c000000025c1f8f0] [c000000000d8b15c] device_release_driver_internal+0x17c/0x280
[ 4399.892579] [c000000025c1f930] [c000000000d883a4] bus_remove_device+0x124/0x210
[ 4399.892584] [c000000025c1f9b0] [c000000000d80ef4] device_del+0x1d4/0x530
[ 4399.892589] [c000000025c1fa70] [c000000000e341e8] unregister_dev_dax+0x48/0xe0
[ 4399.892594] [c000000025c1fae0] [c000000000d91d10] devm_action_release+0x30/0x50
[ 4399.892599] [c000000025c1fb00] [c000000000d92e34] release_nodes+0x2f4/0x3e0
[ 4399.892605] [c000000025c1fbb0] [c000000000d8b15c] device_release_driver_internal+0x17c/0x280
[ 4399.892610] [c000000025c1fbf0] [c000000000d87000] unbind_store+0x130/0x170
[ 4399.892615] [c000000025c1fc30] [c000000000d862a0] drv_attr_store+0x40/0x60
[ 4399.892621] [c000000025c1fc50] [c0000000006d316c] sysfs_kf_write+0x6c/0xb0
[ 4399.892626] [c000000025c1fc90] [c0000000006d2328] kernfs_fop_write+0x118/0x280
[ 4399.892631] [c000000025c1fce0] [c0000000005a79f8] vfs_write+0xe8/0x2a0
[ 4399.892636] [c000000025c1fd30] [c0000000005a7d94] ksys_write+0x84/0x140
[ 4399.892641] [c000000025c1fd80] [c00000000003a430] system_call_exception+0x120/0x270
[ 4399.892647] [c000000025c1fe20] [c00000000000c540] system_call_common+0xf0/0x27c
[ 4399.892650] Instruction dump:
[ 4399.892654] 41800018 38210070 7fe3fb78 ebe1fff8 4e800020 60000000 7c0802a6 3c62ff0f
[ 4399.892670] 38635a30 f8010080 4bd487b9 60000000 <0fe00000> e8010080 7c0803a6 4bffffc8
[ 4399.892688] CPU: 52 PID: 1335 Comm: ndctl Not tainted 5.9.0-12063-g270315b8235e-dirty #332
[ 4399.892690] Call Trace:
[ 4399.892694] [c000000025c1f170] [c000000000b49160] dump_stack+0xc4/0x114 (unreliable)
[ 4399.892701] [c000000025c1f1c0] [c00000000017ba8c] __warn+0xfc/0x130
[ 4399.892707] [c000000025c1f260] [c000000000b47f6c] report_bug+0xdc/0x1f0
[ 4399.892712] [c000000025c1f2f0] [c00000000002a4a4] program_check_exception+0x234/0x3a0
[ 4399.892717] [c000000025c1f360] [c0000000000093a4] program_check_common_virt+0x2a4/0x2f0
[ 4399.892724] --- interrupt: 700 at static_key_slow_try_dec+0x88/0xa0
                   LR = static_key_slow_try_dec+0x84/0xa0
[ 4399.892728] [c000000025c1f6d0] [c000000000433664] __static_key_slow_dec_cpuslocked+0x34/0xd0
[ 4399.892733] [c000000025c1f700] [c0000000004337a4] static_key_slow_dec+0x54/0xf0
[ 4399.892738] [c000000025c1f770] [c00000000059c49c] memunmap_pages+0x36c/0x500
[ 4399.892743] [c000000025c1f820] [c000000000d91d10] devm_action_release+0x30/0x50
[ 4399.892748] [c000000025c1f840] [c000000000d92e34] release_nodes+0x2f4/0x3e0
[ 4399.892754] [c000000025c1f8f0] [c000000000d8b15c] device_release_driver_internal+0x17c/0x280
[ 4399.892759] [c000000025c1f930] [c000000000d883a4] bus_remove_device+0x124/0x210
[ 4399.892764] [c000000025c1f9b0] [c000000000d80ef4] device_del+0x1d4/0x530
[ 4399.892769] [c000000025c1fa70] [c000000000e341e8] unregister_dev_dax+0x48/0xe0
[ 4399.892774] [c000000025c1fae0] [c000000000d91d10] devm_action_release+0x30/0x50
[ 4399.892779] [c000000025c1fb00] [c000000000d92e34] release_nodes+0x2f4/0x3e0
[ 4399.892784] [c000000025c1fbb0] [c000000000d8b15c] device_release_driver_internal+0x17c/0x280
[ 4399.892790] [c000000025c1fbf0] [c000000000d87000] unbind_store+0x130/0x170
[ 4399.892795] [c000000025c1fc30] [c000000000d862a0] drv_attr_store+0x40/0x60
[ 4399.892800] [c000000025c1fc50] [c0000000006d316c] sysfs_kf_write+0x6c/0xb0
[ 4399.892805] [c000000025c1fc90] [c0000000006d2328] kernfs_fop_write+0x118/0x280
[ 4399.892810] [c000000025c1fce0] [c0000000005a79f8] vfs_write+0xe8/0x2a0
[ 4399.892815] [c000000025c1fd30] [c0000000005a7d94] ksys_write+0x84/0x140
[ 4399.892820] [c000000025c1fd80] [c00000000003a430] system_call_exception+0x120/0x270
[ 4399.892826] [c000000025c1fe20] [c00000000000c540] system_call_common+0xf0/0x27c
[ 4399.892830] ---[ end trace c56bf28fafec054d ]---
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
