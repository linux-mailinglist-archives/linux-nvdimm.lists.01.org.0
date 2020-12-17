Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD92DCB50
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 04:33:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6E27E100EBB97;
	Wed, 16 Dec 2020 19:33:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 11CE7100EBB95
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 19:33:18 -0800 (PST)
IronPort-SDR: JyG3eGGIF0LQHregoDL/mo8u0Fs2MM3NkXG1SWzkkzVzzSj8iEbWFMwnyYzxi+Bgr/B8IS46VH
 Jo4bskkPkKkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="162925936"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400";
   d="scan'208";a="162925936"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 19:33:18 -0800
IronPort-SDR: qoLbhtS+6RnOW6H/tGygkHXhfByyrsCV4PErc7GEGriJc9ck15uYaOCQmt4OZkA/eyS7pyhMEy
 TlCrfJHv/Spw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400";
   d="scan'208";a="342347945"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2020 19:33:18 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Dec 2020 19:33:16 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 16 Dec 2020 19:33:16 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 16 Dec 2020 19:33:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsx7YNykt5bLSXYjaTNVERkAaTwECqmBme9/mJFkonhGv+vkTGnOmXYrdUJuYvQhGDzo3uEK7R1Fon+5pbn9YJ6LVkOpTDc7z3AOEOvPoGYyud7gINbgBxvucDlb2UOHwcqdzeDbTzJwMoZAT4kYZ3FznvK/PzkO6PlAJcLKYnQafw2XfJhZjvPiPnjwcxdcHgjwyCIG5vei3c7IL2jSNqXplQboXp3yw+wg6KUA/8QJrsjQkb4xW9+Q8qYcOZzZECDUAiu0wv/b0kq2vI9jOE2o4mFIkzQ75wRDZumxMOZX98kUmSxXC7+00clm1mppzuEsA2NAHzC/jSj9Sh8tlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXgTNoVM72TX6Nbpzd0ihwNS/k1CgQNbyMdF6w24ezU=;
 b=eeyii1qlDQ0+w5t5kdYLkUj9mbWeTr1EikHDiHzq/8664Kms5ytiuR4xwx/iIr/WUzLKUTWDAA1w6yeznmZfSRZphGgCLzmpOhlyaEJsFrU+szK9hQzUa1tZuGG1dG9AksHmU+0FMBj8TSLqnycNVFtalUarUsgdbbag4h2MrkU6UdKP8NBsFHxOX2ULfJW3BKHxlcm6OBF+jknM45RXxr70xf//vKa6DF8EkDLyTHPScsyjnAP2lmJxlu+4RcVBByprT7dG3BxjWdrJy05dbh2WqtqOSueXgBVUDD2CbSGaxIdV6zibuXG3SSgOiAgL1M8QhkS+dyBszbYeaiAfFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXgTNoVM72TX6Nbpzd0ihwNS/k1CgQNbyMdF6w24ezU=;
 b=AZyXwQeEbd7Kq2ckyQeokJQw22Ro5sY+dMo6yxw3xd0/xHlOVcVfR/6j7s8Zi6u9bzX3Jp+x0T/sAqnfS616QK4+nAXhc2VnpDAlvNevEfrS4Ellx7LRnDpl5HvRfLjEdrgrQ5Gu+3XlqIqfTq5U6DOJdlg+UguHjgtRd9KDSVk=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by SJ0PR11MB4960.namprd11.prod.outlook.com (2603:10b6:a03:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Thu, 17 Dec
 2020 03:33:15 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae%7]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 03:33:15 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>
Subject: Re: [ndctl PATCH 6/8] lib/inject: check whether cmd is created
 successfully
Thread-Topic: [ndctl PATCH 6/8] lib/inject: check whether cmd is created
 successfully
Thread-Index: AQHWtB8SHR11wa3l8kqQ05m5b3qEf6n64nUA
Date: Thu, 17 Dec 2020 03:33:15 +0000
Message-ID: <a75b781d2d838242930633f9f3c70c67df248849.camel@intel.com>
References: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
	 <8e8a88ee-a792-dc86-0fa7-b2609588fc88@huawei.com>
In-Reply-To: <8e8a88ee-a792-dc86-0fa7-b2609588fc88@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20b9e9bf-7440-4475-d192-08d8a23c7d3d
x-ms-traffictypediagnostic: SJ0PR11MB4960:
x-microsoft-antispam-prvs: <SJ0PR11MB49604FA20187F0146E5A7778C7C40@SJ0PR11MB4960.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:309;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zcXwFrDBAY7ftLZe+rgRAF34Kq46Q67oVOfJOSRk8/gSDmwNB04WkpocjAGYkFx8AvWHGbWhQquzZRMiQny4Lk01cs7z38T8lGZzbMePpabqBfOW2NqX0KOipgGA+KkprnCWf/fpVPl1s2eAB/jRAW6N/gS6lRKBj//wZD4WT+uNAKjCjdtZKaxC2y2C8NNNiuUBLB9oF9yEEdabHYG9LrkxpwV/11dvgRP5mMH9+cGtZIG3iOA1cT8Qy0cWT++OvTN5kQ6QRZIIKTWHM19o9LDCIT2gEbaoxVxB/jsiXo4JgbVKKbWGJDwTGR3W/xw7qW+8pN8c/ogpP57sGTl/xA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(6512007)(83380400001)(64756008)(316002)(26005)(4326008)(2906002)(478600001)(5660300002)(66476007)(71200400001)(66556008)(6486002)(86362001)(54906003)(66446008)(6506007)(8936002)(8676002)(76116006)(186003)(36756003)(6916009)(2616005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SmRGYWN4M3llWklha2QzRnpFYTE3eFlpdzU4MXlHK1o4b1hQajl3YW9tMFU0?=
 =?utf-8?B?Uk9Jb3VWb25lVkUyeTFnOGp1MTA2bDBmSTArR1JBbnd1dUpPajY1eFg3c2V2?=
 =?utf-8?B?bllENlUwV3lRK2xRcFJKa1J0RTVYOWVzcW8yTFFvZ3FsZlRpUVRaaEZlNW5L?=
 =?utf-8?B?R1BGYkpzeGlyY2gxN3VmTzVITEF5L05kRk9sUEV1YzhxNW9FTFU1a3JBMVFv?=
 =?utf-8?B?RUJ3MWdvQzFFWFl5MmMzUTR5UXlrM2pFWElMMCtVRDVzZmVHY0ZpeUJiTjc2?=
 =?utf-8?B?eFNFSzVCR0t3VlcxbE5menBWdTE3aHAzYXNhMklUNU95N3VYeUxQMWdWelBM?=
 =?utf-8?B?bGJUN3pES3hPa0JtU0MyaHhycUpMYzl1M0RxUURJajc5dVFNVTZyaS9RZmll?=
 =?utf-8?B?Ty90aXNsVXFXTU1zY0o0RytPWlU5MmZrSm1KejB1QlF1Qmx5TWlxUzQ4Mm5F?=
 =?utf-8?B?UWtGVHVOZkkwMEt4bkc3aitGYUhUYVdIcEFPUEpTcmpyUVdwQ2tJdFpVVUN1?=
 =?utf-8?B?ejJpTXBsN1VIQ256SlFvZllobk15d3ljVTdtOG5CT1plRUpsTHM4R0M0OFlo?=
 =?utf-8?B?MGtaRWJCT290S2xkN3U2c1c2a2VxbEdiaVltTDBpTERubG1VNzcrVTN4bWVi?=
 =?utf-8?B?YkNzZ1B3dmV6UWlHVTIveHg4aU9BZU9McEI2aXVVK0FPVlR0WUt6U2Jkdml1?=
 =?utf-8?B?cDRGQXBJdGFHTWpGa0NKQjg0eU80S3lNdnhXa3poOU54bEFkdVNjUjdjMGkr?=
 =?utf-8?B?OHZIQ1J2dzJtZnFPK0Jmc0MzSjZVaWRxUHBocWQzNXZKUUd0c2FKcFdoUnRM?=
 =?utf-8?B?NG0vTlBNYXlITCt1bHR4L3RyTDdweHZkS05kQVRhTW9mU3J1L3ZoOTZxM3Fx?=
 =?utf-8?B?UUxpS1NpQVNZeTVBNmtMK1lCc3NEL2cwSVJwSjVSSUhoWGdoQUNvamU3MUdq?=
 =?utf-8?B?YUlLR1RacVRUYkZXd2YzSFEwZWFUNE1kRjMvRzl4WFBZWU40OGR2NXF5QjRX?=
 =?utf-8?B?TUlFMnlHM0xDeWVHcXNMVVRUUHI4aUMwSm5KNmRqNjZMZ21zNmJWa25CNGI1?=
 =?utf-8?B?bVZCNHhRRFMwcjM4aWlzTFZWcWUvL2NZTFdydU5zUC9iUm5ZQ3V3ekNlNU40?=
 =?utf-8?B?SXlxbmZLRVYxTW9pbHlyS2FCVkwrZGpGRDJwZnhraG16a0Zlcyt3MVlMa0hS?=
 =?utf-8?B?NmlOZ0RVS295cFYwVSs2NmQ1K0xxOG1FM3JxR3FnNTFoR1RuTk05aEM5Ukgz?=
 =?utf-8?B?T3M1K0xaS3E1QUxFNFhPOTVOL0VTaERhemtkWkwvS2tHcHV3Qm83NUVsMGUy?=
 =?utf-8?Q?WChWyNwZ2tqcWRjQODlt136gFgqjhUdqjF?=
x-ms-exchange-transport-forked: True
Content-ID: <440982B020EEED4086DC1E77313BE45F@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b9e9bf-7440-4475-d192-08d8a23c7d3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 03:33:15.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24ZPad3fJbZHkXYtCUduvW6JiPURddNHezV+bichq4+xIn+COhe1WwWn5S9TGIFrnQKI7wD3+CqOWQfOtolwqZX3SgnxW3PmvmxfyXYyfQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4960
X-OriginatorOrg: intel.com
Message-ID-Hash: 7HSKQUFEGKCQBZQRJQ63MGVYYIONHGV5
X-Message-ID-Hash: 7HSKQUFEGKCQBZQRJQ63MGVYYIONHGV5
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linfeilong@huawei.com" <linfeilong@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7HSKQUFEGKCQBZQRJQ63MGVYYIONHGV5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2020-11-06 at 17:27 +0800, Zhiqiang Liu wrote:
> ndctl_bus_cmd_new_ars_cp() is called to create cmd,
> which may return NULL. We need to check whether it
> is NULL in callers, such as ndctl_namespace_get_clear_uint
> and ndctl_namespace_injection_status.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  ndctl/lib/inject.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/ndctl/lib/inject.c b/ndctl/lib/inject.c
> index 815f254..b543fc7 100644
> --- a/ndctl/lib/inject.c
> +++ b/ndctl/lib/inject.c
> @@ -114,6 +114,10 @@ static int ndctl_namespace_get_clear_unit(struct ndctl_namespace *ndns)
>  	if (rc)
>  		return rc;
>  	cmd = ndctl_bus_cmd_new_ars_cap(bus, ns_offset, ns_size);
> +	if (!cmd) {
> +		err(ctx, "bus: %s failed to create cmd\n", ndctl_bus_get_provider(bus));
> +		return -ENOTTY;
> +	}
>  	rc = ndctl_cmd_submit(cmd);
>  	if (rc < 0) {
>  		dbg(ctx, "Error submitting ars_cap: %d\n", rc);
> @@ -457,6 +461,10 @@ NDCTL_EXPORT int ndctl_namespace_injection_status(struct ndctl_namespace *ndns)
>  			return rc;
> 
>  		cmd = ndctl_bus_cmd_new_ars_cap(bus, ns_offset, ns_size);
> +		if (!cmd) {
> +			err(ctx, "bus: %s failed to create cmd\n", ndctl_bus_get_provider(bus));
> +			return -ENOTTY;
> +		}
>  		rc = ndctl_cmd_submit(cmd);
>  		if (rc < 0) {
>  			dbg(ctx, "Error submitting ars_cap: %d\n", rc);

This looks good in general, but I made some small fixups while applying.
Printing the bus provider here isn't as useful - I replaced it with
printing the namespace 'devname':

-               err(ctx, "bus: %s failed to create cmd\n", ndctl_bus_get_provider(bus));
+               err(ctx, "%s: failed to create cmd\n",
+                       ndctl_namespace_get_devname(ndns));

Also fixed up a couple of typos in commit messages, but otherwise the
series looks good and I've applied it for v71.

Thanks,
-Vishal
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
