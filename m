Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4E935920C
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 04:30:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5559A100EAAFD;
	Thu,  8 Apr 2021 19:30:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.159.88; helo=esa8.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D5EF6100EAAFC
	for <linux-nvdimm@lists.01.org>; Thu,  8 Apr 2021 19:30:49 -0700 (PDT)
IronPort-SDR: XZGTerV/SiZ99rYsFSRBpK7RPQBVLL+pfkREqBrYq40/LnSxFKKei6DZzX/KfvzgxWgLidSDrm
 WxB2P/d7smmHHzPTuuxGVl69CTy/oaMty6Fvl9/oC5k0m6nyGrZgueCETb29STjEFMkry6tdS0
 KQWLVyvIPQEsbFjJovOc3R10XNroA2UoP6D/Xu9ZfhemRuddRj2BJ86+lHAnQY1JimXGLzqX4/
 3xyC6FHruW3LDcxpxMfzs2HooFCV16SfRPN/NP9+AXpmBHj5z2LD+wqmlTBILQCKSk1r6jVJLH
 01w=
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="29361394"
X-IronPort-AV: E=Sophos;i="5.82,208,1613401200";
   d="scan'208";a="29361394"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 11:30:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQz0DIaoofCnPtN1D5aDzQ6ZB+TVhwSHbZYj9HT3r5bmpKncGggC1C4n60uh8GNXQjsb9v621HNajW5MwSPzFSyc4OAjnHHPHHLLxcpD4pOzzc630UpAjNS+jtBKuMH4roJJKrV29XJPYMqLFsDvLZzT80mxz6gezmrCIh1Vu+Gn5z/zDEGS9rluOtD3HOSzor1lKFjous/TCdgmtx0GWl2FgTa9Dg9mJ/Nk4gqXKgBUyfdhhRcsEviBSANsTHAYZhsINvgN+cNVC7+Mx9+OlsmG+pk1ULYbBXW/Rhyt+N8uvAJIPKTdkdk9ivbeZYTbnnO4JYKz1P3M/k7bXaCqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6EwXUeyaIs2sGAiwtlfAZXUfGtncDXc8SRTtPLQkAk=;
 b=UPOtZjbaRpVrkEX9f+Gm95iFKw5vvG/0JBEo0IBEeCVIpm49U+Rrb6gSSQVPX1fHr+/9JiDbuFeBku6MhA3vt1sDm7SYf2ZlYs4VXN8/+JLFp5VSxZrvq+hLDhKw48C/+TcrXe/IbeWiMRwdiuBn7NwBA/pUMBoUJ2vt5lNV6bFLRD7FWDyC3OTnetJQU9fgIWaR6B/XNx+3PbAAKaDdUbFqqQUMHkgTZNsAR0FnYWZqJ5xZkAYyEq8MdBXG+TNBu4GIott/NwylxcsGRb18JwCeU45+DI778+STWObIvPdjxMDL+3+hGJtcDu1+N04Nj8IchUZflA0d5bLXyRrIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6EwXUeyaIs2sGAiwtlfAZXUfGtncDXc8SRTtPLQkAk=;
 b=PIbxBQj/4748a6Mf2yUYnXfusMdS+dEfEYdL7beTe0SNjX7zFEU2zrYsQsSadyCpoUKeWKq0W2AuyxBPIxV8qBPab361QlMr9dt6Myi2mGW2IsFEe19T/8S+GBaiJSFUdfp43IYCQuh+ZJ2bkUPsud6h7frWRxtoANzmN4P0uvg=
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com (2603:1096:603:3f::16)
 by OSBPR01MB3302.jpnprd01.prod.outlook.com (2603:1096:604:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 9 Apr
 2021 02:30:39 +0000
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::5a:7b3b:1e18:3152]) by OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::5a:7b3b:1e18:3152%4]) with mapi id 15.20.3999.032; Fri, 9 Apr 2021
 02:30:38 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: RE: [PATCH v4 1/7] fsdax: Introduce dax_iomap_cow_copy()
Thread-Topic: [PATCH v4 1/7] fsdax: Introduce dax_iomap_cow_copy()
Thread-Index: AQHXLG9+3xG/bxK25Ue6JPs+lQvHQaqrKkqAgABIUpA=
Date: Fri, 9 Apr 2021 02:30:38 +0000
Message-ID: 
 <OSAPR01MB2913D304AA481F9E851DF9F2F4739@OSAPR01MB2913.jpnprd01.prod.outlook.com>
References: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
 <20210408120432.1063608-2-ruansy.fnst@fujitsu.com>
 <20210408215317.GY3957620@magnolia>
In-Reply-To: <20210408215317.GY3957620@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86fa4f93-4178-42ef-cfdc-08d8faff76aa
x-ms-traffictypediagnostic: OSBPR01MB3302:
x-microsoft-antispam-prvs: 
 <OSBPR01MB330242D67A5BA8BE93EA03C6F4739@OSBPR01MB3302.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 O7wjJvwMZs5qBL5UGVUmqcv6amRBoXssDNHYgeEPrR4UCLDWCrbStXjD2kyvOLGSnOufxcEXCAT5JWUqnqMAMnrrsMxi/O06O/WiXmh0gb+6/eD2v019NBWhTqw3QwPH/kV0Fp4ouhjxF9+wTS2KOtn4kf2Q4kguT7NFGTSqAx4uE9F/GjqLx5n/fCNpPbS4lgi+rHCZp+28jFFF3VjgUkqNm/n+hZWtT9oJ7CxH2NE+vvGIHeEYrDF7IuhcXJCqsS+xGVOKP19ULe7U4OcEP66s6BMIGpCemOdW2vvyhgYyCfgh/fVizQ8/Akjf163N5T/XqgBQjRlgpvoPsZzsYhEs4SxXZO3tp7NhIPiJrP4QauK6MCzgfmcnqdHF1L+jKKAZDhACKqnh9vJNTDniqnOZUoFQ9Hvb1VCMcokUuA9ruWDK6uUDmrtyrAk1Ct+aPMmkSuBaglgC5XsQKhvhm2ztKMrKW1+3IQx2165kbIByGkIfY+LYnspG9WFfo9cUPjtrrjZ9fjqMp6tfEmfrJhC5rcv/0HW/+1adm+kghqpon3NnvTKUOjH4k+BvqXWcOSeGBROTpoutn029wepiLi4TDL5VPvswKu4tBqbguMH6L1evby9W7Bm0VE2XUj0CANVrGXbR09ErbA7wlhTdgk3w1m4kdjC0OScg2/fcTDY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2913.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(38100700001)(53546011)(71200400001)(6506007)(54906003)(7416002)(26005)(478600001)(4326008)(8676002)(316002)(186003)(9686003)(66476007)(66946007)(66446008)(66556008)(64756008)(55016002)(86362001)(6916009)(2906002)(52536014)(8936002)(83380400001)(33656002)(85182001)(76116006)(5660300002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?K1pmL3RRR2FyZWVaYmFnSkNSZUtKalZvcDIzU0kxNVVXRThkSXhxLzlXOUov?=
 =?gb2312?B?alpMZVdwenViUXNiZnBQTVYyOWZ6bUFGT1lnUmpWbytIcE1KS0J4c3gxUGh1?=
 =?gb2312?B?b3hFWk5JZlA0dUZ5SjZ5VnB4dU4rcnlpUGFiZ2RPbXk5SVBBWWo3Q2hlb29R?=
 =?gb2312?B?WWxyR2lhSjcyb2tRbFlxVThXNjVPdWg4WVN1OGhhRzJtNnZlNXBnKzRnaURt?=
 =?gb2312?B?amV5NzBJVGdnM2dlSnBLRGJFU2E0bFBNT1NkMjFXTzNlL0hSenpBQjdGa1hs?=
 =?gb2312?B?QzFMeS9qUFRLTHlpd3hDV3YwRm5hd095ZG9Ka1c4SGVpRW5lclJGZGd1WGlG?=
 =?gb2312?B?am5iS1l0WHFxNlJWZW1YeHlBY3dhcE1DU2VJZStNVEovOHg0WSthdysxZ2lF?=
 =?gb2312?B?dlcyenI5Y0plV0VOY2FXVDc2QXpQcFViUjN5OUNsNDBpT3pYbjhEOFNxbXQ2?=
 =?gb2312?B?YmtGaXBKZVMveUk2U1dLSzltMnNwdFdyQlZXUWV6UUQ2aisybWx1ZFIxSFdp?=
 =?gb2312?B?WEhUZzdTc25ZQ1VEaHB3MUZka0xmRE0zS3ZEbjMyM0dQWVcrb2h3eGZXOVFV?=
 =?gb2312?B?YlZBeVZFWUlsQloxbVV1UFR2SDRuTHJtYVBULzFINDNzbTdkUEMzOFpWeTVG?=
 =?gb2312?B?NXBSamliSjlTWHZKTFF4QnJETWEyWWhueDliUFlEVGhPem5YQWxPcDRsRko2?=
 =?gb2312?B?c3RWN1prNWJaaUx5VXk4MUFkYkFheCtrOS9KbktGUklQTjg1dXB0K0ZyZGk1?=
 =?gb2312?B?RERmOG9nYjZCTEFPaUtsZTZ6YUM5RjlDVHVUdEo2OHpLVEVWVldsRXJqOGd4?=
 =?gb2312?B?Q0lUZ1ltMWZ5aVpKSkNaWE5LMVZEVElocWR3dUc1aW5ObHhkWjR6bXJ0TCtW?=
 =?gb2312?B?cUJCT1lLSDUwNHl6QXU1dmtnNGxDRTc5WkhPaWMwSmZnMWZnQnc0L0VlZk9X?=
 =?gb2312?B?eXI4c2FhZ0ZOcEkrVXpEbXdSbVphUjlML0MzSTRibXZQdXlobEh2bzgvS3Jw?=
 =?gb2312?B?VEY2NGZEcFJTZU4yaUZrNDB6S1ArQUZuTmI5SFk1WU1vbjJCb0U3aUdaeTJn?=
 =?gb2312?B?MGdVZ0lCRVViYXNMRU5SQjdVVWZrRDk2ajJhS1U5WnhTMjhBQ1pRbXJ5cjd3?=
 =?gb2312?B?amIvZVlnR2pDemEvUmIvano2U0t0Z1lOVCtXQ2MreGxzTW1TUzUvWFpTMG5E?=
 =?gb2312?B?SUEzNWppT1lOS0I1Y25YY1FpMjF1MkRSUXhJakJqR0dGbUhuZ2FjUHFIQnNI?=
 =?gb2312?B?ZnliL0hiczh6MUhRMTlMc1hvRlRwT2dnc211WUdkMTBmS1JWVExJOEFWblk1?=
 =?gb2312?B?TzdKa1FkZGhZeGowZjJjWW1JSVM5aEFOL3l0QXhabVZ5RjNXZmZpY0ZZNVVV?=
 =?gb2312?B?QjBnK3B3aHJJMWxRQW93SUpoYld2YWJ6bUxLMGRLL21ZRXExam81NVhIRjlE?=
 =?gb2312?B?RWJnTmE1VzFIQmdEdVgzcW5YaWVqS2hjMmQ4SDRibFIyc0IyM1JoVGJaczVn?=
 =?gb2312?B?M00wTWRMWFYzWTduSjhkejd6d3gvMWhqdE5LK0hzRERCTjNHS2hvWHdTTnpI?=
 =?gb2312?B?dDc2UmZYN090a2gvVFRlNVN3ZUNPR0pZQVZXOGpPTkRPSzZOWS9qL3QxQ1ZM?=
 =?gb2312?B?R0ovODF6bWc3WFIyQVgwYWVldlZ6SC9HTG9ZWGUrc0g0eVcrV2toVWJFUFVr?=
 =?gb2312?B?RWs3UGVXOWwrK1NTMzExbnAwMkd1ak9MalkxOTVma2N6UExTK0NvMDZGNi80?=
 =?gb2312?Q?rl71pLtx87P+eS0LkY80I0JYJsFHZ7xI5aQRBTi?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2913.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fa4f93-4178-42ef-cfdc-08d8faff76aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 02:30:38.6316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mAYrngUU0Rs06MdMfvZrv5wmilETy/zzs3/kMyQC62p6xGsTHCSpC0bnb8D50gfiZbUXMjrfDZtQ9YqEXO/xgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3302
Message-ID-Hash: E57NWYDRDUFL5AOKGP5VESK3LUHQIHPT
X-Message-ID-Hash: E57NWYDRDUFL5AOKGP5VESK3LUHQIHPT
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YQUUQIIPG2MBDIPYUKXV3LWKXQGQ4KDU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> -----Original Message-----
> From: Darrick J. Wong <djwong@kernel.org>
> Sent: Friday, April 9, 2021 5:53 AM
> Subject: Re: [PATCH v4 1/7] fsdax: Introduce dax_iomap_cow_copy()
> 
> On Thu, Apr 08, 2021 at 08:04:26PM +0800, Shiyang Ruan wrote:
> > In the case where the iomap is a write operation and iomap is not
> > equal to srcmap after iomap_begin, we consider it is a CoW operation.
> >
> > The destance extent which iomap indicated is new allocated extent.
> > So, it is needed to copy the data from srcmap to new allocated extent.
> > In theory, it is better to copy the head and tail ranges which is
> > outside of the non-aligned area instead of copying the whole aligned
> > range. But in dax page fault, it will always be an aligned range.  So,
> > we have to copy the whole range in this case.
> >
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/dax.c | 82
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 77 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 8d7e4e2cc0fb..b4fd3813457a 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1038,6 +1038,61 @@ static int dax_iomap_direct_access(struct iomap
> *iomap, loff_t pos, size_t size,
> >  	return rc;
> >  }
> >
> > +/**
> > + * dax_iomap_cow_copy(): Copy the data from source to destination before
> write.
> > + * @pos:	address to do copy from.
> > + * @length:	size of copy operation.
> > + * @align_size:	aligned w.r.t align_size (either PMD_SIZE or PAGE_SIZE)
> > + * @srcmap:	iomap srcmap
> > + * @daddr:	destination address to copy to.
> > + *
> > + * This can be called from two places. Either during DAX write fault,
> > +to copy
> > + * the length size data to daddr. Or, while doing normal DAX write
> > +operation,
> > + * dax_iomap_actor() might call this to do the copy of either start
> > +or end
> > + * unaligned address. In this case the rest of the copy of aligned
> > +ranges is
> > + * taken care by dax_iomap_actor() itself.
> 
> Er... what?  This description is very confusing to me.  /me reads the code,
> and ...
> 
> OH.
> 
> Given a range (pos, length) and a mapping for a source file, this function copies
> all the bytes between pos and (pos + length) to daddr if the range is aligned to
> @align_size.  But if pos and length are not both aligned to align_src then it'll
> copy *around* the range, leaving the area in the middle uncopied waiting for
> write_iter to fill it in with whatever's in the iovec.
> 
> Yikes, this function is doing double duty and ought to be split into two functions.
> 
> The first function does the COW work for a write fault to an mmap region and
> does a straight copy.  Page faults are always aligned, so this functionality is
> needed by dax_fault_actor.  Maybe this could be named dax_fault_cow?
> 
> The second function does the prep COW work *around* a write so that we
> always copy entire page/blocks.  This cow-around code is needed by
> dax_iomap_actor.  This should perhaps be named dax_iomap_cow_around()?

Two functions seems easier to understand.  But I think the code from dax_iomap_direct_access() to its above will be redundant in this two functions.
How about make the description better?

> 
> > + * Also, note DAX fault will always result in aligned pos and pos + length.
> > + */
> > +static int dax_iomap_cow_copy(loff_t pos, loff_t length, size_t align_size,
> > +		struct iomap *srcmap, void *daddr)
> > +{
> > +	loff_t head_off = pos & (align_size - 1);
> > +	size_t size = ALIGN(head_off + length, align_size);
> > +	loff_t end = pos + length;
> > +	loff_t pg_end = round_up(end, align_size);
> > +	bool copy_all = head_off == 0 && end == pg_end;
> > +	void *saddr = 0;
> > +	int ret = 0;
> > +
> > +	ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (copy_all) {
> > +		ret = copy_mc_to_kernel(daddr, saddr, length);
> > +		return ret ? -EIO : 0;
> 
> I find it /very/ interesting that copy_mc_to_kernel takes an unsigned int
> argument but returns an unsigned long (counting the bytes that didn't get
> copied, oddly...but that's an existing API so I guess I'll let it go.)
> 
> > +	}
> > +
> > +	/* Copy the head part of the range.  Note: we pass offset as length. */
> > +	if (head_off) {
> > +		ret = copy_mc_to_kernel(daddr, saddr, head_off);
> > +		if (ret)
> > +			return -EIO;
> > +	}
> > +
> > +	/* Copy the tail part of the range */
> > +	if (end < pg_end) {
> > +		loff_t tail_off = head_off + length;
> > +		loff_t tail_len = pg_end - end;
> > +
> > +		ret = copy_mc_to_kernel(daddr + tail_off, saddr + tail_off,
> > +					tail_len);
> > +		if (ret)
> > +			return -EIO;
> > +	}
> > +	return 0;
> > +}
> > +
> >  /*
> >   * The user has performed a load from a hole in the file.  Allocating a new
> >   * page in the file would cause excessive storage usage for workloads
> > with @@ -1167,11 +1222,12 @@ dax_iomap_actor(struct inode *inode,
> loff_t pos, loff_t length, void *data,
> >  	struct dax_device *dax_dev = iomap->dax_dev;
> >  	struct iov_iter *iter = data;
> >  	loff_t end = pos + length, done = 0;
> > +	bool write = iov_iter_rw(iter) == WRITE;
> >  	ssize_t ret = 0;
> >  	size_t xfer;
> >  	int id;
> >
> > -	if (iov_iter_rw(iter) == READ) {
> > +	if (!write) {
> >  		end = min(end, i_size_read(inode));
> >  		if (pos >= end)
> >  			return 0;
> > @@ -1180,7 +1236,8 @@ dax_iomap_actor(struct inode *inode, loff_t pos,
> loff_t length, void *data,
> >  			return iov_iter_zero(min(length, end - pos), iter);
> >  	}
> >
> > -	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
> > +	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED &&
> > +			!(iomap->flags & IOMAP_F_SHARED)))
> 
> This is a bit subtle.  Could we add a comment:
> 
> 	/*
> 	 * In DAX mode, we allow either pure overwrites of written extents,
> 	 * or writes to unwritten extents as part of a copy-on-write
> 	 * operation.
> 	 */
> 	if (WARN_ON_ONCE(...))

OK.

> 
> >  		return -EIO;
> >
> >  	/*
> > @@ -1219,6 +1276,13 @@ dax_iomap_actor(struct inode *inode, loff_t pos,
> loff_t length, void *data,
> >  			break;
> >  		}
> >
> > +		if (write && srcmap->addr != iomap->addr) {
> 
> Do you have to check if srcmap is not a hole?
This dax_iomap_actor() is called by iomap_apply(), in which srcmap has been checked: If srcmap is a HOLE, then iomap_apply() will tell the actor that iomap == srcmap.  So, I didn't check it here.  But in dax_fault_actor() case, because we are not using iomap_apply(), the check is needed.


--
Thanks,
Ruan Shiyang.
> 
> --D
> 
> > +			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
> > +						 kaddr);
> > +			if (ret)
> > +				break;
> > +		}
> > +
> >  		map_len = PFN_PHYS(map_len);
> >  		kaddr += offset;
> >  		map_len -= offset;
> > @@ -1230,7 +1294,7 @@ dax_iomap_actor(struct inode *inode, loff_t pos,
> loff_t length, void *data,
> >  		 * validated via access_ok() in either vfs_read() or
> >  		 * vfs_write(), depending on which operation we are doing.
> >  		 */
> > -		if (iov_iter_rw(iter) == WRITE)
> > +		if (write)
> >  			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
> >  					map_len, iter);
> >  		else
> > @@ -1382,6 +1446,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault
> *vmf, pfn_t *pfnp,
> >  	unsigned long entry_flags = pmd ? DAX_PMD : 0;
> >  	int err = 0;
> >  	pfn_t pfn;
> > +	void *kaddr;
> >
> >  	/* if we are reading UNWRITTEN and HOLE, return a hole. */
> >  	if (!write &&
> > @@ -1392,18 +1457,25 @@ static vm_fault_t dax_fault_actor(struct
> vm_fault *vmf, pfn_t *pfnp,
> >  			return dax_pmd_load_hole(xas, vmf, iomap, entry);
> >  	}
> >
> > -	if (iomap->type != IOMAP_MAPPED) {
> > +	if (iomap->type != IOMAP_MAPPED && !(iomap->flags &
> IOMAP_F_SHARED))
> > +{
> >  		WARN_ON_ONCE(1);
> >  		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
> >  	}
> >
> > -	err = dax_iomap_direct_access(iomap, pos, size, NULL, &pfn);
> > +	err = dax_iomap_direct_access(iomap, pos, size, &kaddr, &pfn);
> >  	if (err)
> >  		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
> >
> >  	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn, entry_flags,
> >  				  write && !sync);
> >
> > +	if (write &&
> > +	    srcmap->addr != IOMAP_HOLE && srcmap->addr != iomap->addr) {
> > +		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr);
> > +		if (err)
> > +			return dax_fault_return(err);
> > +	}
> > +
> >  	if (sync)
> >  		return dax_fault_synchronous_pfnp(pfnp, pfn);
> >
> > --
> > 2.31.0
> >
> >
> >
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
