Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61735376FB8
	for <lists+linux-nvdimm@lfdr.de>; Sat,  8 May 2021 07:26:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EDDE4100EAAF0;
	Fri,  7 May 2021 22:26:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.159.83; helo=esa6.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E46E7100EAAEB
	for <linux-nvdimm@lists.01.org>; Fri,  7 May 2021 22:26:40 -0700 (PDT)
IronPort-SDR: sDHXWIVpvAjtMaVQC0yuKmAnHkOqJ/3Whja4/WqPTZXtkr10druYH/z5gzzuZVnGNn5Ho+33wv
 e5j7fVxOcXNmBHZw1XtGOzGLaAf+e9zvtVO4lQ25qhRhkoE5hHAlichlsVZgU7DLHO/k+Jkpw7
 cxZSIcS+NIdlvYWIP+cx22LqUpxeXN4l1IczDbu+gONtqWT8MbeMTHVYAfyBm7lixmrbLcWlBs
 w1os0YzrZ7B8L3opeObhMhho6Nh7xhFBcpvoLlEniHcglNxsXdhiRhWJI4t8XgRhJBNuOqMAoe
 GkE=
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="31107942"
X-IronPort-AV: E=Sophos;i="5.82,282,1613401200";
   d="scan'208";a="31107942"
Received: from mail-os2jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2021 14:26:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1IggSGYzbkNfUj3P18LztakePeTkcHiDulieEBJBddeF7fZx1g0BeFFC71V0HLOC+7PveX785faIbiNgD/Vlk+dMPh/nQiR1FXfVa9OgzF3wa8md9rV1L2uHhjZTVcExSqUdrgus3mbR4b41ytvfjKxwYjTdMT5Z/DURuQXVyx6GNtFdRUVXtYs1amhe4EKXk3uU30aMjSUTIg+jSc3eoT/PrRIK7DldD3mk0KEMV22TSIJm9VFo8SiZwowiDdwOMQZzA/A7Tn7VEYU7E5QTn9cEZ92CuM9DRmbQ3vNM6gJ1FWwA11iTgt5zw/7+ixatFFoY3yDtZfh1z1RxzFvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOeC3vu+7clFPbAHDHS3thSf5/YASS1sMfLbA5OMCBA=;
 b=RXdBx9V44F3xhpL8+5aP33B/N4fKYoWPLbvaFH8+yLxvlYjBpNm4gO3rqvCMShy++elevHYutGKZLKnINYDUGX+4C9/BrowWbHT+gf1mOj34q+lkMuTXIH+UVOZBLqtxTwss5D9qFhWHqLQHYQIPm4lnjVqXXS4xkYyhhVaaU3pTioc1rTYI0EPGiZacV34F7c0+r/sgNuhL752Y268GX0CJt7v2f/YJScrwkJ2iNB0J61hhy8GfnIAjiPKi0HujWzFkcWtFMP4m/NmivG4y2HgLubJgGSrVFlZyNbt6jqRgiYrD/bqrEEEC8czcXieoF6bhwi7treYSlmpecgqdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOeC3vu+7clFPbAHDHS3thSf5/YASS1sMfLbA5OMCBA=;
 b=WatrRG8c2VKu7SYHO4uIHb1OOrVwft4sgWQvgokI2kVotwYcSDNQsVNoe1VIQUiUuvomyU/5s/VK9v66yu1ME23OhUkdUXO26MslOWK2yePCSInYwlYWNww6YaqTuAuW6jHxo6WlzR0OgkK4WDwwz2C4cbGOdLcOl4nCNuVLG/k=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSZPR01MB6293.jpnprd01.prod.outlook.com (2603:1096:604:ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Sat, 8 May
 2021 05:26:32 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4108.031; Sat, 8 May 2021
 05:26:32 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [PATCH v3 0/3] fsdax: Factor helper functions to simplify the
 code
Thread-Topic: [PATCH v3 0/3] fsdax: Factor helper functions to simplify the
 code
Thread-Index: AQHXN325ZvNg0AwKgEyTZt/tgpBu/qrZJMtA
Date: Sat, 8 May 2021 05:26:32 +0000
Message-ID: 
 <OSBPR01MB29205D645B33F4721E890660F4569@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210422134501.1596266-1-ruansy.fnst@fujitsu.com>
In-Reply-To: <20210422134501.1596266-1-ruansy.fnst@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5df88144-5d5d-4a9f-739b-08d911e1d701
x-ms-traffictypediagnostic: OSZPR01MB6293:
x-microsoft-antispam-prvs: 
 <OSZPR01MB6293271876D5981797A260B3F4569@OSZPR01MB6293.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 cc9u2bdaMbUkID9Edub3sB5dBGouniStjSEfaSRKtCH/OcGR5QlpTIfjIjtK8sjSh5jqpJuSfAgfMdclVzDRjICWSu/qmx7SWxn8kmu6zXSHAyEOSRVVsEW4S7gqlvqrro71S3NGN12WuW0COx+yuGDBsw7GJgKw4OzFAFGO4S3byVrjXdD16vKX6VTQXFeayvu1al5GnqUVIRft+X91hIskl+CAyv2DHXsHT6aAJRr30ILBfEHhVho1frm9tyavOmM8bvrrQJ+i31pHFeDYx6kgvQBKDogrNec0vKCeqX7dpr04LkmrWKdgYobUntMd15i+wC4NTB8ap5LWR+Wgd9hNWMXZdhRu68NDbx6syUNWbxTkVASSQU4uC7NkTHOm5l189fnxrKuh0Vl4QjjdCVIET1UifpyR8wMqV8H1PeCpF6HwPvikUHzYm5/4Xn9w1GjiXuQngD6VNakdQFwFmrWSyX+YT212Mem9/zkqyfUcBM/0FlxCKOLByeD8SRbdGc0WrviVQ9usrKTvOtkj2Potx/RnsZY5Z3gmU9XucR7p6+nkt+NUlyGysRP3DnpdxI3EOmIVpUPZ0Jj6oyCOFMjIiSGKk0bQF1R8jXHeMKXdl7kspntxOZfs1DlH4doDgHIkK7kVciDKkiUzuC95htOF9b7l7vNysHlO7nHUwtK4nBijOpnx3Ds6IY6uHhbc
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(33656002)(7416002)(186003)(316002)(8936002)(8676002)(85182001)(26005)(71200400001)(7696005)(4326008)(110136005)(54906003)(122000001)(52536014)(76116006)(66946007)(66556008)(2906002)(66476007)(66446008)(9686003)(38100700002)(64756008)(5660300002)(966005)(6506007)(478600001)(86362001)(53546011)(83380400001)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?S3E5cHNsY0t2V2tiZ2lBdmcvSUNwVksrNWg4Q2ZEWm5OTCs5aXVwUkpTOGxq?=
 =?gb2312?B?SkJ4ZW1OTTVCSnI3RnpoUlJXR2FiNFpRK3JoS296eVAzVWM4TVJJUFlVZUUr?=
 =?gb2312?B?M1NNN0JrY3laWnZDd2FZdjQ0RjVVaE5jS3NlQ09neUxZM2FxaDJZdkVSR1Qv?=
 =?gb2312?B?b1BieDhhRENaN3B1YkNOMVk5TWdWcjdKYy8rMjVhOEVsdDQwQ0pKZ0R2Zisy?=
 =?gb2312?B?S0xTYXppR0h2V3hQVmlvTEprWUVrMnZkNmNaYzB5MktuREpFTm8zRXNvK3BX?=
 =?gb2312?B?VTRKMTRzQ3A2dFZ5V0RiclhQZFdzdTVVblNOVkhiUnlJMlVKY2xoV2tyNTdJ?=
 =?gb2312?B?YjV4RGRLd3Z5SVRxSlBqbUlKMVMzV0RQZ3RpRlhCVUhqNlJnSXhmbjFZU3Z2?=
 =?gb2312?B?M0NoQ3pvQzVBOXJIUFFaejNmb29CbThOQkJ5cmRsN1loSVMxVkNuWTc2MEpw?=
 =?gb2312?B?NTdPOW9EOGRVeXg1RklHV0RjWUJHcGpzMlN6MXFTMksxTjJtVDI4dHBrUkJl?=
 =?gb2312?B?aDRZbEdjOUhiQnNwcVRKTHpmRUFlRWN3WlcvOUtEdEJneGllallKZFY1NWd6?=
 =?gb2312?B?eVdnajRrQXBGNjNvcXdHKzIwUlJLTWh6TG5pZXFOQU5oR1ROWDJENDFVZVF3?=
 =?gb2312?B?amQ5dW1nT2NJOWdPcDdJVEhsZlJHNWY0NXR3SVlkRDBsUVNraHRwWmRVbzR2?=
 =?gb2312?B?Uy9QTUtidlh5ZFJUbEZGOWprMmVORXVuOFhBMEt1VnAveWtjalFjeGN3dHVo?=
 =?gb2312?B?WTFmMVdIYTZybFNsbVFnMCtQU1RyTWF1M2d4SzN1ZmtrczFqUUhYMnVxalRB?=
 =?gb2312?B?cHlkVnM4TlBhaXRpelZxSmZGekFtK0pYOWhTeFBUWWRCUjRzekdHemF2NjJp?=
 =?gb2312?B?N1plcHlScTZnUFR3WTVRRDU0eVZhVmVRU0ZXcFdYaUQ1UElOVHNaeXpKaTdn?=
 =?gb2312?B?RGdCOWRRQ3AwZTJEOUQ4cjJ4VGRBdTVEMXhpb2RLTTRWQjdNcDFSbk9heWg1?=
 =?gb2312?B?TWRCZUlDTTdWbGZBUzFKbFJLMExlQW5Ld2d3bTF1ZHVDVGVhWmorbG5KbTl6?=
 =?gb2312?B?bXVSYnN6aStKWVFoemw1VUw3TWpJMkJTSGRvczRsT3M3WURiY0N3S2R1SHJR?=
 =?gb2312?B?Z0ZseGoyRWVkaWlLaDhZSWpnWktzczFoY2xiaDNNMnlwa0RnUWg1SVRWb2la?=
 =?gb2312?B?c3VQdWdkdy9KTXAvdkVyYkVTU3NRTEhnU3owWnNDR2NwRjA1RXArSXlNTjky?=
 =?gb2312?B?aEVRcmhmdi9QMXpRVU9zU0crTkEreE1IMXF5L0RLdktWN1I2bFU4V0xybkNW?=
 =?gb2312?B?MkJIOTJseko2VU9sQVN1YnE1cVd6Z2pqeUFZZ2wxNlpnOERaVExQSjF6aDgv?=
 =?gb2312?B?ZGcvWTBucWNlMk1GWTZ6ZUVoZjdxcFZUNUtWNDVZaW1TbTlDWUU4djUzMFla?=
 =?gb2312?B?MVFiOStwVmEwRHJWL0tDNmtMei9mdzVnRnNRTXU1TlQ5KzRVV293cWF0RGsx?=
 =?gb2312?B?bGlUamkxaFM1WmZFVWFLKy9ENVdOZXJSeUVrU2RJMUtuMUxqcWV1VHRjaGY1?=
 =?gb2312?B?Y2tobndDMkRqaW1yOGI2djVVb2txVFRray9GWUhnWW8vU1VLbXVKSFE5aEZE?=
 =?gb2312?B?WHJtajBjVDgwNzB3TUoxS3RlZHprbTBNc2ZLU3RZdDZCSGVYVytXMGEzVkVF?=
 =?gb2312?B?WmFHNnZPVyt2R2dFTmtaam1adEYzK2Rpa2FpdHRxNmRJM21iSTh6WU5PZEYw?=
 =?gb2312?Q?chKMTlGsrX2bHXeDlJr8xF8o1RSPkaSRgR9rcTc?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df88144-5d5d-4a9f-739b-08d911e1d701
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2021 05:26:32.1596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tmc3JVee0tT5HXUWFd/ubGa0FB96bemoZrISCS1DQzugBq3SRFE1oQZbyIqfcjvQva1vChKRFrMBfDPziVV7CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6293
Message-ID-Hash: VJIIESGCGY5Z2MPS3PJ4UPH4KF6XPPIT
X-Message-ID-Hash: VJIIESGCGY5Z2MPS3PJ4UPH4KF6XPPIT
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OT5CGJICXZOZR3OXZHT5B3N2PFMYR3XY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, Dan

Do you have any comments on this?


--
Thanks,
Ruan Shiyang.

> -----Original Message-----
> From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Sent: Thursday, April 22, 2021 9:45 PM
> Subject: [PATCH v3 0/3] fsdax: Factor helper functions to simplify the code
> 
> From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> 
> The page fault part of fsdax code is little complex. In order to add CoW feature
> and make it easy to understand, I was suggested to factor some helper functions
> to simplify the current dax code.
> 
> This is separated from the previous patchset called "V3 fsdax,xfs: Add
> reflink&dedupe support for fsdax", and the previous comments are here[1].
> 
> [1]:
> https://patchwork.kernel.org/project/linux-nvdimm/patch/20210319015237.99
> 3880-3-ruansy.fnst@fujitsu.com/
> 
> Changes from V2:
>  - fix the type of 'major' in patch 2
>  - Rebased on v5.12-rc8
> 
> Changes from V1:
>  - fix Ritesh's email address
>  - simplify return logic in dax_fault_cow_page()
> 
> (Rebased on v5.12-rc8)
> ==
> 
> Shiyang Ruan (3):
>   fsdax: Factor helpers to simplify dax fault code
>   fsdax: Factor helper: dax_fault_actor()
>   fsdax: Output address in dax_iomap_pfn() and rename it
> 
>  fs/dax.c | 443 +++++++++++++++++++++++++++++--------------------------
>  1 file changed, 234 insertions(+), 209 deletions(-)
> 
> --
> 2.31.1

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
