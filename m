Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA0858702
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 18:26:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BBA79212AAFEA;
	Thu, 27 Jun 2019 09:26:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.1.48; helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10048.outbound.protection.outlook.com [40.107.1.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C388221296B07
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jq7Cu3ouaiLqX0IyGygS1qxPemZhEAEBbrhyRDwG1Is=;
 b=MHijS0oYLxu5vC+EWNq92BwDqgOvHOLP1gLfS8iXKfrGgNfN9WJTK0hB1ynANWCXGoyqlhu0/QlDM533DGiRJA+Rh+Ea6zZVzIf52jqvqrhNwaRr/zhF2HfgU1T3QeUrRV+nyqmmEfeQaLdmZjCRPEQiJmdvd19qZeQoanou9uE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6032.eurprd05.prod.outlook.com (20.178.127.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 16:26:31 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 16:26:31 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 20/25] mm: remove hmm_vma_alloc_locked_page
Thread-Topic: [PATCH 20/25] mm: remove hmm_vma_alloc_locked_page
Thread-Index: AQHVLBqmxPw5VkIwH0Gf/TUCNUoY46avseoA
Date: Thu, 27 Jun 2019 16:26:31 +0000
Message-ID: <20190627162624.GE9499@mellanox.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-21-hch@lst.de>
In-Reply-To: <20190626122724.13313-21-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0045.namprd08.prod.outlook.com
 (2603:10b6:a03:117::22) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.199.206.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01f337c1-21dc-4ca8-4b59-08d6fb1c364d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB6032; 
x-ms-traffictypediagnostic: VI1PR05MB6032:
x-microsoft-antispam-prvs: <VI1PR05MB6032F49F38A52C3FBF316643CFFD0@VI1PR05MB6032.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(376002)(39860400002)(346002)(136003)(396003)(366004)(189003)(199004)(6506007)(26005)(6916009)(64756008)(186003)(6486002)(36756003)(71200400001)(71190400001)(25786009)(86362001)(73956011)(66446008)(66556008)(33656002)(4326008)(4744005)(66946007)(8676002)(7416002)(14454004)(66476007)(1076003)(476003)(81156014)(478600001)(256004)(102836004)(6512007)(5660300002)(486006)(305945005)(7736002)(6116002)(229853002)(316002)(6246003)(54906003)(2906002)(66066001)(68736007)(8936002)(99286004)(3846002)(76176011)(11346002)(386003)(53936002)(6436002)(81166006)(52116002)(2616005)(446003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB6032;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /wKHS2Wcqi+iX24iwXUD8ArjOm9W3DfrSJrbk8SW/dAF176EK8nGoG4iNVHmTibsz8VHuwClL+aIp65i7lxuQFO0AyDfq1V2xvjK5FVX/MwyJYhX6TOLkhroZJnvUb7+7rShZFQgt6bdixcvylD0nFpEoLmiK0WQTscQ97Vo5fRqIQdB3kKUMLmzp2v2JaYLOZhH8r5TXLJjb7Uhg+msPNpdbraZXFXiZPJ2rRRj32tBOf0GDwdkC2O9ShEeGhfCSSeWRBx4KKxSthRvRvfsGDmJv0kCUnxe5qdCK8L8ZX2Y7wi8CdVGcYCjXQi60vtDNxoZSvNpX5+PtYKr0i2Nms3pwYQejTxXaODp1CJe4Zmd73q3oBdnP5VavdWarJU0x5j3pUWp0a1Hyvjq+0lAU7UmpENfOR3TZebAbITisM0=
Content-ID: <6EDBED9EAD9A054886AF3DDD66AD8103@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f337c1-21dc-4ca8-4b59-08d6fb1c364d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 16:26:31.1693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6032
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

On Wed, Jun 26, 2019 at 02:27:19PM +0200, Christoph Hellwig wrote:
> The only user of it has just been removed, and there wasn't really any need
> to wrap a basic memory allocator to start with.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/hmm.h |  3 ---
>  mm/hmm.c            | 14 --------------
>  2 files changed, 17 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
