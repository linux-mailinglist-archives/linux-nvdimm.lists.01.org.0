Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D490F37F3C6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 May 2021 09:57:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 21723100EAB54;
	Thu, 13 May 2021 00:57:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.151.212; helo=esa3.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6F28E100F227A
	for <linux-nvdimm@lists.01.org>; Thu, 13 May 2021 00:57:55 -0700 (PDT)
IronPort-SDR: nBYRPwjlzdxsM3XUbe6Mrxmo8f5Idciyc4HulaNZQEdk5z5zz1iHphdl+x1eoRyo2wUua2iomi
 9ATUagdVLINeDkAf2msfmGXF0Rp7VXHibTaDHh3NAOQD1YUqSnGQvalzUhMU7t/wyHs9+Srm0a
 9WHm6qhOQVQNs2wXDHpcDIDSFlpoaGayn0a04y32+P36wia1aMFjSkUmpcwjWRiGPBj0WnavIZ
 bq2FyO4IkCAQzR6o0KC7kwuL1wdVqdV37Ib1wWDgyXU2sij1TxMK5fCimjVL6h0wqIOEjILKy6
 52s=
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="39344606"
X-IronPort-AV: E=Sophos;i="5.82,296,1613401200";
   d="scan'208";a="39344606"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 16:57:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGrQTR4y+mJT1LJ1QxZtDCluwyzSL5HPr48+WtbDdBHF+fNKNo8z7REAqwSFErm0enVcR0M4TulYcPfXgOQT88sHMfCEBbcQcXthjwTk+ZPvYPqmt9W/ivwAGwQcnOx4VSDCZoVe/byNC9GyM6gi6b+hZXBnnUwHUxCJvjMysL2FuHOYPNNJtu8plgPR/Mqj3fvqCCqNFVHYWEuRrnBhzT1V/WoEZM+JddjgjVd8sMBVSXI9zM723kULunvm3MrGUuOgQ8KMtF8nfTodAnOUn5zq0tnl0JtW2KAEn/u2w4RXwwcHpHpCoSmvAhUEXH9+uOSz4nPxgew5TCvXXiXmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XXZP2p64MUEzoBDHgC1N4f3CRyJhlr5nw62SY11xqU=;
 b=liUY4YdbuO5eeXexCPKo9bn6diTe6/cjQCNrkYt5vpvSQGWBEsBjN1OKrcwga11DSLLXItZ2gMDhsxqb6Ye9k2hrSj+nBN/YRMbC16SHrTlvOxKsUeuo2g1MfNElo8e5ue7r+3sdFvhftSI2EkXNr24Xbo7RFQAGsYaiNMzWU/evaE9pNVJH8cFxWMyWKoX5rWdBIl/VQf1xW90gfqWqp/Ks1eAnUpOmc9Z14D2ZMvYnJUaYa2wodAOBWaArmaa/IbNNBqD8/xA98Ibk83abVf9in592zCzWHWdtQyc4XJ1rkXHe1b6F80eatMGziF3aEu9XdKmd8jJeJKXjG79ypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XXZP2p64MUEzoBDHgC1N4f3CRyJhlr5nw62SY11xqU=;
 b=hOtL/adneYXERhEoqjfYVsQd2fPH3EhZorUw0hO3RyABB0PgZDKimqAWK+l9K+xNr/cKHl/qKAujYa5NyFkMeRKkU3hICZ1UwgOSM/QwQ6YYU/Rz7onxOE717H3y2RaZFijVYn9FTdWOWiY47NC75AedJRg0eiTXyYCpza9zcUo=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSAPR01MB1617.jpnprd01.prod.outlook.com (2603:1096:603:2f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 07:57:47 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4108.032; Thu, 13 May 2021
 07:57:47 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Subject: RE: [PATCH v5 1/7] fsdax: Introduce dax_iomap_cow_copy()
Thread-Topic: [PATCH v5 1/7] fsdax: Introduce dax_iomap_cow_copy()
Thread-Index: AQHXRhMt0iZsAJx3Qk6pgqIZS1uA+KrfCmUAgAICTOA=
Date: Thu, 13 May 2021 07:57:47 +0000
Message-ID: 
 <OSBPR01MB292062DA13D47BDBF3E2321BF4519@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-2-ruansy.fnst@fujitsu.com>
 <20210512010810.GR8582@magnolia>
In-Reply-To: <20210512010810.GR8582@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a09ebc5-dc35-43b9-37af-08d915e4cc44
x-ms-traffictypediagnostic: OSAPR01MB1617:
x-microsoft-antispam-prvs: 
 <OSAPR01MB1617D5037325586812163093F4519@OSAPR01MB1617.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RLrW3v9OwMLdYnFwguN8UTQdJ7QC4koMZiQMctXaruUJ64+BB1FGwPmNfUbVDvmvo4KZYqw6xOdaMEiW7P81wdVcZtrk9sPc/a6eIdBWTxtlyJHFmtsDwK7HR3gnGm8xDGDy39oqTfg8Ka2mBWXZ7wvM+DYekGVj2gaE6j1z99I4rkyr1htjRnHAvi7IJyEZSGaS+hd+wDSIHgK/GGd12sE8kKbf3O/WW/jONmKxP3WAIVIpiOmHA2Brm5TmqqGowMO294H46ZrNgVdwF8sdBAFPpcX16ToQr5Uhlb5AuCTaYeQtMuj9m+0fx7B0MWDH2KLhdVQNp0OuMVqViQD6XtrDko1dzQnNKcws2w7pYQD2UEudm7MdrNNQVmZSVrfC/0xveubqVH823zVh4284J30ELIJ566mgWGESZlb6BcAGSpPKs2OTmaCrvkXL5+eW8ybPsZtBB9Zq2ng96mQDCz3uIwFpAtOq33pQlfenoQayNj/Uce+RyCRgl9v7sfNxvU3hKdIQJ+G9DT5bTan6MOq8718vsqNDcoLn0Bd/uY34ANMIvZP7oLcz97rXY8d9iYKlsGrs1TrAbM5+WNc2dtjecUDuuWnq1XuDQONl+0E=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(5660300002)(186003)(2906002)(9686003)(83380400001)(26005)(7416002)(6916009)(33656002)(7696005)(54906003)(478600001)(64756008)(38100700002)(316002)(85182001)(66446008)(6506007)(122000001)(66476007)(76116006)(71200400001)(52536014)(86362001)(8676002)(55016002)(8936002)(66556008)(66946007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?YXdBbHpLaGFMNFRGSS91QjBmQWMyTjZQR21wdWhMVXVzMG9VTTJrdHc0RU9W?=
 =?gb2312?B?QStLMlNzS2laSWQyR0hwM2lTS3FTZUNzekVkUWtqemVNSGdkd3dWWjB5NVEw?=
 =?gb2312?B?YnNYRnBTTk9kZC9zQmtXT1JlMVFDVTAwQ0dyUkl3VmlxcWd3STVrbjA3VnF6?=
 =?gb2312?B?QmZUUlFiSmR6YW9qWFh4enZFeWcrZ3RZbVV1RXBLcDNoYWgxTXZobE1EdFA3?=
 =?gb2312?B?UzhMUTZVemRXeHp2N2VwNEFMSkk4VmVaWkJGMkRhZFV0YTVGWHdseUlQK1Fs?=
 =?gb2312?B?cEx6eUUzNlR4UEpDd2xWNGpiTmNEbjZoc1RaK092endpZ2VOQWVVVC83M0k5?=
 =?gb2312?B?bFhwUkhDbmg0cExrT3h0bkJKNVNYelVSR0ppUDhzN1IvQ3hPS3VPL3Erc3I2?=
 =?gb2312?B?VHlDbjNYZ1VsamIvSk9xajdUbEQ0Q1dtNk5INDliSS9zaWh3cGczYjBkdHZs?=
 =?gb2312?B?MHdZR2wyWWtYYlhWZndrOGJPVDBwMW5kbXN3bzRLbGZHbXZobXZ1R01VUllK?=
 =?gb2312?B?blYrd1d2dXpyaTVTMnRxSUJrYVlnZ1BLNFkvZzU4SjlBMUxWQkh0L3ZIYWsz?=
 =?gb2312?B?VVJ4SjEzVUpEbXM4dm1Ed0FvT1JwbW1uZlNaalFJZm02MVhyd1pJU2UxRnFT?=
 =?gb2312?B?MXRzdERhTXhYS08vVkNJQ0t4K2gzYUNTYmJsbG5rbzgxempEU1hiUnJTdHln?=
 =?gb2312?B?ZzBhenoyQzRDZnJEV1FGeUxxdm81NkI0NEthdk1FOVJtN2t3eE16RVo0WXRO?=
 =?gb2312?B?Vzc1WWNVaVMwN25hQ3pLOWtIODVDYUlWL1cyallQbGx6UjZmdDZaS0ZCeG1V?=
 =?gb2312?B?bUkrcWg5d2d1SW5JU2lnUnNUMmF5RzJhdUttUmFBRGM4SU54clRPckhjMmRy?=
 =?gb2312?B?WmxuWGNPMHhlY1hnUjI2WEpHNXJCNzBMeDlmNUNQNStNejJ4cS9rWGtrU0gx?=
 =?gb2312?B?aDNLVmZJVWJIc1Z3ZTc4YnpRK1dtckFtTm5NWWwzYkhIMmpxNVVVb3R4Tkt5?=
 =?gb2312?B?S1ZVYktiaXZDb2lvR2FvRHZMeUZNdDdFZW5zeFlQU3cwMFQ4cG0xNTBCWXZC?=
 =?gb2312?B?Y1lwdjRUUm9QbjErc2xyaEMxbVFOckhOSlJhNjhKNXFKSXk0M1ZCUTBucVdH?=
 =?gb2312?B?bWRXWkJZQ05sMEY4YkZyUlI5cTk0RGpJVnRHdXNIOHlGVTNYVjVvMG9SSGNv?=
 =?gb2312?B?a0Fob041cEN1SlNiWk9td05VSXZQc3dFRkxXbmxUelE2TkxZNHRNUElnYmxO?=
 =?gb2312?B?M2pkR2YveXV2bHdUWndrUXM4U1M2MzJHbEVrRkpLblg0R3BkSHVBTUpIQmE3?=
 =?gb2312?B?emx5ejlxclNURTlOMjVkYnNSdytFNWh3TXNDaCtwL2ZuUkdteU14Q0FyUDRK?=
 =?gb2312?B?Um9YWVpHQXJXYVY0TEsxN25vUThlcmp6TVg4aTlGSWd6bXpxSUI0TFJsMEFy?=
 =?gb2312?B?QUQ4TS9SaE53Smt1OXBUS1VGVFovMC92TVNrcGpiOWFwMVRZTFhtcVErNkRu?=
 =?gb2312?B?Z1NOaHI4cGhyNVdpa2IxNkRZMTVEQTNnYlkzOThQR1R4VFZJejAzeXp2endO?=
 =?gb2312?B?eUtIdHJEZXN0OFByTTU4aG5paTFFRkRxSXJGMHZjZk9STnJDODg2ZzZBZnp6?=
 =?gb2312?B?RTk1dTd5SWk1TS9lREErWGdCUUtNelQvb3NHL3NETzF4Q2Vlc2NpQzI4SzhE?=
 =?gb2312?B?aTJOb2hxWjRRTnNZVlRUeUdUdDVUSk55bFFzNHJObFZGNUUwUEdMVUVmU1FH?=
 =?gb2312?Q?YOqtIPCE2MybLrAGqbryFEJML0caCv6rXs5iNzs?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a09ebc5-dc35-43b9-37af-08d915e4cc44
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 07:57:47.2675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UglcJfQ6wCbpkJ0jevJZJ2JxpE8olmVlhMhHaTMTjqYRUdl0foVb9fW+0ZoXr0KuguDCWOEh0XFwIU1epSaG/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1617
Message-ID-Hash: SCWADL43BTELD2DAWTJKLBII4EFLRDFQ
X-Message-ID-Hash: SCWADL43BTELD2DAWTJKLBII4EFLRDFQ
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4LGX6MPOVMKLT7JVFGTF54EVOBMXDCIO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Darrick J. Wong <djwong@kernel.org>
> Subject: Re: [PATCH v5 1/7] fsdax: Introduce dax_iomap_cow_copy()
> 
> On Tue, May 11, 2021 at 11:09:27AM +0800, Shiyang Ruan wrote:
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
> >  fs/dax.c | 86
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 81 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index bf3fc8242e6c..f0249bb1d46a 100644
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
> > + * Also, note DAX fault will always result in aligned pos and pos + length.
> > + */
> > +static int dax_iomap_cow_copy(loff_t pos, loff_t length, size_t
> > +align_size,
> 
> Nit: Linus has asked us not to continue the use of loff_t for file io length.  Could
> you change this to 'uint64_t length', please?
> (Assuming we even need the extra length bits?)
> 
> With that fixed up...
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> > +		struct iomap *srcmap, void *daddr)
> > +{
> > +	loff_t head_off = pos & (align_size - 1);
> 
> Other nit: head_off = round_down(pos, align_size); ?

We need the offset within a page here, either PTE or PMD.  So I think round_down() is not suitable here.


--
Thanks,
Ruan Shiyang.

> 
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
> > @@ -1180,7 +1236,12 @@ dax_iomap_actor(struct inode *inode, loff_t pos,
> loff_t length, void *data,
> >  			return iov_iter_zero(min(length, end - pos), iter);
> >  	}
> >
> > -	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
> > +	/*
> > +	 * In DAX mode, we allow either pure overwrites of written extents, or
> > +	 * writes to unwritten extents as part of a copy-on-write operation.
> > +	 */
> > +	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED &&
> > +			!(iomap->flags & IOMAP_F_SHARED)))
> >  		return -EIO;
> >
> >  	/*
> > @@ -1219,6 +1280,13 @@ dax_iomap_actor(struct inode *inode, loff_t pos,
> loff_t length, void *data,
> >  			break;
> >  		}
> >
> > +		if (write && srcmap->addr != iomap->addr) {
> > +			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
> > +						 kaddr);
> > +			if (ret)
> > +				break;
> > +		}
> > +
> >  		map_len = PFN_PHYS(map_len);
> >  		kaddr += offset;
> >  		map_len -= offset;
> > @@ -1230,7 +1298,7 @@ dax_iomap_actor(struct inode *inode, loff_t pos,
> loff_t length, void *data,
> >  		 * validated via access_ok() in either vfs_read() or
> >  		 * vfs_write(), depending on which operation we are doing.
> >  		 */
> > -		if (iov_iter_rw(iter) == WRITE)
> > +		if (write)
> >  			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
> >  					map_len, iter);
> >  		else
> > @@ -1382,6 +1450,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault
> *vmf, pfn_t *pfnp,
> >  	unsigned long entry_flags = pmd ? DAX_PMD : 0;
> >  	int err = 0;
> >  	pfn_t pfn;
> > +	void *kaddr;
> >
> >  	/* if we are reading UNWRITTEN and HOLE, return a hole. */
> >  	if (!write &&
> > @@ -1392,18 +1461,25 @@ static vm_fault_t dax_fault_actor(struct
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
> > 2.31.1
> >
> >
> >
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
