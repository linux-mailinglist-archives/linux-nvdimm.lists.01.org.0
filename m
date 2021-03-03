Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AFE32BF28
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Mar 2021 00:12:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D0673100EB35C;
	Wed,  3 Mar 2021 15:12:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9BA45100EB35A
	for <linux-nvdimm@lists.01.org>; Wed,  3 Mar 2021 15:12:31 -0800 (PST)
IronPort-SDR: bduEC+CGOWkOpAb76RPoUEjTF1VYZu9dwkExGfE3N4KsEfCOjBhBwy3MP5G528vAzqm5UOL7ua
 FvJz9Z05AApg==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="187354825"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400";
   d="scan'208";a="187354825"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 15:12:31 -0800
IronPort-SDR: 9Qyl0iyFq6DvoixLVLWDUfil/rPS9Jw01n1DD7zZEKWk0SWY8rLBEtQkwWe3HCdTdhYRXdgNNz
 5FM99evfxh7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400";
   d="scan'208";a="367782044"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 03 Mar 2021 15:12:31 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Mar 2021 15:12:30 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Mar 2021 15:12:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 3 Mar 2021 15:12:30 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 3 Mar 2021 15:12:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJA98ryfM01ESzOV0rajIK/zoX24JbmsVfsETMZUUKM0tXDCkgsGaVWh6bub8+iVRsOBKQivC5a1yFNpz3CzlrGNZQkTzmUYabVDms1xi+7rulzCXpbIv9ZiGxoHNY7EfJGanlpHY1zsfRyeS3kQfkDk8dc7Siyu4CPrXcXLa9XQgRkItdGcyo5vmoZWTEdZlSEivQMk3rY89SI4Vxq7YyglPnfqoCX2+3qKl8Knj99w0OYaIhkp/7oEaFWe0SSB66WdN7GuiY2CLJ3XSjH52uO11Ql+uBkYFw7uIFvN6O88qt75iJ5ObIzgdXqUMV0O9VVcQX+yxJ604O13JI+xXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPckX8vFuP7fDAdOtDKE9ghCZP9knCk7ZBUg/IwMuWI=;
 b=U5D0HxyfgsW+s8Iu9/Sar5h7HEI4KZkWP+nQwyzE1XEqmSpbh1A4SSZQjMp285se8AMy3a1NB3e3RpIuiFp4x9pJ8uDpo81Qr/5B5UPMKfKhmDKOLhtALu+bWc8glSwRTVR2EaeNnwqIVGd+i6yLK1Y2Vfb4Fb3rixKgpryp1c1Yjfe7vwkRQNL8UVN9a+Whte5S7thTMdV7QB9J+6hsqT9lwRFEUaqfxvZ5oh4eMirdV7L08Yeh/HGdMCYU/Za3nPLqeX3mxMDA70OkfcEgFk1+zG6lXh3DEonoAFPL3E3SR5MRRcIKYDNRX5xvyd1muHDGjOf8fyo4RPdWY10BYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPckX8vFuP7fDAdOtDKE9ghCZP9knCk7ZBUg/IwMuWI=;
 b=aW/WI7RXbcUbOqJjXQis5eR5DbtuFByuOrT1Zl5PrNDFlubfXyyv+QP2uOpkUVKkTac8242w5QOiCH84E+AjnhIrYE/dxALDCN5h9TnUEe/uV0qxPJS8d+AyGxPUDh33dPrPEaYTXuW02nPPv1MlWgL8gJVBL7O7+CwNLltMhh4=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2725.namprd11.prod.outlook.com (2603:10b6:a02:c5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Wed, 3 Mar
 2021 23:12:29 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3%3]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 23:12:29 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Tsaur, Erwin"
	<erwin.tsaur@intel.com>
CC: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v2] Expose ndctl_bus_nfit_translate_spa as a public
 function.
Thread-Topic: [ndctl PATCH v2] Expose ndctl_bus_nfit_translate_spa as a public
 function.
Thread-Index: AQHXEHHOFpuSbFEjf0GuGTsJZAYErqpy5HgA
Date: Wed, 3 Mar 2021 23:12:28 +0000
Message-ID: <28b95b86506f9ecdd9ee7a6fc825dfc471d910b6.camel@intel.com>
References: <20210303211009.2913-1-erwin.tsaur@intel.com>
In-Reply-To: <20210303211009.2913-1-erwin.tsaur@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc6f00c0-2711-42f5-c080-08d8de99d0f6
x-ms-traffictypediagnostic: BYAPR11MB2725:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB27250346E38B402B2B77BC69C7989@BYAPR11MB2725.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UJ1gtscmXVjscs1FoE2wS6Mgv8wfU9jL2fzGAlESRpGewRW+CwEc33YdrmpjKd+kQsIfvlbQEJCXsNGfEd7fMNft+HRWthUpnJV8d2WYQPoTLnLNuYSSVWBGqGf0YbbeYS1xgyPBy0R/C15xhAXFg8PmIHQtTwi87MWshNt9m4hEAIdkTbw5uOHUdMBAOt3bbHNU2VVkbxiIDkbN3Ks3zaTGxczEem0nQgYU0wlFsGNXL8cZ1kxXNn0+n/miLQIrTcFfx+bPolVL8BBXqftnxZ1pgAdCv87zBQqLspz68mMt60iY4+D3XhMEr3aGTvn6rjp0PkLvGsnqBak2sG0erFFt6A7YQbF9VFgLWsxw8ovc2O9b4YPqDJo1VeC8pTYRe01NF38UGOOM9BH+SVqmDvoV/JRcNKU/RBHkFxseO2lajmI+S55IlYV8KYiZUgWPuEGfo3oBFrPDeW6A5hKaNqKB4Xn5EINHgAE0JJCkifSAsNfL2TZ3j5guHYfQSLh6+1IUWs2RMoux8itYUnigiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(396003)(366004)(26005)(76116006)(66946007)(36756003)(66556008)(186003)(86362001)(6636002)(110136005)(91956017)(5660300002)(8936002)(66446008)(8676002)(2906002)(83380400001)(6486002)(64756008)(316002)(4326008)(2616005)(66476007)(6506007)(71200400001)(478600001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YWc2WTVkL2h3NldCVkcwVVcwRFZSZkVTUVJKK0NnNFdZUjlQOTdBUE83U1ZJ?=
 =?utf-8?B?MVJZTXJiRXRkeCtzc3JBam1OZDl3SDRySDFjTFZDSFBZNHpVRzUzREpqVGNu?=
 =?utf-8?B?dEl3ZmRBWU9qZW4vQlJ0TVM1bVpkcWg4aGRRdXdmeWh4OEt2SFViQUpMS0Rm?=
 =?utf-8?B?aGRGc1J6RTd4dmlPUG41T1NJN0Uxcng2enJSK2VPaGhxSFpMWTUvTVJHKy80?=
 =?utf-8?B?MlR1L2hJVnNsMms5a1dlU2FheTMzeGRvMG1jd2VWNjhzWGJrK2kvT0RNeG0y?=
 =?utf-8?B?SE41d0hITGtJVEZKOVVhQWlQd1pPZGh4WG5UNkMvTWNQOTBnNWdmQjVoTC9Q?=
 =?utf-8?B?MlBrekZTR0N2S2RSSGlyM0kyd3JGVDJvZ3RvS2xUbnVncEdGeU1OS085emk4?=
 =?utf-8?B?bUY1MVB0dm90Vzc3NnpUMlY1N1NPY2JRS3RmNytabzI3bDJ0WDRTZ0ZvdTAw?=
 =?utf-8?B?dWRUL1ZqV0M3akJtWk11dXJ2a1Jxczc5by9CdU5hYy9iRWtrLzdTLzd2ZnFQ?=
 =?utf-8?B?QkVnVlRaMEdsK2tpY01RcmNlcStGQXhLby96RDNHT3NBZ25TK3BSNHNuNVBV?=
 =?utf-8?B?UGhKdmF6MlFGSEplTUtqeWdYdGNrZFFoRlozZ1NKTDB4OWpGZVlEUytTOEw3?=
 =?utf-8?B?SzZXOVdEUE1abGJhbEErNzhLUGdYbm5NMTBaaVFsQWxPaFE0aXlWSWxabU5P?=
 =?utf-8?B?Q2NWbjhRQXdSV2xXUElwSU5VNys0cXlUclZpZk1xdnJwaGtZd0kvMTVYYXk2?=
 =?utf-8?B?TUJFY2V3VG9qRDRCZjBBY3lJb3Z2WDhmbHJRN3pQRS9YRThqMldLdDFmQnRZ?=
 =?utf-8?B?WnlHTkJGa3FmbkRCV21QV0pUNVpLbjNQbHVwc3NSNUhCMjVlME9yc1ZmTVY1?=
 =?utf-8?B?TTBTcFdlMXJ1STFoSzV0RS9iVU9YeXJLSzV0a2MzN2dJMEF4cUpVQ1lKd2VM?=
 =?utf-8?B?blhIWGt3YzJrNHpBOURQRTVEc2phaFpQZHk4dldFeGpYei83eXdzdHVjS0FK?=
 =?utf-8?B?WEJWVElCQ28zaFVaRjVZMFN5a09DOEFjWk1qbys1cjNkZWdjZnJvYTBPVWNr?=
 =?utf-8?B?Zllmc0JXa2svaURyQUtOSVVDaVpDR1JjVE1TUGo3RjlqMTNwUXBqSEVxbGY2?=
 =?utf-8?B?WTVDeWptcTVJbTAwWmFZUjFDbmpHMWJOaXBNQ3Jhdm42b2s4S0FnYkI2TzFs?=
 =?utf-8?B?LzZ2U2FEYVE2aHBjUEJxNFM0N3NmYUs3UWhGcnV3U2F5M1NoMGxIUnJHUE9p?=
 =?utf-8?B?ZEhPUDhHTWRkZEcwRm5rOVNmTkpZMEJOMTJNN0F6VWh6MzF1c3dmbmJ1VEY3?=
 =?utf-8?B?N01SekRteVFZWE1zNWQyWmtFbmdadi9oMzNIL3YvbW5PZjlTVEREeXkvU1pC?=
 =?utf-8?B?T0xYQW1jeWtWbDlNbnMxUmZ5clplTVJwZis4Q3djeVcxT3pHZ3FJdHc1WTF3?=
 =?utf-8?B?QnlTNHhQTHlSeE1KQ2tmQ1dDeG1pdW9seStYcHQ4bzd3SmZmY1RiVUVpWkYx?=
 =?utf-8?B?OHlOWDFGN2hJSnB6VzdITUJxMWI2RzZ3T1g1N3VtTWhCMi8xVVd6YW1TblZJ?=
 =?utf-8?B?OTNDUTl5WkVHWjROemRkZE5HOWpzMCtrR1Q2Z2ZHZnZQeUVHQnhwVlExcDF3?=
 =?utf-8?B?U0lJaE1kZ09SczJza0k3TUh0bGl0eE9kWXl6bWxTbWJoN2paM2lqWVM4Uk9w?=
 =?utf-8?B?N0s5NGNJeDVuYWxsVW1LSDRzd0hXMXpZZGo3UVIrZHErajkwcXY4ekRsRGRD?=
 =?utf-8?B?Vmo0c2FWMEdnTm9UNE1WZWR0WWtKR1E4bTJxYSsvQUdMZjdvRGpKMi8vcVBX?=
 =?utf-8?B?ek5HQnZBQUpNNGMxSFBCQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <453431E43FE3024EB47D0E1D64F44C72@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6f00c0-2711-42f5-c080-08d8de99d0f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 23:12:28.9210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtJZwnlXTZ4knfxp7Zo64zWXG6PYFO+dPw35IecDgxNVPFLWMmDvN/k8VXyz3gsJojypdbhf8v3Zoy+0cL5Yumoyn55OqY4innRIF3lfyf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2725
X-OriginatorOrg: intel.com
Message-ID-Hash: R3UB6C3RSIVXMTIMJTVTZP4Y5GL5ZS7N
X-Message-ID-Hash: R3UB6C3RSIVXMTIMJTVTZP4Y5GL5ZS7N
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R3UB6C3RSIVXMTIMJTVTZP4Y5GL5ZS7N/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

T24gV2VkLCAyMDIxLTAzLTAzIGF0IDEzOjEwIC0wODAwLCBUc2F1ciwgRXJ3aW4gd3JvdGU6DQo+
IFRoZSBtb3RpdmF0aW9uIGlzIHRvIGFsbG93IGFjY2VzcyB0byBBQ1BJIGRlZmluZWQgTlZESU1N
IFJvb3QgRGV2aWNlDQo+IF9EU00gRnVuY3Rpb24gSW5kZXggNShUcmFuc2xhdGUgU1BBKS4gIFRo
ZSByZXN0IG9mIHRoZSBfRFNNIGZ1bmN0aW9ucywNCj4gd2hpY2ggYXJlIG1vc3RseSBBUlMgcmVs
YXRlZCwgYXJlIGFscmVhZHkgcHVibGljLg0KPiANCj4gQmFzaWNhbGx5IG1vdmUgbmRjdGxfYnVz
X25maXRfdHJhbnNsYXRlX3NwYSBkZWNsYXJhdGlvbiBmcm9tIHByaXZhdGUuaA0KPiB0byBsaWJu
ZGN0bC5oLg0KPiANCj4gQ2hhbmdlcyBmcm9tIFYxOg0KPiAtIEdyb3VwIGZ1bmN0aW9uIGRlY2xh
cmF0aW9uIGluIGxpYm5kY3RsLmggd2l0aCBvdGhlciBuZGN0bF9idXNfKiBmdW5jdGlvbnMuDQo+
IA0KPiBSZXZpZXdlZC1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+
DQo+IFJldmlld2VkLWJ5OiBWZXJtYSwgVmlzaGFsIEwgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNv
bT4NCg0KSGkgRXJ3aW4sDQoNCkkgZm9yZ290IHRvIG1lbnRpb24gdGhpcyBmb3IgdjEgYnV0IHlv
dSdyZSBhbHNvIG1pc3NpbmcgeW91ciBvd24gU2lnbmVkLQ0Kb2ZmLWJ5LiBJZiB5b3UgY29tbWl0
IHVzaW5nICdnaXQgY29tbWl0IC1zJywgdGhhdCBzaG91bGQgYXV0b21hdGljYWxseQ0KYWRkIGl0
IGZvciB5b3UuDQpEbyB5b3UgbWluZCBzZW5kaW5nIGEgdjMgd2l0aCB0aGF0LCBhbmQgSSdsbCBn
ZXQgaXQgcXVldWVkIHVwLg0KDQpUaGVyZSdzIGFsc28gYSBtYWxmb3JtZWQgZW1haWwgQ0MgLSBJ
IHRoaW5rIHlvdSB3YW50IHRvIHF1b3RlIHRoZSAtLWNjDQpsaW5lIHRvIGdpdC1zZW5kLWVtYWls
IGxpa2U6IC0tY2M9Im5hbWUgPGVtYWlsPiINCg0KPiAtLS0NCj4gwqBuZGN0bC9saWIvbGlibmRj
dGwuc3ltIHwgNCArKysrDQo+IMKgbmRjdGwvbGliL25maXQuYyAgICAgICB8IDIgKy0NCj4gwqBu
ZGN0bC9saWIvcHJpdmF0ZS5oICAgIHwgMiAtLQ0KPiDCoG5kY3RsL2xpYm5kY3RsLmggICAgICAg
fCAyICsrDQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmRjdGwvbGliL2xpYm5kY3RsLnN5bSBiL25kY3RsL2xp
Yi9saWJuZGN0bC5zeW0NCj4gaW5kZXggMGE4MjYxNi4uNThhZmI3NCAxMDA2NDQNCj4gLS0tIGEv
bmRjdGwvbGliL2xpYm5kY3RsLnN5bQ0KPiArKysgYi9uZGN0bC9saWIvbGlibmRjdGwuc3ltDQo+
IEBAIC00NTEsMyArNDUxLDcgQEAgTElCTkRDVExfMjUgew0KPiDCoAluZGN0bF9idXNfY2xlYXJf
ZndfYWN0aXZhdGVfbm9zdXNwZW5kOw0KPiDCoAluZGN0bF9idXNfYWN0aXZhdGVfZmlybXdhcmU7
DQo+IMKgfSBMSUJORENUTF8yNDsNCj4gKw0KPiArTElCTkRDVExfMjYgew0KPiArCW5kY3RsX2J1
c19uZml0X3RyYW5zbGF0ZV9zcGE7DQo+ICt9IExJQk5EQ1RMXzI1Ow0KPiBkaWZmIC0tZ2l0IGEv
bmRjdGwvbGliL25maXQuYyBiL25kY3RsL2xpYi9uZml0LmMNCj4gaW5kZXggNmY2OGZjZi4uZDg1
NjgyZiAxMDA2NDQNCj4gLS0tIGEvbmRjdGwvbGliL25maXQuYw0KPiArKysgYi9uZGN0bC9saWIv
bmZpdC5jDQo+IEBAIC0xMTQsNyArMTE0LDcgQEAgc3RhdGljIGludCBpc192YWxpZF9zcGEoc3Ry
dWN0IG5kY3RsX2J1cyAqYnVzLCB1bnNpZ25lZCBsb25nIGxvbmcgc3BhKQ0KPiDCoMKgKg0KPiDC
oMKgKiBJZiBzdWNjZXNzLCByZXR1cm5zIHplcm8sIHN0b3JlIGRpbW0ncyBAaGFuZGxlLCBhbmQg
QGRwYS4NCj4gwqDCoCovDQo+IC1pbnQgbmRjdGxfYnVzX25maXRfdHJhbnNsYXRlX3NwYShzdHJ1
Y3QgbmRjdGxfYnVzICpidXMsDQo+ICtORENUTF9FWFBPUlQgaW50IG5kY3RsX2J1c19uZml0X3Ry
YW5zbGF0ZV9zcGEoc3RydWN0IG5kY3RsX2J1cyAqYnVzLA0KPiDCoAl1bnNpZ25lZCBsb25nIGxv
bmcgYWRkcmVzcywgdW5zaWduZWQgaW50ICpoYW5kbGUsIHVuc2lnbmVkIGxvbmcgbG9uZyAqZHBh
KQ0KPiDCoHsNCj4gwqANCj4gDQo+IA0KPiANCj4gZGlmZiAtLWdpdCBhL25kY3RsL2xpYi9wcml2
YXRlLmggYi9uZGN0bC9saWIvcHJpdmF0ZS5oDQo+IGluZGV4IGVkZTEzMDAuLjhmNDUxMGUgMTAw
NjQ0DQo+IC0tLSBhL25kY3RsL2xpYi9wcml2YXRlLmgNCj4gKysrIGIvbmRjdGwvbGliL3ByaXZh
dGUuaA0KPiBAQCAtMzcwLDggKzM3MCw2IEBAIHN0YXRpYyBpbmxpbmUgaW50IGNoZWNrX2ttb2Qo
c3RydWN0IGttb2RfY3R4ICprbW9kX2N0eCkNCj4gwqAJcmV0dXJuIGttb2RfY3R4ID8gMCA6IC1F
TlhJTzsNCj4gwqB9DQo+IMKgDQo+IA0KPiANCj4gDQo+IC1pbnQgbmRjdGxfYnVzX25maXRfdHJh
bnNsYXRlX3NwYShzdHJ1Y3QgbmRjdGxfYnVzICpidXMsIHVuc2lnbmVkIGxvbmcgbG9uZyBhZGRy
LA0KPiAtCQl1bnNpZ25lZCBpbnQgKmhhbmRsZSwgdW5zaWduZWQgbG9uZyBsb25nICpkcGEpOw0K
PiDCoHN0cnVjdCBuZGN0bF9jbWQgKm5kY3RsX2J1c19jbWRfbmV3X2Vycl9pbmooc3RydWN0IG5k
Y3RsX2J1cyAqYnVzKTsNCj4gwqBzdHJ1Y3QgbmRjdGxfY21kICpuZGN0bF9idXNfY21kX25ld19l
cnJfaW5qX2NscihzdHJ1Y3QgbmRjdGxfYnVzICpidXMpOw0KPiDCoHN0cnVjdCBuZGN0bF9jbWQg
Km5kY3RsX2J1c19jbWRfbmV3X2Vycl9pbmpfc3RhdChzdHJ1Y3QgbmRjdGxfYnVzICpidXMsDQo+
IGRpZmYgLS1naXQgYS9uZGN0bC9saWJuZGN0bC5oIGIvbmRjdGwvbGlibmRjdGwuaA0KPiBpbmRl
eCA2MGUxMjg4Li44N2QwN2I3IDEwMDY0NA0KPiAtLS0gYS9uZGN0bC9saWJuZGN0bC5oDQo+ICsr
KyBiL25kY3RsL2xpYm5kY3RsLmgNCj4gQEAgLTE1Miw2ICsxNTIsOCBAQCBpbnQgbmRjdGxfYnVz
X2NsZWFyX2Z3X2FjdGl2YXRlX25vaWRsZShzdHJ1Y3QgbmRjdGxfYnVzICpidXMpOw0KPiDCoGlu
dCBuZGN0bF9idXNfc2V0X2Z3X2FjdGl2YXRlX25vc3VzcGVuZChzdHJ1Y3QgbmRjdGxfYnVzICpi
dXMpOw0KPiDCoGludCBuZGN0bF9idXNfY2xlYXJfZndfYWN0aXZhdGVfbm9zdXNwZW5kKHN0cnVj
dCBuZGN0bF9idXMgKmJ1cyk7DQo+IMKgaW50IG5kY3RsX2J1c19hY3RpdmF0ZV9maXJtd2FyZShz
dHJ1Y3QgbmRjdGxfYnVzICpidXMsIGVudW0gbmRjdGxfZndhX21ldGhvZCBtZXRob2QpOw0KPiAr
aW50IG5kY3RsX2J1c19uZml0X3RyYW5zbGF0ZV9zcGEoc3RydWN0IG5kY3RsX2J1cyAqYnVzLCB1
bnNpZ25lZCBsb25nIGxvbmcgYWRkciwNCj4gKwkJdW5zaWduZWQgaW50ICpoYW5kbGUsIHVuc2ln
bmVkIGxvbmcgbG9uZyAqZHBhKTsNCj4gwqANCj4gDQo+IA0KPiANCj4gwqBzdHJ1Y3QgbmRjdGxf
ZGltbTsNCj4gwqBzdHJ1Y3QgbmRjdGxfZGltbSAqbmRjdGxfZGltbV9nZXRfZmlyc3Qoc3RydWN0
IG5kY3RsX2J1cyAqYnVzKTsNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlz
dHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxl
YXZlQGxpc3RzLjAxLm9yZwo=
