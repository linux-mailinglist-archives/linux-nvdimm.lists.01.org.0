Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F6B4C19D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Jun 2019 21:42:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3A0BC21296B0A;
	Wed, 19 Jun 2019 12:42:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.15.84; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150084.outbound.protection.outlook.com [40.107.15.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3E8D22194EB70
 for <linux-nvdimm@lists.01.org>; Wed, 19 Jun 2019 12:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSRKc0hpLpMPKshog4wha+zcC6Sxgq2cZ5PlvZB0qoM=;
 b=ZSwtME/SMf2qmA+BpeVW3mHny8REA3FCMUxCHE8lRkkEMxElMjsQ1DX2cnJvGZGVJ8BbeL4b1n4axUNDLngO9Tr18RWshV7wZkZtMhndAHkT43IXAIrC7stLRS10BWy22PBb5aNUpDNdt5zSYXs70bV1ne5Av63H5Wf4DYzew6c=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5072.eurprd05.prod.outlook.com (20.177.52.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Wed, 19 Jun 2019 19:27:25 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 19:27:25 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
Thread-Topic: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
Thread-Index: AQHVIcyVeqgMzBs0VkumwilsEzSkhqaZ/TwAgAACYgCAAAF6gIAAT5yAgAALIACACQqXgA==
Date: Wed, 19 Jun 2019 19:27:25 +0000
Message-ID: <20190619192719.GO9374@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-19-hch@lst.de> <20190613194430.GY22062@mellanox.com>
 <a27251ad-a152-f84d-139d-e1a3bf01c153@nvidia.com>
 <20190613195819.GA22062@mellanox.com>
 <20190614004314.GD783@iweiny-DESK2.sc.intel.com>
 <d2b77ea1-7b27-e37d-c248-267a57441374@nvidia.com>
In-Reply-To: <d2b77ea1-7b27-e37d-c248-267a57441374@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::30) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 900ad4f4-9a37-403d-9297-08d6f4ec28b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VI1PR05MB5072; 
x-ms-traffictypediagnostic: VI1PR05MB5072:
x-microsoft-antispam-prvs: <VI1PR05MB5072502328C7585990C51C52CFE50@VI1PR05MB5072.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(366004)(189003)(199004)(5660300002)(86362001)(6246003)(7736002)(73956011)(316002)(66476007)(71190400001)(7416002)(54906003)(486006)(1076003)(71200400001)(256004)(66556008)(2906002)(99286004)(26005)(11346002)(446003)(76176011)(476003)(52116002)(186003)(53546011)(6506007)(386003)(2616005)(36756003)(102836004)(25786009)(3846002)(8936002)(229853002)(6436002)(66946007)(6916009)(6486002)(68736007)(81166006)(53936002)(6116002)(66066001)(64756008)(81156014)(33656002)(66446008)(8676002)(4326008)(6512007)(478600001)(14454004)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB5072;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s0JMiyaM6v59K9Eqvq++39Arx4aDM+CpGKjs2X6UorK6bcpv6l9Q4i9tauNvj0vSZSD3N4mIT8Hy0RczR7OULw46AWpykaDPGF1OEg+O77QdgkpDWOpv6EWjxe0pahP7ur+CMqTY53LiG+BxjnFFCp8JQJtmb5bwiHUJegB+WQ8YHQ6cIuwuXKtyqf0J+vptYI6jTembRhhk2NbSxqeJ3aICqHn6qKizFRKk258+72b4as+ZsMq8T+L+kqMZ2lscGlebcSehAcXWxlWBgFCEtm5ZQ88/WBly85cxXZAolyF8V22GdtISRlQRpn9VBCgqKpJ2hvdBxWvhVfx0QzufxBaFBAPjRVRMNsw/QVIsTpXD2aPXpIJzN7yy81iT9PhiwC6koEHGMSJpMlOvS+4N3ZFn54BqDa6OSepntXF0w00=
Content-ID: <081C2DB7B7A13A4A93487CC051D6E961@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900ad4f4-9a37-403d-9297-08d6f4ec28b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 19:27:25.5442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5072
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
Cc: Ralph Campbell <rcampbell@nvidia.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
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

On Thu, Jun 13, 2019 at 06:23:04PM -0700, John Hubbard wrote:
> On 6/13/19 5:43 PM, Ira Weiny wrote:
> > On Thu, Jun 13, 2019 at 07:58:29PM +0000, Jason Gunthorpe wrote:
> >> On Thu, Jun 13, 2019 at 12:53:02PM -0700, Ralph Campbell wrote:
> >>>
> ...
> >> Hum, so the only thing this config does is short circuit here:
> >>
> >> static inline bool is_device_public_page(const struct page *page)
> >> {
> >>         return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
> >>                 IS_ENABLED(CONFIG_DEVICE_PUBLIC) &&
> >>                 is_zone_device_page(page) &&
> >>                 page->pgmap->type == MEMORY_DEVICE_PUBLIC;
> >> }
> >>
> >> Which is called all over the place.. 
> > 
> > <sigh>  yes but the earlier patch:
> > 
> > [PATCH 03/22] mm: remove hmm_devmem_add_resource
> > 
> > Removes the only place type is set to MEMORY_DEVICE_PUBLIC.
> > 
> > So I think it is ok.  Frankly I was wondering if we should remove the public
> > type altogether but conceptually it seems ok.  But I don't see any users of it
> > so...  should we get rid of it in the code rather than turning the config off?
> > 
> > Ira
> 
> That seems reasonable. I recall that the hope was for those IBM Power 9
> systems to use _PUBLIC, as they have hardware-based coherent device (GPU)
> memory, and so the memory really is visible to the CPU. And the IBM team
> was thinking of taking advantage of it. But I haven't seen anything on
> that front for a while.

Does anyone know who those people are and can we encourage them to
send some patches? :)

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
