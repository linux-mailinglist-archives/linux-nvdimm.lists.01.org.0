Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 119713338C9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Mar 2021 10:34:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 09860100EB85D;
	Wed, 10 Mar 2021 01:34:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B78C8100EB84C
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 01:33:57 -0800 (PST)
IronPort-SDR: dHKl69KA3J9GZ1lh7ofPdrdP81wOJ+e98FJVVoJHMIhVQudT77p/C+KuJAy/BVSV2xu25peJ08
 5StMrINIMs/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="176024409"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400";
   d="scan'208";a="176024409"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 01:33:57 -0800
IronPort-SDR: VIUSYGiIoCRifQpTe9BtaBvmgXfEpQ0o4G7Xb+qoHIDrNhGsMsKCd9nxT3uJJm+t6zo3NG9llp
 yr1uif5DyDOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400";
   d="scan'208";a="603012410"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2021 01:33:57 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 01:33:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 01:33:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 10 Mar 2021 01:33:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 10 Mar 2021 01:33:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3ATFPUtWK3lvLpM59TnIs//avQXMLK2qgyo36Qby/xWEFipYbFRUGUKxl5419/f9hIUERkFvCNIShnj1pXbWrP9523p/n8h/2wsblzpH3wJ3Wr/9b0wqYTMaia0xc2ITqrVzkauQD6CB7ByWpOHIwjsre53VlLKwsnaRIa1uPQ0Ga7oz8Sz+xMSV7b7n+1hvfI3b0dbDIiaejGLufRC2ZuM3fxi15ieUrWDwZC457nKL28kU5eDiSRWfDh2dKzPhPPTatWzP8QGHkVK/apjiy8eaw8JM2nZ43kkkN7kESinCT0tAnlhNOMCcDApsJBzz1BMQL181F7P8Y3UrKiYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeMTZHGLtyFxP1JAXmQzEv/1HMbLtm42vSJrKQrC2Uk=;
 b=ZGqldd0FTnvd7HgMghut7X1bQaK9/tfIac6EfnxGQfS+7kLvtd6KpmJ1meEE1p68nPmqy/asiQC7LYdEORROStuBj4rML/0DykAGdvhTi6oNLris4FCXhYskKVM+rabGI/v1bebhqkuSbciSe7md0XZVk5JYH6bCCEzQbgIQmXq5SAafGSWLxN+TlRWmTlhGc/tHLVpR+Nd3wbk52nVAhVOnO8K24xCVBnsFob1k17xFQhXp54S4vTTJIXuXbTYkP0d5YR9ci2CRyrUkX7TUMS4CAgg6dxGf4WrxZr+At3yZ71CFIrni+KweNa6aS0zP8e3aQH+NqcNn1mfvSB2wsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeMTZHGLtyFxP1JAXmQzEv/1HMbLtm42vSJrKQrC2Uk=;
 b=Ki1z8S5FXfXwOXoYB9Eeik4jjYIE5JUjaD/iq0cWiTnpxh3ZvPJi5QpjebXvtT/u8aWAZjmZxXB0TYjLBg4J4SQ4UHzLb6OQvKOoMJgo51YG8mszl99J29n2fNx7/ItSNheQCnLwGMBzXldV7iEcpSq7ya88QbSp0FbiFDZG3mQ=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by SJ0PR11MB5184.namprd11.prod.outlook.com (2603:10b6:a03:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Wed, 10 Mar
 2021 09:33:52 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3%3]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 09:33:52 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>
Subject: Re: [PATCH v2] libnvdimm: Notify disk drivers to revalidate region
 read-only
Thread-Topic: [PATCH v2] libnvdimm: Notify disk drivers to revalidate region
 read-only
Thread-Index: AQHXFU7ZjscxBXRsek+Q2910+9bZ46p89leA
Date: Wed, 10 Mar 2021 09:33:52 +0000
Message-ID: <c016da156b56b7cd181b8eebdccfe28c5c1d3641.camel@intel.com>
References: <161534060720.528671.2341213328968989192.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161534060720.528671.2341213328968989192.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcb3c2f7-9c27-4966-8172-08d8e3a79e2f
x-ms-traffictypediagnostic: SJ0PR11MB5184:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5184CBCD41AC7638F3E33026C7919@SJ0PR11MB5184.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwbg2rV9gicqDPec72zoSM2J/u5vdBKTsBylPs1jdImtcrNeO4dFOkq+upNKHcUw5anrWEplTlPIGwvT7TcoLRe4oHF9UJD1tk1CgOPWlMd+b3zk8IFv+GqBkgGMl4XtLTbf3k74WTtrY/c3KHhyBB+14FuQyBXfZclXXctW2gXtHon5KBOmtP+SAcSdc2TjcxK5ZvbqAQsYCUvBTs8E+eHlCyhAO9vU0K+b+IkiC18oBbvVmQKNrIGzMS6prt+BFsVsRe4pdruvepFy3dBQguPZq0bO6AHISnwWqDJypJgb24Zn0ruvGmKPvmW69SQczqmVarzcXIU00+gbG5Xd5PnJuHCJRFtjBIk4bsJCv0IOiY8SYzRfqACwDZSzAWm3alcSCFA3BJbiwcJ4q6E9vMbcUv/sZ8sF0Vff9iE0pWzwQB+E1Z2FGmLtO6+crTDicZK/wY/x1G3BYrKdyoYPYEvXN1G4eycUR/jUTzR5dTVGQWsT9dsNd1Js0sdCNn6bxpZCADwJWy3Y+nKuGGAAT7Ow+EJJkL9bdTZteDy/H8tRkQrhotDhMKZgN1nS8XvaU/FDTaqU1sJ42xP+e2Cu+OCbRBfH+7VPlKhXAjhYkLg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(39860400002)(376002)(2616005)(186003)(2906002)(66946007)(64756008)(66476007)(66556008)(66446008)(86362001)(76116006)(54906003)(26005)(110136005)(966005)(4326008)(478600001)(316002)(8936002)(6512007)(71200400001)(83380400001)(5660300002)(36756003)(8676002)(6506007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MEVqZ2o4Q3VWbWdsVVVTUC9ra3A4aURQUE1obnBGQ2dJVU44ZDAweXR3cHQ2?=
 =?utf-8?B?a1VtMTVJOVlsOXNsZ2tqd1EzVnBncW9GWDhqdloyMnNRVTdLVnplbGxBM3hz?=
 =?utf-8?B?ZHNQbTJlMW5sMGhmSFJFdFJSZ0xLZmFvWlUwZnJEMUtxc1ZNdEp6azBKTHpZ?=
 =?utf-8?B?OGxpTWhkMVhramlWUGh1NEVBbFlHcUYzUURVeHBScTFiN1hxU1dqRFY3R3Z2?=
 =?utf-8?B?RXVTTHNhaWc3cmZTd0dMMGJtRmlCRmxHbnkzUldmZEl2UDFQY2M0b1dqZWtC?=
 =?utf-8?B?NE92REpsMUNoOGRFVXlCbUFwcGlmaWhheEJDU0tyN2V6S3h3YXNxcHpJem1I?=
 =?utf-8?B?Tmc0QVphZU45ZDErN01wdVZJZVhiVjFxa3huODd3N3ZMd1FuRXVWWGdJQ0Rx?=
 =?utf-8?B?aThFVnVlTWY0QmlnWk1yWk9FQUNMZVAzeXZFc1U3UUZVS3pSRTZjcURPRHcx?=
 =?utf-8?B?alh6UVgzemVGTm10WHlSVDQxbVlOYUdZZys1eGxNUDE1YUkwclRxSXZnbHAy?=
 =?utf-8?B?T3Urcm9jcjVhaHYwWVZKWUZTMGFpaXd6NDFhYUJqa2tWU0l1SkJqbEZlWWxn?=
 =?utf-8?B?NlRLZjZzNFd0cXFwT1hTUjRQeFV5bis2OER4LzNHaUd6eDlzMUwvZno1ajFS?=
 =?utf-8?B?YlVXVzRtOWtNMWk0eEdjakdSQTRPc2lNVytBV1JreVlndEo5QjM4M3Byc0ZV?=
 =?utf-8?B?MjNGWGFReXpNRUJyTW4xaGZTcVhYNnRYN2wyRjY0V1NwNnh2aVhHb3ZTVUx2?=
 =?utf-8?B?TS92akVyUlllWG0zQlluRUhVbkVaMXlSZUFac1IyaTZLZ2VHbys5OWxVUkd2?=
 =?utf-8?B?K3RjZGRwcVVPK3NneTZGWDZBdDk1MXRWcFpUZWFKWE5rVXl4SDdZbXdmRW4z?=
 =?utf-8?B?MzhSck54dmZMMEY0dFd0M2FpY092M0NnSmJkY1dWVVNCMC8rd1pmUDFRMzRD?=
 =?utf-8?B?Z3Y4MWVWc0JGTWNyTFNCNHNQZ3RSZVY1SFZPZlRueVBSbS9zdXBTQmV0MFhT?=
 =?utf-8?B?OXpPcmNEd1V1SE5GYk5qTXQ3WkFTTkpib3p5ZnM3OXY1QnpCL0JXRzdRQVhS?=
 =?utf-8?B?SlNZNHVYOEhHRzhUZDB3dDJFenB3U281WW9ycnd4TnU4UlVOZWJyQTA1NFU2?=
 =?utf-8?B?M20vVHF6a0VNMCt1OVZmNkx5QVNUcitCYzdaUzhLOVRLSmNXcXc5OVdOM0U2?=
 =?utf-8?B?L1NXdHFzVXhjaFF3MFpKZmZBYzRpT3pXQnVYS2ZyUzFNYWpGU01ocjVCa1N3?=
 =?utf-8?B?cXJYZkRmUGxaMmp1a0JJbjZNSStjc2pzemFCWkxFcFEvTm11eWJoT0hsU0VM?=
 =?utf-8?B?S3lVRDdIYVBZNGU0bDZEZlMrUjQ1WmJaY0JESndML0RORTVhREdvM2EwUjU0?=
 =?utf-8?B?UW1sUmVRMnN3QmFXMFN5Ymdia1hTd3R3eThCb0YzL0lycXJ2cmNlUDRHcG1a?=
 =?utf-8?B?djExSFFtOHRlY1QzV29NSmsrYi9FSWtSRDVDMk8wYWVoazdrN1lvTi9CcFEz?=
 =?utf-8?B?ZkdicDcrbTBSWDJJbmdOYXlZQmVyM3pRK3JjSnRiVjJIWm8zU2d1STZEN3lT?=
 =?utf-8?B?QTVvRlU1TExmWWNlR1F3eGNWTHQ0dWZGRFVGbHNJcHJzQkQvbFR6V3lqdWxQ?=
 =?utf-8?B?MnJjaE9sM1V4WHJRSHl2U2ZGKytFTExOTlNvSzY5cFlIMlVrWjBQK1hPUHpx?=
 =?utf-8?B?aUg5ekhqeEJGWVVBS3J4eThuenAxT25DVFN3OFNoTTh2Z2RiZzlxcEhuUWU5?=
 =?utf-8?Q?HMSoK2xdHRzBVNGPyVic1Qh4/dUMHn4v9vtuJEy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBB0B987C67F8D4F815A727B01B0386A@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb3c2f7-9c27-4966-8172-08d8e3a79e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 09:33:52.4852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khCdsJBHNFwBU+J+ubqnWQPt5DjspwdvewGe9/LOlu5VTSEZj5Ge0EPoaKwE/8fMNj5oFrioucqV4HluHpZuo68A4O731KyZffP4degi3Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5184
X-OriginatorOrg: intel.com
Message-ID-Hash: KFFT5VQ4UEU4YTKLBQ2OMKKE7XSWZAYP
X-Message-ID-Hash: KFFT5VQ4UEU4YTKLBQ2OMKKE7XSWZAYP
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: lkp <lkp@intel.com>, "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KFFT5VQ4UEU4YTKLBQ2OMKKE7XSWZAYP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

T24gVHVlLCAyMDIxLTAzLTA5IGF0IDE3OjQzIC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFByZXZpb3VzIGtlcm5lbHMgYWxsb3dlZCB0aGUgQkxLUk9TRVQgdG8gb3ZlcnJpZGUgdGhlIGRp
c2sncyByZWFkLW9ubHkNCj4gc3RhdHVzLiBXaXRoIHRoYXQgc2l0dWF0aW9uIGZpeGVkIHRoZSBw
bWVtIGRyaXZlciBuZWVkcyB0byByZWx5IG9uDQo+IG5vdGlmaWNhdGlvbiBldmVudHMgdG8gcmVl
dmFsdWF0ZSB0aGUgZGlzayByZWFkLW9ubHkgc3RhdHVzIGFmdGVyIHRoZQ0KPiBob3N0IHJlZ2lv
biBoYXMgYmVlbiBtYXJrZWQgcmVhZC13cml0ZS4NCj4gDQo+IFJlY2FsbCB0aGF0IHdoZW4gbGli
bnZkaW1tIGRldGVybWluZXMgdGhhdCB0aGUgcGVyc2lzdGVudCBtZW1vcnkgaGFzDQo+IGxvc3Qg
cGVyc2lzdGVuY2UgKGZvciBleGFtcGxlIGxhY2sgb2YgZW5lcmd5IHRvIGZsdXNoIGZyb20gRFJB
TSB0byBGTEFTSA0KPiBvbiBhbiBOVkRJTU0tTiBkZXZpY2UpIGl0IG1hcmtzIHRoZSByZWdpb24g
cmVhZC1vbmx5LCBidXQgdGhhdCBzdGF0ZSBjYW4NCj4gYmUgb3ZlcnJpZGRlbiBieSB0aGUgdXNl
ciB2aWE6DQo+IA0KPiDCoMKgwqBlY2hvIDAgPiAvc3lzL2J1cy9uZC9kZXZpY2VzL3JlZ2lvblgv
cmVhZF9vbmx5DQo+IA0KPiAuLi50byBkYXRlIHRoZXJlIGlzIG5vIG5vdGlmaWNhdGlvbiB0aGF0
IHRoZSByZWdpb24gaGFzIHJlc3RvcmVkDQo+IHBlcnNpc3RlbmNlLCBzbyB0aGUgdXNlciBvdmVy
cmlkZSBpcyB0aGUgb25seSByZWNvdmVyeS4NCj4gDQo+IEZpeGVzOiA1MmYwMTlkNDNjMjIgKCJi
bG9jazogYWRkIGEgaGFyZC1yZWFkb25seSBmbGFnIHRvIHN0cnVjdCBnZW5kaXNrIikNCj4gQ2M6
IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBDYzogTWluZyBMZWkgPG1pbmcubGVp
QHJlZGhhdC5jb20+DQo+IENjOiBNYXJ0aW4gSy4gUGV0ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBv
cmFjbGUuY29tPg0KPiBDYzogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IENjOiBK
ZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCBy
b2JvdCA8bGtwQGludGVsLmNvbT4NCj4gUmVwb3J0ZWQtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFs
LmwudmVybWFAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5q
LndpbGxpYW1zQGludGVsLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgdjEgWzFdOg0KPiAt
IE1vdmUgZnJvbSB0aGUgc2lua2luZyBzaGlwIG9mIHJldmFsaWRhdGVfZGlzaygpIHRvIHRoZSBs
b2NhbCBob3RuZXNzDQo+IMKgwqBvZiBuZF9wbWVtX25vdGlmeSgpIChoY2gpLg0KPiANCj4gWzFd
OiBodHRwOi8vbG9yZS5rZXJuZWwub3JnL3IvMTYxNTI3Mjg2MTk0LjQ0Njc5NC41MjE1MDM2MDM5
NjU1NzY1MDQyLnN0Z2l0QGR3aWxsaWEyLWRlc2szLmFtci5jb3JwLmludGVsLmNvbQ0KPiANCj4g
wqBkcml2ZXJzL252ZGltbS9idXMuYyAgICAgICAgIHwgICAxNCArKysrKystLS0tLS0tLQ0KPiDC
oGRyaXZlcnMvbnZkaW1tL3BtZW0uYyAgICAgICAgfCAgIDM3ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0NCj4gwqBkcml2ZXJzL252ZGltbS9yZWdpb25fZGV2cy5jIHwgICAg
NyArKysrKysrDQo+IMKgaW5jbHVkZS9saW51eC9uZC5oICAgICAgICAgICB8ICAgIDEgKw0KPiDC
oDQgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQoNCldp
dGggdGhlIHVwZGF0ZSB0byB0aGUgdW5pdCB0ZXN0IGFwcGxpZWQsIGFuZCB0aGlzLCBldmVyeXRo
aW5nIHBhc3Nlcw0KZm9yIG1lLiBZb3UgY2FuIGFkZDoNCg0KVGVzdGVkLWJ5OiBWaXNoYWwgVmVy
bWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51
eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGlu
dXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
