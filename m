Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1782DEDD3
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Dec 2020 09:22:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3FA22100ED4A3;
	Sat, 19 Dec 2020 00:22:36 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CC274100ED489
	for <linux-nvdimm@lists.01.org>; Sat, 19 Dec 2020 00:22:34 -0800 (PST)
IronPort-SDR: P/s/ks13n+m6AJPWj5H37LIbX15YHDZAKRorT1oQga9I0he3SKfQVlK0/cwCO61UlmoGOAlk2M
 K+KziS5dxgag==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="237129172"
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400";
   d="scan'208";a="237129172"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2020 00:21:03 -0800
IronPort-SDR: U6K2QA4nVUC0HaN58UKQh8gDW0QKhLSXNdszNIB+wGzexoEZHHaooqZtIZq3eSV/mb1li+5zAq
 F0xQC5/nx8gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400";
   d="scan'208";a="414544628"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 19 Dec 2020 00:21:03 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 19 Dec 2020 00:21:02 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 19 Dec 2020 00:21:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 19 Dec 2020 00:21:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 19 Dec 2020 00:21:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSvFgIQqIyyoFLdT03vE826uIMjytAbdCsHZqVzxIstpOykJvn/R1vqUy91Jv4yKipFTMSxJotxujskbCRcTu4/wlM7C3Pquk27sTjP/yrgRUHoY4x8Qsh5oNdzWbZzlgOLrRScHij4GGqMhZ1B7oRmvF5zdPCpWpPLLh+/25c8nHoFR5PKo77ADHCJZ0s0EmBGPdPzxUvYF9Fsv7ASX09S8kndJAOZMznbGMi372I2DQVAqBQWsRMOQWT5Ak+1Gndss8DUCoWcFRqJYwOTPFMf7JNS2VsrDNM0hgXTdfINBE5+0l5LDtdzJAMWTnlCU+G3hgarDeesGUI1UW+Ckwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvWG9TMdo+hv5Ez+kWN0TpetJk17mXMQUDZgyWRUF6Y=;
 b=Xyj8SQQhhph4z/tqN8ivyIfCa1CwDz1eAVpPrBF7YJfhqF6FaNEjdop5AR3RKf2kUz8Y6Piv7PpdyyaylBuIZtfFljpB33Sy66qjhvy60Jrvmhje4ZgpG+v0jn2R4EcKjLEDwvF09D6yFUSZz2fId9dy6DteA2npwB3F4OYg1zaPRlax2N/rgDj5pAxheNbFYYxvq3KijKJx/BOwWBDLfpb319hoUdlLBpf70T0b0jMoedKSajl2/eDPxx7wqlNSTlbkFGvMMIdbdDz4S9iJDn3HhHVXxDC99JA4HO10eMy9Q8IDA9+Mtzwxq7l4sCDqfs1TaLlMylhqQAlr1CTBrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvWG9TMdo+hv5Ez+kWN0TpetJk17mXMQUDZgyWRUF6Y=;
 b=y/HsKdiWMqzNS+kK5EC19PclXAusGPKEh0IkSj/h7j5D0MVW9Hgw0Ey51zxA2X5Cg4ykclEJMmH/m75TyyV0jXsHqX3UGHEFFNlMv5OdOOBJVrroSZgF8/luHISb8LGuwr8DyczghtG5DOK3yVn7Xpg+MpbPc4WVuW2xq9vQBXI=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BY5PR11MB4354.namprd11.prod.outlook.com (2603:10b6:a03:1cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Sat, 19 Dec
 2020 08:21:01 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae%7]) with mapi id 15.20.3654.025; Sat, 19 Dec 2020
 08:21:00 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
CC: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH daxctl v2 0/5] daxctl: range mapping allocation
Thread-Topic: [PATCH daxctl v2 0/5] daxctl: range mapping allocation
Thread-Index: AQHW1OOZRCx5koQrx0a/pnjCQsZrbKn+FfwA
Date: Sat, 19 Dec 2020 08:21:00 +0000
Message-ID: <1390aa2e28e014ece1e217963ec44a0da6bd9db8.camel@intel.com>
References: <20201218021438.8926-1-joao.m.martins@oracle.com>
In-Reply-To: <20201218021438.8926-1-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c87380b1-0434-45ad-c7c6-08d8a3f70508
x-ms-traffictypediagnostic: BY5PR11MB4354:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4354EABCCA49DBFCFD35BA85C7C20@BY5PR11MB4354.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XX9t2nEFxVtjtSqr/V153VOFx54FARHJ3qZVl9zHYp9OHeghQEudi9V2ZyeXWUHGSYWJ0NO0Vldbw++50R9yZbc0DCqXcpoqYpLb7aVs5ETU8l1LDxTIitU0f4XsO6mfnRtsbkr7uNqNe3SFnShfTCk6NkU47cvjmEAVIUXUmDj2TWquPUk28iF5xo8GDQ9+rOskfoMLAGH0AfkBgGqGKlc5JGnHuhL9o7ne3dB7gjUgRzKBXHbgRImaA30qOob6RLoX5oOH0QkxG9Uj4GGk/0YA5sBAJt+gWpP6O8w6ryMx92wAILBW4E7vY1prxipYy4CvZ1NRu+T9W06t9UqahOQkqVoWTKZ7Madfeph/gaaPf9Sbnhf9/Oc/qS/T3JmCAbcJvtusshdq7qZfU8U61Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(186003)(316002)(91956017)(110136005)(36756003)(26005)(4326008)(4001150100001)(8676002)(6506007)(6512007)(2616005)(478600001)(66946007)(5660300002)(76116006)(66556008)(64756008)(66476007)(83380400001)(8936002)(86362001)(66446008)(2906002)(6486002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WmFaRmpLQlJFM1JjU0htWi9wUE1vR01JKzZCcm83VWxDNGVHQ010Wmp5dmkw?=
 =?utf-8?B?RW1pcEtqeVdyR1Nwb0R6NElqbU1VZWVkZUVncFlwNEZTYzFVVC9ocUJXZmhD?=
 =?utf-8?B?THZ3MEVXUGJhMkNvdllrN1QrbUw1NHBwYkk5R3VmZHBpY1NzYVhFSXRMcjZt?=
 =?utf-8?B?bTd0bERvWFN1bXY0VldadnBtS2M3VzlzU1QzMVhSVE11aUg5cUtNdCtmbk9H?=
 =?utf-8?B?MW9kTU13QWdXZ1dSUjJ4T0piVkJGOTJSVHBqUEtCTEdxNUpnOXZpSHRlQTRG?=
 =?utf-8?B?azZnRkNrUlh4aVZBQ3RrWnlLUGxyVlJxN3dWS0IvdTZxd0tVTE9EMTVyWDRv?=
 =?utf-8?B?MjJEWFcwUXA4Z3Y5ZDRtMmlLVlowYVBmZTZheWt0UE4xVWhJYmdrRHl6NjJY?=
 =?utf-8?B?MWtrMkdxWlR0YXJCNmlHQUxGQkloTHk0NDd4MnE2dk9BbmNxbllkaUlaSUJM?=
 =?utf-8?B?K08zbzU3RHhQc2xNcDlHamZwMmpNSHV3d3d2aUFkRDFGV0V5U2hMRHRreThp?=
 =?utf-8?B?bktOUFRteFJIOElDQ1NlTFU2OHJGSWJPMTgwVDVXS21oT3dkbWl6d0xUUHl3?=
 =?utf-8?B?SGw0UjNoVU9Rb2Rqc0h5c1BEWmRRalF5ZUpqUEl5TTJ1amNybjRwcEtlZGRy?=
 =?utf-8?B?Rlh0bTRWdUhwZ0VCdnB0dVY0d3FzaitSZWs4Z0p3TUJqZk9OMHVMVUxtWjU3?=
 =?utf-8?B?cmJWWWg0RHpnQi9FZ0xnUU9DbFpkOUd5alFOdTRHM0ZvT2FzZVNZY0ZDVHNn?=
 =?utf-8?B?dnh6S3cvSktrODZZVGNGcWRqanQzNTNKS0JjRGsrR0hCRWMwc1ZCY0k2WVZW?=
 =?utf-8?B?SDlSU1VDM2lFWVNRNGZ3M29ObnFnclRYQWJEV3I5UnJuY1I2TCtyK2Q3K1Zm?=
 =?utf-8?B?OEtsWTZlMEwrU2pZdE1idzhBNWtFd2ZRWmdKajBuREVWTEhqOHBGSUZzYUxl?=
 =?utf-8?B?bm80U0lxZ00yeGpjbkNHeW9RZ1ZqWkd4cTRmRy81TEo5dlhTWmU0YVVmSnRh?=
 =?utf-8?B?cmFqZmttYW12THlzWTJFNCtTNC94K0s2ZGVjK3NkMkZrZFJSWEtlc1c4cUhV?=
 =?utf-8?B?b3QrSWhGb01lWmxqUFMyMG9yOTBSN2xlWGhtY00wakp2eThYZDg5Qy9GUVF3?=
 =?utf-8?B?QzA1ZGlhV2VzTUMzYW5BcGtvaCtYSUJpTy9SNUROS0FLMXRGOEJWOUxQcjRr?=
 =?utf-8?B?NmpxVkFZQTJEYzVqdDJlN0V5L3k0dk9JamZ2YVE3cjN6MzkrdndhcGJ5Z0Vv?=
 =?utf-8?B?YmU1cmt6cmFGbUV1UkhhbkJ1QnE2MTdEVjFpWDdDb1l4MnhpaXcyZFhTcTdC?=
 =?utf-8?Q?EPy9rKrRSdQ8tt0CJR5LRtBSRW+TYQ5gOH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0747BAD8DFE3944DAA6F5548AF9622AE@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87380b1-0434-45ad-c7c6-08d8a3f70508
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2020 08:21:00.8726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jL7tdliId8YEyZogeQ4tSExyHsy+KDKjg/4JWiltJswkVNMimT1sT8mRwqgAYS8CmZRZA6k6XH1v2QqMzrTyhYmAT2ZIsGRX+vGfxCpQeUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4354
X-OriginatorOrg: intel.com
Message-ID-Hash: CSYMHMD42DWELWSQHEZXTTEWOJRRE4T3
X-Message-ID-Hash: CSYMHMD42DWELWSQHEZXTTEWOJRRE4T3
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CSYMHMD42DWELWSQHEZXTTEWOJRRE4T3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDIwLTEyLTE4IGF0IDAyOjE0ICswMDAwLCBKb2FvIE1hcnRpbnMgd3JvdGU6DQo+
IEhleSwNCj4gDQo+IFRoaXMgc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3I6DQo+IA0KPiAgMSkgTGlz
dGluZyBtYXBwaW5ncyB3aGVuIHBhc3NpbmcgLU0gdG8gwrRkYXhjdGwgbGlzdMK0LiBUaGVzZSBh
cmUgb21taXRlZA0KPiAgYnkgZGVmYXVsdC4NCj4gDQo+ICAyKSBJdGVyYXRpb24gQVBJcyBmb3Ig
dGhlIG1hcHBpbmdzLg0KPiANCj4gIDMpIEFsbG93IHBhc3NpbmcgYW4gaW5wdXQgSlNPTiBmaWxl
IHdpdGggdGhlIG1hbnVhbGx5IHNlbGVjdGVkIHJhbmdlcw0KPiAgdG8gYmUgdXNlZCB3aGVuIGNy
ZWF0aW5nIHRoZSBkZXZpY2UtZGF4IGluc3RhbmNlLg0KPiANCj4gVGhpcyBhcHBsaWVzIG9uIHRv
cCBvZiAnam0vZGV2ZGF4X3N1YmRpdicgYnJhbmNoIGluIGdpdGh1Yi5jb206cG1lbS9uZGN0bC5n
aXQNCj4gDQo+IFRlc3RpbmcgcmVxdWlyZXMgYSA1LjEwKyBrZXJuZWwuDQo+IA0KPiB2MSAtPiB2
MjoNCj4gICAqIExpc3QgbWFwcGluZ3Mgb25seSB3aXRoIC1NfC0tbWFwcGluZ3Mgb3B0aW9uDQo+
ICAgKiBBZGRzIGEgdW5pdCB0ZXN0IGZvciAtLWlucHV0IGZpbGUgKHdoaWxlIHRlc3Rpbmcgd2l0
aCAtTSBsaXN0aW5nIHRvbykNCj4gICAqIFJlbmFtZSAtLXJlc3RvcmUgdG8gLS1pbnB1dA0KPiAg
ICogQWRkIERvY3VtZW50YXRpb24gZm9yIC1NIGFuZCBmb3IgLS1pbnB1dA0KPiANCj4gSm9hbyBN
YXJ0aW5zICg1KToNCj4gICBsaWJkYXhjdGw6IGFkZCBtYXBwaW5nIGl0ZXJhdG9yIEFQSXMNCj4g
ICBkYXhjdGw6IGluY2x1ZGUgbWFwcGluZ3Mgd2hlbiBsaXN0aW5nDQo+ICAgbGliZGF4Y3RsOiBh
ZGQgZGF4Y3RsX2Rldl9zZXRfbWFwcGluZygpDQo+ICAgZGF4Y3RsOiBhbGxvdyBjcmVhdGluZyBk
ZXZpY2VzIGZyb20gaW5wdXQganNvbg0KPiAgIGRheGN0bC90ZXN0OiBhZGQgYSB0ZXN0IGZvciBk
YXhjdGwtY3JlYXRlIHdpdGggaW5wdXQgZmlsZQ0KPiANCj4gIERvY3VtZW50YXRpb24vZGF4Y3Rs
L2RheGN0bC1jcmVhdGUtZGV2aWNlLnR4dCB8ICAxMyArKysNCj4gIERvY3VtZW50YXRpb24vZGF4
Y3RsL2RheGN0bC1saXN0LnR4dCAgICAgICAgICB8ICAgNCArDQo+ICBkYXhjdGwvZGV2aWNlLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMjggKysrKysrKysrKysrKysrKysrKysr
KysrKy0NCj4gIGRheGN0bC9saWIvbGliZGF4Y3RsLXByaXZhdGUuaCAgICAgICAgICAgICAgICB8
ICAgOCArKw0KPiAgZGF4Y3RsL2xpYi9saWJkYXhjdGwuYyAgICAgICAgICAgICAgICAgICAgICAg
IHwgMTE4ICsrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgZGF4Y3RsL2xpYi9saWJkYXhjdGwu
c3ltICAgICAgICAgICAgICAgICAgICAgIHwgICA3ICsrDQo+ICBkYXhjdGwvbGliZGF4Y3RsLmgg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTQgKysrDQo+ICBkYXhjdGwvbGlzdC5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKw0KPiAgdGVzdC9kYXhjdGwtY3Jl
YXRlLnNoICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMxICsrKysrKy0NCj4gIHV0aWwvanNv
bi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA1NyArKysrKysrKysrKy0N
Cj4gIHV0aWwvanNvbi5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCAr
DQo+ICAxMSBmaWxlcyBjaGFuZ2VkLCAzODAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cj4gDQpIaSBKb2FvLA0KDQpUaGVzZSBhbGwgbG9vayBnb29kLCBhcHBsaWVkLiBUaGFua3MgZm9y
IHRoZSBxdWljayB0dXJuYXJvdW5kIQ0KDQotVmlzaGFsDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxp
bnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBs
aW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
