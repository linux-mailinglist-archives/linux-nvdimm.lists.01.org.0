Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3F436BD72
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Apr 2021 04:44:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 63265100EBB80;
	Mon, 26 Apr 2021 19:44:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.71.158.33; helo=esa16.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 669AF100EBB7D
	for <linux-nvdimm@lists.01.org>; Mon, 26 Apr 2021 19:44:42 -0700 (PDT)
IronPort-SDR: TqZBe5NlH/Ed7W6BVPwgqH0mKVb0zv2PuYmRM2LP3tjbHH/lQJGGBLmPa+8GqXNVyrLujJ1djf
 6GNAlOSNc8dhMWFS+oFEy7cPKlt8/eS9ZYWwhQ2eAit5zYVYoF5q6ftbZDwzSOPzwE/uDE8tCc
 ZD+5T47w/rb5Ley/mW+VYkcM4JJEVFoxtk/IzgAE+dL6vlv0sfndH1uZWRbGHWBw/Oi/gpiSKs
 clEe1a91fRSnrLL7wwAz4ulFQjvS/A5zZAqxvk8MIz1c42kAfBqQikPgx28YlhOm7dBpLxgIrj
 A/M=
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="30438281"
X-IronPort-AV: E=Sophos;i="5.82,252,1613401200";
   d="scan'208";a="30438281"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 11:44:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in7FapKBuzO4JwaIOBLsQz4KzmgfsM5jT2pvrUwrcRDbVgXjnxd0XV/cgUlVOwLyVste52UC2IaXArcqUSXwjyxlMIB7QHPE8jscoQ5ibWqbs+GvR8TB6Ko2hS8uW32BaCTJ7WEJf18SiYkP3vJnitffq0NvydecwovkJ8raRS7bJVC/Ec2i3YpWEWPPxUu5zZa72Yo/EFTXcRmfZh1nR3QbpplnoZBuLfk4FyLVqqmjLLX2Z5kk62IqOjTrfWzx65QSpAFyYKUJsWeW2h8OSPMf38mQoRdgUDRXbdL7XkC3HOGmzZ5ICJxtCuhCJ5kritNOk7KvRK6VNRdfx4PYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0OIqqjv5K7zMT2rdwr+Ri7zoRHqzJU+Hwd0xJ360ZU=;
 b=oLnsILGT57DzG6FC3zERU0ap3U7r7Fhu7OiD9Z8Ly3JilDCRZf3biF1o9i+wLQELyxYrIZl4UtpndwbQaaWwrEZ5BJ2/vphc1k2vjThgQjGTpORBrTbry3VzIXsEmkUTYNnItbR7OdqHIjpel5FDifZgCA1rRK7DJw2iYR1UDIYN5g0EJ72lvc8d3XbLHx8EjZlEzXs/K+rcS59fH3j+TR6E8QWicWDq8qGGfiumHWP90FRoTCB9j64YHEPRGxXsSCJ0PRHwJP2orcm0Jumf9x2E3/IX6ynb4NVzZ6/fismC6dgNokAdb4dvF3fkgHkLW91/9kzk6VMBIHzpUpd6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0OIqqjv5K7zMT2rdwr+Ri7zoRHqzJU+Hwd0xJ360ZU=;
 b=FO45EUiK2JWfb1knZRQG7Ith5+fUU4Dc9oFPGTCPth8iZ/MYYS73XjDFQyn9Zr183cHfCPPMvGVRY9C0N25Q6S8ygRs7OGJ0vuQUXfKvqx4RcrUlHVwityTj4b8VsJOFdavSYZBQP1fcYTbEozQemZvaDmR6X4fGk8G/i547k54=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSAPR01MB3139.jpnprd01.prod.outlook.com (2603:1096:603:37::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 02:44:33 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::bde7:2ca6:9b9:8ce5]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::bde7:2ca6:9b9:8ce5%7]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 02:44:33 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH v3 1/3] fsdax: Factor helpers to simplify dax fault code
Thread-Topic: [PATCH v3 1/3] fsdax: Factor helpers to simplify dax fault code
Thread-Index: AQHXN33HjYLLHwr+rE+QAF3Yh+hjD6rHe4KAgAAnj/A=
Date: Tue, 27 Apr 2021 02:44:33 +0000
Message-ID: 
 <OSBPR01MB292025E6E88319A902C980FEF4419@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210422134501.1596266-1-ruansy.fnst@fujitsu.com>
 <20210422134501.1596266-2-ruansy.fnst@fujitsu.com>
 <20210426233823.GT1904484@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20210426233823.GT1904484@iweiny-DESK2.sc.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed7f6c89-6845-451d-16c1-08d9092663a1
x-ms-traffictypediagnostic: OSAPR01MB3139:
x-microsoft-antispam-prvs: 
 <OSAPR01MB3139F81F7BC5F831C35F2F7FF4419@OSAPR01MB3139.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NgtBpefexZRleSKaLMoEPk1qogFJvwX0Lkg85YOw0Rt1BFmodIgykP6vX3TpwiWDaCWsBqvlr3Ha9hTL4pgJ61cKSfyWSxpAO29tw/2InT3/nPu0qhBLfM1qQP4sxk75pd07AsYEi+eJRZnNkSIyL5DElNMCzZumsjLzzsO2vRXIk6zcCRsF3hgiaMfRM6ms7m030zdKJuqmGWyWtXZ3Eewx7X/I6sRiHwcveoVYyyH8L9JzQ+RzRCzpgQElr7vIdUPY7mWx8lTu7DZtccCcN86FraLbRaYmNsU1NO0tnJeHQr3M0djJ3rCzjAqIVFPtqarpz86emcB/cq6Kpmb955NWm+YBTeg3nsb6uus66GWXyIese3FMmT3kl7tyDatEi87HeqRkM52HgGn8mPA6eFL2z8J5XPv2IdvqRTUKQjmN8Xy7V8jZWEUnxOpmTBisxHi8u28Qvdah1GgPIE3SPuADlrTSpFsib+caUxmeMtxhZC34B9UA//dgXzuh/0/gZwG12kAAccF2Lwb8bQa6R0RxzJM/g9Dmc8hPUwkETh1seOGPONWQ+1+zlPUq2i/sAqiTFwZB5sY+jou2wFkYU//a4xEnnBaHbY70lE9tjSg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(9686003)(71200400001)(33656002)(8676002)(64756008)(66556008)(66476007)(83380400001)(66946007)(66446008)(76116006)(26005)(55016002)(186003)(6916009)(8936002)(316002)(478600001)(4326008)(54906003)(7696005)(6506007)(53546011)(122000001)(85182001)(86362001)(38100700002)(2906002)(7416002)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?bnlSUWliMUhzaS84Mzd1OU4xUThaN0pjTWNnYnYvU1FGTzRlSmt1WVRJeXI3?=
 =?gb2312?B?Q09OVG9TdnlNbmR2V0tuVEE5YlhPbGtpNmRjU1Q4Z1M1N0pBWUtPcVlyZ0dO?=
 =?gb2312?B?elBRejQzRERLT09OcmdyZGY0RmRwY3RKZWlnMFFRS0hCUnBwb1JYL1ZhQTBj?=
 =?gb2312?B?TmtuN1BjYUFvK3lKZUlPeGo4M2xaUko3d3JZb0g5V1ZBRUlaRE1nOWtzUWNK?=
 =?gb2312?B?NVJoREJMRDM4Wm0zK1RRYlZpeUhhOXBSR1VzWmMzODlWZnQwVHlzUldNNGls?=
 =?gb2312?B?WXVucmxPcEZwamlOUjZCL3duNEpIT3pWRWxVR3RSVFlvMW9YakdJK0Y0Mk9H?=
 =?gb2312?B?ZVc1TERmS01HWkViczlsWkpjU1BxYjFVeTBmWDMwQWJlTGNXTHFPaDhKemtn?=
 =?gb2312?B?S0x5R245SERIb0Fpa2wveVVmb0ZiOTNaalorbFNzQ2xiWnZBMHFvOGYwQnFT?=
 =?gb2312?B?aEYyNlY3eG85cXBDd1U1VUtjZmd4QU1rR1Jpb2hYOWVqcHNDWlZnKzRXVU5m?=
 =?gb2312?B?b1NteUw0SVhWcGhaSEdCZnVBMmt2S2NGeHRhbUErS1RDOTFVZnI4c3JBZ3lm?=
 =?gb2312?B?VlFQeHRrK0RwVVFnR2ZpWXE4bWthcFlKWEtCZFpDa0UvRkxpTVhlV2VKZktX?=
 =?gb2312?B?ZzFSODI1cjk2WUZLU1BTdFQ1QkxoSVNyY1RjNFJWTWMyRDM0SUJaWVBlMUhp?=
 =?gb2312?B?S0dDK1YrUEJsZHYvUUFlZkg0N01ZL0dCZFdpRVh4OGxSMlMyVk5PUjlNWDRV?=
 =?gb2312?B?ckdyK1lrUnlPcU8zdG1scG9OM0N2RTVROC85TUg5Z3c2cVRaajB3ZndPRzhq?=
 =?gb2312?B?Zzl4YjFPUi9ZZ2x1dmV0bmRtUVFOeW40TEZWeHJ3T0x0b2ZJZjk2QVNmZC9M?=
 =?gb2312?B?a2c0MHJwV2tuMFFXYTlrNGtLTXNwS3FoWHpJYnUwbE5tY0xIOTYrK0pDcWlC?=
 =?gb2312?B?Z0JRbXdkNVZaUjVjT0JDSkZseHd4NDdUT2pNUllkcitIS2EzUHBJT294SklU?=
 =?gb2312?B?NGRwTC9pOTZyRUh6eW9YaStvL2ZEbE8rTGRNcWdDamxMa3A1QjdVN3ZsNlhC?=
 =?gb2312?B?bHpUVWw4OVh3L1VUQ3hxVjZTL2phajRUbWxCZC9lZkR4YVpVbjREcnZUbFhq?=
 =?gb2312?B?ajlESG01cDFmajV5T05SOWhuOHlIZVJvUEJCczVhZkJZdmUzYThGMEhPdlZK?=
 =?gb2312?B?M1BpTkdCRXRPOGlzaXlmbEhOeGFQQlFIWDlxelJ3R3djV0Jhb3hjeW41VVlp?=
 =?gb2312?B?eWRnL1gxZ2toQTdwMG5iRDAvS0xtREl5RnZ6UXEyYVRkSDhpNHNPMGdjeE9Y?=
 =?gb2312?B?ZHU4eGgvYnlFbzZpVnZMcmJ4RFNRbnVRYVNWSGdQbGtwQmVyQ1NkZitRaDJ2?=
 =?gb2312?B?c1ZaTjV2Z2hiOGNrRlNKMXppRHhMSlprbjdqb2VHdHZ3ejMxcVJXcys5ZW9G?=
 =?gb2312?B?Zzk0N3ZZMGJkY01nRFBnMFA0cmk1elRCcldiRkdNTjJXeHh5VHI3eGxuSk51?=
 =?gb2312?B?WS84SWRXc2IwRDdmZzRMSlpVV2xpVjhOUWNVZVI0a0YrZ1A4aE1SUG1kNmlx?=
 =?gb2312?B?bWJPVmZnSERYbnB1dHpFRDJVWUgrcGsyUDdqRzFjcjNzTlBwRU9WSUJ0cEVE?=
 =?gb2312?B?bFNwQXRLcFVDcmlxK081YTFjTlp2bkVmSjdHdGphVHVObEN3Z3p6Q2l0QmdB?=
 =?gb2312?B?dmVEYWMwd0ZaanRkV29HOTFLamhPa29TWlFDaE5td0dzaWF5aDgzWVVXQjdV?=
 =?gb2312?Q?9rP592+hKGg7+QLTww=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7f6c89-6845-451d-16c1-08d9092663a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2021 02:44:33.3854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L//CgqHJ1WMUJ/srxouQjnq/j3gEagqULhgGjJcdNIsEWlpTTgTyS3/5zsMa2DIeR368IQX9iBMgpxD1o9PTVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3139
Message-ID-Hash: QFAO4ZLZCJ7KANWKVGLVLRPCF7QQJCWX
X-Message-ID-Hash: QFAO4ZLZCJ7KANWKVGLVLRPCF7QQJCWX
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5TA3V7FXBWDGULYKVRSXRXBFOCQD3VRX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Ira Weiny <ira.weiny@intel.com>
> Sent: Tuesday, April 27, 2021 7:38 AM
> Subject: Re: [PATCH v3 1/3] fsdax: Factor helpers to simplify dax fault code
> 
> On Thu, Apr 22, 2021 at 09:44:59PM +0800, Shiyang Ruan wrote:
> > The dax page fault code is too long and a bit difficult to read. And
> > it is hard to understand when we trying to add new features. Some of
> > the PTE/PMD codes have similar logic. So, factor them as helper
> > functions to simplify the code.
> >
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> >  fs/dax.c | 153
> > ++++++++++++++++++++++++++++++-------------------------
> >  1 file changed, 84 insertions(+), 69 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index b3d27fdc6775..f843fb8fbbf1 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> 
> [snip]
> 
> > @@ -1355,19 +1379,8 @@ static vm_fault_t dax_iomap_pte_fault(struct
> vm_fault *vmf, pfn_t *pfnp,
> >  		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
> >  						 0, write && !sync);
> >
> > -		/*
> > -		 * If we are doing synchronous page fault and inode needs fsync,
> > -		 * we can insert PTE into page tables only after that happens.
> > -		 * Skip insertion for now and return the pfn so that caller can
> > -		 * insert it after fsync is done.
> > -		 */
> >  		if (sync) {
> > -			if (WARN_ON_ONCE(!pfnp)) {
> > -				error = -EIO;
> > -				goto error_finish_iomap;
> > -			}
> > -			*pfnp = pfn;
> > -			ret = VM_FAULT_NEEDDSYNC | major;
> > +			ret = dax_fault_synchronous_pfnp(pfnp, pfn);
> 
> I commented on the previous version...  So I'll ask here too.
> 
> Why is it ok to drop 'major' here?

This dax_iomap_pte_fault () finally returns 'ret | major', so I think the major here is not dropped.  The origin code seems OR the return value and major twice.


--
Thanks,
Ruan Shiyang.

> 
> Ira

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
