Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B8144CD7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 22:04:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 878EF21296704;
	Thu, 13 Jun 2019 13:04:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.2.66; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20066.outbound.protection.outlook.com [40.107.2.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C31E32129641B
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 13:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnyCRHhq6our3JahOP7YUJnCatYmzhQnh3SEMqGi3dI=;
 b=tDnFxoEoVdJBSN3ifgsVF1zVBJV+F7fIQFERH6l2SFzpul7cbtTkMS4MxC6YxRlST4jOSZUB3kCC8MnSqhwbNgP97LvBIHKqZn3DwjpIUiqGNULbal9I3/wQPE+1k7Qa4APNV7lQY7PyLFlmnfI34vV38Sl/Z5PjU8dXF8PeMCk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4381.eurprd05.prod.outlook.com (52.133.13.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Thu, 13 Jun 2019 20:04:03 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 20:04:03 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 22/22] mm: don't select MIGRATE_VMA_HELPER from HMM_MIRROR
Thread-Topic: [PATCH 22/22] mm: don't select MIGRATE_VMA_HELPER from HMM_MIRROR
Thread-Index: AQHVIcyc3r2YZSS3CUapXwnP1XJouKaaAquA
Date: Thu, 13 Jun 2019 20:04:03 +0000
Message-ID: <20190613200357.GC22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-23-hch@lst.de>
In-Reply-To: <20190613094326.24093-23-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::15) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a348214a-681a-493b-a591-08d6f03a4842
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB4381; 
x-ms-traffictypediagnostic: VI1PR05MB4381:
x-microsoft-antispam-prvs: <VI1PR05MB43813927D62479F9D88EF8ABCFEF0@VI1PR05MB4381.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(39860400002)(376002)(136003)(396003)(199004)(189003)(446003)(476003)(14454004)(8936002)(6512007)(186003)(2616005)(11346002)(7736002)(3846002)(386003)(6116002)(76176011)(6506007)(316002)(7416002)(8676002)(4744005)(256004)(66946007)(66476007)(25786009)(73956011)(478600001)(14444005)(4326008)(64756008)(66446008)(66556008)(305945005)(486006)(66066001)(81166006)(36756003)(81156014)(68736007)(53936002)(52116002)(71190400001)(26005)(71200400001)(6246003)(2906002)(6486002)(99286004)(86362001)(229853002)(6916009)(33656002)(54906003)(5660300002)(1076003)(102836004)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB4381;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wHlkn2ZfV9rDati83SasESQC5vPO5aAUc6haeZsc3mf5YMTqR0rvPOwQ/jmHjydNylEIBAbQSsIpA4xlWwWWmXVcbjuSbBG89xPpjgnzFAY9/pNQ0MevcNaLFvKVwmaofHBRX3U80+m+n/XNiTHFh4Dkr1Y8xUBqXH3Bm7kLAGqZNIa80R9+gfK1I/ojwlmseAk+31Z3tJJsHWoHjogYiG/BUrdnA2YRRv//z4Yoth+w2fzdP6j9E9OO8whiiJCjw7AHM2LJhRP1YU7SSXS5ASCcA0Aa7Ja/kHzVKJHzFIDfaLy7RBoiCbsIbgGKzVoRMwiljvO9aMLS2+LOzhiT2/5Ldlmi0pcEr629xNZ/eEkITnDNP+wcG4JcSreBI0wnIMLHZJIO86ajMA/D9QjQnb+9FjlgsHFbbVB1Rjgz34U=
Content-ID: <DC6C94E2B8591541A7B0CC844A612312@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a348214a-681a-493b-a591-08d6f03a4842
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 20:04:03.4038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4381
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

On Thu, Jun 13, 2019 at 11:43:25AM +0200, Christoph Hellwig wrote:
> The migrate_vma helper is only used by noveau to migrate device private
> pages around.  Other HMM_MIRROR users like amdgpu or infiniband don't
> need it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/nouveau/Kconfig | 1 +
>  mm/Kconfig                      | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)

Yes, the thing that calls migrate_vma() should be the thing that has
the kconfig stuff.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
