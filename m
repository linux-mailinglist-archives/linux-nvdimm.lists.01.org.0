Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FB8379F60
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 May 2021 07:54:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C5772100EB85F;
	Mon, 10 May 2021 22:54:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.71.158.65; helo=esa20.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9F893100EB85D
	for <linux-nvdimm@lists.01.org>; Mon, 10 May 2021 22:54:01 -0700 (PDT)
IronPort-SDR: fPIgCnMqdJHn2yB2gcchxiJhoJCDl2Yx9mgHwIyWZc8RY4YqIZoqtLL3zL2fpneC5BI7QUYn97
 1YpTV9sJzlrNVckvPDjeLywOJiDJXBBQeNXJgVOt435CSzP6YCLkrYwDI3KWofSIEP4o31zAXE
 St/CRks65nSWWd4wjEZOvFUsvrD905Qvhr0VuSHxFdJtgyGHgyIfN1P1s9PcJ+tUxmgRm4PgOT
 FZ7LlrbwvoXSPgJ5IilxzFSaCz8rDaJ67q7+Pz+KjjSMkZSogQNsJH+/G195+mLCdPmQ5ihxe4
 0k4=
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="31056023"
X-IronPort-AV: E=Sophos;i="5.82,290,1613401200";
   d="scan'208";a="31056023"
Received: from mail-ty1jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 14:53:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MK7OD2fZ7MQZDSIe+RxOwAoOszfsQvUmL0kjgqnZzBEBPRPqGpcH4O5HValxDN20S8yyqh95NekUdH536VqDhCK5/YMut8pvUg6nBrdkTpzPeY3eFrw/ARV20Otl6m6PqJbSrc3b1AEiXl78WNy+lFHzHroLsnvjaXGo/6h1hHUa2+fkY+uL8aj/1j6emayEoa/uKvLkP3lKAGAOOQYrldmTtZ4JPws0Ja5d9qmefOVTKLW/4CxH5wHLNSQbckq9M7zQBzFvuhUklCzbWeeZCTSwebzM/RItx/YyqqYSUD05ta4+2pfr+tOkvQLyIiXUB6YbNxsmlnxUfUo+H+fM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywSVl5JuvVgOwa835Fi/m25xN3VVnOyf0RLVY+05sx4=;
 b=Nggs2oTjXvuXJBRQIIyebsVWFe/fdAPP3Zk7ZvQB8hQ/j8vyvIoBOnbJalDo3JrGYxiI/FKGHtL3Z9uJTbxhgrRSHjrQ+7ZuN3D0fzh3Yf1+tFK9Fh7bXjIjh3CPabInhz1uifa3pdtAzG7NI9HeRiKsuX5LWD20S7mCRyVweD8CmUhEautRCJW2ZZx/tXTVy5BlTqmmHmqStmuGZZCod+nVvg6J408qp3N340cenoFy1KuCBXHbfyKY46yEbUZZgF2v4C52XxkDBT0MYgkAobKczlgUiEUQQI7ueM3MsRkPD9aJiAza+TPxe06uP6GTpHvGKA6OsOrIa5B94sifJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywSVl5JuvVgOwa835Fi/m25xN3VVnOyf0RLVY+05sx4=;
 b=ejvpelUMt0atUPoXs5MdTaMQfZYf85h/BLFOgESp2w/EPTCiiDn+o8ug3TVwJZxHMrllepgYgDmuAZJIKw5mMVAPH0O43q3Z1G6u9aZoYQPfoiMf6q7d4wiSKkeXxrBG6ghWidz8s/Agm3kd0N5Y3StbNiyw/pKTQmZm9W6B4jA=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS0PR01MB6035.jpnprd01.prod.outlook.com (2603:1096:604:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Tue, 11 May
 2021 05:53:51 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 05:53:51 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: RE: [PATCH v5 0/7] fsdax,xfs: Add reflink&dedupe support for fsdax
Thread-Topic: [PATCH v5 0/7] fsdax,xfs: Add reflink&dedupe support for fsdax
Thread-Index: AQHXRhMgYtQIMqpR5EmTUmDl9HnNxKrdp0QAgAAa8pA=
Date: Tue, 11 May 2021 05:53:51 +0000
Message-ID: 
 <OSBPR01MB2920C085D788A9F918107F33F4539@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511035706.GL8582@magnolia>
In-Reply-To: <20210511035706.GL8582@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c838aa83-850b-455d-8306-08d914412749
x-ms-traffictypediagnostic: OS0PR01MB6035:
x-microsoft-antispam-prvs: 
 <OS0PR01MB60355CFDFDD3158105FBF4B1F4539@OS0PR01MB6035.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vWqxvLAkvefAaVxmBtPQFAyVlAG23xc23KW1efPdiaegcsBI/k8+aQMPQ/EuszQPMkTZqg6iqKSyq1pQRVZomS8yy9OWUF/Rya323EP3rzua1gOZerDHmmQFKdCG+I2XTOSSDZL3PBNjO/lC782Hk1/HXE3kzquLhdt2Ke9gFkIvZl5Og6qcBJDXFpQPtLZRnbN9pHD9LrTb0yFmKUalnujV2yngU0wGwTg8BZ24ld9O9i2k/S9r3poJBfwqKZYj8j+r3sHkM3hqEstibtfuqAy0yuf3qGVUQiKclc4sWBrdPlAsgdTot7k0YH5qHlaxRy/iFnIdj2y0yh0GtOZalS+Odw/y9g8PkJ/mkeJgjl9bEaQUZQAcu8cO+EMIAFZKAIY3dRD770XZBw9dJUTNqfM2f0te5TENNpA/6emb3rBQ8X9ukQn/VGQJUkQd9Jjqx3XZrtRpG7W6b7XZAVaNdGJ01fVIZV7aEtXeQrezUH9kW8B3s81tbd7Qr810h3hWdY2ZVwKser5ydF/UTjR8vByb0W0N7gt+oqfNN0NI94/oSyDTopUEfbHNyfNaKSRCjFOQQZOR8FO5CbHXlLegTp2Pwo6s42areVdOX+nJGeLE0UngUg4Gxy7LE8v/AyKbnTmBcHOP9vkQZOG+kvSZbvuYp2rXrfAWmkUW91gGlIf0vNSx1OVnNLqCTA/INR73
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(6916009)(8936002)(5660300002)(71200400001)(6506007)(4326008)(478600001)(52536014)(7696005)(122000001)(7416002)(53546011)(83380400001)(38100700002)(33656002)(66476007)(26005)(55016002)(8676002)(66446008)(66556008)(64756008)(76116006)(9686003)(66946007)(85182001)(186003)(86362001)(54906003)(316002)(966005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?N0FSdjcra3JNY0VWRDZac3RJSlFtSGpJbGtEdEJEejhxbFZETExSbjhmOGFV?=
 =?gb2312?B?UzN2aUdFUnpGRzUvam1CK1YwYTVSdDcrVVlRa3JsaEx2VXlDREQ1STk2bllt?=
 =?gb2312?B?UlRTRlUwanczR1ExS3p3d2pTbFdPSmFSM0FDRkQrbjFYbHRHWFFjL1BrcnhM?=
 =?gb2312?B?UDF1T2NOSXNsWmpGeURPMmxyY1NRV05OcEFZNUpDS0FGbXJzbC9QaVVPbFFJ?=
 =?gb2312?B?d0pxUXlGRFlxalkzc1dYK3NCUW1USEc0c3o5YXA0Q1gxUkNjVExYWmlHaUZq?=
 =?gb2312?B?dDc3THBUVmJJK0FuMGQyUW1WcndFSUdaNHZ4OEpzaE1nbnZub0J4VEdwdFg0?=
 =?gb2312?B?S2h1M1dRRVp2M05mR01maXUyQlFRRkllN0pQT2J0UzNvVEt5WURwZ1ZhSmNS?=
 =?gb2312?B?dlpIQ0ZmcVRHUGkvNlFkb0I2aHpJMU5laEJXMkpGZjhQajVDTG5MTTFSS2cv?=
 =?gb2312?B?em1COWRaNWhPYWZpNkhTU0haQk1uRkdOTlAxMlVWVVlZNi9pKzFJRzBuVkRK?=
 =?gb2312?B?cG5LTFZ3TC9MYXN4dEVTcEhCZmpHc1dtbEFnWlViN0NTM3F1eW5MRFhBeGV0?=
 =?gb2312?B?Szl3RWJPZHIzNW5WN1lkVUw4eHhFU2lBQ0FrK2pQMWN3NmtWS2dTYWlPMEw1?=
 =?gb2312?B?S1pzU3dseDZVeDByRFIrZnUxVml5eS8wTlNtVEdDcWl5R0oyNzlKK0ovTG5C?=
 =?gb2312?B?bDdBd0tMSFBjcC9CZE1NbjVuYVN0ckhOMUlCREJJTzRobWw0VG1wZzQra3pn?=
 =?gb2312?B?VWJueDdFNVplMlhETk1yeXlTMDZTdlhjSjFZcXg1VXJlTmoyTkNXSVppMElZ?=
 =?gb2312?B?LzFBYW1uS3Z4c0NrTk9EbFFFRUl3U1oyenlrMExBdzdZVTNMSG1WZVI4cFZp?=
 =?gb2312?B?NW1kMVhyWnFjWkk0NTNOd2JkWWtBWTFXcUI3cUxkc0c1RjBRRCtqNkZkbUxz?=
 =?gb2312?B?TVV5U0hXYkNRQ0FyeGxqWlh6Mnl1Wlk4MkQ5Wi9nQUFMWjNOdWNRZGNYcjlD?=
 =?gb2312?B?RFFSQkpSdU90dGt0YkR3bWJWaXFmV0JVMnZkYWt6Skg2YkkzN095dytRREhL?=
 =?gb2312?B?SnJsdFQwaWVZNXV1cHFIbWlBZ3Vwa1czUXhZWmxEQXYrL2haQVdsNERLSkQ5?=
 =?gb2312?B?MndzM2k5RFpEVGh5Rk5lUG9zcE93MjZ3dk9rQStIQ3JlSVlGQ2lEYkNUT2Jv?=
 =?gb2312?B?MGRVMHVvcFJUdVZyTHFQT3dpNFVLMFdCVXEwRWpyZGZ6NUZ1WjBTem9KV3h5?=
 =?gb2312?B?Y0cvVEROVS92ZmZ5dkJQaXhLbDVDTlplZHBYdVhzKzZSaWw1akFEbXZDV09m?=
 =?gb2312?B?SmdxNXJ3NWswMHhiOHQrTkVacWpyblBXNTE4MTBWSS90ZG0wR1h4UHo0SGFn?=
 =?gb2312?B?djMzaGdkVEg4WDAzbVMrbWw4NkdzK3NPU0d1N2EyZ1RNcWp2OTJnZmdrNE1z?=
 =?gb2312?B?cUU2cGtJbks5bDIrSlpBdlF5VnJObFlvejQrbE0yQXMrVWcvNFVSMUdCcXZV?=
 =?gb2312?B?TVNoektjRkN1RkY3QkxYaUFPUHg1djJsZjlRWEFMYjNBM0huU1pKOTFlSk1i?=
 =?gb2312?B?d0tNMXdvaUx6ZHNyRkN5NjhpbkxMTGl5TEJJSy94MzREdk5BQVd0Y09VV2pk?=
 =?gb2312?B?d3h2Z3IzR3RWWE53L09PaVdPRFBjQnNvem1lMmhOakVidW9pbWlxaGhQYXlX?=
 =?gb2312?B?Y29HR3M0OWd3cHQ0bnJTMnk5bzBZNGtFYTBRN2xrWVRCV0p2S1FXemtFTU1v?=
 =?gb2312?Q?TxYYHxOtpPPjEnJnV1qQShI2a9nv3OvoTmLEyVh?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c838aa83-850b-455d-8306-08d914412749
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 05:53:51.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNTXktMlJ8CVcFqO7v7wqFqZ7TqroLMMy9curUrdOpVN4U+CNLuyRc77lNB7QK7KzLHsvuy1b3FZFRg9JKwy6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6035
Message-ID-Hash: 5BSE6XTQAYZI6IFRKL3Y7POTJU2BVTNU
X-Message-ID-Hash: 5BSE6XTQAYZI6IFRKL3Y7POTJU2BVTNU
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/67DS6UODQNIVUCYCPLDLG3S2F5JP2S33/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Darrick J. Wong <djwong@kernel.org>
> Sent: Tuesday, May 11, 2021 11:57 AM
> Subject: Re: [PATCH v5 0/7] fsdax,xfs: Add reflink&dedupe support for fsdax
> 
> On Tue, May 11, 2021 at 11:09:26AM +0800, Shiyang Ruan wrote:
> > This patchset is attempt to add CoW support for fsdax, and take XFS,
> > which has both reflink and fsdax feature, as an example.
> 
> Slightly off topic, but I noticed all my pmem disappeared once I rolled forward to
> 5.13-rc1.  Am I the only lucky one?  Qemu 4.2, with fake memory devices
> backed by tmpfs files -- info qtree says they're there, but the kernel doesn't show
> anything in /proc/iomem.

I have the same situation on 5.13-rc1 too. (Qemu 5.2.0, fake memory device backed by files)
I tested this code in v5.12-rc8 and then rebased it to v5.13-rc1...  It's my bad for not testing again.


--
Thanks,
Ruan Shiyang.
> 
> --D
> 
> > Changes from V4:
> >  - Fix the mistake of breaking dax layout for two inodes
> >  - Add CONFIG_FS_DAX judgement for fsdax code in remap_range.c
> >  - Fix other small problems and mistakes
> >
> > Changes from V3:
> >  - Take out the first 3 patches as a cleanup patchset[1], which has been
> >     sent yesterday.
> >  - Fix usage of code in dax_iomap_cow_copy()
> >  - Add comments for macro definitions
> >  - Fix other code style problems and mistakes
> >
> > One of the key mechanism need to be implemented in fsdax is CoW.  Copy
> > the data from srcmap before we actually write data to the destance
> > iomap.  And we just copy range in which data won't be changed.
> >
> > Another mechanism is range comparison.  In page cache case, readpage()
> > is used to load data on disk to page cache in order to be able to
> > compare data.  In fsdax case, readpage() does not work.  So, we need
> > another compare data with direct access support.
> >
> > With the two mechanisms implemented in fsdax, we are able to make
> > reflink and fsdax work together in XFS.
> >
> > Some of the patches are picked up from Goldwyn's patchset.  I made
> > some changes to adapt to this patchset.
> >
> >
> > (Rebased on v5.13-rc1 and patchset[1])
> > [1]: https://lkml.org/lkml/2021/4/22/575
> >
> > Shiyang Ruan (7):
> >   fsdax: Introduce dax_iomap_cow_copy()
> >   fsdax: Replace mmap entry in case of CoW
> >   fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
> >   iomap: Introduce iomap_apply2() for operations on two files
> >   fsdax: Dedup file range to use a compare function
> >   fs/xfs: Handle CoW for fsdax write() path
> >   fs/xfs: Add dax dedupe support
> >
> >  fs/dax.c               | 206
> +++++++++++++++++++++++++++++++++++------
> >  fs/iomap/apply.c       |  52 +++++++++++
> >  fs/iomap/buffered-io.c |   2 +-
> >  fs/remap_range.c       |  57 ++++++++++--
> >  fs/xfs/xfs_bmap_util.c |   3 +-
> >  fs/xfs/xfs_file.c      |  11 +--
> >  fs/xfs/xfs_inode.c     |  66 ++++++++++++-
> >  fs/xfs/xfs_inode.h     |   1 +
> >  fs/xfs/xfs_iomap.c     |  61 +++++++++++-
> >  fs/xfs/xfs_iomap.h     |   4 +
> >  fs/xfs/xfs_iops.c      |   7 +-
> >  fs/xfs/xfs_reflink.c   |  15 +--
> >  include/linux/dax.h    |   7 +-
> >  include/linux/fs.h     |  12 ++-
> >  include/linux/iomap.h  |   7 +-
> >  15 files changed, 449 insertions(+), 62 deletions(-)
> >
> > --
> > 2.31.1
> >
> >
> >
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
