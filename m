Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC79A44C6C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 21:42:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5F924212966FF;
	Thu, 13 Jun 2019 12:42:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.2.58; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20058.outbound.protection.outlook.com [40.107.2.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8FB29212966E3
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NiBEz4ijO+lxSyXpK7Yl0ytQfTsISKxzcr0SCPm6JE=;
 b=WPGGb8xOAp+UkRHD5UlkX2A3ttSqfhJeUF/W0UGsNyhrRpFFVUdOEYmRXw91pjffy9YmgsocweUK+R+oi10UC3Ffgy29CtibR3+2FP6J9n5l+eXR96WXyatq7wrBsVkpIZQvAc7UkRhqmai5cH8uqQ9IhBH0PDA+JO4E2vrVrHU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5006.eurprd05.prod.outlook.com (20.177.52.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 19:42:43 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 19:42:43 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 17/22] mm: remove hmm_devmem_add
Thread-Topic: [PATCH 17/22] mm: remove hmm_devmem_add
Thread-Index: AQHVIcyUgj3D92K/UEqq0wbnWDoM1aaZ/LeA
Date: Thu, 13 Jun 2019 19:42:43 +0000
Message-ID: <20190613194239.GX22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-18-hch@lst.de>
In-Reply-To: <20190613094326.24093-18-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31)
 To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad0204ab-e9f3-41a8-358f-08d6f0374dad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB5006; 
x-ms-traffictypediagnostic: VI1PR05MB5006:
x-microsoft-antispam-prvs: <VI1PR05MB5006C2D23554C23B116DFEE3CFEF0@VI1PR05MB5006.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:454;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(11346002)(33656002)(52116002)(486006)(99286004)(76176011)(7416002)(386003)(229853002)(2906002)(66066001)(102836004)(6506007)(54906003)(3846002)(6512007)(6916009)(6436002)(6486002)(186003)(26005)(476003)(446003)(2616005)(6116002)(36756003)(305945005)(64756008)(316002)(66446008)(8676002)(66556008)(66476007)(25786009)(68736007)(73956011)(5660300002)(66946007)(4326008)(81166006)(86362001)(7736002)(81156014)(14454004)(4744005)(6246003)(8936002)(71200400001)(53936002)(478600001)(71190400001)(256004)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB5006;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: McGaOtbmZWACFWSvsDkXQQIGurm3RW/CW3fPYQ5QlYRTj3VHKVGzTNLVyjFiCL2tpCIQB6qnZzXK2qhRkaRpwHMICQyLJja3HA3B+rDSSEbpyab+P7f70du4JnGTvVMrnLmpV8bI0zX8Jsu7XGfT1rR8/0gToQfFkKP/c6pvA5ErS/Xp+yUb5gKEzSB9O8qNJVrV5MALF6U0uYSxd/1KyDpQPIctlIEUdL41q6/k7FO5Wr6ETTep7tzvy6FQLcwQ0QTcN/6KJhFQ2AoHKLxkiqUB9BlsSbkHDLFnueMjNRv7bvRIxryhT6ENwDcWmvGIhxle3r2U/w/AbnEkVdHPZqk3VFeuT5yawpumwi1hTJcovKSYCz8ZCTNA3PgcqA7ZkgrEyt/m/tMwUJHAIJSvY15//IfkasHvBAvHfJ5DqKs=
Content-ID: <4271DAA2E22D344AB96571BECBECE6B2@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0204ab-e9f3-41a8-358f-08d6f0374dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 19:42:43.8857 (UTC)
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

On Thu, Jun 13, 2019 at 11:43:20AM +0200, Christoph Hellwig wrote:
> There isn't really much value add in the hmm_devmem_add wrapper.  Just
> factor out a little helper to find the resource, and otherwise let the
> driver implement the dev_pagemap_ops directly.

Was this commit message written when other patches were squashed in
here? I think the helper this mentions was from an earlier patch

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/vm/hmm.rst |  26 --------
>  include/linux/hmm.h      | 129 ---------------------------------------
>  mm/hmm.c                 | 115 ----------------------------------
>  3 files changed, 270 deletions(-)

I looked for in-flight patches that might be using these APIs and
found nothing. To be sent patches can use the new API with no loss in
functionality...

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
