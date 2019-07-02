Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9175D660
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Jul 2019 20:42:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CC949212ABF79;
	Tue,  2 Jul 2019 11:42:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.2.57; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20057.outbound.protection.outlook.com [40.107.2.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 035992128D698
 for <linux-nvdimm@lists.01.org>; Tue,  2 Jul 2019 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+FoI6vpCgiLSBqPMjFHBUD4fTkpXFG2F39LPBhxl74=;
 b=I9ohJ6GNRLW+Zm+ooghClKVijPw+7yhdPymyZ9UYfnb4h8l6cgxmEgeOCdNbseE8x/L9Ge3wh5JFWVDJkBobwtg4AMDNxisbgOSckJW6DEFsDhCpj4Vvnc0r7ERyJeLyh4zmpM5zcIi36u7IFgX/RRdLh9hX6jYVNuPMYsv81uA=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5855.eurprd05.prod.outlook.com (20.178.125.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 18:42:07 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 18:42:07 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: dev_pagemap related cleanups v4
Thread-Topic: dev_pagemap related cleanups v4
Thread-Index: AQHVL9UU5cGGdRKLlkyPcV6XfRMxZaa1bVyAgAI+pYA=
Date: Tue, 2 Jul 2019 18:42:07 +0000
Message-ID: <20190702184201.GO31718@mellanox.com>
References: <20190701062020.19239-1-hch@lst.de> <20190701082517.GA22461@lst.de>
In-Reply-To: <20190701082517.GA22461@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: QB1PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::33) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3e918f6-e7b1-45d3-220d-08d6ff1cfc06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB5855; 
x-ms-traffictypediagnostic: VI1PR05MB5855:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB5855D9FC2C87AE8EDF4F3360CFF80@VI1PR05MB5855.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(189003)(199004)(36756003)(305945005)(7736002)(6246003)(2906002)(54906003)(64756008)(81156014)(8676002)(8936002)(86362001)(81166006)(53936002)(316002)(6916009)(68736007)(478600001)(7416002)(3846002)(229853002)(5660300002)(6486002)(66066001)(102836004)(6506007)(66446008)(6512007)(14444005)(26005)(4326008)(25786009)(99286004)(186003)(33656002)(14454004)(486006)(446003)(476003)(6116002)(256004)(6306002)(11346002)(1076003)(6436002)(66476007)(76176011)(73956011)(966005)(52116002)(71200400001)(66946007)(386003)(66556008)(71190400001)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB5855;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uxvz6FxwQNsbgdBscCEIRaUYaJ9Hx5UYarazHW+5NehM9eLqQYvVoI1KKwDxw/TefzXSdN5/4xxaq2D7Tani/hQ3Ba46KvDWFZX1MzCawz6jHovyW1WbVATRJPe/6oCfFCi3u7vgRuAnaIKDN7CqC0ljSMhNokZQnmPfYTlZjMpHjSkEb/fv3JDQ1CElySfqAL/l4SpYJpExh8oDwUQRFHHntindvjHxrlA3vnEVyvFJ3u9/MyorpuyISuMH3O9fpPEFzvbkZ+C/6mcbz2FnOogmpZQUZXV8McdcqbNVN5fOXX29ykI848fp6PhT8GI+2FA8t3lq6/klVApz+1NqJaUYSLnxp43VAin0GArLmHF+KBQlgy2AbPkodq7v9nnCYT3QUUxkXF0uDyCQgO7rpgim7bFHYuOpyFu69U5lnyA=
Content-ID: <ADE83ECAC2BC474EA837455494A5DDBE@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e918f6-e7b1-45d3-220d-08d6ff1cfc06
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 18:42:07.4459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5855
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

On Mon, Jul 01, 2019 at 10:25:17AM +0200, Christoph Hellwig wrote:
> And I've demonstrated that I can't send patch series..  While this
> has all the right patches, it also has the extra patches already
> in the hmm tree, and four extra patches I wanted to send once
> this series is merged.  I'll give up for now, please use the git
> url for anything serious, as it contains the right thing.

Okay, I sorted it all out and temporarily put it here:

https://github.com/jgunthorpe/linux/commits/hmm

Bit involved job:
- Took Ira's v4 patch into hmm.git and confirmed it matches what
  Andrew has in linux-next after all the fixups
- Checked your github v4 and the v3 that hit the mailing list were
  substantially similar (I never did get a clean v4) and largely
  went with the github version
- Based CH's v4 series on -rc7 and put back the removal hunk in swap.c
  so it compiles
- Merge'd CH's series to hmm.git and fixed all the conflicts with Ira
  and Ralph's patches (such that swap.c remains unchanged)
- Added Dan's ack's and tested-by's

I think this fairly closely follows what was posted to the mailing
list.

As it was more than a simple 'git am', I'll let it sit on github until
I hear OK's then I'll move it to kernel.org's hmm.git and it will hit
linux-next. 0-day should also run on this whole thing from my github.

What I know is outstanding:
 - The conflicting ARM patches, I understand Andrew will handle these
   post-linux-next
 - The conflict with AMD GPU in -next, I am waiting to hear from AMD

Otherwise I think we are done with hmm.git for this
cycle.

Unfortunately this is still not enough to progress rdma's ODP, so we
will need to do this again next cycle :( I'll be working on patches
once I get all the merge window prep I have to do done.

Regards,
Jason
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
