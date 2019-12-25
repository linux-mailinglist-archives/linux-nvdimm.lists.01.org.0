Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8023F12A6AB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Dec 2019 09:17:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8EEEE1011369E;
	Wed, 25 Dec 2019 00:21:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.13.53; helo=eur01-he1-obe.outbound.protection.outlook.com; envelope-from=justin.he@arm.com; receiver=<UNKNOWN> 
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130053.outbound.protection.outlook.com [40.107.13.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 259BA10113695
	for <linux-nvdimm@lists.01.org>; Wed, 25 Dec 2019 00:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8w6s+ScEcdun3DcCqd3xcDgeHYX6xZh0vG8DNnkUAs=;
 b=wtjetIzCXFDZHhUFyQ7R87Z85n5SahWwFNecNRXWf1J3u/+maITp6GSgzkP/5Xu5P0XCInEgf4cDlR3T0OJi2tspw+EkHHbv+rMSpKKHq+k+7KqCxR+AmtjE5+RmtveuN03gapLCUPlomkY/79rk5mLajnToJ//WP6lA6Kdt1/w=
Received: from VI1PR08CA0133.eurprd08.prod.outlook.com (2603:10a6:800:d5::11)
 by AM0PR08MB4964.eurprd08.prod.outlook.com (2603:10a6:208:157::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.15; Wed, 25 Dec
 2019 08:17:37 +0000
Received: from DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by VI1PR08CA0133.outlook.office365.com
 (2603:10a6:800:d5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Wed, 25 Dec 2019 08:17:37 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.01.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;lists.01.org; dmarc=bestguesspass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT033.mail.protection.outlook.com (10.152.20.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11 via Frontend Transport; Wed, 25 Dec 2019 08:17:36 +0000
Received: ("Tessian outbound e09e55c05044:v40"); Wed, 25 Dec 2019 08:17:36 +0000
X-CR-MTA-TID: 64aa7808
Received: from 5c2acb3c9853.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 302509E3-C788-4B2D-8461-98EC765132E4.1;
	Wed, 25 Dec 2019 08:17:31 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5c2acb3c9853.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 25 Dec 2019 08:17:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWiQ7KF1IqUTyB5uyuvXdSMa9bigZkUwOZyg8/zmrnA9kEKb8tQUIMXvzpXKahMyTusH1fgXIS+58Utowu1PgFJ8EL7UtDkqLKGv38l9EDL08FenN8NS4i29deeI12KGygYparC9UPnn97RqAdOT5hVs0tp3DtwcTl5AlfZaeyMCsTcoZH0U+WGd4gJMxaRMg7z99jLYu8jqbkZkcZSSZqr8hPTmpBu/eS08/7Btg2NaI29V0q8/3kFwxw4WoY2bevUKxku9PxYDsN572RQJhlF41hrzBaq3qOw8zwhI91J4z+fB1tRfHNrb6wZ30mF/Bi11H9wYZtuZjBV5fjNOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZV5IlF9OtSccZ9PeYMRYlJ/vUhwHTwsNF4YL1n+7+I=;
 b=ajPPQjeCzyGOPxfsdlOxwN3sWOrzVwBpkYrpi96xraw5Z0A8G/4pO9ynwIjduV+J4b3jro0VL8OchZt2MvqyxeWJAbQf7YDVzXv8bRUoZIKH5WygFatFU2kXtTTcj1JIu71KK1qwatSHCNeu2FTBnQu0maojWYxEZkOPLk6q92CMRbk6+9lb9BwQR95zEvTHFzoU8R8aNL1CXjctaXyAvWRR7h6iODMED37gvF+ehOg7P48sZeqHG116HldtDozaOIcsATtL7IKD5VD84kCZU7javUdrnWV6D8Pb9/MwyFLKMNzF8K+Ip+hlmzXIpn0eKYglInQP7IrcQew62YifMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZV5IlF9OtSccZ9PeYMRYlJ/vUhwHTwsNF4YL1n+7+I=;
 b=yAUhugDT2ficpJaWvq3+EK9hxsTWE/7shKytxCv4IorfpfCDWTnhwGqitDLKJpIywg/WfKBvT8sOiIEFmLw0JH+x3moYxJx+e41UzZMjWfkMEErYzWTXQ6bPbRGRSrXrQsbakWbkirHp3hiDaNFpb7w3UrJNR93jBziCOIckH70=
Received: from VE1PR08MB4639.eurprd08.prod.outlook.com (10.255.112.205) by
 VE1PR08MB5247.eurprd08.prod.outlook.com (20.179.31.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Wed, 25 Dec 2019 08:17:30 +0000
Received: from VE1PR08MB4639.eurprd08.prod.outlook.com
 ([fe80::c9ee:3f89:c4ac:416]) by VE1PR08MB4639.eurprd08.prod.outlook.com
 ([fe80::c9ee:3f89:c4ac:416%7]) with mapi id 15.20.2581.007; Wed, 25 Dec 2019
 08:17:29 +0000
From: Justin He <Justin.He@arm.com>
To: Murphy Zhou <jencce.kernel@gmail.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: RE: [PATCH] mm: get rid of WARN if failed to cow user pages
Thread-Topic: [PATCH] mm: get rid of WARN if failed to cow user pages
Thread-Index: AQHVuuYfWVnxzT4aNEiMQFaNzdeHAqfKfu3Q
Date: Wed, 25 Dec 2019 08:17:29 +0000
Message-ID: 
 <VE1PR08MB46390C98EBC3FE58A0132B86F7280@VE1PR08MB4639.eurprd08.prod.outlook.com>
References: <20191225054227.gii6ctjkuddjnprs@xzhoux.usersys.redhat.com>
In-Reply-To: <20191225054227.gii6ctjkuddjnprs@xzhoux.usersys.redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 9c42031a-2324-4f76-85bb-1104b7557086.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com;
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05e93148-fe67-44c0-75e4-08d78912e6b6
X-MS-TrafficTypeDiagnostic: VE1PR08MB5247:|AM0PR08MB4964:
X-Microsoft-Antispam-PRVS: 
	<AM0PR08MB49643E298E6C69941238857EF7280@AM0PR08MB4964.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 02622CEF0A
X-Forefront-Antispam-Report-Untrusted: 
 SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(13464003)(478600001)(45080400002)(316002)(71200400001)(33656002)(966005)(186003)(7696005)(5660300002)(55236004)(55016002)(86362001)(9686003)(66476007)(66946007)(76116006)(8936002)(81156014)(81166006)(26005)(66556008)(66446008)(64756008)(110136005)(6506007)(52536014)(53546011)(8676002)(2906002)(26583001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5247;H:VE1PR08MB4639.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 8MTd2M/Q2phMcxKO3+pPdGviEahgQxNZotKIbLpHAbziY21fUm/NsWOODBO47FoyZTALuBuskrFlzKokBsCsH4uLY5Cd/Wmfes/3BteJQ/t8xFGNoa9O+oR8rEZmpCus2/y97YQ359QVDVEYj52XJiBCPFz/tPkx2xa5/BeLpi3xU7XcaePav92/qOqdqthhb4SqyY/EGpqYFysRxfnf0BlmvV8wvTRY/jfChh1TzqGvCH6zLF0ZU1iK3uyfF6xsj2XRH8oQwKaxQI6mczpYBdBZVtWz12+89oH7IVJxqKqY/LzMxIBgPQQgm+YWk69DRrBz/0kXA0NUbeeoh4+E2gfY6J32Y03jrVKuG2mk3Q0AA1bt71s/hPom0ydHn2OZZu+Xvl915N8ABW93abJkvnANuyAdxh/pH13weJHRWXA/Y/EgRm0h2zsbFkqnWWWmQsqQHcqa8CZBcFKSx+0QfQcNRMqS874c34nXvjfBaUmChSwD+aymDEPxAFOx9g/xVYZpgYA66iWKmp6qljzx6VpyzMBKRO9QiK3bQNZKTLY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5247
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB5EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(13464003)(40434004)(199004)(189003)(52536014)(7696005)(53546011)(6506007)(336012)(186003)(9686003)(33656002)(316002)(356004)(81166006)(26005)(81156014)(76130400001)(2906002)(8676002)(110136005)(5660300002)(478600001)(8936002)(70206006)(966005)(70586007)(86362001)(55016002)(45080400002)(26826003)(26583001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4964;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	e3d12879-a503-4d42-94c4-08d78912e293
X-Forefront-PRVS: 02622CEF0A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GBanZCMbQZK3F0ISswyxCW6+YjbuOnFLGakmqekDu9X299PSVabNMiAmgcx9r9DpeaPSEp0AuuOHMiN53QK2jkKmF/LZjHjY5M3ccg1knvJNVCwcKAmpMFQLlasNMB+n6L5cLTZs2Y7jgMoYVEYKFEE1zir9xhugRghOn/UbT4GICE91L2gWnN41hJL2AF7+9z3USf6fH6ekGsCuCxSnfgjdTIc/XyIPyCvhobpDwDY/sN/Cu6fxZNY+05HbF8jwqTiqb6bZ815av99cS1K+GKopi77kdnGrEWU57K2MsOwgO+ImTMB99VoNlKoCLpuHhV/sHIh0EqTpt38XK+Lsq3Mhyhn3TJoH1TjT1WWhLEPqSTFR9Gsr1OtJKnNqBfEbtnMCljAmMLUnRS2mLuexmpPG2ZBHa7op+Gj1KK6kgTqDotGcEr/nnvxqxsJESDeP7Og4gRx17voniEgz26VjVKy0BduJ0IMJZ9/Ok9/2PENpq6Q9xFd4wYXdsWliYwCwdH0hY8R54cLyHFpRkv/6PGlacqNEJE51g0uG4mxFRTJTPg1u9LfXz13cJHwVmuX8K3M9yXAno/JFtjow21oHJA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2019 08:17:36.8788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e93148-fe67-44c0-75e4-08d78912e6b6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4964
Message-ID-Hash: I3R4DRC6MD7LYLYMGKUK4BQF2SSLRMDY
X-Message-ID-Hash: I3R4DRC6MD7LYLYMGKUK4BQF2SSLRMDY
X-MailFrom: Justin.He@arm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LFUTYJAMDKKC7PLVFLAY3HLYBEIAR5BQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

Hi Murphy

> -----Original Message-----
> From: Murphy Zhou <jencce.kernel@gmail.com>
> Sent: Wednesday, December 25, 2019 1:42 PM
> To: linux-nvdimm@lists.01.org; Justin He <Justin.He@arm.com>; Ross Zwisler
> <ross.zwisler@linux.intel.com>
> Subject: [PATCH] mm: get rid of WARN if failed to cow user pages
>
> By running xfstests with fsdax enabled, generic/437 always hits this
> warning[1] since this commit:
>
> commit 83d116c53058d505ddef051e90ab27f57015b025
> Author: Jia He <justin.he@arm.com>
> Date:   Fri Oct 11 22:09:39 2019 +0800
>
>     mm: fix double page fault on arm64 if PTE_AF is cleared
>
> Looking at the test program[2] generic/437 uses, it's pretty easy
> to hit this warning. Remove this WARN as it seems not necessary.
>
> [2] https://git.kernel.org/pub/scm/fs/xfs/xfstests-
> dev.git/tree/src/t_mmap_cow_race.c
> [1] warning message:
> -----------------------------------------------------------------------
> [   97.344077] WARNING: CPU: 0 PID: 2486 at mm/memory.c:2281
It is hard for me to reproduce it in my x86 desktop when running that generic/437

Could you please share your test env? E.g. guest or host? What is the test_dev of
your xfstests? Is it a 100% reproducible issue?

Besides, a few days ago, syzbot reported a similar issue, Kirill relied his concerns
at [1]

[1] https://www.spinics.net/lists/linux-mm/msg199008.html

--
Cheers,
Justin (Jia He)


> wp_page_copy+0x687/0x6e0
> [   97.348354] Modules linked in: nf_tables nfnetlink rfkill sunrpc
> snd_hda_codec_generic ledtrig_audio qxl snd_hda_intel snd_intel_dspcfg
> drm_ttm_helper snd_hda_codec ttm snd_hda_core drm_kms_helper
> snd_hwdep snd_seq syscopyarea sysfillrect sysimgblt snd_seq_device
> fb_sys_fops snd_pcm drm snd_timer crc32_pclmul snd soundcore
> dax_pmem_compat i2c_piix4 device_dax virtio_balloon pcspkr joydev
> dax_pmem_core ip_tables xfs libcrc32c crct10dif_pclmul crc32c_intel sd_mod
> sg ata_generic 8139too ata_piix libata ghash_clmulni_intel 8139cp
> virtio_console serio_raw nd_pmem mii dm_mirror dm_region_hash dm_log
> dm_mod
> [   97.382176] CPU: 0 PID: 2486 Comm: t_mmap_cow_race Tainted: G        W
> 5.5.0-rc3-v5.5-rc3 #1
> [   97.387804] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [   97.392228] RIP: 0010:wp_page_copy+0x687/0x6e0
> [   97.396572] Code: 95 f5 00 48 81 e6 00 f0 ff ff ba 00 10 00 00 49 c1 ff 06 49
> c1 e7 0c 4c 03 3d 35 95 f5 00 4c 89 ff e8 8d 85 6a 00 85 c0 74 0a <0f> 0b 4c 89
> ff e8 8f 80 6a 00 65 48 8b 04 25 40 7f 01 00 83 a8 d8
> [   97.413487] RSP: 0000:ffffb882493afd28 EFLAGS: 00010206
> [   97.417520] RAX: 0000000000001000 RBX: ffffb882493afdf8 RCX:
> 0000000000001000
> [   97.422295] RDX: 0000000000001000 RSI: 00007f1d20c00000 RDI:
> ffff976384d1f000
> [   97.426914] RBP: 0000000000000000 R08: 0000000000000000 R09:
> 00000000000ca308
> [   97.431746] R10: 0000000000000000 R11: ffffe0cd4c1347c0 R12:
> ffffe0cd4c1347c0
> [   97.436371] R13: ffff9763b46ba190 R14: ffff9763a963d0c0 R15:
> ffff976384d1f000
> [   97.441085] FS:  00007f1d203fe700(0000) GS:ffff9763b8a00000(0000)
> knlGS:0000000000000000
> [   97.445500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   97.448393] CR2: 00007f1d20c00000 CR3: 0000000333dfc000 CR4:
> 00000000000006f0
> [   97.452346] Call Trace:
> [   97.453681]  ? __switch_to_asm+0x34/0x70
> [   97.455566]  ? __switch_to_asm+0x40/0x70
> [   97.457418]  ? __switch_to_asm+0x34/0x70
> [   97.459197]  ? __switch_to_asm+0x40/0x70
> [   97.460971]  ? __switch_to_asm+0x34/0x70
> [   97.462746]  ? __switch_to_asm+0x40/0x70
> [   97.464561]  ? __switch_to_asm+0x34/0x70
> [   97.466342]  ? __switch_to_asm+0x40/0x70
> [   97.468141]  do_wp_page+0x8c/0x640
> [   97.469818]  ? finish_task_switch+0x77/0x2a0
> [   97.471631]  __handle_mm_fault+0xa06/0x1420
> [   97.473517]  handle_mm_fault+0xae/0x1d0
> [   97.475168]  __do_page_fault+0x27f/0x4e0
> [   97.476947]  do_page_fault+0x30/0x110
> [   97.478490]  async_page_fault+0x39/0x40
> [   97.480275] RIP: 0033:0x400d68
> [   97.481587] Code: 53 48 89 fb 48 83 ec 10 66 2e 0f 1f 84 00 00 00 00 00 0f
> b6 03 ba 04 00 00 00 be 00 00 20 00 48 89 df 89 44 24 0c 8b 44 24 0c <88> 03
> e8 71 fc ff ff 85 c0 78 30 e8 b8 fc ff ff 89 c7 41 f7 ec 89
> [   97.489326] RSP: 002b:00007f1d203fded0 EFLAGS: 00010202
> [   97.491336] RAX: 0000000000000001 RBX: 00007f1d20c00000 RCX:
> 0000000000000000
> [   97.494080] RDX: 0000000000000004 RSI: 0000000000200000 RDI:
> 00007f1d20c00000
> [   97.497244] RBP: 0000000000000002 R08: 00007f1d2138d230 R09:
> 00007f1d2138d260
> [   97.500028] R10: 00007f1d203fe9d0 R11: 0000000000000000 R12:
> 0000000051eb851f
> [   97.502785] R13: 00007fff01d5607f R14: 0000000000000000 R15:
> 00007f1d203fdfc0
> [   97.505546] ---[ end trace 18f1c94bd7c3d1e1 ]---
>
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  mm/memory.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 45442d9..e3a1dce 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2269,18 +2269,12 @@ static inline bool cow_user_page(struct page
> *dst, struct page *src,
>
>       /*
>        * This really shouldn't fail, because the page is there
> -      * in the page tables. But it might just be unreadable,
> -      * in which case we just give up and fill the result with
> -      * zeroes.
> +      * in the page tables. But it could happen during races,
> +      * or it might just be unreadable, in which cases we
> +      * just give up and fill the result with zeroes.
>        */
> -     if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
> -             /*
> -              * Give a warn in case there can be some obscure
> -              * use-case
> -              */
> -             WARN_ON_ONCE(1);
> +     if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
>               clear_page(kaddr);
> -     }
>
>       ret = true;
>
> --
> 1.8.3.1

IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
