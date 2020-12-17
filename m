Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A916B2DD9BC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 21:19:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B89D100EB83D;
	Thu, 17 Dec 2020 12:19:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C5C64100EB83C
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 12:18:58 -0800 (PST)
IronPort-SDR: PqzuCtt3zQhmUScBMjTAXnBxyzG57ri3P+UQ3uU8Oz5YI7eMOcCgSBDWpGQcUcL01X4IDnmO0B
 AStCxawl1Drw==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="175466816"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400";
   d="scan'208";a="175466816"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 12:18:58 -0800
IronPort-SDR: Ea/QJLzB+092G+wzIefEDc+ATeAoOeDkqqncWHwrck8hQfR9JWfHaTdZUwle45EfsQM34W6Qxh
 lhCBxjPgX1Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400";
   d="scan'208";a="558205379"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 17 Dec 2020 12:18:57 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Dec 2020 12:18:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 17 Dec 2020 12:18:57 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 17 Dec 2020 12:18:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNPVHFkJvK2gijcRw9vlt2z2vz4N7GLzBLN+fsF7pN2IDR4zeOLIvWXHH7uWmeTozdFB7hOPtJz3pJ9u18lHCVSVvQ4cviJElJg91lCiXKU1hZQA0xjM+30gCHQMavAhuPgRl1RHRbVkoX1X32oxP4OjpJYXPO3XjyXEMHuug8O4BhMhYOI9Y9U4imKbB+A1K83HpoUcbObJY1PJCmnx83E+1OPNTgsJKE+rVaRbN71aG4yMeX0a6GqQSNfxH3ezSXoTgE2F3xVL1pFbnFQ+oGq9vrdyKEMhoeYtsX+sHaXYoZLLzjWABathzSLE3xA1T9gvA/M1eAl2hY2xUGM58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08m/Oat+vJUWuKh/O6Vqz2A/tVRkq1h5ePmpfeqHbxQ=;
 b=O8uHAT9sYaMJdWCR7N9+we2QbJWE5sergd/Btkknpi+9AfDI/3GzaufK5JuFHWmxvS1H24qgZEuNBJlDsyr8kfN+/qPxZ+xIoB4kJjHIZcqfaa8uSv/C7kv8qkEjrjr/wotEtSg9PWGUk0J6/e1nb+3u0gDFMxH4XmzZ/xHWF/+eQbUMP6yrcp8zq/++CTMB8+9xedYGtnqE6ns/QnYpzgEWWFV293+X6NPdh9IrMuOVtXLT2TCRGYsmAH2UEhp/x95QOtLFN+3nQZfP4I/psp+iFLjAB4BncCLEMUWdBeCiLI3fQbnxVkcpva1tSZNbmBH/NIKd1X9s8n88n711Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08m/Oat+vJUWuKh/O6Vqz2A/tVRkq1h5ePmpfeqHbxQ=;
 b=VVdwJo68499jSeVStiaD/ivA8ZS9lYvX729TMuDFpDLLR8zYSEYH7Q2isNarzomWa1sg5+hqCh53xGTydCoSL/yCkN1+oV8LclA1ShghdjwRVbDKXb9xBYg1CwuRu0rSvR174P2Zyhbmd+RpQwAV7aYQakq5hV1zxbyV/SvxUZk=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2535.namprd11.prod.outlook.com (2603:10b6:a02:be::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 17 Dec
 2020 20:18:56 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae%7]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 20:18:56 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>
Subject: Re: [PATCH ndctl v1 0/8] daxctl: Add device align and range mapping
 allocation
Thread-Topic: [PATCH ndctl v1 0/8] daxctl: Add device align and range mapping
 allocation
Thread-Index: AQHWW6GWF54l+0lFOUmqQOy0+J0No6n6iOUAgAB2KgCAADQ/AIAAC9aAgAAGQQCAAA1wAIAAw+cAgACVsIA=
Date: Thu, 17 Dec 2020 20:18:56 +0000
Message-ID: <af21593c734577910543e14de95d6b742d17fe04.camel@intel.com>
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
	 <988f8189-b20c-d569-91f0-cf31033cf9d7@oracle.com>
	 <9db17315af1440b805c4fed2338969e7fe3155ec.camel@intel.com>
	 <1ba4fc06-a13a-ce2b-2f53-95a913ac3a8e@oracle.com>
	 <CAPcyv4jiS07bGi+YRsMjAt37DCNwioTd8cd=LXKxOg-ARTM87g@mail.gmail.com>
	 <01b3c6f8-901e-c9c8-6e98-88366d4ecbdd@oracle.com>
	 <CAPcyv4jQ9ee-o3t_Wy_4K-Nm5Lj6wJKv1pdjvtYQG6eJ3ejUrQ@mail.gmail.com>
	 <b5a6577f-0384-8cbf-d3c7-2512f0f5d22c@oracle.com>
In-Reply-To: <b5a6577f-0384-8cbf-d3c7-2512f0f5d22c@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.44]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79b1f855-01bd-47f4-4a6b-08d8a2c8fb24
x-ms-traffictypediagnostic: BYAPR11MB2535:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB25351EB36854AB6EC660EFF5C7C40@BYAPR11MB2535.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H/9tkY83bpDD2DtJEmFrzZPTe/ei6weEp456ha5eSEFAbAdbjH87+kIVkBtAqz0lN+Uer1h/KVJ26zi6aNU/MK6rj5rLq63/xTq5VngJq0ujyjvhCsFMMpk405qwYfGWXlKsxEOakefHEss9oLDYsr6ouAkjB20T2GTLlOIhi6TNqQV1Zo4kZgFgsh+05AmAZW0AW/4SEpxr8xAR0pvK5kaVwSwptxggO53z3UvRaNvW/JQG9N1DjMguyGybHQpw6yh5+2dvWVgFd9CtveVBwFGOh3oofiQt0kLRtGz3oKWj0N76vbUA7rOFOnLh8/jeSMVDxImmhdg+ZS4sAtzMPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(66946007)(186003)(8936002)(8676002)(110136005)(26005)(76116006)(316002)(478600001)(4326008)(4001150100001)(86362001)(6486002)(83380400001)(2906002)(66476007)(6512007)(71200400001)(66446008)(66556008)(2616005)(6506007)(36756003)(5660300002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?S1drMHgvb3NqZk5vcElUVlFvVnhyQmVnNlBDWVUyWXRxazRhSVV2N2RPRW8r?=
 =?utf-8?B?NU4yTmYwblFab3FvaWpzcFRRT0ZqNmQ3LzRxeWxEVGZWZjJKblcwOFZSdkRu?=
 =?utf-8?B?aWwzbFFWYU5xM2ZqZkxYWnRySnUvdjM4aEM1K2pDdnFoc2c1bWtMTXozWmR0?=
 =?utf-8?B?aGZnMFdhbEZuSEdUS2toM0lnVHAzcmtKTUJSa3dyY1pMMXdyVkplVGZXU280?=
 =?utf-8?B?d3pPRWRRN3pHOWUzeEN0enNOenBwUXJFZmZmbVpzSVRsM1VMYlVQWGRyQnpw?=
 =?utf-8?B?a0hHbllnM2FiZWlkaFV3TWVXbTFJY0h3eHJNQnNOZzczRGlVUVRaQ01ZWHhM?=
 =?utf-8?B?MFd1a3lWS2p4L3lWTCt2SGNMRkF4eFE0bUQ2a0dBTmRnWGlsSFlleXQ0NlVx?=
 =?utf-8?B?UHhSMmlEdm9XNE5XSUw5MEx3WHQ3b1k3bC9Wemk4dXNoQmRZRm50VjRtSldN?=
 =?utf-8?B?RnRsNys3Qisvbnk3bk00Y2FueDFtUjcwU0lWaEJwbXJjUHdJejJFVHUrTFUx?=
 =?utf-8?B?eG91aEJ4ZlBWZGwvUjNPMkl1VSsvZm9halNQSjJQVUFaMi82b1RZRlgyemtQ?=
 =?utf-8?B?bjZCRm1ra25ISS9ib25kbURUL3ZkZWg5ZFpTRDFoU3h2Z1VHbmg5Y3JHUkcx?=
 =?utf-8?B?bTE1Uk4rUE9MWHNxeTVqQUdtVnVxek4xWmpRU3RVaThYM3dUOGRNcFlXSWwy?=
 =?utf-8?B?SFp5SE85T0w1WnFlenF5cnRzUE1NUFRJUHZUWEt0N1pPRmFSdjh0QUtEazFJ?=
 =?utf-8?B?aVpiYjlyWVFJMmU1Q1B0dmx5OVg1UDZINWdZN1JOMDF3c0xQU0hCYzRFbDVM?=
 =?utf-8?B?dnQ3TStEZnFpcCtZYWRrS2JOUVdyY2dXaHJWUmw0N1hxSXJ0b3NmSFJKSWI5?=
 =?utf-8?B?TUZoL1p1WWZRc0tLYkpBTmN6L0drZlhzWHh6SWVkZ0EzN0JiTFJyV2JSQ1Vw?=
 =?utf-8?B?cG5hT2VjaTFtYVduTHU1UllYT0NGR0hyMG12NUdpMkZ1cGUxcHBML01BaUFk?=
 =?utf-8?B?M0JkYnVnU3pvckcxRFFISTVlM21vd1ZJNHZJb1lPdTUyUXFNSmJCTHdVRTZ2?=
 =?utf-8?B?VlFnN1RMdGdKd0FvWjU2NUNFSGJYdUpsWU5zUFJXSnFabFhCSW90RHl1WlVR?=
 =?utf-8?B?ZWk4bkExR2ZFL0xIL3F0WklBUFJRaHBVb0p3bkJ0a0cyWitPM0dxeVlvK25j?=
 =?utf-8?B?WmRiWU5uZ21mRmtqUlJDbUF2Z2dhTy9WZEV4aHRDMld1Zi9Ma1FLVllYdUJC?=
 =?utf-8?B?VVM4SnRQR2xjRHkrZ3p2RlVtT3kzc0F6ZVpDRnB4SGI0bk5FejZBVGY1cURX?=
 =?utf-8?Q?1jDlBkLslYJ8WEJ6lKYN2Iq/u3UMPWAH38?=
Content-ID: <7CF479B71E7F594CA04ADA291347610E@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b1f855-01bd-47f4-4a6b-08d8a2c8fb24
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 20:18:56.2674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWGr0WiSzvsTgaK+7TbDGABYTfPgZazhylr3BTGLgqnP2If0GEegS96R69nSAUP201IZmnmOpcGy29fYRgM9PPLlH2Tcin4xbOrKMh4T+ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2535
X-OriginatorOrg: intel.com
Message-ID-Hash: RREGGQ4LRNH2CHEBO3CNKJGIFKCVOU36
X-Message-ID-Hash: RREGGQ4LRNH2CHEBO3CNKJGIFKCVOU36
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RREGGQ4LRNH2CHEBO3CNKJGIFKCVOU36/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2020-12-17 at 11:23 +0000, Joao Martins wrote:
> 
> The provisioning flow additions has some questions open about the daxctl
> user interface. To summarize:
> 
> 1) Should we always list mappings, or only list them with a -v option? Or
> maybe instead of -v to use instead a new -M option which enables the
> listing of mappings?
> 
> The reason being that it can get quite verbose with a device picks a lot
> of mappings, hence I would imagine this info isn't necessary for the casual
> daxctl listing.

I think hiding them behind a new option is probably best. And then we
can have different verbosity levels turn on or off. The verbosity levels
stuff is implemented in ndctl, but I don't think it is in daxctl yet, so
we can just do the specific option to display mappings for now, and then
revisit verbosity levels in the future if we feel like the number of
options is getting out of hand.

> 
> 2) Does the '--restore <file.json>' should instead be called it
> instead '--device'? I feel the name '--restore' is too tied to one specific
> way of using it when the feature can be used by a tool which wants to manage

Hm, I looked at other commands that take an input file - write labels
just calls it --input, so there might be value in staying consistent
with that. But write-infoblock just uses stdin - so that could be
another option. I'd be fine with either of those.

> its own range mappings. Additionally, I was thinking that if one wants to
> manually add/fixup ranges more easily that we would add
> a --mapping <pgoff>:<start>-<end> sort of syntax. But I suppose this could
> be added later if its really desired.

Agreed with adding this later if needed.

> 
> And with these clarified, I could respin it over. Oh and I'm missing a
> mappings test as well.

Sounds good I'll wait to get these in.

> 
> It's worth mentioning that kexec will need fixing, as dax_hmem regions
> created with HMAT or manually assigned with efi_fake_mem= get lost on
> kexec because we do not pass the EFI_MEMMAP conventional memory ranges
> to the second kernel (only runtime code/boot services). I have a
> RFC patch for x86 efi handling, but should get that conversation started
> after holidays.
> 
> 	Joao

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
