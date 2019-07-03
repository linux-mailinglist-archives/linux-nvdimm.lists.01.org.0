Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D5A5DA52
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 03:08:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1E1E6212AC48D;
	Tue,  2 Jul 2019 18:08:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.0.84; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00084.outbound.protection.outlook.com [40.107.0.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C73BF212AC487
 for <linux-nvdimm@lists.01.org>; Tue,  2 Jul 2019 18:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYH8NoUBbuO2DOp2zCSNKmlTWAV3O/N7vZgO68ZXz/0=;
 b=XPpTI/dvpyr+KQdeVAbwUKBph62vq391kwQ9z8vUhHMjQELdyP2iVsuCI8V3ojKcwRycOSwBRa0cazWesE+wGLDs5A719Gw5wn0NidA7BnveoZaIU1uT97hcXtNLBJZmkCZhUoBuJVr2zyHN7bKMDy4j0+0ME2BA8zmaHzz82NM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6190.eurprd05.prod.outlook.com (20.178.123.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 01:08:27 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 01:08:27 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: dev_pagemap related cleanups v4
Thread-Topic: dev_pagemap related cleanups v4
Thread-Index: AQHVL9UU5cGGdRKLlkyPcV6XfRMxZaa1bVyAgAI+pYCAAE0OAIAAHuWA
Date: Wed, 3 Jul 2019 01:08:27 +0000
Message-ID: <20190703010823.GB11833@mellanox.com>
References: <20190701062020.19239-1-hch@lst.de>
 <20190701082517.GA22461@lst.de> <20190702184201.GO31718@mellanox.com>
 <CAPcyv4iWXJ-c7LahPD=Qt4RuDNTU7w_8HjsitDuj3cxngzb56g@mail.gmail.com>
In-Reply-To: <CAPcyv4iWXJ-c7LahPD=Qt4RuDNTU7w_8HjsitDuj3cxngzb56g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0058.prod.exchangelabs.com
 (2603:10b6:208:25::35) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 666e2153-d0c6-48b5-99ee-08d6ff52f414
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB6190; 
x-ms-traffictypediagnostic: VI1PR05MB6190:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB61903AF6C1A65E8369742AA3CFFB0@VI1PR05MB6190.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(199004)(189003)(36756003)(4326008)(33656002)(26005)(2616005)(81156014)(305945005)(86362001)(6506007)(966005)(53936002)(486006)(186003)(102836004)(446003)(14454004)(386003)(6916009)(6486002)(316002)(476003)(478600001)(81166006)(53546011)(11346002)(8676002)(68736007)(25786009)(8936002)(7416002)(5660300002)(66476007)(6246003)(6306002)(71200400001)(2906002)(64756008)(6512007)(66946007)(66556008)(66446008)(1076003)(73956011)(52116002)(6436002)(3846002)(229853002)(66066001)(76176011)(7736002)(99286004)(54906003)(14444005)(256004)(6116002)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB6190;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tDKuuIfgR9oX45s9hP9f7523FVZuj/Cp4IDBxNigMSr5WEC2agQIzrEXUBuNboGMSlvz67S1Uv6KuO5ZVoYd5GYuM2F54yxs2sTTMi7FCmrslBqo7dj9at7q74+TdPen4Ou5eFR3mxXkZfyOMYDWnkaLgqzNL/2If2wmF9amG3XbUzJrrF2i9Y4zdvEfxHk9R6qJRkf1ORCx28U/T4g+NZc4f1kuljqQ7WijxNpAVCogMYiR2X1Bk/db8lPDR/VAJvnU79i6YYQsywnUHwhH1zw+GXfs5OX1quMtO1UbEOoC10CfEL+pXw4pjtS9lPIj4b+ktBwFtMnKhYrF4qAXJUgVjOMvu9C0TEJuKee9QFswmucNkvOOYZpnw8ASNXTTpgYjkkaU87VUc1nZzBDTTlMhEbysA2yhWNye1T9POjE=
Content-ID: <9433B9982DD5FE40BE697C702241BE2B@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666e2153-d0c6-48b5-99ee-08d6ff52f414
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 01:08:27.1163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6190
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

On Tue, Jul 02, 2019 at 04:17:48PM -0700, Dan Williams wrote:
> On Tue, Jul 2, 2019 at 11:42 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > On Mon, Jul 01, 2019 at 10:25:17AM +0200, Christoph Hellwig wrote:
> > > And I've demonstrated that I can't send patch series..  While this
> > > has all the right patches, it also has the extra patches already
> > > in the hmm tree, and four extra patches I wanted to send once
> > > this series is merged.  I'll give up for now, please use the git
> > > url for anything serious, as it contains the right thing.
> >
> > Okay, I sorted it all out and temporarily put it here:
> >
> > https://github.com/jgunthorpe/linux/commits/hmm
> >
> > Bit involved job:
> > - Took Ira's v4 patch into hmm.git and confirmed it matches what
> >   Andrew has in linux-next after all the fixups
> > - Checked your github v4 and the v3 that hit the mailing list were
> >   substantially similar (I never did get a clean v4) and largely
> >   went with the github version
> > - Based CH's v4 series on -rc7 and put back the removal hunk in swap.c
> >   so it compiles
> > - Merge'd CH's series to hmm.git and fixed all the conflicts with Ira
> >   and Ralph's patches (such that swap.c remains unchanged)
> > - Added Dan's ack's and tested-by's
> 
> Looks good. Test merge (with some collisions, see below) also passes
> my test suite.

Okay, published toward linux-next now

> >
> > I think this fairly closely follows what was posted to the mailing
> > list.
> >
> > As it was more than a simple 'git am', I'll let it sit on github until
> > I hear OK's then I'll move it to kernel.org's hmm.git and it will hit
> > linux-next. 0-day should also run on this whole thing from my github.
> >
> > What I know is outstanding:
> >  - The conflicting ARM patches, I understand Andrew will handle these
> >    post-linux-next
> >  - The conflict with AMD GPU in -next, I am waiting to hear from AMD
> 
> Just a heads up that this also collides with the "sub-section" patches
> in Andrew's tree. The resolution is straightforward, mostly just
> colliding updates to arch_{add,remove}_memory() call sites in
> kernel/memremap.c and collisions with pgmap_altmap() usage.

Okay, thanks

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
