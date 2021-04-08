Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 311DA357AB5
	for <lists+linux-nvdimm@lfdr.de>; Thu,  8 Apr 2021 05:22:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C2A2C100F2262;
	Wed,  7 Apr 2021 20:22:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.71.158.62; helo=esa19.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1619C100F2253
	for <linux-nvdimm@lists.01.org>; Wed,  7 Apr 2021 20:22:02 -0700 (PDT)
IronPort-SDR: caNgbh3nz0oLKZ66KdNyNoDbHvwNAgJ0NlabsM7fb3BQkDXR1PS9aadInfWLSBp8Vm/xOK23Ub
 uCv7XxG6raOkDqBm29mrxIRmwzrslLXLrXKValE79vmcDCEljyfEY/iri6NwPSoXqTJCRgg3DW
 w3FqZHhB+bvSuQM3OTvo/IATm+nSjvCpAF0VRW6C75WIcPAPQfC+N7QCa5Im2ADPzrTEcT9R5Q
 FpJu9I6K2od5962qalQKq+IucXi5Qv+AMbog/lTE5M+Ll+EeFIK/3eG8/KkyeyKL7MPp7uUxHH
 HGg=
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="29046577"
X-IronPort-AV: E=Sophos;i="5.82,205,1613401200";
   d="scan'208";a="29046577"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 12:21:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ioz7fTclyMv8BabgaIs/Su60CsD6oDIvxIQdHroVv5pdYUA+/4N0MeyOrX2Ug7Zj2R/NXw3l4aGQaDlsNjbShbP6PfhUVPlspRvaq0zsPE8b1dEzZ4U7j4GF5EtrP5HW7TpzuwA4ijWe+3JbMOg++8j5IbswliU/FjGoLcNTqdKrzPJG6t9FSP3kGDLh9EuxDkYQfW0KErNCTRGRMww1NHDwV50O7gq8zZ0U8t4SUQG2tcJLTEKCKF+qH4VbAyyscVVoxZrSvblUs7lCwxu/S7OLPBCIo+jSQo9U72oWTCVxX8qqbkj5P9P9tjQkaHJ/pLzNSrS0oecHIqttJNzFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G4U9sk4VEpOveNCXolTsaOBVCwO0F/AdzrJAxbyFDg=;
 b=ZSL/yHhhWd2VK/S8uV1LntVMyP1Ic/Y5M9xZ9JFyeCQvmRBg6K7rBeoy/u67rfD1jQjyWzDcJd/NF28fkPosf1ErU0AJNWyUJcF9XlEBAD1t3DlNV9LWdM0/Pt58+CDNK/bFrc7EoSNb9S4w9JS4kHrRWd89hn/WzbIdshNNISsoVKnJBjq1QZ8jj3YRX2yzQOe1S2gLxzO2vIbUcyiThyAHZ/q/726AatIJDnDcux95iKLmZAGzQkpBhuzyi3tzzOGkN9RVk+UaF/jS0ssyxepQFZ9DI+z0y14f3xw17nwIqpIH/TTbfrf+OAJWcMI4KBbC9BcnnH28y6A6c0MDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G4U9sk4VEpOveNCXolTsaOBVCwO0F/AdzrJAxbyFDg=;
 b=TRhsc7o4UB45FQZNC2yM78cjuoCIja0GdT6sIiUSU8326blWJo3Havx7XXS5HbX0PpoN9apn6Ubehl2ycNcwZHHZ3q4QOoLthSfhDphIwhTwuSPg9VsYRDwF8K/+husj7SJ9eY6tm6M7airSyj5xJYxA1zGOeywWafBPRfBkt3A=
Received: from TY2PR01MB2921.jpnprd01.prod.outlook.com (2603:1096:404:75::14)
 by TYCPR01MB6557.jpnprd01.prod.outlook.com (2603:1096:400:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 03:21:53 +0000
Received: from TY2PR01MB2921.jpnprd01.prod.outlook.com
 ([fe80::e4ef:b5e8:6e7c:ee89]) by TY2PR01MB2921.jpnprd01.prod.outlook.com
 ([fe80::e4ef:b5e8:6e7c:ee89%6]) with mapi id 15.20.3999.034; Thu, 8 Apr 2021
 03:21:53 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Subject: RE: [PATCH v3 08/10] fsdax: Dedup file range to use a compare
 function
Thread-Topic: [PATCH v3 08/10] fsdax: Dedup file range to use a compare
 function
Thread-Index: AQHXHGLCkg6dUIPK4kKi6Usidu8iSKqflrYAgAp3LYA=
Date: Thu, 8 Apr 2021 03:21:53 +0000
Message-ID: 
 <TY2PR01MB2921EBF98C2AC2900799FB85F4749@TY2PR01MB2921.jpnprd01.prod.outlook.com>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-9-ruansy.fnst@fujitsu.com>
 <20210401111120.2ukog26aoyvyysyz@riteshh-domain>
In-Reply-To: <20210401111120.2ukog26aoyvyysyz@riteshh-domain>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe7e6042-e563-44a6-711e-08d8fa3d7527
x-ms-traffictypediagnostic: TYCPR01MB6557:
x-microsoft-antispam-prvs: 
 <TYCPR01MB6557E59B32D8D0350178C29AF4749@TYCPR01MB6557.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jIHY3kfk21NG6iYaK/vNJm7XR27M46EOAfzJ+dLIwg6pYs5m7FWu2vxEaYB5KknTA1ham+FM27iW/3PhOMNT/NCoRTLne5bbriGeBYaEARUP7Mi7ezer2wBC6MZXkaGzNmPW+1qhH//NktDStR05rHolN4NDPHP5RP53T7ypofG3kfZydhT9e/enGXvc/Rr510tx6AF2vBN2YyDmOnLVyWAeBKZYDVlv1TTf49husJp3X9pI8eJNzNdD8tHdebLPCXsbezGnEwPQwe8eVS4EPuFnF/P7uEqnQ/GT9iQnQT8oHMmMZKJFjDOLQqkPo6tgFXf5U6qDjt4HuN+rZLVOxo0aY7gqtRuUk+hK0u+T32shfh6Okwk5nLKyi0Trbh0BPeH/EBXL8rTm/tPpMZgBkAdW+9H8yTtTw7ximzK0mF6cPfqCqxrgBXhEmdcwzA53St3tImp5ySdbeeQ7rN+M76avWtD+v5Nj7pL+m8bWrnJTR1Y4EoXko5rilj9OmFZsj9//M3sPE7BusibmIKTqava0CCENWKhcgICzUZOtzFpYSEZLXgNRTM7qVkMJTJGRR8THApCxLW04cd95g9QyHuNNO2TMZMw35Ekckkei8zkpUFyo9M5fLEhw6nfX5fee1uU1iNjhnYXtovavDQL56EtLQurKmieooeVTQmxMNVw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB2921.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(86362001)(66446008)(66476007)(9686003)(66946007)(6916009)(64756008)(4326008)(26005)(66556008)(76116006)(38100700001)(55016002)(316002)(54906003)(5660300002)(71200400001)(85182001)(8936002)(33656002)(52536014)(186003)(7416002)(7696005)(2906002)(83380400001)(6506007)(478600001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?cGxMWFVkSkdET05Oemh1TnZZWjVmNW04aWxSbWFKN3pVS3hmQWdEUnc0Z3BV?=
 =?gb2312?B?NkdYWjl0cEQ0OWVJNWpEdldlakpEU1JqU042SXF5NllvRzMvcmM2azBXN0Jk?=
 =?gb2312?B?WXhHWGxGNTMzQnpidFBIdE5zdTVMSHYzZmw5bnAzS2Q2WHR0Nm91T2xtb2hD?=
 =?gb2312?B?c3dpUlJ1ZGlQem9SQmZaVFRnNnlvc0cvcTJCOEMxQUplWDcxRlVmV0NhdHNq?=
 =?gb2312?B?TzlxMm12QzZ0UEp3ai94REh6Z3NQVGVFMi93QjBIdVVNNmNYclg5SzgveUM5?=
 =?gb2312?B?YXJwLzJHYVhyZ2JDSXZPOHdYektySDkvL3RSUDBOUVB5ZDBzRzF2am9WYmFL?=
 =?gb2312?B?VDlJdUtwNFBMMjRKeDJhNWxFTjg5Ny9ibVlYUkorc0gvVE85QmNpemFtMEx1?=
 =?gb2312?B?ZDk1Y0FhS080SmQvTTZQNXV2NUxWWGRaMTlVR09xRFVoUjZ5Q1o2V1NUWDQy?=
 =?gb2312?B?VkVsZnkrblJZbUpUTG5TSE1xR3cydUw0SFBrdmNIWi95cUN6V2NaWXpkS056?=
 =?gb2312?B?MythSFZWdG1zS29sdzFMWDJBckVPMmk1THNxSFdNSkZOUTlsbXpTVnFTemIx?=
 =?gb2312?B?WWVzOFRKNi91QWJrejZ5OWVKNE9EWHFYNGt4NFFLWDVCNEJYbVFNL1dPY3FB?=
 =?gb2312?B?R3BjOWMwT215WXk4R1FVRFVXeTRqKys3Qjg5bEZsYTNSQVRHMWJON1NoMkx2?=
 =?gb2312?B?KzRFV1E2NXdnRzlyQ25mNmFPc2hGeCtEWHIrYUk4NzhHOTFKdmJ5OVR0MEUy?=
 =?gb2312?B?R1pacEFJWUFYVFcyM3ZjcUtJNDNQSXl5Q2JuT2NMUHlWb01aMDhKOXNTRnBm?=
 =?gb2312?B?SEh4MnhRUmNpTGQ0Q20rMzdTdk5MSmFtb0oycnlEbzhpbWpOQzhNQkR1TVBD?=
 =?gb2312?B?RExVRmUyZWJPUEpoQ01qTTFaSjVETlU1TitwSU9tTnVvc0QzMTd1eTU3Zmxj?=
 =?gb2312?B?M0d4a0JpL041UzExNTkrWDBkdWVhUi9uR015MXg4OENZTzIvUjU5Qmd4QWk5?=
 =?gb2312?B?MkJ0SHNLN1h3cEgvejUvQm52Y2E0TVR5TnBaV0tab3A4TkJpRHlRQWIwanpp?=
 =?gb2312?B?c3pObFZPWmR0aVEybTVKdVc3YTFEbGZBd0YzdFJESXo1SGd3aTRYSFpyWVFW?=
 =?gb2312?B?R3Y1c3F5eW50U1VKQzlYSzdjUWVwajR3VzZnUXRlUGxNUy9DQ1BCOThHSnJM?=
 =?gb2312?B?S2VxdmRQa1REVWdZbWl6WE5ab1ZsRzZrRWc5YjdPK0dycm9hRCs4anNnK2Rs?=
 =?gb2312?B?SjFHNGg4Rk5FK2F5YnMvMnhaKzJPTGlueG5UcXdmMnpveG1vTFlYK3FoK1JZ?=
 =?gb2312?B?Z1IvdnJmQVZYSEFRaURYQ0wyaDZ2bHJ5NS9RRzVWb3pLVURYci9md2RBNWhz?=
 =?gb2312?B?MVZzaGdoVHZMV2xUS2ZGTlZLaExqTkRQdWxveXg4b0tteWRiTEhXL00xbGR1?=
 =?gb2312?B?Q2FINkd5bkZLVWowcWxVVjdTOUFYbjBzMTFzbURPZ1pzN2pLUEtzN0dsbUM3?=
 =?gb2312?B?SWxIS0t3OFRrVTBzczRpQXpHSDZiRHE0b01uMDZzbzQza21UZmNxV3BDeTVt?=
 =?gb2312?B?aEQxdjQ1T1pLbGJ3WUlLV2NqdEV0cUZvZmxpUC96V3d2NjluRGI2dncxK0E4?=
 =?gb2312?B?YnRDdThZUGNzSHNJaU9rU05XOHpEa0U4eVNjc01HWXIrVVRhdnJPL0FXaCtW?=
 =?gb2312?B?WVdjcE5nOE5IWjIwMHhLZWpxY25YcGZwT1ZoLzQ0cnhlQmVSeEVTQ2N6MzVH?=
 =?gb2312?Q?f8AaHyEtqoaU8G9C/cXouR0l0eDxwOp2cwQa+mr?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB2921.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7e6042-e563-44a6-711e-08d8fa3d7527
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 03:21:53.7134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2AdHb+qutiKz/mU1neNKx5bjPe1CAp2VkbekY25IFinU0KQlZHxhhT5ZvHgN7OR3/ecWuDwMSypaScPscXMkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6557
Message-ID-Hash: YB6WVC2MWEFSWMADRB6PQH7SBGZHSQJR
X-Message-ID-Hash: YB6WVC2MWEFSWMADRB6PQH7SBGZHSQJR
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4ZNMCCF3BVWXPOK4MCFQN7NCCPHDWKKC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> -----Original Message-----
> From: Ritesh Harjani <ritesh.list@gmail.com>
> Subject: Re: [PATCH v3 08/10] fsdax: Dedup file range to use a compare function
> 
> On 21/03/19 09:52AM, Shiyang Ruan wrote:
> > With dax we cannot deal with readpage() etc. So, we create a dax
> > comparison funciton which is similar with
> > vfs_dedupe_file_range_compare().
> > And introduce dax_remap_file_range_prep() for filesystem use.
> >
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > ---
> >  fs/dax.c             | 56
> ++++++++++++++++++++++++++++++++++++++++++++
> >  fs/remap_range.c     | 45 ++++++++++++++++++++++++++++-------
> >  fs/xfs/xfs_reflink.c |  9 +++++--
> >  include/linux/dax.h  |  4 ++++
> >  include/linux/fs.h   | 15 ++++++++----
> >  5 files changed, 115 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 348297b38f76..76f81f1d76ec 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -1833,3 +1833,59 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault
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
> 
> shouldn't it take len as the second argument?

The second argument of dax_iomap_direct_access() means offset, and the third one means length.  So, I think this is right.

> 
> > +	if (ret < 0)
> > +		return -EIO;
> > +
> > +	ret = dax_iomap_direct_access(dmap, pos2, ALIGN(pos2 + len, PAGE_SIZE),
> > +				      &daddr, NULL);
> 
> ditto.
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
> > 77dba3a49e65..9079390edaf3 100644
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
> > +				const struct iomap_ops *ops)
> >  {
> >  	struct inode *inode_in = file_inode(file_in);
> >  	struct inode *inode_out = file_inode(file_out); @@ -351,8 +355,15 @@
> > int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> >  	if (remap_flags & REMAP_FILE_DEDUP) {
> >  		bool		is_same = false;
> >
> > -		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
> > -				inode_out, pos_out, *len, &is_same);
> > +		if (!IS_DAX(inode_in) && !IS_DAX(inode_out))
> > +			ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
> > +					inode_out, pos_out, *len, &is_same);
> > +		else if (IS_DAX(inode_in) && IS_DAX(inode_out) && ops)
> > +			ret = dax_dedupe_file_range_compare(inode_in, pos_in,
> > +					inode_out, pos_out, *len, &is_same,
> > +					ops);
> > +		else
> > +			return -EINVAL;
> >  		if (ret)
> >  			return ret;
> >  		if (!is_same)
> 
> should we consider to check !is_same check b4?
> you should maybe relook at this error handling side of code.
> we still return len from actor function but is_same is set to false.
> So we are essentially returning ret (positive value), instead should be returning
> -EBADE because of !memcmp

The ret from compare function will not be positive, it will always be 0 or negative.  
In addition, if something wrong happens, is_same will always be false.  The caller could not get correct errno if check !is_same firstly.

> 
> > @@ -370,6 +381,24 @@ int generic_remap_file_range_prep(struct file
> > *file_in, loff_t pos_in,
> >
> >  	return ret;
> >  }
> > +
> > +int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > +			      struct file *file_out, loff_t pos_out,
> > +			      loff_t *len, unsigned int remap_flags,
> > +			      const struct iomap_ops *ops) {
> > +	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
> > +					       pos_out, len, remap_flags, ops); }
> > +EXPORT_SYMBOL(dax_remap_file_range_prep);
> > +
> > +int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > +				  struct file *file_out, loff_t pos_out,
> > +				  loff_t *len, unsigned int remap_flags) {
> > +	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
> > +					       pos_out, len, remap_flags, NULL); }
> >  EXPORT_SYMBOL(generic_remap_file_range_prep);
> >
> >  loff_t do_clone_file_range(struct file *file_in, loff_t pos_in, diff
> > --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c index
> > 6fa05fb78189..f5b3a3da36b7 100644
> > --- a/fs/xfs/xfs_reflink.c
> > +++ b/fs/xfs/xfs_reflink.c
> > @@ -1308,8 +1308,13 @@ xfs_reflink_remap_prep(
> >  	if (IS_DAX(inode_in) || IS_DAX(inode_out))
> >  		goto out_unlock;
> >
> > -	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
> > -			len, remap_flags);
> > +	if (IS_DAX(inode_in))
> 
> if (!IS_DAX(inode_in)) no?
My mistake...
> 
> > +		ret = generic_remap_file_range_prep(file_in, pos_in, file_out,
> > +						    pos_out, len, remap_flags);
> > +	else
> > +		ret = dax_remap_file_range_prep(file_in, pos_in, file_out,
> > +						pos_out, len, remap_flags,
> > +						&xfs_read_iomap_ops);
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
> > fd47deea7c17..2e6ec5bdf82a 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -68,6 +68,7 @@ struct fsverity_info;  struct fsverity_operations;
> > struct fs_context;  struct fs_parameter_spec;
> > +struct iomap_ops;
> >
> >  extern void __init inode_init(void);
> >  extern void __init inode_init_early(void); @@ -1910,13 +1911,19 @@
> > extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t
> > *);  extern ssize_t vfs_write(struct file *, const char __user *,
> > size_t, loff_t *);  extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct
> file *,
> >  				   loff_t, size_t, unsigned int);
> > +typedef int (*compare_range_t)(struct inode *src, loff_t srcpos,
> > +			       struct inode *dest, loff_t destpos,
> > +			       loff_t len, bool *is_same);
> 
> Is this used anywhere?

No, I forgot to remove it...


--
Thanks,
Ruan Shiyang.
> 
> >  extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
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
> > 2.30.1
> >
> >
> >
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
