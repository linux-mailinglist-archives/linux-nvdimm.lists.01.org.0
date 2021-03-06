Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B08C32FD21
	for <lists+linux-nvdimm@lfdr.de>; Sat,  6 Mar 2021 21:33:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 58556100ED48C;
	Sat,  6 Mar 2021 12:33:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D0511100EF264;
	Sat,  6 Mar 2021 12:33:11 -0800 (PST)
IronPort-SDR: AFv3belU2Gegfnl1K4HY8V2xXbae3t9w2AxVR/AsqxAxQhV6bhTXggrWlXl6XkgcJ1YKY/RlIi
 uNFtaJPFHKHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9915"; a="187191447"
X-IronPort-AV: E=Sophos;i="5.81,228,1610438400";
   d="scan'208";a="187191447"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2021 12:33:10 -0800
IronPort-SDR: UOSe9kY9acVy0Zi7KD4794tt+Gc2yL8Su8gxpgWY/YzJFS/18Auk8ZO0b7FGq4g9WfyXH3y0NB
 Lvn8sRz/vTiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,229,1610438400";
   d="scan'208";a="385353812"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 06 Mar 2021 12:33:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 6 Mar 2021 12:33:10 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 6 Mar 2021 12:33:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sat, 6 Mar 2021 12:33:09 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.52) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sat, 6 Mar 2021 12:33:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du6NvG6xVPFH3xHuVZSrkri5EPD6FZrmDqy3fwiSlL32bNzrlxHfsVrOUoDaLlHRkRSd6ndbeh64x5GdWstaHjZKX4mIXAcFRS+OtB2L2QckoIFNdruQ+j63kG9+rBZgpVwt9M/AY1Goukdat+9V1aIMDvoz13+mUppYIjVIM4zEvSKwpcMWEu1GEUNSytgWn1hq2iTAdzgbPX8xWzlXMe3XEWjT3dxAn5xzp8Ne32+lw62vyl/ef/Vh/M60295/1/OHD1Nq520wdYRWbv/AE0noj9nH6UmLMAHKAOff0kAnpOYbiiHBNfXto1teS7+5KHatgK1giBXAIb1e3QwgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RHwywtyXrSjChezlGeMyo9AGDrKmxPwtpwE0jw+4Lg=;
 b=d48mEPelGAwj3Pt2XKeHanG/xjBCLCgkQl4hKw0wcg4SLjdJBYkekVS468WdC0CgOpbTqdpdp28dRANFdjNwXKd+pPYEtfJsutQsHAlUAJLsalZ4Cd2tLZwRHZXSCFQ/luCpmNEeNsUSlkW90722kHi8H8ZRG3iqJJemCGgpXVR//xa5E5I5v/gGn4Uo2/kEBpii4ketfUoHca71PqNTQt/Y/8TbNVO6bZw8WWRW8ez+fjcVM7dejVuIcuA8VctJRQoSD4zRflFdVcqu9NxIUvZV9HPqJutTjWsVC0skjGFQjgDh064+diwK6EIXrxYc+1QxCqgzXz128jgJ6F5u7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RHwywtyXrSjChezlGeMyo9AGDrKmxPwtpwE0jw+4Lg=;
 b=kDZp+t5mYgVEnNrA4CyoWa0NvqKB6dGBELrWxV/3CdIKGNoatgJcuYDzD/ZJwbBLoIBi2yT7BEH3aQ2Fi4rdJWHQej3wS2u4dWzky/hW0Te8qko/Eig8BaUFlwH2kcEbnJUDjhV4B71ChFrVh7fkqQhQn0udlCsid7+bYnrstqQ=
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18)
 by BYAPR11MB3286.namprd11.prod.outlook.com (2603:10b6:a03:79::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Sat, 6 Mar
 2021 20:33:05 +0000
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::5127:2366:9745:85d8]) by SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::5127:2366:9745:85d8%7]) with mapi id 15.20.3890.035; Sat, 6 Mar 2021
 20:33:05 +0000
From: "Williams, Dan J" <dan.j.williams@intel.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [block]  52f019d43c: ndctl.test-libndctl.fail
Thread-Topic: [block]  52f019d43c: ndctl.test-libndctl.fail
Thread-Index: AQHXEZMjgzQQGI9GwEqsFA9jwQ3SzKp3bLEA
Date: Sat, 6 Mar 2021 20:33:04 +0000
Message-ID: <6f40b1f53c029788e20fe175618d8772e36d648c.camel@intel.com>
References: <20210305055900.GC31481@xsang-OptiPlex-9020>
	 <20210305074204.GA17414@lst.de>
In-Reply-To: <20210305074204.GA17414@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-2.fc32) 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ca22427-b9d3-44b5-8c39-08d8e0df0bb1
x-ms-traffictypediagnostic: BYAPR11MB3286:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3286C71B12264D265D8556D4C6959@BYAPR11MB3286.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wFHWv0fB0HOKPAGmioyLwAwFdK8tV2gBHEWO+lIKSKtCP1nA5AWlL35x5t8vO9lTGADVhu6MqXRGXHGjSdn+AhEXQZcPj152dE5m9FqEsVqd33GrqLX91rhokU0K6QjbxNQn7uD4e2SSU1wyxHHjI3yF/x33ZHy8ikWl3PO1XFez9CQf2YSoWgc2nTNfjmPowj+RTw0dLXbvjNRi1KKgcEJCnCVBTvhapMl3wMRNUxYOwPTv15yYR9tgcRWm6OkAd5LWzJE1j2ioc2Cjpy9MxsnCxShr6U+DL/vT9TpIkbxDeJ5t0S2PhtbVF8a1M0lidVu5Vp9YcsE1sb5mz60uOtbc1aVf1wzGgvEXFOIDpPUC6951FROGg61Ooh2AaMyEgQ32AHHErPv6LgPFyrywNislMqPvxyBQuUmkE5pENXxkmTk79v90HQBIUcvD6CWSmMJxi4eCpKqSGLOOR/f+kHf8CcvVlgZDDCCLkgY387XIcwj/CWiYVGb/IDlUIZW+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5150.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39860400002)(376002)(396003)(2906002)(478600001)(4326008)(186003)(26005)(5660300002)(83380400001)(6506007)(36756003)(64756008)(8936002)(66476007)(2616005)(316002)(91956017)(6512007)(6916009)(86362001)(66946007)(66556008)(66446008)(71200400001)(54906003)(76116006)(8676002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MzZ2ZUVhRWZSQ3dCVVR4QS93WTZxM3V3dEtXSktQWHlMZmhjOUxHOG5UeU14?=
 =?utf-8?B?cVErZnlsdDhFcU4zUzhrZ1FHbWZ1UzljaVdWVi9LSWhwTGR6em0rdmtjOHJP?=
 =?utf-8?B?R0h6WHJXZVlrcTFyaCtXQktIbE9UTURtUjVlK3pudWZPcFVhZHBSVnhnLzB4?=
 =?utf-8?B?cWVMVCtQdFlvSENPa0pRbXZqRzhYY1pzdHN4R28zTmJXR1plNVorMXRlQ1Y1?=
 =?utf-8?B?ZTVxdGFZY3AwU0h6YUpMdFJRWHhtZXBka2F3Ry91bUhIODBDSFp5UUVabHZ0?=
 =?utf-8?B?aGJ5a0dlTUpNSmpWdzZheVRXYk1TWEFCMUZlRTBZcmVPMDlRYTJZc1JucDk3?=
 =?utf-8?B?UXduQnN3ZmJKWllQcjBxSUxUU3hiUk0wcGJVMUsvdkdla3JkQS9tYmRtQzcz?=
 =?utf-8?B?R3d1eXZUS0x2SjJnL0FwZ3NtTUFFazVKbFNpZWNwYzl0allzblhQdkV0TnZs?=
 =?utf-8?B?WVpzTEwySWI4STBSTFdQVGtyM3VHOThRMUFHZHhYd0NaZnkwM2NqcHNwQ1lD?=
 =?utf-8?B?elQ5OEFNelg2bmtOS1hkbzFSY1FyVFd4TUtzY0NnTzB0UnJIR3R2ekxENzJm?=
 =?utf-8?B?Rm4yTHViM2xldGFDYld1M1c3L0ZndVFZOG1WTXl6Tktza2w1cXhQa3dSZE5a?=
 =?utf-8?B?ZGhXbmdkK0JqSWRVRlZUTEIwTkZ6MzVGQWpEcHVmYmplTEhoRXp1MFlWWjF2?=
 =?utf-8?B?emZlZTQzNVVFVmw4U1ZjZEliRVRwTWxXZzRqU0xWTzVZaHBKTU1OVmhXU29p?=
 =?utf-8?B?M0RTWFBxa1NLekRBUk9UajF5V0tCamtWZTZ0SDQ0aEYyYkRXdURadWM2Q09h?=
 =?utf-8?B?U0hpL2tUOUdTajNuZmUyNFVFNWIzZXV6ZndCM1g3QmtoU2dFZkxBSVJMVHZ0?=
 =?utf-8?B?OU4yNCs5TjYzNU5xbHZKUm5ubGxxUlZDSkNxNUE4L2FnNXMwYU1DSDA4TnNz?=
 =?utf-8?B?YjBudllOYmxOWmw2MGsxS0NZTVFMeGJKeUlvSksvVFd3Y1BvQkdUdjlhMk9w?=
 =?utf-8?B?M2pMMmZtUmRkNUhyYlpsNHh2TlZKeEFmN2UrVDRhNG1BL3hzV0oySDAzVkpz?=
 =?utf-8?B?SFNjRkJwQ0ZNRWhURHg4YkN1NDBjL3hCOVVMd0d4WEhPdWJxMW1UU0NGNFI2?=
 =?utf-8?B?VlJiV1o0bkJsWjZsYnNFNlI3WitXckcxRU1iUk9PMG0wTWtNY2IrRXhtVkZt?=
 =?utf-8?B?cG8rOCtvcFJlbDZQNHhWRFYrYlpHNTZkU3R4SFBPS1QzSmFsb1d1N2FSS0RP?=
 =?utf-8?B?RFBCdThmVnNSdEJwVzJTWEdwREJqbWZlVDN5ZEd3NE5BekI0N090c3o0Y1Fh?=
 =?utf-8?B?N0tPY3dXOEtsWCt2ZE9mVUF5dkVLVUF6VkgyOVRPOHZPNmo4N2VxMVlVeTNQ?=
 =?utf-8?B?dXlaWlRBVUNsY1cwSHRLdllIajZ4dVRMNkhJWVVZcDR5RG1KT0tzNURJQzRq?=
 =?utf-8?B?Qm1EVFk1alJ6T3dWcGtLYnlmRXhPMzhKNDdPN3UwYlozYzJrYUtvQndGMlhm?=
 =?utf-8?B?cmEwdjVwaXpNVDFoM0hTaG0zWTVhYSt4VS9TaXFiRDZGUlZwTmtYT25PYnFL?=
 =?utf-8?B?cDdReFgzdTl2VVpacGhlTDZBL2NwTHdFSG1DMDc4UE14K2tFNXd5eWMyUmxG?=
 =?utf-8?B?L2hzVXEvTTMxcjA1Smo2cGcyTndHS2lsVUllRWdrd0I2MVBjU0FQSm1sWUZB?=
 =?utf-8?B?MUMrS0dmclFNV0JabUZyeXVnOUNRWnExdDVZaTlyeUFXQk1WSDVoQzdxMzl4?=
 =?utf-8?Q?vqcbubfs99dkEKiCmagg8dcAZrjllmdX4YMAvld?=
Content-ID: <429AD38932649741A5C0C9E1E934C407@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5150.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca22427-b9d3-44b5-8c39-08d8e0df0bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2021 20:33:04.9009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: St3n9jBYnZV6ptqVsyddozBSRUTbqwXW63fKn9MnXzgq6GiojehX8KFf1A/+YYzD9BfZBdn//UPfqDBVQx0XQZ0/qDdlYPesP3RhVDBc890=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3286
X-OriginatorOrg: intel.com
Message-ID-Hash: UCULDBPV2NKJPLAHWNHKA5MJ2PLPW4SX
X-Message-ID-Hash: UCULDBPV2NKJPLAHWNHKA5MJ2PLPW4SX
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: lkp <lkp@intel.com>, "hare@suse.de" <hare@suse.de>,
	"olkuroch@cisco.com" <olkuroch@cisco.com>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"lkp@lists.01.org" <lkp@lists.01.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "Sang,"@ml01.01.org,
	Oliver@ml01.01.org, " <oliver.sang@intel.com>, "@ml01.01.org,
	martin.petersen@oracle.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UCULDBPV2NKJPLAHWNHKA5MJ2PLPW4SX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2021-03-05 at 08:42 +0100, Christoph Hellwig wrote:
> Dan,
> 
> can you make any sense of thos report?
[..]
> > check_set_config_data: dimm: 0 read2 data miscompare: 0
> > check_set_config_data: dimm: 0x1 read2 data miscompare: 0
> > check_set_config_data: dimm: 0x100 read2 data miscompare: 0
> > check_set_config_data: dimm: 0x101 read2 data miscompare: 0
> > check_dax_autodetect: dax_ndns: 0x558a74d92f00 ndns: 0x558a74d92f00
> > check_dax_autodetect: dax_ndns: 0x558a74d91f40 ndns: 0x558a74d91f40
> > check_pfn_autodetect: pfn_ndns: 0x558a74d91f40 ndns: 0x558a74d91f40
> > check_pfn_autodetect: pfn_ndns: 0x558a74d8c5e0 ndns: 0x558a74d8c5e0
> > check_btt_autodetect: btt_ndns: 0x558a74d8c5e0 ndns: 0x558a74d8c5e0
> > check_btt_autodetect: btt_ndns: 0x558a74da1390 ndns: 0x558a74da1390
> > check_btt_autodetect: btt_ndns: 0x558a74d8c5e0 ndns: 0x558a74d8c5e0
> > check_btt_autodetect: btt_ndns: 0x558a74d91f40 ndns: 0x558a74d91f40
> > namespace7.0: failed to write /dev/pmem7
> > check_namespaces: namespace7.0 validate_bdev failed
> > ndctl-test1 failed: -6
> > libkmod: ERROR ../libkmod/libkmod-module.c:793 kmod_module_remove_module: could not remove 'nfit_test': Resource temporarily unavailable
> > test-libndctl: FAIL

Yes, it looks like my unit test checks for exactly the behavior you
changed. It was convenient to test that the device could be switched
back to rw via BLKROSET, but I don't require that. The new behaviour of
letting the disk->ro take precedence makes more sense to me, so I'll
update the test for the new behaviour.

I.e. I don't think regressing a unit test counts as a userspace
regression.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
