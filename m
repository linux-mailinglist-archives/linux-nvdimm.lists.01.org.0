Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C5F2DCB59
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 04:41:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 155CD100EBB98;
	Wed, 16 Dec 2020 19:41:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 68FD4100EBB97
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 19:41:21 -0800 (PST)
IronPort-SDR: 7x/CTmDTDzTTht+u4AHxqFkzogb9OlXK8z+5NDWiKGzHe5EVxFIlucB/J3ty4//GDFOoDh7AU6
 xHwI2lXpguYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="175325718"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400";
   d="scan'208";a="175325718"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 19:41:20 -0800
IronPort-SDR: AS/B5mS7HuaosifSkoNLfObmO0NKsdMZLxXNj0vPOJI795YTCTwSs5Jo/mLkKXhGQ64gHgvONe
 Vfrq9teuMRqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400";
   d="scan'208";a="557742783"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2020 19:41:20 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Dec 2020 19:41:19 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 16 Dec 2020 19:41:19 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 16 Dec 2020 19:41:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFwKxQ8RZGKVivP+GW3e07+vmv7BixBWp0oPvjoOYq5Lug3TXMHLVP4AeptfscKhapHVwfKrYKrRp54PldqMT1brHkoE3j1509vtu93Pu9pt6AX9qkQDqnhBVtZh5wYtLqys5omP+H1BYR+RoqFPL0NqV/VAENvdA7ct3FQeJ0T24WBOrnNlN6HIG+EJAqlDd0+zU6Zysf3i1tweK8wWf1wt8xClRpJhLROJQ/R9wvYAaraHyC9R3RYrusMyt0gYGKle0J/VdW1u3oY5XAmIECihdsYhZTtVZuLLKI7Mp9IZkH4YqqDPBDiqijuxlbkCK15gDAFl5wY9Rogg0a8qLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANpqlvTRBYpwQRux6kmiFtrYnXoi3c4NRu0REstLKyk=;
 b=TyRdhnskByT9FK7m5YGGr6wF7Ux4SCKE+m++uCDETH2oFGcvwmFptFC0e1fnjCcU7bJO16SQUWV7TWTbEPIwBodpZrVG3URXWE9x/PIFGx4SIISd9KL5PAeaDDKinAqdfXVbuWR55+zbORlQaCEJ15dOSO7o1zMdDRQRwU1hr2pYHjyKXNTlY+S1uBf/4aQSqXa65kcZmfzECtxkeGWUqwSwsU8AuiYmTPEJ70zPpFBBxiTy5HagUvKAGGOPC21Gb+6oYP/bYbfZ9l1fhCLaQRaTbxvj5ecNYrEo7T/MutcPGVd70cruQ2NP34321h3uFVuNiwtpU2AYMzYNtcLSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANpqlvTRBYpwQRux6kmiFtrYnXoi3c4NRu0REstLKyk=;
 b=kz5H2ZApnWgICzXNRoJReJZbeH6yQI/xpB8VpVyskaLwta3TMiFt2eRsNO5nTKxKsSTQ0Oujx2Ur53iNBL2M/SSH5qlET7CWX9/k5Rni75aKiFN7twlwCn/9d/AzW0V1GmatM/+9WrSLsGAjCW08W6oC8DfZWYlAF/Rg9sFGOws=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by SJ0PR11MB4960.namprd11.prod.outlook.com (2603:10b6:a03:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Thu, 17 Dec
 2020 03:41:18 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae%7]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 03:41:18 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>
Subject: Re: [ndctl PATCH V2 0/8] fix serverl issues reported by Coverity
Thread-Topic: [ndctl PATCH V2 0/8] fix serverl issues reported by Coverity
Thread-Index: AQHWwsZ5Cw9Y+IFTEk26JESm1jZb6an6x2cA
Date: Thu, 17 Dec 2020 03:41:18 +0000
Message-ID: <ac83df5da52b505371abeeac1396e92d68fdc2c8.camel@intel.com>
References: <3211fe8a-33fb-37ca-e192-ad1f116f4acd@huawei.com>
In-Reply-To: <3211fe8a-33fb-37ca-e192-ad1f116f4acd@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6594a7e-74ec-4cc1-72de-08d8a23d9d56
x-ms-traffictypediagnostic: SJ0PR11MB4960:
x-microsoft-antispam-prvs: <SJ0PR11MB496033AE5D8B162819D9F94CC7C40@SJ0PR11MB4960.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqWYkxtGOVeICncOEdeSli0esSNKQaT0xTSeYUfTvMd2EpSJMBY+o4vX1RKp44Su5CFGmGtFGXzqn3otoC8j+KfiB72GIZbUJSCekX2j1xC67KjzI2Om0IzR5umOAFl3XrQsTn+B8I8h0UqPQSLfzhUuOhSP55Q31fboRHmmqNs6nJB0ggR/tX4wMdkai6CBbKQjHKB6Sf/301ktXsK0HcGT82gVO/m2uDa5Lmv8aBWCAKlTWpiZS6hsZi863KkwU8xb8PMYGge28tuie24to4mTFZo3SxXMD+CSmrHdbrpd+KVH2we76ewu1ktWeEpLGDWcf2nricGUHlT+fCI3og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(66446008)(6506007)(54906003)(86362001)(66476007)(71200400001)(66556008)(6486002)(66946007)(76116006)(186003)(36756003)(8676002)(6916009)(2616005)(8936002)(83380400001)(64756008)(6512007)(316002)(4001150100001)(478600001)(5660300002)(26005)(4326008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NmZ0QldNZGo5dDBaNkh4eEtnYTZ3Yk1IOC80VnN0YVNxaVMvWk9vVkZwaTlz?=
 =?utf-8?B?MHBabzJqN0h4NEo0SDNLRVJyQ2FYL2lKdDJ3TGtNRkVXU1NMald1RDRCR0lG?=
 =?utf-8?B?TTRjRFByNzB5R3pocDdIWVZSZGFqOEw3KzJTZEtzYVZZbW1QeFU2V3d3eiti?=
 =?utf-8?B?ckpFOHNGZHZ6OUpvV0VONWpwbFRURnZ5S0VVRFFUcXJCUzJDcU8ySjczRCtk?=
 =?utf-8?B?RUJoNkhCS3lhNWs0aFJGM3dUa0JiQ0N1ejdWaHJlbnhOMFpXSUc1cmZ6ZXVC?=
 =?utf-8?B?U3Uva1IrbUlUbVVUM0h1ODB3WUxucmFQR0NDemNKVzIwMUxZaUZRTGtIaDVv?=
 =?utf-8?B?M213N0JCYWt4STVZQlZxRWtDbmRZTVV5WDRUTEhYTjY3UUs3eGozcXV0WWg3?=
 =?utf-8?B?K0dTNXg4eWdOTGxBczlRUWJWbXoxS3k1TSt4Nm9mUVU1bkg4ZDNDMEVxRzNk?=
 =?utf-8?B?VGt3RUF5bUtkQUJwS0NyN1hkemhFUkcvRXYvZ1RicnhWd2JvL2twd2JoMlFl?=
 =?utf-8?B?TXpRaUxaUlJnMjRWMFYycWhCNHV4S0VSSlppZkxONDlHWjJNdENjTitoZ0tu?=
 =?utf-8?B?WVlVVXljL3NUTXc4NmFKYkp2L1lmZ2Q0bU1XWmRUSHFPM1Q0UUNJK3FPUURJ?=
 =?utf-8?B?VTRmTGRMYld2c28xU2tKL0FoMEhtRU03ZUFUZExNOEpvbkdUMCtyZW80Z3Y3?=
 =?utf-8?B?SlA3SXZWbkFVZllPWmdmOWc5MTlWbFQvYkZqZTBnSG5RdXpZaVRPdG03Znlh?=
 =?utf-8?B?ZVpBbHpNZ054TTVaSEpxTzA0Sml6Sk5VaEdDbUdXamQ0NzY1QVlYTm12eFVj?=
 =?utf-8?B?WlpReUlrT2VwdUZUK3lOdmVwUnF6ak0rcTJQVGYxZjRYYTJyYzUwazBMZTdB?=
 =?utf-8?B?MDdOYVAwakR5RitDa0NhMGtRQ2xRWGE0RnRLL1NoTEFHbDVESURVN2M4dTdm?=
 =?utf-8?B?UlRWbWNCcW9XWjgrZlBIZDlOM1o4Qkl4T2ZoeEF3NXc5V3dnVVc2U2VVZ0Zz?=
 =?utf-8?B?enNibjBNcUxxYUYrdUxtdW9uOHIraHRNYW83Z1FsZzUrbExJSmpFMFg3S3Nk?=
 =?utf-8?B?dTVxZ3A2bUhtRWV2SU9mTjhaSG1BT21VRUlGNzBUWVhBaSsza3V6UDUwNnFS?=
 =?utf-8?B?L0M1eVhLRk9XU0NyTmFaSlNZV0JjbDNMMGoyOGRMMTY3Yi9hMmw2UWpwRm5K?=
 =?utf-8?B?dkRiL3o0b2JNbUEzbnZnTGx5Zm5iNEc4RElNMSs5MVFuWW1qRXdERnlSaDBH?=
 =?utf-8?B?SStGd3RINkdvdnlXc1VGWEJVRGFCdDVxVHNSTVpIT2FNSEw4Y1N1Z0ZHZW9C?=
 =?utf-8?Q?momk2ynslJooVsBA06k5XUcGipIbfMhWxt?=
x-ms-exchange-transport-forked: True
Content-ID: <5B6731134E308849B6E287CC27004B61@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6594a7e-74ec-4cc1-72de-08d8a23d9d56
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 03:41:18.8019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZNBm+aokISTso8/Ud53cneEyLCbOZzUOwkhsFSwJlSvEnFXdHCVfcnpx3S0UmkWe/ydlIzaI4lvvemV6gqT07vfaL1rfq8HJItcPB0JDxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4960
X-OriginatorOrg: intel.com
Message-ID-Hash: CEEHZMNUQPRSG6DG75PEEWJHFOAR64ZE
X-Message-ID-Hash: CEEHZMNUQPRSG6DG75PEEWJHFOAR64ZE
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linfeilong@huawei.com" <linfeilong@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CEEHZMNUQPRSG6DG75PEEWJHFOAR64ZE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-11-25 at 09:00 +0800, Zhiqiang Liu wrote:
> Changes: V1->V2
> - add one empty line in 1/8 patch as suggested by Jeff Moyer <jmoyer@redhat.com>.
> 
> 
> Recently, we use Coverity to analysis the ndctl package.
> Several issues should be resolved to make Coverity happy.
> 
> Zhiqiang Liu (8):
>   namespace: check whether pfn|dax|btt is NULL in setup_namespace
>   lib/libndctl: fix memory leakage problem in add_bus
>   libdaxctl: fix memory leakage in add_dax_region()
>   dimm: fix potential fd leakage in dimm_action()
>   util/help: check whether strdup returns NULL in exec_man_konqueror
>   lib/inject: check whether cmd is created successfully
>   libndctl: check whether ndctl_btt_get_namespace returns NULL in
>     callers
>   namespace: check whether seed is NULL in validate_namespace_options
> 
>  daxctl/lib/libdaxctl.c |  3 +++
>  ndctl/dimm.c           | 12 +++++++-----
>  ndctl/lib/inject.c     |  8 ++++++++
>  ndctl/lib/libndctl.c   |  1 +
>  ndctl/namespace.c      | 23 ++++++++++++++++++-----
>  test/libndctl.c        | 16 +++++++++++-----
>  test/parent-uuid.c     |  2 +-
>  util/help.c            |  8 +++++++-
>  util/json.c            |  3 +++
>  9 files changed, 59 insertions(+), 17 deletions(-)
> 
Hi Zhiquiang,

The patches look good, and I've applied them for v71. However one thing
to note:

If you're sending a v2, it is preferable to respin the whole series,
even if you're only changing a subset of (even a single) patch in the
series. That allows tools like 'b4' to just Do The Right Thing, and make
sure all the latest patches are grabbed.

In this case, especially, your cover letter promises 8 patches (0/8),
but there is only one that follows. This confuses 'b4':

   ERROR: missing [2/8]!
   ERROR: missing [3/8]!
   ERROR: missing [4/8]!
   ...etc

I've fixed it up manually for this, but just some things to consider for
the future.

Thanks,
-Vishal
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
