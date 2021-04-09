Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEC83591BF
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 03:57:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B1934100EAAE6;
	Thu,  8 Apr 2021 18:56:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.156.101; helo=esa14.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3B056100EAAE5
	for <linux-nvdimm@lists.01.org>; Thu,  8 Apr 2021 18:56:55 -0700 (PDT)
IronPort-SDR: CGYKUzoRfrkLxdYlwYcHevp9DvZGlT2HuhFh1mIcJawK+I7dRvUU9WxDBKb1BjBkfZb0KUMLsu
 amV3D1q8I4OC0JPsO+yvZEsW4Rb+od284/DQECikqFCRemQSH6x9btXrK8RRrtSEPkBcZM93ne
 EHnd1BLBXT1Geo9h5IfuvhiPxsqFzzQ51rCIbPoHEB/JJ9kuSV7g0uB+uusfcMiXhmRX42Mj0e
 T6zC+gYfkRYUGV/k3saqjwlABKnFHWfXYYvx6kiXolXTAdZfdAH52lcEg8kZqYNnC4kThL3b2p
 tS0=
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="29245544"
X-IronPort-AV: E=Sophos;i="5.82,208,1613401200";
   d="scan'208";a="29245544"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 10:56:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6QpZbm4OM+B5jPbWmNFNuhRmvIybRxIn1H26UpG57524yzOm4nZKOZe3FnVsf0rKKRGkmfnm9AHfA17/1Mi2ZK9pUni+Qc2rluV0YNuQ233ZER3URb0xv4jsjCFj4U+c7QFTSOrJsu25hEluO2cZhN1RQ9qVJsSQN8W2W/oDbUuyiawbKkUAvD2Fq0rNyijngVKCo/Uf7kgwEVqLR4qd0Znt97mXkFIE7KuUemGae7oaC6z/YnRVYgJIxvz3gXACvFiw/sFH+qxI3A4LAZ2oYWpVI6UBSJDLtcEAxJNfsH2uD0kXPCEKQVF+neddPyhS2YB1yiwaLgRVH1OxMh5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J8YTAnBiIV/waonUTMMv6X9fLAMlH3lU/Fns6nfRUw=;
 b=RwpDcMcPcuMsOrN8h1NHYwCWfuzQklwIrBXbZ3WJk7iCDciYVTJTsG2IIrlRcf9TFRpw0Ixmz4ZZq3tgA65kYtzrXkgWs76wA68sxVXUU0D/3+JoKtfQKqDgsW3H32jD7o95yInJddpDPJ3WTBQoGPYzuko17rOdg95t8Rl8EzPnlGhQY94nL/D26NMuWb2p+eSlIl92jC9f0BjXt3HkdB4VL4EaLT9+QNmevqkEiO5tHxfvk4/KGznODw20biow6A6kZi06Kp69/Q/RXAUTycQ1sGq17l9JSdexATIWSPBgvYMP47pEFy/X2XV27+Hnnb66Oefb1uK9JDcCmobo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J8YTAnBiIV/waonUTMMv6X9fLAMlH3lU/Fns6nfRUw=;
 b=m4hhhZpxYBrLr4qO1g6YNnFpo68EeH863I0KIMBNIvQYwG4fDJOybZUTP7GOq/EAoHtO7tCL/nCK19HKTwreQ/lKa77AQu1YoOKbymlgIBTE+4QkqvRPXGYjUg8NGHtDvlPR1m5Nv/VoFWMkiNVrmyH9FRoquK9oSEYj9Zz2jpU=
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com (2603:1096:603:3f::16)
 by OSAPR01MB2995.jpnprd01.prod.outlook.com (2603:1096:604:2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 9 Apr
 2021 01:56:48 +0000
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::5a:7b3b:1e18:3152]) by OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::5a:7b3b:1e18:3152%4]) with mapi id 15.20.3999.032; Fri, 9 Apr 2021
 01:56:48 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: Su Yue <l@damenly.su>
Subject: RE: [PATCH v4 7/7] fs/xfs: Add dedupe support for fsdax
Thread-Topic: [PATCH v4 7/7] fs/xfs: Add dedupe support for fsdax
Thread-Index: AQHXLG+b4elRrPTeA0mbgmZnucDQOqqqmKUAgADU7sA=
Date: Fri, 9 Apr 2021 01:56:48 +0000
Message-ID: 
 <OSAPR01MB291345BD169337AE2BCAA717F4739@OSAPR01MB2913.jpnprd01.prod.outlook.com>
References: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
 <20210408120432.1063608-8-ruansy.fnst@fujitsu.com> <czv4syut.fsf@damenly.su>
In-Reply-To: <czv4syut.fsf@damenly.su>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: damenly.su; dkim=none (message not signed)
 header.d=none;damenly.su; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 311eb91d-fc95-483b-21f1-08d8fafabcb2
x-ms-traffictypediagnostic: OSAPR01MB2995:
x-microsoft-antispam-prvs: 
 <OSAPR01MB29957E2B0B8F408D0AE870BAF4739@OSAPR01MB2995.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 f1W8cEmZSV+PDBcWlPA0wrYMKTG1OSpX3Io30TGvCwI9VeiQLj/7gH3c7Cxkg31tImQpPs1vkJVHHdBDu3Q5uWI1jJbAPh9C7RhQgAr1zenGLXX6S7id3uolNTVct7g3yOOAyzVjyzfHr5a1NpY8Tnrji/A76YwCm7ehn07gYvad+ZZ5ntiLjQxDeF4Luqe21bkLYyPwIbvQ8kMiUOaEQl9nATmzLBfZF/JMh8IOrGltTY3uhJe9l50CSJZ7TR3sAxVFtfw1qVBbjVREh8A9QmM781lWqMuN3cowx+GACYcencD6qxq/7ebIy5Nwfapkp84Z/34mdUUBC1Ifb4BkzWvDdZ0RQ7n90cETwfg4Ki0nc36DGF4e4qOdOtlEHWt2z4DcgcrKNDdtai9TNB3vKjWzSBmN8juIgieruYUI3OI6G/v/yD1BGsMgLFb3jJGg1yGwNX4Qd47ODZgjfBgOCwRzNc4A4jENZNi8ARYaINrhhFslxpzUG7SmncJk7FbbEyrGAgHJB5YNN47oRxpApEtSokW8VBeqOs/ONXlqmOwoW44wCKnkG4I2xQrj6U97V7ycvDDw8+j/CvPcwNCVX9jY3vgAn5uclsEcu6+UiFPu7/HaHwHDMnblcg35Yt0GdCU18vPkd/RWIQcH9pq/vxWuwC8YSKtKnQi4SW6UNx9UoFT9h7a1zCA2H8eaniYm
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2913.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(83380400001)(66446008)(5660300002)(76116006)(66946007)(86362001)(2906002)(33656002)(8936002)(26005)(66476007)(38100700001)(186003)(6506007)(64756008)(7416002)(7696005)(54906003)(71200400001)(4326008)(52536014)(85182001)(6916009)(478600001)(55016002)(316002)(8676002)(9686003)(66556008)(781001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?MW9yMUlJeENrYWIveHR5NytQNkFwLzJzU0hUb014R3lKNS9rb2tQZHY3T3Ux?=
 =?gb2312?B?aWw2VkR0VmJXRlVJVjRaRFhraXRGQys3d09LWWx3WkpXV0h2NUdJdjZWQWtj?=
 =?gb2312?B?MmJ3Zzg3T3dPaU5ybGVBcS9ZZWhRYjV5VERGbVMzV09PTEsreFBNbm11NTEw?=
 =?gb2312?B?RGoyei9GN1ppd1A3ZGtMOFhXUmxnUEVHU0FwVUtkMFlndFcxd1VXaFpEdW4y?=
 =?gb2312?B?N3hwSjhVSWczNS91N3N2NkRTcWM3NHQvMHArSGYwVmRmTmtrRjJDN1l5dGNR?=
 =?gb2312?B?SzVJeUFYV3pZV0toY2Z4SlhSZjNud1NlZ2gwOHIrdDVvMzF6aVA3L2tQVUlO?=
 =?gb2312?B?LzhSRjVqN05PWUdZajk4RnFBaDRydFpyWENDUTZjSFVObTcrektrZGdyTUx6?=
 =?gb2312?B?ZzZQZTQ0YjRMK3B3OWF0eUFrS0orRURzSmw0QTUyaTU0cEJZVno1SFdjdEpu?=
 =?gb2312?B?TkV5WGhES1ZpRnJOZUp0dHJFMENTS3cxcEJpUjJkOHpxK0V3azBYaGNRY3Q1?=
 =?gb2312?B?Nko3QVh3VUxPZGExZXNsSzM0ZlF5ZityNWwzVjl3QTlGTTcxLzJSQnFwVUFX?=
 =?gb2312?B?YzYxMUFCNUJiOEdjanNxNFlQUWtuazBZQW5UUXpVQmt0dnZ3NTJYSnI2bXQw?=
 =?gb2312?B?NWljTVFxZ0VXS285Umo2eFpuMGg2UHIrWGlkdlRMMkg3ZjJCSFlxazJOaE84?=
 =?gb2312?B?NkpzQnFmWUI0U0xUN1ByOU5qUnRXTFZTVlpLUm9KWEFOQzlscUxzMmZ5RWlj?=
 =?gb2312?B?eEUyVWtUMVU1dHdiR3JTckw3VFdlcS85bXJqT1plUTFqYWg1VW52eXVtcWxN?=
 =?gb2312?B?RnArYmpzMkNEMTk3QUpLUjZLTHc0dkRPMnRhRDc0M21YdjFxSXZXcm9IN01F?=
 =?gb2312?B?RjN0MTliVm1lSnd1ZjQzVzBxME9EVy8yNlRGZTZ0QVV5UW96Y1g1VW0yZnVH?=
 =?gb2312?B?empqNlFPMlZzdTR0ejNWaStVQjlUd3Jmcm51Q3VMUFV5dThIK0NpbDMrdXBH?=
 =?gb2312?B?U25PUmpVNForRnF1WnBjeTJEdStrQWppU2RQTXFBMEg0azFMN0xPazRmeW16?=
 =?gb2312?B?cjJNSXM5TWNBTWh1UEFCbHVOUURoWmFJVE5wdHZMQU9CdlgvbTJzV25La0R0?=
 =?gb2312?B?TE5Rc21VUU9lb0wvcHBzcjBpMHl0eWJSNFhsamxDU0tjUXU1M0JQbXk1SzhB?=
 =?gb2312?B?M0tJalpROS80Q0grcCt6a0R6cFVVWVRnN0NzOE9zc3kvbndTeGhxRE95RmZG?=
 =?gb2312?B?TVMvNUxiRXRsUUNUVm5WOHpiK1hPaEFTNFMrcGlYWFZLQWR2QlFFS1lHSHFt?=
 =?gb2312?B?SFd6Yy9qV09OdTN5WEtmRG83dGNjdytvazg5WFNoT1VNMW81a00zeURGbXov?=
 =?gb2312?B?WDY3N2hNM3JuRkpxWTlvek11eDZlUFg3WXU2QnNJeTFXZ0MycC9yWkZlUVJT?=
 =?gb2312?B?eElHd2VUSlVLM28xUExyVTJUc1N4Z245cm5lL2gvdm1OaGVwOEZjRFJWZlI5?=
 =?gb2312?B?bUhvbkt5UVJGWXlVLzRkbndBbzRKMmFRZGpXZTBkVjV2RjRWK042bVRkQmFh?=
 =?gb2312?B?L3J2a1RRTUZnK2xqREgraWs0MytQall4QTBaN0pUU1pTaDd0d3NhNmR2Z0Yw?=
 =?gb2312?B?dXpCdTF3ZHhQRWFPc0lkNEc0M0hWZEFoK29tWWtmYWROTnRFZVJBODExaHQx?=
 =?gb2312?B?R1ZaSVZrcnNtWnpCUzJkZXNhWmFObWhmakZvamJ4M1NxOUxmTEtsWUtFeFUz?=
 =?gb2312?Q?OFXryaARjwnqtAO233PzXWh3Zn8Rf1ijUNgao2J?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2913.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311eb91d-fc95-483b-21f1-08d8fafabcb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 01:56:48.6734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSKLZ17Dq+lfGTW3uU0GgB5FhIo46WjilQwzheFWrzR5oVhL2ymSAZ5aajYnn0tuniE7OgQJezNeUy6Fn2TVqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2995
Message-ID-Hash: 6RBUPHMPKVO43N6FTGIBFAEEFTGNHJAH
X-Message-ID-Hash: 6RBUPHMPKVO43N6FTGIBFAEEFTGNHJAH
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NK75CKSQ5IN4Q7YGKGJMMJ7MUKJWSEQO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Su Yue <l@damenly.su>
> Subject: Re: [PATCH v4 7/7] fs/xfs: Add dedupe support for fsdax
> 
> 
> On Thu 08 Apr 2021 at 20:04, Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> 
> > Add xfs_break_two_dax_layouts() to break layout for tow dax files.
> > Then call compare range function only when files are both DAX or not.
> >
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> >
> Not family with xfs code but reading code make my sleep better :) See bellow.
> 
> > ---
> >  fs/xfs/xfs_file.c    | 20 ++++++++++++++++++++
> >  fs/xfs/xfs_inode.c   |  8 +++++++-
> >  fs/xfs/xfs_inode.h   |  1 +
> >  fs/xfs/xfs_reflink.c |  5 +++--
> >  4 files changed, 31 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c index
> > 5795d5d6f869..1fd457167c12 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -842,6 +842,26 @@ xfs_break_dax_layouts(
> >  			0, 0, xfs_wait_dax_page(inode));
> >  }
> >
> > +int
> > +xfs_break_two_dax_layouts(
> > +	struct inode		*src,
> > +	struct inode		*dest)
> > +{
> > +	int			error;
> > +	bool			retry = false;
> > +
> > +retry:
> >
> 'retry = false;' ? since xfs_break_dax_layouts() won't set retry to false if there is
> no busy page in inode->i_mapping.
> Dead loop will happen if retry is true once.

Yes, I should move 'retry=false;' under the retry label.

> 
> > +	error = xfs_break_dax_layouts(src, &retry);
> > +	if (error || retry)
> > +		goto retry;
> > +
> > +	error = xfs_break_dax_layouts(dest, &retry);
> > +	if (error || retry)
> > +		goto retry;
> > +
> > +	return error;
> > +}
> > +
> >  int
> >  xfs_break_layouts(
> >  	struct inode		*inode,
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c index
> > f93370bd7b1e..c01786917eef 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -3713,8 +3713,10 @@ xfs_ilock2_io_mmap(
> >  	struct xfs_inode	*ip2)
> >  {
> >  	int			ret;
> > +	struct inode		*inode1 = VFS_I(ip1);
> > +	struct inode		*inode2 = VFS_I(ip2);
> >
> > -	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1),
> > VFS_I(ip2));
> > +	ret = xfs_iolock_two_inodes_and_break_layout(inode1, inode2);
> >  	if (ret)
> >  		return ret;
> >  	if (ip1 == ip2)
> > @@ -3722,6 +3724,10 @@ xfs_ilock2_io_mmap(
> >  	else
> >  		xfs_lock_two_inodes(ip1, XFS_MMAPLOCK_EXCL,
> >  				    ip2, XFS_MMAPLOCK_EXCL);
> > +
> > +	if (IS_DAX(inode1) && IS_DAX(inode2))
> > +		ret = xfs_break_two_dax_layouts(inode1, inode2);
> > +
> ret is ignored here.

Thanks, it's my mistake.


--
Thanks,
Ruan Shiyang.
> 
> --
> Su
> >  	return 0;
> >  }
> >
> > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h index
> > 88ee4c3930ae..5ef21924dddc 100644
> > --- a/fs/xfs/xfs_inode.h
> > +++ b/fs/xfs/xfs_inode.h
> > @@ -435,6 +435,7 @@ enum xfs_prealloc_flags {
> >
> >  int	xfs_update_prealloc_flags(struct xfs_inode *ip,
> >  				  enum xfs_prealloc_flags flags);
> > +int	xfs_break_two_dax_layouts(struct inode *inode1, struct
> > inode *inode2);
> >  int	xfs_break_layouts(struct inode *inode, uint *iolock,
> >  		enum layout_break_reason reason);
> >
> > diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c index
> > a4cd6e8a7aa0..4426bcc8a985 100644
> > --- a/fs/xfs/xfs_reflink.c
> > +++ b/fs/xfs/xfs_reflink.c
> > @@ -29,6 +29,7 @@
> >  #include "xfs_iomap.h"
> >  #include "xfs_sb.h"
> >  #include "xfs_ag_resv.h"
> > +#include <linux/dax.h>
> >
> >  /*
> >   * Copy on Write of Shared Blocks
> > @@ -1324,8 +1325,8 @@ xfs_reflink_remap_prep(
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
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
