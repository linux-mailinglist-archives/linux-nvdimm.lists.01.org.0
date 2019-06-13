Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF70944CCB
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 22:02:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 458DD21296703;
	Thu, 13 Jun 2019 13:02:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.2.87; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20087.outbound.protection.outlook.com [40.107.2.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1C31E2129641B
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lmhrKuSV7GaCf2C9+fxP56+CLwg4sVHwuhk2+6yAoA=;
 b=nXHH6oTMdTMLmi/TtImBS/dCyHU78zPjEUjNSp4lnVViy2lTe4AGx/4SeMkZVFDBhoMNAia0JdmLifxdH4Lr98odLCuLVpxPcLYBuHFpOxbTMu3TvhAnWgTwwxsm+pF4izCRK+/ISDqaIWNIQj2rfgiibv/r9EJD1smDKgXN6eA=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4381.eurprd05.prod.outlook.com (52.133.13.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Thu, 13 Jun 2019 20:01:55 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 20:01:55 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 21/22] mm: remove the HMM config option
Thread-Topic: [PATCH 21/22] mm: remove the HMM config option
Thread-Index: AQHVIcybZ4YnmSc/ekSwqfkgyQT9faaaAhMA
Date: Thu, 13 Jun 2019 20:01:55 +0000
Message-ID: <20190613200150.GB22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-22-hch@lst.de>
In-Reply-To: <20190613094326.24093-22-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0082.namprd02.prod.outlook.com
 (2603:10b6:208:51::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7d97d2a-4a43-492c-522b-08d6f039fbe4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB4381; 
x-ms-traffictypediagnostic: VI1PR05MB4381:
x-microsoft-antispam-prvs: <VI1PR05MB4381BEEE04CCE0A53CD45D77CFEF0@VI1PR05MB4381.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(366004)(189003)(199004)(68736007)(52116002)(53936002)(2906002)(6246003)(71190400001)(71200400001)(26005)(66066001)(81156014)(81166006)(36756003)(54906003)(5660300002)(33656002)(6436002)(102836004)(1076003)(86362001)(99286004)(6486002)(6916009)(229853002)(6116002)(76176011)(3846002)(386003)(316002)(7416002)(6506007)(14454004)(446003)(476003)(7736002)(11346002)(6512007)(8936002)(2616005)(186003)(4326008)(478600001)(486006)(64756008)(66446008)(305945005)(66556008)(256004)(4744005)(8676002)(25786009)(73956011)(66946007)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB4381;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7yWCsk29qZQJ4Hn9JUnWEfUTBD+kbukUw0AN3qXho23YT0zYsYge5E4RXgxJRsbaXi5No2o4BAdg3BW9u67HbUL/SigKNq9GtuqbhSWyCmUbByPx6Qh+tnSkwrr6J++SoZOFL38nzVkfKSB0Dg7VS7R2jtx055eoY7l/DcgRp8Rsm1zQ/FL0XElohyiIghL8gA6UoyT1JU0Du1rAA508vDb2CvlZv2hIGcs5AYYuKsqpDOJGlM7TjL3GJWbl8B8wNSh2iTlmyf2VDQoE4WlvPqhMKur+sHPzL0R7SZg257XZygcRGjOFIyJLnOyo1z6DalA94eYsFjveI0KR74DInxMg4ixWlprhTJ0l5J1ub+ASeoqTeP83paufq04i2gx1MODiqrVm82Fv2gIkrAqFm+kQZfckMDd0HKbfK308SNI=
Content-ID: <4F4AB6FDDD24014F95455A97A0E953B7@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d97d2a-4a43-492c-522b-08d6f039fbe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 20:01:55.3627 (UTC)
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

On Thu, Jun 13, 2019 at 11:43:24AM +0200, Christoph Hellwig wrote:
> All the mm/hmm.c code is better keyed off HMM_MIRROR.  Also let nouveau
> depend on it instead of the mix of a dummy dependency symbol plus the
> actually selected one.  Drop various odd dependencies, as the code is
> pretty portable.

I don't really know, but I thought this needed the arch restriction
for the same reason get_user_pages has various unique arch specific
implementations (it does seem to have some open coded GUP like thing)?

I was hoping we could do this after your common gup series? But sooner
is better too.

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
