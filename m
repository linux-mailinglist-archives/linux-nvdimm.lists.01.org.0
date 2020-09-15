Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DD626A057
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 10:03:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 72CB7140DFB68;
	Tue, 15 Sep 2020 01:03:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.219.246.4; helo=mail1.bemta23.messagelabs.com; envelope-from=ahuang12@lenovo.com; receiver=<UNKNOWN> 
Received: from mail1.bemta23.messagelabs.com (mail1.bemta23.messagelabs.com [67.219.246.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AEDDA140CEB87
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 01:03:21 -0700 (PDT)
Received: from [100.112.3.165] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
	by server-4.bemta.az-b.us-east-1.aws.symcld.net id 33/A1-07118-845706F5; Tue, 15 Sep 2020 08:03:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTbUxbZRTHee69bS+EOy4tGw8EFm02N+taW9h
  YMzTKFrUuIEv2xWFIuZVCO/uCvSV007gRVjfHizAzwZbSQhGkzvEqOmFrgskyUFI222EHWybb
  3Hgx4ChiFJi93G7qt9///P/POefDeXCU/zs3GVdbzGqTgdIJuTFY8eYZrvi10gKl1DMpkteX+
  3jy+rNjQH4lWM6Ve+/dx+T3291AXlE3wZPXnQog8srVLp78w+4lIL9Rexl5OUZxwXaTp3APTi
  OKSvsappi/FOAqOvsCmKL3h/cOcPM4WoPKaCngaJrmv8ZKmoUWV3cQHAdzKadBDM4nHwHYW9X
  KZcUDAFt9jQgrrAj0j3UAVqwAeK/qAYcRgPwchQPf/YGy4jIGV5oaIqILwMq/FtffYOQACvt+
  +hFjGzQhcLRqLtLtDoC2q5NhgeNcUgRHe6jTIBpPIM8AOLv6BpNByRCA593DPEYIyHMAXvJOo
  GzqKwBv+WmW0+Bo6OJ6HSO3Qm/3zzymKUEWwMHbO5kyn8yDyxPjgOFo8i3Y0F++HgfkJrg8cg
  5hGCUT4Y27znWGJAlbB30oyxvh9J01DpuvAvDvRi5bz4TtC1cinAqvOSsByzmwwlYRYRG8VV3
  BYfkd2FhrxVh+BvrKxyNvN0NP9S9YLUiz/WcNlndA18BDLsvPwbbmWZRhgoyHw5/dxVwA84AM
  lUlbrDHrKa1OLJNKxTJZmjhNLEvfJaGOilWSUlqspmizWCahymgJfUT/tq5QYlCbe0D47gpLk
  JPfAuvcgmQIJOGIcCORlFeg5G9QGQuPaChaozSV6tT0EEjBcSEk2uiwF29SF6stRVpd+Hof2x
  CPFSYQNYxN0CWUntYWs9YISMdrpx0tKF53svxLlI8ZjAZ1ciIRbw5HSSaqKTU8afT4J1wDqck
  CAkRFRfFjS9Qmvdb8f38GJOJAKCBSmYGxWoP5ybyZ8CpIeJWDgnxmFTP1r5V8HKF2TRmfXzJ+
  cTTL78Dqs0/YWseWRn5TnomN8p1q84sygsGiTYfcZQVbBI6s3dLujn3pr/RHxwn9qra4kNfZ0
  J/Tv/PX24uuZ0NFze75FOkeR1N13dTrnSfwF7/Znp/kiduXfWwudz/agWbkPtzfonR3vVCoV4
  woryeEnJN7Z4O9n/JC3lQZ38VxTWW+9H378gHols2PW53EwZxsR35AJoh2WWqeNm7DVC0uw4U
  hasC4W1GS2fznB3Z/TGxWtP3QU4d7+t7NPd9bR7559pH9qut6hlV3c/rjDdtq8lfHVlqzeXve
  X7ALPcRHwYGLicde3ZEwvPcw+cli5/altbJAXJcQozWUTISaaOof1Hq2joQEAAA=
X-Env-Sender: ahuang12@lenovo.com
X-Msg-Ref: server-17.tower-396.messagelabs.com!1600156996!411649!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3456 invoked from network); 15 Sep 2020 08:03:19 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-17.tower-396.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Sep 2020 08:03:19 -0000
Received: from reswpmail03.lenovo.com (unknown [10.62.32.22])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Forcepoint Email with ESMTPS id 6A73994203562D8F932E;
	Tue, 15 Sep 2020 16:03:14 +0800 (CST)
Received: from reswpmail01.lenovo.com (10.62.32.20) by reswpmail03.lenovo.com
 (10.62.32.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 15 Sep
 2020 04:03:12 -0400
Received: from va32wusexedge02.lenovo.com (10.62.123.117) by
 reswpmail01.lenovo.com (10.62.32.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4
 via Frontend Transport; Tue, 15 Sep 2020 04:03:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.125.52)
 by mail.lenovo.com (10.62.123.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Tue, 15 Sep 2020 16:03:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3LfENHeqR8CEm36KTyjzXR7MeuT32aXis3ttI0NPnUSr0w6O367Fe1MBP1Jjiffol4zJ3exk3T7uYBfllnMn/MgKhIimPFWNeltJGdMyEjwTLmDrypJQu2y/ZaGBuz6g37uVTLK7lBZr3FCAfgwt+vPbsktJd0B1kNahvgTvZJIBGuL2UiPR9jw6x7QfWJHHxTpieLnlBRFCUwvYndawDT7IZl1aYFeJXmHMpZhDVbDzB2mitCuftSF9PpZHQ2ss6112ArWo4DqrYD5DMVSJeHMWuyqxrWLMi5x0caBH78XoP6aRJE2Npytt42P6gHJ6kx7mrGBdguIf8JhbOWmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFIYpAYdEuVZGNMs9iFfJcmsSlFcAex09OfOBSbsWdg=;
 b=kqv0grrTeXZStOyWVOj9uAOX/FT+k/AR0D4VjUAv6ScfASNxlWuGFn2i6RusDAKipJCXovCww3yIzjecRdWVmC/wDTGhfuu5ad5KwxZBA/3GXqNaSt0LqVBLjExC5FHT28U2uVZTqzjLaon3M4Y8G/C5XbgZzH7XjQtB7JRNXi4i8phR9aaxLtkYfQjuLk35IgxjVB3909QFpVDEzdAbwxm87WtGEzjCHcfTL2RlKdHvxw7ErPE2UB9JLysV5HBVuy/swTamf2zp6F/u5tDy0MAzwLEvotZeSDLqzwWewhLeguVvOabI8wDv1/R2ZS4xE646FvzkdRmZLNnMsvMAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFIYpAYdEuVZGNMs9iFfJcmsSlFcAex09OfOBSbsWdg=;
 b=RJo/om/74jAovCpINVBnUAORWHbbcP8ERCMtE9hEzULXt2YAzpbbdGvLzVPmB5a2v0jrjr6zDXmxHvHzU2QBirsWV1I4Z8WJksOP3sb+hCs60VR/KuBLN5o6Sd+nUPpo8Si+B/1C4F2CBji59ss4dXlffn+X0SHN08gE3qRFNro=
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com (2603:1096:202:c::8)
 by HK0PR03MB3058.apcprd03.prod.outlook.com (2603:1096:203:4b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5; Tue, 15 Sep
 2020 08:03:09 +0000
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164]) by HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164%7]) with mapi id 15.20.3391.009; Tue, 15 Sep 2020
 08:03:09 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Coly Li <colyli@suse.de>, "Dan
 Williams" <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: RE: [External]  regression caused by patch
 6180bb446ab624b9ab8bf201ed251ca87f07b413 ("dax: fix detection of dax support
 for non-persistent memory block devices")
Thread-Topic: [External]  regression caused by patch
 6180bb446ab624b9ab8bf201ed251ca87f07b413 ("dax: fix detection of dax support
 for non-persistent memory block devices")
Thread-Index: AQHWiq6a3lQ9jLTgFkS8+OwP/ESjwalpVzIA
Date: Tue, 15 Sep 2020 08:03:09 +0000
Message-ID: <HK2PR0302MB259490E9D3F212396ACD0109B3200@HK2PR0302MB2594.apcprd03.prod.outlook.com>
References: <alpine.LRH.2.02.2009141131220.30651@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009141131220.30651@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:b011:e002:f5de:1462:81a7:657b:8410]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3176beb6-fdcc-4198-ea1d-08d8594dc96b
x-ms-traffictypediagnostic: HK0PR03MB3058:
x-microsoft-antispam-prvs: <HK0PR03MB3058C2A497E55E4EC3FD90D8B3200@HK0PR03MB3058.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7+m0gg90PjIIl16PRfM9svN2tjLd96CukIKMUwOqiTrd91pgnXd5yiAxHsrcPQwh0j7KLUZgiAMmBsuFe/zG/9J1j+l+iIWw6beIMSvjmASKeRyGYBS/vISd8lhzU98sjw5yR0vjDkNWK5T4eYXcTUrL3umZFUPwq3ZnwbRI9WOS31+E88urLRj0SjGfSvSXSvDXJUMemmDQ1JZTghS5oYW3UNCxtkds+cyqXwzMBNs0J2osn0BO1Q5heBRphZ+ae20L6nib6M1FxLFWt+efO5JczpkhAT6s2Op4jaPQRSE2NQulo7CoTxyyGaUBSeqnkB7mkxQHRH2NNo6HQSk/+RG861Bj/ouMwGmLTscWbJBPIAUCVWPe7i01v1BJvpBVW73IqSmi/qH01ab8w/RGpllq3ew3AR8pQ9mWTbkueIiY5hPMYc1CfkFlFkG9Kkau
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR0302MB2594.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(83380400001)(76116006)(66946007)(4326008)(7696005)(86362001)(2906002)(71200400001)(186003)(966005)(6506007)(9686003)(8676002)(66556008)(55016002)(64756008)(66446008)(52536014)(316002)(66476007)(53546011)(45080400002)(5660300002)(7416002)(8936002)(110136005)(478600001)(33656002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mgWi0m24jkadSXhcCGOtNfLKNl7g2OlUWcOdSafkmhnJtnGhGuKvW1UMxktVtBx9k7kBrEO8Z3gH3c3pIsT+lycuByB6qMThpp2UCgff8yWbDNgeJaNs7a5It9zPJdhsagihMxNHso8yiV29d/iVwKiNfO3MQuk0TRAPXzOC/PY9ppYy5bSLTPn7YaH0++QtRQ7ei9qE0fGfjBcQk39ua4/QIPsasSmDdTWRzxV56P8/2ZY7svY0l4v3JdhzrDG4mBdb54j1xaMmbXvbUZ0Rlxc6zY0ABca+ZxTImmuuJivYK+hh9hFi8CKdFt+p6y3KfcLci4Gn9RRTpkQffnhmQMGhoZxL3qiFJ2VNGtnQfc6Lt/nz+LU6GqHAyVuy26c1PQlSnPlOW/u0wBqwTNGbq4sO2MdlvaJTOVmkTucPS9Rzab+8M9QdcJYXY6jEgy628dPL3svMhi7LMpXUlyJVDWXd0ukwuno2VDRMHHzQZJtM7ZGW/aJl+z+CJAUOsqb9WNoYibZoo5w98kOtwSjQkteBCFpEOZAsvM5DvkkCPP7iv8zmyf+p6i0IIPWxx2a4VrXh5jQmxR04rWI+6HCLN2iFgKHNETu4ti2z1iPZvvQBRLu37ojU/3n0DO5NjsZfbFaRRUIEsdx+KcmRW98tf4WIqRYNKfiRju0K2R3pqOJ9HZw+eECzJVAH8Cz1yqoxwrqMnYTAvmHX4qumbrr6zQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR0302MB2594.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3176beb6-fdcc-4198-ea1d-08d8594dc96b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 08:03:09.8782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUwIyh8Bg+uv461lktx3t2piQ4TvirmNmweqn/5tKaJvzy2URWVq88FhPkrZxByVZSHQrjCt6qfoW4bbQ913Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3058
X-OriginatorOrg: lenovo.com
Message-ID-Hash: 75OM4HAKUSGL6GICYAUHUUJHH5MXUW74
X-Message-ID-Hash: 75OM4HAKUSGL6GICYAUHUUJHH5MXUW74
X-MailFrom: ahuang12@lenovo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.com>, "Ira Weiny  <ira.weiny@intel.com>, Mike Snitzer <snitzer@redhat.com>, Pankaj Gupta" <pankaj.gupta.linux@gmail.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/75OM4HAKUSGL6GICYAUHUUJHH5MXUW74/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

Hi Mikulas,

> -----Original Message-----
> From: Mikulas Patocka <mpatocka@redhat.com>
> Sent: Monday, September 14, 2020 11:49 PM
> To: Coly Li <colyli@suse.de>; Dan Williams <dan.j.williams@intel.com>; Dave
> Jiang <dave.jiang@intel.com>
> Cc: Jan Kara <jack@suse.com>; Vishal Verma <vishal.l.verma@intel.com>;
> Adrian Huang12 <ahuang12@lenovo.com>; Ira Weiny <ira.weiny@intel.com>;
> Mike Snitzer <snitzer@redhat.com>; Pankaj Gupta
> <pankaj.gupta.linux@gmail.com>; linux-nvdimm@lists.01.org
> Subject: [External] regression caused by patch
> 6180bb446ab624b9ab8bf201ed251ca87f07b413 ("dax: fix detection of dax
> support for non-persistent memory block devices")
> 
> Hi
> 
> The patch 6180bb446ab624b9ab8bf201ed251ca87f07b413 ("dax: fix
> detection of dax support for non-persistent memory block devices") causes
> crash when attempting to mount the ext4 filesystem on /dev/pmem0
> ("mkfs.ext4 /dev/pmem0; mount -t ext4 /dev/pmem0 /mnt/test"). The device
> /dev/pmem0 is emulated using the "memmap" kernel parameter.
> 

Could you please test the following patch? Thanks.
https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/2JDBSE2WK75LSGCFEOY3RXRN3CNLBPB2/

 > The patch causes infinite recursion and double-fault exception:
> 
> __generic_fsdax_supported
> bdev_dax_supported
> __bdev_dax_supported
> dax_supported
> dax_dev->ops->dax_supported
> generic_fsdax_supported
> __generic_fsdax_supported
> 
> Mikulas
> 
> 
> 
> [   17.500619] traps: PANIC: double fault, error_code: 0x0
> [   17.500619] double fault: 0000 [#1] PREEMPT SMP
> [   17.500620] CPU: 0 PID: 1326 Comm: mount Not tainted 5.9.0-rc1-bisect #10
> [   17.500620] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [   17.500621] RIP: 0010:__generic_fsdax_supported+0x6a/0x500
> [   17.500622] Code: ff ff ff ff ff 7f 00 48 21 f3 48 01 c3 48 c1 e3 09 f6 c7 0e 0f
> 85 fa 01 00 00 48 85 ff 49 89 fd 74 11 be 00 10 00 00 4c 89 e7 <e8> b1 fe ff ff
> 84 c0 75 11 31 c0 48 83 c4 48 5b 5d 41 5c 41 5d 41
> [   17.500623] RSP: 0018:ffff88940b4fdff8 EFLAGS: 00010286
> [   17.500624] RAX: 0000000000000000 RBX: 00000007fffff000 RCX:
> 0000000000000000
> [   17.500625] RDX: 0000000000001000 RSI: 0000000000001000 RDI:
> ffff88940b34c300
> [   17.500625] RBP: 0000000000000000 R08: 0000000004000000 R09:
> 8080808080808080
> [   17.500626] R10: 0000000000000000 R11: fefefefefefefeff R12:
> ffff88940b34c300
> [   17.500626] R13: ffff88940b3dc000 R14: ffff88940badd000 R15:
> 0000000000000001
> [   17.500627] FS:  00000000f7c25780(0000) GS:ffff88940fa00000(0000)
> knlGS:0000000000000000
> [   17.500628] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [   17.500628] CR2: ffff88940b4fdfe8 CR3: 000000140bd15000 CR4:
> 00000000000006b0
> [   17.500628] Call Trace:
> [   17.500629] Modules linked in: uvesafb cfbfillrect cfbimgblt cn cfbcopyarea fb
> fbdev ipv6 tun autofs4 binfmt_misc configfs af_packet virtio_rng rng_core
> mousedev evdev pcspkr virtio_balloon button raid10 raid456 async_raid6_recov
> async_memcpy async_pq raid6_pq async_xor xor async_tx libcrc32c raid1 raid0
> md_mod sd_mod t10_pi virtio_scsi virtio_net net_failover psmouse scsi_mod
> failover
> [   17.500638] ---[ end trace 3c877fcb5b865459 ]---
> [   17.500638] RIP: 0010:__generic_fsdax_supported+0x6a/0x500
> [   17.500639] Code: ff ff ff ff ff 7f 00 48 21 f3 48 01 c3 48 c1 e3 09 f6 c7 0e 0f
> 85 fa 01 00 00 48 85 ff 49 89 fd 74 11 be 00 10 00 00 4c 89 e7 <e8> b1 fe ff ff
> 84 c0 75 11 31 c0 48 83 c4 48 5b 5d 41 5c 41 5d 41
> [   17.500640] RSP: 0018:ffff88940b4fdff8 EFLAGS: 00010286
> [   17.500641] RAX: 0000000000000000 RBX: 00000007fffff000 RCX:
> 0000000000000000
> [   17.500641] RDX: 0000000000001000 RSI: 0000000000001000 RDI:
> ffff88940b34c300
> [   17.500642] RBP: 0000000000000000 R08: 0000000004000000 R09:
> 8080808080808080
> [   17.500642] R10: 0000000000000000 R11: fefefefefefefeff R12:
> ffff88940b34c300
> [   17.500643] R13: ffff88940b3dc000 R14: ffff88940badd000 R15:
> 0000000000000001
> [   17.500643] FS:  00000000f7c25780(0000) GS:ffff88940fa00000(0000)
> knlGS:0000000000000000
> [   17.500644] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [   17.500644] CR2: ffff88940b4fdfe8 CR3: 000000140bd15000 CR4:
> 00000000000006b0
> [   17.500645] Kernel panic - not syncing: Fatal exception in interrupt
> [   17.500941] Kernel Offset: disabled
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
