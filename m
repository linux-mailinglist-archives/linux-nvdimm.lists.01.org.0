Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4097D44C1B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 21:26:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CAB31212966F8;
	Thu, 13 Jun 2019 12:26:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.1.69; helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10069.outbound.protection.outlook.com [40.107.1.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6A24221295CA5
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 12:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvcAsIkjFLYSdUniTF8G+sYHGSU4mYolhzc6717/V8I=;
 b=HQ6f8qD3M80i6/HWhY9aAYXl2Zuf5Hxud/tSbgQeMPzAhqLte+GlCLBqketRtxRq5Um5H3ru99Joy0pT/kkAwJFTTC2ebmEeU5e5uMysOHDNyNoBXZSVkynlsUhzU+wDJf4mwRpkcrFAMKYOJBOCQdEhGEWapvrkVzJsfQKdaDY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6431.eurprd05.prod.outlook.com (20.179.27.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Thu, 13 Jun 2019 19:26:20 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 19:26:20 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/22] memremap: pass a struct dev_pagemap to ->kill
Thread-Topic: [PATCH 08/22] memremap: pass a struct dev_pagemap to ->kill
Thread-Index: AQHVIcyEEZgvAYVgakq3PD/MH8+2iKaZ+CKA
Date: Thu, 13 Jun 2019 19:26:20 +0000
Message-ID: <20190613192615.GT22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-9-hch@lst.de>
In-Reply-To: <20190613094326.24093-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::29) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 993f786f-02ab-43f7-4dfa-08d6f0350384
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB6431; 
x-ms-traffictypediagnostic: VI1PR05MB6431:
x-microsoft-antispam-prvs: <VI1PR05MB6431317ADECB4131223AC21ACFEF0@VI1PR05MB6431.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(189003)(71190400001)(186003)(36756003)(11346002)(446003)(71200400001)(14454004)(305945005)(66066001)(6506007)(478600001)(76176011)(53936002)(52116002)(316002)(386003)(81166006)(54906003)(476003)(99286004)(2616005)(102836004)(8936002)(486006)(3846002)(86362001)(6116002)(1076003)(8676002)(4326008)(81156014)(66556008)(7736002)(7416002)(66476007)(6916009)(25786009)(2906002)(66946007)(73956011)(66446008)(5660300002)(229853002)(6486002)(26005)(6246003)(64756008)(33656002)(256004)(68736007)(6512007)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB6431;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xj4tjUkJSgoEYdWtNIdYqjdPPITUyLgZz9xkAp/QkS61G+3Qf+HJ/Jkb8hN5iNZDWnMXTupMfMPR4xLNGIqxjsZyKdvb9PaAd8lC9boN2H6VLJVikbaPfzHZE7ChOpRSXlkl/TfKfdeWSefSIQi2BWYWpwPbM9pX+m6KdVKozPtEgm5JdtFoEBhEz4SEkH35vlX6U0wOtlkhjvbPZTQHwwOOI6f9FzSCFapImSn7CY3o5DUpcOZNpjqpSVVZg/D50/UtF2W83/nPM5ysLrbkEw6W+FYmqCXCTcPOflzM2QHEzakE0cQkHoVl1bQhJGfCVsHxvjppsHJb5nV14f8gNjVdy+pAjTgr2rGERzznu2IDeULyx0a9TlgIIDb7OJ/mZxCRJicaf5H55lWSyxZ8YtFkW6pOotTj2qhrffICwbw=
Content-ID: <6555DEAFF3F4AF4A941D63DB429D69BC@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993f786f-02ab-43f7-4dfa-08d6f0350384
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 19:26:20.5397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6431
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 13, 2019 at 11:43:11AM +0200, Christoph Hellwig wrote:
> Passing the actual typed structure leads to more understandable code
> vs the actual references.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  drivers/dax/device.c              | 7 +++----
>  drivers/nvdimm/pmem.c             | 6 +++---
>  drivers/pci/p2pdma.c              | 6 +++---
>  include/linux/memremap.h          | 2 +-
>  kernel/memremap.c                 | 4 ++--
>  mm/hmm.c                          | 4 ++--
>  tools/testing/nvdimm/test/iomap.c | 6 ++----
>  7 files changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index 4adab774dade..e23fa1bd8c97 100644
> +++ b/drivers/dax/device.c
> @@ -37,13 +37,12 @@ static void dev_dax_percpu_exit(void *data)
>  	percpu_ref_exit(ref);
>  }
>  
> -static void dev_dax_percpu_kill(struct percpu_ref *data)
> +static void dev_dax_percpu_kill(struct dev_pagemap *pgmap)
>  {

Looks like it was always like this, but I also can't see a reason to
use the percpu as a handle for a dev_pagemap callback.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
