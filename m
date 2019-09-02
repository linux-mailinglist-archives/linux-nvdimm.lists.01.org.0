Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7B5A4F27
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Sep 2019 08:22:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9E4282021EBDF;
	Sun,  1 Sep 2019 23:23:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.15.82; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=linux-nvdimm@lists.01.org 
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150082.outbound.protection.outlook.com [40.107.15.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B748220218C2D
 for <linux-nvdimm@lists.01.org>; Sun,  1 Sep 2019 23:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYmniCD1kZuDz4RBf5PBlf52B40289MTca0teLXJz2UfF8rbVREZcw4zHf7B5+/wyO4czgrRIQEgP78olxZdNnKg0dFBtwFimODTMwTNjUcET1cF1r1sLaaOLZed2R1jVGlk+LsQKBQxhaqtm5DbJl9V0OFozz9Gi5XfdLj520EeIq73bpiMn1GwowMc7geLvOfRodJyIaDgKuCQtmlzWng265g035qIE+xMDkBR7LiklpAg0IBcw/G/o1vATljAH1bb+5hD/0INqtxJgNwdLT49FVOF8P7TzqlByyUWnA1TfwNh+VYiDmfrdhibBBKXxtdjL2MgiGarNaulyhdB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uk9VJEOyLLARlr5saP4hK7TKKnGsfjm07ye9p+32wJo=;
 b=N+DU+wiLwi3w3tPnxMlofXmgzQTxSsuZA9+5xajLY+r6qUVBF3TKw3kx7kKGwLmrg2OCDAvOqRjOryOJ4X2CPqkb9wbz7lGFCBIGJnOfv/hVmKTvH4xmUnLf0tYRlzFecvNCdHNoLYfLMSfkROquCpXQv/rTyDC+Hbqt3eE7anGxwtqmr0KirUaizecsvw0ISaXUjloOnzJHYBd4FpLOdPRC5NuAibMQiM5oD7CJZMR/bltpRJo8fxGpBPNSA4/6Fya6CiawV9lazYfkNsMmJDKuIAMY7xjd32PptQBXXy65yI8hLkoHMKVivb/kYECYMu9aNRBvbn4HkoophGZHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uk9VJEOyLLARlr5saP4hK7TKKnGsfjm07ye9p+32wJo=;
 b=HOOh3Vgb2HRZWM5gGsAE67TXthH72LoNtfwWVOSyf3t78CIDT4zQFiettmm6+LSqM6xRPvIQgWF/ORmjWHXMLegbdDy7drvD21XJdLeRYOV/KyyT5ltL6p6eTC+f9VjXuBnezB3f45IZ2XxR8K4UEJDPH/xI2nomgy7242jyI8w=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6336.eurprd05.prod.outlook.com (20.179.25.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Mon, 2 Sep 2019 06:22:24 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2220.020; Mon, 2 Sep 2019
 06:22:24 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3] libnvdimm: Enable unit test infrastructure compile
 checks
Thread-Topic: [PATCH v3] libnvdimm: Enable unit test infrastructure compile
 checks
Thread-Index: AQHVYC9JAnNVfRxuWUOxm7Gbqx8x6qcX7S+A
Date: Mon, 2 Sep 2019 06:22:23 +0000
Message-ID: <20190902062221.GK24116@mellanox.com>
References: <156727753022.2310789.16427613406082399871.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156727753022.2310789.16427613406082399871.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0135.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::27) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a52c096-0092-44fd-91b4-08d72f6deabf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB6336; 
x-ms-traffictypediagnostic: VI1PR05MB6336:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB633689BB5E520530AA88841CCFBE0@VI1PR05MB6336.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(6506007)(71200400001)(256004)(14454004)(486006)(11346002)(478600001)(66066001)(86362001)(966005)(7736002)(476003)(186003)(33656002)(446003)(305945005)(316002)(5660300002)(2616005)(99286004)(6916009)(66446008)(2906002)(76176011)(52116002)(66946007)(53936002)(64756008)(102836004)(6512007)(6486002)(25786009)(6246003)(66556008)(386003)(36756003)(6116002)(1076003)(26005)(4326008)(81166006)(81156014)(8676002)(54906003)(3846002)(66476007)(229853002)(6436002)(71190400001)(8936002)(6306002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB6336;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RPSnRY0g3DL24bY8ASbqDsFKlkDuWZ7piSFzUQ3SPbJMSkX+0NAwACU/f4O27xRe04+ljAzikVenlI+vbWtgnzUorRLqvv+f6JGliXKdx259AKO9PO8s1jpfHaMP3drHRAYuUYmnF7Rqng+cG+o8J+dO+7S7Mruu0a/rVgK6VWL84t80rfEjYGf/DAZzorLzSkojwkVXq02ulsUyVVy/dbaz0+19ERhxEnp6EwZsdkzp5fDjyTgB8YiAVrKA4iMB8LqTrLq4UmUUH/WmmhfQpiSDdcGXSO44K38UFZ44rXXKGNWIE6e5U88hyOg4kFUxsFLNG7ZS5RK/3LZYsELSuv6GiPJxKZb5AF9JqEbjPvK0WvsyFjs2XjRLOYDShPNfMh6bOsaVFKgQYoNyTYGCb7oeUq3vyaKuj4AjlQ2Pzlo=
x-ms-exchange-transport-forked: True
Content-ID: <634D885666AECA4FA4FA998A909DB5AF@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a52c096-0092-44fd-91b4-08d72f6deabf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 06:22:23.9074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmcSH0doENba7nxLZA94UMXmJRvEily6ehfx/0LgwiVXl3AUO8PtBDji+fd20R5XF6tSMDj79cINEtouAtECRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6336
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

T24gU2F0LCBBdWcgMzEsIDIwMTkgYXQgMTE6NTI6NDdBTSAtMDcwMCwgRGFuIFdpbGxpYW1zIHdy
b3RlOg0KPiBUaGUgaW5mcmFzdHJ1Y3R1cmUgdG8gbW9jayBjb3JlIGxpYm52ZGltbSByb3V0aW5l
cyBmb3IgdW5pdCB0ZXN0aW5nDQo+IHB1cnBvc2VzIGlzIHByb25lIHRvIGJpdHJvdCByZWxhdGl2
ZSB0byByZWZhY3RvcmluZyBvZiB0aGF0IGNvcmUuDQo+IEFycmFuZ2UgZm9yIHRoZSB1bml0IHRl
c3QgY29yZSB0byBiZSBidWlsdCB3aGVuIENPTkZJR19DT01QSUxFX1RFU1Q9eS4NCj4gVGhpcyBk
b2VzIG5vdCByZXN1bHQgaW4gYSBmdW5jdGlvbmFsIHVuaXQgdGVzdCBlbnZpcm9ubWVudCwgaXQg
aXMgb25seSBhDQo+IGhlbHBlciBmb3IgMGRheSB0byBjYXRjaCB1bml0IHRlc3QgYnVpbGQgcmVn
cmVzc2lvbnMuDQo+IA0KPiBOb3RlIHRoYXQgdGhlcmUgYXJlIGEgZmV3IHg4NmlzbXMgaW4gdGhl
IGltcGxlbWVudGF0aW9uLCBzbyB0aGlzIGRvZXMNCj4gbm90IGJvdGhlciBjb21waWxlIHRlc3Rp
bmcgdGhpcyBhcmNoaXRlY3R1cmVzIG90aGVyIHRoYW4gNjQtYml0IHg4Ni4NCj4gDQo+IENjOiBK
w6lyw7RtZSBHbGlzc2UgPGpnbGlzc2VAcmVkaGF0LmNvbT4NCj4gQ2M6IEphc29uIEd1bnRob3Jw
ZSA8amdnQG1lbGxhbm94LmNvbT4NCj4gUmVwb3J0ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAbHN0LmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1z
QGludGVsLmNvbT4NCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8xNTYwOTcyMjQy
MzIuMTA4Njg0Ny45NDYzODYxOTI0NjgzMzcyNzQxLnN0Z2l0QGR3aWxsaWEyLWRlc2szLmFtci5j
b3JwLmludGVsLmNvbQ0KPiBDaGFuZ2VzIHNpbmNlIHYyOg0KPiAtIEZpeGVkIGEgMGRheSByZXBv
cnQgd2hlbiB0aGUgdW5pdCB0ZXN0IGluZnJhc3RydWN0dXJlIGlzIGJ1aWx0LWluLg0KPiAgIEFy
cmFuZ2UgZm9yIGl0IHRvIG9ubHkgY29tcGlsZSBhcyBhIG1vZHVsZS4gVGhpcyBoYXMgcmVjZWl2
ZWQgYSBidWlsZA0KPiAgIHN1Y2Nlc3Mgbm90aWZjYXRpb24gZnJvbSB0aGUgcm9ib3Qgb3ZlciAx
NDIgY29uZmlncy4NCj4gDQo+IEhpIEphc29uLA0KPiANCj4gQXMgd2UgZGlzY3Vzc2VkIHByZXZp
b3VzbHkgcGxlYXNlIHRha2UgdGhpcyB0aHJvdWdoIHRoZSBobW0gdHJlZSB0byBnaXZlDQo+IGNv
bXBpbGUgY292ZXJhZ2UgZm9yIGRldm1fbWVtcmVtYXBfcGFnZXMoKSB1cGRhdGVzLg0KDQpPa2F5
LCBhcHBsaWVkIGFnYWluIGFuZCAwLWRheSBwYXNzZWQNCg0KVGhhbmtzLA0KSmFzb24NCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBt
YWlsaW5nIGxpc3QKTGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpodHRwczovL2xpc3RzLjAxLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52ZGltbQo=
