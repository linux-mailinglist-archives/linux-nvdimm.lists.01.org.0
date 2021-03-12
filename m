Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D963389DE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Mar 2021 11:19:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 94192100ED48C;
	Fri, 12 Mar 2021 02:19:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.151.212; helo=esa3.fujitsucc.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C52C0100EF264
	for <linux-nvdimm@lists.01.org>; Fri, 12 Mar 2021 02:19:14 -0800 (PST)
IronPort-SDR: BE2kqCUOs+YbkO4/TfSI2mmOojSUF5CJrJYiQamO0sI0APOg/iE5xsvJAtjI/uvkMY0tMi3MiG
 kSU7Po0gumyjlMFHYbzEGws4HXXVihAUkRWQRGI6sQgI6ri4p8ptYlOxxFB54exDQ1f8DwIDWZ
 7Zu+59skBnN8Sh4WsL5Ki2AImhrN6yyAbMyqBkILa0DSgHCE7Zso5ZXUH9YWgMqvcfXhdVdHEX
 Ln2qXqYj/VDzmW6Q2MEwgPZa+MKbO0MAZtK+4Gd+3cn0CWFH5o7VqG8ExPvt05CdgYtKmX+OFH
 ovE=
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="35826815"
X-IronPort-AV: E=Sophos;i="5.81,243,1610377200";
   d="scan'208";a="35826815"
Received: from mail-ty1jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 19:19:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOVl0PBlvOINu+7h2pT++bhSeoxC8nJMmGVLA42gSJfVd4We/sXSv2fzXGoAv9FPguhzryAPHbN9YYcC3Z6XrXBy6o34XlZguMGEucCgbmzxkyCsudkvCZ1eH+9gONqHe91SSF1pr0drqNdAh8q176/LDJKUZJTzyE8apTUPkq5D3DhkiaFS6ji3F2BNiVMgLwmcMN5Onc5fXkjSbeNdzHB4CZrYRfD/S0UYfBz9Ef2uK/NoV6e6n0uVURJxhLkNZUPBK95Ms7PWHf46RT915QFk/1lUm9w9CtkohpuGlLy+1er1gZg6GNfWbKBfUnSlzaLCmObjkrSDO/6srFm5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A+q/LIVtl8nw4QRQMucXxYfNJLCAqe3llPGRr2TjfE=;
 b=OodlpXl9f3281NwYpJ3Q8SHdNuePhycQXOG2N30zDFbwmddPtWg88zOKIrU7y5fFYLbnsznPgWz0vt83INGXC2AoMLwtAw8HkU4jyWYb3pYkxKYJ8ed1UmQEHusZFKi81rHGO2/9FKYMIlUBx/qyRWSVlX9XrIBG3VF6oKA0+7UjODd1YfscjABVAP2y6moeEeS0iF9FTfd79TrUm1zJEt6AfqxOcLM9z4l9jRRLnoQXFTf0zMpbZe9B1+WpXaptv9HBJnUD+qHRIwsQI5qvD7oneB84tWjSKt9R+PUmeemJQbBLpW4AFWjRdASHOjYiQE+Bz5vXlKgCvf1F9w4MjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A+q/LIVtl8nw4QRQMucXxYfNJLCAqe3llPGRr2TjfE=;
 b=S+HSMrYcSBXyPkW63VZ0pXOkK5+KfW+NBWZZAsrw/HYpl4wVEy4R/PEEVWlHkHDsDNcQIP8uFhRjiGA0renGkZaVkLpuNOxRMIWaXbWV4aO7LvvuB02tNTjCE4PIGxZE4rXjVtmDHotdFhDWg8lKtuV4itvmzh8XF20TO88mJ00=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSBPR01MB3285.jpnprd01.prod.outlook.com (2603:1096:604:1f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Fri, 12 Mar
 2021 10:18:59 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063%3]) with mapi id 15.20.3912.027; Fri, 12 Mar 2021
 10:18:59 +0000
From: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Topic: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Index: 
 AQHW/gjzAa5hnh6PaUq187fVBTbxkqp3lL+AgAIDAHSAACKcgIAARgh1gACNxwCABb8rEA==
Date: Fri, 12 Mar 2021 10:18:58 +0000
Message-ID: 
 <OSBPR01MB2920E46CBE4816CDF711E004F46F9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com>
 <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
 <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com>
 <OSBPR01MB29203F891F9584CC53616FB8F4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4gn_AvT6BA7g4jLKRFODSpt7_ORowVd3KgyWxyaFG0k9g@mail.gmail.com>
In-Reply-To: 
 <CAPcyv4gn_AvT6BA7g4jLKRFODSpt7_ORowVd3KgyWxyaFG0k9g@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 035cdfb5-f722-4166-77e7-08d8e5404029
x-ms-traffictypediagnostic: OSBPR01MB3285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB3285FF7DDC5D33573D21ABDCF46F9@OSBPR01MB3285.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wezIMGHhX/LzoDNXoLe/G9/AIK8zzdReRQWz+f1UbDjtmXIPQdB48Tq1Kn9EggqNFy3stPHrinDyfBQNGS4QWTWNu5Uqm6OX8euhYU8+vMEaVXbq7g6dyAmZB6ZdkXdqo4bSiATvcrzb20aMmjWyAv5Sjt+gun4WoQ7RslzwcfrX93N1hdGqNxmNKueqfr2uFwyP7z/6GCVWQGAZPD1HlChD4WS6lq95BOizTKdqAQDtDAMA4ZHtHz14qDLv/oJv//1gMN4RpKmHJbVL0NDNQLM6EwAK3RNCUOUVMn3QefoaELd/klyZDZ8a/pR9ICghKfmtqpJsXW4Jr7bnJ+RvQxgocemoWcMkt4CTJTSt6FCxUHdNU/iJkDC8T80fTIu4vhM1mIDNr809R77nqTMmdNWY0qX+O0350WrfAjSZICN5H/wlOj4UXa6UteVgtsPGhdLu3hR7XHo2IUcLb5lCexdg9s6G9Bw3LwFaORLHMLVqrzx/Oqly1yK6hbG5aoluNvrKvOB5ogyviCeEF4JsLw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(33656002)(9686003)(76116006)(52536014)(7416002)(83380400001)(5660300002)(316002)(66556008)(8936002)(26005)(66946007)(6916009)(55016002)(7696005)(66446008)(186003)(6506007)(53546011)(478600001)(71200400001)(54906003)(2906002)(4326008)(86362001)(8676002)(107886003)(85182001)(64756008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?utf-8?B?eVNWV2hnQVNodmswNFdIb0doQlBMbzhqVUsrK3JlcWFWQjR5NmVCY2E4cGhq?=
 =?utf-8?B?Q3MyZ3dEUk16VEYzU21FMFFyV1pGVUlvSk9IOURESEwyb01oSFkyYzcyeUdr?=
 =?utf-8?B?czN3L0cveFhQNThUZk11M2VlYW1Wd0hHTzluTEQvUmY5ZDZyQ21DUTE0RG5V?=
 =?utf-8?B?ZUNLZFlYalBsZngxWGFKem5EcllyUXJjWGNFbFJhbzVYRFJPaDUxa0Znendp?=
 =?utf-8?B?WW81MGNBRGJjaWFHU0NCbjZUTFR4azZUVHJyQStRZGdudDFwWFlCZmRLUW40?=
 =?utf-8?B?Qk1zelkxRkRxamE0Q1hwWmZVa3k4bUhSVUZFYjVLcGVJdmYxZUJHbFg4U3Vt?=
 =?utf-8?B?VXFuYXNZUFg2bElxVFJjVXdXL3pJOVN1NVkramJpZ0xOcHZuQnIvMnN4Q25P?=
 =?utf-8?B?dnY2TXorK3c3Z0xQdmo4MTZjUlVsS1Zla1Rjd1Nrdm8rbmEzb0UzZGxsOFA2?=
 =?utf-8?B?Z1RNNVFSY0NwRkttZmV0cXJvWmNxSmVNbU5LM2NrY2N5eG1qUlRSa2FBWUda?=
 =?utf-8?B?b2QxQktGcVM3NFFyNTVTTStDUTZVUzRZSzI5SUJrYTlrWnpuZjJjeTcxbGl3?=
 =?utf-8?B?NFFKSUgvUi9oYjYxQ0FOK0VyZ3Vmb1VkbCtNQXFhUzZvNitLUm1welg0Njk3?=
 =?utf-8?B?em5MeUErVlNFOVNoRnBkekdCcHZIc1BWa2pmeHFHMm1OZHVFV0QwNUJaNlMz?=
 =?utf-8?B?Z2dqNDdGV2dBUWdYM2lHMjZNT0F6Y0xlbVBEODdycUthNDRBVklZbVV0UG50?=
 =?utf-8?B?bFRTYlY5QmVIMmRpZXg0dCtNODk3aklaUjMzbnYwQ1dZVWt5TDZTRDF0R0xs?=
 =?utf-8?B?c3dZcDBnYmJ1YjVPcFlrQ0xJdXgzVGtVR0UraXFyREpxSUora3VHanZoWTMr?=
 =?utf-8?B?VVFYS204UVB4b3QzUElDdjdWeGlja3hOckZ3TG50SURRdXhOc1pKc2JiWGE5?=
 =?utf-8?B?MXNKYXV6Vm13RDNpSzduRUROeFhOME5YbDlzRVpxSk41WElxc000RFIrSXRU?=
 =?utf-8?B?R3FuTEhZcHNqYnRxZDAxaENUTFVteUUwUWhyYW9SVUtxN1drS2ZMa0ZwZGZZ?=
 =?utf-8?B?WHpzdnJzRmRXY09uQk1kb0FTS2VLb3k1MS9sVTl3T0wwWFlmSXFuc3V0eURl?=
 =?utf-8?B?aDMydE15V2dOVlNCemlsdmJlTStKaXhuR05YTmZGT1hTT1JMb3g5OEFIdS9M?=
 =?utf-8?B?NTdtS2h5WW00VHNRaXBFZ0huQVhWNU8zL3RHWjFIdkk0bXRFZjE1b01FeDdt?=
 =?utf-8?B?T0V0ZWNlK3hZMUoycHRUSWZuTEtQenJFVkxmanhIM3VIeWdIVVYvZHVpcDNx?=
 =?utf-8?B?eWd6ZGFnMnE0NFpZNE5PdVZBdnFUME83ZER6S0EwZklCZWdrczRRSHAyTnRx?=
 =?utf-8?B?dGo5VmZRdkhWblBjQlk1Q0RPVXFsVENLSU1sN3JFWmVBOXd5NHBQYTFIUjZQ?=
 =?utf-8?B?RlJyU2R1MFRQV3NQbms0WEJDV0VRRlRiZUZ2UU9zN3daWUNPT0xXSERtcUc0?=
 =?utf-8?B?c1R5WGZlcUxGZlJQdlhFUjR1YmFqOVZ4NExkVzA4OE11dmZNbUxQZ0s3L0RZ?=
 =?utf-8?B?NEkrNG1DdjhablJER2tuWXBndCtQbktLVUdiUmV5dmErZDlseFlDV3Q2ZVp2?=
 =?utf-8?B?TDJXV25rV2NZRzNrSDNIdlk0NFF3Q1lXbFVXMWludURMbnBoTmpSWHJRS0FF?=
 =?utf-8?B?dWdZSFZMbDJyeDJzKzdjelJQR3JyRVNwU1FwOXZRMXV2ZGowd0I2c1NGRTVj?=
 =?utf-8?Q?qSqJb39YAxFfNo1ceMNqst3pS+aZlYkoQRzCdIN?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035cdfb5-f722-4166-77e7-08d8e5404029
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 10:18:58.9642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eZsFLftvM3Vo++GjOZfyLJ6WHkqfsDwkjPVaPdnZ6qaMSW+ucjusr7wZlwsTmWe9BYyYqfWSBUeuguVUgwwlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3285
Message-ID-Hash: IBAHSAJOYQ6WEWNQXL2AAB6MO4A4CLM2
X-Message-ID-Hash: IBAHSAJOYQ6WEWNQXL2AAB6MO4A4CLM2
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, device-mapper development <dm-devel@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Goldwyn Rodrigues <rgoldwyn@suse.de>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "y-goto@fujitsu.com" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AXZEF7UDSPBDU242H3K4X2JE24V5JHE7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Dan Williams <dan.j.williams@intel.com>
> Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
> 
> On Mon, Mar 8, 2021 at 3:34 AM ruansy.fnst@fujitsu.com
> <ruansy.fnst@fujitsu.com> wrote:
> > > > > >  1 file changed, 8 insertions(+)
> > > > > >
> > > > > > diff --git a/include/linux/memremap.h
> > > > > > b/include/linux/memremap.h index 79c49e7f5c30..0bcf2b1e20bd
> > > > > > 100644
> > > > > > --- a/include/linux/memremap.h
> > > > > > +++ b/include/linux/memremap.h
> > > > > > @@ -87,6 +87,14 @@ struct dev_pagemap_ops {
> > > > > >          * the page back to a CPU accessible page.
> > > > > >          */
> > > > > >         vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> > > > > > +
> > > > > > +       /*
> > > > > > +        * Handle the memory failure happens on one page.  Notify
> the processes
> > > > > > +        * who are using this page, and try to recover the data on
> this page
> > > > > > +        * if necessary.
> > > > > > +        */
> > > > > > +       int (*memory_failure)(struct dev_pagemap *pgmap,
> unsigned long pfn,
> > > > > > +                             int flags);
> > > > > >  };
> > > > >
> > > > > After the conversation with Dave I don't see the point of this.
> > > > > If there is a memory_failure() on a page, why not just call
> > > > > memory_failure()? That already knows how to find the inode and
> > > > > the filesystem can be notified from there.
> > > >
> > > > We want memory_failure() supports reflinked files.  In this case,
> > > > we are not able to track multiple files from a page(this broken
> > > > page) because
> > > > page->mapping,page->index can only track one file.  Thus, I
> > > > page->introduce this
> > > > ->memory_failure() implemented in pmem driver, to call
> > > > ->->corrupted_range()
> > > > upper level to upper level, and finally find out files who are
> > > > using(mmapping) this page.
> > > >
> > >
> > > I know the motivation, but this implementation seems backwards. It's
> > > already the case that memory_failure() looks up the address_space
> > > associated with a mapping. From there I would expect a new 'struct
> > > address_space_operations' op to let the fs handle the case when
> > > there are multiple address_spaces associated with a given file.
> > >
> >
> > Let me think about it.  In this way, we
> >     1. associate file mapping with dax page in dax page fault;
> 
> I think this needs to be a new type of association that proxies the representation
> of the reflink across all involved address_spaces.
> 
> >     2. iterate files reflinked to notify `kill processes signal` by the
> >           new address_space_operation;
> >     3. re-associate to another reflinked file mapping when unmmaping
> >         (rmap qeury in filesystem to get the another file).
> 
> Perhaps the proxy object is reference counted per-ref-link. It seems error prone
> to keep changing the association of the pfn while the reflink is in-tact.
Hi, Dan

I think my early rfc patchset was implemented in this way:
 - Create a per-page 'dax-rmap tree' to store each reflinked file's (mapping, offset) when causing dax page fault.
 - Mount this tree on page->zone_device_data which is not used in fsdax, so that we can iterate reflinked file mappings in memory_failure() easily.
In my understanding, the dax-rmap tree is the proxy object you mentioned.  If so, I have to say, this method was rejected. Because this will cause huge overhead in some case that every dax page have one dax-rmap tree.


--
Thanks,
Ruan Shiyang.
> 
> > It did not handle those dax pages are not in use, because their
> > ->mapping are not associated to any file.  I didn't think it through
> > until reading your conversation.  Here is my understanding: this case
> > should be handled by badblock mechanism in pmem driver.  This badblock
> > mechanism will call
> > ->corrupted_range() to tell filesystem to repaire the data if possible.
> 
> There are 2 types of notifications. There are badblocks discovered by the driver
> (see notify_pmem()) and there are memory_failures() signalled by the CPU
> machine-check handler, or the platform BIOS. In the case of badblocks that
> needs to be information considered by the fs block allocator to avoid /
> try-to-repair badblocks on allocate, and to allow listing damaged files that need
> repair. The memory_failure() notification needs immediate handling to tear
> down mappings to that pfn and signal processes that have consumed it with
> SIGBUS-action-required. Processes that have the poison mapped, but have not
> consumed it receive SIGBUS-action-optional.
> 
> > So, we split it into two parts.  And dax device and block device won't be
> mixed
> > up again.   Is my understanding right?
> 
> Right, it's only the filesystem that knows that the block_device and the
> dax_device alias data at the same logical offset. The requirements for sector
> error handling and page error handling are separate like
> block_device_operations and dax_operations.
> 
> > But the solution above is to solve the hwpoison on one or couple
> > pages, which happens rarely(I think).  Do the 'pmem remove' operation
> cause hwpoison too?
> > Call memory_failure() so many times?  I havn't understood this yet.
> 
> I'm working on a patch here to call memory_failure() on a wide range for the
> surprise remove of a dax_device while a filesystem might be mounted. It won't
> be efficient, but there is no other way to notify the kernel that it needs to
> immediately stop referencing a page.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
