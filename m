Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB622EB4E0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  5 Jan 2021 22:28:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BB2C7100EBB90;
	Tue,  5 Jan 2021 13:28:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BD272100EBB8F
	for <linux-nvdimm@lists.01.org>; Tue,  5 Jan 2021 13:28:49 -0800 (PST)
IronPort-SDR: kyJBtFyXhCOP8a7zeIelfIMPuZu2he/WG/0p2L60LMqRtt6oYnXNGX4SfpJVOLT6Nt+zQJRoo1
 WxMpc8kIzH2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="164253158"
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400";
   d="scan'208";a="164253158"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 13:28:49 -0800
IronPort-SDR: zu/Q41GkNSZLKh9dfW1WSuFFIccmRDjImRLQthTu7IFi8H2Gq5SC2miwITTSfQ4bdSZfkLsNN9
 bffOUVr0MHVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400";
   d="scan'208";a="361318321"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 05 Jan 2021 13:28:48 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 5 Jan 2021 13:28:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Jan 2021 13:28:48 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 5 Jan 2021 13:28:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjWYYRZ8jbtVHl6JU+zkqmLk6mZSHDTZzwDSSnIyCluormDOD/YrlNO3OPGqEN41Djvk/mCXgbsLHEGQBLtlf4q3Ve1ODek3IwMZwOAnqBrFXLxHqbfNXpAYVCRSi4YPNjtIB2DTM3Ccn7nXSJUdtlo+NGTldh7ZMDnKGgXA2VnGvkZFnIC+F2qOQp3s+Mxvx4AJxQGXnP1z7W+dkB2Hed/nF8Oc7Y1fSEqFSWhXU5Fk13BlUH60MvSYbNWuk60i6mvBHm+tlo/W4yWvw/xU5pI2PPkFNwA6JsJSTQQN3W3RSiXwKyUtbUspKXfXaEIWi09fLGd4+MtQeNHoTkmtzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtVFq8ddnkPomII3F1j7bfr1WzdAw8PfoJHmYRIoKD8=;
 b=Ls9Kumhjy2sAoE0Q//BvPVVCtHBVYxy5bg0xnTCfmyvWdAtkZRFb/ZMaHL+joqXW+8M3vr8nbW0qsNE4vLM66q61f5AowZXBcgiVQL5SUhqQBRTcgKKE359HQjbwzRnumAKlymuvzF+c476MZgs0cFQ+X4CrEmywaHDRB44XzlVA6xvkC0eA0J4A5AOC8U9eE6hu8wSctCjeMtseAwKwp/kTBNCO07T8bO5+BVOsnC07zv/JBGTRs/s6uA68Ih2EYV5XUjOv8vNDW2Y98bxRh4JgoEYZk25A8y+pJif3GZju7DY0TV6/iDWII1/p/ZS47Sl6Lnv1zWu7PN4xYGqntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtVFq8ddnkPomII3F1j7bfr1WzdAw8PfoJHmYRIoKD8=;
 b=x8Sj+CRzcY8Z+O34K77cXXiB+pQpI0fdBKhq+dm9RT52Yk4Fa/LEPjnRkp6eAartJwA8EhNMJu8JkgmJ1fM2ssycRUNX8igRfZscaiKH/SXlR0ksenMq0n03+vZiG1sER//H1shpMekDQ9qerIhTuCkmT1CpJ9imXm60rHjW8c4=
Received: from SN6PR11MB3455.namprd11.prod.outlook.com (2603:10b6:805:bb::26)
 by SN6PR11MB2606.namprd11.prod.outlook.com (2603:10b6:805:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 21:28:45 +0000
Received: from SN6PR11MB3455.namprd11.prod.outlook.com
 ([fe80::cc92:a803:6a73:1900]) by SN6PR11MB3455.namprd11.prod.outlook.com
 ([fe80::cc92:a803:6a73:1900%5]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 21:28:45 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>
Subject: Re: [PATCH] ACPI: NFIT: Fix flexible_array.cocci warnings
Thread-Topic: [PATCH] ACPI: NFIT: Fix flexible_array.cocci warnings
Thread-Index: AQHW46Y9FJnprgCRpEKiYT1qBtAd3qoZjDAA
Date: Tue, 5 Jan 2021 21:28:45 +0000
Message-ID: <3c31c3328f569f15f03de9eb8d1b6a9ae4862893.camel@intel.com>
References: <160988059854.2071197.11821323682102566548.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160988059854.2071197.11821323682102566548.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.2 (3.38.2-1.fc33) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb81feb7-6551-452a-2f29-08d8b1c0e1db
x-ms-traffictypediagnostic: SN6PR11MB2606:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB260643A99576A3D81C326B8DC7D10@SN6PR11MB2606.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QkyibXVdBdZOO6yWtWkKXKrqyzHBwsSE2b7cIcO5OfNgU+iDVbRDT+XQNVWIOxVlC/xmgeCK8CquOREV63SsGSvLzz4glX3hLdw+nHLxVHvoY4Qp3tpdQEUTXbJA/HbLseuxFO6o227+fetHeTtJkS8ptz5rPn9ksNDc4stXWawL6KsWCgkxpmkdhpIpTLD9ISbaplSQmLrs+htkDmPfkDNmB1rj83jTbTdpHD26l+xs2Pej5DLFbeO69qJEX6rMNCx9Sjgp/ZKMhj03RwWgeHnmYJ0Nmeo2176DaBnDYdTvtF8zq9Gi2Bz2qQX10edDCmI1bXCbbOPi1xpeI/+Ks0eU2ia+tvHCGVOQWhoR4i0t4Q3ztXINvKDiaNI9JlUOZaOVx+K2xo3RORJXDtS7xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(2906002)(6486002)(4326008)(8936002)(86362001)(110136005)(36756003)(83380400001)(316002)(6512007)(71200400001)(8676002)(6506007)(66446008)(2616005)(64756008)(186003)(66556008)(5660300002)(66476007)(66946007)(54906003)(76116006)(478600001)(91956017)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UDVNaml6YW90OXV4Z1R3V2VKR2Job2UzQW1ZUnNJRGx6amZ2Y0ViM1FWR0d6?=
 =?utf-8?B?WnZwVU82WnBQS2djVG83TzVOc3hNVXcwWGZGUHJqTHo2WU15RGZXNUVxMjMy?=
 =?utf-8?B?dUhsakNOMFVacXZMRHd2cy9sRzJ1Zk5rUkpUNVhJSm9aV3hVcE1XcVcvaFNm?=
 =?utf-8?B?T2VMRVB6NjU2KzZTcVljSGYwTjdvZGRac1ovWFBISkJRSkI3dUtLcnVGNXpN?=
 =?utf-8?B?VXU4T25HT3VEaDdTVmY1Y1FrOExIc0tmcVp5U0Y4Y2wzcmJvb2o1SzRNekZI?=
 =?utf-8?B?ZndxaDdJN1NYdEtRSWhvVXlEV0NKQjd4bG9yQzBIMHRPQms5U3FZdnkvR25F?=
 =?utf-8?B?eFdyOHpZUllHMjBTeVlTM1IxbnZLdzlWSjd0bHErSUJiV0N0VEdLeFNPM3JO?=
 =?utf-8?B?eUVqY1hXdzFpMElvOUZyMW16MkZIVUt5UExQSkxzSWJneWdQNXNzZFpSWjVt?=
 =?utf-8?B?N0QwbU8xL2xFdHBGYzBERXNXTEJLR0t5NnoyK1R3ZXc0Z3J3MEJoaS9YYlh3?=
 =?utf-8?B?a1pxMHVsNG0zazR1Z0VNL0hBRm1rRzhhYm9hOWRieTYwRGZiNWpDVWhqejAz?=
 =?utf-8?B?djlBaG1tYysrbnpsbjl4ZmxabkEwM2NUeW1rVFpDTEVneENYb08wREpIdm9G?=
 =?utf-8?B?M2xyZGdld3NRUzhUZnUzRFBkUFFQUnRkb2FERDBDbXNUOGVDQlFMMmZEeFBV?=
 =?utf-8?B?aVhTU09KVHE5dFNXRFBjK28zYnRtUE1oV3VPVldWMmRsMm45VC9VOFhoOTVt?=
 =?utf-8?B?bXlZZ1E2TGpyRXZoRG5MM3E3dUdTbTJqdHlsRlp5OWtsaUw0QXRkZ09Vazdu?=
 =?utf-8?B?UHRHNGNIcnNjLy9RYXNSSk1VTTRJN2l2a2FkUnJHem5IV0xSNlFNSFRMSVN5?=
 =?utf-8?B?TVd3dk1LMVpaNm52WjRVNEVpUThTRWtUdFlndWdtYzNVa1JxbmdtK1gyc1Fr?=
 =?utf-8?B?WGVkY0Y5YTVnUkd4a24xYzAxNUxNNzRTa3FRcGFQVFNiOGYxRnM4RVV3d0xn?=
 =?utf-8?B?ZzcrUTdUVUtlRXJnaWZUQ2k4L3FCYmI2bUM3Z3FTRm1sNnI5YlZVNjNvYk1D?=
 =?utf-8?B?Rmo3TGxLSEhmM2tmK3JmUUZJRW00V21tdldsRXFpMmFvMm5aTUMyaFlCNjM1?=
 =?utf-8?B?S3dDL0FwTjcwUjR5RGlRQ3U1OW1JUHFsYXI2Z0xmRUlDUU9MdjUwMktDT1dZ?=
 =?utf-8?B?UExRZXFlUFZHRjBrckl2a3NDaUNKMDA3MXBnL2Qzbis5bFVlekFUUklaK0Jw?=
 =?utf-8?B?TmxyNTNPeS9aSWtyQ2QxUkRIRWNtYmFPdlUyemJDa0RmODJUb2o4TUxUeW1P?=
 =?utf-8?Q?E2/D1DGYFtVks8qZc8zC9aEVVOlLE5e42w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C349708C95FBF4478791D3D718D279EB@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb81feb7-6551-452a-2f29-08d8b1c0e1db
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 21:28:45.2511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MV9J9mYWZ/fVuMC5VLOEEwIRtkZthcdYueCLBzhUFbARYbccmaxz/rwbUR1s36xU0U6v43U0AztreG7SXfc/kes3f8uZIt/e2P23UaTVsUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2606
X-OriginatorOrg: intel.com
Message-ID-Hash: TMRQSU4KC2ILUGHEGJKRVRXNE77Y3Q4E
X-Message-ID-Hash: TMRQSU4KC2ILUGHEGJKRVRXNE77Y3Q4E
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "efremov@linux.com" <efremov@linux.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lkp <lkp@intel.com>, "julia.lawall@inria.fr" <julia.lawall@inria.fr>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TMRQSU4KC2ILUGHEGJKRVRXNE77Y3Q4E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

T24gVHVlLCAyMDIxLTAxLTA1IGF0IDEzOjAzIC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEp1bGlhIGFuZCAwZGF5IHJlcG9ydDoNCj4gDQo+IMKgwqDCoMKgWmVyby1sZW5ndGggYW5kIG9u
ZS1lbGVtZW50IGFycmF5cyBhcmUgZGVwcmVjYXRlZCwgc2VlDQo+IMKgwqDCoMKgRG9jdW1lbnRh
dGlvbi9wcm9jZXNzL2RlcHJlY2F0ZWQucnN0DQo+IMKgwqDCoMKgRmxleGlibGUtYXJyYXkgbWVt
YmVycyBzaG91bGQgYmUgdXNlZCBpbnN0ZWFkLg0KPiANCj4gSG93ZXZlciwgYSBzdHJhaWdodCBj
b252ZXJzaW9uIHRvIGZsZXhpYmxlIGFycmF5cyB5aWVsZHM6DQo+IA0KPiDCoMKgwqDCoGRyaXZl
cnMvYWNwaS9uZml0L2NvcmUuYzoyMjc2OjQ6IGVycm9yOiBmbGV4aWJsZSBhcnJheSBtZW1iZXIg
aW4gYSBzdHJ1Y3Qgd2l0aCBubyBuYW1lZCBtZW1iZXJzDQo+IMKgwqDCoMKgZHJpdmVycy9hY3Bp
L25maXQvY29yZS5jOjIyODc6NDogZXJyb3I6IGZsZXhpYmxlIGFycmF5IG1lbWJlciBpbiBhIHN0
cnVjdCB3aXRoIG5vIG5hbWVkIG1lbWJlcnMNCj4gDQo+IEluc3RlYWQsIGp1c3QgdXNlIHBsYWlu
IGFycmF5cyBub3QgZW1iZWRkZWQgYSBmbGV4aWJsZSBhcnJheXMuDQoNClRoaXMgcmVhZHMgYSBi
aXQgYXdrd2FyZGx5LCBtYXliZToNCg0KICAiSnVzdCB1c2UgcGxhaW4gYXJyYXlzIGluc3RlYWQg
b2YgZW1iZWRkZWQgZmxleGlibGUgYXJyYXlzLiINCg0KT3RoZXIgdGhhbiB0aGF0LCB0aGUgcGF0
Y2ggbG9va3MgbG9va3MgZ29vZDoNClJldmlld2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5s
LnZlcm1hQGludGVsLmNvbT4NCg0KPiANCj4gQ2M6IERlbmlzIEVmcmVtb3YgPGVmcmVtb3ZAbGlu
dXguY29tPg0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+
DQo+IFJlcG9ydGVkLWJ5OiBKdWxpYSBMYXdhbGwgPGp1bGlhLmxhd2FsbEBpbnJpYS5mcj4NCj4g
U2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+
IC0tLQ0KPiDCoGRyaXZlcnMvYWNwaS9uZml0L2NvcmUuYyB8ICAgNzUgKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyOCBp
bnNlcnRpb25zKCspLCA0NyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2FjcGkvbmZpdC9jb3JlLmMgYi9kcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMNCj4gaW5kZXggYjEx
YjA4YTYwNjg0Li44YzVkZGU2Mjg0MDUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYWNwaS9uZml0
L2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMNCj4gQEAgLTIyNjksNDAg
KzIyNjksMjQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgKmFjcGlfbmZp
dF9yZWdpb25fYXR0cmlidXRlX2dyb3Vwc1tdID0gew0KPiDCoA0KPiANCj4gDQo+IA0KPiDCoC8q
IGVub3VnaCBpbmZvIHRvIHVuaXF1ZWx5IHNwZWNpZnkgYW4gaW50ZXJsZWF2ZSBzZXQgKi8NCj4g
wqBzdHJ1Y3QgbmZpdF9zZXRfaW5mbyB7DQo+IC0Jc3RydWN0IG5maXRfc2V0X2luZm9fbWFwIHsN
Cj4gLQkJdTY0IHJlZ2lvbl9vZmZzZXQ7DQo+IC0JCXUzMiBzZXJpYWxfbnVtYmVyOw0KPiAtCQl1
MzIgcGFkOw0KPiAtCX0gbWFwcGluZ1swXTsNCj4gKwl1NjQgcmVnaW9uX29mZnNldDsNCj4gKwl1
MzIgc2VyaWFsX251bWJlcjsNCj4gKwl1MzIgcGFkOw0KPiDCoH07DQo+IMKgDQo+IA0KPiANCj4g
DQo+IMKgc3RydWN0IG5maXRfc2V0X2luZm8yIHsNCj4gLQlzdHJ1Y3QgbmZpdF9zZXRfaW5mb19t
YXAyIHsNCj4gLQkJdTY0IHJlZ2lvbl9vZmZzZXQ7DQo+IC0JCXUzMiBzZXJpYWxfbnVtYmVyOw0K
PiAtCQl1MTYgdmVuZG9yX2lkOw0KPiAtCQl1MTYgbWFudWZhY3R1cmluZ19kYXRlOw0KPiAtCQl1
OCAgbWFudWZhY3R1cmluZ19sb2NhdGlvbjsNCj4gLQkJdTggIHJlc2VydmVkWzMxXTsNCj4gLQl9
IG1hcHBpbmdbMF07DQo+ICsJdTY0IHJlZ2lvbl9vZmZzZXQ7DQo+ICsJdTMyIHNlcmlhbF9udW1i
ZXI7DQo+ICsJdTE2IHZlbmRvcl9pZDsNCj4gKwl1MTYgbWFudWZhY3R1cmluZ19kYXRlOw0KPiAr
CXU4IG1hbnVmYWN0dXJpbmdfbG9jYXRpb247DQo+ICsJdTggcmVzZXJ2ZWRbMzFdOw0KPiDCoH07
DQo+IMKgDQo+IA0KPiANCj4gDQo+IC1zdGF0aWMgc2l6ZV90IHNpemVvZl9uZml0X3NldF9pbmZv
KGludCBudW1fbWFwcGluZ3MpDQo+IC17DQo+IC0JcmV0dXJuIHNpemVvZihzdHJ1Y3QgbmZpdF9z
ZXRfaW5mbykNCj4gLQkJKyBudW1fbWFwcGluZ3MgKiBzaXplb2Yoc3RydWN0IG5maXRfc2V0X2lu
Zm9fbWFwKTsNCj4gLX0NCj4gLQ0KPiAtc3RhdGljIHNpemVfdCBzaXplb2ZfbmZpdF9zZXRfaW5m
bzIoaW50IG51bV9tYXBwaW5ncykNCj4gLXsNCj4gLQlyZXR1cm4gc2l6ZW9mKHN0cnVjdCBuZml0
X3NldF9pbmZvMikNCj4gLQkJKyBudW1fbWFwcGluZ3MgKiBzaXplb2Yoc3RydWN0IG5maXRfc2V0
X2luZm9fbWFwMik7DQo+IC19DQo+IC0NCj4gwqBzdGF0aWMgaW50IGNtcF9tYXBfY29tcGF0KGNv
bnN0IHZvaWQgKm0wLCBjb25zdCB2b2lkICptMSkNCj4gwqB7DQo+IC0JY29uc3Qgc3RydWN0IG5m
aXRfc2V0X2luZm9fbWFwICptYXAwID0gbTA7DQo+IC0JY29uc3Qgc3RydWN0IG5maXRfc2V0X2lu
Zm9fbWFwICptYXAxID0gbTE7DQo+ICsJY29uc3Qgc3RydWN0IG5maXRfc2V0X2luZm8gKm1hcDAg
PSBtMDsNCj4gKwljb25zdCBzdHJ1Y3QgbmZpdF9zZXRfaW5mbyAqbWFwMSA9IG0xOw0KPiDCoA0K
PiANCj4gDQo+IA0KPiDCoAlyZXR1cm4gbWVtY21wKCZtYXAwLT5yZWdpb25fb2Zmc2V0LCAmbWFw
MS0+cmVnaW9uX29mZnNldCwNCj4gwqAJCQlzaXplb2YodTY0KSk7DQo+IEBAIC0yMzEwLDggKzIy
OTQsOCBAQCBzdGF0aWMgaW50IGNtcF9tYXBfY29tcGF0KGNvbnN0IHZvaWQgKm0wLCBjb25zdCB2
b2lkICptMSkNCj4gwqANCj4gDQo+IA0KPiANCj4gwqBzdGF0aWMgaW50IGNtcF9tYXAoY29uc3Qg
dm9pZCAqbTAsIGNvbnN0IHZvaWQgKm0xKQ0KPiDCoHsNCj4gLQljb25zdCBzdHJ1Y3QgbmZpdF9z
ZXRfaW5mb19tYXAgKm1hcDAgPSBtMDsNCj4gLQljb25zdCBzdHJ1Y3QgbmZpdF9zZXRfaW5mb19t
YXAgKm1hcDEgPSBtMTsNCj4gKwljb25zdCBzdHJ1Y3QgbmZpdF9zZXRfaW5mbyAqbWFwMCA9IG0w
Ow0KPiArCWNvbnN0IHN0cnVjdCBuZml0X3NldF9pbmZvICptYXAxID0gbTE7DQo+IMKgDQo+IA0K
PiANCj4gDQo+IMKgCWlmIChtYXAwLT5yZWdpb25fb2Zmc2V0IDwgbWFwMS0+cmVnaW9uX29mZnNl
dCkNCj4gwqAJCXJldHVybiAtMTsNCj4gQEAgLTIzMjIsOCArMjMwNiw4IEBAIHN0YXRpYyBpbnQg
Y21wX21hcChjb25zdCB2b2lkICptMCwgY29uc3Qgdm9pZCAqbTEpDQo+IMKgDQo+IA0KPiANCj4g
DQo+IMKgc3RhdGljIGludCBjbXBfbWFwMihjb25zdCB2b2lkICptMCwgY29uc3Qgdm9pZCAqbTEp
DQo+IMKgew0KPiAtCWNvbnN0IHN0cnVjdCBuZml0X3NldF9pbmZvX21hcDIgKm1hcDAgPSBtMDsN
Cj4gLQljb25zdCBzdHJ1Y3QgbmZpdF9zZXRfaW5mb19tYXAyICptYXAxID0gbTE7DQo+ICsJY29u
c3Qgc3RydWN0IG5maXRfc2V0X2luZm8yICptYXAwID0gbTA7DQo+ICsJY29uc3Qgc3RydWN0IG5m
aXRfc2V0X2luZm8yICptYXAxID0gbTE7DQo+IMKgDQo+IA0KPiANCj4gDQo+IMKgCWlmIChtYXAw
LT5yZWdpb25fb2Zmc2V0IDwgbWFwMS0+cmVnaW9uX29mZnNldCkNCj4gwqAJCXJldHVybiAtMTsN
Cj4gQEAgLTIzNjEsMjIgKzIzNDUsMjIgQEAgc3RhdGljIGludCBhY3BpX25maXRfaW5pdF9pbnRl
cmxlYXZlX3NldChzdHJ1Y3QgYWNwaV9uZml0X2Rlc2MgKmFjcGlfZGVzYywNCj4gwqAJCXJldHVy
biAtRU5PTUVNOw0KPiDCoAlpbXBvcnRfZ3VpZCgmbmRfc2V0LT50eXBlX2d1aWQsIHNwYS0+cmFu
Z2VfZ3VpZCk7DQo+IMKgDQo+IA0KPiANCj4gDQo+IC0JaW5mbyA9IGRldm1fa3phbGxvYyhkZXYs
IHNpemVvZl9uZml0X3NldF9pbmZvKG5yKSwgR0ZQX0tFUk5FTCk7DQo+ICsJaW5mbyA9IGRldm1f
a2NhbGxvYyhkZXYsIG5yLCBzaXplb2YoKmluZm8pLCBHRlBfS0VSTkVMKTsNCj4gwqAJaWYgKCFp
bmZvKQ0KPiDCoAkJcmV0dXJuIC1FTk9NRU07DQo+IMKgDQo+IA0KPiANCj4gDQo+IC0JaW5mbzIg
PSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2ZfbmZpdF9zZXRfaW5mbzIobnIpLCBHRlBfS0VSTkVM
KTsNCj4gKwlpbmZvMiA9IGRldm1fa2NhbGxvYyhkZXYsIG5yLCBzaXplb2YoKmluZm8yKSwgR0ZQ
X0tFUk5FTCk7DQo+IMKgCWlmICghaW5mbzIpDQo+IMKgCQlyZXR1cm4gLUVOT01FTTsNCj4gwqAN
Cj4gDQo+IA0KPiANCj4gwqAJZm9yIChpID0gMDsgaSA8IG5yOyBpKyspIHsNCj4gwqAJCXN0cnVj
dCBuZF9tYXBwaW5nX2Rlc2MgKm1hcHBpbmcgPSAmbmRyX2Rlc2MtPm1hcHBpbmdbaV07DQo+IC0J
CXN0cnVjdCBuZml0X3NldF9pbmZvX21hcCAqbWFwID0gJmluZm8tPm1hcHBpbmdbaV07DQo+IC0J
CXN0cnVjdCBuZml0X3NldF9pbmZvX21hcDIgKm1hcDIgPSAmaW5mbzItPm1hcHBpbmdbaV07DQo+
IMKgCQlzdHJ1Y3QgbnZkaW1tICpudmRpbW0gPSBtYXBwaW5nLT5udmRpbW07DQo+IMKgCQlzdHJ1
Y3QgbmZpdF9tZW0gKm5maXRfbWVtID0gbnZkaW1tX3Byb3ZpZGVyX2RhdGEobnZkaW1tKTsNCj4g
LQkJc3RydWN0IGFjcGlfbmZpdF9tZW1vcnlfbWFwICptZW1kZXYgPSBtZW1kZXZfZnJvbV9zcGEo
YWNwaV9kZXNjLA0KPiAtCQkJCXNwYS0+cmFuZ2VfaW5kZXgsIGkpOw0KPiArCQlzdHJ1Y3QgbmZp
dF9zZXRfaW5mbyAqbWFwID0gJmluZm9baV07DQo+ICsJCXN0cnVjdCBuZml0X3NldF9pbmZvMiAq
bWFwMiA9ICZpbmZvMltpXTsNCj4gKwkJc3RydWN0IGFjcGlfbmZpdF9tZW1vcnlfbWFwICptZW1k
ZXYgPQ0KPiArCQkJbWVtZGV2X2Zyb21fc3BhKGFjcGlfZGVzYywgc3BhLT5yYW5nZV9pbmRleCwg
aSk7DQo+IMKgCQlzdHJ1Y3QgYWNwaV9uZml0X2NvbnRyb2xfcmVnaW9uICpkY3IgPSBuZml0X21l
bS0+ZGNyOw0KPiDCoA0KPiANCj4gDQo+IA0KPiDCoAkJaWYgKCFtZW1kZXYgfHwgIW5maXRfbWVt
LT5kY3IpIHsNCj4gQEAgLTIzOTUsMjMgKzIzNzksMjAgQEAgc3RhdGljIGludCBhY3BpX25maXRf
aW5pdF9pbnRlcmxlYXZlX3NldChzdHJ1Y3QgYWNwaV9uZml0X2Rlc2MgKmFjcGlfZGVzYywNCj4g
wqAJfQ0KPiDCoA0KPiANCj4gDQo+IA0KPiDCoAkvKiB2MS4xIG5hbWVzcGFjZXMgKi8NCj4gLQlz
b3J0KCZpbmZvLT5tYXBwaW5nWzBdLCBuciwgc2l6ZW9mKHN0cnVjdCBuZml0X3NldF9pbmZvX21h
cCksDQo+IC0JCQljbXBfbWFwLCBOVUxMKTsNCj4gLQluZF9zZXQtPmNvb2tpZTEgPSBuZF9mbGV0
Y2hlcjY0KGluZm8sIHNpemVvZl9uZml0X3NldF9pbmZvKG5yKSwgMCk7DQo+ICsJc29ydChpbmZv
LCBuciwgc2l6ZW9mKCppbmZvKSwgY21wX21hcCwgTlVMTCk7DQo+ICsJbmRfc2V0LT5jb29raWUx
ID0gbmRfZmxldGNoZXI2NChpbmZvLCBzaXplb2YoKmluZm8pICogbnIsIDApOw0KPiDCoA0KPiAN
Cj4gDQo+IA0KPiDCoAkvKiB2MS4yIG5hbWVzcGFjZXMgKi8NCj4gLQlzb3J0KCZpbmZvMi0+bWFw
cGluZ1swXSwgbnIsIHNpemVvZihzdHJ1Y3QgbmZpdF9zZXRfaW5mb19tYXAyKSwNCj4gLQkJCWNt
cF9tYXAyLCBOVUxMKTsNCj4gLQluZF9zZXQtPmNvb2tpZTIgPSBuZF9mbGV0Y2hlcjY0KGluZm8y
LCBzaXplb2ZfbmZpdF9zZXRfaW5mbzIobnIpLCAwKTsNCj4gKwlzb3J0KGluZm8yLCBuciwgc2l6
ZW9mKCppbmZvMiksIGNtcF9tYXAyLCBOVUxMKTsNCj4gKwluZF9zZXQtPmNvb2tpZTIgPSBuZF9m
bGV0Y2hlcjY0KGluZm8yLCBzaXplb2YoKmluZm8yKSAqIG5yLCAwKTsNCj4gwqANCj4gDQo+IA0K
PiANCj4gwqAJLyogc3VwcG9ydCB2MS4xIG5hbWVzcGFjZXMgY3JlYXRlZCB3aXRoIHRoZSB3cm9u
ZyBzb3J0IG9yZGVyICovDQo+IC0Jc29ydCgmaW5mby0+bWFwcGluZ1swXSwgbnIsIHNpemVvZihz
dHJ1Y3QgbmZpdF9zZXRfaW5mb19tYXApLA0KPiAtCQkJY21wX21hcF9jb21wYXQsIE5VTEwpOw0K
PiAtCW5kX3NldC0+YWx0Y29va2llID0gbmRfZmxldGNoZXI2NChpbmZvLCBzaXplb2ZfbmZpdF9z
ZXRfaW5mbyhuciksIDApOw0KPiArCXNvcnQoaW5mbywgbnIsIHNpemVvZigqaW5mbyksIGNtcF9t
YXBfY29tcGF0LCBOVUxMKTsNCj4gKwluZF9zZXQtPmFsdGNvb2tpZSA9IG5kX2ZsZXRjaGVyNjQo
aW5mbywgc2l6ZW9mKCppbmZvKSAqIG5yLCAwKTsNCj4gwqANCj4gDQo+IA0KPiANCj4gwqAJLyog
cmVjb3JkIHRoZSByZXN1bHQgb2YgdGhlIHNvcnQgZm9yIHRoZSBtYXBwaW5nIHBvc2l0aW9uICov
DQo+IMKgCWZvciAoaSA9IDA7IGkgPCBucjsgaSsrKSB7DQo+IC0JCXN0cnVjdCBuZml0X3NldF9p
bmZvX21hcDIgKm1hcDIgPSAmaW5mbzItPm1hcHBpbmdbaV07DQo+ICsJCXN0cnVjdCBuZml0X3Nl
dF9pbmZvMiAqbWFwMiA9ICZpbmZvMltpXTsNCj4gwqAJCWludCBqOw0KPiDCoA0KPiANCj4gDQo+
IA0KPiDCoAkJZm9yIChqID0gMDsgaiA8IG5yOyBqKyspIHsNCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGludXgtbnZkaW1tIG1haWxpbmcgbGlz
dCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnDQo+IFRvIHVuc3Vic2NyaWJlIHNlbmQgYW4g
ZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZw0KDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBs
aXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBl
bWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
