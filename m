Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B4A33FADC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Mar 2021 23:15:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D6874100EB85D;
	Wed, 17 Mar 2021 15:15:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 540E7100EB847
	for <linux-nvdimm@lists.01.org>; Wed, 17 Mar 2021 15:15:00 -0700 (PDT)
IronPort-SDR: rr/QkxcSBV95Hms6WNWj+o4FNw9qlY5qDtR/FdyL+fNBbdGUUM4IOfr/EG6ZLz039ubQVG1awd
 nYPt3BQqhW4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="189647141"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400";
   d="scan'208";a="189647141"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 15:14:59 -0700
IronPort-SDR: vvIHGET29KKLNI7+EdxnwQ6acyp3q+TgAELSpwgAhfflnjS0QDApPKxenquJi5/q2mwOdmrhXA
 x/wVrd2khSuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400";
   d="scan'208";a="411637077"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2021 15:14:59 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 15:14:59 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 15:14:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 17 Mar 2021 15:14:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 17 Mar 2021 15:14:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l62nVRiQrSpcpZFaIZH1fTf9IQJzUIoHAUUaHN8caN11KoSk8+jQSgJj8NjAvk7vJV3SfLvcDD1Hy3PdcDbZgVWlUgNzcC2kUUYaa/8CrOIz/rqWp+d9sec1SlGoNc33+R//S1FAGzI9HG9KX6CtiUX7aYHH632uYmFYtdYFfAtORbynDO7LOpDgBCk6Q7vmKPvOepAAb+iO/SFqogJMcWOYTrI4kA2dK/NhnRU1R8O6L57g1xsa/jjBD+iszLx7vSTi2B54NGeOShdd8HrBE1vFr3BXRIjdBlI/qxERrN9EWHpsjdZbtZBIMUCOFZNLeKMfsHn4/YB5W6M0rQ+3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oOZsYeKbSBs4P+OInywlWjE4M7GoqsRoIwbMQvMNYo=;
 b=cEoBtPHH0vQsVHKdBOFye8uVuCa8io1Wb8ZyB1OLY4Nw1eSCXf4BNPw5z3VfBna7aOoolZy+4fjJWnCWFbThynUhwgqWJCk5H1yaiv7AFS1wnku7Ec1/UgTc1pB8yUkxqMFYtdPPovYYJ6CiaFlrZqGA4AYvbgbblf4V/o1ygcvjx/ieye0cszatgK+hhyQExq7PSSL45GjyU0INNs/03sM+Rpv1PmjI5IO6dOQGs/p/rH7AtMtxcow5ItkdS2bLtCci5KAVfkYTA1k9bQRIby9WmAtJPOkVOdd+ZZk3u2FPmSxK2wPqs95hxTHjSH3v5nuzDtCJmR5Xi82NWwSxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oOZsYeKbSBs4P+OInywlWjE4M7GoqsRoIwbMQvMNYo=;
 b=GmmLswYJ1sAvaO9nL817jE+ziBYr20Tds560wZ+91nr0KNoVxUCHlvYFeUR5YUzscYXAnQod41LsT1NDn4Nvw9oxXSKfj0tECE0ylXartJJSOmSl02Zky8NKKweGIfh2+KhOIfgzEH4GEc8wJR1aHeHjv74y8NTmu3ck8LKsqho=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BY5PR11MB4150.namprd11.prod.outlook.com (2603:10b6:a03:190::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 22:14:56 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 22:14:56 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "sbhat@linux.ibm.com" <sbhat@linux.ibm.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "harish@linux.ibm.com" <harish@linux.ibm.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "santosh@fossix.org"
	<santosh@fossix.org>, "vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH v3 2/4] test: Don't skip tests if nfit modules are
 missing
Thread-Topic: [ndctl PATCH v3 2/4] test: Don't skip tests if nfit modules are
 missing
Thread-Index: AQHXFksIEZlcGvNvxEa83aRI7xDLvqqIyVSA
Date: Wed, 17 Mar 2021 22:14:56 +0000
Message-ID: <6a62d78cfccf9f544a991df8334433a1e01021ba.camel@intel.com>
References: <20210311074652.2783560-1-santosh@fossix.org>
	 <20210311074652.2783560-2-santosh@fossix.org>
In-Reply-To: <20210311074652.2783560-2-santosh@fossix.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9089a137-94a9-472d-2c4d-08d8e99218a8
x-ms-traffictypediagnostic: BY5PR11MB4150:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB41504DF4676343D7371DD7A0C76A9@BY5PR11MB4150.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ifq9M7DJGCu1lBsejqE7pQffR5XmcmaKSVxhaiOAZKQ9J82q+P9pnWi3V+RVDwnyOHyxH40iM5f1Se3qpZq7/zz4RqQmBYXuqIdSL5bymkjaHZTjzq9jRc++YJ5B/yC4RUWTkyNNCJ1Sgq9EoNChqo4a5UcdMHY3tp3ZyRNVmkjBB77HdAfFcfXadeoZFH10UhE+bzRXJPt9CKQU5gyV+tHbZXy+LYrtaTG8AaQrWP70WRxA1KrBL6BXRN9p+8BeZNHessL3WvLgVpXcq5oPbo4Dj/5MAEgwGBvueFV/lG3B8Xh3cZ25PBNb1L8oNEyrb0gv8JIrGtUtt7bCTovGDyuvHrX4vySqy/XyWACIJmLiwMjsg/NMRJgBpz6C28VBSB5AtnyNy4x4DcENf2oOhuP80+En6CJ+w+bh1esC4tIXuS8RGsT5Jw516pUO/ZvlVQ9ySmB/qdM511Etk/WFQrzPfGWiaCC3p1C9039hTxlWPNpRfhfSeVFomaxc9JMxbNW+Es/ld/yOpaQs6bCeIUZSuiDFw+c5Rh59J4/AKXrpFjeRBMnASV2PB/3huKiX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(366004)(376002)(346002)(26005)(66946007)(66556008)(8676002)(66446008)(64756008)(6486002)(66476007)(5660300002)(478600001)(76116006)(91956017)(186003)(2906002)(6506007)(83380400001)(71200400001)(36756003)(6512007)(8936002)(2616005)(86362001)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Vy9ZNFFYcHJKQWx4aW04RVVjUDRucGNPUVdsc2FnV3lsQmJiRzh0NHBQMWsy?=
 =?utf-8?B?RGN6SnNDRUdIZmh0ODNpVDlqa3BiS1h1dHBnLzZCZWdBRVVCUFI4MmFKbW9a?=
 =?utf-8?B?Ukp1c0lQMExKQklwSjQ5VDFPZm5nU3lUck0wUXlPVktXb0JZRVZTcGZRNk5n?=
 =?utf-8?B?U25yQ25XUVBDY25EOGZqanRYR3F0UXd1VTZ0aXZrSjJhYy9JQzhuVWZ0WnN0?=
 =?utf-8?B?bW1wcFJQV1haY3pUMCtvWDkrMmt0V2FJTFl5TUN3ZHVHTDcwOVJsUzdOMGxB?=
 =?utf-8?B?a1lmVERva0JuSHduOCtLVGJQR09YOWNUMHduZC84THFxKzdRMmxLNU9CTVN0?=
 =?utf-8?B?dW5VcEFIUm42Q2lkckVxSDdKQ3gyNUd2alJoR25Qelo5c25OTndJSllERktH?=
 =?utf-8?B?dmJMMGF3SktuYkZJcW56RSt5Y1RjWTNMM2UxOVdLbGMvbE9MemZudVJhOThG?=
 =?utf-8?B?UFJPRmVCR2dqTExWTVNnLzdzc045VXh6Vmg1Z2dXK0lGMFd1WUY1eGF6djJv?=
 =?utf-8?B?M0NBSThBSHczb09lYTR3ZHJZU09pOWhocVpRWG1hYmVKY2tJWXFMdGxSMjV3?=
 =?utf-8?B?NlQ5ZTl4dWdWV0dTWERxdjJkYXlQSXd1ZXg2SzZDS1ZMYnd2STVSaEVYRlJj?=
 =?utf-8?B?ZXltekI2VEp2d3kvdjRMaFBhVVppTXJTRUorSnFnL0ZCREd2V1FNcHJMV3VT?=
 =?utf-8?B?Uys2eDlLeHhWcUNWNCs5MFUrNnFNb0xTRFIzRzByU0FreVZYL3NrNE5uSTJ6?=
 =?utf-8?B?K1BFOHVVWkxOUVNGODZxL21Mcmo2NUVGOTNBZTUxMVhhN3BWOWdiOWxiU2tM?=
 =?utf-8?B?a3NkWXd1UmJ2UzFYOVljZ25wL0hxTkl6UFpGRzBSVWJKZk1TMFRweERFendv?=
 =?utf-8?B?RmxFREVTa2JsRGl5MU9XdWFJampWV2RKWFFHaENXYmNrUXdZL3RJd1lYbi9G?=
 =?utf-8?B?aDEvZ1dqa3UxK2J6Q3ljckpKUUtZVE9Oc3BHWENsUE1UVWwwS1ExN3dkcFU1?=
 =?utf-8?B?WHNOTXY3VFlhYzhwUmYvREtCQzZlNW9ZNkhZT2QxbFMyaFA4R1pSaGpzc2JB?=
 =?utf-8?B?U0VpeFljczRQWHU1ZkdtaktQS1NudzJ0QnRxNVR5SWs5VTVJTHQveVBEWkp1?=
 =?utf-8?B?QzJkbDdOMlZ1VU1qUDRpWkVNakw2WEJpT0xJL0pUV3kyRmlLQ3hERjl0Ky9M?=
 =?utf-8?B?b3Qyc0RibVdOV21FY3pISlV3UWtqN3FsWllaVHFtOTFTQ3RIak9vNjJwZ1JV?=
 =?utf-8?B?S3ZrT0krR1JJS0VWY0JtZk45RStsOHFENzlIRVl5c3FqQnNMT1UvaEpVY3ZG?=
 =?utf-8?B?NHZNZHI1RGxOQ2xOU1JnUy8zaHVRcUlSczN2cnN5N0ZvS21qckR2aFJuY3la?=
 =?utf-8?B?UXV1WmQrQWdCaWZrbXl6MkI4U21qZ1ZpZ2Z6cjdBRnRzQko0L0NpZjlLTkhM?=
 =?utf-8?B?RWNBQkpiZDcvdlZYeWhURzV5U3lsK3dweEk2K2ZYditHV2F4NmUvNDQ3SGFY?=
 =?utf-8?B?U2QvbVhsQjUxUnAyQllXWFhZUzByNUF5czZNUE5GNWRkb3lIcjNjRmVWSmdr?=
 =?utf-8?B?U3Y1b1FkOGxTYTJHZHUvZDFBVEk4Y1E5MVJPTWwxOEZldVgwZVErZ1FnZjVW?=
 =?utf-8?B?UmFOQmt2SjNTanQyUTY1N2pJajFGMWNXY3B1dll1YVB5Zm81VEpvZFp4RDZT?=
 =?utf-8?B?Yit2emhFU1pIRWZjMXpoK0JLUHUxVDdVRWg0RkYrWXQwOUJVUE5VNGxQQlJH?=
 =?utf-8?B?WjZ5RkZwUHN5TUt6R0Vndys1emNLYVNVNHZuaE5qdFVTengxZTJicHo0RDVj?=
 =?utf-8?B?d3hxTmM2USt1SWRyMzlYdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46D9D45C32D11E45BA3D13DCE606BDA1@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9089a137-94a9-472d-2c4d-08d8e99218a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 22:14:56.0487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYK/Dd2IjhNmMRvyADA/aXZoqXc0ZtpVD4xqrbD95yFctuOqAt1vGKuegxN3xoiVNOIPhxFwbjj6CnK+PjJYMkVyFJBaYsMQexq03CUNqb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4150
X-OriginatorOrg: intel.com
Message-ID-Hash: H7SM2R7MZWSZAAZWYYPZ6G2OZF3XHC6Z
X-Message-ID-Hash: H7SM2R7MZWSZAAZWYYPZ6G2OZF3XHC6Z
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/H7SM2R7MZWSZAAZWYYPZ6G2OZF3XHC6Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDIxLTAzLTExIGF0IDEzOjE2ICswNTMwLCBTYW50b3NoIFNpdmFyYWogd3JvdGU6
DQo+IEZvciBORklUIHRvIGJlIGF2YWlsYWJsZSBBQ1BJIGlzIGEgbXVzdCwgc28gZG9uJ3QgZmFp
bCB3aGVuIG5maXQgbW9kdWxlcw0KPiBhcmUgbWlzc2luZyBvbiBhIHBsYXRmb3JtIHRoYXQgZG9l
c24ndCBzdXBwb3J0IEFDUEkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTYW50b3NoIFNpdmFyYWog
PHNhbnRvc2hAZm9zc2l4Lm9yZz4NCj4gLS0tDQo+IMKgdGVzdC5oICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMiArLQ0KPiDCoHRlc3QvYWNrLXNodXRkb3duLWNvdW50LXNldC5jIHwgIDIgKy0N
Cj4gwqB0ZXN0L2Jsa19uYW1lc3BhY2VzLmMgICAgICAgICB8ICAyICstDQo+IMKgdGVzdC9jb3Jl
LmMgICAgICAgICAgICAgICAgICAgfCAyMyArKysrKysrKysrKysrKysrKysrKystLQ0KPiDCoHRl
c3QvZHBhLWFsbG9jLmMgICAgICAgICAgICAgIHwgIDIgKy0NCj4gwqB0ZXN0L2RzbS1mYWlsLmMg
ICAgICAgICAgICAgICB8ICAyICstDQo+IMKgdGVzdC9saWJuZGN0bC5jICAgICAgICAgICAgICAg
fCAgMiArLQ0KPiDCoHRlc3QvbXVsdGktcG1lbS5jICAgICAgICAgICAgIHwgIDIgKy0NCj4gwqB0
ZXN0L3BhcmVudC11dWlkLmMgICAgICAgICAgICB8ICAyICstDQo+IMKgdGVzdC9wbWVtX25hbWVz
cGFjZXMuYyAgICAgICAgfCAgMiArLQ0KPiDCoDEwIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlv
bnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3QuaCBiL3Rlc3Qu
aA0KPiBpbmRleCBjYmE4ZDQxLi43ZGUxM2ZlIDEwMDY0NA0KPiAtLS0gYS90ZXN0LmgNCj4gKysr
IGIvdGVzdC5oDQo+IEBAIC0yMCw3ICsyMCw3IEBAIHZvaWQgYnVpbHRpbl94YWN0aW9uX25hbWVz
cGFjZV9yZXNldCh2b2lkKTsNCj4gwqANCj4gDQo+IMKgc3RydWN0IGttb2RfY3R4Ow0KPiDCoHN0
cnVjdCBrbW9kX21vZHVsZTsNCj4gLWludCBuZml0X3Rlc3RfaW5pdChzdHJ1Y3Qga21vZF9jdHgg
KipjdHgsIHN0cnVjdCBrbW9kX21vZHVsZSAqKm1vZCwNCj4gK2ludCBuZGN0bF90ZXN0X2luaXQo
c3RydWN0IGttb2RfY3R4ICoqY3R4LCBzdHJ1Y3Qga21vZF9tb2R1bGUgKiptb2QsDQo+IMKgCQlz
dHJ1Y3QgbmRjdGxfY3R4ICpuZF9jdHgsIGludCBsb2dfbGV2ZWwsDQo+IMKgCQlzdHJ1Y3QgbmRj
dGxfdGVzdCAqdGVzdCk7DQo+IMKgDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdC9hY2stc2h1dGRv
d24tY291bnQtc2V0LmMgYi90ZXN0L2Fjay1zaHV0ZG93bi1jb3VudC1zZXQuYw0KPiBpbmRleCBm
YjFkODJiLi5jNTYxZmYzIDEwMDY0NA0KPiAtLS0gYS90ZXN0L2Fjay1zaHV0ZG93bi1jb3VudC1z
ZXQuYw0KPiArKysgYi90ZXN0L2Fjay1zaHV0ZG93bi1jb3VudC1zZXQuYw0KPiBAQCAtOTksNyAr
OTksNyBAQCBzdGF0aWMgaW50IHRlc3RfYWNrX3NodXRkb3duX2NvdW50X3NldChpbnQgbG9nbGV2
ZWwsIHN0cnVjdCBuZGN0bF90ZXN0ICp0ZXN0LA0KPiDCoAlpbnQgcmVzdWx0ID0gRVhJVF9GQUlM
VVJFLCBlcnI7DQo+IMKgDQo+IA0KPiDCoAluZGN0bF9zZXRfbG9nX3ByaW9yaXR5KGN0eCwgbG9n
bGV2ZWwpOw0KPiAtCWVyciA9IG5maXRfdGVzdF9pbml0KCZrbW9kX2N0eCwgJm1vZCwgTlVMTCwg
bG9nbGV2ZWwsIHRlc3QpOw0KPiArCWVyciA9IG5kY3RsX3Rlc3RfaW5pdCgma21vZF9jdHgsICZt
b2QsIE5VTEwsIGxvZ2xldmVsLCB0ZXN0KTsNCj4gwqAJaWYgKGVyciA8IDApIHsNCj4gwqAJCXJl
c3VsdCA9IDc3Ow0KPiDCoAkJbmRjdGxfdGVzdF9za2lwKHRlc3QpOw0KPiBkaWZmIC0tZ2l0IGEv
dGVzdC9ibGtfbmFtZXNwYWNlcy5jIGIvdGVzdC9ibGtfbmFtZXNwYWNlcy5jDQo+IGluZGV4IGQ3
ZjAwY2IuLmYwNzZlODUgMTAwNjQ0DQo+IC0tLSBhL3Rlc3QvYmxrX25hbWVzcGFjZXMuYw0KPiAr
KysgYi90ZXN0L2Jsa19uYW1lc3BhY2VzLmMNCj4gQEAgLTIyOCw3ICsyMjgsNyBAQCBpbnQgdGVz
dF9ibGtfbmFtZXNwYWNlcyhpbnQgbG9nX2xldmVsLCBzdHJ1Y3QgbmRjdGxfdGVzdCAqdGVzdCwN
Cj4gwqANCj4gDQo+IMKgCWlmICghYnVzKSB7DQo+IMKgCQlmcHJpbnRmKHN0ZGVyciwgIkFDUEku
TkZJVCB1bmF2YWlsYWJsZSBmYWxsaW5nIGJhY2sgdG8gbmZpdF90ZXN0XG4iKTsNCj4gLQkJcmMg
PSBuZml0X3Rlc3RfaW5pdCgma21vZF9jdHgsICZtb2QsIE5VTEwsIGxvZ19sZXZlbCwgdGVzdCk7
DQo+ICsJCXJjID0gbmRjdGxfdGVzdF9pbml0KCZrbW9kX2N0eCwgJm1vZCwgTlVMTCwgbG9nX2xl
dmVsLCB0ZXN0KTsNCj4gwqAJCW5kY3RsX2ludmFsaWRhdGUoY3R4KTsNCj4gwqAJCWJ1cyA9IG5k
Y3RsX2J1c19nZXRfYnlfcHJvdmlkZXIoY3R4LCAibmZpdF90ZXN0LjAiKTsNCj4gwqAJCWlmIChy
YyA8IDAgfHwgIWJ1cykgew0KPiBkaWZmIC0tZ2l0IGEvdGVzdC9jb3JlLmMgYi90ZXN0L2NvcmUu
Yw0KPiBpbmRleCBjYzdkOGQ5Li45MDMwMzRhIDEwMDY0NA0KPiAtLS0gYS90ZXN0L2NvcmUuYw0K
PiArKysgYi90ZXN0L2NvcmUuYw0KPiBAQCAtMTEsNiArMTEsNyBAQA0KPiDCoCNpbmNsdWRlIDx1
dGlsL2xvZy5oPg0KPiDCoCNpbmNsdWRlIDx1dGlsL3N5c2ZzLmg+DQo+IMKgI2luY2x1ZGUgPG5k
Y3RsL2xpYm5kY3RsLmg+DQo+ICsjaW5jbHVkZSA8bmRjdGwvbmRjdGwuaD4NCj4gwqAjaW5jbHVk
ZSA8Y2Nhbi9hcnJheV9zaXplL2FycmF5X3NpemUuaD4NCj4gwqANCj4gDQo+IMKgI2RlZmluZSBL
VkVSX1NUUkxFTiAyMA0KPiBAQCAtMTA2LDExICsxMDcsMTEgQEAgaW50IG5kY3RsX3Rlc3RfZ2V0
X3NraXBwZWQoc3RydWN0IG5kY3RsX3Rlc3QgKnRlc3QpDQo+IMKgCXJldHVybiB0ZXN0LT5za2lw
Ow0KPiDCoH0NCj4gwqANCj4gDQo+IC1pbnQgbmZpdF90ZXN0X2luaXQoc3RydWN0IGttb2RfY3R4
ICoqY3R4LCBzdHJ1Y3Qga21vZF9tb2R1bGUgKiptb2QsDQo+ICtpbnQgbmRjdGxfdGVzdF9pbml0
KHN0cnVjdCBrbW9kX2N0eCAqKmN0eCwgc3RydWN0IGttb2RfbW9kdWxlICoqbW9kLA0KPiDCoAkJ
c3RydWN0IG5kY3RsX2N0eCAqbmRfY3R4LCBpbnQgbG9nX2xldmVsLA0KPiDCoAkJc3RydWN0IG5k
Y3RsX3Rlc3QgKnRlc3QpDQo+IMKgew0KPiAtCWludCByYzsNCj4gKwlpbnQgcmMsIGZhbWlseSA9
IE5WRElNTV9GQU1JTFlfSU5URUw7DQo+IMKgCXVuc2lnbmVkIGludCBpOw0KPiDCoAljb25zdCBj
aGFyICpuYW1lOw0KPiDCoAlzdHJ1Y3QgbmRjdGxfYnVzICpidXM7DQo+IEBAIC0xMjcsNiArMTI4
LDE5IEBAIGludCBuZml0X3Rlc3RfaW5pdChzdHJ1Y3Qga21vZF9jdHggKipjdHgsIHN0cnVjdCBr
bW9kX21vZHVsZSAqKm1vZCwNCj4gwqAJCSJuZF9lODIwIiwNCj4gwqAJCSJuZF9wbWVtIiwNCj4g
wqAJfTsNCj4gKwljaGFyICp0ZXN0X2VudjsNCj4gKw0KPiArCS8qIERvIHdlIHdhbnQgdG8gZm9y
Y2UgdGVzdCBQQVBSPyAqLw0KPiArCXRlc3RfZW52ID0gZ2V0ZW52KCJORENUTF9URVNUX0ZBTUlM
WSIpOw0KPiArCWlmICh0ZXN0X2VudiAmJiBzdHJjbXAodGVzdF9lbnYsICJQQVBSIikgPT0gMCkN
Cj4gKwkJZmFtaWx5ID0gTlZESU1NX0ZBTUlMWV9QQVBSOw0KPiArDQo+ICsJLyogQUNQSSBpcyBh
IG11c3QgZm9yIG5maXQsIHNvIGlmIEFDUEkgaXMgbm90IGF2YWlsYWJsZSBsZXQncyBkZWZhdWx0
IHRvDQo+ICsJICogUEFQUiAqLw0KDQpmaXggbXVsdGkgbGluZSBjb21tZW50IHRvIHRoZSByaWdo
dCBmb3JtYXR0aW5nOg0KLyoNCiAqIGxpbmUgMSwgZXRjDQogKi8NCg0KPiArCWlmIChhY2Nlc3Mo
Ii9zeXMvYnVzL2FjcGkiLCBGX09LKSA9PSAtMSkgew0KPiArCQlpZiAoZXJybm8gPT0gRU5PRU5U
KQ0KPiArCQkJZmFtaWx5ID0gTlZESU1NX0ZBTUlMWV9QQVBSOw0KPiArCX0NCg0KSW5zdGVhZCBv
ZiBhIGJsaW5kIGRlZmF1bHQsIGNhbiB3ZSBwZXJmb3JtIGEgc2ltaWxhciBjaGVjayBmb3IgcHJl
c2VuY2Ugb2YNClBBUFIgdG9vPw0KDQo+IMKgDQo+IA0KPiDCoAlsb2dfaW5pdCgmbG9nX2N0eCwg
InRlc3QvaW5pdCIsICJORENUTF9URVNUIik7DQo+IMKgCWxvZ19jdHgubG9nX3ByaW9yaXR5ID0g
bG9nX2xldmVsOw0KPiBAQCAtMTg1LDYgKzE5OSwxMSBAQCByZXRyeToNCj4gwqANCj4gDQo+IMKg
CQlwYXRoID0ga21vZF9tb2R1bGVfZ2V0X3BhdGgoKm1vZCk7DQo+IMKgCQlpZiAoIXBhdGgpIHsN
Cj4gKwkJCWlmIChmYW1pbHkgPT0gTlZESU1NX0ZBTUlMWV9QQVBSICYmDQo+ICsJCQkgICAgKHN0
cmNtcChuYW1lLCAibmZpdCIpID09IDAgfHwNCj4gKwkJCSAgICAgc3RyY21wKG5hbWUsICJuZF9l
ODIwIikgPT0gMCkpDQo+ICsJCQkJY29udGludWU7DQo+ICsNCj4gwqAJCQlsb2dfZXJyKCZsb2df
Y3R4LCAiJXMua286IGZhaWxlZCB0byBnZXQgcGF0aFxuIiwgbmFtZSk7DQo+IMKgCQkJYnJlYWs7
DQo+IMKgCQl9DQo+IGRpZmYgLS1naXQgYS90ZXN0L2RwYS1hbGxvYy5jIGIvdGVzdC9kcGEtYWxs
b2MuYw0KPiBpbmRleCBlOTIyMDA5Li4wYjNiYjdhIDEwMDY0NA0KPiAtLS0gYS90ZXN0L2RwYS1h
bGxvYy5jDQo+ICsrKyBiL3Rlc3QvZHBhLWFsbG9jLmMNCj4gQEAgLTI4OSw3ICsyODksNyBAQCBp
bnQgdGVzdF9kcGFfYWxsb2MoaW50IGxvZ2xldmVsLCBzdHJ1Y3QgbmRjdGxfdGVzdCAqdGVzdCwg
c3RydWN0IG5kY3RsX2N0eCAqY3R4KQ0KPiDCoAkJcmV0dXJuIDc3Ow0KPiDCoA0KPiANCj4gwqAJ
bmRjdGxfc2V0X2xvZ19wcmlvcml0eShjdHgsIGxvZ2xldmVsKTsNCj4gLQllcnIgPSBuZml0X3Rl
c3RfaW5pdCgma21vZF9jdHgsICZtb2QsIE5VTEwsIGxvZ2xldmVsLCB0ZXN0KTsNCj4gKwllcnIg
PSBuZGN0bF90ZXN0X2luaXQoJmttb2RfY3R4LCAmbW9kLCBOVUxMLCBsb2dsZXZlbCwgdGVzdCk7
DQo+IMKgCWlmIChlcnIgPCAwKSB7DQo+IMKgCQluZGN0bF90ZXN0X3NraXAodGVzdCk7DQo+IMKg
CQlmcHJpbnRmKHN0ZGVyciwgIm5maXRfdGVzdCB1bmF2YWlsYWJsZSBza2lwcGluZyB0ZXN0c1xu
Iik7DQo+IGRpZmYgLS1naXQgYS90ZXN0L2RzbS1mYWlsLmMgYi90ZXN0L2RzbS1mYWlsLmMNCj4g
aW5kZXggOWRmZDhiMC4uMGE2MzgzZCAxMDA2NDQNCj4gLS0tIGEvdGVzdC9kc20tZmFpbC5jDQo+
ICsrKyBiL3Rlc3QvZHNtLWZhaWwuYw0KPiBAQCAtMzQ2LDcgKzM0Niw3IEBAIGludCB0ZXN0X2Rz
bV9mYWlsKGludCBsb2dsZXZlbCwgc3RydWN0IG5kY3RsX3Rlc3QgKnRlc3QsIHN0cnVjdCBuZGN0
bF9jdHggKmN0eCkNCj4gwqAJaW50IHJlc3VsdCA9IEVYSVRfRkFJTFVSRSwgZXJyOw0KPiDCoA0K
PiANCj4gwqAJbmRjdGxfc2V0X2xvZ19wcmlvcml0eShjdHgsIGxvZ2xldmVsKTsNCj4gLQllcnIg
PSBuZml0X3Rlc3RfaW5pdCgma21vZF9jdHgsICZtb2QsIE5VTEwsIGxvZ2xldmVsLCB0ZXN0KTsN
Cj4gKwllcnIgPSBuZGN0bF90ZXN0X2luaXQoJmttb2RfY3R4LCAmbW9kLCBOVUxMLCBsb2dsZXZl
bCwgdGVzdCk7DQo+IMKgCWlmIChlcnIgPCAwKSB7DQo+IMKgCQlyZXN1bHQgPSA3NzsNCj4gwqAJ
CW5kY3RsX3Rlc3Rfc2tpcCh0ZXN0KTsNCj4gZGlmZiAtLWdpdCBhL3Rlc3QvbGlibmRjdGwuYyBi
L3Rlc3QvbGlibmRjdGwuYw0KPiBpbmRleCAyNGQ3MmIzLi4wZTg4ZmNlIDEwMDY0NA0KPiAtLS0g
YS90ZXN0L2xpYm5kY3RsLmMNCj4gKysrIGIvdGVzdC9saWJuZGN0bC5jDQo+IEBAIC0yNjkyLDcg
KzI2OTIsNyBAQCBpbnQgdGVzdF9saWJuZGN0bChpbnQgbG9nbGV2ZWwsIHN0cnVjdCBuZGN0bF90
ZXN0ICp0ZXN0LCBzdHJ1Y3QgbmRjdGxfY3R4ICpjdHgpDQo+IMKgCWRheGN0bF9zZXRfbG9nX3By
aW9yaXR5KGRheGN0bF9jdHgsIGxvZ2xldmVsKTsNCj4gwqAJbmRjdGxfc2V0X3ByaXZhdGVfZGF0
YShjdHgsIHRlc3QpOw0KPiDCoA0KPiANCj4gLQllcnIgPSBuZml0X3Rlc3RfaW5pdCgma21vZF9j
dHgsICZtb2QsIGN0eCwgbG9nbGV2ZWwsIHRlc3QpOw0KPiArCWVyciA9IG5kY3RsX3Rlc3RfaW5p
dCgma21vZF9jdHgsICZtb2QsIGN0eCwgbG9nbGV2ZWwsIHRlc3QpOw0KPiDCoAlpZiAoZXJyIDwg
MCkgew0KPiDCoAkJbmRjdGxfdGVzdF9za2lwKHRlc3QpOw0KPiDCoAkJZnByaW50ZihzdGRlcnIs
ICJuZml0X3Rlc3QgdW5hdmFpbGFibGUgc2tpcHBpbmcgdGVzdHNcbiIpOw0KPiBkaWZmIC0tZ2l0
IGEvdGVzdC9tdWx0aS1wbWVtLmMgYi90ZXN0L211bHRpLXBtZW0uYw0KPiBpbmRleCAzZDEwOTUy
Li4zZWEwOGNjIDEwMDY0NA0KPiAtLS0gYS90ZXN0L211bHRpLXBtZW0uYw0KPiArKysgYi90ZXN0
L211bHRpLXBtZW0uYw0KPiBAQCAtMjQ5LDcgKzI0OSw3IEBAIGludCB0ZXN0X211bHRpX3BtZW0o
aW50IGxvZ2xldmVsLCBzdHJ1Y3QgbmRjdGxfdGVzdCAqdGVzdCwgc3RydWN0IG5kY3RsX2N0eCAq
Y3R4DQo+IMKgDQo+IA0KPiDCoAluZGN0bF9zZXRfbG9nX3ByaW9yaXR5KGN0eCwgbG9nbGV2ZWwp
Ow0KPiDCoA0KPiANCj4gLQllcnIgPSBuZml0X3Rlc3RfaW5pdCgma21vZF9jdHgsICZtb2QsIE5V
TEwsIGxvZ2xldmVsLCB0ZXN0KTsNCj4gKwllcnIgPSBuZGN0bF90ZXN0X2luaXQoJmttb2RfY3R4
LCAmbW9kLCBOVUxMLCBsb2dsZXZlbCwgdGVzdCk7DQo+IMKgCWlmIChlcnIgPCAwKSB7DQo+IMKg
CQlyZXN1bHQgPSA3NzsNCj4gwqAJCW5kY3RsX3Rlc3Rfc2tpcCh0ZXN0KTsNCj4gZGlmZiAtLWdp
dCBhL3Rlc3QvcGFyZW50LXV1aWQuYyBiL3Rlc3QvcGFyZW50LXV1aWQuYw0KPiBpbmRleCA2NDI0
ZTlmLi5iZGVkMzNhIDEwMDY0NA0KPiAtLS0gYS90ZXN0L3BhcmVudC11dWlkLmMNCj4gKysrIGIv
dGVzdC9wYXJlbnQtdXVpZC5jDQo+IEBAIC0yMTgsNyArMjE4LDcgQEAgaW50IHRlc3RfcGFyZW50
X3V1aWQoaW50IGxvZ2xldmVsLCBzdHJ1Y3QgbmRjdGxfdGVzdCAqdGVzdCwgc3RydWN0IG5kY3Rs
X2N0eCAqY3QNCj4gwqAJCXJldHVybiA3NzsNCj4gwqANCj4gDQo+IMKgCW5kY3RsX3NldF9sb2df
cHJpb3JpdHkoY3R4LCBsb2dsZXZlbCk7DQo+IC0JZXJyID0gbmZpdF90ZXN0X2luaXQoJmttb2Rf
Y3R4LCAmbW9kLCBOVUxMLCBsb2dsZXZlbCwgdGVzdCk7DQo+ICsJZXJyID0gbmRjdGxfdGVzdF9p
bml0KCZrbW9kX2N0eCwgJm1vZCwgTlVMTCwgbG9nbGV2ZWwsIHRlc3QpOw0KPiDCoAlpZiAoZXJy
IDwgMCkgew0KPiDCoAkJbmRjdGxfdGVzdF9za2lwKHRlc3QpOw0KPiDCoAkJZnByaW50ZihzdGRl
cnIsICJuZml0X3Rlc3QgdW5hdmFpbGFibGUgc2tpcHBpbmcgdGVzdHNcbiIpOw0KPiBkaWZmIC0t
Z2l0IGEvdGVzdC9wbWVtX25hbWVzcGFjZXMuYyBiL3Rlc3QvcG1lbV9uYW1lc3BhY2VzLmMNCj4g
aW5kZXggZjBmMmVkZC4uYTRkYjFhZSAxMDA2NDQNCj4gLS0tIGEvdGVzdC9wbWVtX25hbWVzcGFj
ZXMuYw0KPiArKysgYi90ZXN0L3BtZW1fbmFtZXNwYWNlcy5jDQo+IEBAIC0xOTEsNyArMTkxLDcg
QEAgaW50IHRlc3RfcG1lbV9uYW1lc3BhY2VzKGludCBsb2dfbGV2ZWwsIHN0cnVjdCBuZGN0bF90
ZXN0ICp0ZXN0LA0KPiDCoA0KPiANCj4gwqAJaWYgKCFidXMpIHsNCj4gwqAJCWZwcmludGYoc3Rk
ZXJyLCAiQUNQSS5ORklUIHVuYXZhaWxhYmxlIGZhbGxpbmcgYmFjayB0byBuZml0X3Rlc3RcbiIp
Ow0KPiAtCQlyYyA9IG5maXRfdGVzdF9pbml0KCZrbW9kX2N0eCwgJm1vZCwgTlVMTCwgbG9nX2xl
dmVsLCB0ZXN0KTsNCj4gKwkJcmMgPSBuZGN0bF90ZXN0X2luaXQoJmttb2RfY3R4LCAmbW9kLCBO
VUxMLCBsb2dfbGV2ZWwsIHRlc3QpOw0KPiDCoAkJbmRjdGxfaW52YWxpZGF0ZShjdHgpOw0KPiDC
oAkJYnVzID0gbmRjdGxfYnVzX2dldF9ieV9wcm92aWRlcihjdHgsICJuZml0X3Rlc3QuMCIpOw0K
PiDCoAkJaWYgKHJjIDwgMCB8fCAhYnVzKSB7DQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51
eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGlu
dXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
