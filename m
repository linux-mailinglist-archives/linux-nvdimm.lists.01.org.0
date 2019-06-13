Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AAF44B06
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 20:46:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 63C5A212966F2;
	Thu, 13 Jun 2019 11:46:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.15.51; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150051.outbound.protection.outlook.com [40.107.15.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0E6132194EB7A
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 11:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XcQHmpnLa8Ccm8n/NNb6h6pJP/b83WvVwKH4dVjrGI=;
 b=F2NGmmF8PcrSuKqYHZP/ltHNtTQ/3yXA1jxUOAv6zBo/PQnSoylORIuCAGTEg5bTKk5lnKFf0as+54Ck2eM3roPqwxGi69XuGjJnNgJRRGrex66U663ag2Zr/ob/qEYj8FEiAsc/evMyyzj2t89jw53MYPv/cMAfHehUy/IDIXc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4701.eurprd05.prod.outlook.com (20.176.4.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 18:46:36 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 18:46:36 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/22] mm: remove the struct hmm_device infrastructure
Thread-Topic: [PATCH 02/22] mm: remove the struct hmm_device infrastructure
Thread-Index: AQHVIcx635NBB7Z8DkeP0aiwq2XU+KaZ7QiA
Date: Thu, 13 Jun 2019 18:46:36 +0000
Message-ID: <20190613184631.GO22062@mellanox.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-3-hch@lst.de>
In-Reply-To: <20190613094326.24093-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e748266-6013-44cb-2451-08d6f02f765a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB4701; 
x-ms-traffictypediagnostic: VI1PR05MB4701:
x-microsoft-antispam-prvs: <VI1PR05MB47013CC710784AD316D44798CFEF0@VI1PR05MB4701.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(346002)(376002)(39860400002)(396003)(199004)(189003)(66556008)(305945005)(2616005)(476003)(54906003)(11346002)(8676002)(486006)(446003)(5660300002)(1076003)(64756008)(66476007)(66946007)(66446008)(86362001)(8936002)(36756003)(66066001)(81166006)(81156014)(73956011)(99286004)(229853002)(6512007)(4326008)(6916009)(386003)(478600001)(256004)(71190400001)(3846002)(2906002)(76176011)(14454004)(52116002)(102836004)(6116002)(6506007)(33656002)(186003)(26005)(6486002)(68736007)(7416002)(6246003)(25786009)(6436002)(7736002)(316002)(71200400001)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB4701;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G88QnbZ36FCyyTJ2ZfcHbffJ0GQh3bFvTCHaf2zR8pqVCi1LDB7+CL+El3nvKWgdu/iFQUyD78uJpeXN9987OemXcoF9Er8/LcElZsIfVhfRwVbjccuVRaIeehvTxYRLMWVEzcR/o4e4FldKcOVc9poTQwNp/jgyZ0HfEL8IsrNXDvJ7XIhkevcrwbqRj7kuwVCvuTW66hAIBhvfRIOpa3dfb6FLbY8YbDNh5d8jNlav9LNBhDjbZeXTuTf8PG1Rosp0LWh8hbbamrA77AxkORqOVq7tTqVoj4mQgrjouT6rGBIN4qYXzHUwO4LQxsNf+BJ09t6EfH+ysIufgj77LIZqcfVV+WVqIMB57vcvkp1AQQZ6mvkBdKGgK7F2LbCGmXi/3jDxfkSb6BPFgvpMWezYAqEUoFTQNnMxHT81ydY=
Content-ID: <547A0314023A5340818D48E18E9DA700@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e748266-6013-44cb-2451-08d6f02f765a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 18:46:36.2740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4701
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

On Thu, Jun 13, 2019 at 11:43:05AM +0200, Christoph Hellwig wrote:
> This code is a trivial wrapper around device model helpers, which
> should have been integrated into the driver device model usage from
> the start.  Assuming it actually had users, which it never had since
> the code was added more than 1 1/2 years ago.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/hmm.h | 20 ------------
>  mm/hmm.c            | 80 ---------------------------------------------
>  2 files changed, 100 deletions(-)

I haven't looked in detail at this device memory stuff.. But I did
check a bit through the mailing list archives for some clue what this
was supposed to be for (wow, this is from 2016!)

The commit that added this says:
  This introduce a dummy HMM device class so device driver can use it to
  create hmm_device for the sole purpose of registering device memory.

Which I just can't understand at all. 

If we need a 'struct device' for some 'device memory' purpose then it
probably ought to be the 'struct pci_device' holding the BAR, not a
fake device.

I also can't comprehend why a supposed fake device would need a
chardev, with a stanadrd 'hmm_deviceX' name, without also defining a
core kernel ABI for that char dev..

If this comes back it needs a proper explanation and review, with a
user.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
