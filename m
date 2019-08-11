Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C721C894B5
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 00:53:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 23479212FD3F4;
	Sun, 11 Aug 2019 15:55:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.14.81; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140081.outbound.protection.outlook.com [40.107.14.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5800121959CB2
 for <linux-nvdimm@lists.01.org>; Sun, 11 Aug 2019 15:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUIttu4JwHUI1EBZI6cb27TuJ4Eq48KLg7F8+wlYS3YGlVHcAqUs0LSB3WYbniVBOb/pghMtlLmYanAzUdyvEcOu5WL5YEDg6+OnKjuLDv9C//QHG4GEWgDKDmJWoPI01a15tR2mGxM4/O8w6CAOZc5u+oTBaPjMfW9cK5dWcNI/KOANgveqFOnPkpgEO5SDAU943/uaAxE0sRuObZS9atj5uvSxZcoSEy2wOjWrHyC2QVy8cDzccVdJ+OFCkI4nm8/VUT25zZDr7xd6rnPiDraGrFNvDOuA73n1OtVNhZ4ot2318M8vpwjUXBjJ6WBCBQ3gJ11bzSUUmbBwTEQuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39/yMi2GN3fti8KSy4MytXOiJ4iqQ7GH75iAmcvnbiY=;
 b=VXQgFuETSgmq+VhQ+JEa6XQP0+mxbewBKyVzbczytlfWGoquWZB/vI57L1dYdNvdPUP03phEGvrgLq10C+L5SNwLVbHYBk9AGY+QMdjjr7TfOkE0vV4j4qS0V9UtJO8Y5CYITcaaOyGjJYqjPP3TC/p9zMJjQS2oep+mfuCNjohLfz1UYzL0g1sDV87E4z54GiyJyR+cHjzw4V3QcIFhYrtIIDpXlF8O6l5EGQtbUkhWAcuJOyVVBweRLZ+7VG5FlXIS9v55OraFfqHiXf422aBT1SJHC/AK42uDwDqIhHewhVR3GfkSZmMt9T/zTltbd8LK7nAVk3/5bSwXHuTt3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39/yMi2GN3fti8KSy4MytXOiJ4iqQ7GH75iAmcvnbiY=;
 b=VDIFNJPI07stSrBymBXP6VaSTG5YZLsUpYygoiV/q1i3kkzV82ys+eF01YmgIFfS5AnCkx62Sq5Hj7QGqJMbzcM6jw0i3fQo2gx36OcxeZQ3FcNEkwGXdi4LxP6z8G0Ybs9NW7N63+AQhWgubbpCp7MP2Nsz2o6L55ra9STWO18=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4189.eurprd05.prod.outlook.com (10.171.183.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Sun, 11 Aug 2019 22:52:58 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2157.022; Sun, 11 Aug 2019
 22:52:58 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] resource: add a not device managed
 request_free_mem_region variant
Thread-Topic: [PATCH 2/5] resource: add a not device managed
 request_free_mem_region variant
Thread-Index: AQHVUByWUXcrp3flMEyx0f20u8Fcx6b2jskA
Date: Sun, 11 Aug 2019 22:52:58 +0000
Message-ID: <20190811225252.GB15116@mellanox.com>
References: <20190811081247.22111-1-hch@lst.de>
 <20190811081247.22111-3-hch@lst.de>
In-Reply-To: <20190811081247.22111-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::47) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57d5c8f2-91a0-4bc2-c98f-08d71eaea7e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB4189; 
x-ms-traffictypediagnostic: VI1PR05MB4189:
x-microsoft-antispam-prvs: <VI1PR05MB418933CB6AED2D5D24286C0BCFD00@VI1PR05MB4189.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0126A32F74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(189003)(199004)(6246003)(6512007)(36756003)(81156014)(6916009)(81166006)(478600001)(25786009)(86362001)(229853002)(14454004)(6116002)(3846002)(102836004)(6436002)(2906002)(2616005)(8676002)(5660300002)(76176011)(476003)(8936002)(446003)(11346002)(99286004)(66446008)(64756008)(66946007)(66476007)(66556008)(186003)(256004)(33656002)(66066001)(14444005)(316002)(1076003)(4326008)(305945005)(53936002)(486006)(52116002)(54906003)(386003)(26005)(71200400001)(6486002)(71190400001)(6506007)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB4189;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fib/d5/7PLpwc+0jjc7QqzYzB3bHWHc7KIbrwXBeTw6zkKWhxy3ta9vTDfKKG+IMUgq9A17rYnoHdQfn4j37UVTfPdt5yYXCEHGgmkmhmp6hDzRhn6D1GcDKQL+iCTHf/0x7SClHTa1ee5VRdfg3kTZeQcGjxVINRg3Klf324s6E8oI0xYUF7q5kbSbXGeyKqSw+AYxE91XuSh1A4L0FYTrplXkUnLm1JhsJtAqqaZ4CfVHHgp0zrLOx+zv6xsXCpNUc1OZ+L2yKeUDi3GK3K/iTHLEgCI7tDbZj6w4SBt+fMpE5lgNbHp2gp4NR2NQjXw/sbpfPZ1SURu43HjvYO+C5jwIof6wzS/bnZYFtHsJ5HotlefIDJscChKJn0RkfX5kLZIx3cV7xqD77Hvgk86YHueL6wLgPEKoTSFN3DNc=
x-ms-exchange-transport-forked: True
Content-ID: <821914AB69678F44867B3E27B8469A9F@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d5c8f2-91a0-4bc2-c98f-08d71eaea7e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2019 22:52:58.7756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqus/QJTHmxISqT0Qcqz2TI1ZyjqbbLaL2t/1hQ+KirkuYgxQjBL/62Tsn1ehf2SZZw94hdvesUGjZ1JAsRNCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4189
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bharata B Rao <bharata@linux.ibm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Sun, Aug 11, 2019 at 10:12:44AM +0200, Christoph Hellwig wrote:
> Just add a simple macro that passes a NULL dev argument to
> dev_request_free_mem_region, and call request_mem_region in the
> function for that particular case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  include/linux/ioport.h | 2 ++
>  kernel/resource.c      | 5 ++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 0dcc48cafa80..528ae6cbb1b4 100644
> +++ b/include/linux/ioport.h
> @@ -297,6 +297,8 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
>  
>  struct resource *devm_request_free_mem_region(struct device *dev,
>  		struct resource *base, unsigned long size, const char *name);
> +#define request_free_mem_region(base, size, name) \
> +	devm_request_free_mem_region(NULL, base, size, name)
>  
>  #endif /* __ASSEMBLY__ */
>  #endif	/* _LINUX_IOPORT_H */
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 0ddc558586a7..3a826b3cc883 100644
> +++ b/kernel/resource.c
> @@ -1671,7 +1671,10 @@ struct resource *devm_request_free_mem_region(struct device *dev,
>  				REGION_DISJOINT)
>  			continue;
>  
> -		res = devm_request_mem_region(dev, addr, size, name);
> +		if (dev)
> +			res = devm_request_mem_region(dev, addr, size, name);
> +		else
> +			res = request_mem_region(addr, size, name);

It is a bit jarring to have something called devm_* that doesn't
actually do the devm_ part on some paths.

Maybe this function should be called __request_free_mem_region() with
another name wrapper macro?

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
