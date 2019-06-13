Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C88144C4A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 21:39:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 06F3C212966FE;
	Thu, 13 Jun 2019 12:39:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.8.58; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80058.outbound.protection.outlook.com [40.107.8.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C4748212966E3
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kynqoWA1ZTWnY9VFOPXvMf/AcdQpgMQDiT/cVThh9kM=;
 b=ieCtWqkWrx4Ap+H1W7y2YcH2DPeDbFBIsA/cSDxRf5I6afMVyMS7Q0xUURicnSoBdNudME6QcTBsiy+81C3IbMWz1lTHh6gNKB+VRaz/0N9rsmAoTojsjpo3H2HaONgV9lNjMgmE63w9uTjfjbiJbhvFs+L4QsFWunybTSDmVSI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5006.eurprd05.prod.outlook.com (20.177.52.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 19:39:09 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 19:39:09 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 14/22] nouveau: use alloc_page_vma directly
Thread-Topic: [PATCH 14/22] nouveau: use alloc_page_vma directly
Thread-Index: AQHVIcyOHaopcwSxm0ibFlXFitCRUaaZ+7iA
Date: Thu, 13 Jun 2019 19:39:09 +0000
Message-ID: <20190613193905.GW22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-15-hch@lst.de>
In-Reply-To: <20190613094326.24093-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0138.namprd02.prod.outlook.com
 (2603:10b6:208:35::43) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8abe11b-1e47-4154-4922-08d6f036cd7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB5006; 
x-ms-traffictypediagnostic: VI1PR05MB5006:
x-microsoft-antispam-prvs: <VI1PR05MB500624416AC3B3A1B5C8E2F6CFEF0@VI1PR05MB5006.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(11346002)(33656002)(52116002)(486006)(99286004)(76176011)(7416002)(386003)(229853002)(2906002)(66066001)(102836004)(6506007)(54906003)(3846002)(6512007)(6916009)(6436002)(6486002)(186003)(26005)(476003)(446003)(2616005)(6116002)(36756003)(305945005)(64756008)(316002)(66446008)(8676002)(14444005)(66556008)(66476007)(25786009)(68736007)(73956011)(5660300002)(66946007)(4326008)(81166006)(86362001)(7736002)(81156014)(14454004)(4744005)(6246003)(8936002)(71200400001)(53936002)(478600001)(71190400001)(256004)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB5006;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YSP7XrTOSi8fUyoaKByWR58FatUSy2ppLe9VhcSpPwu/wfB8XDF8r0oHaqPYSG9NWIgAkTMgAZi+ezOPH5w7TGwVfD102STiXwTJ21mHpP1UydPE8LZuWkAixhMnczpX46wzVnsV52eiIZX6dwcE3hxweW7Br1G/mt9wQXjZqNbaYHs40BTr4i/AfAKdH/enSRIAwZQnN0uZ3sc2Ne6NiDpwggxYvPDCJq4sbrk7Olkv3LCwSnb6lvrPjgermYp/bmm3NczcubPkbJnNP2sz/GS1nvijscZP7ArQAyAwaOTSzObWCoCjHijINdKUtfXp+Hu0Nv4X/FhfcfSdYVXgwAYSHTwX8fruI3xVLq2oJ+f7Ioo2Vp/IFt6juTU4cgYJxJIgJ8jUfsumZNL1JpDHVcDcGBvoaHB35bSi0MwaH2g=
Content-ID: <CA662AD9B612344580205C283CE6481B@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8abe11b-1e47-4154-4922-08d6f036cd7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 19:39:09.3344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5006
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

On Thu, Jun 13, 2019 at 11:43:17AM +0200, Christoph Hellwig wrote:
> hmm_vma_alloc_locked_page is scheduled to go away, use the proper
> mm function directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
