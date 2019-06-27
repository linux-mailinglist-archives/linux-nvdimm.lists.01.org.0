Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF6F58716
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 18:29:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BF55A212AAB9F;
	Thu, 27 Jun 2019 09:29:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.14.75; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140075.outbound.protection.outlook.com [40.107.14.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F056521296B07
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 09:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acwz3hHPfD+Le/jb5+cmcROosiINY+hQq7uRwwksQzk=;
 b=gFFEYLwEZzcaYgGPwF102oxi9KMrRut1jd93LscZWuscZkJ7vz97pan3/8x2vEXXJM9WtbJlA14NR8UcJbAkHW9w3JeIedSKTFFPtORHMOvOGhoGZb7RAvRv/Y5BxudV1nlvg+ILuTvFuVVL0MF4CwUE0spAe6YVXUlUxB7bc6I=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6032.eurprd05.prod.outlook.com (20.178.127.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 16:29:45 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 16:29:45 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/25] memremap: add a migrate_to_ram method to struct
 dev_pagemap_ops
Thread-Topic: [PATCH 12/25] memremap: add a migrate_to_ram method to struct
 dev_pagemap_ops
Thread-Index: AQHVLBqZBQCOhXKkekmD+Za0eny3n6avsW2A
Date: Thu, 27 Jun 2019 16:29:45 +0000
Message-ID: <20190627162439.GD9499@mellanox.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-13-hch@lst.de>
In-Reply-To: <20190626122724.13313-13-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::33) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.199.206.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 910ae93e-1c98-4933-e059-08d6fb1caa3b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB6032; 
x-ms-traffictypediagnostic: VI1PR05MB6032:
x-microsoft-antispam-prvs: <VI1PR05MB60323BDF1EC27F3D38D0D595CFFD0@VI1PR05MB6032.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(346002)(39860400002)(376002)(136003)(199004)(189003)(6512007)(102836004)(5660300002)(7736002)(305945005)(6116002)(486006)(478600001)(476003)(81156014)(256004)(386003)(11346002)(53936002)(76176011)(3846002)(2616005)(52116002)(446003)(81166006)(6436002)(8936002)(68736007)(66066001)(6246003)(316002)(2906002)(54906003)(229853002)(99286004)(36756003)(6486002)(26005)(6506007)(186003)(64756008)(6916009)(8676002)(7416002)(66946007)(1076003)(66476007)(14454004)(4326008)(86362001)(66556008)(66446008)(73956011)(71190400001)(71200400001)(25786009)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB6032;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FQumiSKh7GVdRl14hBXAy3T/ENWqYM4HWMyt/KiMQB3yuvYG+MOIrLUCPq4S72Bqu5H/LaAUqWhI7Tr8MmgAWraK9rbKVPCD7phnzfo27BCXksIEnr+JiI8gC8Dkz4BoJWEulCIXVdw0MTHsUNYkf4YaA37Jj+hVFrb/3EAHXH56uihx5XRp67A0kIrQyIzowuvy9TMI00/W3AAZlgs8xR6rTn2nfawvNYsN6H0PQmYbU+RUQ2+60Uw5GlYfhzxUkZUBXL3GTMM2930c4vcFAHzQj/BOGwGVL7BXrCUqVPtvAy7rIu5zFs0PBD4C/zDx2ySDvoXcIZjXKZZtgXHwP25hvbKI4+zkbxKJn/yyiRnclDN67c5oFNBFejLblul4zRdK/fFAbZIVtSb6UpmyMqIdIxc06082NQNUV3bmkIg=
Content-ID: <D936285C7F16454CABEEFE9D1BD77309@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910ae93e-1c98-4933-e059-08d6fb1caa3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 16:29:45.6208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6032
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
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 26, 2019 at 02:27:11PM +0200, Christoph Hellwig wrote:
> This replaces the hacky ->fault callback, which is currently directly
> called from common code through a hmm specific data structure as an
> exercise in layering violations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  include/linux/hmm.h      |  6 ------
>  include/linux/memremap.h |  6 ++++++
>  include/linux/swapops.h  | 15 ---------------
>  kernel/memremap.c        | 35 ++++-------------------------------
>  mm/hmm.c                 | 13 +++++--------
>  mm/memory.c              |  9 ++-------
>  6 files changed, 17 insertions(+), 67 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
 
I'ver heard there are some other use models for fault() here beyond
migrate to ram, but we can rename it if we ever see them.

> +static vm_fault_t hmm_devmem_migrate_to_ram(struct vm_fault *vmf)
>  {
> -	struct hmm_devmem *devmem = page->pgmap->data;
> +	struct hmm_devmem *devmem = vmf->page->pgmap->data;
>  
> -	return devmem->ops->fault(devmem, vma, addr, page, flags, pmdp);
> +	return devmem->ops->fault(devmem, vmf->vma, vmf->address, vmf->page,
> +			vmf->flags, vmf->pmd);
>  }

Next cycle we should probably rename this fault to migrate_to_ram as
well and pass in the vmf..

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
