Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5B944CB2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 21:58:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E458021296702;
	Thu, 13 Jun 2019 12:58:34 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.4.60; helo=eur03-db5-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40060.outbound.protection.outlook.com [40.107.4.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B10D421290DDC
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2htE/EYsrky4UH8MwG+WJWY3xDNbfvqPNXq0yl06kE=;
 b=NwrQy10/EB/7iKUzBwiP0xmPlH7ZtdAlNMflQH1hNbn4/r+oHD5CfsY9MXBj7FAnXVrVuSaY6GulI3Vah/8X2MrMbltvr3EEYzYKmGvnmP5JLdsfZXTlSxHbW/YL8LUsjhMibWBRxFD2oe6UOpY8Bog/vkEf6sFBQ0wUOe4qK6o=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6030.eurprd05.prod.outlook.com (20.178.127.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 19:58:29 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 19:58:29 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
Thread-Topic: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
Thread-Index: AQHVIcyVeqgMzBs0VkumwilsEzSkhqaZ/TwAgAACYgCAAAF6gA==
Date: Thu, 13 Jun 2019 19:58:29 +0000
Message-ID: <20190613195819.GA22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-19-hch@lst.de> <20190613194430.GY22062@mellanox.com>
 <a27251ad-a152-f84d-139d-e1a3bf01c153@nvidia.com>
In-Reply-To: <a27251ad-a152-f84d-139d-e1a3bf01c153@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:c0::16) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5c3b5b4-9397-4985-fe76-08d6f039811e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB6030; 
x-ms-traffictypediagnostic: VI1PR05MB6030:
x-microsoft-antispam-prvs: <VI1PR05MB60308FFB6145E73B56AB9897CFEF0@VI1PR05MB6030.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(76176011)(256004)(99286004)(3846002)(4326008)(68736007)(66556008)(73956011)(2906002)(66946007)(6246003)(66446008)(64756008)(386003)(6116002)(53546011)(6506007)(1076003)(52116002)(66476007)(86362001)(446003)(316002)(14454004)(6512007)(2616005)(53936002)(66066001)(81166006)(478600001)(7416002)(33656002)(8936002)(71200400001)(71190400001)(36756003)(11346002)(6916009)(476003)(8676002)(7736002)(102836004)(5660300002)(186003)(305945005)(26005)(54906003)(6486002)(6436002)(25786009)(229853002)(81156014)(486006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB6030;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +rHR4yNz2DiEAD3ZeK5Nywni7ynWym3Tv9AxgXTqs7Di54gyzHpnC7Sn53lpHimljqLCvlTHL5Fm2/whl2TetvZ99ChjzU5mbuPPtL02FmKHU0zbx+B+i4VSgdXjvGlXUqLbyM9ksoeaCT4y33yEK7ojwFJrCQWUD5yA00jKpXGEaxzkkJfYcOvllHmFWMfbP97VK3sdwn5bJiA1Gi+5jjKe5YOB/LWKqIcalEy9+SrI1xvBifgZfk6LMrnkLUl/lTQch+pO3n7OU3C/W678nu4HzLwKoqMocAI1GDI49RnhIkfUskKgPu2eiPme7cdk44FpI1AqD6Gd8axVEOSp8Q/0BEPaBRrMkvpp+K5DHbQLwcnmK1Dank3QkGM0Ju/kXiG19aAalZiYdRGuEXKVftwFo07S6QPKvYhDO0klfyw=
Content-ID: <E2A7F637FAC6984B88734C89A688CD72@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c3b5b4-9397-4985-fe76-08d6f039811e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 19:58:29.4725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6030
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

On Thu, Jun 13, 2019 at 12:53:02PM -0700, Ralph Campbell wrote:
> 
> On 6/13/19 12:44 PM, Jason Gunthorpe wrote:
> > On Thu, Jun 13, 2019 at 11:43:21AM +0200, Christoph Hellwig wrote:
> > > The code hasn't been used since it was added to the tree, and doesn't
> > > appear to actually be usable.  Mark it as BROKEN until either a user
> > > comes along or we finally give up on it.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > >   mm/Kconfig | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index 0d2ba7e1f43e..406fa45e9ecc 100644
> > > +++ b/mm/Kconfig
> > > @@ -721,6 +721,7 @@ config DEVICE_PRIVATE
> > >   config DEVICE_PUBLIC
> > >   	bool "Addressable device memory (like GPU memory)"
> > >   	depends on ARCH_HAS_HMM
> > > +	depends on BROKEN
> > >   	select HMM
> > >   	select DEV_PAGEMAP_OPS
> > 
> > This seems a bit harsh, we do have another kconfig that selects this
> > one today:
> > 
> > config DRM_NOUVEAU_SVM
> >          bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
> >          depends on ARCH_HAS_HMM
> >          depends on DRM_NOUVEAU
> >          depends on STAGING
> >          select HMM_MIRROR
> >          select DEVICE_PRIVATE
> >          default n
> >          help
> >            Say Y here if you want to enable experimental support for
> >            Shared Virtual Memory (SVM).
> > 
> > Maybe it should be depends on STAGING not broken?
> > 
> > or maybe nouveau_svm doesn't actually need DEVICE_PRIVATE?
> > 
> > Jason
> 
> I think you are confusing DEVICE_PRIVATE for DEVICE_PUBLIC.
> DRM_NOUVEAU_SVM does use DEVICE_PRIVATE but not DEVICE_PUBLIC.

Indeed you are correct, never mind

Hum, so the only thing this config does is short circuit here:

static inline bool is_device_public_page(const struct page *page)
{
        return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
                IS_ENABLED(CONFIG_DEVICE_PUBLIC) &&
                is_zone_device_page(page) &&
                page->pgmap->type == MEMORY_DEVICE_PUBLIC;
}

Which is called all over the place.. 

So, yes, we really don't want any distro or something to turn this on
until it has a use.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
