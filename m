Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D10307A73
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Jan 2021 17:16:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AE91C100EAB46;
	Thu, 28 Jan 2021 08:16:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=redhairer.li@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9D3A8100EAB44
	for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 08:16:53 -0800 (PST)
IronPort-SDR: QbrKijO5fwT/B8P0TFrpqCrFP+OFVwZj5Pz7jiTAvy+nGtynHXNNzl5+INnAKFG6qtlOtNDjy6
 Ge+nk6A3VeEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="167931602"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400";
   d="scan'208";a="167931602"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 08:16:51 -0800
IronPort-SDR: oM7t7vQzxbLZhFh9XFqiRrAAeI3d1ChyXhLc3usaM/dA1K4F29PeDN1zPVHfHuJ7Gkjvy0Ith6
 oxstqNirJjcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400";
   d="scan'208";a="578673002"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jan 2021 08:16:51 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 08:16:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 08:16:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 28 Jan 2021 08:16:20 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 28 Jan 2021 08:16:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J89zcrKAq9CRhSXW0ekcxQeiL/XjQbDEzZKnnlSTjwy1YKCNoqr7EXOoNOTGKwdq29njl1mOcscU2NRnGQleId4uk8Hln+5rzC8d+mAWi+QR0gd9NjMlcp+kThmXbRGwuzheW+nyctFuua/2L3hFHTaY4Bj2lORjqxcmJaS+KofZTjwLVFJHddJbk53lJkj1PE+VQ4s5NuKINIIJ8M0ERdG1S4yCeC8hScWu37rAZsq3xz+lWtsujAzZLDCEH+Q3m1agfBJ8sMw8W2/xA2PJ8Fi3GhxZAek680DbhlQMAIT+ymfuFQ6yOCaifTbqRJNcyhrORY+v+8qb4ZVirit91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ9zrPIsjj5ulirJ3CpNUhaujU/WALjOUlCgRPR5OtU=;
 b=ESrxo+B8kzFGI/x649qAGblHAe690LcGAv1ScFVzEpvWHrBrx0PMI7BMnxTDfqshmspl4dLln1vFauzjHpzPg3K2NyykrQFCvf4B9YLYAFodmeYV+/81FgS/qK8NE6YLOPPuctRdsvDcri7Ts0L2titsFlvsFEYx3Vd9geZfcWzvlUmGdxSc2i4Xkx1Gv9lqy/ouFK/YHhJnfQKNeyLN30z+oTMLlobemiZUcf1mvHes/WvkBOt0aSqcy1wEM1WLmG1qAuqtDiH3OjtYbEhDWvlMwbDv5mNAx2s/I30TgVXS5Rz3Iq/hKj0w1UpWyxbd/3hmvCe8CMaUgn1OQKSx6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ9zrPIsjj5ulirJ3CpNUhaujU/WALjOUlCgRPR5OtU=;
 b=sNn5VgtsBZQQrJfJ2xSkCq4uo2k3lVFK8sX3vGaKlHy1sAaqyTg2Q++pxfabKFODtFE8X5xgvOditz/KgTRkYTYm+KoMMGOpgPTembOIqqLeZzPFaqEhpTR8NwK3zwVw5obzgUy6/aRdmZBPLUB1wg1Ph41AkEvI1FyJC0FCqko=
Received: from MWHPR11MB1375.namprd11.prod.outlook.com (2603:10b6:300:23::11)
 by MWHPR11MB1581.namprd11.prod.outlook.com (2603:10b6:301:d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Thu, 28 Jan
 2021 16:16:15 +0000
Received: from MWHPR11MB1375.namprd11.prod.outlook.com
 ([fe80::3171:f7d1:c19:fcd3]) by MWHPR11MB1375.namprd11.prod.outlook.com
 ([fe80::3171:f7d1:c19:fcd3%3]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 16:16:15 +0000
From: "Li, Redhairer" <redhairer.li@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting
 relative to seed devices
Thread-Topic: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting
 relative to seed devices
Thread-Index: AQHW6XrcV5Ed68tNgkCZDi+pg3otQqoo62HggBPmEwCAAHubIA==
Date: Thu, 28 Jan 2021 16:16:14 +0000
Message-ID: <MWHPR11MB1375EA493990A3759C8C731592BA9@MWHPR11MB1375.namprd11.prod.outlook.com>
References: <20200426095232.27524-1-redhairer.li@intel.com>
 <CAPcyv4gLKSMa4bN446MnRtjdfGaM-Hjy+dcYm316=4EP43G1wg@mail.gmail.com>
 <BL0PR11MB3281CBD1CC9B64389731ECE492AC0@BL0PR11MB3281.namprd11.prod.outlook.com>
 <CAPcyv4gupvktDG2PdCL6SyO4gwC1WoP8PKmPv1gP6pp8i10esQ@mail.gmail.com>
 <MWHPR11MB13753C37B1394CFFE124A30892A70@MWHPR11MB1375.namprd11.prod.outlook.com>
 <CAPcyv4iG9XMfrhKn+vSmU2RjyeaHtiF2pprGJ6t-56uOtPNSJg@mail.gmail.com>
In-Reply-To: <CAPcyv4iG9XMfrhKn+vSmU2RjyeaHtiF2pprGJ6t-56uOtPNSJg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [118.167.193.155]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78daeb5d-b674-4f34-bfdc-08d8c3a809b9
x-ms-traffictypediagnostic: MWHPR11MB1581:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB158139DD85DB30A6AD4B302692BA9@MWHPR11MB1581.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pm8ftpAt+/zBtqcc+XYd0p5NxVUYLeVVPcA350Ffwi9p3SmhgGkEoNqC4q8aNoFRknpxVS881OVcYEperTW2TzDtITZd1TPIzPNynD07U6ZjYwmlQvWXGmWP32EXYO59J0UZ4c8fz4VZZ5CSMfKcT5VQIIJcxgbxZoYKavwVTL/j7vf1qtRo958uD/CcVUeBAr8cYkUoXPZIabGVAvhlq5cVXYNrsjQqkZn/doS4zgmglrS7/6XxnJMgt0OPqjqHAMLHqjOzj8tQ/KZbMJNXITCIrIQLGHBF0nRVRVnnS39bqL/PcKE9fNJib2XC7yKZqdNypJjJYN0ykPBmwpVwAw5/oHy2VOCpk0qbFBGgISEbzbkIc7I+bP2ZwH+/BkZlpKypUpJ6ZvM1Y4VDoxG6upIVyrd4681jj+KkX5iTmBa51mnG2u4LWxdWjXJ0DXR5woN24PSmv9ifuEpllS0DLk2610W7C0SQbUgaPbvkj+L5Rdm6UD/w6k9jZfiJFOOxpi7c/CBab7hzXXdbglD2mQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(83380400001)(5660300002)(64756008)(52536014)(86362001)(66946007)(316002)(66446008)(76116006)(55236004)(7696005)(33656002)(8676002)(53546011)(2906002)(71200400001)(15650500001)(6636002)(4326008)(6506007)(8936002)(478600001)(55016002)(9686003)(66556008)(26005)(186003)(66476007)(6862004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UUFQYm50blh0TFZwTUN5bS9UaUVPbXlDcW5FMjYzMzBBNlpsV0V6M01wMHlh?=
 =?utf-8?B?dU54NnIvYzdXQmdpdGJmMDYvQTkyVkpITm8xalBqaUk4NlRnYkNiYk5CU1pG?=
 =?utf-8?B?MU5aN2FpS1R2R3ZNNmE4MXBjZGo2dVR6ZTE2a1Q5cWxYRVhZNmZ6Z2FpMWFY?=
 =?utf-8?B?L0FObXhJWjdzOUZVU3NMaTM1ZVBtbGVtYmxHQVprT2s4bm42MHdsSlFrTTBw?=
 =?utf-8?B?c0hkdUZpa09DUWVjeitpNnJVRWRKS09rRHliRkhuNmgwMzVMQ0dvM081MWdX?=
 =?utf-8?B?NzlZbUtacWFMeGx0ZVhPTTlHUVU3SU9JTkRVOEd3dEFjSUtzYXlZSHN5SVQz?=
 =?utf-8?B?a05waURYVUJyeS9MUTZMazE2cnRKeXFvZUU1Yk90Qm8venBIcHlrdWxKL0tF?=
 =?utf-8?B?ejRRN3hPVXlFdVpRYWxCSCsxUnByOVVQcjRPV3VZeEN5Uys4Q0xOU1pSVGR5?=
 =?utf-8?B?SzZWeWJ2NWNlaGxVQjQwTjBPOG5nME1uSUZQMEhwKzlETW92aE9EWXFCcDNZ?=
 =?utf-8?B?ODN0eElqTWM2b3JZdUhyaHBYWUpXUFRXVlFQWHMybDJQczM3U0RyTGR1cElW?=
 =?utf-8?B?UWRBL3VMb2g5Y240bDhvUlNBSzNBcVBRcVFHZGd3WTB5Ym0za2xzczEvUCs2?=
 =?utf-8?B?NTFGN1lCNTNCdkRVUHkzVGxaTkdISVAvZDFCZEI3cysvUGV1dk9YUldaYmk2?=
 =?utf-8?B?WHlqd2JEZ0JRLzFEMkpCUFQyL3BvOVVFcVFWSkFWMGVtY3VWY241Mzg2c2lI?=
 =?utf-8?B?SU5EMGFiUEJlT0RMZjdFaE92dVc0Lzg4cFdSV296NkI2UzVQMU1KMmJnOVhV?=
 =?utf-8?B?eGZMcUIwN0Jpdy9HN1NIYXc0N2RDbUhCU3RmSm1UNkovcEhyOEhoVTc2RFoz?=
 =?utf-8?B?R2lBRU9ZLzBMb0d4cHhVVnRCUmpkbU9GL1dWYVpqY21vTHVUdHRVd2VXNWJ1?=
 =?utf-8?B?OHg5OFdLRkE3Y2lGNWRUZ3dZRWhjWE1VSDZqMUJLNld5akJDTHNZMGUxK0lY?=
 =?utf-8?B?ZHEzSXhDaWJBcWYxLzhjODdkSm1pVlM2R2Rib29LZ0k5bTRJOFhjMWdlZVBv?=
 =?utf-8?B?WU85WjFYWG9LT2lYTnNKV1ZrVWFucmR6RThCV0FxRmpSM0ZOK2o4SzY5dDB1?=
 =?utf-8?B?b2YzejFublZmc1lNREp6K2tzTWpJVlRHL0MvMUdLMklYSGpBUVNhV3FrVmha?=
 =?utf-8?B?QjlJbzRhWnVCZmN5USsza1RGMy9BdlZXZWJPaVg5dmtSUkNWckRNVmhHajhY?=
 =?utf-8?B?d2tEb0tuT1ZveGE5OHR0MVVHR25GTnQ5R2l2aXd2aG9mTFAzZDJHUk1zb3Zv?=
 =?utf-8?B?Y3Z5aUpvOVRTbnRsZ25NRU9QWUpWaDBDVzBDSG1Hc0hseWJvQmpzQjF0cUJQ?=
 =?utf-8?B?by8vY1JSRVdqUEtaRU11c1hVMWNTMHNBbTRmNGRPUE01OVptZWdVdTFmL1lz?=
 =?utf-8?Q?bXBNk23r?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78daeb5d-b674-4f34-bfdc-08d8c3a809b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 16:16:14.9919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJgffrEI77eq1hT3ZM+xwJcIAOBOmGcwn8w/F08nnnP0rWF6OFOLsmQJ7Vpf/clikYGNLODrIJociXDsL+w1bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1581
X-OriginatorOrg: intel.com
Message-ID-Hash: 4LBA54RZZ4KHDHIKC3BHXFHANED4ISER
X-Message-ID-Hash: 4LBA54RZZ4KHDHIKC3BHXFHANED4ISER
X-MailFrom: redhairer.li@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4LBA54RZZ4KHDHIKC3BHXFHANED4ISER/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Resend it base on v71.1.


-----Original Message-----
From: Dan Williams <dan.j.williams@intel.com> 
Sent: Thursday, January 28, 2021 4:47 PM
To: Li, Redhairer <redhairer.li@intel.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 1/1] ndctl/namespace: Fix disable-namespace accounting relative to seed devices

On Fri, Jan 15, 2021 at 9:22 AM Li, Redhairer <redhairer.li@intel.com> wrote:
>
> Hi Dan,
>
> Your comment is make sense.
> ndctl_namespace_disable_safe will return 1 if namespace size is 0.
> I send a new patch out for review.

It looks ok but it does not apply to the current tip of tree now v71.1 can you resend?

>
> But I am not sure what do you mean for 2nd patch.
> In cmd_disable_namespace, it already print error if rc<0.
>         rc = do_xaction_namespace(namespace, ACTION_DISABLE, ctx, &disabled);
>         if (rc < 0 && !err_count)
>                 fprintf(stderr, "error disabling namespaces: %s\n",
>                                 strerror(-rc));

Hmm, you're right, once you change to the positive error code the report will just work. Did you give it a try does it fix the accounting problem with just your first patch?

>
> my patch is based on v70 due to latest one will see "FAIL: create.sh" when make check even not include my change.

I know of at least one create.sh failure that was fixed by:

Kernel commit:

2dd2a1740ee1 libnvdimm/namespace: Fix reaping of invalidated block-window-namespace labels

...which is now in v5.11-rc1 and backported to v5.10-rc4. However, that bug only started triggering after ndctl changed to reconfigure namespaces in place with commit:

d4bc247faeda ndctl/namespace: Reconfigure in-place

..which was only merged into ndctl in v71.

Another kernel change that may be causing your failures is:

d1c5246e08eb x86/mm: Fix leak of pmd ptlock

...which was merged for v5.11-rc3 and backported to v5.10.7.

Can you run latest kernel and ndctl and see if you still see the create.sh failure?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
