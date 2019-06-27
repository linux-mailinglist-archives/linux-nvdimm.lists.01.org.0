Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5257E586DB
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 18:18:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D7DF2212AAFE0;
	Thu, 27 Jun 2019 09:18:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.3.56; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30056.outbound.protection.outlook.com [40.107.3.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4035B2129671C
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 09:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=LBJCwUQhZNZ7JO6Lm19Nly1Wj8bCpXKqTCKdgBXsd6H55hzx7W1wAb6hUJJrD5FqcHqpTPQWmGOjeeJB8iX/pkbU1eeUm2bF+4gSiCpHD3NQDYjzq9HHS7zfgVocvCuAlQZQxkhvFkyt3jKqK1xJXCcqBX6vSIItewtdUWpzMPc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQKJZidBThddtQhWQZohKcjkCp3iYRBt7c0S6siQ09M=;
 b=UtnblwRey3svlmUCbu+2ebcVAuSz5M+zsn+H8ORaEAtxvjgk96dUT6WBtbwkfbuiBC3bcUK96/X+QfQh7GO/4zgdibmsu0eYLFCKZzvsQlth1qResb22s9dFROK5zbAkTX5ZOcpgmeXJbziLc3phdsi3SLaNm0i00WScr2FO9xE=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQKJZidBThddtQhWQZohKcjkCp3iYRBt7c0S6siQ09M=;
 b=J2dMlcNPZlD5N3vpQW1JjZMZcMPSA86ZsmMs/EA5ArN364tGhM/lbJBxFeL8QjH9sUmtmFktOVRL7mywOKEaFOcd259xase/Xs5EwItur4p4WBEUMAcCj0JbdS9MN5foY/pEt0x+MnDGkFVMwyd7bcVx8mwkr8hnhSOMGkaySa4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5886.eurprd05.prod.outlook.com (20.178.125.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 16:18:22 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 16:18:22 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/25] mm: remove hmm_devmem_add_resource
Thread-Topic: [PATCH 03/25] mm: remove hmm_devmem_add_resource
Thread-Index: AQHVLBqRvJE5RWoAFEuwP/I4qHQ7paavr6GA
Date: Thu, 27 Jun 2019 16:18:22 +0000
Message-ID: <20190627161813.GB9499@mellanox.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-4-hch@lst.de>
In-Reply-To: <20190626122724.13313-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::24) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.199.206.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c526e6d-f839-4214-2861-08d6fb1b12e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB5886; 
x-ms-traffictypediagnostic: VI1PR05MB5886:
x-microsoft-antispam-prvs: <VI1PR05MB5886C35E617535FD2443239DCFFD0@VI1PR05MB5886.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(6436002)(66556008)(81166006)(99286004)(2616005)(3846002)(8936002)(6512007)(33656002)(6246003)(68736007)(4326008)(102836004)(53936002)(4744005)(8676002)(6486002)(73956011)(86362001)(81156014)(66946007)(478600001)(5660300002)(36756003)(54906003)(1076003)(186003)(66446008)(25786009)(66066001)(316002)(229853002)(71190400001)(76176011)(6116002)(26005)(66476007)(476003)(2906002)(7736002)(446003)(386003)(52116002)(14454004)(6916009)(256004)(305945005)(486006)(64756008)(11346002)(6506007)(7416002)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB5886;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MPZH6fxej22oS7mLYEZmxFyn20waja4eRFeHmir8gtV1hjF9WJIgHwtjY4C36d2npItR/CWyxfgPjCQ+e19S8i/WruQpqNIHjrH8CZ+IYxP/SAf5mBH7mWcVbuKjO5vst38yOem1FSeiQc+UM2HMfjmCGzZa1IsRZcLs0/bJZFvSDMd7v8/irZB5vT9QtJv1uBJ3h7xdhz/QMy1Uw26YL0jRvCcMQ/atQgGDIJsmelkfWdS/PbSyMm+AYLLH079WJ+KZtdpsYfSGGYocok7klunoms3nZiojM8Wl2c8TBBunzsbCb3Y4kJbM5C/sD1C0N8RqfQHigF8REGgBv/QvoepFXUnYnPM6uoUomO356Lzf/kFxS5R31l4fpw9RbxA78tBT/LQENWHD6dP3CjqH5nHlGfE0H/4aTEuIRyx7Vjo=
Content-ID: <0E26856B4495E64E8EFED3F814341B4B@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c526e6d-f839-4214-2861-08d6fb1b12e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 16:18:22.2670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5886
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
Cc: Michal Hocko <mhocko@suse.com>, John Hubbard <jhubbard@nvidia.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
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

On Wed, Jun 26, 2019 at 02:27:02PM +0200, Christoph Hellwig wrote:
> This function has never been used since it was first added to the kernel
> more than a year and a half ago, and if we ever grow a consumer of the
> MEMORY_DEVICE_PUBLIC infrastructure it can easily use devm_memremap_pages
> directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/linux/hmm.h |  3 ---
>  mm/hmm.c            | 50 ---------------------------------------------
>  2 files changed, 53 deletions(-)

This should be squashed to the new earlier patch?

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
