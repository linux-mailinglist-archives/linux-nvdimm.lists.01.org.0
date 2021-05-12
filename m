Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DD437D45F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 May 2021 23:06:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C498B100F2268;
	Wed, 12 May 2021 14:06:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2B9E6100F225D
	for <linux-nvdimm@lists.01.org>; Wed, 12 May 2021 14:06:10 -0700 (PDT)
IronPort-SDR: mvlXgGhOmb2VOpZEo8lp66+D9Y0FjkE5cSv7KkGWwJhBbzP1UpyHWonm5z5cWYnVcq9M4fJ505
 JVVSz/pQlXoA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="197834331"
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400";
   d="scan'208";a="197834331"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 14:06:09 -0700
IronPort-SDR: Gu9qooI7YPDJIm7pUoN3u3fdlwfoQ1DTgBeCmGvzXPDt9LrMmOTRCbtRAYNiGwhhwAid1E887v
 6tSHk1BnQv1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400";
   d="scan'208";a="430915530"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2021 14:06:09 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 12 May 2021 14:06:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 12 May 2021 14:06:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 12 May 2021 14:06:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX4tjTAekR+CV5tIsv12Lzm7+ytKMKEEZz5SJMIfmSKGB3/LVgzMk4Qh0E4NgeVuHI2wk0PEBxx3lWN4YwO1Su0zKti+bbLlsVznpz2KPUYCek1RtiJcprcwGYVeAiYR1ct/c27QdyWhmqXtWPKVev7xRc7fT4vZRiU32lmt17+QKV/YSfVyqeit9I9pHlSS/HTemPSafrU+4jpTg3GTCGhKONTdIOH/H1dXpGrjASGjYhFIgG92kgC/pBRdi5WxPS6nEPrvRp2hSmZbJZQvGrKd453Hz1KCaxbppVh3IN1udATOnrYO+GIk5vuRbHwVznflvrkUoN7qFHaQMWuPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSxakJaUR2tWGCrWTYjefGRvEQSGzNjTlbuBQ58uMdA=;
 b=SQycxcsZdCWw+qHFNGbVa4UGWf+Pkv4BY1/gEwOwIC7tuNkEy3aoL9OytrVm1JUEqlqm/hXzQNJo4XjtrMuw2qldoHY1Q+AMUcSzn6/99hGJeVQbzM6KQyYfht+hT5yDiWTxukrUinINhg5RNmh+d8xfVU6vB+VRV46BKUEXW8DyGrFpCAFC9RD3izsoAhol3NhjLfqhWFDv2OnO0hUQGEip6ffI3LuPwqUZ9Liyipy7CxxW1mGXQNKnv3tTEcQtrCovd6OZjcoNJvpoC2vsKEig0S2dTcRyf+U4ftibu7Z2q660LOVQhNbK+9Cr2s98qHyhxQze6DzDxElJOHKFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSxakJaUR2tWGCrWTYjefGRvEQSGzNjTlbuBQ58uMdA=;
 b=H9luPcSIiGeR46dEKitK7Olelv67EQ7O6tIcy3iJmuZdM7p0yby9BVqzs/tSD8oZgqLNzZz8mlugYrtngz0/V9kP0ykoL+GaPWmXQnHeEzmvbf9wStKH14DRKlkGtvNgM6bJtVPJKWb0YSlVZPsCtIPlkLsyn9q+GZebWIcVajc=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BY5PR11MB4243.namprd11.prod.outlook.com (2603:10b6:a03:1c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Wed, 12 May
 2021 21:06:06 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc%5]) with mapi id 15.20.4108.034; Wed, 12 May 2021
 21:06:06 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "sbhat@linux.ibm.com" <sbhat@linux.ibm.com>, "linux-nvdimm@lists.01.org"
	<linux-nvdimm@lists.01.org>, "harish@linux.ibm.com" <harish@linux.ibm.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "santosh@fossix.org"
	<santosh@fossix.org>, "vaibhav@linux.ibm.com" <vaibhav@linux.ibm.com>
Subject: Re: [PATCH 2/4] test: Don't skip tests if nfit modules are missing
Thread-Topic: [PATCH 2/4] test: Don't skip tests if nfit modules are missing
Thread-Index: AQHXI3eOEQnljR07BkutwRRqK+bYdKrNdrYAgADoWQCAEj2ogIAAAZeA
Date: Wed, 12 May 2021 21:06:06 +0000
Message-ID: <b8492c711f6145afe1bbeab726d26a4987cd0557.camel@intel.com>
References: <20210328021001.2340251-1-santosh@fossix.org>
	 <20210328021001.2340251-2-santosh@fossix.org>
	 <5b0e885146cf54acb82ead867e495169d7a28252.camel@intel.com>
	 <87fsz72cll.fsf@fossix.org>
	 <b5b8d378a757640c9e6345a1239e5c611a08dde1.camel@intel.com>
In-Reply-To: <b5b8d378a757640c9e6345a1239e5c611a08dde1.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.1 (3.40.1-1.fc34) 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f44250d-7cf2-4c69-fc53-08d91589c229
x-ms-traffictypediagnostic: BY5PR11MB4243:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4243DE91B8885C494B8C74FEC7529@BY5PR11MB4243.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BYlURxA1mLUJcRghL6KHd+0Mi34PDd3bkMwW4Fe6fFOpHa0xxZNbNHePSyszUhlks664DCzVY0bJUd+qKO+3/FYSh5qhLf+gQfm2h4bmtRDywDkraIVoKbzVytF5BcH+jz5qC/sAVX45pJ5duDHYSD5lZWI9Lo86ADAhJm9xlOEfCRTlRaXadlLyPdC5U73hERDnJS8G6CRboahkhoj5cobfNUgc44nQIFieeaRxKM+53dpkIxokmGvSWC45/bOvfU60W2atwOegGt1bWtlhDTS7iVVY6U/MEQBTTDpHFFxtDRo/0wU1GpxjEcIiQMdwhoLw3bYiiN6sd9Srh0w//mEWi2SXay4I32QqxDiAYbXzBlAz6GPTJV7RfkqzmszBmHEFa0mxfKiS8YFiE9D4VbnvFYSaLaLkqP2WNDNLhx6cmIUH9fT720T8DV0qKOWS6L08cRkYdfh2UjQoUdOEACXjyYkFLz5TPsWaQxAiT7JOeoQIPTnXwmNSVjgQPeJPBzBPsSzrjSuIEl5UPka4mOmT5y2ef5GRkhBnnhLl6ZRtCGTuS7863ahBpWfd9z0Xa3XFE+ebgbS9V4JBRJ3VyF59AwvcvzQDjcXUyp8AcRA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39860400002)(346002)(396003)(66476007)(110136005)(83380400001)(4744005)(66556008)(66946007)(71200400001)(2906002)(36756003)(66446008)(6512007)(76116006)(8936002)(64756008)(122000001)(5660300002)(6506007)(8676002)(6486002)(38100700002)(2616005)(316002)(26005)(86362001)(186003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?S2ltUTFRRkhuNWQydmJDdzdSYWF4cGswZVd3WEdFNnB0NnMxTTZwYmpxUTk1?=
 =?utf-8?B?dG1QMGFFdWl5WFIvbmZLTGFhTXVTTW5aYk1sem1maDh1aWowdzlvcG9PbU11?=
 =?utf-8?B?OEpyWGxKaWlkY09RL2VtQzVjZmZJWnBZQXZMSUozRmRnLzlIRkdPL0dFbVZj?=
 =?utf-8?B?QSsrTDkyNEkzYlVNWng3RGw0RHRSUFNqWHhBOFV0azhKcGs2QTZTTVhja2h2?=
 =?utf-8?B?ZUZ0cVYxU3pBbUNEeGJQaEpOVlhvVFBXdDNoOEFxNFdoaWxxVlVFcjB1UlMw?=
 =?utf-8?B?MCtkQis3L2RXZ0taeVIraFZTdHNmS1lrRTV2SDhEWitGbThLOS8zMjdaSkVU?=
 =?utf-8?B?UVRGZ0RlV2lWWmhvTFJHS0JUcVJrdUtjck9jcWkzNStadHlFa3BsWEdqYytO?=
 =?utf-8?B?MmFmOWNMRGlub2NyMVBQOWJ2dlZiOWZ6bnJqbkhuQnhQamZGSHJKRzlpUHpz?=
 =?utf-8?B?a25ZQUhhZkd2R2l2RHBQMXFPbHZiL1M0ei9iTmt6SU1ROFpodE05d0QyMmFV?=
 =?utf-8?B?ZStrMGxwdURORVpPcHlnSk1VTlRxVVJ5NHRLdktjdUswTmVWYnljdzdYZUR3?=
 =?utf-8?B?aXBXWFBhcUEyV3FQSnNIdGxpWVBiR3Nvd3NoUFEzdGRIdFI5ZWdqTHordUpS?=
 =?utf-8?B?WTROSkdPbjFKem5rajV2MVhWYUt5ZnNYUkdwUEFMak5NV0VjeWdYcWFhWnBZ?=
 =?utf-8?B?cHgvejZJSW5QcERYNjNTMGUxcU5TR2VDdE5CbjdnZVpWU09KNGp2TjlrMnNL?=
 =?utf-8?B?eXFZNDF0TmwrbUpHeDZMRERoSTVhazV2WjQ4OUdISC9IdFVyZkNESHNjUDJD?=
 =?utf-8?B?VERzS1hoOFBmRVhDYUFJVElsd3FNbWxsZ1JPNEY1aFhhbWtOVlA2VHkrQ3Br?=
 =?utf-8?B?WitTb3pZOXNlZktzbDRvZHBYRzJUOXZlWnQzYzN1OWVTWS9tTW1WV0pvc0ZD?=
 =?utf-8?B?QmErWHZJRVlXR2FZWkUwWk9lcllHN0lTM0pvejYzMitGU3NYeGp3KzI4NnB0?=
 =?utf-8?B?MDRVc0ZhKzRZUm1mMFN1dzJKVzFVVElzUzZmcVVBL1Zkd0xYWUZ2R1lMWVZL?=
 =?utf-8?B?SjNrTEJQVG1CWTFxTC9TdmdzdU9CZGVMM1hpVnZPYlZjS1dIbWZZK2lWOFZv?=
 =?utf-8?B?bVAvNXM3TktreDlINS9hOThrT21yWjhGOE42bmpZYVhJbjJrVGFjUlFwTEty?=
 =?utf-8?B?YkFuekhkaW1maDhZQWU0MlluNGpaVCt2U0NpZGxWWmhEMDNTSGZHM3NobS96?=
 =?utf-8?B?RnFwa3ZpWGxRNWFkaXpIK3RDSmNHZkprUTJxczM0SHNwUERjN2NkOFF3YmtX?=
 =?utf-8?B?QlhiSS85RjVoWUM0WDRDbkVWYXhwOVpwYjRaOVFEV1pOY3hienpTeWZPZWpZ?=
 =?utf-8?B?Ti94WktTUUF3bWlEa25ackxXTUExUDkyYWR6ZmxndmJSbzJVVlRtL2FTeXd0?=
 =?utf-8?B?ZUhVaXNzdEEvbUJCUmh4eWhNKzlVaWVudWRXK2ZOaEZOeGJCcmNETzZSendo?=
 =?utf-8?B?NEQ4dmpMcG5XMzhwSHpudnlPOC9Ob2p4WmhBaDNXSElYRVU1UDI4bERWSVJZ?=
 =?utf-8?B?MzlhTmdoYUhDYnlxYW9DVEhDVlVmb0g5YnU1YytiMUFSZ1BCd245MFNpZERt?=
 =?utf-8?B?d2I2VDlJckJjcEFpb0xTMmZZT0E2dTExRS9MWURlWWJYWWRWNGRwMmRLYnlh?=
 =?utf-8?B?YTNWV2tKTE16WWx3c1F4V0ZBdGdsQlM1WEVxQmw0dVlBU2NCbWo2SjZzRCtl?=
 =?utf-8?Q?xhp0XCj3kaaHouna/qfmRr8y91/isaTjDgVa6XK?=
Content-ID: <A02553C59C90554BBA8AF32E2AA506BD@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f44250d-7cf2-4c69-fc53-08d91589c229
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 21:06:06.0650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 986Zqs/V8NOa0MY57XqxczfUHcQiQL7QCXZDX1cca0IaqZ6BcHWawAHbbGqimJEvg9jLSTrU+pF27ESVlcGWfsP2jpEGxkrbfSIkF80/ieI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4243
X-OriginatorOrg: intel.com
Message-ID-Hash: 4Z33DCYH4PKMA36KXOIBQSUOFS3TYEBJ
X-Message-ID-Hash: 4Z33DCYH4PKMA36KXOIBQSUOFS3TYEBJ
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4Z33DCYH4PKMA36KXOIBQSUOFS3TYEBJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2021-05-12 at 21:00 +0000, Verma, Vishal L wrote:
> 
> Did you mean for the errno check to be if (errno != ENOENT) ?
> This is what was causing the unit test failure for me. This patch on
> top fixes it for me:
> 
> diff --git a/test/core.c b/test/core.c
> index 44cb277..698bb66 100644
> --- a/test/core.c
> +++ b/test/core.c
> @@ -139,7 +139,7 @@ int ndctl_test_init(struct kmod_ctx **ctx, struct
> kmod_module **mod,
>          * determine from the environment variable NVDIMM_TEST_FAMILY
>          */
>         if (access("/sys/bus/acpi", F_OK) == 0) {
> -               if (errno == ENOENT)
> +               if (errno != ENOENT)
>                         family = NVDIMM_FAMILY_INTEL;
>         }

Also, looks like for access(<path>, F_OK), it should be sufficient to
just test for the return value instead of return value and errno.


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
