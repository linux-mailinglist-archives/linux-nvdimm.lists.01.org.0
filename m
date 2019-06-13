Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A4144AB3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 20:30:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1C010212966F1;
	Thu, 13 Jun 2019 11:30:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.5.76; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50076.outbound.protection.outlook.com [40.107.5.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 768492129641B
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0d+YLFD8dGkAwiCYZAtPwS2G6Ds7zR/M3jKY4RPVuk=;
 b=monCWH28lJ8KutFgYrbunH4n71O0rCyBxc5YAFfMijiC+36DWBjgRugr2jES4xlF5XZW4obgenyjgDDc9/IxSVr5yzCoI5cH1QauGF4qKClZYCrLY15EznN0ic2/4wRlPBtniXJKWIQFSIlRR23+0rxITpaOtgBm7uBPIcTdrA8=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5584.eurprd05.prod.outlook.com (20.177.203.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 18:30:28 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 18:30:28 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/22] mm: remove the unused ARCH_HAS_HMM_DEVICE Kconfig
 option
Thread-Topic: [PATCH 01/22] mm: remove the unused ARCH_HAS_HMM_DEVICE Kconfig
 option
Thread-Index: AQHVIcx6m7GApB2g2EOjqyqCTmZIFaaZ6IgA
Date: Thu, 13 Jun 2019 18:30:28 +0000
Message-ID: <20190613183024.GN22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-2-hch@lst.de>
In-Reply-To: <20190613094326.24093-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:208:fc::45) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1ee3c6a-1509-419a-74b4-08d6f02d35ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB5584; 
x-ms-traffictypediagnostic: VI1PR05MB5584:
x-microsoft-antispam-prvs: <VI1PR05MB558425A8B5EAF3873BF93F5BCFEF0@VI1PR05MB5584.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(366004)(189003)(199004)(11346002)(26005)(4326008)(8676002)(2906002)(446003)(73956011)(81166006)(81156014)(68736007)(316002)(8936002)(229853002)(66446008)(6512007)(6436002)(64756008)(25786009)(66946007)(66556008)(6486002)(66476007)(2616005)(476003)(7736002)(305945005)(186003)(53936002)(256004)(3846002)(1076003)(6116002)(6506007)(6246003)(33656002)(66066001)(386003)(14454004)(102836004)(4744005)(71190400001)(54906003)(86362001)(6916009)(71200400001)(36756003)(478600001)(486006)(5660300002)(99286004)(76176011)(7416002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB5584;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eb3KNKd+VDg3aMK8Xechk52gl84tRX+UWpHdsOLNOQzeiT28ESmFj2R4yKBmX+NPNaW6nZgyRfR3xgOTcaQ1b4lRWF6pQAbCHEkPttsEIW1r8cu28CXaD45UV36dQZIooipJbaFiZTzELlXICo9wDON3UG7aNvg+R+cWUXcYJie9pdMNgKX5v3lkEcBent4N1kyPRMafc480EDdxGF4aAAmP5ip0yM9nDnluL/fQCgq8GXOGX7b3kOgug3OKimrxKxX837QgZlGE2fpggJ/ZDicu4ctD5be9CWPG3TpqcjUCqzn1BV4UmOojvh+hKxZkl1v7Z0lpZ+RXvTN9QxS06jX1iWzwcH93SIz/BXEzE46Prkw1Id4bz6tQ0K79DZqnttQrzX5GmktcE0O6ji7z3ox0jb5Tt89CDTzrmvMVFN0=
Content-ID: <1C3FD7879859344FA6C6020F72EC479A@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ee3c6a-1509-419a-74b4-08d6f02d35ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 18:30:28.7061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5584
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

On Thu, Jun 13, 2019 at 11:43:04AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/Kconfig | 10 ----------
>  1 file changed, 10 deletions(-)

So long as we are willing to run a hmm.git we can merge only complete
features going forward.

Thus we don't need the crazy process described in the commit message
that (deliberately) introduced this unused kconfig.

I also tried to find something in-flight for 5.3 that would need this
and found nothing

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
