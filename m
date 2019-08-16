Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5560901A2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Aug 2019 14:34:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8BD60202C80B8;
	Fri, 16 Aug 2019 05:35:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.6.62; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60062.outbound.protection.outlook.com [40.107.6.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 87948202C80AB
 for <linux-nvdimm@lists.01.org>; Fri, 16 Aug 2019 05:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8OQ4NhNYl9h9gPHNk6xnSHn5cbz57jb30qM41Bfl/SnwH9BWtR5zawc31uTtysScaP/qrAEiXZ8bBHwYGtCb1LMr1Yi5Pcw+1nRLwMYkY3eE4XC8ed1wQKw1F0jUDZ+NOkc2LtZQ0Enl8bG0QdHVnSbuL1uhkse4bjxFfW+tEsQANKljpG8q6iFaQTgQN8YO5lWr86+bXp5U79lI1h+sZt7ZC9PX9A02ssbhWFfXilK4+3hSU8q5bMpvgWOe3YFw6cvuoTQeId8QzzxcXaW/ubQO3I+ivxecLZ4hNfwFgoz8FhKXnnoX3n9nIvFz1yyVwOP8zgA9d27/khncmPGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P9sAnoIFMCO89xDGUoKFkg2dnn59n+DD+YTOQd/ut8=;
 b=nnM9PVLk4JJJneZOM+SZowdh0eKcHUOUhGF+9/5MipNX3t8e2uf4o2da8rGk0Wpvcjb3asT1wkXi3qRXQrBq/jKa7cxWhwfzQIze8mkhl7B9d4BL6Zu59dmkdHfr+HlRbyloMBtuflhg73Qm/ybBgiQ1Cf/0wkTrSA39fva2EdvK5CeMxIWa6VZB4KmHo+2+9Byatcswwevpj3RRDtygsluQi5u1gTOmO1K1iMgl+ynhgkBjtzsXypgJXQxtQq5PlVfHgD9iyYmjZOu9GSPf6OSCVwUZObJRBR+ftkEMn0ynS54jfmwB75FewJ1dDkcYFVC/BPV/QLNyGWZgVBYBVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P9sAnoIFMCO89xDGUoKFkg2dnn59n+DD+YTOQd/ut8=;
 b=NjHfkVJ18DFe9BRnBfFLQe5rQw/VltVEBcrf0012YF9+jjftMQk4c3Y6A9ctgpeMko0TPBMx/Sn/ceFKbOdQTafeYkqi/KVK2I9XqLIKaBj3TFtpAe5OLea3OZzCN7J5Ki6gyWQe82G1s18i2JQabDmxb0o1852M151e4pymlDw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5566.eurprd05.prod.outlook.com (20.177.202.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 16 Aug 2019 12:34:02 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.016; Fri, 16 Aug 2019
 12:34:02 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: add a not device managed memremap_pages v2
Thread-Topic: add a not device managed memremap_pages v2
Thread-Index: AQHVU/97vsv9UEZaeUmMAUjVp5ftIKb9tb4A
Date: Fri, 16 Aug 2019 12:34:01 +0000
Message-ID: <20190816123356.GE5412@mellanox.com>
References: <20190816065434.2129-1-hch@lst.de>
In-Reply-To: <20190816065434.2129-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::43) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 224ca08e-6004-4106-d8d1-08d722460498
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB5566; 
x-ms-traffictypediagnostic: VI1PR05MB5566:
x-microsoft-antispam-prvs: <VI1PR05MB55664914851400D2352756E0CFAF0@VI1PR05MB5566.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(189003)(199004)(2616005)(102836004)(8936002)(53936002)(305945005)(14454004)(81166006)(476003)(256004)(81156014)(14444005)(446003)(11346002)(3846002)(54906003)(86362001)(6116002)(486006)(4326008)(71190400001)(7736002)(6512007)(316002)(6246003)(6486002)(8676002)(99286004)(33656002)(66476007)(6436002)(66946007)(64756008)(71200400001)(229853002)(66446008)(66556008)(25786009)(4744005)(1076003)(6916009)(52116002)(2906002)(66066001)(5660300002)(6506007)(386003)(186003)(26005)(76176011)(478600001)(36756003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB5566;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MY73pnBQRtVmHNEMeFsKS+DTAxd1Ivw2o7GLlh5JXfU7KNwUTkOPXMndHoCVBpgyOoY2SqGaEUikWTgfQPa5/VMdnDwknOnfftkws8bUmSi06AIdGoQ/UzzWjzKc8jWdjn2PTLZ2CMQVugMQ7zE+f9fIroDhMlviwv4we38g3z2kgQl/+vZ2mHdjEtM9aTAZVnybR0yo1x0ibruhJRkHoT4HiWWBnxKD2p5VUNZ585favw0+oV+RzdWjQCiNBx30jO7A6VGpF7L7qvsnCDoaYtHyFa9EtiR2QXSJvC4c4DA0ixla6G+lo+jjl8JibhTZQrroQ7LYT9oR4XkxAHghQlGcZ5GHD2frtV5sFBi0ZxIVSzpN3dB7ftSxAVB08gC1NDRC2I0pgEW+P5GlRsujPWMpSvl/uja5GIf3Biam3aA=
x-ms-exchange-transport-forked: True
Content-ID: <C7EF064B65B4074E82C1D3942FF34F9F@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224ca08e-6004-4106-d8d1-08d722460498
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 12:34:01.8214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fDhP4GxnHZM4uuZzIFlZH+M7EkC9pc8INPfsdv9qElewU8t04CK+YcKKjbnobqaDoS8qN36DE52skQOdlqdYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5566
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

On Fri, Aug 16, 2019 at 08:54:30AM +0200, Christoph Hellwig wrote:
> Hi Dan and Jason,
> 
> Bharata has been working on secure page management for kvmppc guests,
> and one I thing I noticed is that he had to fake up a struct device
> just so that it could be passed to the devm_memremap_pages
> instrastructure for device private memory.
> 
> This series adds non-device managed versions of the
> devm_request_free_mem_region and devm_memremap_pages functions for
> his use case.
> 
> Changes since v1:
>  - don't overload devm_request_free_mem_region
>  - export the memremap_pages and munmap_pages as kvmppc can be a module

What tree do we want this to go through? Dan are you running a pgmap
tree still? Do we know of any conflicts?

Thanks,
Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
