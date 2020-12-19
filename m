Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6379F2DEE0D
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Dec 2020 10:53:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CE113100EC1D3;
	Sat, 19 Dec 2020 01:53:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3786B100ED4A3
	for <linux-nvdimm@lists.01.org>; Sat, 19 Dec 2020 01:53:33 -0800 (PST)
IronPort-SDR: J0454x9o9emw+u0tMUqFfaMRkHXDBHMq8dhYc3Y0lqEUUPqDRZB39Osorohqn/3yC4dkQRF4bv
 hqsWViWLbH+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="175663085"
X-IronPort-AV: E=Sophos;i="5.78,433,1599548400";
   d="asc'?scan'208";a="175663085"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2020 01:53:32 -0800
IronPort-SDR: DTtvqcdN2R+mlz6mEI3TBVbo1kfLvULAoZ6hU0lX1YBqFAw2Rq73e/Y03h5i+y8Fuv09B4OyHU
 MyyWkvOdkdOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,433,1599548400";
   d="asc'?scan'208";a="339567609"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 19 Dec 2020 01:53:32 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 19 Dec 2020 01:53:32 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 19 Dec 2020 01:53:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 19 Dec 2020 01:53:31 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 19 Dec 2020 01:53:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8FEogPGW0uacBCCiYncwfs4nElly6GVzlul1Et/Ny8+RO1uJZgfpyOATzN6p9EkBfzdC1QndjQL6RhXYvd+a9E3/sF79pJWLdFEQMFG5XQqecBSuEGuwczlEF+WWddJc/D7d4eWHO4bao1Q+rombQ+A9YeDl1mHJIuTuQMZALRggY0crg4TbhBE0z14HUfNTJKHaHcqexmnYeI0FuGZgRNZZERyn+4GMuaN3PF5heQm9YXZk1WnkPiHR9CC9cLHxjvryOPSCdic2e6eENyGco48OO1Eb6uYFgqskL6GbCWqDNtzirlxRJh8RJx9qjtZmMi+xwpDEgoRxUOLQg7N4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewF3ybfUcngVoJINb5oavNT3Cg9710fu31y9lj0Cq7c=;
 b=diGkdyRXXV78CFOe4bZyF0rm8nzj32NKxd5ZVFhvbXNdeuNPDiidbQ7ZkOp391DCHZXm278qtzrZ9eGtoEoIy/qlA3rPSnMs0DZR7sAQ4HgYuTnR8vToVULWDt6PtWv3PT0qNhcXxymRz4JkmoeRQQ4hdhkZ9XUDDw5Ct3bXt8FY4Jro9njoQKG0UOAfpV9GnpbXb3zknVdMgrNIZAs5RxUkXOALUECKg57cRNYt30mzaBYnLF4mZy7aVN/I0SGGnzvmUE1UwsIcAOjCScsPUpBv9HNc6z0Wmno4T5ejaqtRHscUEoofn7eUdfgltjkdD0suxo11TLbFCS2Axw+pAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewF3ybfUcngVoJINb5oavNT3Cg9710fu31y9lj0Cq7c=;
 b=fSXgrEtOB476bEdREK9G1plftBpqEE8Z6uVH7AV3q7Dio2W0jMkhKhtxjBL5twZ7VCd/gh0BVJB1Zl426EzuSR3Pnp15vS+l289ekv2B5SIno4AXYBOF7uzHrKvK9iYWsxlKJIez4m2FeflfnHhyJ0p86EQqrMEM86D6bWYl2Ag=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BY5PR11MB4388.namprd11.prod.outlook.com (2603:10b6:a03:1c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29; Sat, 19 Dec
 2020 09:52:46 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae%7]) with mapi id 15.20.3654.025; Sat, 19 Dec 2020
 09:52:46 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: [ANNOUNCE] ndctl v71
Thread-Topic: [ANNOUNCE] ndctl v71
Thread-Index: AQHW1ey0LV5gbC5PoEG6LESasKCOdg==
Date: Sat, 19 Dec 2020 09:52:46 +0000
Message-ID: <ddfb34fe592b9a20d289e33eafd1a87015f77ed1.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03c94ce4-fbd7-4dd6-e9e3-08d8a403d6c4
x-ms-traffictypediagnostic: BY5PR11MB4388:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4388950430FAF01AD1A6D3F9C7C20@BY5PR11MB4388.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wqk/dPp4W2FGMSVXLI+UM9DMY1j5xjGeq8NxH5ShdSduEZe64Br5Cczji67C08sFWDaDVOKgx0g8l9vbovUZUAbnY0KX7TWhrMGdd6wBwJfB/IyYpnZkvgp+QY1XDVe3AJxDgQbtPeLyybS8QZB1xIp1J6kg2XCm0xrfa07l3tQ3T4dtECFEFt6lRmTRjS7i0NzvS+6TFDlmxcf2UO6viLHhwAEY9V01IPUsggNaNYYGrWMj32r5dmW7zVIjuoLyPQz325BKQgYSk9wIFKaCqbLZ6QTNbNoN+hxfqdeSLC3QvCWzjiQtWl1ETEGoz+e3fSvY/GvTz+SphxY2honLGYo9GjPZB1aiTJaAvK9OMSVmIH2rBzXCjFIq10QR9vw8d0bT3mZos1CAKSRdj2QIkzIqNUWqJwph32f6oTE2U/yGHuCxyJztcUK59xxqwCn7o3UPfTPwJwdQob1O8pW//w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(2906002)(8676002)(8936002)(6486002)(66446008)(966005)(83380400001)(478600001)(6512007)(6506007)(316002)(86362001)(99936003)(64756008)(2616005)(5660300002)(76116006)(6916009)(66476007)(36756003)(4326008)(66616009)(66556008)(66946007)(71200400001)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UlNWRE0rbHZPRjFzVzM0ZW4wdGxoOHd6Q005U3RLVU5VU292VHUyT2hTSFBK?=
 =?utf-8?B?Q0s3bXJkeDdNRnhvLzZyRnI2MDFlSGV1TWsyck8rZFhkeXBXR1FhWGxNdjlt?=
 =?utf-8?B?THdCbW4wTGNkNnhpRkhOUUFWT2cwdlRZZmZ2NTlUSlJ6S28yWG9qOFVSY2hm?=
 =?utf-8?B?QkpnU2IwQmhJZGt5WnNGZUZKNURrMG9yQ2NKa29oZ25iUjlBRXZZLzFNaDBy?=
 =?utf-8?B?Nkd1dEVDZ3haU2twNnlyNnR2dkNpeG0wdE9QaEJuSHEwMXRRUkZScm9IV015?=
 =?utf-8?B?TjFGY3FZZVZPbnlkZWtmallqUjhPa0I1ckFkbUF3U0t2dGRXQm03dlV0Zmxr?=
 =?utf-8?B?c1E5QW50VWFaU2lrZ3Z1MDRSV0tsT0g4RDdpeXZEQTZ4MVJsbTVrR2dQZlIw?=
 =?utf-8?B?aDNmMHltTWJnUWc1Z1Z1aFJ1Qi9GdjFFYUd2b0p0ZEdZU2FZbmdYdmtnd01q?=
 =?utf-8?B?bUJzK0Z5Rk1OL1pBVmdhY21ublFFNDFtb1d1Ny9yYi96U0d4Ni82c1FOcW84?=
 =?utf-8?B?VGU4Q3JURnl0czk4ZHprc2YzZnlyY3dta1ZlWWxVejJyei9zc2puVE1lZ3pq?=
 =?utf-8?B?dnIwSFJpbWV1ZUZ2U1htRUJReGs5TjUxSkRrT3dRQmJINzJTd1plNUpiZXdH?=
 =?utf-8?B?Y256VmJXcm9RaXZOZWdGOW8vRGw3UW54Nmc1a1BnL2dJVk1XOWswcjlYNTRn?=
 =?utf-8?B?dlRTZlJ4bS9NTXo0cDVJQ25IVExvajB2VXA0Uk8yV3ljQkJpK3ZrckFYdzVm?=
 =?utf-8?B?Tm5adzVSOTFRczdqTU9FQnZjTEhMRThReG4rWU1pM1lYZmdPOUh1ajJ4MWVX?=
 =?utf-8?B?WDVELzJyUUxVRWhBMFdpeVpQdXQ3UXBraEZCc2JHR2hJZDZMSVA2TElHWWdP?=
 =?utf-8?B?YXBwUHdOQVFtTG9DQmRReUU3azNMWHZNdWtEWFJRbWllTHRkR3FiRzZrZW1E?=
 =?utf-8?B?aWFuV1ZnUTNOc3pZV1VzMldvbk1yTXh0RFQ2dGJJd3Rud0RVTm5LNWlUK3JQ?=
 =?utf-8?B?blVjT3Z1KytNSWxqMzI5WmZaeERaSmY0NUNUZ25wM2IvSGtHcnF1eElDRjRK?=
 =?utf-8?B?YldtTXRwSUdDKzRmSSt2UGV3RzhSVDdaUGl4eS9Lb1lNT055WXZYQTlRRkc4?=
 =?utf-8?B?cXNTQ1lrT04wekVCWjgzbDNiRW1tMWxZL1hSWnJGaEVLdTU0MC9tN2FXSlll?=
 =?utf-8?B?TGRPRkRtRDFuQ014ZjkvOS9GbjJ4dGtwNWR6UnRvUG52TytvZkpPZXRla2tQ?=
 =?utf-8?B?N3hiZ2dpN1A3c0g0eEJielAwRkgrL3NRMC92emY1SFpYeFNxbm8zUnFVblI4?=
 =?utf-8?Q?5fqaBBblwbACYijAQIz9zxVqx2OngZiyLo?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c94ce4-fbd7-4dd6-e9e3-08d8a403d6c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2020 09:52:46.7231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 381UJhopu8DyYkXzAumuhzsO9/iWxa+cbDfll+yrspaULhxf5F7WnnOGb3pEOkLj4xlTiz6NEK9TAl4lYSvUA/8Vs1udVEokY4iCjTUgH24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4388
X-OriginatorOrg: intel.com
Message-ID-Hash: VMNTVPLAHGTIAQB57DPBB7JCQRRMHW6P
X-Message-ID-Hash: VMNTVPLAHGTIAQB57DPBB7JCQRRMHW6P
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VMNTVPLAHGTIAQB57DPBB7JCQRRMHW6P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============2730612159920387700=="

--===============2730612159920387700==
Content-Language: en-US
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-J+ZVMw1oox0uaUwD7tuE"

--=-J+ZVMw1oox0uaUwD7tuE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A new ndctl release is available[1].

Highlights include support for the new device-dax subdivision
functionality added in Linux in v5.10, including ways to create smaller
devdax devices using daxctl/libdaxctl, as well as creating, listing, and
restoring from a config dump, 'mappings' on these devices. Other updates
include several static analysis fixups, reworking the license
identification scheme for different sub-components, and a fix for the
reconfigure-in-place workflow which tries to retain device names.

A shortlog is appended below.

[1]: https://github.com/pmem/ndctl/releases/tag/v71


Aneesh Kumar K.V (1):
      daxctl: phys_index value 0 is valid

Dan Williams (6):
      build: Use asciidoc instead of asciidoctor on RHEL
      ndctl/namespace: Catch attempts to sub-divide legacy / label-less cap=
acity
      Clarify COPYING
      daxctl: Cleanup whitespace
      Rework license identification
      ndctl/namespace: Reconfigure in-place

Joao Martins (20):
      libdaxctl: add daxctl_dev_set_size()
      daxctl: add resize support in reconfigure-device
      daxctl: add command to disable devdax device
      daxctl: add command to enable devdax device
      libdaxctl: add daxctl_region_create_dev()
      daxctl: add command to create device
      libdaxctl: add daxctl_region_destroy_dev()
      daxctl: add command to destroy device
      daxctl/test: Add tests for dynamic dax regions
      test/daxctl-create.sh: Validate @size versus mappingX sizes
      daxctl: add daxctl_dev_{get,set}_align()
      util/json: Print device align
      daxctl: add align support in reconfigure-device
      daxctl: add align support in create-device
      daxctl/test: Add a test for daxctl-create with align
      libdaxctl: add mapping iterator APIs
      daxctl: include mappings when listing
      libdaxctl: add daxctl_dev_set_mapping()
      daxctl: allow creating devices from input json
      daxctl/test: add a test for daxctl-create with input file

Vishal Verma (3):
      Documentation/daxctl: use option includes in reconfigure-device
      daxctl/device: fix a memory leak in create-device
      ndctl.spec.in: update for license reworks

Zhiqiang Liu (8):
      namespace: check whether pfn|dax|btt is NULL in setup_namespace
      lib/libndctl: fix memory leakage problem in add_bus
      libdaxctl: fix memory leakage in add_dax_region()
      dimm: fix potential fd leakage in dimm_action()
      util/help: check whether strdup returns NULL in exec_man_konqueror
      lib/inject: check whether cmd is created successfully
      Check whether ndctl_btt_get_namespace returns NULL in callers
      Check whether seed is NULL in validate_namespace_options

--=-J+ZVMw1oox0uaUwD7tuE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQT9vPEBxh63bwxRYEEPzq5USduLdgUCX93NaAAKCRAPzq5USduL
dpaVAPY4AU3HJsOLOUhE3G+D1+LULkYCltSEOA8v4Np13qbHAP4+Wr47WoWgIEF1
ya5ghNX0l/eY4h6zNWiu3dRLpbuiBg==
=jTHT
-----END PGP SIGNATURE-----

--=-J+ZVMw1oox0uaUwD7tuE--

--===============2730612159920387700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============2730612159920387700==--
