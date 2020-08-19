Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A18E249369
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 05:24:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5AE74134D2781;
	Tue, 18 Aug 2020 20:23:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.92.47; helo=nam10-bn7-obe.outbound.protection.outlook.com; envelope-from=qiang.zhang@windriver.com; receiver=<UNKNOWN> 
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 920E0134CE8D7
	for <linux-nvdimm@lists.01.org>; Tue, 18 Aug 2020 20:23:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gm1ionFQRq3/ezlNxrotL1h0PIy57E+JY2uxcAeZw0biPd0k9XiWZqUT1u0TrtdxNx7lmgOo5+jNHK1BjhorLHZhENSBTT0bx5jcwRWTPuktyyvZ3tv69eHy6NqsMkKqv+J644MV5JJEFrPCTQyVq5tlPp/MHzvHv85L0S4nl/2VOEuIpdLrdfhtGNrXSc87UJqrhYUpMK7EFapBenr7+yEihesbP+y0NczVLJqx49vdI6lG3Y3//tlT38T2oL+eh/tIY85ruopn98gD+1VBVxxFaWQyJfqJ7CXz9NB6r89AHbEhxo75MdSM1tU54hE/7HG7WyhcyF0l5960b5EsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wj3ktnfkaE/zES+RSgPwDyQ8mhOTu7xXCT0aIGkFCfY=;
 b=aQzRT/XXAEbhF/bjrFGt00WQSKbFUd/i1pjivc4w6y483ookZ9xu046GzNffZ+XlIeMNlbZEKsF6d0AXD+eejEIjfddMbW8Ws/WK72WYZ0HXmDjyAACavVlwFsHnpp4lAcexdJolUU0DVu5cXZcnNAvZ88bJP7JT5Vm2kPA1vnALlXC8bKftj5oUwBaDgXG6Od0O9H7y+0H/ZzYsKU56bu5mW+bnIW1PPqT1OEp1WXfmXLanheJJGHdx1TsKk+kMQgpmEJRaFxcK+UIk+PCF65r1VIwd5NYtlkInxojZo2fybkWtPYeWGHfblBQk4ArHEmswtFPkTOJ48sdLEOOwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wj3ktnfkaE/zES+RSgPwDyQ8mhOTu7xXCT0aIGkFCfY=;
 b=RyM+LpnNBTOapNqc5mDH/epreEC1PEe7oc9YGitq/Tl4ZJKy7p0Birw8W9umQjuubLdadVYb0c+wRhO4Wsb1VIikDPz55cPuZ53lwTo9VsH8qPkNDH6G3ljYBBDGfWAqga84WaHBJZOy/19rmZEdH/X4bMIaVF5Rtp2MGrRJ26w=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2807.namprd11.prod.outlook.com (2603:10b6:a02:c3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 19 Aug
 2020 03:23:53 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b%7]) with mapi id 15.20.3305.024; Wed, 19 Aug 2020
 03:23:53 +0000
From: "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: 
 =?gb2312?B?u9i4tDogW1BBVENIIHYyXSBsaWJudmRpbW06IEtBU0FOOiBnbG9iYWwtb3V0?=
 =?gb2312?B?LW9mLWJvdW5kcyBSZWFkIGluIGludGVybmFsX2NyZWF0ZV9ncm91cA==?=
Thread-Topic: [PATCH v2] libnvdimm: KASAN: global-out-of-bounds Read in
 internal_create_group
Thread-Index: AQHWcIZ759O455Me90qyS7wcmU/yCKk+zxcs
Date: Wed, 19 Aug 2020 03:23:53 +0000
Message-ID: 
 <BYAPR11MB26327E2CF93B199DFDA4BCD4FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200812085501.30963-1-qiang.zhang@windriver.com>
In-Reply-To: <20200812085501.30963-1-qiang.zhang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2efac0b5-453d-4560-de08-08d843ef4c7b
x-ms-traffictypediagnostic: BYAPR11MB2807:
x-microsoft-antispam-prvs: 
 <BYAPR11MB2807808ED945966378CC092EFF5D0@BYAPR11MB2807.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4VQkvVhvAppgxNkyNtEWthhDny1QO/cL40UBnuNWLlUadEqcmdDMzGy42kjQzzVB2MLZGseiZmKhl4BkgvlT2TIcCDDPSrKNi7bbRFcqJmllTPJB5G56Cof09dLC/j+S1M5lG9JkL+yDz3HUZI8UTvJLWK3T5Y7oRCP6yFevcjYqlY8cxN7j4/qzu5CEbuzfesgJNALGhOZYTUaEBoITwCILc3UUaX/jt/FxYlwQj38/jgfBdePlf+uvLLxVChvMem6FGPJNL18r7uckGfjeXlBitZnQ/WeQgzh+tyWHAIziKBMzTa/lr7ByJm0m7lL3V/gIJ8rgnA8oq6QjWxLyJQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39840400004)(366004)(136003)(7696005)(8936002)(54906003)(4326008)(33656002)(9686003)(71200400001)(55016002)(224303003)(83380400001)(186003)(2906002)(66476007)(86362001)(26005)(66946007)(52536014)(478600001)(316002)(66556008)(64756008)(6506007)(91956017)(5660300002)(110136005)(76116006)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 XlCKAUbNexF7xOxjXfqzZBejUAimNBCYwX2UVvJcsJNskA+/skJzFlYbnsDFY5QfsBrTtK2Yms0YnY506CTMs9Gs7icNuNc8DgStU2lN/bG9+GF0RqS0iWwSWkbrKFQKCLRCq21Aqepl6SCUAZy3XBnsKo4hF4/qR+iv15tOZftg3jr6/X9aMiH304RO72jJpV0JN5NrJ7Oz9C0DXiJsn1OL+rFdGWrsrJXwy8bwTQC8ITTm2W7VXbiBC00gBk8cNfilY/5O0GUKRjUBjJxHpJOB8vPuowiJLhMCjQOmea0Sfo2BLgjXck9vZZbR+fnXLSAVZLFn4zYLJUiyrkimUl4XbAdNPfx+1fL7+9tLBHP3DYQZLfuwO0RTV/IQt1G2kb4hlFCLFTRU3VxqWEc8O3soony/cr42OdVGjNEo+nYzZAQAxLzQ4UbY+XLS+N1/PB1lK0/2oP9VpQMRwTjYYj3J/skZDHdhXcythwa9nLP7qyHbmvG5YQzNmXTFxnbl09JTII9XMe+MRjv6n9i6Vn2FRcUXGTUIY9lEvb53aMrb1yQ7v1HJHvd6nubappps3HKD1np1KA47PxYpEuGm33HQBFC9agXAwFAulxgKc14zsgWJZezixixtz4iFJEcSemgHOMw05Bmbi/7VjA+JIw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efac0b5-453d-4560-de08-08d843ef4c7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 03:23:53.1136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xDHXP4JM0JRfDmrikLpN3BEm1b4/lo08zy0JX5QGa2mLVbRwtNFfa1rinhB7EFSWHJKYDZ0fDtrQd3WFhkXLXiB8yP61js9o6FqYUfSBkho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2807
Message-ID-Hash: DWCGNGT76VG4TMVUXOPPAMPOYLQRINYI
X-Message-ID-Hash: DWCGNGT76VG4TMVUXOPPAMPOYLQRINYI
X-MailFrom: Qiang.Zhang@windriver.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RQELOJB4QF2IDUCVOCOLW73NEST2WTF4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

Y2M6IERhbiBXaWxsaWFtcw0KUGxlYXNlIHJldmlldy4NCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBsaW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJu
ZWwub3JnIDxsaW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnPiC0+rHtIHFpYW5nLnpo
YW5nQHdpbmRyaXZlci5jb20gPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+DQq3osvNyrG85Dog
MjAyMMTqONTCMTLI1SAxNjo1NQ0KytW8/sjLOiBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IHZp
c2hhbC5sLnZlcm1hQGludGVsLmNvbTsgZGF2ZS5qaWFuZ0BpbnRlbC5jb207IGlyYS53ZWlueUBp
bnRlbC5jb20NCrOty806IGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCtb3zOI6IFtQQVRDSCB2Ml0gbGlibnZkaW1tOiBLQVNBTjogZ2xvYmFs
LW91dC1vZi1ib3VuZHMgUmVhZCBpbiBpbnRlcm5hbF9jcmVhdGVfZ3JvdXANCg0KRnJvbTogWnFp
YW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tPg0KDQpCZWNhdXNlIHRoZSBsYXN0IG1lbWJl
ciBvZiB0aGUgIm52ZGltbV9maXJtd2FyZV9hdHRyaWJ1dGVzIiBhcnJheQ0Kd2FzIG5vdCBhc3Np
Z25lZCBhIG51bGwgcHRyLCB3aGVuIHRyYXZlcnNhbCBvZiAiZ3JwLT5hdHRycyIgYXJyYXkNCmlz
IG91dCBvZiBib3VuZHMgaW4gImNyZWF0ZV9maWxlcyIgZnVuYy4NCg0KZnVuYzoNCiAgICAgICAg
Y3JlYXRlX2ZpbGVzOg0KICAgICAgICAgICAgICAgIC0+Zm9yIChpID0gMCwgYXR0ciA9IGdycC0+
YXR0cnM7ICphdHRyICYmICFlcnJvcjsgaSsrLCBhdHRyKyspDQogICAgICAgICAgICAgICAgICAg
ICAgICAtPi4uLi4NCg0KQlVHOiBLQVNBTjogZ2xvYmFsLW91dC1vZi1ib3VuZHMgaW4gY3JlYXRl
X2ZpbGVzIGZzL3N5c2ZzL2dyb3VwLmM6NDMgW2lubGluZV0NCkJVRzogS0FTQU46IGdsb2JhbC1v
dXQtb2YtYm91bmRzIGluIGludGVybmFsX2NyZWF0ZV9ncm91cCsweDlkOC8weGIyMA0KZnMvc3lz
ZnMvZ3JvdXAuYzoxNDkNClJlYWQgb2Ygc2l6ZSA4IGF0IGFkZHIgZmZmZmZmZmY4YTJlNGNmMCBi
eSB0YXNrIGt3b3JrZXIvdTE3OjEwLzk1OQ0KDQpDUFU6IDIgUElEOiA5NTkgQ29tbToga3dvcmtl
ci91MTc6MTAgTm90IHRhaW50ZWQgNS44LjAtc3l6a2FsbGVyICMwDQpIYXJkd2FyZSBuYW1lOiBR
RU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwNCkJJT1MgcmVsLTEuMTIuMC01OS1n
YzliYTUyNzZlMzIxLXByZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQNCldvcmtxdWV1ZTogZXZl
bnRzX3VuYm91bmQgYXN5bmNfcnVuX2VudHJ5X2ZuDQpDYWxsIFRyYWNlOg0KIF9fZHVtcF9zdGFj
ayBsaWIvZHVtcF9zdGFjay5jOjc3IFtpbmxpbmVdDQogZHVtcF9zdGFjaysweDE4Zi8weDIwZCBs
aWIvZHVtcF9zdGFjay5jOjExOA0KIHByaW50X2FkZHJlc3NfZGVzY3JpcHRpb24uY29uc3Rwcm9w
LjAuY29sZCsweDUvMHg0OTcgbW0va2FzYW4vcmVwb3J0LmM6MzgzDQogX19rYXNhbl9yZXBvcnQg
bW0va2FzYW4vcmVwb3J0LmM6NTEzIFtpbmxpbmVdDQoga2FzYW5fcmVwb3J0LmNvbGQrMHgxZi8w
eDM3IG1tL2thc2FuL3JlcG9ydC5jOjUzMA0KIGNyZWF0ZV9maWxlcyBmcy9zeXNmcy9ncm91cC5j
OjQzIFtpbmxpbmVdDQogaW50ZXJuYWxfY3JlYXRlX2dyb3VwKzB4OWQ4LzB4YjIwIGZzL3N5c2Zz
L2dyb3VwLmM6MTQ5DQogaW50ZXJuYWxfY3JlYXRlX2dyb3Vwcy5wYXJ0LjArMHg5MC8weDE0MCBm
cy9zeXNmcy9ncm91cC5jOjE4OQ0KIGludGVybmFsX2NyZWF0ZV9ncm91cHMgZnMvc3lzZnMvZ3Jv
dXAuYzoxODUgW2lubGluZV0NCiBzeXNmc19jcmVhdGVfZ3JvdXBzKzB4MjUvMHg1MCBmcy9zeXNm
cy9ncm91cC5jOjIxNQ0KIGRldmljZV9hZGRfZ3JvdXBzIGRyaXZlcnMvYmFzZS9jb3JlLmM6MjAy
NCBbaW5saW5lXQ0KIGRldmljZV9hZGRfYXR0cnMgZHJpdmVycy9iYXNlL2NvcmUuYzoyMTc4IFtp
bmxpbmVdDQogZGV2aWNlX2FkZCsweDdmZC8weDFjNDAgZHJpdmVycy9iYXNlL2NvcmUuYzoyODgx
DQogbmRfYXN5bmNfZGV2aWNlX3JlZ2lzdGVyKzB4MTIvMHg4MCBkcml2ZXJzL252ZGltbS9idXMu
Yzo1MDYNCiBhc3luY19ydW5fZW50cnlfZm4rMHgxMjEvMHg1MzAga2VybmVsL2FzeW5jLmM6MTIz
DQogcHJvY2Vzc19vbmVfd29yaysweDk0Yy8weDE2NzAga2VybmVsL3dvcmtxdWV1ZS5jOjIyNjkN
CiB3b3JrZXJfdGhyZWFkKzB4NjRjLzB4MTEyMCBrZXJuZWwvd29ya3F1ZXVlLmM6MjQxNQ0KIGt0
aHJlYWQrMHgzYjUvMHg0YTAga2VybmVsL2t0aHJlYWQuYzoyOTINCiByZXRfZnJvbV9mb3JrKzB4
MWYvMHgzMCBhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjI5NA0KDQpUaGUgYnVnZ3kgYWRkcmVz
cyBiZWxvbmdzIHRvIHRoZSB2YXJpYWJsZToNCiBudmRpbW1fZmlybXdhcmVfYXR0cmlidXRlcysw
eDEwLzB4NDANCg0KUmVwb3J0ZWQtYnk6IHN5emJvdCsxY2YwZmZlNjFhZWNmNDZmNTg4ZkBzeXpr
YWxsZXIuYXBwc3BvdG1haWwuY29tDQpTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nLnpoYW5n
QHdpbmRyaXZlci5jb20+DQotLS0NCiB2MS0+djI6DQogTW9kaWZ5IHRoZSBkZXNjcmlwdGlvbiBv
ZiB0aGUgZXJyb3IuDQoNCiBkcml2ZXJzL252ZGltbS9kaW1tX2RldnMuYyB8IDEgKw0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udmRpbW0v
ZGltbV9kZXZzLmMgYi9kcml2ZXJzL252ZGltbS9kaW1tX2RldnMuYw0KaW5kZXggNjEzNzRkZWY1
MTU1Li5iNTkwMzJlMDg1OWIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252ZGltbS9kaW1tX2RldnMu
Yw0KKysrIGIvZHJpdmVycy9udmRpbW0vZGltbV9kZXZzLmMNCkBAIC01MjksNiArNTI5LDcgQEAg
c3RhdGljIERFVklDRV9BVFRSX0FETUlOX1JXKGFjdGl2YXRlKTsNCiBzdGF0aWMgc3RydWN0IGF0
dHJpYnV0ZSAqbnZkaW1tX2Zpcm13YXJlX2F0dHJpYnV0ZXNbXSA9IHsNCiAgICAgICAgJmRldl9h
dHRyX2FjdGl2YXRlLmF0dHIsDQogICAgICAgICZkZXZfYXR0cl9yZXN1bHQuYXR0ciwNCisgICAg
ICAgTlVMTCwNCiB9Ow0KDQogc3RhdGljIHVtb2RlX3QgbnZkaW1tX2Zpcm13YXJlX3Zpc2libGUo
c3RydWN0IGtvYmplY3QgKmtvYmosIHN0cnVjdCBhdHRyaWJ1dGUgKmEsIGludCBuKQ0KLS0NCjIu
MTcuMQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8g
dW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEu
b3JnCg==
