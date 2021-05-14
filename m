Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DC0380555
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 May 2021 10:35:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1DFA5100EAAFD;
	Fri, 14 May 2021 01:35:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.71.156.121; helo=esa11.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B7EF0100EAAFB
	for <linux-nvdimm@lists.01.org>; Fri, 14 May 2021 01:35:53 -0700 (PDT)
IronPort-SDR: MXMO6ialDwCcnsCgsZW5zH2ZtdJqvk5igowgO1omu/MVHzdfUZz4xog0s7wt/2gOC2V4Abbxeh
 nap91H6pnOQhI0jsi3fd8NYHxG/bVCFNyf7pC1LwWw7Q+DICGgwW/7VGxgsfWN8jHAe3561WvQ
 ZBAXBI/OzN/JaKR8IOBE/lqGnJSPgzbE860wf2oIQ0FM6vIe8DZV5SbyHMFnqHGhOSxyaBKOGl
 QXNyri1uKFiGM0uNmUry7iarQ7G9i9iDVseqxgB90qofF4d+uwHQd7yDO4Lv8BcL+LUOPIIrKp
 eh4=
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="31440383"
X-IronPort-AV: E=Sophos;i="5.82,299,1613401200";
   d="scan'208";a="31440383"
Received: from mail-os2jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 17:35:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YN5BVZc9GkT++JwAeLbRLjOhUfdz1N4nk6OmsGpIgMu8Gv2pTn0xVo+CmQJSK77+gHsTidkfi85KmzZgdASr3W8fKGAnyaDkKio+XqCaQ1WddHFVQCsvl478yBAf451Ejw30swDktw6Ulq5S/JbTh4vVxycwfpt+nb7ZkUmBRR/pS10lLJjbrrOk2PzMr6Legb2nTykw+leOvZPu+2xW67177P0+k4DvnrfmUE0YnpQ79Fbb74IeLCdeQUjBLJyPeGzSm3BLqpBHUKAFdyWiLUfZt7l29IcJT/IUUc0FhBxdRbWb0cVCvMV/vnCZob6UBQft1jTOtNYvv+aBAMwPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQis9JXWTanLDkzD07MqWb13eQqYhbpqdNLmhTqhZzA=;
 b=eARHYzQ6tzQAq7DKqhl0UNUx67WT8We7Gw3NGU4TnQtwUQCoR6i3qqPh6EiSwDo5J+g+9CyxsZ0o4gMF38pyTbQR+sAweTGDUmv3qmHbL4iWjCIt4ahpm0TGIOApR6h3ND5/TUaawRI+C80h+RMbis714waLoCp/LAQRty0wEWbeUeeBvohoRjQgt9zQ6wPGT81uTwOgG62debYTL0DYkxJO/3oPoZg/mK+vE2nOpYgq/59ySpjxcQqkejPgXKs56ZwM03tywaqIdWeM18xdLHMVngiRuM5CZkkuX/xcdZ695O+qMcjdED+SsVJre9/LrufzxJbIus9Bx6ENWIlGMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQis9JXWTanLDkzD07MqWb13eQqYhbpqdNLmhTqhZzA=;
 b=rQ3GgfVgq6v/+bkzXwjquV+eoMJ5v7v5hje7qttQCDNu4iW1M6yiJX+tXnvX6YafREA0KQJ+ofx2WPjFkvN44l3cj6J1OBW9BT8Q7roJ7whoSXA9zWuEG0FMYtkxQkFJmJUOcQ3Ze+F3/5O2F4yZjwHj7RPoX4XYzpDQ5VyQiT8=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSAPR01MB4963.jpnprd01.prod.outlook.com (2603:1096:604:37::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 08:35:44 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4108.032; Fri, 14 May 2021
 08:35:44 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: RE: [PATCH v5 5/7] fsdax: Dedup file range to use a compare function
Thread-Topic: [PATCH v5 5/7] fsdax: Dedup file range to use a compare function
Thread-Index: AQHXRhM6cq5EsgJhOkif8HCLojlGfKrfDrUAgAOVHuA=
Date: Fri, 14 May 2021 08:35:44 +0000
Message-ID: 
 <OSBPR01MB292047344E0119E78E4D443CF4509@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-6-ruansy.fnst@fujitsu.com>
 <20210512012336.GU8582@magnolia>
In-Reply-To: <20210512012336.GU8582@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c052c9b3-3775-4a7b-d549-08d916b34427
x-ms-traffictypediagnostic: OSAPR01MB4963:
x-microsoft-antispam-prvs: 
 <OSAPR01MB496376401D6822F392250865F4509@OSAPR01MB4963.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qrjU2DWtJowbvqrVEMw5BeGclPkd/eHdZQwjJhDZoijK+nf7n0+0oS4UbZt6uogoS+1yN9+n2blvbFU769ZdF1sFHNCvQZJ3cm7i9zZdY6EirZ/5jmUaMey70xtB0AfFy4MrgxJpETGkzXbj1Ssqeo8w4EabjpD6EIxo3PUVjwQO7Ys05ZHkRTSrZGv/c5ehdTtspPFOxYrWrmIgxymBNx3dR+dYyt2DWC8mzJmvT9YDwjCNZmI4qm1hjHcydzkBwTASFqYdPoirn8aFdMhLNqJB6qec8bsm8eT71+lu1FvM7urhOz616PkI/nHXN9+jG6qq3vo6gzbuIq8yCCcCS5DWT7jBIys9txIfv69BF1DDiR82PT9y3FGQuXM9DTSUwutIAHGC7E3Zl6jJOd2lONJK7Mrf7R3YaWy6slzq1wCNyQogVyIG1iFfZekBZiZnqQaJf+Uir5FxHdo4O9Ng3UZ6k0YqzsNlwC8n5OXvoeYc5QG5gxr1LFCMNYMONlGNaiW/hazMaRExh/w6AZVQFhfhOlMS1inARW74ZemAGwJ9mTIuXlqY3NgV4pvj83Xl1aUuY0eAFK6XGn+gvOzeZOVKFVU+FFN6l2/V209qP+0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(9686003)(83380400001)(38100700002)(7416002)(55016002)(30864003)(6506007)(86362001)(122000001)(85182001)(52536014)(186003)(5660300002)(6916009)(33656002)(478600001)(26005)(66556008)(66476007)(8936002)(64756008)(7696005)(54906003)(2906002)(66946007)(76116006)(4326008)(71200400001)(316002)(8676002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?LzR2b3RhdmxERmV2UkJGNmN0Ylc2dmN0Q1pJSHc4bFFPYXZoeWVMcUVzK0Ro?=
 =?gb2312?B?WEhXQm5jQkUrOHY0WktNRDlNejY3TnMyK05vM3I1djVCb01zSW5QRWRyeks5?=
 =?gb2312?B?Y29hYnZDa3k4SFNCOVQxL3dkTUpaSjJzbDkzUVl1b1puWDZqVnBDSDh5MEww?=
 =?gb2312?B?QVBqcHJWYnJMTXNzcUpQcnBkUGNrMDl6ZzhOMVJGL0dlWVZoclJ0NVJISUhP?=
 =?gb2312?B?SnJBM2RSNzNlSi9EV1M4YjZBemRpaktJTnd5ZTJ3bFMzODlJSmJRWEY5K253?=
 =?gb2312?B?UjdLVEdYUFEyT1Rqd2xHbHpXcHFSNUJPWXRHcE9PQ1dMTFlzdXorQU96c1FG?=
 =?gb2312?B?QjFMOEdRWFJsY3JzRnh4UUFJUUdNM3RvOTUxMmVUQ0dIV21JOE9qMGRHbXA1?=
 =?gb2312?B?azBMdHMyQlhnVzdSTWNuWTA2STVSWDBpOFlWZTlJOUNCa2pNZURMMnFVcWdo?=
 =?gb2312?B?ZzNvWVNnY1Y1L2RqeThnd1ZFTy9IWWV0elVHZnVtc0U0c1g4WHdDdERvY2xY?=
 =?gb2312?B?RnV0eDVqb2wvVTdjbmplZUF0L0ZaLzFqMi9HYVBuWVJwQWliMU5TMGlPa2pp?=
 =?gb2312?B?bGJubkg3NVNmdkNKenVQRXpIK3lvTmFlb3pzeDhQeTF6MUNNbFkxWmhSeHpC?=
 =?gb2312?B?SkJVVlppWFhTMGwxaklVSmNGaThqNGVNUWRrSjFhdVJjU3drSGwwWGRrVXVS?=
 =?gb2312?B?V1FLa0Yydy85SUsvZUxGa1ljNTJkcm94NlF1TTlDRGo1SFRYZkhsMHg4eUdQ?=
 =?gb2312?B?ZkF3VDVxRWQrbmh4eTk1OGlIZEZvVjlmTDJMeG8xeTFCT1N6ZWp3VS9kZVZz?=
 =?gb2312?B?b2JyZ2JhRnlic3Foa3lrdHJHT2FkT3FyTnF3bkUzazA4M2JvRm5pY2dpdVN1?=
 =?gb2312?B?cmZpelI5V0dmdGc3Q0t0QUFOak0xcmJ2MGJ5ZzFQMU95b2VCNDdkV1pUbkZ4?=
 =?gb2312?B?LzByN1ZZWWRoZG5FNGdsOWRzczJVZmdNK2tmdVRNUXg1RkdLZmZmanRlbnRN?=
 =?gb2312?B?bFpCRU83UmQwSCtZMWwvKzd0blQ1UGJNdnJ3ckJBaU5mWEtnN3BRa1poVXRy?=
 =?gb2312?B?b1FjU0YxTUhkWmdVVUx0TVA1Z1ZVUDhvNG1tRHBRd25vQ1pSaXZXTVhWMWNJ?=
 =?gb2312?B?WTdqWHJJNlFOQjVCYlFLK1RmQ25sNGFuZ1MzanEvZ25XazljTmRPVndXOEo4?=
 =?gb2312?B?WFI0dDFnNVpJWkFwMU0wS1JaVWdqOTdwVGh5TGpNczNyMlduSjFQcE1UamdG?=
 =?gb2312?B?NHMzWTlHdXNyb1RwaW05TXpLN085QWViK0NEby9FeHRReDA4TUt4cVVBbGds?=
 =?gb2312?B?TmFPWDdjMU5lakxQelFsYVBSL2ROVjR5Z1hlTVFNbSs4QmFuN0JhQTRjaVdQ?=
 =?gb2312?B?b0pTRElRcWRkRnFuUjhrT2VSVkhQV3VpM3VXZHFxUEl1UDc4dUxXV2oxdFFa?=
 =?gb2312?B?ZWFFdHl1WThyVUVEQlY1K1JZeDd5cXpFQ1dURlMwZmhicHhhR3F2d2J0UWk0?=
 =?gb2312?B?SFpRZzVyMEtoMllFV0Fpa2NnclRvdzlYcEFhYzJ1eVBZbENmZlVrNkpaL2dN?=
 =?gb2312?B?bCszaFlRQ25zd2JYY3crMWRKUU5PbmlkblRIc3pmN3RVblFMZ0UyVzhqem5L?=
 =?gb2312?B?SWlaSnhJVndTWkI0UXlHMThoTmxYQjFFUWM2NGNleVJTU1k5ZjR6ZlNidUl3?=
 =?gb2312?B?WmpwRlFndXk4WXNuOGJ2c0RIcHhoSHVsNHRXcjhEdnRNbStpMmhUWWJWdXVO?=
 =?gb2312?Q?9jJoqdm6tRA8r2lT4y1sCubYZwUHCuc3OfnQEib?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c052c9b3-3775-4a7b-d549-08d916b34427
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 08:35:44.6554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gm9yK5JIZy4AUmbqdV0aMNEB6Xq4U/GgHOplFcorK7BMZuhvkCbp9pnNKZaNWEyYORL5tqTopI+EFbNnzBNL2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4963
Message-ID-Hash: U5R5XKTEPD3X5J67I7YTA3STFNT2NSC5
X-Message-ID-Hash: U5R5XKTEPD3X5J67I7YTA3STFNT2NSC5
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GUF6X3NZ5Q7G5PCVGBVVEF2XI3TMKHXX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Darrick J. Wong <djwong@kernel.org>
> Subject: Re: [PATCH v5 5/7] fsdax: Dedup file range to use a compare function
> 
> On Tue, May 11, 2021 at 11:09:31AM +0800, Shiyang Ruan wrote:
> > With dax we cannot deal with readpage() etc. So, we create a dax
> > comparison funciton which is similar with
> > vfs_dedupe_file_range_compare().
> > And introduce dax_remap_file_range_prep() for filesystem use.
> >
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > ---
> >  fs/dax.c             | 56
> +++++++++++++++++++++++++++++++++++++++++++
> >  fs/remap_range.c     | 57
> +++++++++++++++++++++++++++++++++++++-------
> >  fs/xfs/xfs_reflink.c |  8 +++++--
> >  include/linux/dax.h  |  4 ++++
> >  include/linux/fs.h   | 12 ++++++----
> >  5 files changed, 123 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index ee9d28a79bfb..dedf1be0155c 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1853,3 +1853,59 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault
> *vmf,
> >  	return dax_insert_pfn_mkwrite(vmf, pfn, order);  }
> > EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
> > +
> > +static loff_t dax_range_compare_actor(struct inode *ino1, loff_t pos1,
> > +		struct inode *ino2, loff_t pos2, loff_t len, void *data,
> > +		struct iomap *smap, struct iomap *dmap) {
> > +	void *saddr, *daddr;
> > +	bool *same = data;
> > +	int ret;
> > +
> > +	if (smap->type == IOMAP_HOLE && dmap->type == IOMAP_HOLE) {
> > +		*same = true;
> > +		return len;
> > +	}
> > +
> > +	if (smap->type == IOMAP_HOLE || dmap->type == IOMAP_HOLE) {
> > +		*same = false;
> > +		return 0;
> > +	}
> > +
> > +	ret = dax_iomap_direct_access(smap, pos1, ALIGN(pos1 + len, PAGE_SIZE),
> > +				      &saddr, NULL);
> > +	if (ret < 0)
> > +		return -EIO;
> > +
> > +	ret = dax_iomap_direct_access(dmap, pos2, ALIGN(pos2 + len, PAGE_SIZE),
> > +				      &daddr, NULL);
> > +	if (ret < 0)
> > +		return -EIO;
> > +
> > +	*same = !memcmp(saddr, daddr, len);
> > +	return len;
> > +}
> > +
> > +int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> > +		struct inode *dest, loff_t destoff, loff_t len, bool *is_same,
> > +		const struct iomap_ops *ops)
> > +{
> > +	int id, ret = 0;
> > +
> > +	id = dax_read_lock();
> > +	while (len) {
> > +		ret = iomap_apply2(src, srcoff, dest, destoff, len, 0, ops,
> > +				   is_same, dax_range_compare_actor);
> > +		if (ret < 0 || !*is_same)
> > +			goto out;
> > +
> > +		len -= ret;
> > +		srcoff += ret;
> > +		destoff += ret;
> > +	}
> > +	ret = 0;
> > +out:
> > +	dax_read_unlock(id);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(dax_dedupe_file_range_compare);
> > diff --git a/fs/remap_range.c b/fs/remap_range.c index
> > e4a5fdd7ad7b..7bc4c8e3aa9f 100644
> > --- a/fs/remap_range.c
> > +++ b/fs/remap_range.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/compat.h>
> >  #include <linux/mount.h>
> >  #include <linux/fs.h>
> > +#include <linux/dax.h>
> >  #include "internal.h"
> >
> >  #include <linux/uaccess.h>
> > @@ -199,9 +200,9 @@ static void vfs_unlock_two_pages(struct page *page1,
> struct page *page2)
> >   * Compare extents of two files to see if they are the same.
> >   * Caller must have locked both inodes to prevent write races.
> >   */
> > -static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> > -					 struct inode *dest, loff_t destoff,
> > -					 loff_t len, bool *is_same)
> > +int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> > +				  struct inode *dest, loff_t destoff,
> > +				  loff_t len, bool *is_same)
> >  {
> >  	loff_t src_poff;
> >  	loff_t dest_poff;
> > @@ -280,6 +281,7 @@ static int vfs_dedupe_file_range_compare(struct
> > inode *src, loff_t srcoff,
> >  out_error:
> >  	return error;
> >  }
> > +EXPORT_SYMBOL(vfs_dedupe_file_range_compare);
> >
> >  /*
> >   * Check that the two inodes are eligible for cloning, the ranges
> > make @@ -289,9 +291,11 @@ static int
> vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> >   * If there's an error, then the usual negative error code is returned.
> >   * Otherwise returns 0 with *len set to the request length.
> >   */
> > -int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > -				  struct file *file_out, loff_t pos_out,
> > -				  loff_t *len, unsigned int remap_flags)
> > +static int
> > +__generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > +				struct file *file_out, loff_t pos_out,
> > +				loff_t *len, unsigned int remap_flags,
> > +				const struct iomap_ops *dax_read_ops)
> >  {
> >  	struct inode *inode_in = file_inode(file_in);
> >  	struct inode *inode_out = file_inode(file_out); @@ -351,8 +355,17 @@
> > int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> >  	if (remap_flags & REMAP_FILE_DEDUP) {
> >  		bool		is_same = false;
> >
> > -		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
> > -				inode_out, pos_out, *len, &is_same);
> > +		if (!IS_DAX(inode_in))
> > +			ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
> > +					inode_out, pos_out, *len, &is_same); #ifdef
> CONFIG_FS_DAX
> > +		else if (dax_read_ops)
> > +			ret = dax_dedupe_file_range_compare(inode_in, pos_in,
> > +					inode_out, pos_out, *len, &is_same,
> > +					dax_read_ops);
> > +#endif /* CONFIG_FS_DAX */
> 
> Hmm, can you add an entry to the !IS_ENABLED(CONFIG_DAX) part of dax.h
> that defines dax_dedupe_file_range_compare as a dummy function that returns
> -EOPNOTSUPP?  We try not to sprinkle preprocessor directives into the middle
> of functions, per Linus rules.

I found that it's ok to build without the #ifdef and #endif here, even though CONFIG_FS_DAX is disabled.
And like other dax functions in fs/dax.c, such as dax_iomap_rw(), it is declared in include/linux/dax.h without IS_ENABLED() or #ifdef wrapped.  And xfs calls it directly and it won't cause build error.  So, I think I could just remove the #ifdef here, but I am not sure if this obeys the rule.

> 
> > +		else
> > +			return -EINVAL;
> >  		if (ret)
> >  			return ret;
> >  		if (!is_same)
> > @@ -370,6 +383,34 @@ int generic_remap_file_range_prep(struct file
> > *file_in, loff_t pos_in,
> >
> >  	return ret;
> >  }
> > +
> > +#ifdef CONFIG_FS_DAX
> > +int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > +			      struct file *file_out, loff_t pos_out,
> > +			      loff_t *len, unsigned int remap_flags,
> > +			      const struct iomap_ops *ops) {
> > +	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
> > +					       pos_out, len, remap_flags, ops); } #else int
> > +dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > +			      struct file *file_out, loff_t pos_out,
> > +			      loff_t *len, unsigned int remap_flags,
> > +			      const struct iomap_ops *ops) {
> > +	return -EOPNOTSUPP;
> > +}
> > +#endif /* CONFIG_FS_DAX */
> > +EXPORT_SYMBOL(dax_remap_file_range_prep);
> 
> I think this symbol belongs in fs/dax.c and the declaration in dax.h?

For the function name, it does should belong to fs/dax.  But if so, __generic_remap_file_range_prep() needs to be called in fs/dax.  I don't think this is good.


--
Thanks,
Ruan Shiyang.

> 
> --D
> 
> > +int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > +				  struct file *file_out, loff_t pos_out,
> > +				  loff_t *len, unsigned int remap_flags) {
> > +	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
> > +					       pos_out, len, remap_flags, NULL); }
> >  EXPORT_SYMBOL(generic_remap_file_range_prep);
> >
> >  loff_t do_clone_file_range(struct file *file_in, loff_t pos_in, diff
> > --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c index
> > 060695d6d56a..d25434f93235 100644
> > --- a/fs/xfs/xfs_reflink.c
> > +++ b/fs/xfs/xfs_reflink.c
> > @@ -1329,8 +1329,12 @@ xfs_reflink_remap_prep(
> >  	if (IS_DAX(inode_in) || IS_DAX(inode_out))
> >  		goto out_unlock;
> >
> > -	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
> > -			len, remap_flags);
> > +	if (!IS_DAX(inode_in))
> > +		ret = generic_remap_file_range_prep(file_in, pos_in, file_out,
> > +				pos_out, len, remap_flags);
> > +	else
> > +		ret = dax_remap_file_range_prep(file_in, pos_in, file_out,
> > +				pos_out, len, remap_flags, &xfs_read_iomap_ops);
> >  	if (ret || *len == 0)
> >  		goto out_unlock;
> >
> > diff --git a/include/linux/dax.h b/include/linux/dax.h index
> > 3275e01ed33d..32e1c34349f2 100644
> > --- a/include/linux/dax.h
> > +++ b/include/linux/dax.h
> > @@ -239,6 +239,10 @@ int dax_invalidate_mapping_entry_sync(struct
> address_space *mapping,
> >  				      pgoff_t index);
> >  s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
> >  		struct iomap *srcmap);
> > +int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> > +				  struct inode *dest, loff_t destoff,
> > +				  loff_t len, bool *is_same,
> > +				  const struct iomap_ops *ops);
> >  static inline bool dax_mapping(struct address_space *mapping)  {
> >  	return mapping->host && IS_DAX(mapping->host); diff --git
> > a/include/linux/fs.h b/include/linux/fs.h index
> > c3c88fdb9b2a..e2c348553d87 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -71,6 +71,7 @@ struct fsverity_operations;  struct fs_context;
> > struct fs_parameter_spec;  struct fileattr;
> > +struct iomap_ops;
> >
> >  extern void __init inode_init(void);
> >  extern void __init inode_init_early(void); @@ -2126,10 +2127,13 @@
> > extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file
> > *,  extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
> >  				       struct file *file_out, loff_t pos_out,
> >  				       size_t len, unsigned int flags); -extern int
> > generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > -					 struct file *file_out, loff_t pos_out,
> > -					 loff_t *count,
> > -					 unsigned int remap_flags);
> > +int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > +				  struct file *file_out, loff_t pos_out,
> > +				  loff_t *count, unsigned int remap_flags); int
> > +dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > +			      struct file *file_out, loff_t pos_out,
> > +			      loff_t *len, unsigned int remap_flags,
> > +			      const struct iomap_ops *ops);
> >  extern loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
> >  				  struct file *file_out, loff_t pos_out,
> >  				  loff_t len, unsigned int remap_flags);
> > --
> > 2.31.1
> >
> >
> >
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
