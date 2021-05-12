Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F245337B371
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 May 2021 03:26:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 28C46100EB33C;
	Tue, 11 May 2021 18:26:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.159.88; helo=esa8.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C3EEB100EB33A
	for <linux-nvdimm@lists.01.org>; Tue, 11 May 2021 18:26:39 -0700 (PDT)
IronPort-SDR: ogBk6sSzzwxQvEE8olUb8Wz7UlOjwbm2Wk6RZwRUmHBN8nUX4pXDRXrmhlXSukrJ79O5fSe8nR
 BUWAJurBRaMbAGB57DuYdZ3QZP7ES+SGXy0G/fpR9BiYkf9DSCZdTQoExbYzJtee5IgvTD+iia
 ITclwWBbO/k57cXYwHoEN+re42cj9JYFIi+wlj8aNi4sbjmLzJ8i23rgS5zE0c+TZrMMRkbiQo
 z7OB18TwTGuMHwsysJUZFddCHPmNkbW3yvkvIjy4I2bnlqBsmu8bhryCpfO3BawkGM4zvPLE25
 guE=
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="31167728"
X-IronPort-AV: E=Sophos;i="5.82,292,1613401200";
   d="scan'208";a="31167728"
Received: from mail-os2jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 10:26:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX7WGA8psQRPvAlPWOHgDiJ9dapxO+6WjyHz5gkxEASjrIOwfTTb9XZJhVnCPdf0feThmaVRqduluolEFT/6G5n4uG+mKcl/jeXFNfW9YnQPhLmuXa53ghmpmcBGoxTV+QkDdeDXBjRbZizoQGeluDZj5NLy7M01WcIWIFkClPNLzeTNpw5SCJj3AX782ViltC911gpUDuZBES2yAXjwsd4Pxm9LnoGr4NsAW+WpzmfmOZjZCD2syetYsy4Tqg4Wftk41V0HKJBer5UoW1MJyEOndb/ZubUv/QAxXUxtikggacomh0mPRrhHOJipIhvJg57MoYprNAZ06ytO3J1OqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GunQJCoQ5PZX41lKtKo2dnNUIl9zSXBMxpy7ebJlq7I=;
 b=J8j2Cf7d8+GK7SfE7iQLiTFnj05BiTIgeDEhvP6UarfcRMAN+Lao0CkgA48bUqVvLrSupUVOr9VdRPorRadrUbFbgw6aAMgL29c72/9/BsTIJIwfASDAa4eGoIkcMgx9uYDQIyFh3zvvD7qvgkujpaWBWwE4l97IAGMfwQ9VwSSBmsN7CPtNNALAMH66sPpWpdjucT7mscULhn1CE+NXhIgym5isjUADarvUteINeDFAK7snlRarJXrD1WDEwxmcR3qxW3ztB4Rn7LxMIPDtoHOAX8bE6+0lUJ/Qsk3bIBXLzS1EUTzomS2sx40W/SHa+Njzz3FGDi1zA5mlmChe7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GunQJCoQ5PZX41lKtKo2dnNUIl9zSXBMxpy7ebJlq7I=;
 b=UiSS+ovlMtSGqXvIUs6NkbYj0U9ggVRpcoWMEI6yy47Osfa+5bEpB7xltSiRAAm6XjHiiILIyFWMawO9xaUsbP9+dq85gcJmPdK5WBczyENR4b/tocpPnQIgsFdWybDs/BanYsxnChOZUZsK8+npFwOkUN9zARyl0lDHAk6CuWU=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSZPR01MB6664.jpnprd01.prod.outlook.com (2603:1096:604:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 12 May
 2021 01:26:31 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 01:26:30 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: RE: [PATCH v5 7/7] fs/xfs: Add dax dedupe support
Thread-Topic: [PATCH v5 7/7] fs/xfs: Add dax dedupe support
Thread-Index: AQHXRhNDCed4g25S+UadwA1j61+HmqrfCV0AgAADOLA=
Date: Wed, 12 May 2021 01:26:30 +0000
Message-ID: 
 <OSBPR01MB292025D1E3CA65493B714E63F4529@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-8-ruansy.fnst@fujitsu.com>
 <20210512010428.GQ8582@magnolia>
In-Reply-To: <20210512010428.GQ8582@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46b6c3cc-111b-42ca-103c-08d914e4f8dc
x-ms-traffictypediagnostic: OSZPR01MB6664:
x-microsoft-antispam-prvs: 
 <OSZPR01MB6664BAA7D9C809FC20771297F4529@OSZPR01MB6664.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TEpItdJVn/ZUhP2tke/evJ4YEYUB5GFLjF1/uhQJfumPetHYWOLhsGRgCaYlD+k1opeVWpiLrKVsBGDHue+L7FB0fHUb8LYhjM2j0Z3i2+Hvs607mJtgMC4Wwk65zytjDp8lTcnebKK2Ol9paZG3DkJZXeVUPK261CsP6P4CkZCt/2FpQhYN0Zkskyom8DDXI2ecwZzds4I9avnKcR1QKt/TkDf0Pkpn4d8c3KdvFO3/zp+9CjsfXwEDt5q7v2qJp6Kq5B/wNYtgx7Jdt41PFCCS6pewunSZvw9VihcOqKi3RNVAhmE5AEGG20+8KHxtl19a1/6Uc1/ayVxhQlOIKSmYjOZQSjnr7iPIOTVUdwUAMbwygKGAsnhP4zsqM3vXl6kAG/TtH9gK6WqrHboG7o8apTp/D4+utCa8HNUAajdz5jaLxZ5NvkKfkWM4BaJ7cgbUQNdmw6ENW6zE62WXQjLobb3E7/jl4v9IadFG7rfYnfYnb43+9C5BdXuq6QgSURdSaJSYl+XVGtsVY5dYltt0ZbHVuddjtWp9Aejzz1BTz0azBT1gQ9CzwHiaw22M29fH7j8OuSty5L28g317wyH4VaNl68qh3B/VnTvnzPw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(33656002)(66446008)(2906002)(9686003)(5660300002)(66476007)(4326008)(64756008)(186003)(7696005)(66556008)(55016002)(66946007)(54906003)(26005)(52536014)(86362001)(6506007)(122000001)(76116006)(6916009)(7416002)(71200400001)(316002)(8936002)(85182001)(478600001)(8676002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?c0QvOGI1cENpblJPc1VvQWJTR3czRzFTdDJTeXVZbVZPN05ENXBPMTRYekVR?=
 =?gb2312?B?Zzc1Nnd4a055KzdFMTJCeW9YTmtiQzJhc3BxOEFQQzlWU2dCUUR6TEVEdGdG?=
 =?gb2312?B?TlJBTE5DWUdiVnlyNzhtVEtadEpmRzdwbU5PYkZFaFdxVVpYbU1IUXpBVkIv?=
 =?gb2312?B?c1ZOUnRIZ0I0Q3lEMFliTTlTd0lyYVcyVXFCNmd5a2xFd2V5NE84NFN4UUZ1?=
 =?gb2312?B?dHRhTmhUME14cFJGZFNzMXZJRHRIS08veldrb1h2MVVNdWsvMkJzZmYzWGVv?=
 =?gb2312?B?dVc4Rml5MU1JV2tqSEZjRXhZUFZybUFnWk9wUjhWZlF3OStHa2NnbElrdWpN?=
 =?gb2312?B?QmNiTU1MaG5kSHNlT3QxbEthdCtBUlZNTS9BL2ZOMEZrVGo0SlFySThFSlMw?=
 =?gb2312?B?SlNmd0hPdk9iSHJCakZIWjd3WjAxNjJTWEY1c0dZZnNobVRVMWg4VW1YOVBp?=
 =?gb2312?B?Y1MxN3Vtb010UitaYmdYK2pUcy9Td2VhdEZ6RDhUSFNtOWNpeEZFTkFKUVlm?=
 =?gb2312?B?Y2dHR2tSNVNZZVZMWGlXNTBCK1IrbFBOZm1kOEg2azQ2T05KQWh1bk1CZS9q?=
 =?gb2312?B?b1IwbWlsRnJpTlc1UTgrZ3kyZlVhNjVKOE94S25qS3lxZ1JwblpESUU5MTY0?=
 =?gb2312?B?eklaK3BkU3UvUkFWNElyR3FxcXo1OGJjdlVCUHVid05kajdNL2VIVkN3azli?=
 =?gb2312?B?Z0RnTkdHYkhEUTIwUVJLa1UyK1pOdnpyMFoxMm9NaVRGc2ZrSmxEbWNtaytH?=
 =?gb2312?B?WGg2N1lsVUVCam5seDAxWEtEMS81OHROMHR5KzJuT0trUEM5N2tFUkFpb3NG?=
 =?gb2312?B?UFFzdVJ6RER5TXlEbUM3bk9tdThwQ2RPN2M5TDZPWWxXRHQ5NzJCYWdiTzBs?=
 =?gb2312?B?dVFhTW4xVTd2cnhGcHJ0bEp6UEwxbFFkcWNtTmFEaVNGV3hPWktjOVB3NytF?=
 =?gb2312?B?Ny9uUC9KcmJhTlBkZDF4ei9iYnN5cWg2S3JKRWxhcFpRVlowNVJkU1NKVXpx?=
 =?gb2312?B?T25pbGQ1TVp2SkxPQ1dlY2R6dnpwL01BSitzTi9hbUpRclB6Sys4bVcwd2Zz?=
 =?gb2312?B?Q2FBK1lwd2c3bitqUUpmUHZMWlpWenFISmhtSll4UEVvcUgreWNIRnFNYUFI?=
 =?gb2312?B?M2JTK29PQTF4dlR3NURLRmswWjZVUUFLc1A2RlZ1ZDZObXRoenR1a2t4QVNw?=
 =?gb2312?B?bjRrdmJaNlJpRmkxbTZVNlMvVCs5V0d1VUEzdlM2UXdrdkdVVDJob0xaS2pK?=
 =?gb2312?B?OUordENnaHhUeUFSM0FjdXBjaXNtakNNYVJxQUJEZ0JLYStrZWlpTTRwWGM0?=
 =?gb2312?B?S2FOSjgza0J1ZzVMejNMd1JiNk1GcnlKcW9jT1JUZU9PSHJnZGxLK2ViMWRI?=
 =?gb2312?B?QVNwOGlYcDR3ZENOY2VESnFrdE8rbkpBSWZmcjZJVWMwamN6bHZRZEhHSFZH?=
 =?gb2312?B?eE5rWFBldmsyKzI2Y05aSmk3bTJZd2xNTjdXeENxZ0JTcVRUcHJEYmQzekxx?=
 =?gb2312?B?RllRSzVpR3lEMzV5RVpNMmZVVFFwNVVnTzlLZ1FGbE9tdWh6aDNNVTRwYjJJ?=
 =?gb2312?B?UzZQamoxMnA1YW5wUUxHc01RUFNKRmV3TTZsVDZnaW9xOVVYU1o3K3NXb0dz?=
 =?gb2312?B?OGtFMWl3MlE1WWFmeExBSFpmWlNBRCtqM2VvL1Uzci95eldTUjZ1TEx3SkV1?=
 =?gb2312?B?R1FPY0JHaFV4M3dvSmUycEk0b1dwQkd5UU92K2FFUm5vTVFWRnowWm82TFdP?=
 =?gb2312?Q?GVkV6Y4mtHICwdXCKQYou8rnnW5QTxzbZiubxii?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b6c3cc-111b-42ca-103c-08d914e4f8dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 01:26:30.9286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05MReelaDgfT3e+cYMKNOy3kvmvl9/BjY+A2JsvMiUhmMubYc/JbWjWpDEh3cMreoNcA6piqA3tQ7sCuDD8/MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6664
Message-ID-Hash: JUX3WY4A754BHYJ3TEH3J34V3G6QVFI7
X-Message-ID-Hash: JUX3WY4A754BHYJ3TEH3J34V3G6QVFI7
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JHRA2SAKBAY577BLSQ5YXZYW3ZG42R4F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Darrick J. Wong <djwong@kernel.org>
> Subject: Re: [PATCH v5 7/7] fs/xfs: Add dax dedupe support
> 
> On Tue, May 11, 2021 at 11:09:33AM +0800, Shiyang Ruan wrote:
> > Introduce xfs_mmaplock_two_inodes_and_break_dax_layout() for dax files
> > who are going to be deduped.  After that, call compare range function
> > only when files are both DAX or not.
> >
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > ---
> >  fs/xfs/xfs_file.c    |  2 +-
> >  fs/xfs/xfs_inode.c   | 66
> +++++++++++++++++++++++++++++++++++++++++++-
> >  fs/xfs/xfs_inode.h   |  1 +
> >  fs/xfs/xfs_reflink.c |  4 +--
> >  4 files changed, 69 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c index
> > 38d8eca05aee..bd5002d38df4 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -823,7 +823,7 @@ xfs_wait_dax_page(
> >  	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
> >  }
> >
> > -static int
> > +int
> >  xfs_break_dax_layouts(
> >  	struct inode		*inode,
> >  	bool			*retry)
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c index
> > 0369eb22c1bb..0774b6e2b940 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -3711,6 +3711,64 @@ xfs_iolock_two_inodes_and_break_layout(
> >  	return 0;
> >  }
> >
> > +static int
> > +xfs_mmaplock_two_inodes_and_break_dax_layout(
> > +	struct inode		*src,
> > +	struct inode		*dest)
> 
> MMAPLOCK is an xfs_inode lock, so please pass those in here.
> 
> > +{
> > +	int			error, attempts = 0;
> > +	bool			retry;
> > +	struct xfs_inode	*ip0, *ip1;
> > +	struct page		*page;
> > +	struct xfs_log_item	*lp;
> > +
> > +	if (src > dest)
> > +		swap(src, dest);
> 
> The MMAPLOCK (and ILOCK) locking order is increasing inode number, not the
> address of the incore object.  This is different (and not consistent
> with) i_rwsem/XFS_IOLOCK, but those are the rules.

Yes, I misunderstood here.

> 
> > +	ip0 = XFS_I(src);
> > +	ip1 = XFS_I(dest);
> > +
> > +again:
> > +	retry = false;
> > +	/* Lock the first inode */
> > +	xfs_ilock(ip0, XFS_MMAPLOCK_EXCL);
> > +	error = xfs_break_dax_layouts(src, &retry);
> > +	if (error || retry) {
> > +		xfs_iunlock(ip0, XFS_MMAPLOCK_EXCL);
> > +		goto again;
> > +	}
> > +
> > +	if (src == dest)
> > +		return 0;
> > +
> > +	/* Nested lock the second inode */
> > +	lp = &ip0->i_itemp->ili_item;
> > +	if (lp && test_bit(XFS_LI_IN_AIL, &lp->li_flags)) {
> > +		if (!xfs_ilock_nowait(ip1,
> > +		    xfs_lock_inumorder(XFS_MMAPLOCK_EXCL, 1))) {
> > +			xfs_iunlock(ip0, XFS_MMAPLOCK_EXCL);
> > +			if ((++attempts % 5) == 0)
> > +				delay(1); /* Don't just spin the CPU */
> > +			goto again;
> > +		}
> > +	} else
> > +		xfs_ilock(ip1, xfs_lock_inumorder(XFS_MMAPLOCK_EXCL, 1));
> > +	/*
> > +	 * We cannot use xfs_break_dax_layouts() directly here because it may
> > +	 * need to unlock & lock the XFS_MMAPLOCK_EXCL which is not suitable
> > +	 * for this nested lock case.
> > +	 */
> > +	page = dax_layout_busy_page(dest->i_mapping);
> > +	if (page) {
> > +		if (page_ref_count(page) != 1) {
> 
> This could be flattened to:
> 
> 	if (page && page_ref_count(page) != 1) {
> 		...
> 	}

OK.


--
Thanks,
Ruan Shiyang.
> 
> --D
> 
> > +			xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
> > +			xfs_iunlock(ip0, XFS_MMAPLOCK_EXCL);
> > +			goto again;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Lock two inodes so that userspace cannot initiate I/O via file syscalls or
> >   * mmap activity.
> > @@ -3721,10 +3779,16 @@ xfs_ilock2_io_mmap(
> >  	struct xfs_inode	*ip2)
> >  {
> >  	int			ret;
> > +	struct inode		*ino1 = VFS_I(ip1);
> > +	struct inode		*ino2 = VFS_I(ip2);
> >
> > -	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), VFS_I(ip2));
> > +	ret = xfs_iolock_two_inodes_and_break_layout(ino1, ino2);
> >  	if (ret)
> >  		return ret;
> > +
> > +	if (IS_DAX(ino1) && IS_DAX(ino2))
> > +		return xfs_mmaplock_two_inodes_and_break_dax_layout(ino1, ino2);
> > +
> >  	if (ip1 == ip2)
> >  		xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
> >  	else
> > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h index
> > ca826cfba91c..2d0b344fb100 100644
> > --- a/fs/xfs/xfs_inode.h
> > +++ b/fs/xfs/xfs_inode.h
> > @@ -457,6 +457,7 @@ enum xfs_prealloc_flags {
> >
> >  int	xfs_update_prealloc_flags(struct xfs_inode *ip,
> >  				  enum xfs_prealloc_flags flags);
> > +int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
> >  int	xfs_break_layouts(struct inode *inode, uint *iolock,
> >  		enum layout_break_reason reason);
> >
> > diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c index
> > 9a780948dbd0..ff308304c5cd 100644
> > --- a/fs/xfs/xfs_reflink.c
> > +++ b/fs/xfs/xfs_reflink.c
> > @@ -1324,8 +1324,8 @@ xfs_reflink_remap_prep(
> >  	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
> >  		goto out_unlock;
> >
> > -	/* Don't share DAX file data for now. */
> > -	if (IS_DAX(inode_in) || IS_DAX(inode_out))
> > +	/* Don't share DAX file data with non-DAX file. */
> > +	if (IS_DAX(inode_in) != IS_DAX(inode_out))
> >  		goto out_unlock;
> >
> >  	if (!IS_DAX(inode_in))
> > --
> > 2.31.1
> >
> >
> >
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
