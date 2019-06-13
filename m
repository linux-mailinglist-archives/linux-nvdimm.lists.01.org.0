Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 616C144C3E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 21:37:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C46F8212966FD;
	Thu, 13 Jun 2019 12:37:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.5.41; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50041.outbound.protection.outlook.com [40.107.5.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DEBBE212966E3
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqVMVbmuBMLCfrrJsLkvyOSYFtdu1jpJ2fCQlvBuFnA=;
 b=Qt3C9kNsuyNWRihe9lrn0qa7iUaXO6uzsV2nd+cx8JBB3gZ8ywF0zBRH3FE4lXFypy0IjTL9mpTH1w68WFIFh+xz9C38mH757ZYFqq2/8D+NmDYALJr1cUVuFcAuMw385iVa4sGMFGLCpmliyoBT1GqpGsQQLsApOFG576vtKZc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4703.eurprd05.prod.outlook.com (20.176.4.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 19:37:28 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 19:37:28 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/22] memremap: remove the data field in struct
 dev_pagemap
Thread-Topic: [PATCH 11/22] memremap: remove the data field in struct
 dev_pagemap
Thread-Index: AQHVIcyJQUnvCVRSIE2bb/Jw4XNupaaZ+z0A
Date: Thu, 13 Jun 2019 19:37:27 +0000
Message-ID: <20190613193722.GV22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-12-hch@lst.de>
In-Reply-To: <20190613094326.24093-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0026.prod.exchangelabs.com
 (2603:10b6:207:18::39) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 907cdff8-e256-466c-f3e4-08d6f036912d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB4703; 
x-ms-traffictypediagnostic: VI1PR05MB4703:
x-microsoft-antispam-prvs: <VI1PR05MB4703809C46130FB7F4861F17CFEF0@VI1PR05MB4703.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:281;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(7736002)(81156014)(305945005)(8936002)(81166006)(478600001)(73956011)(6486002)(14454004)(86362001)(4744005)(4326008)(36756003)(6512007)(8676002)(33656002)(186003)(7416002)(5660300002)(1076003)(229853002)(99286004)(52116002)(386003)(76176011)(316002)(256004)(25786009)(2616005)(71190400001)(11346002)(476003)(26005)(446003)(68736007)(71200400001)(6436002)(66446008)(54906003)(66476007)(64756008)(486006)(66556008)(3846002)(53936002)(6116002)(66946007)(66066001)(6246003)(102836004)(6916009)(2906002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB4703;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z4vP3UlC5xby6GoAzbIvFJnRyDvBvzto7/5u8I8QrQHRW7bdV+01Dd935kVu3GmRGelDhVwrMBg70UAGFS/gR5pOQFYjBuVg9zORQBnONNsY5Ed64myCE/K4zNNawxbPXaoR83hcA/qd5GfI/ddoc2pF66qJuOjG51b4kBZFlZxgM5Odjo6ThEfmyeJ3+cmXbeinYqi9sdVyHzfCSx2aESLdIhexmxRamCfh7QcCxb+5B99JEQ3uCfpuTFKJrX198C1qPTGkNdE41GmkK64PzqyRkbEDkQWbkEgIOdsT+EjY2wBdKBmM5u0MpztvNnpX0Ge2f1QdgEihksR3fcM2GkiTWOXSACyconHTTioeGVBx2vbReMo+Tarxm8YqRkbspisO33CqZRHJ9DW2ZYDScE4OFCrtlfnbbqtKm7AAg9M=
Content-ID: <9EE56540715B244EBE0C89B76768CFAF@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907cdff8-e256-466c-f3e4-08d6f036912d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 19:37:27.9159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4703
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

On Thu, Jun 13, 2019 at 11:43:14AM +0200, Christoph Hellwig wrote:
> struct dev_pagemap is always embedded into a containing structure, so
> there is no need to an additional private data field.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvdimm/pmem.c    | 2 +-
>  include/linux/memremap.h | 3 +--
>  kernel/memremap.c        | 2 +-
>  mm/hmm.c                 | 9 +++++----
>  4 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
