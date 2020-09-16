Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D331826C37C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 16:03:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E8033145BC0A1;
	Wed, 16 Sep 2020 07:03:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.219.250.1; helo=mail1.bemta24.messagelabs.com; envelope-from=ahuang12@lenovo.com; receiver=<UNKNOWN> 
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com [67.219.250.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 12E6E144CFAB8
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 07:03:05 -0700 (PDT)
Received: from [100.112.129.88] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
	by server-1.bemta.az-a.us-west-2.aws.symcld.net id C9/A1-36160-71B126F5; Wed, 16 Sep 2020 14:03:03 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJsWRWlGSWpSXmKPExsWSLveKXZdDOin
  e4NtJEYsZnRfYLdafOsZsMb3xPLvF7OnNTBbNE2+zW0zsuMpk0bbxK6MDu8fOWXfZPbpn/2Px
  eL/vKpvHmQVH2D02n64OYI1izcxLyq9IYM24+HwxY8FF1Yo/C90bGJvkuxi5OIQE/jNKfDz2j
  BHCec4o8a35JBOcs+P9SnYIp5VJYtL506wQzh9GifcvZ7J1MXJyMAosZZboOKoGkmAUOMYise
  XuTCYIZwOjRPevz2CTWQR2M0v8nrCHFaRFSGAek0T/9WqIWY8ZJZa87wLawsHBJqAlcXZTIki
  NiIC0xKxjK1lAapgF3jFKTJy1nh0kISyQKNFy+SATRFGSxI8rb1ggbCeJ769vgd3EIqAq8X3p
  a0YQm1cgQeLajo8sEMueMko8PTMTbBCngLHE26bFzBBPiEl8P7UGbCizgLjErSfzwWwJAQGJJ
  XvOM0PYohIvH/9jhfitjVHi2JbfrBAJa4nlH06wQdiyEpfmdzNC2L4Sm09fh4prScz5BgpYDi
  A7W+LpvjyIsJrEhYvNzBMYjWchWQ1h60gs2P2JDcLWlli28DXzLLB/BCVOznzCsoCRZRWjRVJ
  RZnpGSW5iZo6uoYGBrqGhka6hkYWuoYW5XmKVbqJeabFueWpxia6RXmJ5sV5xZW5yTopeXmrJ
  JkZgIkspaNi9g/Hl6w96hxglOZiURHmVxZPihfiS8lMqMxKLM+KLSnNSiw8xynBwKEnw9kgA5
  QSLUtNTK9Iyc4BJFSYtwcGjJMJ7XxIozVtckJhbnJkOkTrFaM8x4eXcRcwcO4/OA5I33y8Bkh
  PbG1czC7Hk5eelSonzdoK0CYC0ZZTmwQ2FZYFLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR
  5+UGm8GTmlcDtfgV0FhPQWWyciSBnlSQipKQamE5ZSj37HrPgxb3XUfZiYmkd81fcrvLgfTpF
  WmDvtQnbsr4Y7RT+d17iays7ywt/CyvZZlfhg8sk/VUsZ9R+c37cls565+b+J/dNjl6dU5Dge
  7TmZJ52qK77o72XKoOnPFr7e+f/aXuWPl3RukJj8RJRHzenzQsmNn0zK5/7QuqcuaGs7Icti3
  bPCZ5Vzhj58tCJqbprrOM7VG7N/m3CpPjjW9MmpgMaXZs6fzWXf4rR0MzuPb97nX7vOcsj1ak
  SO643lRe+X/n4ZX+MZueRsH19jIfvZPRt9deLXHbNdcOUzd6HhGuOdSrsvMnzTTn2160708wv
  tIsdPRy744DniRlpjtnHjh79JK7LVB4jYzZLiaU4I9FQi7moOBEA5GGObX0EAAA=
X-Env-Sender: ahuang12@lenovo.com
X-Msg-Ref: server-32.tower-335.messagelabs.com!1600264965!1999!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23345 invoked from network); 16 Sep 2020 14:02:47 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-32.tower-335.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Sep 2020 14:02:47 -0000
Received: from reswpmail03.lenovo.com (unknown [10.62.32.22])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Forcepoint Email with ESMTPS id D3F4C8B41156455D24BD;
	Wed, 16 Sep 2020 22:02:43 +0800 (CST)
Received: from reswpmail05.lenovo.com (10.62.32.4) by reswpmail03.lenovo.com
 (10.62.32.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 16 Sep
 2020 10:02:42 -0400
Received: from reswpmail01.lenovo.com (10.62.32.20) by reswpmail05.lenovo.com
 (10.62.32.4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 16 Sep
 2020 07:02:41 -0700
Received: from va32wusexedge02.lenovo.com (10.62.123.117) by
 reswpmail01.lenovo.com (10.62.32.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4
 via Frontend Transport; Wed, 16 Sep 2020 10:02:41 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.125.51)
 by mail.lenovo.com (10.62.123.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Wed, 16 Sep 2020 22:02:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoyWgC5cghrI2KhcaRDkzSBgzPfdsq3CqmoBdn+6J3TFpUIHY5ZUd38p8v9TtMA3ScfwsDuqZ9+ei6wEbmHQJd2pK6BKglP6BkSzJZOlEV1RJ5HlNOC/ECKdUk+Z4oMNKg2zBJQcPl2UHahxiUXzoBNKgVD39FDUGrk3hwVDlcqRcadMx3EP1IdTWqkBttvvQkQ8fSXT68P1W5JDUCxXEe6MbhKJKwnY2bSu8heei00Bi+UazhcZ13QUkCNLzzFtz5foDuPM8vqwCNWdjnDIZIPivFihzZ6IviWBeN/zmAxZ+Gaggt9zt4qSJumATGELVnIKDz2KfDCY/gbofAJc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQcppcjbpYmQxYh91FMDTYCjwekPipae/IGYM+u+dKg=;
 b=JkKvY/1Tf2troM6uJanX6B2b/ZBrx2sHvMsFq19rMzn0pq/ZM08chVA19jNHd4wVZxYldObI5EUEyxEKwTjTBCGI0trxkRD91tWjzq+GkpuX+e8SLUa4bAZasI+QHFZfH+nqTdiDGKN9RMwWMzobYcmkk9Ss/CokWRHttnHanhSj16LBTavqTNPBt3+KC7xLRsMxgMp7rH0RS4fNysiih/QLr6h77f7jVFIhDNZHaETBL42M8ceOoYfskRaWFoDhd50+Q6Ld/15MP8GKPMh9M0w9GS5xbREvF8cVszmKYxQwlL/esfPedibkIuzdV/xN0I6P0sBao0rUQwUw+NRV3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQcppcjbpYmQxYh91FMDTYCjwekPipae/IGYM+u+dKg=;
 b=iKsFfrw0QrNYiO1wrSj99rUO1b+GP0fiGaQIOo2cLjXKotuGItaOSEZbiJ6RA6O7+07fnqGfxMrZPmsWAJsKWa0xz21FDGgGbqD4aQTmgIGMSCUimnMhukpz/jLvmlmjt04qK9Z+dpb+3jI/ZyAWWHnZCgRxnOJVTiz27KbJbmg=
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com (2603:1096:202:c::8)
 by HK0PR03MB5139.apcprd03.prod.outlook.com (2603:1096:203:ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5; Wed, 16 Sep
 2020 14:02:19 +0000
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164]) by HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::dc8d:b50c:1dfa:b164%7]) with mapi id 15.20.3391.009; Wed, 16 Sep 2020
 14:02:19 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: Jan Kara <jack@suse.cz>
Subject: RE: [External]  Re: [PATCH 1/1] dax: Fix stack overflow when mounting
 fsdax pmem device
Thread-Topic: [External]  Re: [PATCH 1/1] dax: Fix stack overflow when
 mounting fsdax pmem device
Thread-Index: AQHWizuEGtYqjFvsA02CyQO+yS/hlKlqxvZggABY8oCAACFEgA==
Date: Wed, 16 Sep 2020 14:02:19 +0000
Message-ID: <HK2PR0302MB2594F6503ECF4BAEDF76E9F4B3210@HK2PR0302MB2594.apcprd03.prod.outlook.com>
References: <20200915075729.12518-1-adrianhuang0701@gmail.com>
 <20200915083716.GA29863@quack2.suse.cz>
 <HK2PR0302MB25945D758119BECF62C7DC73B3210@HK2PR0302MB2594.apcprd03.prod.outlook.com>
 <20200916111904.GD3607@quack2.suse.cz>
In-Reply-To: <20200916111904.GD3607@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:b011:e002:f5de:1462:81a7:657b:8410]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8a4b370-66f0-4a48-eedf-08d85a492073
x-ms-traffictypediagnostic: HK0PR03MB5139:
x-microsoft-antispam-prvs: <HK0PR03MB5139E79B87F77C0143B41F03B3210@HK0PR03MB5139.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5o9MDWQTVvYOQREjh6yBAOcWEjwt2vklaKiGlDnXCcf9K5+lV27Nq4zaG/CFaocaoSSahhTJTyaYm+gdSx2V3wi4bq8lUd/uFAh6sqvqhMF0TlOERyjdkFKoifmxKUZilAl5Bowb69tJ+X+5bgghaJtffbluCJdSYC/8mEc5p71nYvDn+KE63QjGVfZVEy0jdirmp6vMpDGAU0yds9CrKqENV42bfM8K/tWkMds+0Pgy75INiCCPqtVnLB3VPH//jNgA1rr7UI9UcBb02cHr1kdEXCZBswDi7LtwoLWDYyfhNiLabrVF/vJZL7Er9toCZDcYgwGs6QmOh/ugWw59tTu5L2V8njyXnanNlzpqys/ENaqkpzm/PBm7FgZ0C50sJRaxWf+TTlerx+tLkKNhOrOLyjHCwQZUmDpDSxqmYRNeUFOS+9D1GQ7LvmHchXL/8duW5CEvvHo4bqJpI/y4yQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR0302MB2594.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(33656002)(8676002)(45080400002)(8936002)(55016002)(478600001)(86362001)(4326008)(7696005)(83380400001)(54906003)(316002)(64756008)(66446008)(66946007)(66476007)(66556008)(2906002)(6506007)(71200400001)(6916009)(76116006)(5660300002)(966005)(52536014)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FwKEzUIvmmBxVPq0xT1pGo4GeYogNq+Ly5ewYKB1h/7mO33chFdsheUlMqN0/pnjPsogweLL6HQqsclGjB9tmuhwUa05jCFFeKOKRQ07VmKC2kgZmvpR6ACh1o7YloDtLDbLdyNwM55qqdpSRapnfROvzLOYpdIIo1u6yumzmkN3kXXX6eE6L6RBuGKPCXpdTETeUkT7QSLxY+blSjxX5u3HIeGYrhkfO/NTpv6FBkoePNTTjjSIGtxm3QVpUETzwv+1/pLaH2DPLcodxgIok8+1m2uQi/rL28+c+y6QheyNSdbnZKET3dqXVHYo8wnDQyRYmJqPwZy7NsHI3M/8TWOlGQbokgZ1oaONgBHl9Tt1zjqqZyHYrGT1+9BLMiFxevEc8HisvsQiqqjtbWU9lOFf0OlYtJQ8Z6mvHpewH6saRBRAMmR/ysYQ3/sgxSxTx+4MPx8kLEevybL26KVvHtGAeWoKvkLR0sA1VM76aF7PmxZTbtCFqrNz4v2vmTWHnHvNeEW+pc0n2gS+a9uHlMoBxv7IZsWVVEzTiqSKb/Ls4SOh/Iq21SQ44vfMAmLaFvuWu0TlGiC9zNNXczcLWghtm6T/WbUEA87So7b0izj6ensGEreVCJ6wOu47hDUOWq2xeu1kOZSpiAtuzkB83Rm1AULqBuZNdDBxpBe0EnyHkAHDU+MbPaAvo1kiwiYKW+KLS0tTvS9pE/y1LiVXsA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR0302MB2594.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a4b370-66f0-4a48-eedf-08d85a492073
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 14:02:19.4717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iz8hOg51w/gws7eKDWmqECtqqcS3AA6xnKa166KyYPBKH/xez2fQFeuQxsmSUc5m+YcDfXIfOwOCoIEIfnpuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB5139
X-OriginatorOrg: lenovo.com
Message-ID-Hash: RM337ANZZ7IOZALPAURVS56QNROGWURJ
X-Message-ID-Hash: RM337ANZZ7IOZALPAURVS56QNROGWURJ
X-MailFrom: ahuang12@lenovo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Adrian Huang <adrianhuang0701@gmail.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RM337ANZZ7IOZALPAURVS56QNROGWURJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Jan Kara <jack@suse.cz>
> Sent: Wednesday, September 16, 2020 7:19 PM
> >
> > dm-3: error: dax access failed (-95)
> > dm-3: error: dax access failed (-95)
> > dm-3: error: dax access failed (-95)
> 
> Right, and that's result of the problem I also describe above. Attached patch
> should fix these errors.

The patch introduces the following panic during boot. Apparently, the dax_dev is NULL in dax_supported(). So, the address 0x00000000000002d0 is offset of the member 'flags' in struct dax_device (the member 'flags' is referenced in dax_alive()):

crash> struct dax_device -xo
struct dax_device {
    [0x0] struct hlist_node list;
   [0x10] struct inode inode;
  [0x258] struct cdev cdev;
  [0x2c0] const char *host;
  [0x2c8] void *private;
  [0x2d0] unsigned long flags;
  [0x2d8] const struct dax_operations *ops;
}

[   30.551352] BUG: kernel NULL pointer dereference, address: 00000000000002d0
[   30.568869] #PF: supervisor read access in kernel mode
[   30.588569] #PF: error_code(0x0000) - not-present page
[   30.602591] PGD 0 P4D 0 
[   30.612924] Oops: 0000 [#1] SMP NOPTI
[   30.627707] CPU: 198 PID: 2133 Comm: lvm Not tainted 5.9.0-rc5+ #21
[   30.645862] Hardware name: Lenovo ThinkSystem SR665 MB/7D2WRCZ000, BIOS D8E105P-1.00 05/08/2020
[   30.666245] RIP: 0010:dax_supported+0x5/0x30
[   30.690943] Code: c7 50 49 7f 83 4c 0f 44 f0 4c 89 f2 e8 b4 ec e6 ff 48 c7 c2 ea ff ff ff e9 e8 fd ff ff e8 53 e2 2e 00 0f 1f 00 0f 1f 44 00 00 <48> 8b 87 d0 02 00 00 a8 01 74 10 48 8b 87 d8 02 00 00 48 8b 40 08
[   30.737769] RSP: 0018:ffffaf660803bc98 EFLAGS: 00010246
[   30.757840] RAX: ffffaf660803bcd8 RBX: 0000000000000000 RCX: 00000000157f6800
[   30.776039] RDX: 0000000000001000 RSI: ffff8b862f677840 RDI: 0000000000000000
[   30.800314] RBP: ffffffffc009c740 R08: 0000000006400000 R09: ffffffffc009c740
[   30.818598] R10: ffffaf660471e0a0 R11: ffff8b8714d376ef R12: ffffaf660803bcd8
[   30.835971] R13: ffff8b8ae0cb6800 R14: ffff8b8ad9a3c000 R15: 0000000000000001
[   30.856943] FS:  00007f17e3c4c980(0000) GS:ffff8b8afeb80000(0000) knlGS:0000000000000000
[   30.875594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.894763] CR2: 00000000000002d0 CR3: 00000008142dc000 CR4: 0000000000350ee0
[   30.919656] Call Trace:
[   30.933808]  device_supports_dax+0x1c/0x20 [dm_mod]
[   30.950784]  dm_table_supports_dax+0x8d/0xb0 [dm_mod]
[   30.968326]  dm_table_complete+0x309/0x670 [dm_mod]
[   30.984310]  table_load+0x15b/0x2e0 [dm_mod]
[   31.001171]  ? dev_status+0x40/0x40 [dm_mod]
[   31.018840]  ctl_ioctl+0x1af/0x420 [dm_mod]
[   31.043825]  dm_ctl_ioctl+0xa/0x10 [dm_mod]
[   31.059381]  __x64_sys_ioctl+0x84/0xb1
[   31.074755]  do_syscall_64+0x33/0x40
[   31.091368]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   31.111434] RIP: 0033:0x7f17e1e2987b
[   31.125175] Code: 0f 1e fa 48 8b 05 0d 96 2c 00 64 c7 00 26 00 00 00 48 c7
c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d dd 95 2c 00 f7 d8 64 89 01 48
[   31.170194] RSP: 002b:00007ffca2dbcf88 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
[   31.193668] RAX: ffffffffffffffda RBX: 0000563b00467260 RCX: 00007f17e1e2987b
[   31.214773] RDX: 0000563b01b17290 RSI: 00000000c138fd09 RDI: 0000000000000003
[   31.236570] RBP: 0000563b005154fe R08: 0000000000000000 R09: 00007ffca2dbcdf0
[   31.259426] R10: 0000563b00581ea3 R11: 0000000000000206 R12: 0000000000000000
[   31.277578] R13: 0000563b01b172c0 R14: 0000563b01b17290 R15: 0000563b01311970
[   31.302167] Modules linked in: sd_mod t10_pi sg crc32c_intel igb ahci libahci i2c_algo_bit libata dca pinctrl_amd dm_mirror dm_region_hash dm_log dm_mod
[   31.347549] CR2: 00000000000002d0

The following patch solves the panic. Feel free to add it to your patch. 

BTW, feel free to add my tested-by to your patch after including the following patch to your patch (I don't see any dax error messages when running lvm2-testsuite).
Tested-by: Adrian Huang <ahuang12@lenovo.com>

Thanks for looking into the issue triggered by lvm2-testsuite.

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0d2dcbb1e549..e84070b55463 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -325,6 +325,9 @@ EXPORT_SYMBOL_GPL(dax_direct_access);
 bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
                int blocksize, sector_t start, sector_t len)
 {
+       if (!dax_dev)
+               return false;
+
        if (!dax_alive(dax_dev))
                return false;

BTW, I just submitted the v2 version: https://lore.kernel.org/linux-nvdimm/20200916133923.31-1-adrianhuang0701@gmail.com/T/#u

Hopefully/ideally, your patch and mine can be merged at the same rc release.

-- Adrian
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
