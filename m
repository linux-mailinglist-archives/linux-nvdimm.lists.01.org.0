Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD96637B396
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 May 2021 03:37:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 364A8100EB349;
	Tue, 11 May 2021 18:37:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.159.83; helo=esa6.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 108AE100EB341
	for <linux-nvdimm@lists.01.org>; Tue, 11 May 2021 18:37:33 -0700 (PDT)
IronPort-SDR: 53A6+YzlHKCiZBzpNd4zLJ8H9eLmEr+Bvcktaq7ipO7yhC6Atzi9Bv11UVmz+GYc8xWO/Drgwj
 VblyTRrzr7LAdnTceOC1m5r2/iTYfAGUZvgSbHQHQ0bNH7fGr3gjO6ya3wZR3UoeJeGhRkw4+Q
 ugZv4A2Up9+/4JGiSaRiNHbSn1A+PsDhuZwmjgCTErnSKLUy17sfRZeWxIhC9XoHoU3yuBD6Tm
 yQh1cMIX2pqwSCzRlpmn9xCSw4zBvXi28zgk+Kop/07AQpYJg1JJBz0L2RFcIp9nD5TMuysRpp
 8oo=
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="31282675"
X-IronPort-AV: E=Sophos;i="5.82,292,1613401200";
   d="scan'208";a="31282675"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 10:37:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBfPLJQ6t5JPCFDviZP6PdMLwX1JgYyUnRYPI+m5jGt+EGneGJGbE+oo1seveJjEpeBL12/hQnaOaU7rk4ZmZAulcA4FHgKCKxDHHD7xfQx3ztJN+IqiUWWFG3c6SL3O9qDjMSKOoKstWyN0UMBcNnX1DcYT94GPQWEdpbmpEKd1RV309NGBoXWEC8cXk6Ga8sIajWiq44XJrw6Fces38PMnR7VUJbII1n6gIN0i/JMmq5CWNuBHnL3Zt6KyGEJ3pq2JTm8z0xCp9gvy3sgrThviG7mq4MSkfDgrraQjoh7HWlZdHd/HnOb3PrvmRbWFPW5ZNEhfc1Q60fYfRYg07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCW86joLdl60d/7X4s9We6jevS8YWJ2Pc9jZLuMahog=;
 b=erSGbQ3emBW9alt3PrGRUv+i59zY2AH1SSR6SHOdzIGix5mLYZpP3F+q02VfLMPifbCbNCD6bASmP6zFZ4CZwwzUO25tdf8xPT0K6VZwtsVGr2g4Tcr4GgQZ1/5PT5lrHwbcWRTVIdNWThedPBQX0s0ZXIPBWAXbD/dBfiChy8UrkZ4wyavuG+x2gJiG4USQl/mCy9h6rFR67yvKuqXoZhil8M0cZWWb2wBZudGwsDIgfJtY2E96yX/ohPQwcomvtICczKcBExI1/ufQUDKmeTu6ZUEeCGTqawkPBi6Uyt0lzhsMNmr0sSE05i8ZWJuyImiFMgB4m9WF34YmdTvfEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCW86joLdl60d/7X4s9We6jevS8YWJ2Pc9jZLuMahog=;
 b=MFgDSViKYWbDhUZo8fo8Uk8aOWKBcBHLrQk4QvcYsqBjhsexRRiL85hU9popuIh77FDV5TDZkj9RaU2tHqeIVXx96/z3roIoC3DvwnE7TNiV0qprIWRDgC5g1U8FgzK1Hc6h7rfW/iHKMFNJd3VxQjvk+YmLlDD2BcV7m5LTFU0=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB6722.jpnprd01.prod.outlook.com (2603:1096:604:f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 01:37:24 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 01:37:24 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: RE: [PATCH v5 3/7] fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
Thread-Topic: [PATCH v5 3/7] fsdax: Add dax_iomap_cow_copy() for
 dax_iomap_zero
Thread-Index: AQHXRhMzaICBJaaoNUiclL46cJ8Bn6rfDQsAgAADYFA=
Date: Wed, 12 May 2021 01:37:24 +0000
Message-ID: 
 <OSBPR01MB2920F14C201E24027A38204AF4529@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-4-ruansy.fnst@fujitsu.com>
 <20210512011738.GT8582@magnolia>
In-Reply-To: <20210512011738.GT8582@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b32d762-4afc-4ef8-123f-08d914e67e4a
x-ms-traffictypediagnostic: OS3PR01MB6722:
x-microsoft-antispam-prvs: 
 <OS3PR01MB6722635AA9953F17B75B7A99F4529@OS3PR01MB6722.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 k4Tmkp4wLYkVCKhmw8tyXqdVNqNOfg9KE9mzO2C/BKjOEbcM9BOXqnMCWME1sHKuznBmHImowhH7G0OYaaMxx9q2yXqMAoxPZSgkTMNcp7+f//T+AXg3c1bLN+KnVBU9rhOGzARoESP1tWubygTDxLGfOIvvS0P2pvb/NYq0NJeHCC3PKXq7b14iRUF8uBqqGYZe6bhCOwDI9MCLA/i29WdNkruqCJHEebNAoiogIiYDPS2h5wXbEwtxr+EZ1QcyVvBZ5a6aF63loFqPlXWybLCVy68MzpJDypsSHUHK91rXg5r4i/VYLu9PjxZZVMY1usKIUmuuQ7t7oq2bRJnp13NxakirqaYvtCoZqh2IAQmklouYFGX3MB+QNjdomLJ6JRgN5v+M5xCHqUH9mAeL7nmUUsyuMxtUzgf23mwEwsAN6kbRZTaaF8LjZiao3PLzyU0y03NVCRs/ZPccXJAS/S10wvb2UK0tzCj6GJlK2Ar9+l2ds12Cu2U8Bmr6F/RLafCWdpipZrUs4B4qxRsyAlbPKqmhIvJ5WzHfIc2B+fdXgOvgy7TcK8/A/u3N6bbM6K/vO7iA8eLP8lgqkNgSwSs650qw8SymdhgQOS2GQ88=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(122000001)(5660300002)(478600001)(7416002)(7696005)(8676002)(33656002)(66476007)(71200400001)(54906003)(76116006)(316002)(9686003)(6916009)(186003)(64756008)(4326008)(8936002)(2906002)(86362001)(38100700002)(66946007)(66556008)(83380400001)(55016002)(26005)(66446008)(85182001)(6506007)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?TVMrOVN2cUNKU2pyVlhYRkxhb0xEVCtad2xaRDB0U2NLUTczY3EyVk9HWnZm?=
 =?gb2312?B?RWw2MkVrclVrdm1wbitHdkxxQXM4T2pMU0p2RWgzZmVTeVhRZXg0TjRuSXVk?=
 =?gb2312?B?UGkwR3FaeGNqOG9RemErbDQ4bVVUVkh4MlI3aDZBQ2laMER1eGJjRFBWV3hG?=
 =?gb2312?B?TUh0UXBaTGxNV1pZWVZxUmRPbFJIbU41YStrWHlaM1I0YVlZU3l1Yzk3RjFP?=
 =?gb2312?B?SW9JYlpPZEtKbFFZZDdNVDA0K0hhOEQxU205OTBlY2pUdGNrOHB0UHVOM2hU?=
 =?gb2312?B?M1NaSUhwM0EyU3pyR0h1dk5sa0VaU2VLRTdpQlBoM3dpV2xjMDRqTEY3N01M?=
 =?gb2312?B?YjFlY0tnWmNmVmdEU091SDd0RkNTZFRuNVNKTk42N0U4emw0L0dkbjZRMjh6?=
 =?gb2312?B?a1pqN09IK3Q2Wk00bXV5UldxbVFYSmQ0bXY2ZTNHZDZKMHFPaVoxRzhUcmxq?=
 =?gb2312?B?bjdNVjduS0N1NkYwSlVIZWlyMXgwdGIrZ0ZHT0tJR0YzbkwxcG9NZi91aE9I?=
 =?gb2312?B?dzF0VGQwblZJeEpaT3ZMaVU5dnZiZk8vak9keEcrNXgzVEp0OFNrY28zRDMr?=
 =?gb2312?B?Mk5TZDl4b0dkSi9sTHlxcG9XZ0dQMTVjREgyWXRlU2M0cXg0SmYwWjA3RmxJ?=
 =?gb2312?B?RmFhMmM3SkxZYzI0cVdQNUs4d015SjVEby96VExHZHRTZ1ZEaDJ3bGVvUFRB?=
 =?gb2312?B?YjhDdGZFMkRhNGQ4bjV0L2JqLzRzSWxOaVErTm9CcUNVd2lqMlpnQmk1MzIv?=
 =?gb2312?B?aWhpRllNalh6akRyOGNYTFpsTzVkN203QTNGamRjNmE3ZnBSTzRuTnVOTHFZ?=
 =?gb2312?B?L2ZNTmV2bHlCUUR5cTBZck01d0pZZlFoTWVCdEJYVW9uN3BldU01d2tWQURS?=
 =?gb2312?B?c2JlQmI1b240aWJBbEtyRE04eDliNlQ0eVhFcmkyTzN2SnlRQkVJbmlCcTJx?=
 =?gb2312?B?SnBOOE1iVUk5RFFrcEtKdW9TdHJDd3Q2RnhQd2F3NTc1eFA1N1p4Y3k0V2lK?=
 =?gb2312?B?VjVNb1JyaUdIL2puR0EwM1hDZEdubHpvVFJHemdKcUNsNlZ3YWR4K09GVGtm?=
 =?gb2312?B?cnp2SFRSYUJDT1VMdXJrS3lEc3ZwZjR5MWRyNENscHhVUVVESGl6ZDBxUFVE?=
 =?gb2312?B?Z0xlN0wvVk1FNWdsKzkxdWpvSDJvQW1UZVkxc1I2d1g4eXFFb3BXTlZkakNI?=
 =?gb2312?B?ZGlkS3BZUTZUZk15dy9yc0hmVFIybFJ4Nk1CWW9NelhYNVo1cjNQcStWTElt?=
 =?gb2312?B?NEx2dGJEWkNvd1pEUkZXL2duKzdpRk9OVy9hY2d2WHpuOXRBYk1ocGhZdzZo?=
 =?gb2312?B?bXFHeUpHVGNMWWtIVkhVOHJpWmRxM0N5QmErengyTjc4WjRXYk1WN2VVdkpx?=
 =?gb2312?B?ekQ1dFhTMmRVdG1mVzBTaEJnUWhqRXdBSFJ0MXhQWko5d2MxNUdlSzBUSlFU?=
 =?gb2312?B?YnRKU0IzcG8raitUUWRoRXRGbWxsemp1bEx5cStDMmVJMml4MmhoZG9MZ1Zo?=
 =?gb2312?B?RWduMG9zNlNIS0RldzVGeHg4bWNUZmRWMFdBalZpNWNBREo4Skx1L1Fmd1NG?=
 =?gb2312?B?WXpkZE9ScldSeTBZcDgzUitEUkNHZk5lVHhpL285THZMblFmVWxlRVF1Mlo0?=
 =?gb2312?B?UVcvOFZLOVNUdVplSTcvVlJxdThuNzdiSlF4Mi9BZEo0eTlOOUs2R1ZCL2Uy?=
 =?gb2312?B?UkUwbnRMczdrTFJPbXgrZHBMWXdHeXBiUzlReWliOG5rUllQQ1JRd1BnM21H?=
 =?gb2312?Q?/45xLncWqAg2N4vc3m4cZ1bzu62480Cn5F8AeBO?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b32d762-4afc-4ef8-123f-08d914e67e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 01:37:24.1953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7cHTNkyzbhDmnyMkYdxIPBfb7/DVeYJgBlwhYNfhFVAWrOPvhGJLaDQUfTOp+W842nIeAh2wTIpFiDnrrdmXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6722
Message-ID-Hash: KJU27EHMA4MGYLSGT56E6Q6EHBOG6NBU
X-Message-ID-Hash: KJU27EHMA4MGYLSGT56E6Q6EHBOG6NBU
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HARFPS566KNITXMQ7M6JHSKGWFPLXJAL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Darrick J. Wong <djwong@kernel.org>
> Subject: Re: [PATCH v5 3/7] fsdax: Add dax_iomap_cow_copy() for
> dax_iomap_zero
> 
> On Tue, May 11, 2021 at 11:09:29AM +0800, Shiyang Ruan wrote:
> > Punch hole on a reflinked file needs dax_copy_edge() too.  Otherwise,
> > data in not aligned area will be not correct.  So, add the srcmap to
> > dax_iomap_zero() and replace memset() as dax_copy_edge().
> >
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> >  fs/dax.c               | 25 +++++++++++++++----------
> >  fs/iomap/buffered-io.c |  2 +-
> >  include/linux/dax.h    |  3 ++-
> >  3 files changed, 18 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index ef0e564e7904..ee9d28a79bfb 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1186,7 +1186,8 @@ static vm_fault_t dax_pmd_load_hole(struct
> > xa_state *xas, struct vm_fault *vmf,  }  #endif /* CONFIG_FS_DAX_PMD
> > */
> >
> > -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> > +s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
> > +		struct iomap *srcmap)
> >  {
> >  	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
> >  	pgoff_t pgoff;
> > @@ -1208,19 +1209,23 @@ s64 dax_iomap_zero(loff_t pos, u64 length,
> > struct iomap *iomap)
> >
> >  	if (page_aligned)
> >  		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
> > -	else
> > +	else {
> >  		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
> > -	if (rc < 0) {
> > -		dax_read_unlock(id);
> > -		return rc;
> > -	}
> > -
> > -	if (!page_aligned) {
> > -		memset(kaddr + offset, 0, size);
> > +		if (rc < 0)
> > +			goto out;
> > +		if (iomap->addr != srcmap->addr) {
> 
> Why isn't this "if (srcmap->type != IOMAP_HOLE)" ?
> 
> I suppose it has the same effect, since @iomap should never be a hole and we
> should never have a @srcmap that's the same as @iomap, but still, we use
> IOMAP_HOLE checks in most other parts of fs/iomap/.

According to its caller `iomap_zero_range_actor()`, whether srcmap->type is IOMAP_HOLE has already been checked before `dax_iomap_zero()`.  So the check you suggested will always be true...


--
Thanks,
Ruan Shiyang.

> 
> Other than that, the logic looks decent to me.
> 
> --D
> 
> > +			rc = dax_iomap_cow_copy(offset, size, PAGE_SIZE, srcmap,
> > +						kaddr);
> > +			if (rc < 0)
> > +				goto out;
> > +		} else
> > +			memset(kaddr + offset, 0, size);
> >  		dax_flush(iomap->dax_dev, kaddr + offset, size);
> >  	}
> > +
> > +out:
> >  	dax_read_unlock(id);
> > -	return size;
> > +	return rc < 0 ? rc : size;
> >  }
> >
> >  static loff_t
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c index
> > f2cd2034a87b..2734955ea67f 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -933,7 +933,7 @@ static loff_t iomap_zero_range_actor(struct inode
> *inode, loff_t pos,
> >  		s64 bytes;
> >
> >  		if (IS_DAX(inode))
> > -			bytes = dax_iomap_zero(pos, length, iomap);
> > +			bytes = dax_iomap_zero(pos, length, iomap, srcmap);
> >  		else
> >  			bytes = iomap_zero(inode, pos, length, iomap, srcmap);
> >  		if (bytes < 0)
> > diff --git a/include/linux/dax.h b/include/linux/dax.h index
> > b52f084aa643..3275e01ed33d 100644
> > --- a/include/linux/dax.h
> > +++ b/include/linux/dax.h
> > @@ -237,7 +237,8 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault
> > *vmf,  int dax_delete_mapping_entry(struct address_space *mapping,
> > pgoff_t index);  int dax_invalidate_mapping_entry_sync(struct
> address_space *mapping,
> >  				      pgoff_t index);
> > -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
> > +s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
> > +		struct iomap *srcmap);
> >  static inline bool dax_mapping(struct address_space *mapping)  {
> >  	return mapping->host && IS_DAX(mapping->host);
> > --
> > 2.31.1
> >
> >
> >
> 

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
