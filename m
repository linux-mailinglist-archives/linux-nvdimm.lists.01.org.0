Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2A8364DF4
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 00:56:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 80D67100EB859;
	Mon, 19 Apr 2021 15:56:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=erik.kaneda@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D60FD100EC1DA
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 15:56:14 -0700 (PDT)
IronPort-SDR: /aOzsu4Kd9HmY6dUNvJhPGLVGsRxITPi12mKtYj+nTgXAL7uMGNpm41aBQ8/k/HyO5dce31HLe
 o1vM/O+94EuQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="174895941"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400";
   d="scan'208";a="174895941"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 15:56:14 -0700
IronPort-SDR: SxW7g63o4zlHSbrzZSFK+aqLdvuRHF5nhJVDa57qJro5ZGQTKTYqB/jD5i7sEXEgKmHfqeK9Fv
 uwCHu/GVAhwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400";
   d="scan'208";a="602281616"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 19 Apr 2021 15:56:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 15:56:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 19 Apr 2021 15:56:13 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.56) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 19 Apr 2021 15:56:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8P2Jq00/wmKTzepkOelQPNzPruOyw72T/sFcqwU+YPth6CPwrgdwWLwv3RtuCv/cZ/B2R1AVvBjY1m78EsHhICJrla2QkpE1lLkfmaimAezMzY8dFNByRRgCWadGAfNQSCQQ/eo5OtJKvlidQwYgQntKg879QtRd5FO6+ppx4/+tzL2+vAFmKIpcGWPaQ+6gYWZdrc85YHtcvwH9W+hmAO+I2CXuTgY0hN8zu2NmNEIFTczqnsA7/uVet0XaCWQyEie2O3s7eJdFmW7pvMUECkNrcYs6Red1OhM64jSUMpXmrZYg+fYg30H5BlOO1/Rc1iL44UN0gVvVCwvmIsseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mcx35zd892OQpBKS8iZcLcyNSm1OCERoxSNEq9mDBEU=;
 b=OaHaYHUtHp35DTNxsZbYwgZ2Po+0ilDf53cFv5iSSWnHB+fIK198+fDpm0RDKCrZ42DLNbGhm1tG2GtCDip9N9Rn9lmoLCLs4DNXZgEiilPpSUirk+24mmUi62dm+uKE22Xh7hv2MPQrczlHqLewPi4taJcFFmn8QZAYu6aALkIZJKEgWELfN11KWuuLh7nOdUnb9nl7UuNNhmQVPqSEFMry53rcyFv2wWNronik6JTFDLNTm2ZbhfFH9MBGA+Ze6/ULyhUa8KEH9xrsEfFUA/snxuaKGv5i09dFa9Axyp3ayUajdJCRSnSvFGD/ILOUzva7SvtFhZcHQnXR+X9KAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mcx35zd892OQpBKS8iZcLcyNSm1OCERoxSNEq9mDBEU=;
 b=ymRzLuX48yoVkVbunwkeDG3dI0fx0N1hHcp277p1qX/odsE26IQDmDy/o/diL29pfh93eCfl74xFtDUtYDUxFx7sCWMzQVo8qV07cbVUl9GWrF6ZK/PLFGkq+6e8wWcT+rlcsD8xH9nXl9/SaWZ3CWGXyDkXBuu+MMxLsB052Ak=
Received: from CY4PR11MB1590.namprd11.prod.outlook.com (2603:10b6:910:6::15)
 by CY4PR11MB1925.namprd11.prod.outlook.com (2603:10b6:903:128::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Mon, 19 Apr
 2021 22:56:11 +0000
Received: from CY4PR11MB1590.namprd11.prod.outlook.com
 ([fe80::899:e23a:1c:94c6]) by CY4PR11MB1590.namprd11.prod.outlook.com
 ([fe80::899:e23a:1c:94c6%8]) with mapi id 15.20.4042.023; Mon, 19 Apr 2021
 22:56:11 +0000
From: "Kaneda, Erik" <erik.kaneda@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, "Moore, Robert"
	<robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
Thread-Topic: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
Thread-Index: AQHXMvxos6/G1E0Lb0im/q88amHNoKq3m/kAgAAYKgCABMAQMA==
Date: Mon, 19 Apr 2021 22:56:10 +0000
Message-ID: <CY4PR11MB1590FE3E5B4AC80972BD253AF0499@CY4PR11MB1590.namprd11.prod.outlook.com>
References: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com>
 <YHnLCoeBDn3BcRx1@smile.fi.intel.com>
 <CAPcyv4iwiJwwgiisZTqk6F=A8hLJCGkK-4suqDMPYYiLzuLwFA@mail.gmail.com>
 <YHn2oiP+2YpkFGXQ@smile.fi.intel.com>
 <CAPcyv4g=XyFfDZYL-brAO7LTVEc90=x7aQWar_WZtfnPx09UVQ@mail.gmail.com>
In-Reply-To: <CAPcyv4g=XyFfDZYL-brAO7LTVEc90=x7aQWar_WZtfnPx09UVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e2a5919-a1f0-4f7e-6d8d-08d90386538c
x-ms-traffictypediagnostic: CY4PR11MB1925:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB19253DF3F6B43BDAE5E802EBF0499@CY4PR11MB1925.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UGIjpZRkG4w/3Rn758Gd0OrCTFAx3LW0L5XuMfuB4mvVeh64a0uRa4ygLsBQ5puySysixcCimcBjNbs49PPBYxmLeOSq4hcwNws9zDdp8aJvITAKH79vSeN3rG7VBa4D2VxkDim59dIdM3LrFNKW98gvS61r2rt5712HYl2P+ij2SnTMP10BIp0fjmS/7ULiDnrWfZZ+71gjLQkgq0GZ1oD7Twu6i39Kpl/dhQjcTdc9gHJZ0QClpZe0fOlxyvWcDHNGiEOC935TzKQRzlubuH0j8/UUVwybHUh4AG178v8wBzGtpPA9l5JEve600Jnp/7OrKytY7cAr6n3a8nPK64Nk/gYcTEF8rOBrObzlQrTTWVehT5ukhEnlK8AmVGvNajspJApWFUG903+gDeqG6LGP9BWL7JkFGk0+5WqEqjuP944nNXRyrmBfUp+LGI8walU4EhHxrAGxp0n5tqsCISTKy6fDl4JeDV2sROr95xsKcksMFBEkNXcniot3Ly/1NStSxmZWP8ZLjKpWz/kYBfzHQzyDzNYDWTO+7TwBCA529rlyhVPYuCaD025j/kMn530kHC/8FiDjMy3YgxdlDh2R20pag/uLdzZ6KVqdHkI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(396003)(346002)(33656002)(86362001)(52536014)(26005)(6636002)(186003)(76116006)(66476007)(66946007)(7696005)(122000001)(71200400001)(66556008)(66446008)(110136005)(54906003)(64756008)(6506007)(316002)(53546011)(38100700002)(55016002)(9686003)(478600001)(4326008)(8936002)(8676002)(5660300002)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UFNsajN6Q05LWDB4QnhDSzlET1FtV2NEZFh1K21LZVRMcnJHSnhNWmg0Mkxa?=
 =?utf-8?B?cTlqVEZzK2MrbWF2cFM3MVZMNkxaVStsNEUrK2xjMkdKRS8xRFRveTJlTk84?=
 =?utf-8?B?SXN5M1Z0QkFkMlVYVnI0MS9KdUpqc2xpZUpxV1RzR040MlR3czBvNmFMSHNl?=
 =?utf-8?B?YkkrMTNtVE81bVdaeXhaSXVLa2tRU2ZTQ3pJRmNNZlQveGhWZ3VGOHZaOHVn?=
 =?utf-8?B?bmpPc1JWZnIwbGQ4dVVIYXEzQ29QbDI0RXRXV0dvVWpRMW44a2lRWEp1dExY?=
 =?utf-8?B?OUQ2UG1EOXBVSkVpNXhiT2J1TmxSQW9Ra2ZCQTc4dmNrY0ZjQ0pWeitwZmcx?=
 =?utf-8?B?Q0ZnYkFJZ2xoWFhLRUl0Q0QyUVR6bzdFMUhXQXdRb0UvQjFsb2xaelUyQklE?=
 =?utf-8?B?MUl4T3d4UU9tZ1VrREFFZnBjb003SXhrVzJCNTNBMjJ1ZktHTFFMVndpZHFS?=
 =?utf-8?B?bDd0S3U3bG9VUTQ5bUwrdVN5cVgxTkRSZEFGY3pwVk1LWFhHNzcrbmdLMTFw?=
 =?utf-8?B?ejdYQXpjZXNNSVp6ZkNldFZuWFpaSjg3ZlNhNlhUNmFqamFsUVJXaUFvS29w?=
 =?utf-8?B?dWdxR2JNSjBPRE56TEd1YmJ4MnF3U2NwQjN6dXYyVzZBelVYbWgrMERzcVNV?=
 =?utf-8?B?N3VyZDJGTzdCZklUMzRqVXpXc29PSENOVEJyUHJudnQwS1Y2dlpwYUtObkFK?=
 =?utf-8?B?dmU5VGdJNjJ5eTdLSzFnWmtTeHhLcTYzcko0VkVXdmZuSG5ERC9MbGJSTys5?=
 =?utf-8?B?KzVTTWpTUUl2OC9zWlkzTmNwN1hqUHRhbXJTQVFIMXNFVXZMTnhML3ozYzh2?=
 =?utf-8?B?TWhNWXBTcmVFajljbElWY09TdDg0anVuRHBPUmFvVHoxdnZQOUNUWEFrVGpE?=
 =?utf-8?B?a0lCK2NGRkVJdTY5bHJ6RzN4a0dMVmpCZ2pHSG5WQXRSTTlDTk1yNENTUTBQ?=
 =?utf-8?B?NDdhRWcvaUIwaG9aTVZ0ZXBNWGdhTThkMCs3VXd1UXlYcWx3WFd2SFpSNC8w?=
 =?utf-8?B?R09TeU8yQmd5R0cwNnNSWG1zWnZKS0haVExQN053WldLekxKaHBraHY1dVg3?=
 =?utf-8?B?YXhCU2twT2kybm1ERVZRcW85MHAzMnVmbTVoSGtPNnl5U1ZHTVRpbHU4MkpV?=
 =?utf-8?B?K0NyNTJEYzRjUGhMNWxwWmxNQWNqNnN6dWFuQXVyaFNPRW5qcmJrYXdoVnA1?=
 =?utf-8?B?Qjd6eTUvVkVEQk1WLzdCMEtBSm5iQ3lrR0YxK3V6K25vSWJWRnRkdjBsZno5?=
 =?utf-8?B?SzIvY3dTTkNLb1FaQXJPdVQ1UGo0a1ZQeXNwMk9aRjFtcFdQcTFMN0FkdXBy?=
 =?utf-8?B?aGc3Q3JCTDA1WUlLMXIvc2JBL1ZCU3hUaXR1bmhMcitzcld4Z211T2x4Sktq?=
 =?utf-8?B?YkRZajY3b25NQXhFRXN6RnlhYUVqZDlBVnFaeEFxTVE0cVkyUzJHR283TXdm?=
 =?utf-8?B?TktLUXY0bHlUY1lsanpqbituZ3Z3SnQvTm42dWJ1TmJvYjRzRW40aDEzTmcw?=
 =?utf-8?B?eWxMS1hsODV5bUNBS0Ftb1E4UGQrUTNXZDVzVTIxR3JIeEd3cG9raUlYUk1Y?=
 =?utf-8?B?NHJTc1RHSnF2K1B4NGlLTm1XNFhCaUVXYlUzZXVnMjdONGNsQjRVeWVnVmJV?=
 =?utf-8?B?dkF4TElmMGJ2YUVUWittdFFXS2grcU5Zb3lqd1RKZElDQTczbmlGQ051czFO?=
 =?utf-8?B?anFEdzVycjRmZ0pGMDdOemhMaWQ3N3Q1RC92Z3B6eTV6aExrQjNnQkdkYkdM?=
 =?utf-8?Q?4wKIhvQWI7euv5costCY0uj4T8ead1D5XrFyvOS?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2a5919-a1f0-4f7e-6d8d-08d90386538c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 22:56:10.9869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibFDnYfESiR56QTLAO+fuSxjKp3DW2P4fAj+j788a9mELPV+l4PrTMex7RkKjxZawycKtaboIIr8QxwxSEQrLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1925
X-OriginatorOrg: intel.com
Message-ID-Hash: DPS4DHFSWXRNLDU7XB2SLOLORBY3Q7H7
X-Message-ID-Hash: DPS4DHFSWXRNLDU7XB2SLOLORBY3Q7H7
X-MailFrom: erik.kaneda@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DPS4DHFSWXRNLDU7XB2SLOLORBY3Q7H7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

+Bob and Rafael

> -----Original Message-----
> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Friday, April 16, 2021 3:09 PM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-nvdimm <linux-nvdimm@lists.01.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Verma, Vishal L
> <vishal.l.verma@intel.com>; Jiang, Dave <dave.jiang@intel.com>; Weiny, Ira
> <ira.weiny@intel.com>; Kaneda, Erik <erik.kaneda@intel.com>
> Subject: Re: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw
> buffer
> 
> On Fri, Apr 16, 2021 at 1:42 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Apr 16, 2021 at 01:08:06PM -0700, Dan Williams wrote:
> > > [ add Erik ]
> > >
> > > On Fri, Apr 16, 2021 at 10:36 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Thu, Apr 15, 2021 at 05:37:54PM +0300, Andy Shevchenko wrote:
> > > > > Strictly speaking the comparison between guid_t and raw buffer
> > > > > is not correct. Return to plain memcmp() since the data structures
> > > > > haven't changed to use uuid_t / guid_t the current state of affairs
> > > > > is inconsistent. Either it should be changed altogether or left
> > > > > as is.
> > > >
> > > > Dan, please review this one as well. I think here you may agree with me.
> > >
> > > You know, this is all a problem because ACPICA is using a raw buffer.
> >
> > And this is fine. It might be any other representation as well.
> >
> > > Erik, would it be possible to use the guid_t type in ACPICA? That
> > > would allow NFIT to drop some ugly casts.
> >
> > guid_t is internal kernel type. If we ever decide to deviate from the current
> > representation it wouldn't be possible in case a 3rd party is using it 1:1
> > (via typedef or so).
> 
Hi Dan,

> I'm thinking something like ACPICA defining that space as a union with
> the correct typing just for Linux.

I'm assuming that you mean using something like guid_t type for ACPI data table fields like NFIT rather than objects returned by ACPI namespace object such as _DSD.

For ACPI data tables, we could to use macros so that different operating systems can provide their own definitions for a guid. For ACPICA, it will expands to a 16-byte array. Linux can have it's own definition that contains a union or their own guid type (guid_t). As long as the OS-supplied definition is 16bytes, I don't think there would be an issue.

Bob, do you have any thoughts on this?
Erik
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
