Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68C337FD24
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 May 2021 20:17:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29E7C100EBB96;
	Thu, 13 May 2021 11:17:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 08F3A100ED48C
	for <linux-nvdimm@lists.01.org>; Thu, 13 May 2021 11:17:37 -0700 (PDT)
IronPort-SDR: sxbTs0hIK3BjnHdTNRLG/yNpUnKP+iLolWbe51UdHdN6Ky94TXI+8NA4LzfW6t5ZqbB6dOYrkJ
 akaxw9Og14Gw==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="285525121"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400";
   d="scan'208";a="285525121"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 11:17:35 -0700
IronPort-SDR: GUp1V+zqdNtgOH5oolzGCT0rH+K7TXxHO9xMRxisU9/wcCd1B4aO1GSonYqFwex/E6KXC/K9iL
 GMHTryN1AXfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400";
   d="scan'208";a="542580890"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2021 11:17:35 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 13 May 2021 11:17:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 13 May 2021 11:17:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 13 May 2021 11:17:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0MeSCkaeEdydvbD8+FOt6BzBrfysQGk0zD+ElEc9QvyG9vfVqBaOL/CiWV7E+yJXCyUeE84v3w8cMniAeEU48IssxHM1097R9sPISFYcc6VZhFZObqYSBfV8EPBelMdrYYpL7qeFF0D212GMSRSI73lAFvaAS6gRFyR+d5dMtPJXtd3BMHTHsmk57wjsj460ofao6HXGkEnApfvvg0EQn/32r/GzGn5sLtwWxrpLXKsfmkDlnWnt2cTINEQQV7ZTZ9OxTrmba4lB/UIV6I3bZNRXZo9e0HaC7I/EQG74eMK3uAPcRZSZyR1IhTS6majeooqxlupC4V++a4plTT/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/KovrwIjshyRJZ8imDTMfHqLDfnMGw8dDD98rfIqqw=;
 b=R8cgWFTRXJxkthOP2VFhvEnFi8mnNc1CcyiVtjxbrfzGnAP4c0rjU3w2JQvsK99QWxikJ4SFuAU9t2nAkP2JFjOQ7kbNga4ada2OapcgASQKBUWrdW7e17x/1/fCyoTFWyBvkCUDGL2ln1a2kKHX/qCRKK1ynCnuYMeZKQ6ETLY+2UbdsHoItLBhKguPJKoRFJOqxdDl1LHZ8436NE0TKSKiXXwlLdL9WV4vtPk/5nbvNlkLBTZYp4wCYNGecSI4MK/dR/rhn0+aKL8OdFeatKuDxIMNapqVQsCuyzNXmVFzBC6aR2kr8HBTg7eEX+SXVKKgeizHR4QQGGdG5NsZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/KovrwIjshyRJZ8imDTMfHqLDfnMGw8dDD98rfIqqw=;
 b=EtqoCZNYwgs04lsy3lxRuv37UXJ+HqZJl0MNQ/1hzRRd4DJs058Zr3T34Qo6UxYrokWk88fMyLHedy5iTdde86CypXRgqJi3V+W5oObdsJHDDVe1IadRo5hkdYWvWndJ3RHHBJn2ajdvIfC5smNxej142y3jMmDOmNVwMSovWa0=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2807.namprd11.prod.outlook.com (2603:10b6:a02:c3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Thu, 13 May
 2021 18:17:31 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc%5]) with mapi id 15.20.4108.034; Thu, 13 May 2021
 18:17:31 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"santosh@fossix.org" <santosh@fossix.org>
Subject: Re: [ndctl V5 4/4] Use page size as alignment value
Thread-Topic: [ndctl V5 4/4] Use page size as alignment value
Thread-Index: AQHXR78dliwb0fNPv0qbbfUYRWQK7qrhuPoA
Date: Thu, 13 May 2021 18:17:31 +0000
Message-ID: <27307f1aceeda53154b9985f065fdada71cf1fd4.camel@intel.com>
References: <20210513061218.760322-1-santosh@fossix.org>
	 <20210513061218.760322-4-santosh@fossix.org>
In-Reply-To: <20210513061218.760322-4-santosh@fossix.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.1 (3.40.1-1.fc34) 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f02f8ea9-6d10-4b41-7dc8-08d9163b5fae
x-ms-traffictypediagnostic: BYAPR11MB2807:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2807C8D931C49B9331EA41DFC7519@BYAPR11MB2807.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ECi48rRP6BQBrTKZSWyaCb3gK4WPDKXpeKl0a5tcpLBy3qbZwoDbcOvEnfih3Lj5BuSjGY8RkU8+tX5qG4YCcL+O6UsCpmJAlmCe7DdkGYWsOUKylrOy7vgI+TW5ronZ9Vlipm2YZp7Z+KVhm1KZEVj1BEsOeiSHDJPCLYgXDYPMvpKpA1VrNsWMwQCW6iQjejMZBfiG2M4mzFo3ACCaFNxdwt9NbFQqoypURj99CmEImnNU1/0SvqIq2lNPt8WPT/nU131dil5igWPAnCfqtpWkUz60hJzQgwd0JUduNq+r8kjsOBa71Mm3mXhtBr6/OBN5LzJOvyjF8bc6b7I9F7qGamZJhFR1hw1qlLmf/FY2sJ59uFNm630CHEzis9cwz3SkjUl1BLENJt3nca/eCaf7qBEc56jxFV6bJyhWp5RYM1D5nMiCmd+R2qMclvv/4MRmH7RLfTol0T0hXU1nU/zpWSK112RkCHKz1LoOqWgdkvC42Q1POsJpaXtMYqfc3wtPEIt5ENm7IxRoAS99kNrigHNDkCtZOkezv4GGbyxy3LQpFCvviqsmYmIt3Gh4XBlc3DEzCpU2C8Rrd9bQVpZYk2+K6uaWgQzIKkaxDc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(66476007)(66556008)(76116006)(4326008)(2906002)(498600001)(66446008)(38100700002)(8676002)(6486002)(110136005)(122000001)(26005)(186003)(71200400001)(2616005)(5660300002)(86362001)(6512007)(8936002)(36756003)(66946007)(6506007)(83380400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UmtBcHhuQlU2TktBUzUyeFVjMVQyZW8vQ2U2SGZGWWlvSVZnQ1JLUytpa1dR?=
 =?utf-8?B?OFRaWXdSQnJzVDVneEJ2SlF1WDY1OVJjeXlKZGZ6UGpyK3NLRzNRczBObHlZ?=
 =?utf-8?B?c2lESU5CZmlobGdsdUFONmoyVUNtaEprcGxLVklJMXhyb2hPbnhvNEtXV1Y2?=
 =?utf-8?B?NFBpTXFjV0RxN2E5MjhQYTdiZEphQkdtbE81ZndDalNJUU1jK3planp0VUVt?=
 =?utf-8?B?KzFtK1RxTmQrLzI1SVRFYVpwTGtDYVVVMHlneXFmNmRxdjZoQ042Rjh3SGpi?=
 =?utf-8?B?U3Y4eFhwSzh3bnNtSkJad2l1bXhNTjQ1cytxc3hiQzV5NThTKzdkbkI2ekJv?=
 =?utf-8?B?bDIvMEhac204SThRTkFEL3JMRjBsbWIzRnZ1TmdYS2Q1WldQTE1haEJkOENV?=
 =?utf-8?B?TlFOcHpVT3gvdWN0U2h2R0NhWFo0RHBJU0MrMTVQWkE3Z3dIbmpRUnhkT3Y2?=
 =?utf-8?B?RVJJNTlmZ1lwVndQbDVqb3B6RXVIdlV1VWhSMTdSODNEUnRRUzBwdVFXSmxS?=
 =?utf-8?B?a3hvK2R4T2NraWlMbllLTWhMb2tjSDd5bDkwaFdNcWJTejg3U0tMbGNiY0NT?=
 =?utf-8?B?MCsvOHRaWXM5MCtIb2dITmhKZWg3emViZ3QyUzlRSk82eWNVU3hoOE5mU2Zh?=
 =?utf-8?B?aS9GYnp1a3ZoeUNzRkxWbEQ1RlNPc0JKMVVHY1VLSXhKZEZucldsQnJZWFNn?=
 =?utf-8?B?bzhOems0MmFyaXdEQmlDSGFJYzhoZVp0NFkyemtrNkZ3ZHl6a29zc0dyODI0?=
 =?utf-8?B?NEVLM1h0KzNpMHg2Zi9ZbzByS01VTkhLOXJKeVVPYTlQOFVZblBBY3U5YlZm?=
 =?utf-8?B?SVY0WThsTWkwcmdrTHBzendqNTVNVXNhdTcyblErZWs3NGwyd2hGQ1JCb2FT?=
 =?utf-8?B?UjdCRzMrdm14bStOVFlPT2cvVm5hRW9YLzNQRkFYQ3Jwd0xaSE1XUmhmM25I?=
 =?utf-8?B?aSs4eDNMbHBYSlpoSDVUWjNDYVVyNGZ5bFJCRnlwdXRnWGpGV1FDYlBKWlJu?=
 =?utf-8?B?YXhteDN1YkFiSlpvZWE1djQ0bzFMeUN0Zmczc0xnV2locis0eitWL1Fac0J0?=
 =?utf-8?B?ZGZpY29HL0thMEdCV2RUWTRKSWpxQmR6TGJ4b3FJeEtJUjNUVTFvY2JZYzg2?=
 =?utf-8?B?eGp2Y1JCMDhka2I2YXBxZ0tWVnBnUUY0TmV1b3l5Y3Q4cmgzRkxSQlRFc2hG?=
 =?utf-8?B?ZndPWmpRMWp4SklFSnQrNTRWdzJKVFEzWjRlU1laeVBZU29CaUpkYUJyZTRl?=
 =?utf-8?B?OG1FUlZBWnFRQ1B4Sml5V21BdzdMYnFKUUJnZjljU0d4U3h0YTNieEFEOEFM?=
 =?utf-8?B?UlM5LzdHLzJHTzFYNDJyMWRwanU5TjVuVW5EdFhyQTQ2b29vQ0FhU2ozWWxB?=
 =?utf-8?B?U1pCMDhaRXZKa3Q2MWppbDJSZ2t2eVhwbzBrYzRHRVZoSThtalpBUGVFVlE3?=
 =?utf-8?B?VDB5WE02d2VOb09xRGRiTG0rT3dPVmRWSEJ4RWlTTUllZ29meElBZEowMkpM?=
 =?utf-8?B?VEZMWU5Lb1J2S3pkTHFyV2NTRUh6Y3EremI3a3VCYW90ekJwMkRkdEJXNkNt?=
 =?utf-8?B?VjB1cEdCRUNsWjBVY0YwSHpLYThkRmQwZEtrQ0liQ3FPZWV6T3hzSWh1ckpn?=
 =?utf-8?B?UVd3dXd4aTVuL0k5cUxaSnMwU1lBUUZEZDVIc3o1QW0xRXdBVGtyc25UYzBj?=
 =?utf-8?B?OWthUVVxMWRZTERHRUNQRFR6alI0b2V0eC9RNlhEUWttMTV3Z3lCbWZwWVlJ?=
 =?utf-8?Q?nCuBbscKpNCTZv3GgYp5sLnsk9eTIAXkLHcVbQh?=
Content-ID: <1358B6E69FA69846BDBB57815E1C1617@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02f8ea9-6d10-4b41-7dc8-08d9163b5fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 18:17:31.2389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytdpPxHQr0y7KeDuDOaaBRQ0PerikhrpzHGf6p6xjNVNLX8eWUBLZekkSdEVhZpW36h4P0ZCVUjIpGkRqIbwhcafvQpwCm5qDN9LXzGU6jI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2807
X-OriginatorOrg: intel.com
Message-ID-Hash: RJYK6PYQUTVZTGUVMEYLTAXFCRLAKDCJ
X-Message-ID-Hash: RJYK6PYQUTVZTGUVMEYLTAXFCRLAKDCJ
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "sbhat@linux.ibm.com" <sbhat@linux.ibm.com>, "harish@linux.ibm.com" <harish@linux.ibm.com>, "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RJYK6PYQUTVZTGUVMEYLTAXFCRLAKDCJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2021-05-13 at 11:42 +0530, Santosh Sivaraj wrote:
> The alignment sizes passed to ndctl in the tests are all hardcoded to 4k,
> the default page size on x86. Change those to the default page size on that
> architecture (sysconf/getconf). No functional changes otherwise.
> 
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  test/dpa-alloc.c    | 15 ++++++++-------
>  test/multi-dax.sh   |  6 ++++--
>  test/sector-mode.sh |  4 +++-
>  3 files changed, 15 insertions(+), 10 deletions(-)

Thanks for the updates, these look good - I've applied them and pushed
out on 'pending'.

> 
> diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
> index 0b3bb7a..59185cf 100644
> --- a/test/dpa-alloc.c
> +++ b/test/dpa-alloc.c
> @@ -38,12 +38,13 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>  	struct ndctl_region *region, *blk_region = NULL;
>  	struct ndctl_namespace *ndns;
>  	struct ndctl_dimm *dimm;
> -	unsigned long size;
> +	unsigned long size, page_size;
>  	struct ndctl_bus *bus;
>  	char uuid_str[40];
>  	int round;
>  	int rc;
>  
> +	page_size = sysconf(_SC_PAGESIZE);
>  	/* disable nfit_test.1, not used in this test */
>  	bus = ndctl_bus_get_by_provider(ctx, NFIT_PROVIDER1);
>  	if (!bus)
> @@ -124,11 +125,11 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>  			return rc;
>  		}
>  		ndctl_namespace_disable_invalidate(ndns);
> -		rc = ndctl_namespace_set_size(ndns, SZ_4K);
> +		rc = ndctl_namespace_set_size(ndns, page_size);
>  		if (rc) {
> -			fprintf(stderr, "failed to init %s to size: %d\n",
> +			fprintf(stderr, "failed to init %s to size: %lu\n",
>  					ndctl_namespace_get_devname(ndns),
> -					SZ_4K);
> +					page_size);
>  			return rc;
>  		}
>  		namespaces[i].ndns = ndns;
> @@ -150,7 +151,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>  		ndns = namespaces[i % ARRAY_SIZE(namespaces)].ndns;
>  		if (i % ARRAY_SIZE(namespaces) == 0)
>  			round++;
> -		size = SZ_4K * round;
> +		size = page_size * round;
>  		rc = ndctl_namespace_set_size(ndns, size);
>  		if (rc) {
>  			fprintf(stderr, "%s: set_size: %lx failed: %d\n",
> @@ -166,7 +167,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>  	i--;
>  	round++;
>  	ndns = namespaces[i % ARRAY_SIZE(namespaces)].ndns;
> -	size = SZ_4K * round;
> +	size = page_size * round;
>  	rc = ndctl_namespace_set_size(ndns, size);
>  	if (rc) {
>  		fprintf(stderr, "%s failed to update while labels full\n",
> @@ -175,7 +176,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
>  	}
>  
>  	round--;
> -	size = SZ_4K * round;
> +	size = page_size * round;
>  	rc = ndctl_namespace_set_size(ndns, size);
>  	if (rc) {
>  		fprintf(stderr, "%s failed to reduce size while labels full\n",
> diff --git a/test/multi-dax.sh b/test/multi-dax.sh
> index e932569..9451ed0 100755
> --- a/test/multi-dax.sh
> +++ b/test/multi-dax.sh
> @@ -12,6 +12,8 @@ check_min_kver "4.13" || do_skip "may lack multi-dax support"
>  
>  trap 'err $LINENO' ERR
>  
> +ALIGN_SIZE=`getconf PAGESIZE`
> +
>  # setup (reset nfit_test dimms)
>  modprobe nfit_test
>  $NDCTL disable-region -b $NFIT_TEST_BUS0 all
> @@ -22,9 +24,9 @@ rc=1
>  query=". | sort_by(.available_size) | reverse | .[0].dev"
>  region=$($NDCTL list -b $NFIT_TEST_BUS0 -t pmem -Ri | jq -r "$query")
>  
> -json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -r $region -t pmem -m devdax -a 4096 -s 16M)
> +json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -r $region -t pmem -m devdax -a $ALIGN_SIZE -s 16M)
>  chardev1=$(echo $json | jq ". | select(.mode == \"devdax\") | .daxregion.devices[0].chardev")
> -json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -r $region -t pmem -m devdax -a 4096 -s 16M)
> +json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -r $region -t pmem -m devdax -a $ALIGN_SIZE -s 16M)
>  chardev2=$(echo $json | jq ". | select(.mode == \"devdax\") | .daxregion.devices[0].chardev")
>  
>  _cleanup
> diff --git a/test/sector-mode.sh b/test/sector-mode.sh
> index dd7013e..d03c0ca 100755
> --- a/test/sector-mode.sh
> +++ b/test/sector-mode.sh
> @@ -9,6 +9,8 @@ rc=77
>  set -e
>  trap 'err $LINENO' ERR
>  
> +ALIGN_SIZE=`getconf PAGESIZE`
> +
>  # setup (reset nfit_test dimms)
>  modprobe nfit_test
>  $NDCTL disable-region -b $NFIT_TEST_BUS0 all
> @@ -25,7 +27,7 @@ NAMESPACE=$($NDCTL list -b $NFIT_TEST_BUS1 -N | jq -r "$query")
>  REGION=$($NDCTL list -R --namespace=$NAMESPACE | jq -r "(.[]) | .dev")
>  echo 0 > /sys/bus/nd/devices/$REGION/read_only
>  $NDCTL create-namespace --no-autolabel -e $NAMESPACE -m sector -f -l 4K
> -$NDCTL create-namespace --no-autolabel -e $NAMESPACE -m dax -f -a 4K
> +$NDCTL create-namespace --no-autolabel -e $NAMESPACE -m dax -f -a $ALIGN_SIZE
>  $NDCTL create-namespace --no-autolabel -e $NAMESPACE -m sector -f -l 4K
>  
>  _cleanup

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
