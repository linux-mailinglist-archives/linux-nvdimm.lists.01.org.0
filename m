Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 113AE26E29A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Sep 2020 19:39:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5860814DF56E9;
	Thu, 17 Sep 2020 10:38:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DA79914869C92
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 10:38:56 -0700 (PDT)
IronPort-SDR: mvhU3c1zusCNqvj1d3w+8wTpTSTGcxIt+8zVlMA0ACWmL4O9Fm1/W4mZUTZNcmOYk0/I00ehDD
 Gx31szpaSwPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="147442947"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400";
   d="scan'208";a="147442947"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 10:38:55 -0700
IronPort-SDR: wSWG46GDWBAqDeKFTMfuEC+gbyYB0kYV9V6HET2iOSSdeUmfpg1adrqZ+g6+zD8R5ZboaEWHz/
 8uzoRK72PGAQ==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400";
   d="scan'208";a="508522402"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 10:38:55 -0700
Date: Thu, 17 Sep 2020 10:38:54 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Yi Zhang <yi.zhang@redhat.com>
Subject: Re: regression on 5.9.0-rc5: mount fsdax w/o dax lead kernel panic
Message-ID: <20200917173854.GB2541163@iweiny-DESK2.sc.intel.com>
References: <1420999447.1004543.1600055488770.JavaMail.zimbra@redhat.com>
 <6380e13d-09b8-0d15-e3ed-bd95dfd370e4@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6380e13d-09b8-0d15-e3ed-bd95dfd370e4@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: A37543K6GHR4GE4SR2OUVR6XTF5VSHZN
X-Message-ID-Hash: A37543K6GHR4GE4SR2OUVR6XTF5VSHZN
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: colyli@suse.de, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A37543K6GHR4GE4SR2OUVR6XTF5VSHZN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 02:48:12PM +0800, Yi Zhang wrote:
>=20
> I check the commit, seems it was introduced with bellow commit:
>=20
> commit 6180bb446ab624b9ab8bf201ed251ca87f07b413
> Author: Coly Li <colyli@suse.de>
> Date:=A0=A0 Fri Sep 4 00:16:25 2020 +0800
>=20
> =A0=A0=A0 dax: fix detection of dax support for non-persistent memory blo=
ck
> devices
>

This is being fixed with a couple of patches.

https://lore.kernel.org/linux-nvdimm/20200917104216.GB16097@quack2.suse.cz/

Ira

>
>=20
>=20
> On 9/14/20 11:51 AM, Yi Zhang wrote:
> > Hi
> >=20
> > Could you help check this regression, let me know if you need more info=
/testing, thanks.
> >=20
> > Reproducer:
> > # ndctl create-namespace -f -e namespace1.0 -m fsdax
> > {
> >    "dev":"namespace1.0",
> >    "mode":"fsdax",
> >    "map":"dev",
> >    "size":"15.75 GiB (16.91 GB)",
> >    "uuid":"069a6b5c-917e-4c6c-a277-01fd8574ccb3",
> >    "sector_size":512,
> >    "align":2097152,
> >    "blockdev":"pmem1"
> > }
> > # mkfs.ext4 /dev/pmem1
> > # mount /dev/pmem1 /mnt ---> panic here
> >=20
> >=20
> > kernel log:
> > [ 1363.513242] BUG: stack guard page was hit at 00000000118cab51 (stack=
 is 00000000548b8b77..000000005363ed26)
> > [ 1363.513242] kernel stack overflow (double-fault): 0000 [#1] SMP NOPTI
> > [ 1363.513243] CPU: 22 PID: 14682 Comm: mount Tainted: G S        I    =
   5.9.0-rc5 #1
> > [ 1363.513243] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.8=
.1 06/26/2020
> > [ 1363.513243] RIP: 0010:igrab+0x14/0x50
> > [ 1363.513244] Code: 62 07 8c 00 85 c0 74 c6 83 f8 01 75 cd eb cd 0f 1f=
 80 00 00 00 00 0f 1f 44 00 00 55 48 8d af 88 00 00 00 53 48 89 fb 48 89 ef=
 <e8> 27 65 64 00 f6 83 98 00 00 00 30 75 17 f0 ff 83 58 01 00 00 48
> > [ 1363.513244] RSP: 0018:ffffa700c0e0c000 EFLAGS: 00010246
> > [ 1363.513245] RAX: 0000000000000000 RBX: ffff95b69e415a10 RCX: 0000000=
000000001
> > [ 1363.513245] RDX: 0000000000000000 RSI: ffff95a946a406b8 RDI: ffff95b=
69e415a98
> > [ 1363.513245] RBP: ffff95b69e415a98 R08: 0000000500000000 R09: 8080808=
080808080
> > [ 1363.513245] R10: 0000000000000000 R11: fefefefefefefeff R12: 0000000=
000000001
> > [ 1363.513246] R13: ffff95b69e415a00 R14: 0000000000000000 R15: ffff95b=
79f4d3800
> > [ 1363.513246] FS:  00007fbe9b823080(0000) GS:ffff95b87ff80000(0000) kn=
lGS:0000000000000000
> > [ 1363.513246] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1363.513246] CR2: ffffa700c0e0bff8 CR3: 0000000ffec46002 CR4: 0000000=
0007706e0
> > [ 1363.513247] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [ 1363.513247] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [ 1363.513247] PKRU: 55555554
> > [ 1363.513247] Call Trace:
> > [ 1363.513247]  dax_get_by_host+0x7c/0xd0
> > [ 1363.513247]  __bdev_dax_supported+0x72/0x170
> > [ 1363.513248]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513248]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513248]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513248]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513248]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513249]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513249]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513249]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513249]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513249]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513250]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513250]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513250]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513250]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513250]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513250]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513251]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513251]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513251]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513251]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513251]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513252]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513252]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513252]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513252]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513252]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513252]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513253]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513253]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513253]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513253]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513253]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513254]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513254]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513254]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513254]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513254]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513254]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513255]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513255]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513255]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513255]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513255]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513255]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513256]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513256]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513256]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513256]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513256]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513257]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513257]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513257]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513257]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513257]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513257]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513258]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513258]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513258]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513258]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513258]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513259]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513259]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513259]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513259]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513259]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513259]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513260]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513260]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513260]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513260]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513260]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513261]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513261]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513261]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513261]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513261]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513261]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513262]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513262]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513262]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513262]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513262]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513263]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513263]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513263]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513263]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513263]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513263]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513264]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513264]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513264]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513264]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513264]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513264]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513265]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513265]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513265]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513265]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513265]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513266]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513266]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513266]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513266]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513266]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513266]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513267]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513267]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513267]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513267]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513267]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513268]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513268]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513268]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513268]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513268]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513268]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513269]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513269]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513269]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513269]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513269]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513270]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513270]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513270]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513270]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513270]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513270]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513271]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513271]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513271]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513271]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513271]  ? drain_obj_stock.isra.71+0x60/0x80
> > [ 1363.513272]  ? prep_new_page+0xb1/0xe0
> > [ 1363.513272]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513272]  ? get_partial_node.isra.87.part.88+0x14c/0x260
> > [ 1363.513272]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513272]  ? __mod_memcg_lruvec_state+0x21/0x100
> > [ 1363.513273]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513273]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513273]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513273]  __generic_fsdax_supported+0x8c/0x500
> > [ 1363.513273]  ? _cond_resched+0x15/0x30
> > [ 1363.513273]  ? __kmalloc_node+0x4df/0x510
> > [ 1363.513274]  ? crypto_create_tfm_node+0x3a/0xf0
> > [ 1363.513274]  __bdev_dax_supported+0xd0/0x170
> > [ 1363.513274]  ext4_fill_super+0x719/0x31c0 [ext4]
> > [ 1363.513274]  ? bdev_name.isra.9+0x63/0xd0
> > [ 1363.513274]  ? vsnprintf+0x37c/0x520
> > [ 1363.513275]  ? ext4_calculate_overhead+0x490/0x490 [ext4]
> > [ 1363.513275]  ? mount_bdev+0x185/0x1b0
> > [ 1363.513275]  mount_bdev+0x185/0x1b0
> > [ 1363.513275]  legacy_get_tree+0x27/0x40
> > [ 1363.513275]  vfs_get_tree+0x25/0xb0
> > [ 1363.513275]  path_mount+0x676/0x980
> > [ 1363.513276]  do_mount+0x75/0x90
> > [ 1363.513276]  __x64_sys_mount+0xc4/0xe0
> > [ 1363.513276]  do_syscall_64+0x33/0x40
> > [ 1363.513276]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [ 1363.513276] RIP: 0033:0x7fbe9a85da8e
> > [ 1363.513277] Code: 48 8b 0d fd f3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3=
 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ca f3 2b 00 f7 d8 64 89 01 48
> > [ 1363.513277] RSP: 002b:00007fffc4274d88 EFLAGS: 00000246 ORIG_RAX: 00=
000000000000a5
> > [ 1363.513278] RAX: ffffffffffffffda RBX: 00005557f8a14460 RCX: 00007fb=
e9a85da8e
> > [ 1363.513278] RDX: 00005557f8a14640 RSI: 00005557f8a14680 RDI: 0000555=
7f8a14660
> > [ 1363.513278] RBP: 00007fbe9b609184 R08: 0000000000000000 R09: 0000000=
000000003
> > [ 1363.513278] R10: 00000000c0ed0000 R11: 0000000000000246 R12: 0000000=
000000000
> > [ 1363.513279] R13: 00000000c0ed0000 R14: 00005557f8a14660 R15: 0000555=
7f8a14640
> > [ 1363.513279] Modules linked in: ext4 mbcache jbd2 rpcsec_gss_krb5 aut=
h_rpcgss nfsv4 dns_resolver nfs lockd grace fscache rfkill sunrpc vfat fat =
dm_multipath intel_rapl_msr intel_rapl_common isst_if_common skx_edac x86_p=
kg_temp_thermal intel_powerclamp ipmi_ssif coretemp kvm_intel mgag200 i2c_a=
lgo_bit kvm drm_kms_helper iTCO_wdt iTCO_vendor_support syscopyarea sysfill=
rect dcdbas sysimgblt fb_sys_fops irqbypass crct10dif_pclmul drm crc32_pclm=
ul ghash_clmulni_intel acpi_ipmi rapl ipmi_si intel_cstate mei_me dell_smbi=
os i2c_i801 ipmi_devintf dax_pmem_compat intel_uncore mei wmi_bmof dell_wmi=
_descripto
> > [ 1363.513285] Lost 29 message(s)!
> > [ 1364.493871] ---[ end trace d756ed97f26ed4e7 ]---
> > [ 1364.493872] RIP: 0010:igrab+0x14/0x50
> > [ 1364.493872] Code: 62 07 8c 00 85 c0 74 c6 83 f8 01 75 cd eb cd 0f 1f=
 80 00 00 00 00 0f 1f 44 00 00 55 48 8d af 88 00 00 00 53 48 89 fb 48 89 ef=
 <e8> 27 65 64 00 f6 83 98 00 00 00 30 75 17 f0 ff 83 58 01 00 00 48
> > [ 1364.493873] RSP: 0018:ffffa700c0e0c000 EFLAGS: 00010246
> > [ 1364.493873] RAX: 0000000000000000 RBX: ffff95b69e415a10 RCX: 0000000=
000000001
> > [ 1364.493873] RDX: 0000000000000000 RSI: ffff95a946a406b8 RDI: ffff95b=
69e415a98
> > [ 1364.493874] RBP: ffff95b69e415a98 R08: 0000000500000000 R09: 8080808=
080808080
> > [ 1364.493874] R10: 0000000000000000 R11: fefefefefefefeff R12: 0000000=
000000001
> > [ 1364.493874] R13: ffff95b69e415a00 R14: 0000000000000000 R15: ffff95b=
79f4d3800
> > [ 1364.493874] FS:  00007fbe9b823080(0000) GS:ffff95b87ff80000(0000) kn=
lGS:0000000000000000
> > [ 1364.493875] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1364.493875] CR2: ffffa700c0e0bff8 CR3: 0000000ffec46002 CR4: 0000000=
0007706e0
> > [ 1364.493875] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [ 1364.493875] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [ 1364.493875] PKRU: 55555554
> > [ 1364.493876] Kernel panic - not syncing: Fatal exception in interrupt
> > [ 1364.979497] Kernel Offset: 0x12600000 from 0xffffffff81000000 (reloc=
ation range: 0xffffffff80000000-0xffffffffbfffffff)
> >=20
> > Best Regards,
> >    Yi Zhang
> >=20
> > _______________________________________________
> > Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> > To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
> >=20
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
