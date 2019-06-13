Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7D144FDF
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Jun 2019 01:10:53 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1570A21296B0A;
	Thu, 13 Jun 2019 16:10:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.3.41; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30041.outbound.protection.outlook.com [40.107.3.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3B7302129671B
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 16:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=739c5jQXQ0DYsV5q9yGUEJ3j5bapmAiM/he/yV381G8=;
 b=puGmflYjZFCuMlHhWT3QE5twzlouftmMldP/seG3MfaVrk/szmnlBQwflcPwHA5qHBdvpNlr0Ehq1pu9NgbvTfObVG4KcDZE5q2/IUSvXbgRf/4j6Jza9jw82Fn8p9yrYP4L3YI7cXQvUgFCt7/Je5ZOTooBYEI8LKLE7m5GxvY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5216.eurprd05.prod.outlook.com (20.178.12.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Thu, 13 Jun 2019 23:10:45 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 23:10:45 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: dev_pagemap related cleanups
Thread-Topic: dev_pagemap related cleanups
Thread-Index: AQHVIcx5DdVrUhs/HUiF5V2FmmsvzKaZ58OAgAAlLoCAAAtCgIAAHqKA
Date: Thu, 13 Jun 2019 23:10:45 +0000
Message-ID: <20190613231039.GE22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com>
 <20190613204043.GD22062@mellanox.com> <20190613212101.GA27174@lst.de>
In-Reply-To: <20190613212101.GA27174@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: QB1PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::18) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6deefc2c-1cfe-42b4-a481-08d6f0545d5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB5216; 
x-ms-traffictypediagnostic: VI1PR05MB5216:
x-microsoft-antispam-prvs: <VI1PR05MB52161DFBA773BE4F896E6107CFEF0@VI1PR05MB5216.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(199004)(189003)(66446008)(64756008)(66476007)(66946007)(1076003)(7416002)(66556008)(73956011)(5660300002)(2906002)(8936002)(81156014)(26005)(8676002)(71200400001)(71190400001)(102836004)(256004)(6506007)(386003)(76176011)(86362001)(52116002)(486006)(99286004)(11346002)(446003)(4744005)(7116003)(2616005)(476003)(66066001)(6246003)(305945005)(33656002)(14454004)(25786009)(7736002)(6116002)(3846002)(4326008)(478600001)(54906003)(6916009)(36756003)(68736007)(6512007)(186003)(81166006)(6436002)(6486002)(316002)(53936002)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB5216;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IxerV2Ues/JSOcb8GLs2M1W5creYR/hSc2Ld7NaDx5lom/4gPQHVuDzz+iegaHaiak68YoBo1qmhTmWqPMNuSkxTUbVDMXKuD+y0MYQ+s148o+lJXY45QaReW0xTCbwj4fTWzHYpaVgpzyOI2uJGjuwe8zltTJyKEO+MbJPVH952uN+EGFGVWkIU0VwBnwdLoi/L7zVf4zyvko2537aRaFOVkWfyl2VO9zl8rGK2luIOihGZ8nCEfxFwMA3a3fs9GSSPfKJWGaMt2M06AQU/jZvaIfQtev7Y7HJI6lt7AVU7FDor+VuW5RzO0wnekKZou8W3toLRY+zBldGHKLLUUoWpjJihE6y4qwY2VvpWwKCfX/0BM5glNwMu0BPr3g1xu7K7ivPeEJiAMRgbFvD52ghJtJEYdA1bBTbY/VbQzx8=
Content-ID: <9DD504E2832E244190B09BBD35CAF05D@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6deefc2c-1cfe-42b4-a481-08d6f0545d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 23:10:45.6882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5216
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 13, 2019 at 11:21:01PM +0200, Christoph Hellwig wrote:
> On Thu, Jun 13, 2019 at 08:40:46PM +0000, Jason Gunthorpe wrote:
> > > Perhaps we should pull those out and resend them through hmm.git?
> > 
> > It could be done - but how bad is the conflict resolution?
> 
> Trivial.  All but one patch just apply using git-am, and the other one
> just has a few lines of offsets.

Okay, NP then, trivial ones are OK to send to Linus..

If Andrew gets them into -rc5 then I will get rc5 into hmm.git next
week.

Thanks,
Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
