Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CB244B1F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 20:52:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EFE8B212966F5;
	Thu, 13 Jun 2019 11:52:49 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.0.57; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00057.outbound.protection.outlook.com [40.107.0.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8967B21250CAE
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNfgWtpWZP+R3zWab6EmeYAQTAYgx2pVR+LpFXyrRss=;
 b=HuhOeDN4cvQnIPbnkY3/38FWBgnbccW+6aHtR17EeaLBgLlfggbM7Jmgd9HH/svLW/bPsC9MlhNeSNa3bXCOnAHSwbCOCWxV/UJ9cNCAooyjp2IS3RJ6Yyn/362HV2+z6SsrcvE5DkDoUj77xNdUXAVZHIbvMwr5hkc5ZHOX/JM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5919.eurprd05.prod.outlook.com (20.178.126.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 18:52:44 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 18:52:44 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/22] mm: remove hmm_devmem_add_resource
Thread-Topic: [PATCH 03/22] mm: remove hmm_devmem_add_resource
Thread-Index: AQHVIcx8KEghGfMSdEK+G1+HLD+T3KaZ7r+A
Date: Thu, 13 Jun 2019 18:52:44 +0000
Message-ID: <20190613185239.GP22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-4-hch@lst.de>
In-Reply-To: <20190613094326.24093-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:208:134::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88cc1feb-7b67-4d6e-c18f-08d6f03051c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB5919; 
x-ms-traffictypediagnostic: VI1PR05MB5919:
x-microsoft-antispam-prvs: <VI1PR05MB5919FFFF62953C9A7D5AF300CFEF0@VI1PR05MB5919.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(346002)(376002)(39860400002)(136003)(199004)(189003)(99286004)(229853002)(7416002)(2906002)(53936002)(6486002)(6436002)(86362001)(81166006)(8676002)(186003)(6916009)(26005)(81156014)(102836004)(6116002)(4326008)(3846002)(25786009)(305945005)(7736002)(76176011)(6246003)(68736007)(486006)(316002)(52116002)(476003)(386003)(6506007)(11346002)(2616005)(446003)(1076003)(14454004)(256004)(4744005)(71190400001)(66066001)(33656002)(64756008)(66476007)(66946007)(66556008)(71200400001)(54906003)(36756003)(8936002)(6512007)(73956011)(5660300002)(478600001)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB5919;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iPoetAJzPWZv8VU52oGqZLrf5f3NTUkWPIOsu2E3P9cUOeZ3NwtuyEYz7iS7GJhlnDVMvGysQH81INXAyHGi4fhjs5va1Vo7Rdk93MlIgXRDPGqXx6+KGKEioXBXh61QIBW+HjfcdF9Afc/Uz8IU4w2KDhGZZyhNl/YEDKF9BG8aoozap+p31SfnFwV4kfNk64o6JW56KSiT60BrYrmeCz1XjhbsuaBg6SlAuqng5W2PWwz6FDD5jzrI/s5ZqBSLG+9QaRGa5ztkbj0f21QAbgQ9bDRkhNtDPfY/D24ndwUJPvjpdNIvVA5Nbk22Z1FnYXFRZc91aJgcqQyXDuUFzCT23/IfQophXoBr4oq2jKokb9DjG1mV1f29A7FqlAqhk+lNsM6TLohpGpppFxMbAIkVr/LP6Ao3e2lHBGtj3ng=
Content-ID: <866711CC77D78F4DBA1F59965DF24E41@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cc1feb-7b67-4d6e-c18f-08d6f03051c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 18:52:44.2949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5919
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

On Thu, Jun 13, 2019 at 11:43:06AM +0200, Christoph Hellwig wrote:
> This function has never been used since it was first added to the kernel
> more than a year and a half ago, and if we ever grow a consumer of the
> MEMORY_DEVICE_PUBLIC infrastructure it can easily use devm_memremap_pages
> directly now that we've simplified the API for it.

nit: Have we simplified the interface for devm_memremap_pages() at
this point, or are you talking about later patches in this series.

I checked this and all the called functions are exported symbols, so
there is no blocker for a future driver to call devm_memremap_pages(),
maybe even with all this boiler plate, in future.

If we eventually get many users that need some simplified registration
then we should add a devm_memremap_pages_simplified() interface and
factor out that code when we can see the pattern.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
