Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F35A3223BB
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Feb 2021 02:32:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1C9BD100EB32C;
	Mon, 22 Feb 2021 17:32:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.71.158.38; helo=esa18.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CAB2A100EB84C
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 17:32:19 -0800 (PST)
IronPort-SDR: Y8UHaLvXo0HCKwxsBA85ThP4xXd2+k5dZ+QJ/ovjO1O3vHuT7deFEx2E1E6BMY4xQwv4qPklKa
 Kkv71nnuKnE28g6FdTwxcqJP7Hna96hFpN+7iTVeRz/dePpYFgW06Xr0UtEEe8IdFYH1q6fDh+
 BlQA6MM8o1DouPmg51IlligyRhs4cTEnkS84zixVXQlp41zT1cSVqPnOowOTTvvaQXpFTWM5ZX
 yhI0g9nHEodoeOuQA4XV65I0d9H9u5162IiZ8fhklCBs14ZNNDTZSRg4//cc61YdLtxzgWvq8q
 Q4U=
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="26942697"
X-IronPort-AV: E=Sophos;i="5.81,198,1610377200";
   d="scan'208";a="26942697"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 10:32:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN7Imi+v4hy5inYQmL7U4KqU8rH/jJrEftJZiyueWgh0gb3a92x4lTpyMW/D/x+jgAcGp/Ei3YOGD6SA62ZYmP6B0OoPqp6+sO2z4f9rKwQxTKY3EJd9dESbqBihf5P5VOoWZOLzEHeYocsqkgCd+nIGWVUDMfWI/wvTjOUx4rpTeUCjIKc6E73hPxlOHSVDQCSeyV+CHb84RCVSXMX55EP2e2japrEHTbXDnizbAUMDcC30zRIAhndRmYl1q/3AxTMw5AYd7162javBxT3iVe4qiw+t7lcNMr2HX3cKznUjIc/zoG3zOntyzUsH+cmlsVTxlaIcUKqldZfZf3gukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZOrbr2QQES6DPVS+8wsT6rYGThY5CU/2vKcjKDbih8=;
 b=jhktDQwG9JgoQ3nSfHy4FDLXA+7dvS8h5wBTYSA3vWD/CNbJ4WIoDpuc4Bm1pv/CuQSr10bDXf0KJKt0ue1RsA+IPtgMguftuVk2+mBt0ylHNQE9FHGxkDAqeogpjCjXpstssFFhBklaiBRnJ2VsdLu1zuv832SKBgxX423QtW5Ytq1IVDQptUdxrdC9O9F04O5A2N4Gp+7BCLPjrosuRAyfgWs4kF+0OL2Lho4ilZd5aWb2xsxlQlyqBOFV6UsEF/PMTFTkxEtFlga2anxJrhZwZddyp8FG1OPUoA2C6a63Gly/nULqAEGz4GdJRFLGHpXlLqyxdVyDu5T2CkkJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZOrbr2QQES6DPVS+8wsT6rYGThY5CU/2vKcjKDbih8=;
 b=HzkFg8x2XEiQBeusjC1ObmlgV9PMdisztzJrftH4rPWJDh6bLMNzHJpBBalgfJB+ouaPv2EIHa9Eb4vutpEfIUE4LaG8PpU1Rkh81GUM06ktAQDngUyHH/vPqTO3FrkXzoxvAMrz+vIsw7/LABlFNQWWRMSrzM7ieuFmhm5kJlE=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB6039.jpnprd01.prod.outlook.com (2603:1096:604:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 01:32:11 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7de7:2ce8:ffc0:d098]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7de7:2ce8:ffc0:d098%7]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 01:32:11 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: 
 =?gb2312?B?u9i4tDogW1BBVENIIDEvN10gZnNkYXg6IE91dHB1dCBhZGRyZXNzIGluIGRh?=
 =?gb2312?B?eF9pb21hcF9wZm4oKSBhbmQgcmVuYW1lIGl0?=
Thread-Topic: [PATCH 1/7] fsdax: Output address in dax_iomap_pfn() and rename
 it
Thread-Index: AQHW/XQKfp6kuelFCk2zvQMEsL6iU6pj4i4AgAEoxBI=
Date: Tue, 23 Feb 2021 01:32:11 +0000
Message-ID: 
 <OSBPR01MB2920F7474667D6D73A681D98F4809@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-2-ruansy.fnst@cn.fujitsu.com>,<cd067457-5aaf-a2a9-06b0-953f49437500@linux.alibaba.com>
In-Reply-To: <cd067457-5aaf-a2a9-06b0-953f49437500@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=fujitsu.com;
x-originating-ip: [49.74.161.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b9d27bf-23a9-496a-fb60-08d8d79ad7aa
x-ms-traffictypediagnostic: OS3PR01MB6039:
x-microsoft-antispam-prvs: 
 <OS3PR01MB6039FB526BEB63D321A022CDF4809@OS3PR01MB6039.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 w1i/uP4ES66PL/zOEIKtryJhe2y+B3TorW59BKDyCFR71Rcbsw1Fe6dJFVhkSKukGKKLqQFi82oPH/u/7ArNdIyqska5KgpG7rZwlueBNzJETxyQtITR9jVMWprCb2nNdV5mfk6ERy93G0u9tyXJdnr4KZYMSB6mq/93dFfH3iiT1fKzAIrW3Yd/Q7PLZhU8jDiJfeJRo6lfD67MzkyrMnO4818K3pn3jZTSrKnM0eXxJxm2rwN7HQbTMPHgylpPSMjvX1h9+6Gxyn9e9mMIPVigkHgistt//7RkmcyLDKwChTxMXlP4OnU8On3udOeJlLnq8bMMQo4JYuuBR7+zJFE8/6XmQWH5TQuntGypQCXLFKD3bAW00njWFmOikctIzP6KDiWzSfFWAx/wcf/wXzrfI4LqIhXbzNDYY6/IdL65T0o2EMGpEb1qDUOU2BuJag5TEJMexBhn0mM6PmlcGqSel731RRp69cx9QgaPwZrpXuYorpKujQV35U37/l+DmjBRXrMEWYkfTiYKHTqX/A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(86362001)(9686003)(7696005)(26005)(478600001)(66476007)(186003)(66556008)(2906002)(83380400001)(4326008)(6916009)(55016002)(224303003)(76116006)(66946007)(66446008)(64756008)(33656002)(71200400001)(7416002)(52536014)(5660300002)(8936002)(316002)(85182001)(6506007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?TkVKaGpkY1pqWmlUUmtEZmJEcGRtNXVlR0Y1bXIzb0twSWtyVnJNMGxWWXVO?=
 =?gb2312?B?a0VOT3I5bUF3SE5ZdVZ1b3dkcmFRUklNcHYvaHBGdGpmeXRqak1WaXl2VElZ?=
 =?gb2312?B?dkRreDYycWRJdVgrUjBLMzExTU9MeVpSL1J6Q2tnVUtEejV4WnJsa0dvN0FM?=
 =?gb2312?B?aUNXZFJwendUSENaZHZtbGV3TkI3djlMMjZBQjR1UTJSMmNCc1c3VnVBZklF?=
 =?gb2312?B?WThvQWpRQ0N4UEs2dEJrTjYyTHNFQXBOY01TWHFKQTFhOWdScjN3L1dyVlB5?=
 =?gb2312?B?eC9qVDI0eTdRYXl4VllxbHJ2M0tKdHZJWXk2SjlxTEIzczM4d3Z2dnE1Y1lt?=
 =?gb2312?B?N0VNTmc4eEhqSmdsQ0o3cEZFWWc5R3ovS3hKamlwRjc2YWtHbTRodTJsSWwr?=
 =?gb2312?B?TkcycWZGOElWTGZ6M1h2aFVpZk9WNUVSeGpYSlFuTGNpL2RLSHNHU0hNUXJQ?=
 =?gb2312?B?M1RMZDlEVlZLaWtsR3F5YUllQUJ6aXE1TzM0SmMxNUlxTHRlN1YvUzZzMkd2?=
 =?gb2312?B?MXd4dmJsQTFiMGsyMXBSeS9UbnQ5SjZqUW5iQ20vbnNuQUNnUDJtNnB1cHFK?=
 =?gb2312?B?VzFUWDFTa2pJYnU3dGh4K3Bha3dmT1drc0RGYU1sZjB4NjEzVnFPcDBrOFNX?=
 =?gb2312?B?ZGRGZng4ZHc1dFFpdWNhMzF3U1ErSjBNcEFqajJQcmhXSm95WHdnd3A0c2dQ?=
 =?gb2312?B?K1VFRW1rcnhUdVQrajdYY2RxeW1UMkdXZVVqM20yZjI5QytyeUtIUDBvMDJv?=
 =?gb2312?B?YmlON3hlUk9WWW5mcTVaek5MbjJkZWxKTWd3bDlPZk8zdFNtb3ViNG40ZkpZ?=
 =?gb2312?B?TUVsV3BUMFdpY0RlRFZBZkZhMVhlZHJTZExXZThZTTBjRFdjNURVdTh6dUVW?=
 =?gb2312?B?dXNUZDZmRExreFJIVFhJaitPS0Q0UHFFbCtERUJPWkY5UmRKU2Y2b3pGelRQ?=
 =?gb2312?B?eUd6dzlsVXBoNllYVzRzc0ttNHVsRVYwRGpuUlUrS1diVjc0NlErK3JKK1lF?=
 =?gb2312?B?NU5yYXRkcTNIWGNDVlRFdkFERURPZTV6YWZMSFBGN2R0cEhwalBtK292Vm02?=
 =?gb2312?B?czZ5SnF1UDFVelZ1eFV2T0FBN3p6NE1EOXEwNHo5NlhJa0ZRSFJoTk15VXh5?=
 =?gb2312?B?NnVvelRCeWdaTTNLNnBPNHlmMVdSR1B5Yk50YlpVTUY1N1lLejNsd2ZMVXhE?=
 =?gb2312?B?ZGVRSVgzNzBDVVZQRzBFK3pBZEMzajliS05oSC9VZExlQ1M5cWJTN1l0NXU1?=
 =?gb2312?B?amVYYlRtWjBUeU90L1NhODVFOHdLQVA4N0ZGNnFLUmI5UVJ4bzBmcDNEcnBD?=
 =?gb2312?B?dlFkc0hBQ3F2dEcxaS9SeURKNTRzKzRGa2xzUzJJQmQ1TW01RW9nRUkrZjRR?=
 =?gb2312?B?aWswWmg4RGpGeXRncTBlb3hIU1JsYmZNYmQzYlkrK0xhOFVxNDV3dnpTcmQx?=
 =?gb2312?B?L0U5MHI0bzVITkJUVW1EK3AvVUdwNXhKdHAxM2pkOW9NcFdwZWE3M3p1cXNP?=
 =?gb2312?B?b2g2cFQ4L0FSMFdJc0VkV2hMbktic1o4Rk10YTYwTXFtclZiTWVZd1N1Yncw?=
 =?gb2312?B?L2FqZFJiRVR3WWNueWRQV1V5cjJiYVlObXhSYk5zWTN5MEpqTTg2NVhlN05B?=
 =?gb2312?B?bkZRSTdackk0R09wWVpsNjhtcFVsMXB5Tld0YkszY1JwSUxMZmtPYS9NaDJn?=
 =?gb2312?B?c04zTlVFMyszWEpYRnZCV3h6Y2ppUEpvZmFMT016WXJmZzEvMS9hL3J5Mll2?=
 =?gb2312?Q?p5iP0J+BdmjGP7BojM=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9d27bf-23a9-496a-fb60-08d8d79ad7aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 01:32:11.5587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhXqoG8vxtYGXoMAOKNGw1hSLHx0vnnJAAGNqcI6ov+LV0e8U2600Stbb5UGnVFpTfICVAkGHXTqtliqfEsTHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6039
Message-ID-Hash: PG6X5KZ6A4OFLTHGL3PLYFJTY2XONCLM
X-Message-ID-Hash: PG6X5KZ6A4OFLTHGL3PLYFJTY2XONCLM
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KN3DIWQAAE6JEF7VTEFWVT2COVZ35MGZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> hi,
> 
> > Add address output in dax_iomap_pfn() in order to perform a memcpy() in
> > CoW case.  Since this function both output address and pfn, rename it to
> > dax_iomap_direct_access().
> >
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> > ---
> >   fs/dax.c | 20 +++++++++++++++-----
> >   1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 5b47834f2e1b..b012b2db7ba2 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -998,8 +998,8 @@ static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
> >        return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
> >   }
> >  
> > -static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
> > -                      pfn_t *pfnp)
> > +static int dax_iomap_direct_access(struct iomap *iomap, loff_t pos, size_t size,
> > +             void **kaddr, pfn_t *pfnp)
> >   {
> >        const sector_t sector = dax_iomap_sector(iomap, pos);
> >        pgoff_t pgoff;
> > @@ -1011,11 +1011,13 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
> >                return rc;
> >        id = dax_read_lock();
> >        length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
> > -                                NULL, pfnp);
> > +                                kaddr, pfnp);
> >        if (length < 0) {
> >                rc = length;
> >                goto out;
> >        }
> > +     if (!pfnp)
> Should this be "if (!*pfnp)"?

pfnp may be NULL if we only need a kaddr output.
  `dax_iomap_direct_access(iomap, pos, size, &kaddr, NULL);`

So, it's a NULL pointer check here.


--
Thanks,
Ruan Shiyang.

> 
> Regards,
> Xiaoguang Wang
> > +             goto out_check_addr;
> >        rc = -EINVAL;
> >        if (PFN_PHYS(length) < size)
> >                goto out;
> > @@ -1025,6 +1027,12 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
> >        if (length > 1 && !pfn_t_devmap(*pfnp))
> >                goto out;
> >        rc = 0;
> > +
> > +out_check_addr:
> > +     if (!kaddr)
> > +             goto out;
> > +     if (!*kaddr)
> > +             rc = -EFAULT;
> >   out:
> >        dax_read_unlock(id);
> >        return rc;
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
