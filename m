Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D6233067C
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Mar 2021 04:38:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B085100EBBC3;
	Sun,  7 Mar 2021 19:38:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.152.246; helo=esa2.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B278100EF265
	for <linux-nvdimm@lists.01.org>; Sun,  7 Mar 2021 19:38:29 -0800 (PST)
IronPort-SDR: H/hV0Tkx8RTH0Snb8FCcvcfcKVicJC6FyVLmB4JjiuEfT+WAPK6h1ipAIS2KxKR+sn2TYQheXf
 Z2h4ZN9CuyLJGdfYWEtMsnsLzmQLIXFPU+iP/+Gq/5lbyotRc9+zwdaTnJY+aehEfmVJ1k73il
 3zlLRok0XTT5ndApjeW+9StB3nWyJVdIXYUiwtWdLVKT1R4T7zLx/bxBJc2POdNlIrG1VT4J+z
 SN0opm9FkhxVxLe05b32uCiFOIQE0MVIFB5Xt3TGm/dJU5HoRtI+pMbHLDBRqJKw57KTGXF/84
 klQ=
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="35607024"
X-IronPort-AV: E=Sophos;i="5.81,231,1610377200";
   d="scan'208";a="35607024"
Received: from mail-os2jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 12:38:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nno42MreUxJQjbJ+K4KkGUpIDnVUALLuf2gnlt7p4CA2/9Mo5qii5A+sQ4eaXLn+zp41NZrMj81VzzeSW+v9tE9cn9bA/UWbItyfP4rHKT1ur7Q9X+gSD0gcZ1j37jG321uP0Sid+jX+kzsP3b/NT4zv/ZN6Z4dpVK874NP+oKUOeKWEqX3nx8nm85YDN4Tl+j6wTAOsau0DLfSXM9CqmB93teEzljZgyAZqfa3KMVrb/edWSCRn891JyoOT/s2VbAvhfZWyMovVuMm6dgkWzqHEeICWHMvdsuzz44DXNVuhI3Vgt9KT8C90uF5hV9XDPml8ehDa5MwFBaItZrilAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drJqISjTiVKRcv0otCdyH/ehFTK9ipTCRLB50U+HdWk=;
 b=oHHjP44bbc1dIzhuNA9hyEp3K8MzAQ/0+gKC/jf9F841v6+/HVhCFlDd8xxtL7ONiPimD2QbwpIN40wqx/WzvmRghbMCnqShXZKF3j5ENG9+nUfLt/08KcO4uSqqGCSdvjmWp0PEmQFiF+jyLRF11PCU6PH2xXuHjoavGRfHV2XyLxbmwVKobcLDx76an/J3KxhXF/G8Ekq4kfVWyvA7OwfQWuIuB8v6q7mahHq/BP70xzjmucAx9w5FB0hlO1pNOgcL12R/Gs42BQOHebtTlD2DWvyk0IvtYgfUl0AtngljOjDopZHcLNFsIBqQ7z09ZIkBXDjn8ZHNOhnKcpqZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drJqISjTiVKRcv0otCdyH/ehFTK9ipTCRLB50U+HdWk=;
 b=B67FYMwRClBGcas65eHReK0N59hcj9Cls3h6435+X3WQ5m0fc+JIpPke9TAYuGPJLxQ+M5iQ5gCxVH6EqUaMcxIl7K95rlidXOXeOQ/8OEinIKV/h1yohxEo4cVUlR+79tJPklmm+dlHLcbZNOaDHVIn+l2WtBfGjFEntSEsHpQ=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSBPR01MB3063.jpnprd01.prod.outlook.com (2603:1096:604:14::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 03:38:21 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063%3]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 03:38:21 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Topic: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Index: AQHW/gjzAa5hnh6PaUq187fVBTbxkqp3lL+AgAIDAHQ=
Date: Mon, 8 Mar 2021 03:38:21 +0000
Message-ID: 
 <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com>,<CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
In-Reply-To: 
 <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [49.74.142.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89145445-ce53-4a24-fb1a-08d8e1e39efd
x-ms-traffictypediagnostic: OSBPR01MB3063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB30634E86D05876482518D200F4939@OSBPR01MB3063.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xWqVxLYZCgGUV3torY93IL7K1W2JPbIASE5YIgoXK/O4zF26vcmuStKJcO9VThTYwlXddW4zRruAfhxgjiUwkCRm6gTGppUHkCBYPAMp4+nk6ip/gUX0QDZgMQ4H2QpAr+HeO+EHJvaQ+W8c0xnbq+oSXlFeQuGbeRVOC5OXSRpE7JYwOWVoS1IzpNRN/M4qms47yGljqAszGqVr14sWytzIp0/tf3Gu0wCz5w3BwpGDBfrF/dRQEiRoRaZ6uvqQO9J2tBXpsgQIy+kZJwLzUp0axPLYmBJwTjwRnw0bsZkuEi4ZqY9IK53aW5qTA39fQFSCO7qWfPv5Eiq7V3h26zCEvT4GsFArZ+PKpLugguHwdUFHEtWO7HhP0rMmrIaGSqyfM9/c83CkrfHIIYjJ/l0lvdAejCozgRufyZQ8aCnObCZZwDdU8Vj6QXOakKq0NT2yl8nNDFM1b9RZOw6zMGmoCV8d8MYSXTNh9Lz7y0TE9bxDGs0Mg4ApDK5sld8D3pl06MRwzSEIvFBYDcMOxg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(91956017)(33656002)(8936002)(4326008)(86362001)(478600001)(52536014)(6916009)(66446008)(76116006)(7416002)(54906003)(71200400001)(55016002)(66556008)(8676002)(83380400001)(64756008)(53546011)(66946007)(66476007)(7696005)(107886003)(85182001)(2906002)(26005)(186003)(5660300002)(316002)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?UTdWSFVFbDM5QlY2Q25Ydk1hckRqUlBSVENjYlFIM2d3czhtZE1WbjB1cmZR?=
 =?gb2312?B?czdORWJaTFljU1U5b0g2bERtbTZiUWNuYXE4SjRHODBTZkFqVlpNbHVkcGtY?=
 =?gb2312?B?VTVkVDVESlQ0elZudlFSdkhhNVNQS0piRGlhdDBtK1FZY2JPbXVyVm5DN0tn?=
 =?gb2312?B?VTVUblA3N2FZRlN2bm1PU0d1cHdJR0toUXV1dDhPcnFEQ2VxWVVKM3BJMjUw?=
 =?gb2312?B?ZDNiRDR3Vis0cG9wS3Y5V3FFNy9EMXo5QjJ2WXozclFnMHdkbkpjYzgyVXZj?=
 =?gb2312?B?bUhqbFVYVG54QkRXVW5PMlB3TzRWbi94VGdTSWhoUXRhRnhOQWlsVmJoQVJn?=
 =?gb2312?B?YThZSzBOelVIVmU2QVZOOEMrOTd0VE5xZ1AvVE9SVGU2RExDVU9GNUJmdkg3?=
 =?gb2312?B?Rkh1OGxuelFudnVGUGQxZTZUUkl4Z2RCNERTWFljSzF2dWpSOWZZVWFSUkxl?=
 =?gb2312?B?Sjk4cnplK2pVNGlBdjJHUVUxR20wVUs3TXZNZTNyREFsamx5enltTm5TVE9C?=
 =?gb2312?B?d2NweitEZzZHazUvVnR5d1hsUCtjWlJxZlRBTm1wdnFpRGxMSTJHdmo1NE1D?=
 =?gb2312?B?ZVF2T3RYZEFYTmdTVWVvSkFPYUFGRVE2U25uT1JkaEJWbE00V2QvdDFqeWl3?=
 =?gb2312?B?bTNkT0ZWSlFjelJCMGlDYW9EUUF6SDNNamtYQjlBSk5LVDg4WHNSR0VBUFp6?=
 =?gb2312?B?a2F6a09ORFFuRUhqU1NYOWQvdGIwTzhlR2MyMmxjcm1LVUtqZFZnN0FJOVBl?=
 =?gb2312?B?S3o0S2d1QzNiS3prQlJxTlAvRTVTaHBkRE1tVEdzd1pRWFdDYnEwelA1ZXds?=
 =?gb2312?B?RFoyZEhpcGU3MHJWYVBFZ1AwaVlNZ1k3dTRBMHJubHZudlRiWVd0a2tHRExk?=
 =?gb2312?B?c1NHdE1mS0F0eFAzYnJwdGtGTXZlUlFyVVZkQVIzRldtM1pKajh4Z0RmdE5n?=
 =?gb2312?B?MEEzaTc1TGJoSDhHSjJXRjF0dU1jVjJna3o4TjZ2QW5BaldmazNyTXJEWTJj?=
 =?gb2312?B?MWVtd01RenNBN3ZMQmhnQjNZWUc1SGZDenBnMHc2eWtpR0lWZnV0T1ZXMHd6?=
 =?gb2312?B?MURqdkF2UWpSdzlBUjBtOTV2VUlkTVl2UTAwdnFwOGxhRmlyeTFNUTRaSTlW?=
 =?gb2312?B?WDM4RGY2d1lxVHlWK1VnMGorVzdqbUEwSW41Uk1xekFoOVh6ampnck5UdW1q?=
 =?gb2312?B?MWFDMFJDaXdDVDZWdzJ1TEE2VHZnTHZKTG5GYzRhb1FrdlI5aTBGMTZNaHJp?=
 =?gb2312?B?Nms1QlRrcDh5YTdHSmVNYUhrY2N6R3Z3T0hkT2tiNnNsZkplQmV3Ni92WVdM?=
 =?gb2312?B?bDlYeW9pQVo1WDgzTmpOTm9KSGFPb0MrT2QwMDlzc2RtWmpwRndZRFZlUGZY?=
 =?gb2312?B?WVplemVodXplaFNOdFN5U2FUanV4b3BqZW8yYk1JV2IyQTM4UVQ5SkFYZzgy?=
 =?gb2312?B?TFZmZkpnTnorMy9zaXFGcFpDQVZBRkhlYzRHZ1BZZE95SVEvS1pja3JaYkNi?=
 =?gb2312?B?VktHRWJRMy9uRFc1eENVeTNpeVVJNDJBVGc0bFo0TDJVRzVPRDV4d3NGaGEr?=
 =?gb2312?B?L0dPVmNvL1EreDFEK0JRSWhCdW1yTHZQNEl6SERqaUpLMU8valpwUGJiQTlz?=
 =?gb2312?B?N1ZkQ1NoR2JoWkZ2YXhvZ05kZEdWRFlLcUFQTW5PdXl6YmxhQTV6K0JQUTVr?=
 =?gb2312?B?NDNCbFVYdUpGblJaMWU5elUxdlhzR0ZQQVdDS1FVbjhJT2I2MzJkbjlGWjdk?=
 =?gb2312?Q?Ww7HIutj9JfdUZRldo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89145445-ce53-4a24-fb1a-08d8e1e39efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 03:38:21.3416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZLP7UReXXhVhPijuXgAj5ZBb83+M4KIepnbBBJ/89kl4ymOfsQLvzDlc5c9M90Wa7jiIYcNs4e2Id2ssQxzDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3063
Message-ID-Hash: 6E2T4HTFI7ML4Y2OTERCZF5KCNYD7XXK
X-Message-ID-Hash: 6E2T4HTFI7ML4Y2OTERCZF5KCNYD7XXK
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, device-mapper development <dm-devel@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Goldwyn Rodrigues <rgoldwyn@suse.de>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "y-goto@fujitsu.com" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WNUOMP7FDWWGGWHKKFDPNNQNR5KUPYBJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> On Mon, Feb 8, 2021 at 2:55 AM Shiyang Ruan <ruansy.fnst@cn.fujitsu.com> wrote:
> >
> > When memory-failure occurs, we call this function which is implemented
> > by each kind of devices.  For the fsdax case, pmem device driver
> > implements it.  Pmem device driver will find out the block device where
> > the error page locates in, and try to get the filesystem on this block
> > device.  And finally call filesystem handler to deal with the error.
> > The filesystem will try to recover the corrupted data if possiable.
> >
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> > ---
> >  include/linux/memremap.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > index 79c49e7f5c30..0bcf2b1e20bd 100644
> > --- a/include/linux/memremap.h
> > +++ b/include/linux/memremap.h
> > @@ -87,6 +87,14 @@ struct dev_pagemap_ops {
> >          * the page back to a CPU accessible page.
> >          */
> >         vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> > +
> > +       /*
> > +        * Handle the memory failure happens on one page.  Notify the processes
> > +        * who are using this page, and try to recover the data on this page
> > +        * if necessary.
> > +        */
> > +       int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
> > +                             int flags);
> >  };
> 
> After the conversation with Dave I don't see the point of this. If
> there is a memory_failure() on a page, why not just call
> memory_failure()? That already knows how to find the inode and the
> filesystem can be notified from there.

We want memory_failure() supports reflinked files.  In this case, we are not
able to track multiple files from a page(this broken page) because
page->mapping,page->index can only track one file.  Thus, I introduce this
->memory_failure() implemented in pmem driver, to call ->corrupted_range()
upper level to upper level, and finally find out files who are
using(mmapping) this page.

> 
> Although memory_failure() is inefficient for large range failures, I'm
> not seeing a better option, so I'm going to test calling
> memory_failure() over a large range whenever an in-use dax-device is
> hot-removed.
> 

I did not test this for large range failure yet...  I am not sure if it works
fine. But because of the complex tracking method, I think it would be more
inefficient in this case than before.


--
Thanks,
Ruan Shiyang.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
