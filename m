Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 845CD5A1AF
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 19:02:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E88F9212AB4F3;
	Fri, 28 Jun 2019 10:02:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.6.63; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60063.outbound.protection.outlook.com [40.107.6.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6AA72212AB4DE
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 10:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=IxczjIUX47SlEfJYKoaREQQKFOfyym85joRLApmCR72W4WGLYtBNjfYt1kxQyub6qzLLShmH72FrtV23LqP3o8iX6ar3HpsJuMEiNoUowvo0XYBkV5LGx5T5w13p54XHvsXlDZPBmGU58fljMIHP63QztpW/l4QS5EeffMnUX9U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jwEvvXUPY88v4ZIhjZnxTRkKIFmTLxalBf1YgUdmjQ=;
 b=IL2dXY4OhYgLg4sz80I+UjCUNx0tbxM2db9p8Rj4GEi73Vbn2LoNrBd/QesM81z5Ewvi3FE100nrUYiPwNTMPiHPmekoSRVEviuvM7KW0NlnEllbySczlJfJn83hESXfDbtCK79uD9CqMfHEZwdIQ7KNOs6MSDDDZJEMfkTi0jo=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jwEvvXUPY88v4ZIhjZnxTRkKIFmTLxalBf1YgUdmjQ=;
 b=EEFB2bfzg7R35ekPU9Is2C89hjDR2HVzz4USps+O4m1NTKt+eYNlqIRj3E2ge6F/POzMOyUDha3b1hEf+LsigHTYKKrxng13GVQrHo6GM6Ax0e6+cdYdlpzyfuAMTKZ8Mfl0hly1OH3BuZGrWaCybS6QbzW/MMtLrT/8xaiY6rc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6255.eurprd05.prod.outlook.com (20.178.205.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 17:02:26 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 17:02:25 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
Thread-Topic: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
Thread-Index: AQHVLBqgvimki3zmIk2l4xtSxGbkyKaxNtmAgAANxQCAAAmqgA==
Date: Fri, 28 Jun 2019 17:02:25 +0000
Message-ID: <20190628170219.GA3608@mellanox.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-17-hch@lst.de> <20190628153827.GA5373@mellanox.com>
 <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
In-Reply-To: <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:a03:114::12) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [76.14.1.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dca8a338-cacd-4cc5-0d77-08d6fbea6507
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB6255; 
x-ms-traffictypediagnostic: VI1PR05MB6255:
x-microsoft-antispam-prvs: <VI1PR05MB62553740A223896F85BB96E0CFFC0@VI1PR05MB6255.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(189003)(199004)(66446008)(8936002)(6916009)(6436002)(66556008)(33656002)(476003)(53546011)(305945005)(186003)(66066001)(64756008)(3846002)(54906003)(11346002)(26005)(6486002)(6116002)(2906002)(36756003)(68736007)(478600001)(7736002)(14454004)(316002)(486006)(2616005)(86362001)(53936002)(4326008)(5660300002)(71200400001)(52116002)(73956011)(6246003)(446003)(66476007)(1076003)(81156014)(99286004)(6512007)(81166006)(6506007)(76176011)(8676002)(25786009)(256004)(71190400001)(386003)(7416002)(66946007)(102836004)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB6255;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1/O3iWmC49vqkfTuIb6GxfWPtwbqlTXEwu/cBsHqgZFr2n42TM+T/WLayFGiGhm+ClF7k7H7WUE5ScOm5f7mNwpOaJ2m6+C/qIgtmbduzmKBWANaB4Y6zJk2MXtcp/2cDewi2NNgVZMcdqG+shOFEZviCpMTl8VgoJwlcdSKhcbH3SB44zT3BumCqIU+JKIVw/udzgLHzpk/eZIEwaRxWtsKiG4ZAXBrn/TKiIsN/R2nelXN904cX8vuCjLBox1h4WQpnKa9WZYuy0Mo3i5a1DTUxZ9YeAVXwwoc99ba/G4FOOLxcYGnK1rN22ApkFcP+1qbQMRlchBa3NqffF8YBZvd9af8O0rVEqn6WhFeIyMn2zFyJFtulrLXO6EmInoYzncEs54QmipsPRyLPFYFYGOGNuqU9O92ImK00scWKAY=
Content-ID: <F315CA51D2C30A40AD4C5447E0263858@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca8a338-cacd-4cc5-0d77-08d6fbea6507
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 17:02:25.8791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6255
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
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 28, 2019 at 09:27:44AM -0700, Dan Williams wrote:
> On Fri, Jun 28, 2019 at 8:39 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > On Wed, Jun 26, 2019 at 02:27:15PM +0200, Christoph Hellwig wrote:
> > > The functionality is identical to the one currently open coded in
> > > device-dax.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > >  drivers/dax/dax-private.h |  4 ----
> > >  drivers/dax/device.c      | 43 ---------------------------------------
> > >  2 files changed, 47 deletions(-)
> >
> > DanW: I think this series has reached enough review, did you want
> > to ack/test any further?
> >
> > This needs to land in hmm.git soon to make the merge window.
> 
> I was awaiting a decision about resolving the collision with Ira's
> patch before testing the final result again [1]. You can go ahead and
> add my reviewed-by for the series, but my tested-by should be on the
> final state of the series.

The conflict looks OK to me, I think we can let Andrew and Linus
resolve it.

Thanks,
Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
