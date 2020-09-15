Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B59D26A87B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 17:12:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7471414184BEB;
	Tue, 15 Sep 2020 08:12:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6654714184BE9
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 08:12:26 -0700 (PDT)
IronPort-SDR: qA2zg26NhNrldWcQNGy36VPo6hsupmeDTSkB9MRyh2guGDkDOwilmbWb7GYVpzxeYFRyLj5h43
 z1SMjWYcwfQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="156700600"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600";
   d="scan'208";a="156700600"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 08:12:25 -0700
IronPort-SDR: SjPFC4M1pkrdWYHgv0r7SDJBhHHZirg8kI27qsiPBAR1OTUDLvrdGvUSJrQRwZLnEPx/5lmvCh
 DMQhWwYWGC2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600";
   d="scan'208";a="507605271"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2020 08:12:24 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 15 Sep 2020 08:12:24 -0700
Received: from orsmsx101.amr.corp.intel.com (10.22.225.128) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 15 Sep 2020 08:12:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 15 Sep 2020 08:12:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 15 Sep 2020 08:12:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs+kQq75FN7jreg/EnO7sfQ23ygDDGk0JJvgHGooze+quzAQ6MevgdkX000tKDlZc/R5/He7+hcTiVoiye3RTtopWNisUl5WeDelIfl7nDbzPUQmseAlLMuiDTLll8hzPggh6FYgRqa01lBXxMLxs5WoZeh79Pp2fhj2iFPDbfMT0nDlpALw5HfjktP0qE1W/YcFgm06jRGowPrQy6gEkfFfp0ykULWn7Ib/Vrdz+JrgHbnyM8EvtoWLDVGPyjOknE5/r0rOk2ZX/vUlt3WlFgBidaD2CN6mA/vf0jgXjyXJQpJIygfZQgPXWkuxl/G5TjGC7x9fORqHn1t7AZFHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAay6MiWpiI24iJiwDDV1Ut+Jdc+sUsViLxX2aUO2Yo=;
 b=kEGki71BqZ10dGQdCkEgcLW2FV+SXIUHVfHexTPWpoNrBH6pjNF4p9UQa3jjHTG0x/hVZeiezEsj97xdL9PJFiSxvTtAj8eMzBC8VgmRfP+bIWXOxSfjl2ODkBKR/aASovjxqUEN6JJCPClPNL0H0+//gHDd5dtUP57irDfUO6JTVWVaqJIK6I3jB+0N3jjNH5vjlYNXMsvypOjXheV5BMJt9Vu5fVCPO8uHjqqTXIgJ05kTlop5bo2c/bFAGh2ox+V11KWdMCmr8QRem1gv0LkyGw4wH60KQjd6SNu/8ChHSLx3WNYV2Sr/LZVlStopyGtxffC+5IqmjzwEMV5WqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAay6MiWpiI24iJiwDDV1Ut+Jdc+sUsViLxX2aUO2Yo=;
 b=Gx/EKObSmAQGyElNrLrW6Lze9HiydUoC8dF+ZYUSOuEOrV2cN8wcLWOf01LHmb5L6w3wZie/32DebwJuryvGkbWYOGyP5S6AcaRbw0nSqzaV7Fj48tu9WkqMwwWJe8nvRqloP53+Z4pFFy19N24vRXhDCgWpr6Wy9YHbmK1RzkA=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2808.namprd11.prod.outlook.com (2603:10b6:a02:c8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 15:12:21 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::1084:a79c:5a4f:f115]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::1084:a79c:5a4f:f115%5]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 15:12:21 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "jack@suse.cz" <jack@suse.cz>, "colyli@suse.de" <colyli@suse.de>
Subject: =?utf-8?B?UmU6IOWbnuWkje+8mnJlZ3Jlc3Npb24gY2F1c2VkIGJ5IHBhdGNoIDYxODBi?=
 =?utf-8?B?YjQ0NmFiNjI0YjlhYjhiZjIwMWVkMjUxY2E4N2YwN2I0MTM/PyAoImRheDog?=
 =?utf-8?B?Zml4IGRldGVjdGlvbiBvZiBkYXggc3VwcG9ydCBmb3Igbm9uLXBlcnNpc3Rl?=
 =?utf-8?B?bnQgbWVtb3J5IGJsb2NrPz8gZGV2aWNlcyIp?=
Thread-Topic: =?utf-8?B?5Zue5aSN77yacmVncmVzc2lvbiBjYXVzZWQgYnkgcGF0Y2ggNjE4MGJiNDQ2?=
 =?utf-8?B?YWI2MjRiOWFiOGJmMjAxZWQyNTFjYTg3ZjA3YjQxMz8/ICgiZGF4OiBmaXgg?=
 =?utf-8?B?ZGV0ZWN0aW9uIG9mIGRheCBzdXBwb3J0IGZvciBub24tcGVyc2lzdGVudCBt?=
 =?utf-8?B?ZW1vcnkgYmxvY2s/PyBkZXZpY2VzIik=?=
Thread-Index: AQHWizZw2c8jvLprkE6JxvxncLW2xalpzskA
Date: Tue, 15 Sep 2020 15:12:21 +0000
Message-ID: <a8898f972f427476b8accf41aee2b1e105bc56e5.camel@intel.com>
References: <alpine.LRH.2.02.2009141131220.30651@file01.intranet.prod.int.rdu2.redhat.com>
	 <211sy17ij47lox90ncna7kwk-k7cl0b-ubtml5jg8ocd-r7lb68jgkncbq5ng3g-koqyd471rzfh-t231u5-sxwvexwht98i-b7in5pxxck0j-3b40lqlmuelf13q0uk-ye4ohhsbgodw-xuloz9wpp7tf.1600139009031@email.android.com>
	 <20200915080106.GG4863@quack2.suse.cz>
In-Reply-To: <20200915080106.GG4863@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62e89bb9-bd36-4b07-9b3b-08d85989beb7
x-ms-traffictypediagnostic: BYAPR11MB2808:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2808FB89CF6DC5E684E53873C7200@BYAPR11MB2808.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ixKpnHXZkLgAq0mKWTetAp3YnYUWR/KEOufAkCuBJUI1OEpLWKlk0VFrpyEhU0XtGvkzlKXRP3zPbP/prd3//05IO+mlxpJ1ldnOrXrng+7jhZTHbkrWtmC+HeEc3ZCrv0NmPajKcrcvTaQThgLqaknbIwLSFWcKuMKNJIz8ROaPAs3advp6ekxvaBstqAbTeZ1lTbPhT7OlCpKpEM87va5E2O2XSAvgNsakFRp4GdD1PonXfFbPWAyTHCSJPsYBWwh6wyIynNMkd/vJcXfj+mGnQNdywHpiGuSsXBOpC+SLHxzeuQYA14gh/+jfR6vwTXh7VL6r7UQf+qYX0X/+A9K2AbZb6U0PgCkEcmNrOtf0V8Yvpo4a3UojJK6AbnuA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(83380400001)(224303003)(36756003)(86362001)(6486002)(8936002)(4326008)(6512007)(478600001)(45080400002)(110136005)(91956017)(76116006)(2906002)(66446008)(66476007)(66946007)(64756008)(66556008)(5660300002)(2616005)(54906003)(316002)(6506007)(26005)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8qtEi10AAm1RBJ3oMBhENwdlMbr9qX2AE3vQb61mBNrTOlT1mQAF4p4H+14U9E5TJZ0sNPdrx+twhc5Q2tVuhg9RgbeQie2fjXNmjtkWGB1cLiP8trmLt9iDnaGmTPoU0ifJBuZ0CNcn7Ot+tcx9AykGvyx4BMViIe0P52BSBm20HJTHOyEC6f2fEUbrUOx0BArkbk5z+iKvcgK5GqscHnulV0jOhkgtnXsDv0DSOQHNVbrhrZa+LUW/DWExDsqzwRXQ8jaYAxmTE7qAplrABPXQ4EcUVVa2ep8LDm89BchN9YZrE+sOOOa/LrDxXkI4p9E+fqDuSY4s+MkJ68VjDJ1Yl+Av4HK1tQqFO2TjyCTqRypHs1hP1JPo9a/o6Hi0+EdEaUrcDAYApdbbbHWAstzOdnbvizvoQR595UQkcTGdWzpgnAkn1FlFkUN9U5Lrh3DH5bxdDyaF9GlMaQdL3KV4UsdvSifTw7K0Rc32yiLDYqatriklAEUOJAb3qOARDd+g0sAIWysKVa2TAB0ncIx28tMvGFWoLkpTjn+sRmY5uGUJRx0v1/LjPvCPARdWEY5OFIiUng9FrmuWMxKp1868eCpqUL5NSBC3iXl1pK4ZcIdaFjqs70MTctdkmCh0chUM4A5nkAu/M3w5Y8YTaQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <674BEBE8D926164F90C4A45A8C77084F@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e89bb9-bd36-4b07-9b3b-08d85989beb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 15:12:21.7021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvGmctnK0YDQsWhHAu/28RNT55tGO8+xe3C/2it4FHTSuuhEVJ7zFFCfBZgwvlT6K60lFrl6URUeGWfFgfxM/3mgjlAQQkQVCPBUKBJbQnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2808
X-OriginatorOrg: intel.com
Message-ID-Hash: 67F457ZJZEACM764DC6IPK3WU6LIU2TI
X-Message-ID-Hash: 67F457ZJZEACM764DC6IPK3WU6LIU2TI
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "jack@suse.com" <jack@suse.com>, "ahuang12@lenovo.com" <ahuang12@lenovo.com>, "pankaj.gupta.linux@gmail.com" <pankaj.gupta.linux@gmail.com>, "snitzer@redhat.com" <snitzer@redhat.com>, "mpatocka@redhat.com" <mpatocka@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/67F457ZJZEACM764DC6IPK3WU6LIU2TI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

T24gVHVlLCAyMDIwLTA5LTE1IGF0IDEwOjAxICswMjAwLCBKYW4gS2FyYSB3cm90ZToNCj4gSGkh
DQo+IA0KPiBPbiBUdWUgMTUtMDktMjAgMTE6MDM6MjksIGNvbHlsaUBzdXNlLmRlIHdyb3RlOg0K
PiA+IENvdWxkIHlvdSBwbGVhc2UgdG8gdGFrZSBhIGxvb2s/IEkgYW0gb2ZmbGluZSBpbiB0aGUg
bmV4dCB0d28gd2Vla3MuDQo+IA0KPiBJIGp1c3QgaGFkIGEgbG9vayBpbnRvIHRoaXMuIElNSE8g
dGhlIGp1c3RpZmljYXRpb24gaW4gNjE4MGJiNDQ2YSAiZGF4OiBmaXgNCj4gZGV0ZWN0aW9uIG9m
IGRheCBzdXBwb3J0IGZvciBub24tcGVyc2lzdGVudCBtZW1vcnkgYmxvY2sgZGV2aWNlcyIgaXMg
anVzdA0KPiBib2d1cyBhbmQgcGVvcGxlIGdvdCBjb25mdXNlZCBieSB0aGUgcHJldmlvdXMgY29u
ZGl0aW9uDQo+IA0KPiBpZiAoIWRheF9kZXYgJiYgIWJkZXZfZGF4X3N1cHBvcnRlZChiZGV2LCBi
bG9ja3NpemUpKQ0KPiANCj4gd2hpY2ggd2FzIGJvZ3VzIGFzIHdlbGwuIGJkZXZfZGF4X3N1cHBv
cnRlZCgpIGFsd2F5cyByZXR1cm5zIGZhbHNlIGZvciBiZGV2DQo+IHRoYXQgZG9lc24ndCBoYXZl
IGRheF9kZXYgKG5hdHVyYWxseSBzbykuIFNvIGluIHRoZSBvcmlnaW5hbCBjb25kaXRpb24NCj4g
dGhlcmUgd2FzIG5vIHBvaW50IGluIGNhbGxpbmcgYmRldl9kYXhfc3VwcG9ydGVkKCkgaWYgd2Ug
a25vdyBkYXhfZGV2IGlzDQo+IE5VTEwuDQo+IA0KPiBUaGVuIHRoaXMgd2FzIGNoYW5nZWQgdG86
DQo+IA0KPiBpZiAoIWRheF9kZXYgfHwgIWJkZXZfZGF4X3N1cHBvcnRlZChiZGV2LCBibG9ja3Np
emUpKQ0KPiANCj4gd2hpY2ggbG9va3MgbW9yZSBzZW5zaWJsZSBhdCB0aGUgZmlyc3Qgc2lnaHQu
IEJ1dCBvbmx5IGF0IHRoZSBmaXJzdCBzaWdodCAtDQo+IGlmIHlvdSBsb29rIGF0IHdpZGVyIGNv
bnRleHQsIF9fZ2VuZXJpY19mc2RheF9zdXBwb3J0ZWQoKSBpcyB0aGUgYnVsayBvZg0KPiBjb2Rl
IHRoYXQgZGVjaWRlcyB3aGV0aGVyIGEgZGV2aWNlIHN1cHBvcnRzIERBWCBzbyBjYWxsaW5nDQo+
IGJkZXZfZGF4X3N1cHBvcnRlZCgpIGZyb20gaXQgaW5kZWVkIGRvZXNuJ3QgbG9vayBhcyBzdWNo
IGEgZ3JlYXQgaWRlYS4gU28NCj4gSU1PIHRoZSBjb25kaXRpb24gc2hvdWxkIGJlIGp1c3Q6DQo+
IA0KPiBpZiAoIWRheF9kZXYpDQo+IA0KPiBJJ2xsIHNlbmQgYSBmaXggZm9yIHRoaXMuDQo+IA0K
PiBBbHNvIHRoZXJlJ3MgdGhlIHByb2Nlc3MgcXVlc3Rpb24gaG93IHRoaXMgcGF0Y2ggY291bGQg
Z2V0IHRvIExpbnVzIHdoZW4NCj4gYW55IGF0dGVtcHQgdG8gdXNlIERBWCB3b3VsZCBpbW1lZGlh
dGVseSBraWxsIHRoZSBtYWNoaW5lIGxpa2UgTWlrdWxhcw0KPiBzcG90dGVkLiBUaGlzIHNob3dz
IHRoZSB0aGF0IHBhdGNoIHdhcyB1bnRlc3RlZCB3aXRoIERBWCBieSBhbnlib2R5IG9uIHRoZQ0K
PiBwYXRoIGZyb20gdGhlIGRldmVsb3BlciB0byBMaW51cy4uLg0KDQpIaSBKYW4sDQoNClRoaXMg
d2FzIGVudGlyZWx5IG15IGZhdWx0LCBhbmQgSSBhcG9sb2dpemUuIEkgZ290IGNvbmZ1c2VkIGFz
IHRvIHdoYXQNCnN0YXRlIG15IGJyYW5jaGVzIHdlcmUgaW4sIGFuZCBJIHRob3VnaHQgdGhpcyBo
YWQgY2xlYXJlZCBvdXIgdW5pdCB0ZXN0cw0KZXRjLCB3aGVuIGl0IG9idmlvdXNseSBoYWRuJ3Qu
IEknbSBnb2luZyB0byB0YWtlIGEgaGFyZGVyIGxvb2sgYXQgbXkNCnBlcnNvbmFsIGJyYW5jaC9w
YXRjaCBtYW5hZ2VtZW50IHByb2Nlc3MgdG8gbWFrZSBzdXJlIGl0IGRvZXNuJ3QgaGFwcGVuDQph
Z2FpbiENCg0KVGhhbmtzIGZvciB0YWtpbmcgYSBsb29rLg0KDQotVmlzaGFsDQoNCj4gDQo+IAkJ
CQkJCQkJSG9uemENCj4gDQo+ID4gLS0tLS0tLS0g5Y6f5aeL6YKu5Lu2IC0tLS0tLS0tDQo+ID4g
5Y+R5Lu25Lq677yaIE1pa3VsYXMgUGF0b2NrYSA8bXBhdG9ja2FAcmVkaGF0LmNvbT4NCj4gPiDm
l6XmnJ/vvJogMjAyMOW5tDnmnIgxNOaXpeWRqOS4gOWNiuWknDExOjQ4DQo+ID4g5pS25Lu25Lq6
77yaIENvbHkgTGkgPGNvbHlsaUBzdXNlLmRlPiwgRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFt
c0BpbnRlbC5jb20+LA0KPiA+IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPg0KPiA+
IOaKhOmAge+8miBKYW4gS2FyYSA8amFja0BzdXNlLmNvbT4sIFZpc2hhbCBWZXJtYSA8dmlzaGFs
LmwudmVybWFAaW50ZWwuY29tPiwNCj4gPiBBZHJpYW4gSHVhbmcgPGFodWFuZzEyQGxlbm92by5j
b20+LCBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+LCBNaWtlDQo+ID4gU25pdHplciA8
c25pdHplckByZWRoYXQuY29tPiwgUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGEubGludXhAZ21h
aWwuY29tPiwNCj4gPiBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnDQo+ID4g5Li76aKY77yaIHJl
Z3Jlc3Npb24gY2F1c2VkIGJ5IHBhdGNoIDYxODBiYjQ0NmFiNjI0YjlhYjhiZjIwMWVkMjUxY2E4
N2YwN2I0MTMNCj4gPiAoImRheDogZml4IGRldGVjdGlvbiBvZiBkYXggc3VwcG9ydCBmb3Igbm9u
LXBlcnNpc3RlbnQgbWVtb3J5IGJsb2NrDQo+ID4gZGV2aWNlcyIpDQo+ID4gDQo+ID4gICAgIEhp
DQo+ID4gDQo+ID4gICAgIFRoZSBwYXRjaCA2MTgwYmI0NDZhYjYyNGI5YWI4YmYyMDFlZDI1MWNh
ODdmMDdiNDEzICgiZGF4OiBmaXggZGV0ZWN0aW9uIG9mDQo+ID4gICAgIGRheCBzdXBwb3J0IGZv
ciBub24tcGVyc2lzdGVudCBtZW1vcnkgYmxvY2sgZGV2aWNlcyIpIGNhdXNlcyBjcmFzaCB3aGVu
DQo+ID4gICAgIGF0dGVtcHRpbmcgdG8gbW91bnQgdGhlIGV4dDQgZmlsZXN5c3RlbSBvbiAvZGV2
L3BtZW0wICgibWtmcy5leHQ0DQo+ID4gICAgIC9kZXYvcG1lbTA7IG1vdW50IC10IGV4dDQgL2Rl
di9wbWVtMCAvbW50L3Rlc3QiKS4gVGhlIGRldmljZSAvZGV2L3BtZW0wIGlzDQo+ID4gICAgIGVt
dWxhdGVkIHVzaW5nIHRoZSAibWVtbWFwIiBrZXJuZWwgcGFyYW1ldGVyLg0KPiA+IA0KPiA+ICAg
ICBUaGUgcGF0Y2ggY2F1c2VzIGluZmluaXRlIHJlY3Vyc2lvbiBhbmQgZG91YmxlLWZhdWx0IGV4
Y2VwdGlvbjoNCj4gPiANCj4gPiAgICAgX19nZW5lcmljX2ZzZGF4X3N1cHBvcnRlZA0KPiA+ICAg
ICBiZGV2X2RheF9zdXBwb3J0ZWQNCj4gPiAgICAgX19iZGV2X2RheF9zdXBwb3J0ZWQNCj4gPiAg
ICAgZGF4X3N1cHBvcnRlZA0KPiA+ICAgICBkYXhfZGV2LT5vcHMtPmRheF9zdXBwb3J0ZWQNCj4g
PiAgICAgZ2VuZXJpY19mc2RheF9zdXBwb3J0ZWQNCj4gPiAgICAgX19nZW5lcmljX2ZzZGF4X3N1
cHBvcnRlZA0KPiA+IA0KPiA+ICAgICBNaWt1bGFzDQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4gICAg
IFsgICAxNy41MDA2MTldIHRyYXBzOiBQQU5JQzogZG91YmxlIGZhdWx0LCBlcnJvcl9jb2RlOiAw
eDANCj4gPiAgICAgWyAgIDE3LjUwMDYxOV0gZG91YmxlIGZhdWx0OiAwMDAwIFsjMV0gUFJFRU1Q
VCBTTVANCj4gPiAgICAgWyAgIDE3LjUwMDYyMF0gQ1BVOiAwIFBJRDogMTMyNiBDb21tOiBtb3Vu
dCBOb3QgdGFpbnRlZCA1LjkuMC1yYzEtYmlzZWN0ICMNCj4gPiAgICAgMTANCj4gPiAgICAgWyAg
IDE3LjUwMDYyMF0gSGFyZHdhcmUgbmFtZTogQm9jaHMgQm9jaHMsIEJJT1MgQm9jaHMgMDEvMDEv
MjAxMQ0KPiA+ICAgICBbICAgMTcuNTAwNjIxXSBSSVA6IDAwMTA6X19nZW5lcmljX2ZzZGF4X3N1
cHBvcnRlZCsweDZhLzB4NTAwDQo+ID4gICAgIFsgICAxNy41MDA2MjJdIENvZGU6IGZmIGZmIGZm
IGZmIGZmIDdmIDAwIDQ4IDIxIGYzIDQ4IDAxIGMzIDQ4IGMxIGUzIDA5IGY2DQo+ID4gICAgIGM3
IDBlIDBmIDg1IGZhIDAxIDAwIDAwIDQ4IDg1IGZmIDQ5IDg5IGZkIDc0IDExIGJlIDAwIDEwIDAw
IDAwIDRjIDg5IGU3DQo+ID4gICAgIDxlOD4gYjEgZmUgZmYgZmYgODQgYzAgNzUgMTEgMzEgYzAg
NDggODMgYzQgNDggNWIgNWQgNDEgNWMgNDEgNWQgNDENCj4gPiAgICAgWyAgIDE3LjUwMDYyM10g
UlNQOiAwMDE4OmZmZmY4ODk0MGI0ZmRmZjggRUZMQUdTOiAwMDAxMDI4Ng0KPiA+ICAgICBbICAg
MTcuNTAwNjI0XSBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiAwMDAwMDAwN2ZmZmZmMDAwIFJD
WDoNCj4gPiAgICAgMDAwMDAwMDAwMDAwMDAwMA0KPiA+ICAgICBbICAgMTcuNTAwNjI1XSBSRFg6
IDAwMDAwMDAwMDAwMDEwMDAgUlNJOiAwMDAwMDAwMDAwMDAxMDAwIFJESToNCj4gPiAgICAgZmZm
Zjg4OTQwYjM0YzMwMA0KPiA+ICAgICBbICAgMTcuNTAwNjI1XSBSQlA6IDAwMDAwMDAwMDAwMDAw
MDAgUjA4OiAwMDAwMDAwMDA0MDAwMDAwIFIwOToNCj4gPiAgICAgODA4MDgwODA4MDgwODA4MA0K
PiA+ICAgICBbICAgMTcuNTAwNjI2XSBSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiBmZWZlZmVm
ZWZlZmVmZWZmIFIxMjoNCj4gPiAgICAgZmZmZjg4OTQwYjM0YzMwMA0KPiA+ICAgICBbICAgMTcu
NTAwNjI2XSBSMTM6IGZmZmY4ODk0MGIzZGMwMDAgUjE0OiBmZmZmODg5NDBiYWRkMDAwIFIxNToN
Cj4gPiAgICAgMDAwMDAwMDAwMDAwMDAwMQ0KPiA+ICAgICBbICAgMTcuNTAwNjI3XSBGUzogIDAw
MDAwMDAwZjdjMjU3ODAoMDAwMCkgR1M6ZmZmZjg4OTQwZmEwMDAwMCgwMDAwKQ0KPiA+ICAgICBr
bmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+ID4gICAgIFsgICAxNy41MDA2MjhdIENTOiAgMDAxMCBE
UzogMDAyYiBFUzogMDAyYiBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gPiAgICAgWyAgIDE3LjUw
MDYyOF0gQ1IyOiBmZmZmODg5NDBiNGZkZmU4IENSMzogMDAwMDAwMTQwYmQxNTAwMCBDUjQ6DQo+
ID4gICAgIDAwMDAwMDAwMDAwMDA2YjANCj4gPiAgICAgWyAgIDE3LjUwMDYyOF0gQ2FsbCBUcmFj
ZToNCj4gPiAgICAgWyAgIDE3LjUwMDYyOV0gTW9kdWxlcyBsaW5rZWQgaW46IHV2ZXNhZmIgY2Zi
ZmlsbHJlY3QgY2ZiaW1nYmx0IGNuDQo+ID4gICAgIGNmYmNvcHlhcmVhIGZiIGZiZGV2IGlwdjYg
dHVuIGF1dG9mczQgYmluZm10X21pc2MgY29uZmlnZnMgYWZfcGFja2V0DQo+ID4gICAgIHZpcnRp
b19ybmcgcm5nX2NvcmUgbW91c2VkZXYgZXZkZXYgcGNzcGtyIHZpcnRpb19iYWxsb29uIGJ1dHRv
biByYWlkMTANCj4gPiAgICAgcmFpZDQ1NiBhc3luY19yYWlkNl9yZWNvdiBhc3luY19tZW1jcHkg
YXN5bmNfcHEgcmFpZDZfcHEgYXN5bmNfeG9yIHhvcg0KPiA+ICAgICBhc3luY190eCBsaWJjcmMz
MmMgcmFpZDEgcmFpZDAgbWRfbW9kIHNkX21vZCB0MTBfcGkgdmlydGlvX3Njc2kgdmlydGlvX25l
dA0KPiA+ICAgICBuZXRfZmFpbG92ZXIgcHNtb3VzZSBzY3NpX21vZCBmYWlsb3Zlcg0KPiA+ICAg
ICBbICAgMTcuNTAwNjM4XSAtLS1bIGVuZCB0cmFjZSAzYzg3N2ZjYjViODY1NDU5IF0tLS0NCj4g
PiAgICAgWyAgIDE3LjUwMDYzOF0gUklQOiAwMDEwOl9fZ2VuZXJpY19mc2RheF9zdXBwb3J0ZWQr
MHg2YS8weDUwMA0KPiA+ICAgICBbICAgMTcuNTAwNjM5XSBDb2RlOiBmZiBmZiBmZiBmZiBmZiA3
ZiAwMCA0OCAyMSBmMyA0OCAwMSBjMyA0OCBjMSBlMyAwOSBmNg0KPiA+ICAgICBjNyAwZSAwZiA4
NSBmYSAwMSAwMCAwMCA0OCA4NSBmZiA0OSA4OSBmZCA3NCAxMSBiZSAwMCAxMCAwMCAwMCA0YyA4
OSBlNw0KPiA+ICAgICA8ZTg+IGIxIGZlIGZmIGZmIDg0IGMwIDc1IDExIDMxIGMwIDQ4IDgzIGM0
IDQ4IDViIDVkIDQxIDVjIDQxIDVkIDQxDQo+ID4gICAgIFsgICAxNy41MDA2NDBdIFJTUDogMDAx
ODpmZmZmODg5NDBiNGZkZmY4IEVGTEFHUzogMDAwMTAyODYNCj4gPiAgICAgWyAgIDE3LjUwMDY0
MV0gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAwMDdmZmZmZjAwMCBSQ1g6DQo+ID4g
ICAgIDAwMDAwMDAwMDAwMDAwMDANCj4gPiAgICAgWyAgIDE3LjUwMDY0MV0gUkRYOiAwMDAwMDAw
MDAwMDAxMDAwIFJTSTogMDAwMDAwMDAwMDAwMTAwMCBSREk6DQo+ID4gICAgIGZmZmY4ODk0MGIz
NGMzMDANCj4gPiAgICAgWyAgIDE3LjUwMDY0Ml0gUkJQOiAwMDAwMDAwMDAwMDAwMDAwIFIwODog
MDAwMDAwMDAwNDAwMDAwMCBSMDk6DQo+ID4gICAgIDgwODA4MDgwODA4MDgwODANCj4gPiAgICAg
WyAgIDE3LjUwMDY0Ml0gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogZmVmZWZlZmVmZWZlZmVm
ZiBSMTI6DQo+ID4gICAgIGZmZmY4ODk0MGIzNGMzMDANCj4gPiAgICAgWyAgIDE3LjUwMDY0M10g
UjEzOiBmZmZmODg5NDBiM2RjMDAwIFIxNDogZmZmZjg4OTQwYmFkZDAwMCBSMTU6DQo+ID4gICAg
IDAwMDAwMDAwMDAwMDAwMDENCj4gPiAgICAgWyAgIDE3LjUwMDY0M10gRlM6ICAwMDAwMDAwMGY3
YzI1NzgwKDAwMDApIEdTOmZmZmY4ODk0MGZhMDAwMDAoMDAwMCkNCj4gPiAgICAga25sR1M6MDAw
MDAwMDAwMDAwMDAwMA0KPiA+ICAgICBbICAgMTcuNTAwNjQ0XSBDUzogIDAwMTAgRFM6IDAwMmIg
RVM6IDAwMmIgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+ID4gICAgIFsgICAxNy41MDA2NDRdIENS
MjogZmZmZjg4OTQwYjRmZGZlOCBDUjM6IDAwMDAwMDE0MGJkMTUwMDAgQ1I0Og0KPiA+ICAgICAw
MDAwMDAwMDAwMDAwNmIwDQo+ID4gICAgIFsgICAxNy41MDA2NDVdIEtlcm5lbCBwYW5pYyAtIG5v
dCBzeW5jaW5nOiBGYXRhbCBleGNlcHRpb24gaW4gaW50ZXJydXB0DQo+ID4gICAgIFsgICAxNy41
MDA5NDFdIEtlcm5lbCBPZmZzZXQ6IGRpc2FibGVkDQo+ID4gDQo+ID4gDQoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5n
IGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFu
IGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
