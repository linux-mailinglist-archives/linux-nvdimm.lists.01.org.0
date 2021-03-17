Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BCF33FAE1
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Mar 2021 23:18:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 49CF0100EB320;
	Wed, 17 Mar 2021 15:18:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2B107100EB85D
	for <linux-nvdimm@lists.01.org>; Wed, 17 Mar 2021 15:18:23 -0700 (PDT)
IronPort-SDR: C7IOPpQ0lxjZdOHLwuXp4VAFhBaXwz+6y+qEUXjBri6dTJ2ZF5CHviTZHHFulw4c3skV118/sY
 784iKcLsE5wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="274607774"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400";
   d="scan'208";a="274607774"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 15:18:22 -0700
IronPort-SDR: Z7tjuw1XL2Em6OdcVZwdziIvca/zDKngrJlJrU7lU4ZfpR7QFVOAUlgka6IK7avy5ZTVNJ7Isu
 KspmCuiSGThg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400";
   d="scan'208";a="523030666"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2021 15:18:22 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 15:18:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 17 Mar 2021 15:18:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 17 Mar 2021 15:18:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8fp76kDMpAuC/1nxSEwlAes+TAls/m6onDywr0vKL8lkr2u/l9DRXAGCYprOYtyTph0dvflzJXGwwdgPEsKx8vuBCYVN4pjJKHH1p3/wqEzDTi9OAPihQjO2DYXdJrZi04CYDwURHQ6MupLkE4WSoTHlB+przdR9kmNgxL9EG7tDb/J01SgjeiPlSBjgRqShwqo27S+749TRBU2CR5UaOeFAqTSjpKKRvDOF/Uu2zUrAqqcbOgdE7N4kjrFDzITSnxs0jo1V66/wFAhq9cXjb7CQ/oD52ADoPU1BPKVofk98evfzOLeK1DKncv2FbiI1HI4g2X6cBJW+AB8MCMiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaXOR/tCURBuqQ0umDrDWD38krqnFaxzRXFiVuFs6g8=;
 b=UeqhBx+/sqcUHwPeeEipqOoVU06KnCnNLkq1HMuqyMMVnONAx/2+MQQrcsd6GXuwS6APeR3ba2Z4qoAuo2y8GqSFm3pr3JATYdWUpWLV0Aodnud2Qsn5YHPnLMCvPPUj2We6zg6l3Oafp+iQIZOK52i//Xv/W7uwlm3i2D/VVuYHzqDGwnZB9kEmR3docYravlM63DiGZ9bPq5zGbstYRbC9zir4esZR9X6yXhZjWsVTr+1MBEhKgUktzuvqHzFXKEtVblyGfX9xoC+mvF88JOHzeIahQTiI1/WiB5oYtt4CDej91daFwzqApOWgdBYmhVrJZ6l0RuhZbe28jmfM0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaXOR/tCURBuqQ0umDrDWD38krqnFaxzRXFiVuFs6g8=;
 b=pOT4P+1uoDYnTtucm5zymBgaOh07C8e0DrdTUR9vVY2Px4rwdHRyysvmIQ8cfSR8c3sP0ShN5SN0NIJffWqJq4vdIGdBQjlB7A1w/zZ7PNly3t7Gah9G/Mtw1qnfkwn+OpJK4zeVUb2NHW81bBXUCIk3vf27iOXYVZqpVfy9Q3o=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BY5PR11MB4005.namprd11.prod.outlook.com (2603:10b6:a03:18c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 22:18:18 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 22:18:18 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "sbhat@linux.ibm.com" <sbhat@linux.ibm.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "harish@linux.ibm.com" <harish@linux.ibm.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "santosh@fossix.org"
	<santosh@fossix.org>, "vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH v3 3/4] papr: Add support to parse save_fail flag
 for dimm
Thread-Topic: [ndctl PATCH v3 3/4] papr: Add support to parse save_fail flag
 for dimm
Thread-Index: AQHXFksF8mZuDcqZQUuNBURRNudtBaqIykWA
Date: Wed, 17 Mar 2021 22:18:17 +0000
Message-ID: <01f28982255ecd8f9020efcedc3df501a5ebfb44.camel@intel.com>
References: <20210311074652.2783560-1-santosh@fossix.org>
	 <20210311074652.2783560-3-santosh@fossix.org>
In-Reply-To: <20210311074652.2783560-3-santosh@fossix.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c03fab6-a1b4-4e41-33af-08d8e992910b
x-ms-traffictypediagnostic: BY5PR11MB4005:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB40052E8F8865DA078B3CF9F9C76A9@BY5PR11MB4005.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kLxNe6JHYrBhGyDCrp4RQTVPgxERwQ+UtNk8pRKdpmZmEvdBXWR/1gZ3561naMHCnG3RkmKl1gzSDxlPJN+bNYEuLWnnkSoaumzcRjr8wprsQEuC9PB0AxOsxdcdkx2IMjnV5GfYbWChEaZsInUFs3Y4jjd6lwBaCK4aYupAYyUMBPVRDhdiDIsAURf0NQq9/MD8HGbfqz0l/fy6LQCUyVKa2BXpQpNYcc5U+utTygqliS4zy06OrkMPoPq7f3qNrApQLFXo3f1SY/Uy/Y08BRIEowgZZ8pi1AmZOERzaONi9MkYI5VsKHPUn01tzEJstKuZcTR0hdxH6pztfP1GA5xrmEMCOwSd0xgAg9j08YGQk3IA1i0GdZwRk/ED4DoAppUxGnzfrWeNOBKoqvqTR54rZS3y8/BsMmBzptfQvvpZceK3LR8fNkZV4AN6GizL/C5YQzZtBEOvcgEms0Vl8ycKylKFRO0uV03gShtHZFe9HZW3qXqrykM563kg8s+f3b1xkDyojBMQ0XVcdcKjLSGyw1Tzl7h0DZg9Hiy+5fIVqZb6ZbLurLWOc4DUO+sL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(346002)(136003)(366004)(66476007)(76116006)(6506007)(66446008)(478600001)(8936002)(64756008)(91956017)(5660300002)(71200400001)(316002)(66946007)(36756003)(2906002)(66556008)(83380400001)(186003)(6512007)(2616005)(110136005)(26005)(6486002)(86362001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dEtsQlBvTFIxR09QT0RsUWpzUGFsallZSVZNZ0t1K0w4ZjI4V3AzWlR6SCtS?=
 =?utf-8?B?TVNXZ083YjViZUYxemcxdmk3NFVNNTc2SUszYmpIakVuTmR4VDJDeXYwK1ph?=
 =?utf-8?B?RWFFVW43cHNlZjR0MjlLclJXRUZ5VEF6N28rRVByalVCVmR2NWRqN2x2cWpy?=
 =?utf-8?B?aTU4bUZrOStwTU82TkF2bFUxbU9sNXFKTGVScnVOeTRKbTNIRnlRSnRFNW9H?=
 =?utf-8?B?RDVLVW5odGZhSSs5VVQ0VE9ONm9PL0ZOZmFveXFWeFE3aHp3MVNZbERSUHlo?=
 =?utf-8?B?dzgzbnRQY1U5QzEyQmJ0TW40a2Nsa0JRMys4RTljRHpBZDh2ZjNwRldyQ0hP?=
 =?utf-8?B?RzAycnROcGV3b2t2cm0zckwrbFNzeHRURUYvSGVBYjRXRVpBUWs0WjV0aHpt?=
 =?utf-8?B?Q2NjT0hPMnVJek40NllEREJtOHFMdGpCN0V0blVmNXFEWHFqa2pQSXlNZHJH?=
 =?utf-8?B?YlV1RW9CTWk2M2d2Y21KREVEMXNGZk5Td1E1cGF1b0FqMzQrYy9Ra2p1bmFP?=
 =?utf-8?B?aEVqWGF2M2R1TSs5QmJIbG1ZZmFSekFzN3c1ZHo5TVZ2RzZ1aEVuUUpBQWth?=
 =?utf-8?B?cmxsdGpYNi9jZVFXVjdPT2ZJbUF0REt4bGU3N3p5cER5cVRxcldkZ2ZCbEFP?=
 =?utf-8?B?RGZ2cDV0d2NOVDFndDJob3h4TkZIQ1FnMWcxdHErL2h3ZzU3UFplR3hNbk1J?=
 =?utf-8?B?Y0RLUUNzV2FjcVZ5cWFsNm5OR1RlQTlPR1ZqeGh4VThqdHV3QndoYnREVEQ5?=
 =?utf-8?B?UlozMk10THh1NjlmYmpUN3NCem5kanJGMGh5aVdRcFo3dWJ5NDB0UTFXcEpB?=
 =?utf-8?B?Q2ZseW9wZTQwSXhwYzArcldvQkF4L2ZjNjJEeklaSlF5ekZjM1NpeThNU3Zm?=
 =?utf-8?B?c0RRYi9OTk82bEdwK0NnbkxwU1BPRmhpT0s4bFR2aVVnQ0ZIcjJBQXRBMTZP?=
 =?utf-8?B?ZGlid09HMlEwbE43cVpVQmlBME1ucTJwY3JPNXFLL0tCV0EzU2pjTjNoK2dV?=
 =?utf-8?B?ZUhRRUNrZXRJL0UyVG1oNGtOYkJscnI3MFV4QmhwaEg2dmdOWnc1NXdwZHU4?=
 =?utf-8?B?Tm05d3pZTnlvVTdIRkhrK0NrWm9DV1lGUlRiSXM2TnpWWVN6bXJmMHFEVDdJ?=
 =?utf-8?B?ZHZSVGZIR2phTEg3NFdwYnhQVnNhTHhIZ05IT0NVMmZtSHRHTjQ5VXVMVG9L?=
 =?utf-8?B?WklXOUY4Y21vUDl0aCtQVk9nQTJKWjdjVDhtZ3BUd1NVVkZNM1pVeVFxMVUz?=
 =?utf-8?B?cFhRbmpZNTVOb05Wa0ZmM2ZYd1B5MkMydTlNQzhoaGpGTkdBSFlCc3lITGRn?=
 =?utf-8?B?aGw3NWRUd3JQV2VlU2xCZDVUOWh1L1dlSUxXZy9QYVF1K3FRYThmQ3RXNWRs?=
 =?utf-8?B?ZDdDbFZPcnBDMkRVVkp6ck1COHVEQ1pVVDZLTXNKMTMvYm1VSjdvSlJLdmxU?=
 =?utf-8?B?dHdYd29kbjBUSURUM09nNmczdmtnbHdVOGlRdHl2Sk0wOXZySDlCOXVIaXlX?=
 =?utf-8?B?YkUvV1d0ZXBPblYzYVZOR2luVlJkaVd5SkFjSC9LWGQ2ZDN2VnRVeXY4Q1pt?=
 =?utf-8?B?bXdVR1R4VnFucTgxMisrcmNodVEybzBrd3F5QmtEOUdFWHJITlp3TEtUWjQ4?=
 =?utf-8?B?eTdaZlp4WWJiYk1nU0NDUC9ieWV1R0R3clNvbFVBOGh0elFxQVpoei83Rm5F?=
 =?utf-8?B?WUYvMlBBOG91MGZxV0d6OUN2VjBhRnFmdG93MlBBNWV6dVFnMTZ4NjMwbmRU?=
 =?utf-8?B?cHFBTUkrMTJJbURqaFlLYytLUnJKQ1NwZUQrOHp2QWpsK2NtRzd2aDNWQ3gz?=
 =?utf-8?B?TmxoeWpabnJnaEE3aTdZZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A1DB21CC18E0F4CAD9C33E15600B843@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c03fab6-a1b4-4e41-33af-08d8e992910b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 22:18:18.0103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lF9MzJEX7GlFxoomjZENF2tAAJHhsxszicSysxBIAUVfDqDzVdMHV1A7i5ZNghF1zkzBxAUY4bWSOsSVoVlPU7CftLlZ0BzsZJC/yfbYVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4005
X-OriginatorOrg: intel.com
Message-ID-Hash: H2BEDNMRMAQU5VPLK2YBE5ODQRWDL6JC
X-Message-ID-Hash: H2BEDNMRMAQU5VPLK2YBE5ODQRWDL6JC
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/H2BEDNMRMAQU5VPLK2YBE5ODQRWDL6JC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDIxLTAzLTExIGF0IDEzOjE2ICswNTMwLCBTYW50b3NoIFNpdmFyYWogd3JvdGU6
DQo+IFRoaXMgd2lsbCBoZWxwIGluIGdldHRpbmcgdGhlIGRpbW0gZmFpbCB0ZXN0cyB0byBydW4g
b24gcGFwciBmYW1pbHkgdG9vLg0KPiBBbHNvIGFkZCBudmRpbW1fdGVzdCBjb21wYXRpYmlsaXR5
IHN0cmluZyBmb3IgcmVjb2duaXppbmcgdGhlIHRlc3QgbW9kdWxlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogU2FudG9zaCBTaXZhcmFqIDxzYW50b3NoQGZvc3NpeC5vcmc+DQo+IC0tLQ0KPiDCoG5k
Y3RsL2xpYi9saWJuZGN0bC5jIHwgNSArKysrLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZGN0bC9saWIvbGli
bmRjdGwuYyBiL25kY3RsL2xpYi9saWJuZGN0bC5jDQo+IGluZGV4IDI2YjkzMTcuLmRkMWE1ZmMg
MTAwNjQ0DQo+IC0tLSBhL25kY3RsL2xpYi9saWJuZGN0bC5jDQo+ICsrKyBiL25kY3RsL2xpYi9s
aWJuZGN0bC5jDQo+IEBAIC04MDUsNiArODA1LDggQEAgc3RhdGljIHZvaWQgcGFyc2VfcGFwcl9m
bGFncyhzdHJ1Y3QgbmRjdGxfZGltbSAqZGltbSwgY2hhciAqZmxhZ3MpDQo+IMKgCQkJZGltbS0+
ZmxhZ3MuZl9yZXN0b3JlID0gMTsNCj4gwqAJCWVsc2UgaWYgKHN0cmNtcChzdGFydCwgInNtYXJ0
X25vdGlmeSIpID09IDApDQo+IMKgCQkJZGltbS0+ZmxhZ3MuZl9zbWFydCA9IDE7DQo+ICsJCWVs
c2UgaWYgKHN0cmNtcChzdGFydCwgInNhdmVfZmFpbCIpID09IDApDQo+ICsJCQlkaW1tLT5mbGFn
cy5mX3NhdmUgPSAxOw0KPiDCoAkJc3RhcnQgPSBlbmQgKyAxOw0KPiDCoAl9DQo+IMKgCWlmIChl
bmQgIT0gc3RhcnQpDQo+IEBAIC0xMDM1LDcgKzEwMzcsOCBAQCBORENUTF9FWFBPUlQgaW50IG5k
Y3RsX2J1c19pc19wYXByX3NjbShzdHJ1Y3QgbmRjdGxfYnVzICpidXMpDQo+IMKgCWlmIChzeXNm
c19yZWFkX2F0dHIoYnVzLT5jdHgsIGJ1cy0+YnVzX2J1ZiwgYnVmKSA8IDApDQo+IMKgCQlyZXR1
cm4gMDsNCj4gDQo+IC0JcmV0dXJuIChzdHJjbXAoYnVmLCAiaWJtLHBtZW1vcnkiKSA9PSAwKTsN
Cj4gKwlyZXR1cm4gKHN0cmNtcChidWYsICJpYm0scG1lbW9yeSIpID09IDAgfHwNCj4gKwkJc3Ry
Y21wKGJ1ZiwgIm52ZGltbV90ZXN0IikgPT0gMCk7DQoNCkknbSBndWVzc2luZyB0aGlzIG5hbWUg
Y29tZXMgZnJvbSB0aGUga2VybmVsPyBJdCB3b3VsZCBiZSBuaWNlIHRvIG1ha2UNCml0IHN5bW1l
dHJpY2FsIHdpdGggJ25maXRfdGVzdCcgYnkgY2FsbGluZyB0aGUgYnVzICdwYXByX3Rlc3QnIG1h
eWJlLA0KYnV0IG5vIHdvcnJpZXMgaWYgaXQgaXMgdG9vIGxhdGUgZm9yIHRoYXQuDQoNCj4gwqB9
DQo+IA0KPiDCoC8qKg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4w
MS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVA
bGlzdHMuMDEub3JnCg==
