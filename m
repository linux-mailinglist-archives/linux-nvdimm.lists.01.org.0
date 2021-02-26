Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E46063269A9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Feb 2021 22:41:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EDA60100EAAEA;
	Fri, 26 Feb 2021 13:41:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A03C5100EBB63
	for <linux-nvdimm@lists.01.org>; Fri, 26 Feb 2021 13:41:48 -0800 (PST)
IronPort-SDR: bh+Kt4sN/daA6qAM/K/vjdpkVEuUJ+omzdENLSd5VqcRWAGeo0I3jcNscgoXcKEY6oN9EuNezD
 wF7NECtqlWVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="185315483"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400";
   d="scan'208";a="185315483"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 13:41:47 -0800
IronPort-SDR: JJkDIRGMJK+tw71kxVoxsw1bI40zp0SanRpxCvf20xFLUlVHJfr96kz56cNIWxSAFr1Fun8O6i
 W9ERRPB9Y1HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400";
   d="scan'208";a="382159778"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 26 Feb 2021 13:41:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Feb 2021 13:41:46 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Feb 2021 13:41:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 26 Feb 2021 13:41:46 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 26 Feb 2021 13:41:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QV3hpNDeO54DEkathFXUpYQfAqHlH6zdNExRjbb/S68/MaQNSp71+LL/SO9PK9Re8InbBnmG4x4MU9mcb7FURqGBgStwP6heHc9WT7E7mub2VTD+eJdKbVXQaEBhm0jIV6SDZoIShrkL75H/lodks9SyVKTUXvs7pjO4zSqr+ANbKznntiaADWA/rMLx/4nf4dDhPPtMFzfDLvh+KSuragF0DrvzE4KcZTgSPYMcqaYHMAe8bN/wozIXfC+bg21l8OVN0+Cp5XW8C/x1TN0Q0SwF8UyTGGcd/D0lO4kKz67PWixKcZ6x6oebmGbl/LuDrNV6oXhtIteyC6nX5lcWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bbfoi6oYW2nyui9XCq60eyr1sW1S0Fs3d4Lgcz6kpc=;
 b=kjYLn3LJZcrCYYyH3G3rq6QvYw6vKNxl/QSi/AMw3tPGjPOBQayzuqjzm5ExvsKHZShZtxAvyogg5ynZzY3u/de2e2a6a1EYQYwGrDZ2N6KS1DXSmP1jXUupC+qlcrSgb1p/3vWBmRE7DN1J7ezMWR1vSiwcdS5fag8FPbySncs9HIooWFJVLloPT07B2Rm1gjb203Q0nf3WPmB61HdauFqbFe93dlc7U74oKklV34bYG45eWP91zfKOWUVuadqA0T+yedrvdk6xKHLWujaDmLPK0ISVTMuhIb2aXUf5aq4UJ15MhKiNOYtowfc9cCDbAJvwcwQTsA4WBwXfqkBh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bbfoi6oYW2nyui9XCq60eyr1sW1S0Fs3d4Lgcz6kpc=;
 b=wkoatlKxb9ze/mVHu1Dtni0f2IkEFlXn20sqLwRvRA+XEXntoJepG3FJadEUxKtdJPWXbLGZxkb8U3N6FICGj3cT8rCUGWlpyXl0GsDFQVfY/tzJ0ApXXpZi4/DzLLkXGA/Uni4i4zRhg/rQtdbCHXLvlWWgQPTcptGnn2ua6uE=
Received: from BL0PR11MB3444.namprd11.prod.outlook.com (2603:10b6:208:6f::29)
 by MN2PR11MB4712.namprd11.prod.outlook.com (2603:10b6:208:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Fri, 26 Feb
 2021 21:41:45 +0000
Received: from BL0PR11MB3444.namprd11.prod.outlook.com
 ([fe80::3015:a30e:1ee9:36fd]) by BL0PR11MB3444.namprd11.prod.outlook.com
 ([fe80::3015:a30e:1ee9:36fd%3]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 21:41:45 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Tsaur, Erwin"
	<erwin.tsaur@intel.com>
Subject: Re: [ndctl PATCH] Expose ndctl_bus_nfit_translate_spa as a public
 function.
Thread-Topic: [ndctl PATCH] Expose ndctl_bus_nfit_translate_spa as a public
 function.
Thread-Index: AQHXCweaYKuYVulR9kqifOXvQK36v6pq+kmA
Date: Fri, 26 Feb 2021 21:41:45 +0000
Message-ID: <d2df67801c1e0894e276f1792976ec66a00ba7a7.camel@intel.com>
References: <20210224234814.1021-1-erwin.tsaur@intel.com>
In-Reply-To: <20210224234814.1021-1-erwin.tsaur@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29a4d3cd-4e0b-453d-5ded-08d8da9f504d
x-ms-traffictypediagnostic: MN2PR11MB4712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB471248ADA809AEB6E87DEDBFC79D9@MN2PR11MB4712.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hj748R6Up53newZhHIe5AddULrKZr/7Q0lIgl0qMkzYYc5el8km9olUmu361HubW+0VxAVD3Wdq8/XMo7QHAv4BdAc7BJ9TgtxVP8ceRfg2RERlwRjMDU71Zj06b0FJjRf/6pWJd6yfiebooTf/lFQXrWa2a/duILUkBOaoDGsycan8TCJA6IJO3GhVPNBg8XgmdjrZSyEOdQ/p9bHyjbFQd4nhNr5BgXNfOXKnv7Ip6ORGs8UOe+iQOKsmvgzA28EFzHHZ8f2GNK4Wkqu4wX+6gZvdzmxZWL4FnTEl/54AF+mgATJ1SAY0A/8tbqPAi5VDYeZTz3u5fgc4n6qeIeWDzgb4sXEbnXWPR3AzKM0hJN5M8BOr9QGULWJr3QTTF9MlMggMN7gDZKCeEtQXtfkSjapsCYOqRdN84ZCPO2DRpMX+Qffe2F7ZOLH93Wb3DTKSjYThIg+hM+Xpby/0Pvpyl17yg1cRfLQ2y9q+MWtNHkDDa31YPgLKryrZySZUvvrQX8afMMolww6eeIf9YnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39860400002)(136003)(396003)(2906002)(66476007)(5660300002)(110136005)(36756003)(316002)(6486002)(8936002)(64756008)(66446008)(6512007)(6506007)(86362001)(478600001)(76116006)(91956017)(66946007)(186003)(26005)(2616005)(66556008)(6636002)(71200400001)(83380400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aTl0YTM3Q2JMT1JpaU9LWUQ3L3YwSGgyQUNvQ1JKOHJHOUhtTnVqZTBSb3NL?=
 =?utf-8?B?MnI3WHBFaGpyWUpRbEkzekdBQXY5TXljZU5lM1JsaUZycVhRaVhlbTcza0NP?=
 =?utf-8?B?OS9TanNxaTh3dUZhNDhObC9kaGV6OE9KakRzMWFkYkRDTXp5RmJ3THludmw3?=
 =?utf-8?B?N1M5ZjJyVE5xQ09ER3FpVGVMRDFFMzBLbkIvRGJDNGQ2dit3MDlpczE5cDNX?=
 =?utf-8?B?eUMray9OdzhFVE9EZ09qL3BEUGVSeHRQK3lJejQrSkdtS0NKYVV1amU5aUFE?=
 =?utf-8?B?U296Uk9RcUFTYzBXOFVBaXJ3YzZzZitPNThvWUYvZWl3THQ5ay9zV2NvQ0Qr?=
 =?utf-8?B?b2lYUkhyUUhtSnBWRTFTRGNTZnpJU2drK3F6cldJSFhVajQ1OVRsbzNJN2Iy?=
 =?utf-8?B?UTM0TWM5MzI0VjdndmNndVhjeUVaL1JYbnQ1T05mZHBIYjdDbHZxdWJ3ZmRU?=
 =?utf-8?B?K1VKVnQwY0VzajV5VTBVaGUyT203NFRRQ2p6VjN0REx5RjdxRERpNElxWFVy?=
 =?utf-8?B?R2h4bSs4Mk5ZenZIdkV0UnZTWVpCai9PWE5RSHBzdFZkSDFQdzdLa04yZC8v?=
 =?utf-8?B?Y0x4YUE4cTFFekxVUFV2YWFnV2M4eXlobVBnOFJINlpubWMwTllVSnB1eHhl?=
 =?utf-8?B?YWtNSTVZU09DVit3ZXRyVDNJTitISks3OVV6VFA0Ni9qY01wb1VhYk1PZHJ2?=
 =?utf-8?B?akc1S1dSbHo0T0dCYmZBVEJHN2ZLQ1FMRm9QQ09KOWJoVVFGeTFvZ2dHRXBr?=
 =?utf-8?B?ejhvL2c4REZEankvTDAwTDFkYWxoMm5oMEkwOHovY25ZdEhvbzFHZ3JmSVVL?=
 =?utf-8?B?cHZIOGhhcjZTU1IzbUpFR2xyVDJTeFEyVkp3SzYzdXphYW4vVlRpbkZSdEhx?=
 =?utf-8?B?c3JtREY4SDc2NCtaL1FlM2EzOUVwRmhFYm45ME9pL0ttQ09YekdWZy9DV0tI?=
 =?utf-8?B?akhiUFpzSGwxUTh5QWJYbUFFY2FPcGMvd3lPbVdGOHZRVGYvTjdVZ1JtR3FM?=
 =?utf-8?B?SmU2d1BQNEVpQjBBUGFQYk9vZWgzZVNxSW9ldzA2RmZVMmRUcUZhTHpxOFp3?=
 =?utf-8?B?aGFSdGZPdk1BTEEvcjJ3NEFlbUx1ZVZNR3dIblZMRjVXRmZ3UXAxalNSNzNk?=
 =?utf-8?B?Zk5qRzBFVng1Q0JLYlNpV25VZ0FzTUxHZE15VkllYTVaRUFsdnlYREhwb0Iy?=
 =?utf-8?B?SnphdXBKa0tjNDBPL1cvbndLUEtOWHlYM29pU1FEK1JEd05IVnpVRGdRV0Uz?=
 =?utf-8?B?U21PRmd6UnczZnRyVS9QYTVTQ2daNzA4OWRWQ3RYbXp0bzdMYlEycTZobGNV?=
 =?utf-8?B?N3lTc3U3bHMvZHhkeEFaWEp6YTBhZWJ2TzJ4bENjUmNPaXpWZzVVRkFJSXRs?=
 =?utf-8?B?d1k4ZlRMeWthZCtHVUZObnJzV2E0L1FFTmc1Z1NlbnA3alNHdUNXTE83MXJQ?=
 =?utf-8?B?eTAvWDhLczgrd2hNaHRUNHBCZk12dE9pc2RMVXRxL3BTRUg4eHViZ2tlRGZD?=
 =?utf-8?B?QmhkQ05tNDBPa01QZjh4VTlkWU9TU1FsQXN3MkM3K3NrRm43ZVF1cGFHSEth?=
 =?utf-8?B?UXZDakZXeE9xekIrZEZRUkNPWS9UQzROeFdZdGtNR09hWVhLWUtYVjVqY2U0?=
 =?utf-8?B?Q2VDVjV2cFN4M3ZEWkxERWpUdU11YjFDN09GbURxN1plc0dKTzJWSVhRVC9D?=
 =?utf-8?B?UU9pWGx0UVJCaVpPdDRLcmJ2MXc2ajNQSFRPdGxoL0VLa0VjSWpsMGk2NFhJ?=
 =?utf-8?Q?C3ko9xIspvMSjFoAJugxaaSFCtQRXrUB635zdjV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2F1213FF2DEB24AB78F317205C9F4B6@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a4d3cd-4e0b-453d-5ded-08d8da9f504d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 21:41:45.3798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M001VaqK3oCgNO3C7zj045e7Bu0YM3Iq8YTSiypwKsBaZDvgZ6SOWK8/yRJBCSPE1F8lmwPKijiHsta308z3y0p1SXSy9gatty9qKiHkleA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4712
X-OriginatorOrg: intel.com
Message-ID-Hash: MBICSE42DRR5IZGCILDKJZUQF74Z56KW
X-Message-ID-Hash: MBICSE42DRR5IZGCILDKJZUQF74Z56KW
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MBICSE42DRR5IZGCILDKJZUQF74Z56KW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

T24gV2VkLCAyMDIxLTAyLTI0IGF0IDE1OjQ4IC0wODAwLCBUc2F1ciwgRXJ3aW4gd3JvdGU6DQo+
IFRoZSBtb3RpdmF0aW9uIGlzIHRvIGFsbG93IGFjY2VzcyB0byBBQ1BJIGRlZmluZWQgTlZESU1N
IFJvb3QgRGV2aWNlIF9EU00gRnVuY3Rpb24gSW5kZXggNShUcmFuc2xhdGUgU1BBKS4gIFRoZSBy
ZXN0IG9mIHRoZSBfRFNNIGZ1bmN0aW9ucywgd2hpY2ggYXJlIG1vc3RseSBBUlMgcmVsYXRlZCwg
YXJlIGFscmVhZHkgcHVibGljLg0KPiANCj4gQmFzaWNhbGx5IG1vdmUgbmRjdGxfYnVzX25maXRf
dHJhbnNsYXRlX3NwYSBkZWNsYXJhdGlvbiBmcm9tIHByaXZhdGUuaCB0byBsaWJuZGN0bC5oLg0K
PiAtLS0NCj4gwqBuZGN0bC9saWIvbGlibmRjdGwuc3ltIHwgNCArKysrDQo+IMKgbmRjdGwvbGli
L25maXQuYyAgICAgICB8IDIgKy0NCj4gwqBuZGN0bC9saWIvcHJpdmF0ZS5oICAgIHwgMiAtLQ0K
PiDCoG5kY3RsL2xpYm5kY3RsLmggICAgICAgfCAyICsrDQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmRjdGwv
bGliL2xpYm5kY3RsLnN5bSBiL25kY3RsL2xpYi9saWJuZGN0bC5zeW0NCj4gaW5kZXggMGE4MjYx
Ni4uNThhZmI3NCAxMDA2NDQNCj4gLS0tIGEvbmRjdGwvbGliL2xpYm5kY3RsLnN5bQ0KPiArKysg
Yi9uZGN0bC9saWIvbGlibmRjdGwuc3ltDQo+IEBAIC00NTEsMyArNDUxLDcgQEAgTElCTkRDVExf
MjUgew0KPiDCoAluZGN0bF9idXNfY2xlYXJfZndfYWN0aXZhdGVfbm9zdXNwZW5kOw0KPiDCoAlu
ZGN0bF9idXNfYWN0aXZhdGVfZmlybXdhcmU7DQo+IMKgfSBMSUJORENUTF8yNDsNCj4gKw0KPiAr
TElCTkRDVExfMjYgew0KPiArCW5kY3RsX2J1c19uZml0X3RyYW5zbGF0ZV9zcGE7DQo+ICt9IExJ
Qk5EQ1RMXzI1Ow0KPiBkaWZmIC0tZ2l0IGEvbmRjdGwvbGliL25maXQuYyBiL25kY3RsL2xpYi9u
Zml0LmMNCj4gaW5kZXggNmY2OGZjZi4uZDg1NjgyZiAxMDA2NDQNCj4gLS0tIGEvbmRjdGwvbGli
L25maXQuYw0KPiArKysgYi9uZGN0bC9saWIvbmZpdC5jDQo+IEBAIC0xMTQsNyArMTE0LDcgQEAg
c3RhdGljIGludCBpc192YWxpZF9zcGEoc3RydWN0IG5kY3RsX2J1cyAqYnVzLCB1bnNpZ25lZCBs
b25nIGxvbmcgc3BhKQ0KPiDCoMKgKg0KPiDCoMKgKiBJZiBzdWNjZXNzLCByZXR1cm5zIHplcm8s
IHN0b3JlIGRpbW0ncyBAaGFuZGxlLCBhbmQgQGRwYS4NCj4gwqDCoCovDQo+IC1pbnQgbmRjdGxf
YnVzX25maXRfdHJhbnNsYXRlX3NwYShzdHJ1Y3QgbmRjdGxfYnVzICpidXMsDQo+ICtORENUTF9F
WFBPUlQgaW50IG5kY3RsX2J1c19uZml0X3RyYW5zbGF0ZV9zcGEoc3RydWN0IG5kY3RsX2J1cyAq
YnVzLA0KPiDCoAl1bnNpZ25lZCBsb25nIGxvbmcgYWRkcmVzcywgdW5zaWduZWQgaW50ICpoYW5k
bGUsIHVuc2lnbmVkIGxvbmcgbG9uZyAqZHBhKQ0KPiDCoHsNCj4gwqANCj4gDQo+IA0KPiANCj4g
ZGlmZiAtLWdpdCBhL25kY3RsL2xpYi9wcml2YXRlLmggYi9uZGN0bC9saWIvcHJpdmF0ZS5oDQo+
IGluZGV4IGVkZTEzMDAuLjhmNDUxMGUgMTAwNjQ0DQo+IC0tLSBhL25kY3RsL2xpYi9wcml2YXRl
LmgNCj4gKysrIGIvbmRjdGwvbGliL3ByaXZhdGUuaA0KPiBAQCAtMzcwLDggKzM3MCw2IEBAIHN0
YXRpYyBpbmxpbmUgaW50IGNoZWNrX2ttb2Qoc3RydWN0IGttb2RfY3R4ICprbW9kX2N0eCkNCj4g
wqAJcmV0dXJuIGttb2RfY3R4ID8gMCA6IC1FTlhJTzsNCj4gwqB9DQo+IMKgDQo+IA0KPiANCj4g
DQo+IC1pbnQgbmRjdGxfYnVzX25maXRfdHJhbnNsYXRlX3NwYShzdHJ1Y3QgbmRjdGxfYnVzICpi
dXMsIHVuc2lnbmVkIGxvbmcgbG9uZyBhZGRyLA0KPiAtCQl1bnNpZ25lZCBpbnQgKmhhbmRsZSwg
dW5zaWduZWQgbG9uZyBsb25nICpkcGEpOw0KPiDCoHN0cnVjdCBuZGN0bF9jbWQgKm5kY3RsX2J1
c19jbWRfbmV3X2Vycl9pbmooc3RydWN0IG5kY3RsX2J1cyAqYnVzKTsNCj4gwqBzdHJ1Y3QgbmRj
dGxfY21kICpuZGN0bF9idXNfY21kX25ld19lcnJfaW5qX2NscihzdHJ1Y3QgbmRjdGxfYnVzICpi
dXMpOw0KPiDCoHN0cnVjdCBuZGN0bF9jbWQgKm5kY3RsX2J1c19jbWRfbmV3X2Vycl9pbmpfc3Rh
dChzdHJ1Y3QgbmRjdGxfYnVzICpidXMsDQo+IGRpZmYgLS1naXQgYS9uZGN0bC9saWJuZGN0bC5o
IGIvbmRjdGwvbGlibmRjdGwuaA0KPiBpbmRleCA2MGUxMjg4Li5lZTUxN2E3IDEwMDY0NA0KPiAt
LS0gYS9uZGN0bC9saWJuZGN0bC5oDQo+ICsrKyBiL25kY3RsL2xpYm5kY3RsLmgNCj4gQEAgLTIz
Nyw2ICsyMzcsOCBAQCB1bnNpZ25lZCBsb25nIGxvbmcgbmRjdGxfY21kX2NsZWFyX2Vycm9yX2dl
dF9jbGVhcmVkKA0KPiDCoAkJc3RydWN0IG5kY3RsX2NtZCAqY2xlYXJfZXJyKTsNCj4gwqB1bnNp
Z25lZCBpbnQgbmRjdGxfY21kX2Fyc19jYXBfZ2V0X2NsZWFyX3VuaXQoc3RydWN0IG5kY3RsX2Nt
ZCAqYXJzX2NhcCk7DQo+IMKgaW50IG5kY3RsX2NtZF9hcnNfc3RhdF9nZXRfZmxhZ19vdmVyZmxv
dyhzdHJ1Y3QgbmRjdGxfY21kICphcnNfc3RhdCk7DQo+ICtpbnQgbmRjdGxfYnVzX25maXRfdHJh
bnNsYXRlX3NwYShzdHJ1Y3QgbmRjdGxfYnVzICpidXMsIHVuc2lnbmVkIGxvbmcgbG9uZyBhZGRy
LA0KPiArCQl1bnNpZ25lZCBpbnQgKmhhbmRsZSwgdW5zaWduZWQgbG9uZyBsb25nICpkcGEpOw0K
PiDCoA0KDQpPbmUgbml0IGhlcmU6IGNhbiB5b3UgZ3JvdXAgdGhpcyB3aXRoIHRoZSBvdGhlciBu
ZGN0bF9idXNfKiBmdW5jdGlvbg0KZGVjbGFyYXRpb25zIGluIHRoaXMgZmlsZT8NCg0KRXZlcnl0
aGluZyBlbHNlIGxvb2tzIGdvb2QgdG8gbWUuDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51
eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGlu
dXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
