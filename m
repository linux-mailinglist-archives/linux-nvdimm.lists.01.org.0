Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2098F333866
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Mar 2021 10:10:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 02BC2100EB84C;
	Wed, 10 Mar 2021 01:10:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EF09E100EB832
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 01:10:25 -0800 (PST)
IronPort-SDR: DzpvUQhjW3myRY2KXz37ebVlUzddcF6eUwclM6eCG0j9wFzeAMqFqM2kNKuH3m+eT0+rds/KoH
 pcm5B+Db2mCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="167696725"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400";
   d="scan'208";a="167696725"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 01:10:25 -0800
IronPort-SDR: FFNPzpeVSD+PYokiaE7lo5ahPjF0mtEZtkFzqYuAfklfCt+lcW7irwDQjSroGJ+K7evaXpdzkL
 A+LWJiIKElpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400";
   d="scan'208";a="603005908"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2021 01:10:25 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 01:10:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 10 Mar 2021 01:10:25 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.52) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 10 Mar 2021 01:10:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilbLhDId7X9xRpesr7Y7fZXg0SG67Lxdz/G/fzdRUgu7HkqTaMC4yXucQFs3ohxpgdmL3pjNV7QlFXhqCjLYrKFLfBfnRpWrN+h67LbNPd71TgRQx4vU2M22LnhgxjcpCHGGR6k5rVaw0+d0cCu0HTbrHYwBofZ2FZmg9xHHx4iqmNvxnXP9klfnOCEeA//TzMRQ7S0novGJmzCtobbD6zNzwyx8HejMmEMi8sP8D3GnWL1h5u4Ngz847zzQVj50/nZXim+TUuIjmMts9iHEP5vxt7yigyz5svktODK41aAR9hkNbWq93bw42sxSMPZMPCla/hD7g73URPkI6wWwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1RYe7CzXrhxgrH8+vWOTIiKjvdog+qbn0Wb0jCxDSE=;
 b=a5krZSOXEDsC+EXtopcSbT/6rGbywFi1cBxPy5jIPnNEnbM2o3ANGevkDka7CasR2zPBmU9lVsqBRcDd5eqUfHUvux+JOdmoFnQfguLYJ/3I1v6WmYpuiYiWHdGf5MOFw5oqiEfMfZYWTgYKZoX7bVttypblUV5z3RH8QUFsfRoLZzp/m/aKPN3sbPMzQsG4b+g0JBjwFUFVBmlFqFYvVw+FFy1v/d41H6YoF0EEEVuasdhSXZMT8Xu7TNnYCONpBarntSHAbXaYIapXU4jU1qAokb0RxWzaHiwesz7XE+k8E329qhM13tlKwvoQEVemQ7CYWoYcpFUN/e9d2UslQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1RYe7CzXrhxgrH8+vWOTIiKjvdog+qbn0Wb0jCxDSE=;
 b=ZHwMg29nlUUFkpy8Gsh7s/QyxWMKmq5OhZZIunvc4bqxcDFepu4orVl+lqbk+C4xnYzvfqPM3IHMf7h73XCAnHDMn4d7rJHurDVG8dcgHTOdadovKcS+Pvt3ap4w/2aoxUlswJQVrHa6bZlwItHPn1Zi4SdqHT4IY3bAX40oDsQ=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by SJ0PR11MB4784.namprd11.prod.outlook.com (2603:10b6:a03:2da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 09:10:24 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3%3]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 09:10:24 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "fukuri.sai@gmail.com" <fukuri.sai@gmail.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH 1/2] configure: add checking jq command
Thread-Topic: [ndctl PATCH 1/2] configure: add checking jq command
Thread-Index: AQHXDr/9AMyoOYa4m0yEn7j18UpZc6p8/OeA
Date: Wed, 10 Mar 2021 09:10:23 +0000
Message-ID: <81d1a4aee1de0ae916725c6799e921c0132d37c2.camel@intel.com>
References: <20210301172540.1511-1-qi.fuli@fujitsu.com>
In-Reply-To: <20210301172540.1511-1-qi.fuli@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e636885c-13a4-4169-3289-08d8e3a456ba
x-ms-traffictypediagnostic: SJ0PR11MB4784:
x-microsoft-antispam-prvs: <SJ0PR11MB478467D711E214A40EA53288C7919@SJ0PR11MB4784.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JEY5Z+4caFvRcZ0klscuy9tuh6WF8g0svfO9+lMEPFqFEUWYG6hp8WxoSJU6YPMZI3g5936tO0ka6d7YlqKIOTvlzhf8vDOR0iKhqUIH6eD25o0ie6jWs2ndfmNQdfevr4fhm749wznPjHIa+3yV3pbOv9Tv0jcl2X1bvS2EKebvQG9g1Nozbkrqp0GySGJVGQUobPbUja5+9GSKU5i2n9JbrnjfO4PSOfJLvKbtppD4DqZQLeXLPpukQw/q4tNv2alZB8a7Q4PdodmZsNCj2zVrEnOkGTTwwWkq7oBRe6h/JQktyUkQ+VZ0gY8hL7uQ2i18F3GRtSlGl0++pf18hRLi243rYQCVh2Jl+qoLLfxCVOfW/xyasu9npS9iMt+aRU8kFvqxxVukMl+dYBAq20DzzXcKd9aq9+BN58S6LfGb1s6HYM2kGQ6JXiyvzdTtb8vCkiu+kGIdBYkvfcFxnqMvrYp9IhhNra1fktVod2mH1YtsyNl+eNT5Pr8kk3EuCq5hb9+KDfJ34d6H6EEY6qPyFNm266kLRQS3KR5VJXGasTd5nFhxwLLpZMmol2vlqB6O2qWBdyLuii/LFsvnlqK1PPxOLlEEALSRxjQ22MI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(39860400002)(396003)(8676002)(2616005)(4326008)(316002)(966005)(478600001)(186003)(66556008)(6506007)(6486002)(110136005)(66946007)(8936002)(66476007)(76116006)(5660300002)(64756008)(66446008)(6512007)(26005)(86362001)(71200400001)(2906002)(36756003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OHpxMWdoMVVkTGptZHBZVzViTnZhOVczV2JDNkx1Y09GazZOQlRWTlZ4ZHRF?=
 =?utf-8?B?VENvWE9VekI2OFNldjJlVTJoMzZVaUNHR0Z1bWNJY280R1pveUt1RHNlaHlF?=
 =?utf-8?B?RHcyT1JvdmZ3eFVVenZKMVAreHk5YTVJbEZ6MEw1YmxtaWZhbHNQYjZIU04r?=
 =?utf-8?B?ZzVibEhqWlFCeFMxZ1ByRXRoZlpMaFdTWGdmVm10b1pHNFZqRmxRYlNweVFJ?=
 =?utf-8?B?VmtuUlc5WCtYZEdrWDFSa0I3cjRNNU93Yk5NZlg2TjVkd3U4U2xYNk5Db0JS?=
 =?utf-8?B?Y2tnOHVVNGxTN0IvMUJFMHFkQTIxSllnNkRhUWZNRENZQkF3ZEFkL2sreWY5?=
 =?utf-8?B?bVRpVXRHY1cwTE91OFB0Rkhnc2VxdDVqcERsaXBKVlYyajhGS3lRamFTSC96?=
 =?utf-8?B?WGlwa1hBamhDSXFJRWQ4T0k0K2tUQ1ZnME5zOG5KZkZVYTJ0aHdHWlRoamNZ?=
 =?utf-8?B?NzhINlozaWZuRndJcXU3T1JLeE1KZWlVZEY4QVJKNHpmUDVVZXBkVjZxRlNM?=
 =?utf-8?B?WU1wZXpuQlQxU3QxVlpXV05yYU1iRU94R1FaeS9MaEpCejFWSlBIVEdqOVlL?=
 =?utf-8?B?NW9PQ2VPUGppamN2aDBvd08yakRHZVVoc2FYbEN4L1NBQnZla0hvQUpoOVVp?=
 =?utf-8?B?WURuQk5FTThxU0FhNXdYNjRHU2pML1B2U0pwRUJERndraloyL2tzWHluQXhY?=
 =?utf-8?B?eVkxZDR0ZktJMWZQSEdOY3FERzlRQTUxOGQrdnQ4Ry9PU09aSVRMbS9MRVdG?=
 =?utf-8?B?T0k2QjY1NDNSQTRDRFZ5L3BuQkV2aG12WDNrUUdvSUlHZVdCaVBUMzBoL2M3?=
 =?utf-8?B?cGp1aHh0c0M5NjJJb3hSMmEza1IwUjQ5QW9wVDFvU2g3WkpsOHRNYm91clNp?=
 =?utf-8?B?NndFaWpQN3hIeGJaL0FqNTVxOXlYUUJuR1BGbmNlUWZGeUFWUVJoMnlNcEZM?=
 =?utf-8?B?ZGdCMFFFemJLaGV4OGxNclFRaXJ2QWJCejZHYjgyOUcxOUZReG1NMk1GY0lS?=
 =?utf-8?B?ZkhOZ0I1dkVBM1BpY3htQXhNZTI3MzQ5ckNjNmdtektHODdjUFlqaUhob0hl?=
 =?utf-8?B?Skx1U0RPRUsxT1BGZ3F2T2JJdVBiSGE2YUpQZzIrU1hSazVjN2JtTlI0MnM2?=
 =?utf-8?B?N01wRVdMNlg3WGpWc3ZFYUE4SnBCbFRqSENqczZqSWdHZjhsZDk5RCtmZjJR?=
 =?utf-8?B?MHJjNTJWUVdBYk4xa2dkTzh5R3FmMTJvd1I2eFdia3lzNlFRSktjZmhLWU5z?=
 =?utf-8?B?RTRja2dObUNiUE9SdUxaTWxKV1NoYXd0SHlKZS9oeFN0WGhnYU1ldTYyMjVI?=
 =?utf-8?B?Rk40WHZCQVRkTHBkNk5DRUNqd2UzN256dEZSWkxoR1pxMjd4bUVGY0UvbG00?=
 =?utf-8?B?cnZNTzdmR3RzMTVmbHA2SWRidUlDd2E3SDFQQ0NkOVJWTUdWWVg4N2UzUTdQ?=
 =?utf-8?B?eUFYeVpTTk1VdklGRW8xZW8ra1pBWXZ1YmxtTVUzYXdhY2hPYlZSZVlZdkkx?=
 =?utf-8?B?dHNISS9MOFNoNjd4dHNoK3c3WG9SS01sekk4a2RscmhQWlB5UUY0UTF5eSt3?=
 =?utf-8?B?eksyTUJjNS9aUDBha0duU0lwZ0FMODdNbk8rVzN6YXRPTkF1U2EyNHBiZ01D?=
 =?utf-8?B?Z3N0dktrM090OUdGTGkwRy9oUTdkZTdiR1pWQ0hJb2l3SGpaMlphNGQzQU96?=
 =?utf-8?B?VE1MNEU2R0dmaHQ1VVNqcHdVUVZIN0JRVHd6WlFvRmhualQ5S0FHUkQrUHVr?=
 =?utf-8?Q?tUVZ6+Qiv/pnyKO5VETIu6JQnamjMgAPVYw1n4B?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <70D28B8D4A589842B4449B0D59ECBEB7@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e636885c-13a4-4169-3289-08d8e3a456ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 09:10:24.0630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obsgualmYHV7ALctrF70e082JVzQ5O6XV2tlpqUN61SP12P/wdFonlixg5208/zzauKSbLZ6lw7dtqt1rzpwd1dQSV3ajNIoNUOL3BvtIMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4784
X-OriginatorOrg: intel.com
Message-ID-Hash: 3NMCJRFHQULI5XEDL6KIT332MPVRPW2E
X-Message-ID-Hash: 3NMCJRFHQULI5XEDL6KIT332MPVRPW2E
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3NMCJRFHQULI5XEDL6KIT332MPVRPW2E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

T24gVHVlLCAyMDIxLTAzLTAyIGF0IDAyOjI1ICswOTAwLCBRSSBGdWxpIHdyb3RlOg0KPiBBZGQg
Y2hlY2tpbmcganEgY29tbWFuZCBzaW5jZSBpdCBpcyBuZWVkZWQgdG8gdmFsaWRhdGUgdGVzdHMN
Cj4gDQo+IENjOiBTYW50b3NoIFNpdmFyYWogPHNhbnRvc2hAZm9zc2l4Lm9yZz4NCj4gU2lnbmVk
LW9mZi1ieTogUUkgRnVsaSA8cWkuZnVsaUBmdWppdHN1LmNvbT4NCj4gTGluazogaHR0cHM6Ly9n
aXRodWIuY29tL3BtZW0vbmRjdGwvaXNzdWVzLzE0MQ0KPiAtLS0NCj4gwqBjb25maWd1cmUuYWMg
fCA2ICsrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCg0KSG0sIEkg
dGhpbmsgSSBwcmVmZXIgaG93IHlvdSBkaWQgaXQgaW4gdjEuIGkuZS4gbm8gY29uZmlndXJlLmFj
IGNoZWNrLg0KSW4gbXkgdmlldywgY29uZmlndXJlLmFjIHRlc3RzIGFyZSBmb3IgdGhlIGNvcmUg
dGhpbmdzIG5lZWRlZCB0byAvcnVuLw0KbmRjdGwgb24gYSBzeXN0ZW0uIERldmVsb3BtZW50IHVu
aXQgdGVzdHMgY2FuIGp1c3QgY29udGludWUgdG8gdXNlDQpjaGVja19wcmVyZXEgYXMgeW91IGRp
ZC4gU28gSSdsbCBwaWNrIHVwIHYxIG9mIHRoaXMgZm9yIG5vdyAtIGlmIHlvdQ0Kd2FudCBtZSB0
byBkbyBzb21ldGhpbmcgZWxzZSBwbGVhc2UgbGV0IG1lIGtub3chDQoNCj4gDQo+IGRpZmYgLS1n
aXQgYS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMNCj4gaW5kZXggNWVjOGQyZi4uODM5ODM2
YiAxMDA2NDQNCj4gLS0tIGEvY29uZmlndXJlLmFjDQo+ICsrKyBiL2NvbmZpZ3VyZS5hYw0KPiBA
QCAtNjUsNiArNjUsMTIgQEAgZmkNCj4gwqBBQ19TVUJTVChbWE1MVE9dKQ0KPiDCoGZpDQo+IA0K
PiArQUNfQ0hFQ0tfUFJPRyhKUSwgW2pxXSwgWyQod2hpY2gganEpXSwgW21pc3NpbmddKQ0KPiAr
aWYgdGVzdCAieCRKUSIgPSB4bWlzc2luZzsgdGhlbg0KPiArCUFDX01TR19FUlJPUihbanEgY29t
bWFuZCBuZWVkZWQgdG8gdmFsaWRhdGUgdGVzdHNdKQ0KPiArZmkNCj4gK0FDX1NVQlNUKFtKUV0p
DQo+ICsNCj4gwqBBQ19DX1RZUEVPRg0KPiDCoEFDX0RFRklORShbSEFWRV9TVEFURU1FTlRfRVhQ
Ul0sIDEsIFtEZWZpbmUgdG8gMSBpZiB5b3UgaGF2ZSBzdGF0ZW1lbnQgZXhwcmVzc2lvbnMuXSkN
Cj4gDQo+IC0tDQo+IDIuMjkuMg0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KPiBMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGlt
bUBsaXN0cy4wMS5vcmcNCj4gVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1u
dmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZk
aW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52
ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
