Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BD7268341
	for <lists+linux-nvdimm@lfdr.de>; Mon, 14 Sep 2020 05:51:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4244F13C89115;
	Sun, 13 Sep 2020 20:51:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=yizhan@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 482A013C89113
	for <linux-nvdimm@lists.01.org>; Sun, 13 Sep 2020 20:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600055493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=80RoNLmCdDcHqREgSXk87aDYf/TzwGxP1mMa2xPIHH4=;
	b=QcFg4fDoCO/Uit4Lg0MtKItodNcamFGy7gG9wRZ0fp3FJF8GZdZOBkQr9v4OWp9I//ivnn
	gHF1wLkYO1MKBuhDCoF4OIXGmdfHnNf1sE8/CfGvxsjk0IK7N8OoVQBkrG2NhjeElVzHoR
	kF2q2OI4IImBjgavwP8qlYQqGzAfGd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-OqHLfYMfN8GHxs9BjTCyMg-1; Sun, 13 Sep 2020 23:51:31 -0400
X-MC-Unique: OqHLfYMfN8GHxs9BjTCyMg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21E718015A5;
	Mon, 14 Sep 2020 03:51:30 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 19B8A747B0;
	Mon, 14 Sep 2020 03:51:29 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 13B79181A06C;
	Mon, 14 Sep 2020 03:51:28 +0000 (UTC)
Date: Sun, 13 Sep 2020 23:51:28 -0400 (EDT)
From: Yi Zhang <yi.zhang@redhat.com>
To: vishal.l.verma@intel.com, dan.j.williams@intel.com
Message-ID: <1420999447.1004543.1600055488770.JavaMail.zimbra@redhat.com>
In-Reply-To: <104518616.1004145.1600054672621.JavaMail.zimbra@redhat.com>
Subject: regression on 5.9.0-rc5: mount fsdax w/o dax lead kernel panic
MIME-Version: 1.0
X-Originating-IP: [10.68.5.41, 10.4.195.14]
Thread-Topic: regression on 5.9.0-rc5: mount fsdax w/o dax lead kernel panic
Thread-Index: 3m2nL0phfOOdK71ESwMWFyz6ZE2WWw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Message-ID-Hash: BULZHRILK7N2WS2JVISNF2QZNRQK6JU4
X-Message-ID-Hash: BULZHRILK7N2WS2JVISNF2QZNRQK6JU4
X-MailFrom: yizhan@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BULZHRILK7N2WS2JVISNF2QZNRQK6JU4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

Could you help check this regression, let me know if you need more info/testing, thanks.

Reproducer:
# ndctl  list
[
  {
    "dev":"namespace1.0",
    "mode":"fsdax",
    "map":"dev",
    "size":16909336576,
    "uuid":"c4ebad91-3d29-4fb6-be2c-9ee8e12c8b44",
    "sector_size":512,
    "align":2097152,
    "blockdev":"pmem1"
  }
]
# ndctl create-namespace -f -e namespace1.0 -m fsdax 
{
  "dev":"namespace1.0",
  "mode":"fsdax",
  "map":"dev",
  "size":"15.75 GiB (16.91 GB)",
  "uuid":"069a6b5c-917e-4c6c-a277-01fd8574ccb3",
  "sector_size":512,
  "align":2097152,
  "blockdev":"pmem1"
}
# mkfs.ext4 /dev/pmem1
# mount /dev/pmem1 /mnt ---> panic here


kernel log:
[ 1363.513242] BUG: stack guard page was hit at 00000000118cab51 (stack is 00000000548b8b77..000000005363ed26) 
[ 1363.513242] kernel stack overflow (double-fault): 0000 [#1] SMP NOPTI 
[ 1363.513243] CPU: 22 PID: 14682 Comm: mount Tainted: G S        I       5.9.0-rc5 #1 
[ 1363.513243] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.8.1 06/26/2020 
[ 1363.513243] RIP: 0010:igrab+0x14/0x50 
[ 1363.513244] Code: 62 07 8c 00 85 c0 74 c6 83 f8 01 75 cd eb cd 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 8d af 88 00 00 00 53 48 89 fb 48 89 ef <e8> 27 65 64 00 f6 83 98 00 00 00 30 75 17 f0 ff 83 58 01 00 00 48 
[ 1363.513244] RSP: 0018:ffffa700c0e0c000 EFLAGS: 00010246 
[ 1363.513245] RAX: 0000000000000000 RBX: ffff95b69e415a10 RCX: 0000000000000001 
[ 1363.513245] RDX: 0000000000000000 RSI: ffff95a946a406b8 RDI: ffff95b69e415a98 
[ 1363.513245] RBP: ffff95b69e415a98 R08: 0000000500000000 R09: 8080808080808080 
[ 1363.513245] R10: 0000000000000000 R11: fefefefefefefeff R12: 0000000000000001 
[ 1363.513246] R13: ffff95b69e415a00 R14: 0000000000000000 R15: ffff95b79f4d3800 
[ 1363.513246] FS:  00007fbe9b823080(0000) GS:ffff95b87ff80000(0000) knlGS:0000000000000000 
[ 1363.513246] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[ 1363.513246] CR2: ffffa700c0e0bff8 CR3: 0000000ffec46002 CR4: 00000000007706e0 
[ 1363.513247] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
[ 1363.513247] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 
[ 1363.513247] PKRU: 55555554 
[ 1363.513247] Call Trace: 
[ 1363.513247]  dax_get_by_host+0x7c/0xd0 
[ 1363.513247]  __bdev_dax_supported+0x72/0x170 
[ 1363.513248]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513248]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513248]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513248]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513248]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513249]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513249]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513249]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513249]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513249]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513250]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513250]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513250]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513250]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513250]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513250]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513251]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513251]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513251]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513251]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513251]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513252]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513252]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513252]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513252]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513252]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513252]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513253]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513253]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513253]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513253]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513253]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513254]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513254]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513254]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513254]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513254]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513254]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513255]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513255]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513255]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513255]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513255]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513255]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513256]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513256]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513256]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513256]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513256]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513257]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513257]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513257]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513257]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513257]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513257]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513258]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513258]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513258]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513258]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513258]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513259]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513259]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513259]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513259]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513259]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513259]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513260]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513260]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513260]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513260]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513260]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513261]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513261]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513261]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513261]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513261]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513261]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513262]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513262]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513262]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513262]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513262]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513263]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513263]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513263]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513263]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513263]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513263]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513264]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513264]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513264]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513264]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513264]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513264]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513265]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513265]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513265]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513265]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513265]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513266]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513266]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513266]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513266]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513266]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513266]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513267]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513267]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513267]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513267]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513267]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513268]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513268]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513268]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513268]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513268]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513268]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513269]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513269]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513269]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513269]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513269]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513270]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513270]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513270]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513270]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513270]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513270]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513271]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513271]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513271]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513271]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513271]  ? drain_obj_stock.isra.71+0x60/0x80 
[ 1363.513272]  ? prep_new_page+0xb1/0xe0 
[ 1363.513272]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513272]  ? get_partial_node.isra.87.part.88+0x14c/0x260 
[ 1363.513272]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513272]  ? __mod_memcg_lruvec_state+0x21/0x100 
[ 1363.513273]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513273]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513273]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513273]  __generic_fsdax_supported+0x8c/0x500 
[ 1363.513273]  ? _cond_resched+0x15/0x30 
[ 1363.513273]  ? __kmalloc_node+0x4df/0x510 
[ 1363.513274]  ? crypto_create_tfm_node+0x3a/0xf0 
[ 1363.513274]  __bdev_dax_supported+0xd0/0x170 
[ 1363.513274]  ext4_fill_super+0x719/0x31c0 [ext4] 
[ 1363.513274]  ? bdev_name.isra.9+0x63/0xd0 
[ 1363.513274]  ? vsnprintf+0x37c/0x520 
[ 1363.513275]  ? ext4_calculate_overhead+0x490/0x490 [ext4] 
[ 1363.513275]  ? mount_bdev+0x185/0x1b0 
[ 1363.513275]  mount_bdev+0x185/0x1b0 
[ 1363.513275]  legacy_get_tree+0x27/0x40 
[ 1363.513275]  vfs_get_tree+0x25/0xb0 
[ 1363.513275]  path_mount+0x676/0x980 
[ 1363.513276]  do_mount+0x75/0x90 
[ 1363.513276]  __x64_sys_mount+0xc4/0xe0 
[ 1363.513276]  do_syscall_64+0x33/0x40 
[ 1363.513276]  entry_SYSCALL_64_after_hwframe+0x44/0xa9 
[ 1363.513276] RIP: 0033:0x7fbe9a85da8e 
[ 1363.513277] Code: 48 8b 0d fd f3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ca f3 2b 00 f7 d8 64 89 01 48 
[ 1363.513277] RSP: 002b:00007fffc4274d88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5 
[ 1363.513278] RAX: ffffffffffffffda RBX: 00005557f8a14460 RCX: 00007fbe9a85da8e 
[ 1363.513278] RDX: 00005557f8a14640 RSI: 00005557f8a14680 RDI: 00005557f8a14660 
[ 1363.513278] RBP: 00007fbe9b609184 R08: 0000000000000000 R09: 0000000000000003 
[ 1363.513278] R10: 00000000c0ed0000 R11: 0000000000000246 R12: 0000000000000000 
[ 1363.513279] R13: 00000000c0ed0000 R14: 00005557f8a14660 R15: 00005557f8a14640 
[ 1363.513279] Modules linked in: ext4 mbcache jbd2 rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache rfkill sunrpc vfat fat dm_multipath intel_rapl_msr intel_rapl_common isst_if_common skx_edac x86_pkg_temp_thermal intel_powerclamp ipmi_ssif coretemp kvm_intel mgag200 i2c_algo_bit kvm drm_kms_helper iTCO_wdt iTCO_vendor_support syscopyarea sysfillrect dcdbas sysimgblt fb_sys_fops irqbypass crct10dif_pclmul drm crc32_pclmul ghash_clmulni_intel acpi_ipmi rapl ipmi_si intel_cstate mei_me dell_smbios i2c_i801 ipmi_devintf dax_pmem_compat intel_uncore mei wmi_bmof dell_wmi_descripto 
[ 1363.513285] Lost 29 message(s)! 
[ 1364.493871] ---[ end trace d756ed97f26ed4e7 ]--- 
[ 1364.493872] RIP: 0010:igrab+0x14/0x50 
[ 1364.493872] Code: 62 07 8c 00 85 c0 74 c6 83 f8 01 75 cd eb cd 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 8d af 88 00 00 00 53 48 89 fb 48 89 ef <e8> 27 65 64 00 f6 83 98 00 00 00 30 75 17 f0 ff 83 58 01 00 00 48 
[ 1364.493873] RSP: 0018:ffffa700c0e0c000 EFLAGS: 00010246 
[ 1364.493873] RAX: 0000000000000000 RBX: ffff95b69e415a10 RCX: 0000000000000001 
[ 1364.493873] RDX: 0000000000000000 RSI: ffff95a946a406b8 RDI: ffff95b69e415a98 
[ 1364.493874] RBP: ffff95b69e415a98 R08: 0000000500000000 R09: 8080808080808080 
[ 1364.493874] R10: 0000000000000000 R11: fefefefefefefeff R12: 0000000000000001 
[ 1364.493874] R13: ffff95b69e415a00 R14: 0000000000000000 R15: ffff95b79f4d3800 
[ 1364.493874] FS:  00007fbe9b823080(0000) GS:ffff95b87ff80000(0000) knlGS:0000000000000000 
[ 1364.493875] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[ 1364.493875] CR2: ffffa700c0e0bff8 CR3: 0000000ffec46002 CR4: 00000000007706e0 
[ 1364.493875] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
[ 1364.493875] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 
[ 1364.493875] PKRU: 55555554 
[ 1364.493876] Kernel panic - not syncing: Fatal exception in interrupt 
[ 1364.979497] Kernel Offset: 0x12600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff) 

Best Regards,
  Yi Zhang

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
