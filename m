Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C5330C78
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Mar 2021 12:34:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3B108100EC1F5;
	Mon,  8 Mar 2021 03:34:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.159.87; helo=esa7.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 84ADB100EF250
	for <linux-nvdimm@lists.01.org>; Mon,  8 Mar 2021 03:34:25 -0800 (PST)
IronPort-SDR: sBtAvlq4x0Bw3Jq0ZkvcKdGZbpT7DAVeRHgEWqKnhh0TR9UjZTvL2h0No0H74xqx3ucAAT/7yk
 fo6TN3naQDmGdlGChxEJzp6IPWWRMFm7vNZ18GnW4NSIRRsevGHa6JT92QDCf8JH9XqYVBCnGM
 y6KkABELqZV3TG7wZVdxzoOmbWLsPFDjltu6D4sL0bQWkftCILI9y3sjDsBrdl16LP2FfSA+Ks
 CKOARliCBcxUcn19CSe+8Suj+IvkiPql+dgRgTAoiwTvYn/5Sm2fwsQbOTRHfEjPA/NPOJzs42
 Urs=
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="27391094"
X-IronPort-AV: E=Sophos;i="5.81,232,1610377200";
   d="scan'208";a="27391094"
Received: from mail-os2jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 20:34:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzpAy9oXxURtcobhOqbyWv8P1ZXPYQMU5RkIdq23lQ3za+zuMWWSYb7wu7aLL+uWGt5lV499n0y8EsY5CYNyAoXe7TivNMuzboaCi/9t36xUHpHP2mKf9uACC/tCtDdlCRJNas3BeBDp/y3kpeb9YRfw5/kbuXoxjPYmCQsoKD1zYJugHzZp8BHCVuSsTc40qCh+kS54QvZDt3bHovLH4FvvN/mw+RdGn1d++/KpTwC19aOVTUDrHBq53N7908VyC3nLgr0De+h8/lIRsXXkQrQYkGudzvwFkH3ZgbKK06QvVc6r+eAa9vP5XFvV2MDOC6fqjF1+nBuuT8xDJjiCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7yH3Ef5p3eCXwKhdWr3MstcfOaVdOEKpIAQ0ALp5Ss=;
 b=lb0chRdPEiFmR03TEiVOE1yN1F/k9LEqqAIDtCwTs8uKYcUI6YwlcIpjylJu8RyZVE8GOw9eHRfN+7z2zQek7fhhWWbnWFMFtjo/BUoAW16NuEVomF+co29lYXurrMp2oDvI7N3MInGAc3qoyKFYN0xppe3kHgGDJN9oB0np1FFdKAYtAvSZ8gy3Kn7yrLy1Gk6uvLUSf9HBZfpTwxvZ5TVN2ENQSVSr7oJtx35frXG/vKXWRotpWy2GGMhrVK6LsNlWN8CaU8zs6ybRXoooBMJObVFmPjl0WSbefTtqo/r1Lrrn7tPGZNWctAYEK5xhvaz14/BX2iXJx7WqG65qlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7yH3Ef5p3eCXwKhdWr3MstcfOaVdOEKpIAQ0ALp5Ss=;
 b=Czbqi+PyG0lOv17fA2FBE7tDVy97Guhpv/dSuX0xbADf6FUHttPzkRZVNTWB7ZH2xT2Y5GUqqGwO2mt7WJv1SN4vDyoz7xqax8my73XPnnLNz0QoKz9tki4cJUN/V4kmjzzR6BRaOb4ynHIRGaRPMl4/J2ngmPVoR7AwK3LKLeE=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSYPR01MB5413.jpnprd01.prod.outlook.com (2603:1096:604:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Mon, 8 Mar
 2021 11:34:16 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063%3]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 11:34:16 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Topic: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Index: AQHW/gjzAa5hnh6PaUq187fVBTbxkqp3lL+AgAIDAHSAACKcgIAARgh1
Date: Mon, 8 Mar 2021 11:34:16 +0000
Message-ID: 
 <OSBPR01MB29203F891F9584CC53616FB8F4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com>
 <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
 <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>,<CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com>
In-Reply-To: 
 <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [49.74.142.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3393f5fb-3e41-4fab-a05a-08d8e2261af8
x-ms-traffictypediagnostic: OSYPR01MB5413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSYPR01MB5413B2F1021BEA9CB1105D49F4939@OSYPR01MB5413.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qsYrcBXi0KulC1SmKo90aNEZp8MLk7sk/ilhirmcf67RTHrrFkXYrkAUFiZwhGaeGhvGi08Tw3kGQ4m4yt3gmajQWUvWvYlJTQbYSbXSwdqMiVuJGcGN//Mfd1aYcHPjidRib6LXc8L/S2dNvJPSjrbniA2S3Z+AUu5npSJnHFh9OmBt5MF4PmT5hgc8vzyIO5VogxxCS5JAZlvq1cyZtoA2C+mcrV3U3bQlGVfRy3QmL0AYlb15Gg1Jwv4zuegBGh6UpDmmtvDt3Kq5rMhhE+y2JH6RTePQga5tFpBRpq/wd9hZkIGH5hkZGVnSXGo07KDOl69KLWKq1y46tt6FSXOxo8Dhq6Zt6d1h+9HNzOkVeHkTW9Qs5QqN8csAJZP6YOqRT3WHS5BzjNVAtd5cV3ib9HTw2wpye6D0z6RAXIxYsCj3SxhdEKjjq2fsNtFhToW+tn265Da7QBf7Tj1kQbGBZaS9VAvvDyo5yg9kP76d3L06JLgML6v6L47oOdXFlU63z9LvPL3vfPN7VMfVtA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(91956017)(5660300002)(85182001)(76116006)(86362001)(4326008)(83380400001)(2906002)(186003)(33656002)(107886003)(7416002)(6506007)(8936002)(9686003)(71200400001)(55016002)(26005)(8676002)(7696005)(52536014)(54906003)(66556008)(478600001)(64756008)(66476007)(66446008)(66946007)(316002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?gb2312?B?dEVqakxySFdndFlOK3FlbzQ2KzY0eUFPZUZMYjArV1kwUk1EN0pHbnoxc1Yz?=
 =?gb2312?B?Z25ZY0VJaHNlbkV0bE1TcE52OWlXV2ZkSzNqcjlJV1VzUG5RTXhxaUlGVGVY?=
 =?gb2312?B?cjN0WllFTWVKWTd3QlcvOGpvRGVCenVORTBwN0l5d1hDaVNZekpxbHJZQTd6?=
 =?gb2312?B?d1JOZnIzdHE5a0ZkZWwyTnhackxzaGpGSVJvSWFUMjhjSE85TWxSR2xOWTYr?=
 =?gb2312?B?VFFsay9PTHFZcG9nOFp1ZVVkZzdZU2lPUit6allTUjEwVFBvTmdKaFo0SzU0?=
 =?gb2312?B?SlYxa0ZVdnllRnJ2Wkh2NVRVcUs1TzdrSTh4R3M0SzFwTWIvc3R3Mk12dDM3?=
 =?gb2312?B?TzdiNFhxbWNYcGh1MHBWS09UZXpTcHZIbjQwZUcvMHZFd1RhMGxRUmViSFpS?=
 =?gb2312?B?M2VvNlZPSnI5UXNEaEd1ZFdUSEZQZEhIY0VYMnlhbGV6ZkpZdE5GejJRbXhZ?=
 =?gb2312?B?dDhNaUR0eXRWTEIrRnBtVnhnYTNVY1NuZ0NGdFVJekp5WVd4dC9GL0kzRC9Y?=
 =?gb2312?B?N2RPRy81K0cvdGF3Qy9lSDNUdUR0eCtFaXVhd1V1YStja2w2YXFuSDhlTnBu?=
 =?gb2312?B?WnJDZnhkTUwrWk5MaVZxRUNUc29zbU43cDNRSk03NWQ5NmpHSTRCb3JTMmd5?=
 =?gb2312?B?eUtSdm94Qm1MaTNSQXhBVVR3QnpNVnkxSGhRVG1pVGxMSnNmQlgvVHhQbGJQ?=
 =?gb2312?B?M1I1N1ZVR244YkdPR0l1dHA2UHphMkNXaW93U1UrcTc3WEF3b2ZMTm5IVFF1?=
 =?gb2312?B?S3JGU21CQ2xqVHhYZitVdDMyYXlxV1VRWXVwYmNPRUNCQ2VVU3pOdXl6V0da?=
 =?gb2312?B?Z1oxQUpKT1lIejBGNUxyR1ZtaEwyd0xoaWZMLzZPZ1VKM0NSemFJYUZjelQy?=
 =?gb2312?B?TDlBeTVWRzNkcWtNTXhYNG9ycWxWdFRwUzVQbStyamFZMVZHUURCYTVtbGhY?=
 =?gb2312?B?MUlySUpWem16NERCbjdvclNWdVBybTAzVjh5dzYyMEVxTUozN0EwZXdBdzBj?=
 =?gb2312?B?dTlLYWowL2t5TlVQYXExRkd0ZUFVZVFlMzgxczVPbUFtL2E0aGM4Ykl6cTZu?=
 =?gb2312?B?TmJwOHZKRzduMGRNQjdYR0tTaW5Fdm90NU5RR1hYQVFTQ21yY2FOVzhXL0po?=
 =?gb2312?B?QXVtT1QxZzZvQ1VTU0JRN1A1cUdwQ1hGQ3htbW9Za3pPYXpNTGVycFE2VThB?=
 =?gb2312?B?NUgxdnhyMUZ4MVJ2TFVKdGFwSzlVZ2hMWTB4dHRWMFdSOTJZYjZ3OUN4SEF6?=
 =?gb2312?B?ZmJnN3JmU21aVmRjTjRqd3BocGN5L0FTYzF1akdObi9SbnB6cEhMaGdETm9W?=
 =?gb2312?B?MjBjR3prazA1WFRoZTNBSm1HS3lWMjI4azhNcFhYa0hrOUNYaHhCa095amw2?=
 =?gb2312?B?dmtLMzh5bmNZSG9VdG1DTFZPVXkvUzBBN2lOV3A5d2NuL29Qa2t3NWNHSTBh?=
 =?gb2312?B?NVFobnJCU3ZoajZ1T0VpVlE5Y2dRSy9hRkwrZmJaV2NYVWtLL2RUYkh1NjRY?=
 =?gb2312?B?RWFudWUra1FMVEhuVzd5eEVTNzd6R1F1RHcrVWUxYVFwc0lFUXlCMU5heWJH?=
 =?gb2312?B?UnQ1bi8wNFVkWXpWVWdXc29zMVVGbnFhVUpGQ1hXTmtGODJEYmEzS0x5d0oz?=
 =?gb2312?B?NUVlSGNOSjJyTEszR1hhc0Z6dmEwSmpTZ1M3TjJKSXVYSFhJRVpKRUxKc3dP?=
 =?gb2312?B?L3AwL3F3RTIrbkl0cTVSeS96ZU52am1rbk1vOC9rakpTbDRHUE90RzJpalps?=
 =?gb2312?Q?QHDdUxnV9N2YlN3mIA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3393f5fb-3e41-4fab-a05a-08d8e2261af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 11:34:16.0742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZmgYXijU2OzGS67bH7T8nFINHi5rZeMUr/enpXJ43ReabbnKKq4IIuZ8SzgFhDJGp4K2klH1NeurZsoM7Dipg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5413
Message-ID-Hash: RX2N3WZOOGWUSKK4T6RE7MZ2E7T26RZB
X-Message-ID-Hash: RX2N3WZOOGWUSKK4T6RE7MZ2E7T26RZB
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, device-mapper development <dm-devel@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Goldwyn Rodrigues <rgoldwyn@suse.de>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "y-goto@fujitsu.com" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D22SZYUSZSFG2YOVIKNABGCX3GV4HWDZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > > > index 79c49e7f5c30..0bcf2b1e20bd 100644
> > > > --- a/include/linux/memremap.h
> > > > +++ b/include/linux/memremap.h
> > > > @@ -87,6 +87,14 @@ struct dev_pagemap_ops {
> > > >          * the page back to a CPU accessible page.
> > > >          */
> > > >         vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> > > > +
> > > > +       /*
> > > > +        * Handle the memory failure happens on one page.  Notify the processes
> > > > +        * who are using this page, and try to recover the data on this page
> > > > +        * if necessary.
> > > > +        */
> > > > +       int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
> > > > +                             int flags);
> > > >  };
> > >
> > > After the conversation with Dave I don't see the point of this. If
> > > there is a memory_failure() on a page, why not just call
> > > memory_failure()? That already knows how to find the inode and the
> > > filesystem can be notified from there.
> >
> > We want memory_failure() supports reflinked files.  In this case, we are not
> > able to track multiple files from a page(this broken page) because
> > page->mapping,page->index can only track one file.  Thus, I introduce this
> > ->memory_failure() implemented in pmem driver, to call ->corrupted_range()
> > upper level to upper level, and finally find out files who are
> > using(mmapping) this page.
> >
> 
> I know the motivation, but this implementation seems backwards. It's
> already the case that memory_failure() looks up the address_space
> associated with a mapping. From there I would expect a new 'struct
> address_space_operations' op to let the fs handle the case when there
> are multiple address_spaces associated with a given file.
> 

Let me think about it.  In this way, we
    1. associate file mapping with dax page in dax page fault;
    2. iterate files reflinked to notify `kill processes signal` by the
          new address_space_operation;
    3. re-associate to another reflinked file mapping when unmmaping
        (rmap qeury in filesystem to get the another file).

It did not handle those dax pages are not in use, because their ->mapping are
not associated to any file.  I didn't think it through until reading your
conversation.  Here is my understanding: this case should be handled by
badblock mechanism in pmem driver.  This badblock mechanism will call
->corrupted_range() to tell filesystem to repaire the data if possible.

So, we split it into two parts.  And dax device and block device won't be mixed
up again.   Is my understanding right?

But the solution above is to solve the hwpoison on one or couple pages, which
happens rarely(I think).  Do the 'pmem remove' operation cause hwpoison too?
Call memory_failure() so many times?  I havn't understood this yet.


--
Thanks,
Ruan Shiyang.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
