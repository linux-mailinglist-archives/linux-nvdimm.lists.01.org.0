Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1352493CA
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 06:20:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D0BAB134D4B9D;
	Tue, 18 Aug 2020 21:20:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6236B134D4B9B
	for <linux-nvdimm@lists.01.org>; Tue, 18 Aug 2020 21:20:34 -0700 (PDT)
IronPort-SDR: D3W28ts4QK8GRMgUiej2UbR8FoVYIETN7cSTSCujy9rQTf+9UFGYOsH2CC7ft2EOPG/65UMqZa
 QYR2Nb/Qt0Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="216569418"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600";
   d="scan'208";a="216569418"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 21:20:33 -0700
IronPort-SDR: bdXWH4P5wHcO7sptmVgfUcQXsktf4BLD7MQhLAemY60XM8C9RbHzWzoatEN20h72tA/FmMBchL
 W+gLQm2wixvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600";
   d="scan'208";a="279591386"
Received: from unknown (HELO fmsmsx605.amr.corp.intel.com) ([10.18.84.215])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2020 21:20:33 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 18 Aug 2020 21:20:33 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 18 Aug 2020 21:20:33 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Aug 2020 21:20:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 18 Aug 2020 21:20:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbjWXTLFbbDVb8e25Nv2oWwTtR2+9gdCqltPDs5YWR7shpRymaSwrUONHlBTkFlPv7VD7cGIIMA9wahcmgXilAVmxfk36WAas0tTK97id+rADJmJ6PGO7pJDrL0YQywKb7IWS4QeOewmax/6gvXMJLzPg99jfBUEXP6QgwMrL/LcohnR/pKLq56Qz2nez7DImBbd5Tiai244sBS593jxIeJfFI32U8cLwAJeTDfE6IO0UgUB7+My+Vo1ykrFWpXbDVN61K+07c+Iqgs38DYD632QyMg12LzRiOK+CzW1JYklO6Hr1xTf533Eh2tUIpv/vrXS86ZXHM13P5A4QbY4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEtZSaps3C4Vj7ykCGhaxEk+FE7JEpqfd3aJACEFCq4=;
 b=C3IB0lNcT4qsy5RB2gjbpCpBNufyH1H8IgfYNf9+7FM0xZNSjTFV/4dIBw0nJTRM86rWyon3q46gW3w9vPQpGXpHwwshnVivUtSu8QtQbEhYhaSg4U4J5eOHSJV3+A244/zfKIfebrdgrvcM63czsOOJzr5D0jN4PBOkYQ4Ull+uSBjuUXmz91Yyfgk2ECXZG+fahED8dFcOcHZX9PhL6n7+O892zNDGJCVF81NiLNRF6ZzjsvH/EBgZAMi0RGqRf0LhpnsXoAriC2e3uQNwzAJ9TrX9HyBUeWigv59jkH6RXehEPqx0zcV8Ez9yJ5vdCXYzv9UY82gajJtbVMxDDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEtZSaps3C4Vj7ykCGhaxEk+FE7JEpqfd3aJACEFCq4=;
 b=yBG4sprC8ltjZzi53Dw3+fA2aRk71tdbDzz5VM6LcCjoxGFU3l5HhRsYoMNhJf0O590cSdPY/KaEm86VorIJUquPA63vP5+eDqRjLzgclFw/7kkg04KAe7nNc1OWv7sSOeDjb+TBsFNeDB6Kwkq4OUN/YiGMEsIk6m9+GRMItH8=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2805.namprd11.prod.outlook.com (2603:10b6:a02:c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Wed, 19 Aug
 2020 04:20:20 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::1084:a79c:5a4f:f115]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::1084:a79c:5a4f:f115%5]) with mapi id 15.20.3283.027; Wed, 19 Aug 2020
 04:20:20 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "Qiang.Zhang@windriver.com"
	<Qiang.Zhang@windriver.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Weiny,
 Ira" <ira.weiny@intel.com>
Subject: =?utf-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyXSBsaWJudmRpbW06IEtBU0FOOiBnbG9i?=
 =?utf-8?B?YWwtb3V0LW9mLWJvdW5kcyBSZWFkIGluIGludGVybmFsX2NyZWF0ZV9ncm91?=
 =?utf-8?Q?p?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIGxpYm52ZGltbTogS0FTQU46IGdsb2JhbC1v?=
 =?utf-8?B?dXQtb2YtYm91bmRzIFJlYWQgaW4gaW50ZXJuYWxfY3JlYXRlX2dyb3Vw?=
Thread-Index: AQHWcIZsoQCJrvBQ/kasdBHIemlBZKk+z0aAgAAPxAA=
Date: Wed, 19 Aug 2020 04:20:19 +0000
Message-ID: <3381c99088f1f8d5b96d7f6a289ab598927b9759.camel@intel.com>
References: <20200812085501.30963-1-qiang.zhang@windriver.com>
	 <BYAPR11MB26327E2CF93B199DFDA4BCD4FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB26327E2CF93B199DFDA4BCD4FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3f54281-2780-4561-c1a4-08d843f72f44
x-ms-traffictypediagnostic: BYAPR11MB2805:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB280565DFAA786F4689BBD563C75D0@BYAPR11MB2805.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tj6EGitOzoIlJr/17qx3A55h2+CjamYyjTRDUGEK8lajNxJ04N8qSCAnMZFLIqG9peo+SnIsKX8uLNjUhXcGRwNtfz56b1+2gZiJ18Xrv+vaKbj2vRD9u6teMQrsWjO9mmwjTHCJ4VBdk6nIUE5Ivbrk1IhbNCzbQN8MuQm3bCgjusY0OpeqD02iRn2ZM1sKXYg2C8/Et/N8EcRGqrWGaiBirDjBOLa256NYJe/Faf0f913NmxutDv3nYR2J+exQD/g430UFlBNYCQes6un4Azn2auiWuWTWdvpNRpAWLFXJWqmoIBMxNLo3KzdlFBPUDxkFJ1x6G449u4enNy8ohg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(71200400001)(186003)(76116006)(54906003)(66446008)(2616005)(2906002)(4326008)(26005)(86362001)(66476007)(5660300002)(66946007)(91956017)(6506007)(8936002)(66556008)(64756008)(6486002)(6512007)(478600001)(316002)(36756003)(224303003)(6636002)(83380400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mQeR5goHwtnjLVS7CSUwNX1VPNf9Cuqb3JZqVBXShMoTb+k4knuA3Q0fNvB0VFp9J2osurujwzg59dAmSZs88rxqlMuKcG7/TRjheR8FoTjkN1lYtCEtn/ZDrG/EmqG3UvdSqQqqSPhbgUu2UFcugT3d3zn1/yrffzCGTaXfTWMb22NHDG7citDV9HMbRIIAEUQ8UlpEXnBYqmk7BENsdRnSVW05Wvrp3kzIbFvAi5M+vXdqAqrA2eX1NjZ5+oVKDuMSJes4eh+dZj1fB5HzhjqSsynC8AFXxwFAlsJej4AIXZlUnjLyYiahfXg/tIPDsHCTQQgQnMOyT2Nd/MompGSPUcsM//049kZrhaJDmsf4EdCpgirNBpeeBu0QJoreFEztNh7L0N8M3UWLP+sCDtphzExM4t9X4YGM5ApFrVL4KwIPQCYsHqrEUeoCvOztRf1e4bWVDxh62/ehhFOX5Qybs2s/6ynL5sWBZwbJ6oYzt+J/nS0ejy/dLhzLdTtHQlsWZwxw3LO+Y8Cd2m+2TQFxOGTo41t74nNTq+AwP2eqARBvG2tYI+sT1qiH3yf0cL/RLfgvwvy+XmVDJ/LxJ+I8AjQC3RJt6BFUnIKLJGutLgy6Sr4WIO9zloC68jOqC//Cmel6KBWat6YuilpSiA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF44646AA8C8C843A00F24DE2F6B4730@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f54281-2780-4561-c1a4-08d843f72f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 04:20:19.9654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obweMsthiCDbBs3FNHzWadEvwb6JDq4p8GclArGscxKVneoPogfVFm1lsYEdIOL/Kf+P7WDloSBiQY5OT+X/Z3SveFxALE8D9zAuLOxnV6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2805
X-OriginatorOrg: intel.com
Message-ID-Hash: 67NF72JBWH6IP4OL7PEUMIQVR7HFZNFF
X-Message-ID-Hash: 67NF72JBWH6IP4OL7PEUMIQVR7HFZNFF
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/67NF72JBWH6IP4OL7PEUMIQVR7HFZNFF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

T24gV2VkLCAyMDIwLTA4LTE5IGF0IDAzOjIzICswMDAwLCBaaGFuZywgUWlhbmcgd3JvdGU6DQo+
IGNjOiBEYW4gV2lsbGlhbXMNCj4gUGxlYXNlIHJldmlldy4NCg0KSGkgUWlhbmcsDQoNCkkndmUg
Z290IHRoaXMgcXVldWVkIHVwLCBJJ2xsIHN1Ym1pdCBpdCBmb3IgLXJjMi4NCg0KVGhhbmtzLA0K
LVZpc2hhbA0KDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+IOWPkeS7tuS6ujogbGludXgta2VybmVsLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgt
a2VybmVsLW93bmVyQHZnZXIua2VybmVsLm9yZz4g5Luj6KGoIHFpYW5nLnpoYW5nQHdpbmRyaXZl
ci5jb20gPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+DQo+IOWPkemAgeaXtumXtDogMjAyMOW5
tDjmnIgxMuaXpSAxNjo1NQ0KPiDmlLbku7bkuro6IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsg
dmlzaGFsLmwudmVybWFAaW50ZWwuY29tOyBkYXZlLmppYW5nQGludGVsLmNvbTsgaXJhLndlaW55
QGludGVsLmNvbQ0KPiDmioTpgIE6IGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g5Li76aKYOiBbUEFUQ0ggdjJdIGxpYm52ZGltbTogS0FT
QU46IGdsb2JhbC1vdXQtb2YtYm91bmRzIFJlYWQgaW4gaW50ZXJuYWxfY3JlYXRlX2dyb3VwDQo+
IA0KPiBGcm9tOiBacWlhbmcgPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+DQo+IA0KPiBCZWNh
dXNlIHRoZSBsYXN0IG1lbWJlciBvZiB0aGUgIm52ZGltbV9maXJtd2FyZV9hdHRyaWJ1dGVzIiBh
cnJheQ0KPiB3YXMgbm90IGFzc2lnbmVkIGEgbnVsbCBwdHIsIHdoZW4gdHJhdmVyc2FsIG9mICJn
cnAtPmF0dHJzIiBhcnJheQ0KPiBpcyBvdXQgb2YgYm91bmRzIGluICJjcmVhdGVfZmlsZXMiIGZ1
bmMuDQo+IA0KPiBmdW5jOg0KPiAgICAgICAgIGNyZWF0ZV9maWxlczoNCj4gICAgICAgICAgICAg
ICAgIC0+Zm9yIChpID0gMCwgYXR0ciA9IGdycC0+YXR0cnM7ICphdHRyICYmICFlcnJvcjsgaSsr
LCBhdHRyKyspDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIC0+Li4uLg0KPiANCj4gQlVHOiBL
QVNBTjogZ2xvYmFsLW91dC1vZi1ib3VuZHMgaW4gY3JlYXRlX2ZpbGVzIGZzL3N5c2ZzL2dyb3Vw
LmM6NDMgW2lubGluZV0NCj4gQlVHOiBLQVNBTjogZ2xvYmFsLW91dC1vZi1ib3VuZHMgaW4gaW50
ZXJuYWxfY3JlYXRlX2dyb3VwKzB4OWQ4LzB4YjIwDQo+IGZzL3N5c2ZzL2dyb3VwLmM6MTQ5DQo+
IFJlYWQgb2Ygc2l6ZSA4IGF0IGFkZHIgZmZmZmZmZmY4YTJlNGNmMCBieSB0YXNrIGt3b3JrZXIv
dTE3OjEwLzk1OQ0KPiANCj4gQ1BVOiAyIFBJRDogOTU5IENvbW06IGt3b3JrZXIvdTE3OjEwIE5v
dCB0YWludGVkIDUuOC4wLXN5emthbGxlciAjMA0KPiBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5k
YXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwNCj4gQklPUyByZWwtMS4xMi4wLTU5LWdjOWJhNTI3
NmUzMjEtcHJlYnVpbHQucWVtdS5vcmcgMDQvMDEvMjAxNA0KPiBXb3JrcXVldWU6IGV2ZW50c191
bmJvdW5kIGFzeW5jX3J1bl9lbnRyeV9mbg0KPiBDYWxsIFRyYWNlOg0KPiAgX19kdW1wX3N0YWNr
IGxpYi9kdW1wX3N0YWNrLmM6NzcgW2lubGluZV0NCj4gIGR1bXBfc3RhY2srMHgxOGYvMHgyMGQg
bGliL2R1bXBfc3RhY2suYzoxMTgNCj4gIHByaW50X2FkZHJlc3NfZGVzY3JpcHRpb24uY29uc3Rw
cm9wLjAuY29sZCsweDUvMHg0OTcgbW0va2FzYW4vcmVwb3J0LmM6MzgzDQo+ICBfX2thc2FuX3Jl
cG9ydCBtbS9rYXNhbi9yZXBvcnQuYzo1MTMgW2lubGluZV0NCj4gIGthc2FuX3JlcG9ydC5jb2xk
KzB4MWYvMHgzNyBtbS9rYXNhbi9yZXBvcnQuYzo1MzANCj4gIGNyZWF0ZV9maWxlcyBmcy9zeXNm
cy9ncm91cC5jOjQzIFtpbmxpbmVdDQo+ICBpbnRlcm5hbF9jcmVhdGVfZ3JvdXArMHg5ZDgvMHhi
MjAgZnMvc3lzZnMvZ3JvdXAuYzoxNDkNCj4gIGludGVybmFsX2NyZWF0ZV9ncm91cHMucGFydC4w
KzB4OTAvMHgxNDAgZnMvc3lzZnMvZ3JvdXAuYzoxODkNCj4gIGludGVybmFsX2NyZWF0ZV9ncm91
cHMgZnMvc3lzZnMvZ3JvdXAuYzoxODUgW2lubGluZV0NCj4gIHN5c2ZzX2NyZWF0ZV9ncm91cHMr
MHgyNS8weDUwIGZzL3N5c2ZzL2dyb3VwLmM6MjE1DQo+ICBkZXZpY2VfYWRkX2dyb3VwcyBkcml2
ZXJzL2Jhc2UvY29yZS5jOjIwMjQgW2lubGluZV0NCj4gIGRldmljZV9hZGRfYXR0cnMgZHJpdmVy
cy9iYXNlL2NvcmUuYzoyMTc4IFtpbmxpbmVdDQo+ICBkZXZpY2VfYWRkKzB4N2ZkLzB4MWM0MCBk
cml2ZXJzL2Jhc2UvY29yZS5jOjI4ODENCj4gIG5kX2FzeW5jX2RldmljZV9yZWdpc3RlcisweDEy
LzB4ODAgZHJpdmVycy9udmRpbW0vYnVzLmM6NTA2DQo+ICBhc3luY19ydW5fZW50cnlfZm4rMHgx
MjEvMHg1MzAga2VybmVsL2FzeW5jLmM6MTIzDQo+ICBwcm9jZXNzX29uZV93b3JrKzB4OTRjLzB4
MTY3MCBrZXJuZWwvd29ya3F1ZXVlLmM6MjI2OQ0KPiAgd29ya2VyX3RocmVhZCsweDY0Yy8weDEx
MjAga2VybmVsL3dvcmtxdWV1ZS5jOjI0MTUNCj4gIGt0aHJlYWQrMHgzYjUvMHg0YTAga2VybmVs
L2t0aHJlYWQuYzoyOTINCj4gIHJldF9mcm9tX2ZvcmsrMHgxZi8weDMwIGFyY2gveDg2L2VudHJ5
L2VudHJ5XzY0LlM6Mjk0DQo+IA0KPiBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSB2
YXJpYWJsZToNCj4gIG52ZGltbV9maXJtd2FyZV9hdHRyaWJ1dGVzKzB4MTAvMHg0MA0KPiANCj4g
UmVwb3J0ZWQtYnk6IHN5emJvdCsxY2YwZmZlNjFhZWNmNDZmNTg4ZkBzeXprYWxsZXIuYXBwc3Bv
dG1haWwuY29tDQo+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVy
LmNvbT4NCj4gLS0tDQo+ICB2MS0+djI6DQo+ICBNb2RpZnkgdGhlIGRlc2NyaXB0aW9uIG9mIHRo
ZSBlcnJvci4NCj4gDQo+ICBkcml2ZXJzL252ZGltbS9kaW1tX2RldnMuYyB8IDEgKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dmRpbW0vZGltbV9kZXZzLmMgYi9kcml2ZXJzL252ZGltbS9kaW1tX2RldnMuYw0KPiBpbmRleCA2
MTM3NGRlZjUxNTUuLmI1OTAzMmUwODU5YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udmRpbW0v
ZGltbV9kZXZzLmMNCj4gKysrIGIvZHJpdmVycy9udmRpbW0vZGltbV9kZXZzLmMNCj4gQEAgLTUy
OSw2ICs1MjksNyBAQCBzdGF0aWMgREVWSUNFX0FUVFJfQURNSU5fUlcoYWN0aXZhdGUpOw0KPiAg
c3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKm52ZGltbV9maXJtd2FyZV9hdHRyaWJ1dGVzW10gPSB7
DQo+ICAgICAgICAgJmRldl9hdHRyX2FjdGl2YXRlLmF0dHIsDQo+ICAgICAgICAgJmRldl9hdHRy
X3Jlc3VsdC5hdHRyLA0KPiArICAgICAgIE5VTEwsDQo+ICB9Ow0KPiANCj4gIHN0YXRpYyB1bW9k
ZV90IG52ZGltbV9maXJtd2FyZV92aXNpYmxlKHN0cnVjdCBrb2JqZWN0ICprb2JqLCBzdHJ1Y3Qg
YXR0cmlidXRlICphLCBpbnQgbikNCj4gLS0NCj4gMi4xNy4xDQo+IA0KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eC1udmRpbW0gbWFpbGlu
ZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcNCj4gVG8gdW5zdWJzY3JpYmUgc2Vu
ZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnDQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWls
aW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5k
IGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
