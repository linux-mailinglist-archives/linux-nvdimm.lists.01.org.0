Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 196822B8600
	for <lists+linux-nvdimm@lfdr.de>; Wed, 18 Nov 2020 21:51:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0DA5E100EBB63;
	Wed, 18 Nov 2020 12:51:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F3B49100EBBA9
	for <linux-nvdimm@lists.01.org>; Wed, 18 Nov 2020 12:51:11 -0800 (PST)
IronPort-SDR: y0weTpevhEzfNNEOXGnTgHz14fl8BWrze5Dz+1c8c1yeVv0jeJoROhF1TpUOXcklOGAQneD4X7
 IBtRwkYxQkGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="235331737"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400";
   d="scan'208";a="235331737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 12:51:11 -0800
IronPort-SDR: t31WqSJCAE+4iJtnLgiQqArgVkVkVv+X7f/VBiW5vSqLU3Z9vEf2ucSTjKh29uQVTU7kM7Nu9f
 lEJKLp0QiwwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400";
   d="scan'208";a="357134162"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 18 Nov 2020 12:51:11 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Nov 2020 12:51:10 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Nov 2020 12:51:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Nov 2020 12:51:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 18 Nov 2020 12:51:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCdoGSMe77kVfqaNmDKRuRW+FcOJo3jWkBrKvnJoRPtH0FR5QTshtnTn7pcs/cApE5Ap/RJnepAAhhVQZ4g6f2aWRHTGHcQnrV7ZrR7mO6gm3FH2+7Ht03BerJgznMeTfu+pJmwEEFwy9L0pZ7FOHJfuCIc645CBeHrmBAtRQy1xMWeTJsyMl4PbkQPq2R/RkgF6C4yjQ/1z8eSPOsci9Dh33qEkcDn520TU//FRGUbXUK0857pYzwDV0alcytWuP/aD/16WXk34oel5v6RGbC19+JYx447vcn+og7hW+uZQ5XNEJKkzwRy2+htnkM20Mm8tuvfAh1d45e1G4KfBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMW2+h0PYdGeiUSmN2tc9ThEOI4PXwsPIXfUMtbp7vo=;
 b=PeCqZ0AxsGIcYT2Mr4DKw0Nzi0GUDFCS6Y/oez7BNfsCVJV6HMRyZEKg85Q56pLhdjS2aAnNG2QdJ7kvk7hGR6SZjK1kG6T103TNhEBg4le4Z4NL/x+V3j4TDCUYojZCf1/QsPJJghqqkCS0ZwCZar4LPMi8AKBgDZLvHpvNv1I4Mhi9U2fXpjvVwKOTgX+7+xshRpDUkYhClUu/Rvyz8YeLy0kgSGJb0ysUpOX7B7iXSlBCcnpXWBa9Q7D0IlTfjPkt46u/41PMG++M9Fd9zXJ3/QULFbqMLKVhTStdiWbceBtxw/qM/tADA3NSg1vF7GV2TAs6SGzwzpVC5BhhSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMW2+h0PYdGeiUSmN2tc9ThEOI4PXwsPIXfUMtbp7vo=;
 b=kE7aP1Ic9uP75oEzoMzidahr7OGD9Rt0eE9dPUhYZ4sBqxqT4qT1fy/NrGxNC+L4cQybUOQexsbKZNGl/mnBrWF3C2aHeDvBjHugLRjapHCUl4sZzbNVO3GRZ2BpjIeAENAJl4GmNRC5fc+BWfXjZYPyz7P3qUUTXVxrcYjreGg=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2600.namprd11.prod.outlook.com (2603:10b6:a02:c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 18 Nov
 2020 20:50:56 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::14fe:76f0:df82:d27f]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::14fe:76f0:df82:d27f%5]) with mapi id 15.20.3541.028; Wed, 18 Nov 2020
 20:50:56 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Jiang, Dave"
	<dave.jiang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Weiny, Ira"
	<ira.weiny@intel.com>
Subject: Re: [PATCH 1/1] ACPI/nfit: correct the badrange to be reported in
 nfit_handle_mce()
Thread-Topic: [PATCH 1/1] ACPI/nfit: correct the badrange to be reported in
 nfit_handle_mce()
Thread-Index: AQHWvYbd1sFNhx/+hEK7jO8zPT9wiqnOXfaA
Date: Wed, 18 Nov 2020 20:50:56 +0000
Message-ID: <1fa493113c74a0618d34f0e5d88e4402abe3e69c.camel@intel.com>
References: <20201118084117.1937-1-thunder.leizhen@huawei.com>
In-Reply-To: <20201118084117.1937-1-thunder.leizhen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84c7f04e-7f21-459f-f7c0-08d88c03a5b2
x-ms-traffictypediagnostic: BYAPR11MB2600:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB26009D6297151C43EA6AE80BC7E10@BYAPR11MB2600.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /IULRRuha3XlAJCYmlMJ8NgkCfOtwT2TSO3g0YUmOTbl8ohSuXthHt91U3MS7yt5Le8UFNZzQYcb5sSwxJAkIquGpDrE0GDkCeT6+ZHFax1dXeAv5xw1G3CSz+MPXZTTm8P7opWCQJrTKjWyqx8h/mfSEMDCR85gwlYR9j0icB9mrbvGkdyjUQPQPRTRAL691mM0nH5Hdpo9d2tckkMTzcDzEoAmyFYhCuutgmWGz2xMTp72pQ0UMpng4cHFYqiyMfuSIu3Q1LIwire5UJYCzrCV7t9AuuOgHHqqmIia7AXH/DgzAFmC0bFHKyFYvxEiMrrSl3HpJWRbWgvXEZBvdYCxkRzO/qzCKRs/zHKG4o8Foga0kMMpDdhMYvK7oOSh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(2616005)(110136005)(6506007)(8936002)(83380400001)(91956017)(66446008)(76116006)(921005)(8676002)(66556008)(64756008)(316002)(66946007)(186003)(26005)(66476007)(6636002)(36756003)(478600001)(71200400001)(4001150100001)(5660300002)(6486002)(6512007)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: m6S0d4PJPhS+ZvoMDdn0/ORAbOdeJ2RvfiZFfWvOglu0RTDAeFnLatps2i6l1EC5CpN9Jt1xZTl6mqHGbTpk0dsWJlXlWHhk5qviJqkjppL3J0CUEbFvTJHFhCXadOTpFDe9bS3piRifxIfwUYAi1FgWJFEX7wy+91+9zg4I2mbnABqMoE08qWSdtuEwTnsRaouEVJCJQvbtwXzdkJsgkgW8INPX+AmxUONe8sgl/h0X/O8MM8/rN1WqaaaXzHoH7rq3YW1PhRNf1gfj9AVEWwr+gkKm5OoKoeLJBdHuHYggXVBAf9s2HG4POpwzlx2b+wMoHxN36iQ3YfiYUTYUvlEUtSKlm8eUPYDWA2GGqRJGu34OgFV0kvAwK8a5gHK0j+t0ldWe4lhilJzZs/so8rN9e4Zl1VNFn3rApTQc0Sj12ExTNForwU1K1LdtnjKPas5SBknmLTZUK3gIeorr6siTJokgSQhbTLzaICMVRbfuBQPzzh8Z+Wn+5rPdnq7L4UVEyu94qQx0qe3YNBgl9xe2hbPfQz6SjYVyZnp1pPu/3gl/ecKNXYw65aWr5NVcdYaUb9GdxaHAlV9i1Rixzzp7pgCQuWEA1y6RnxLBYtDGlYJCYuAf1WnMadgnfuZEMSGN8+ZLUuk1FHC01QW2SXrevh2XJpJoQsOKrh9HRIuz6nUMelBOuscSLAPP4Ronu3NghJh4P53tl0J7gqfc1e30iFPw1B9NeGQLIQOhuOg+OvRHN30YinvgmhkTExlihLM6iUEzRTVr81tdEEUrDOhl56SRuGNigXG7+i2ftDVAaZSzD2OnNpm8ckINrliJG36ZrUQmGnRkbMLHhY2WplfScZrJLPQ9Cq3ZzYBhI+0B+XBZWFx7jWdduEfBKWHY70w8A56VUXJBhhYBDpWB0Q==
Content-ID: <27B58195C8872C43A6EBAE60E5304B73@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c7f04e-7f21-459f-f7c0-08d88c03a5b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 20:50:56.4515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PU10IzInSHmRJjkaXOCKl0TQZ4PHAZSEL41PFTZZGFchJ4uduvXSm5nyaSyPEydLwH7DN6XZjBKkYDjsmtC9xyWnPTu5SQ1NZt/4juqNpP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2600
X-OriginatorOrg: intel.com
Message-ID-Hash: NZ3LTBDXY6K3ZBMX5CDNLPENRQ6BBP6E
X-Message-ID-Hash: NZ3LTBDXY6K3ZBMX5CDNLPENRQ6BBP6E
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NZ3LTBDXY6K3ZBMX5CDNLPENRQ6BBP6E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-11-18 at 16:41 +0800, Zhen Lei wrote:
> The badrange to be reported should always cover mce->addr.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/acpi/nfit/mce.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ah good find, agreed with Dan that this is stable material.
Minor nit, I'd recommend rewording the subject line to something like:

"acpi/nfit: fix badrange insertion in nfit_handle_mce()"

Otherwise, looks good to me.
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

> 
> diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
> index ee8d9973f60b..053e719c7bea 100644
> --- a/drivers/acpi/nfit/mce.c
> +++ b/drivers/acpi/nfit/mce.c
> @@ -63,7 +63,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
>  
>  		/* If this fails due to an -ENOMEM, there is little we can do */
>  		nvdimm_bus_add_badrange(acpi_desc->nvdimm_bus,
> -				ALIGN(mce->addr, L1_CACHE_BYTES),
> +				ALIGN_DOWN(mce->addr, L1_CACHE_BYTES),
>  				L1_CACHE_BYTES);
>  		nvdimm_region_notify(nfit_spa->nd_region,
>  				NVDIMM_REVALIDATE_POISON);

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
