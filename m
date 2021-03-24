Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D94348292
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Mar 2021 21:06:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BB8A2100F224E;
	Wed, 24 Mar 2021 13:06:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 26895100F224B
	for <linux-nvdimm@lists.01.org>; Wed, 24 Mar 2021 13:06:36 -0700 (PDT)
IronPort-SDR: 9buAmnKvwqkW8Wu22XRR29VlOvnAqn2MyE5LNUvKsvYb0U3S+EtjlITNQmF7jrJc3y21Z7IDc9
 UdQEqp+Cl3rg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="275902254"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400";
   d="scan'208";a="275902254"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 13:06:35 -0700
IronPort-SDR: yr97og3uta+ZTV4+eRXrCd46evCq4EEW+P9FyHE+8MhreSCUdVQUkMAoVw2xtpKQZx6JJAHhvJ
 5BgXx1+9Xumw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400";
   d="scan'208";a="391424143"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2021 13:06:34 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Mar 2021 13:06:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 24 Mar 2021 13:06:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 24 Mar 2021 13:06:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TteNB+KnF4cyzky9WFT1VxbJzLuAO3jVPxS1KWBAWbnCcltCfuYfVbyCduUmxlhzOljJ3Qtf0vza9MwK4djf3BVKQCiL9h3Oqs8J64BKzRR5uLvcf4WV14xyF09C6LSWnPo3y+FWOd39h23+dCh+jg3GT1Gp0yAfaHQBBPFcqJp54s3Io7sM1WqCRsehBEH6JKcKJCLKBV1Pgw6b4blTPidQjWyEdzMC62XCLOHZb5FNb7GD8TmkWLHMoRzFJssGz8MIcXxclgvjfG7LmpPUVjG8TjYBKAuca3n9iDNeTNC6/S1B2jFr59Susjp4BfDJPcoQ8w7nLYHs1gUeW+h9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZOpDRQL8TZc8VrEyCXl/hjcD64c4BRd+PMJpjIcXkU=;
 b=lbSAyPSmSJKznvwsYupWkr/WijLemPsDRpnqmD+mNi74SBNWRIewq6+2MfgmGW9HNBGWKCxUAN6p9U7fIL2NXWcPgNW1dw20heH66REHOWcU59qqYBRADzKen+byID52WDSA+zfGNH5K921P3EpCnPfL++K9HSY2MwEAPgao92Q5xTaiR91HDUcBP+mGIF5lFgdbTi+yTQO4T6FGSx9f0KoOz0JpvSLdg+a6IXzn60WBWC4NbPNzdaPfZ/f6TlNFsx72t6VknPiTX87bxyBO/ieM4LySnLtTaZF5RZqRngIR3VmYF3Olm+YMc4cC7emqy2otTnxX/MCLPEZYISO3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZOpDRQL8TZc8VrEyCXl/hjcD64c4BRd+PMJpjIcXkU=;
 b=dlQ1+zfj1hXJh3HvYnHTN86Dr7FccyUIIYyILhN+agpGoll/KK81Yyk2PkZJLp080WB/PLUYrNMtJfnnd9pwLJfruodCqgH6z0eYMu81HdHOHwVKBeuVs0BKM0P2XBCNI9UA1T19FeZZ5sODvTB6wBjI1VNyfjTFUsCHyDJzJKI=
Received: from SN6PR11MB3455.namprd11.prod.outlook.com (2603:10b6:805:bb::26)
 by SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 20:06:32 +0000
Received: from SN6PR11MB3455.namprd11.prod.outlook.com
 ([fe80::4985:93ec:d030:7de8]) by SN6PR11MB3455.namprd11.prod.outlook.com
 ([fe80::4985:93ec:d030:7de8%3]) with mapi id 15.20.3955.024; Wed, 24 Mar 2021
 20:06:32 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "sbhat@linux.ibm.com" <sbhat@linux.ibm.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "harish@linux.ibm.com" <harish@linux.ibm.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "santosh@fossix.org"
	<santosh@fossix.org>, "vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH v3 2/4] test: Don't skip tests if nfit modules are
 missing
Thread-Topic: [ndctl PATCH v3 2/4] test: Don't skip tests if nfit modules are
 missing
Thread-Index: AQHXFksIEZlcGvNvxEa83aRI7xDLvqqIyVSAgAIRtoCACMq8gA==
Date: Wed, 24 Mar 2021 20:06:32 +0000
Message-ID: <7467b623b77b4e7232433632d8b110490ca66473.camel@intel.com>
References: <20210311074652.2783560-1-santosh@fossix.org>
	 <20210311074652.2783560-2-santosh@fossix.org>
	 <6a62d78cfccf9f544a991df8334433a1e01021ba.camel@intel.com>
	 <87czvv1ykm.fsf@santosiv.in.ibm.com>
In-Reply-To: <87czvv1ykm.fsf@santosiv.in.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c69c97b-2bc1-4e1d-001e-08d8ef0051ad
x-ms-traffictypediagnostic: SN6PR11MB2718:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2718C391DCCB167F22A7E45DC7639@SN6PR11MB2718.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Am9FwUpmkKSylt1TNT8NnKZ0VJ7TIm2+AGExso7N5ayGMu+vlV7EbQTWVLpLaxVLcNwNn9zrrmwLpqrqg/gZ69Y/+7xEl7uZdLYleTki7WDw6BMKWmzyRlEIPxqLXncHHIWw1MNQgcN6ti9axSHrfV7Z5D2X51trnMeWFfyKWIO8OsnU00ioAMv8mk+LgCdAJOsl+FNWov9ctAlxxGzN3+awr+TA42EgmF/41Xk7c1vcINHv5T0z33rq8v/vhpqsX2nxbyNIF0VF0/iP68pqDgaaCYYYCu1lHwB7V9GksSt0TiSpQmf/9Ajyy2H7cuSi6gMzitLvuzkWZkRc2Id7OYKzMuz8oYMQDrxerN3sYAPiIFx7kgMicrn3WqOxKdLtq8rr8JyMcv0nddGOArrFeUna3IzdHjGzxqUln3+vMpH0K5Ofi44NkQcBv84Urxd96aZRSTsT9P/5Wxj0F+9xgHx9fB6YidABw5cXpBVyQi3BUh+BcRNiDgTkQCfO/niJaz1vnrJaRVg6IGyaDaJrFAPSLsQANs8fnVCcSrVfkidjFJaXk5MiOtIzE85ruVWvedQkwffoLgO79Yg2OWvI98F7O2K25pMsr0dgoFUkEVunMRtLLb9KUcOlLkiKz2XHcqrNPn0Zi6WYSHXI/TOqp0eT9/C8jRqPd88FJBhZNnM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(136003)(396003)(346002)(38100700001)(316002)(478600001)(76116006)(2616005)(110136005)(2906002)(86362001)(91956017)(8936002)(5660300002)(83380400001)(71200400001)(66946007)(66556008)(66446008)(6486002)(26005)(64756008)(6512007)(8676002)(66476007)(6506007)(186003)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?T3ZKQ3ZKZzgwZm5pZ2ExVnNPYWZTd2ZiQi80REZYSUp2UFhLR24wMUJmb0xC?=
 =?utf-8?B?UStTazZvaGM1WVFCWDdQMTl3UVV2bDY0aU5LaUpwYVVpejJDcXhPN0owTjV1?=
 =?utf-8?B?UE1yRlJEK3VJR21NYmdseGRPMG5JcTZJd3l5YWZTUlI1OGlQNk9UbDFpOVNW?=
 =?utf-8?B?WFlLVm9iQVQ0VEpxc28xd1NXK0ZRcDRhMjZCWmZpUEswZDN6SDROWlV5c1hN?=
 =?utf-8?B?RUdzSUk3WEhHL0JMVzBBbERJVDFDcTZSKzMyQlRBWEd2ZXR3VktFQWYrT0NL?=
 =?utf-8?B?MisvcnR2NVhoZkdyeEovcGRhU0IvTnJmcTlPOTB3TGE1T1p1RmF1REhsZFRn?=
 =?utf-8?B?QXlYS0FIeTVYNWE2Vk0wSXUvd3RMY1JGdno0UlJ3blZtVDlNWGpxWEZuVjBB?=
 =?utf-8?B?eTMxeHlZdlNUeVdzSXFWRk5BbEJUUDJjVFNGYWZQRWJCbUcxL2R5UytYMHlO?=
 =?utf-8?B?VzFCUmFwN0tXSHNOaDdRd1FNb2FoQ1V4cFY2aXNmNXlwc281d3VvWFJjbldM?=
 =?utf-8?B?V3RWbSthZUJucEF2OFg2a0xTamJma3B5TnZzT1NRczZNb3lNOGFMa3FjTkQ5?=
 =?utf-8?B?Y0R3cm5VaXJpVnVDbUora2xPeUoveHdHMHl3V2VzalZrUGZWcG5UNE9LV2hH?=
 =?utf-8?B?NHoxQ0U1dnI0QUYwRDRFbC9yMDZmN3k4aWkxVU03V2hUU011dzdwSUJsdkV2?=
 =?utf-8?B?anpjRGlucEdSUnZsQlRIdVF5NmVVam5NbWVSOXhXWnFrSDQyMGVENGJCU2Vz?=
 =?utf-8?B?N3RWYmtqUG5jNGdnTXVoMm91RTM1blgwT0dyWGllcTQxVWJCcWpiRGtGKzlI?=
 =?utf-8?B?enF2bmVFZVY4ZTh6YnVzeXlWeVJpM3RJaXE1UnhSdXd1RUFQR3FLYThrNzRr?=
 =?utf-8?B?SnNiQmVib2k5L0ozd2lkbERmdHVwOWtCUWZjU1NKTGxsRHF6VDVHZFRPV2U2?=
 =?utf-8?B?ZE15VUdXQkdVVmZ5aU45TlRMYWE2ZWxuOWNhakZsR1dsbDBJVDVTY1dIb2NS?=
 =?utf-8?B?M2xGTVRKdUROZzA1ZFhSaW1HekI0dGtodnN1MXNyclFVYUNmK05jOGhvdWVF?=
 =?utf-8?B?NFVTN3ZSRzhvT3FvM285VHp4Q1lkcEliV2lqSVRINm9tNHFRNkxrTXRhaExm?=
 =?utf-8?B?RCtva0JkTityTVVsc2NhOFc2a2xQSnFCUy9YWWRQQklpU281dUlmdXpEaXpw?=
 =?utf-8?B?eU9VR3ZwUW9Tb2RWK0o4ckRReDBQd1dxaS83b0ZCSDhzZm1Ub094blI1MFRu?=
 =?utf-8?B?U1RBalQ1RWRLOHBFZUdoYnhXL3BsNFZORWZiWWtRc2VoVkZacGdRbUV4QWhY?=
 =?utf-8?B?ZmFEbE1XUXZoZUE5OVluZG1lR2o4VGNKdHhYV3h3NFJ6bWVBVmlOMEFCSmRm?=
 =?utf-8?B?MG5vYXdObGk5bkJ0Q05tQ1VhMzhER1F1Wkd4dkhmWkE1K1BGMUtTZTlGZVVv?=
 =?utf-8?B?bFcvd0pCRmNPR2JEZzJCMjVEcXhYc09ycjVienRubXF4YTlGMElRc1h4UnFz?=
 =?utf-8?B?QXVYK3pBbGljUzR3QVprMytqSi9VQ1lzcVdNSndQMzZOa2QxbGNHbG5VOW1S?=
 =?utf-8?B?RGhiYitnZTFwNVVrVlV5QS9JaE1JOFNQUjkySi82bFFqOXJtZ3hycjFxV01D?=
 =?utf-8?B?dWJoV0toT0c0dHQ3T1RJQlJSMzZYRVFXOW9qSjRCUGthMG1qdWNSZkZIYUtY?=
 =?utf-8?B?dDBXa1ZheUZjSjRDdUs3dWVEdUkweStiWkRTN254akZjUUZlMEhtZ1ZvWkFN?=
 =?utf-8?Q?2sDgd8HIiIyqHJMYB34tg3u8T1GUetU4/TGuWcC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5845458B06C77D4984F64EE028728322@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c69c97b-2bc1-4e1d-001e-08d8ef0051ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 20:06:32.0856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+lY9LvyK4Iw4PJVERUMlR8jxBd82Ln1AQRUWaK2H/bDG8mSP/3r7fs7GwROLJZbJLu7GjgKkm5xoNOj0qmwyyo2F12JQGIy28gtGkAYWCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2718
X-OriginatorOrg: intel.com
Message-ID-Hash: LHF6TSVS4IDUI3JTDMVNV6QWW7Z2MWY6
X-Message-ID-Hash: LHF6TSVS4IDUI3JTDMVNV6QWW7Z2MWY6
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LHF6TSVS4IDUI3JTDMVNV6QWW7Z2MWY6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDIxLTAzLTE5IGF0IDExOjIwICswNTMwLCBTYW50b3NoIFNpdmFyYWogd3JvdGU6
DQo+ICJWZXJtYSwgVmlzaGFsIEwiIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+IHdyaXRlczoN
Cg0KWy4uXQ0KDQo+ID4gDQo+ID4gZml4IG11bHRpIGxpbmUgY29tbWVudCB0byB0aGUgcmlnaHQg
Zm9ybWF0dGluZzoNCj4gPiAvKg0KPiA+IMKgKiBsaW5lIDEsIGV0Yw0KPiA+IMKgKi8NCj4gPiAN
Cj4gDQo+IFdpbGwgZml4IHRoYXQuDQo+IA0KPiA+ID4gKwlpZiAoYWNjZXNzKCIvc3lzL2J1cy9h
Y3BpIiwgRl9PSykgPT0gLTEpIHsNCj4gPiA+ICsJCWlmIChlcnJubyA9PSBFTk9FTlQpDQo+ID4g
PiArCQkJZmFtaWx5ID0gTlZESU1NX0ZBTUlMWV9QQVBSOw0KPiA+ID4gKwl9DQo+ID4gDQo+ID4g
SW5zdGVhZCBvZiBhIGJsaW5kIGRlZmF1bHQsIGNhbiB3ZSBwZXJmb3JtIGEgc2ltaWxhciBjaGVj
ayBmb3IgcHJlc2VuY2Ugb2YNCj4gPiBQQVBSIHRvbz8NCj4gPiANCj4gDQo+IFllcywgSSB3YW50
ZWQgdG8gZG8gdGhhdCwgYnV0IHRoZXJlIGlzIG5vIHJlbGlhYmxlIHdheSBvZiBjaGVjayB0aGF0
OyB0aGVyZSBpcw0KPiBubyBvZm5vZGUgYmVmb3JlIG1vZHVsZSBsb2FkLCBhbmQgdGhlcmUgd29u
J3QgYmUgYW55IFBBUFIgc3BlY2lmaWMgRFQgZW50cmllcyBpZg0KPiB0aGUgcGxhdGZvcm0gaXMg
bm90IFBvd2VyLg0KPiANCj4gSSBhbHNvIHRlc3QgdGhlICduZHRlc3QnIG1vZHVsZSBvbiB4ODYg
d2l0aCBORENUTF9URVNUX0ZBTUlMWSBlbnZpcm9ubWVudA0KPiB2YXJpYWJsZS4gSSBjYW4gbGV0
IHRoZSBkZWZhdWx0IGJlIG5maXRfdGVzdCAoTlZESU1NX0ZBTUlMWV9JTlRFTCkgYW5kIG9ubHkg
bG9hZA0KPiBQQVBSIG1vZHVsZSB3aGVuIHRoZSBlbnZpcm9ubWVudCB2YXJpYWJsZSBpcyBzZXQu
IFRob3VnaHRzPw0KPiANClRoZSBlbnYgdmFyaWFibGUgc2VlbXMgcmVhc29uYWJsZSB0byBtZS4g
SWYgdGhlcmUgaXMgZXZlciBhIHRoaXJkDQonZmFtaWx5JyBhZGRpbmcgdGVzdHMsIGhhdmluZyBh
biBhcmJpdHJhcnkgZGVmYXVsdCBtaWdodCBiZSBhd2t3YXJkLg0KSSBtYXkgc3VnZ2VzdCAtIGlm
IGFjcGkgaXMgZGV0ZWN0ZWQsIHVzZSBORklULiBJZiBlbnYgaGFzIHNvbWV0aGluZyB0aGF0DQpp
cyBrbm93biwgZS5nLiBQQVBSLCB1c2UgdGhhdC4gSWYgZW52IGlzIHVuc2V0IG9yIGRvZXNuJ3Qg
bWF0Y2ggYW55dGhpbmcNCndlIGtub3cgYWJvdXQsIHRoZW4gYmFpbCB3aXRoIGFuIGVycm9yIG1l
c3NhZ2UuIERvZXMgdGhhdCBzb3VuZA0KcmVhc29uYWJsZT8NCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0g
bGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRv
IGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
