Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B7632315C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Feb 2021 20:23:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 605AC100EB35E;
	Tue, 23 Feb 2021 11:23:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BF781100EB35B
	for <linux-nvdimm@lists.01.org>; Tue, 23 Feb 2021 11:23:08 -0800 (PST)
IronPort-SDR: Q1Dn7rXGTMrVwxVQIWmRIIK0GCNBb2Y9c4up4SjNl8TzF2+ZsZXlMgjzQt5Hi640s4DG2KSqy0
 XJIe0LD/D8EA==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="184216149"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400";
   d="scan'208";a="184216149"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:23:08 -0800
IronPort-SDR: hAeHrrmNtPANrzFvd2tgKiX8lqpBmDlZiqa774CnchUUXL2f/2NMDkgntoTijtRvyYyjnB5BmD
 ZxC35Cm3AB6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400";
   d="scan'208";a="423754023"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 23 Feb 2021 11:23:07 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Feb 2021 11:23:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Feb 2021 11:23:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Feb 2021 11:23:07 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Feb 2021 11:23:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYYrSb+99QbNM5tY8oFEF82RpUFKKu8E9g0bS3w5Ogl/O88ddW+eCJia632dOfthdqKCX75MdJWJYE/GMqzGSBxU6F5O94GWMeSNbUt1I7OmgMvT/7CnDuXMXya/SzW5hvbQ4fxZizuOPk5wIRAmjCLpe0vuC3xhFkC/D2ZdVKmnei9OF/SLogrhQgcFXBJJ5/aH/9YXIBdkD21GBRSXVMN9EHvSehf0EnOzcZud5W2KbpXbugok/PAv0EkuTVH2TJ1Jt0z1fqZy804HRUv/TgI82jqWigi8KcLxGgRU9IlhV2qdqhuTrF33jAkeyy6W2IX/IxhDI7FoPXr7ArphZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5rSyi9Xd9TPL93HfI0nXibB4UrxIQDRilvYUwn9o3E=;
 b=Gu7GrV2OChrigx5V/RFWPoX0fSNUzwDEKIaBYFAJqJw7Lfcv2fAVrGrXhIJxiHpdvYJKEsM+YCIc6ZsvwIonGqw8eljRbpA/e7h+On+OrSqiy5I/x+/nK4i5NZ0yDoqLzUUVg1OCRbhSho6v1Y5bzQricz/T+7w/wBVXjqTrU3f7qAkYit0tsY0Gn83+Eahmd839ICLw3FAHlBvghlOZJa4FNturxLRqugk+fl1H1lND6x4DZKpAa+RctNJg3E0qqJ0+edXutTEDvSKz+byfwcHBDdPCfdRZbBrxiEhgBCTpgWKXalBrVNGVZ0X1BZCuWq6M8qkQK/pKw3GEB1QO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5rSyi9Xd9TPL93HfI0nXibB4UrxIQDRilvYUwn9o3E=;
 b=XEoS6WOF4RwrhYtDxQAtVAF0DWgyUOT2Y/RvgHWew2Pi89YdKXuMeVoYvj7AS2VowZr5E4fSPsaoCrtdPmfjyHq7EOkb8ROh0Iw8qwC/oZySDejgHtk5QRTzmYX87C5ZeqJdRH5AUQUYqt/hJ2Mlyrun9mvhvj8UY4ikt0+mzXU=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB3559.namprd11.prod.outlook.com (2603:10b6:a03:f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 19:23:04 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::b86b:4cf0:b741:11e3%3]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 19:23:04 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Widawsky, Ben" <ben.widawsky@intel.com>
Subject: Re: [ndctl PATCH v2 01/13] cxl: add a cxl utility and libcxl library
Thread-Topic: [ndctl PATCH v2 01/13] cxl: add a cxl utility and libcxl library
Thread-Index: AQHXBmN+rAutzLBwd0if/n3TQcDzFqpkuLeAgAFtHAA=
Date: Tue, 23 Feb 2021 19:23:03 +0000
Message-ID: <f62d4e8dd4cd89f68c733b0b108b5b3464908862.camel@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
	 <20210219020331.725687-2-vishal.l.verma@intel.com>
	 <20210222213615.lwjansmxclewb3xo@intel.com>
In-Reply-To: <20210222213615.lwjansmxclewb3xo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: feb5c6d9-8f2d-4deb-7ca7-08d8d8307113
x-ms-traffictypediagnostic: BYAPR11MB3559:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3559C6F21869F64AEA8F573BC7809@BYAPR11MB3559.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y5XimI2DeR5yIeg9Y4jGHIqJYLyrev3f9kYzrKilwq1JynoxHfnnW4vPWBJZ9XRTZ/i5fk4l3tKZ5R7gB9BpRell4aRXRsTRcjn80njYUjq429k6LHpj9xbYQS4eJabddaCmg83B73aAhYxvR20EZUuxbl5vZAFAv0XgoaWTSBMAZWw0Ax99+WQiY5FMWMRghL0JToR8uHlUolYqTLnpODzZV5ZB9jzFy3sqg4C4/GcFltXY/JKBYp8Osr0OOHp+HLIwb0aHfEWhuX+Mpvz6iOaewn0d1LVZ57726ty0Qae9j9Fid++ozL03i+qVCqJxN6CxmN6nf+gu1+T9ivYQ+XGB8NEoJQU2u+6TeNDjAwYCLD/iMbBejtXZdC5noJmlmdVAN/2EjkasbX1xFvNe5XwQfFZyUzMe74H9fytnk2J1cS33uTzBq+RO9zgABLWcpupB1ZO2vngEyBJgzzKk3kDq81WfaC4HAWVdjI+ClwlaagE4Q0Kv5D57CvEjpd8pMXkPmSBLMTrzW1NVjM8Sqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39850400004)(396003)(136003)(6636002)(66556008)(71200400001)(26005)(5660300002)(478600001)(37006003)(2906002)(186003)(66446008)(316002)(4326008)(6862004)(64756008)(76116006)(91956017)(86362001)(6486002)(8936002)(6512007)(8676002)(2616005)(36756003)(6506007)(66946007)(66476007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VEs2blRQTy94TUE0bkNnbHZ5OVZ1OHl3OUNMdG9qcXBtN1NOZFJjTk9LQlo1?=
 =?utf-8?B?a1hoUzh3aDhZOVU2SHRyaW1ObTFGZFdaZ25QQXFXWE1FZWdhNzhzaDFnQ2p2?=
 =?utf-8?B?clVha0xRUGMzaDdrM3RlQk5RK3EzdEJoUkYwV21rOFM5VDQxS3dnS2ZncXc5?=
 =?utf-8?B?NC9MWnpLUXovYWJCMWtBd0xWcVdOQXdLR2M3R1Z6OEdRNmFYMU04Y2xWaUV5?=
 =?utf-8?B?R2ZjWGRLdktYUDlKRTVGM2Q3ZzN3ellmVUFadWtGWGxSQ0JnQ29zSlY2K2ZN?=
 =?utf-8?B?TTF1ZW5VdWdiOGk3M0o2amNlK3JObnp3K2MwTWxsZGhjbkQ1b3lVVlFVbGFx?=
 =?utf-8?B?ZFU5WlVyQ2pRVXdoSXI4anVGYjdoV1g5K2gzMTByUm1MNGYxUVMzZkJXOW9x?=
 =?utf-8?B?cEU4cmJBMmlZYkhsaHVUa2tjSmVYQW8zbHUwRy9zYnpHY0dxMkY3NXJqaGw4?=
 =?utf-8?B?ajA0bTR6WElPQjdoU1MrSzVlbWltd1d2UVd5QUxKNXlrWWlpdUJpM0tFbWFh?=
 =?utf-8?B?d0d2U3lISVZybTdua0pKQ2ZRb2lOM29VRmIvOEQyVE1OZkxqZG5aNkUzN2Yy?=
 =?utf-8?B?TmtjSWZ1cVRMVkFpbHoxZW95aFZ3dU00NVJoWC9Ob1ZIR1hvNnpSNERtWENM?=
 =?utf-8?B?d050Vis2YmpoUmxlMjlyYUNsWDlGRmhxOXJQcWhRMi9GOEFoVXhINmI1MUZK?=
 =?utf-8?B?OUx5a0ZFLzg0R3FySGp4Vjhtb3ovN3N0Q3FWSlRqVlZiV2U0UkVjOW1lZ1JP?=
 =?utf-8?B?OEJwZk14cUphQXFnTWFiVW1MRnZVUVFDTjdqVit6c1FZWVBqaU9oNTJRUUFo?=
 =?utf-8?B?aEJmc2pHR1d1NkVxM29kZTNUY3ptblFZK3RTZjRDcWV6MEI3d0VTSFp6R1dQ?=
 =?utf-8?B?b0x1eVU2eXVoU2g1djBBTkRZZHErTE50NGFqcVJZUmIyM0dpdzU4N2xoYVlI?=
 =?utf-8?B?SFdyZjJ5QUd1V1Ayb1Q4WGU3Ym1PSDNFMHhnaUE5ZHM5ZGRaTDZyanRTMUMv?=
 =?utf-8?B?Y3B4YW93MjdiREx3Q0lYNlBCMndkN0VQT3hJQUJTTFMzLzdIa2hEdmpTR1Rt?=
 =?utf-8?B?VVczdEdrS1djc2g1b3dOeE9XN1NKWXczeDR4S1FGcStyNnRKOTJrVG85TWhE?=
 =?utf-8?B?bFVwYTE3QThJWHVEWXUxR0Q5dHo4bkQ3WDd0Y3JlcktaL3BMTGIzMWpuTTRK?=
 =?utf-8?B?TzZPYjRHTmt1UXRRYjA1SlE2VTg5czJCTVBqWER4aWF4YktYb3loU0NTOW9x?=
 =?utf-8?B?T0IxZ1NHWEZ6enFHK08xM092NnpqRW5EbitCSndvSWYzdzUxYjdqRUxXRXZ1?=
 =?utf-8?B?VlFvTlg0WFJQdkVINzNJOUl6aW1QTjBhN0l4eVNJM3JLTE9UbWFxdml5eFh1?=
 =?utf-8?B?OGNPKzN6cWU4SzhjMmhDRzRES0xyQWVoY2pFRmxVUVg1STNybXhubnRpZTBM?=
 =?utf-8?B?YUo4SFpKU3N5UVBUK3hTTVgyZVBUdDFxZm1UamZScWhBTkp6RXlJOTkyQW1P?=
 =?utf-8?B?NDNLZmRpdUdZbWdLWFFmTldLVERHUTY5RE5wcWNNejFpV2F0am1QUFdUV3R5?=
 =?utf-8?B?L2NncXNYdUM4N2gweUgxcWt3ZG91MnRCOU1ISGlsQTA3MnFjT0pVRU8xaHBU?=
 =?utf-8?B?bGZyK21MVm82bHl4bi8zZlQ3cktSM2R6VFU0RHRHWHE5aHJNR2lIczZ4OWt3?=
 =?utf-8?B?ZEdoRDlyaWJSdTdjVDkzZUxmQnZQUVVyYXJyRXA2VVgrelc5cFVVVE41c3M5?=
 =?utf-8?B?QVY1aDEwK01ld2ZsdTRPdEl4Y2xmMTRVS0hlY3dtRXhoS0gzTDc2ZHBZZ0o1?=
 =?utf-8?B?NmxwU2ZKZWJWQ2xkdGhUdz09?=
Content-ID: <B6DA11342C3DAB40A6BFE4737DCF0D83@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb5c6d9-8f2d-4deb-7ca7-08d8d8307113
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 19:23:03.8308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2jOhEZHFoQyb9DHrVGlhh+6lOMlhiD+9KjnOQHPBDxbXwJRzwPwiU/nDlGCkbGDT6tra0VvSwKO+7AZ7wugmNG41VUX0qq77Ku84UHHbEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3559
X-OriginatorOrg: intel.com
Message-ID-Hash: KUTTQWVYUMLEUGKAZSY4RYZMZ4Y7UC3L
X-Message-ID-Hash: KUTTQWVYUMLEUGKAZSY4RYZMZ4Y7UC3L
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KUTTQWVYUMLEUGKAZSY4RYZMZ4Y7UC3L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2021-02-22 at 13:36 -0800, Ben Widawsky wrote:
[..]
> 
> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'cxl list' [<options>]
> > +
> > +Walk the CXL capable device hierarchy in the system and list all device
> > +instances along with some of their major attributes.
> 
> This doesn't seem to match the above. Here it's just devices and above you talk
> about bridges and switches as well.

Good catch - those can be added in later when we have a sysfs
representation for them. I'll change it to say just devices for now.

[..]
> > +
> > +static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
> > +{
> > +	const char *devname = devpath_to_devname(cxlmem_base);
> > +	char *path = calloc(1, strlen(cxlmem_base) + 100);
> > +	struct cxl_ctx *ctx = parent;
> > +	struct cxl_memdev *memdev, *memdev_dup;
> > +	char buf[SYSFS_ATTR_SIZE];
> > +	struct stat st;
> > +
> > +	if (!path)
> > +		return NULL;
> > +	dbg(ctx, "%s: base: \'%s\'\n", __func__, cxlmem_base);
> > +
> > +	memdev = calloc(1, sizeof(*memdev));
> > +	if (!memdev)
> > +		goto err_dev;
> > +	memdev->id = id;
> > +	memdev->ctx = ctx;
> > +
> > +	sprintf(path, "/dev/cxl/%s", devname);
> > +	if (stat(path, &st) < 0)
> > +		goto err_read;
> > +	memdev->major = major(st.st_rdev);
> > +	memdev->minor = minor(st.st_rdev);
> > +
> > +	sprintf(path, "%s/pmem/size", cxlmem_base);
> > +	if (sysfs_read_attr(ctx, path, buf) < 0)
> > +		goto err_read;
> > +	memdev->pmem_size = strtoull(buf, NULL, 0);
> 
> For strtoull usage and below - it certainly doesn't matter much but maybe using
> 10 for base would better since sysfs is ABI and therefore anything other than
> base 10 is incorrect.

Hm, I followed what libndctl does, but I think there is value in
accepting valid hex even if it is technically 'wrong' per the robustness
principle. How much do we want libcxl/libndctl to be a kernel validation
vehicle vs. just work if you can?

[..]
> > +
> > +static int cmd_help(int argc, const char **argv, struct cxl_ctx *ctx)
> > +{
> > +	const char * const builtin_help_subcommands[] = {
> > +		"list", NULL,
> > +	};
> 
> Move NULL to newline.

Yep.

> 
> > +int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
> > +{
> > +	const struct option options[] = {
> > +		OPT_STRING('d', "memdev", &param.memdev, "memory device name",
> > +			   "filter by CXL memory device name"),
> > +		OPT_BOOLEAN('D', "memdevs", &list.memdevs,
> > +			    "include CXL memory device info"),
> > +		OPT_BOOLEAN('i', "idle", &list.idle, "include idle devices"),
> > +		OPT_BOOLEAN('u', "human", &list.human,
> > +				"use human friendly number formats "),
> > +		OPT_END(),
> > +	};
> > +	const char * const u[] = {
> > +		"cxl list [<options>]",
> > +		NULL
> > +	};
> > +	struct json_object *jdevs = NULL;
> > +	unsigned long list_flags;
> > +	struct cxl_memdev *memdev;
> > +	int i;
> > +
> > +        argc = parse_options(argc, argv, options, u, 0);
> 
> Tab.
> 
> /me looks for .clang-format

Thanks - let me see if I can quickly adapt the kernel's .clang-format
for this and add it in for the next revision.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
