Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF5D2DC6AD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 19:42:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D2DD100EBBC5;
	Wed, 16 Dec 2020 10:42:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EE9EC100EBBBD
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 10:42:17 -0800 (PST)
IronPort-SDR: zgOyQnCQ1MahccbyTtLwHSe3VM8YY5YD63tljMj6Df94OH6qybFMzGMl37nc6zKdTeFkLGZdeA
 +GQW6r4zAGDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="154347273"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400";
   d="scan'208";a="154347273"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 10:42:16 -0800
IronPort-SDR: ZNnpXfxg97TGyabDc/u5UYd9eqRWq0WB8Q+axKKxiK+MSC5WGtcHKXkX2dwQK2fG+k5Ibs4Dbf
 wn2fTVU5NjyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400";
   d="scan'208";a="488658265"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2020 10:42:16 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Dec 2020 10:42:16 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Dec 2020 10:42:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 16 Dec 2020 10:42:15 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 16 Dec 2020 10:42:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j66s4rDuiBkb4dtoke9EXfGNt3TYMa2nzEAyWotxnRqlJPLl5QgqxeoGo+RGDa0gqBGytLuezyzMyUSOrQSI5HuR06hGFtjkIdDeXm3oSxnlHcplXOfLpn8bG8z68d2db4fOZlwQiumpk7TDU8STKoxcWFd8ijgqsBxSc5eQXva5UclHHjKcLEqwXAbFw5BGqRIer/2AxzcrUD5yOoRgReKAV4K7G5odceY6+aqFn3SJ4SjiAeTpmOKKK/CIqzLjRuclgWhAowUKcL9Ryechqk3uWjLlFKFl+CuRfQ1ngA8lKBZnpnqRFCG90N0e4gWBk6AaVI9PjKdZed90ZbMC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8GleC82Y2X/Ikyuvidk3fWVTCApiST2nK25b/I182U=;
 b=iB2U6EcViZQ70HHgvewPxKpSDYzjTQuMnLgio0tp0xvNWQaew81VOF+hhKRS7cA6JKCLddUVKUUBE08zpnBTNNEe/7JkFA+nF1pJpq0TETKSTphrZECkzJjGgtCrUL4dBypQfcvP1E9LhE5rm0P8ahHWR0SjNdupnB4GFi+Aw6tNS8nXm7rhxfgcFaSt53vrY7PeJiwd8cESHzFqjv9Bz6qb/ctvsHxF2ZiNIEkuJfC2W9+jW7sYtzfyJ6kE8wqAs6IxJaKpU41SLW78uVjAsnguwXAk9JFRE5ZXfSqkgrXiyvxfuJkhX2ED4PIMguNsuwXOaSnd0iSGjd/8H1RFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8GleC82Y2X/Ikyuvidk3fWVTCApiST2nK25b/I182U=;
 b=AqASsfJ/jINdN4fdXThBc10IWayPDrxg0WH+rE1Rmt1iodddJf0PbzXkhzaCLasFYpW/1x8kaE4cXLea7pSaS1hRpF3JQJx9QS8oded6b4IwW/2aFbfnw3oj2pvn/qwiHrR56PeiNRCcftsZKHDsMEFlFW9vdq0M8nAQhB569mA=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2600.namprd11.prod.outlook.com (2603:10b6:a02:c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 16 Dec
 2020 18:42:11 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 18:42:11 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
CC: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH ndctl v1 0/8] daxctl: Add device align and range mapping
 allocation
Thread-Topic: [PATCH ndctl v1 0/8] daxctl: Add device align and range mapping
 allocation
Thread-Index: AQHWW6GWF54l+0lFOUmqQOy0+J0No6n6iOUAgAB2KgA=
Date: Wed, 16 Dec 2020 18:42:10 +0000
Message-ID: <9db17315af1440b805c4fed2338969e7fe3155ec.camel@intel.com>
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
	 <988f8189-b20c-d569-91f0-cf31033cf9d7@oracle.com>
In-Reply-To: <988f8189-b20c-d569-91f0-cf31033cf9d7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd541744-bd61-4752-2017-08d8a1f24c82
x-ms-traffictypediagnostic: BYAPR11MB2600:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2600E3971FC98B1C6806C76BC7C50@BYAPR11MB2600.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l6Lb8SKxPGvACoI3o1ghX6xtccWSwgXxmAInXTIVCxFkMmlx0h151Z1hA6zle/7kUs4mpg1sX9/iNvp9b1/JzWEXlLeKXoDcsmXx8QNJ+NH+3K4d3zvGNWFENWEfFjxMm1hsxwmU68l82CTh4WmCdBJUleb4AiFiFYlPiOHtXhOkAPlaHjwL2/BC8sIodtgUKrBU/OgQGRZLVJfaDHLdV1MZIiwBhREDmWQUcodrOdJAZms1R/RJmv3vSeJgUcv83KaMDOzKvAqyNAuBMSJ3fb52YkfpTs90lIn+DF42IE8IFKCb6sy/Qh1hbxiobp1b860q5anfFeaUZcWu9UOd9ajAyaBi5DS2mWG+QV66NxoL3i0VWdL6uU+BCHm5RCau46cCDFAH2ONE7rLCndC6KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(110136005)(66446008)(4326008)(186003)(76116006)(6512007)(83380400001)(64756008)(6486002)(71200400001)(478600001)(966005)(66476007)(316002)(8936002)(4001150100001)(2906002)(66556008)(8676002)(2616005)(36756003)(66946007)(86362001)(5660300002)(6506007)(53546011)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WWJWUEZ0YzVLeDhNNEtJYmdEVlJJb1I1MzRFeDlNbzZrTXBiTVZwVi9YM2tF?=
 =?utf-8?B?Z1BZWllNU0R4QXdOR2IxZ0syQmt0bW8xMkowaGlWSmM5RTc3WHBmY0IwQXBh?=
 =?utf-8?B?NGRsVUFEcWZRcEtrUE82Z1hpakxsT2VKZWFMc3lVamlNbkR3amcvMklXSkkx?=
 =?utf-8?B?S2c4Mm9sSDY1WHFQZEJDU1Z6NFpmZ1N2alVKQ0FVQlRLTGI1T1Q2b0EyaVVB?=
 =?utf-8?B?eVZpMVd6Q0JSQmlwUFE3eFc4Y3l1bGE0L2JCbFRZQndRd05jYzZ4REN5dU15?=
 =?utf-8?B?NVlibE1nVERMQ3AxWVFla2tFY1NoSmI1dGNIc1ZGRWxpdVJ5SGpmekI5TUtO?=
 =?utf-8?B?TVlQN3VXZ01rZWNlclRtUWlBcndiNFo5L24xRHdicjZFUTVaUC9SL0l2VURw?=
 =?utf-8?B?d1piYVVHN1UrSEthekU0SmkzY0Rpa1g5eXFFNVNFYjBBSFFmWlZtRnpBdk5n?=
 =?utf-8?B?YlNqb1pkb3NXcWR4UmoxV0FtOC8wdTVPNDdLZ3dUTk9xZ0Z6UzlaeEdJMVE5?=
 =?utf-8?B?MGV2c29pWnh6UmNVOEE3WGZHRFJTNXBUcmFjZXFsVzJiSUhFOXRKdDFUNzRI?=
 =?utf-8?B?Q09PbnpHZE05K2JLYitlNXdKRXB0VkV3QmZmUzdqeDEvcGhrUTRlUzdEWElh?=
 =?utf-8?B?UXpCZ1RSUEZ1RU5FWnBkV1NXeWxVM2RpWjBCVmdZZ2ppWlp1MDVjRE9KYzBT?=
 =?utf-8?B?cWlndnNpTjllenRwaHZpOWJWVm1nQmViR2lPdWNTcFd4OWdHbjNBWEJxRU1M?=
 =?utf-8?B?YWltS2pSOWRJdUVIYzFSN3A4ZzlKeXZQcGVxbWhXSEtGY0lKQzBrTGFKQjdO?=
 =?utf-8?B?QVI3TVVsYmZmYkRxblhDblJid0h2R0VNSXNYclNJQzN3SVdnSnhwV0p1L1Zn?=
 =?utf-8?B?RDhoM1VXZkFxcUhiazBRRlN6aWlrOWJiU3lGMkFxYmJjTzZWSkg3WERQZ2cy?=
 =?utf-8?B?VS9KQzdKMGlYRG1iZHVybE52dXhBSWs0Qm1CeU9Ickd0ZlJpQ1BZbGtsVGNU?=
 =?utf-8?B?eHZmb1N0Rm5jaWsraTZKdWZMTzFVdGJMTm13cWd2a2trVUpyYWY0UkVEMnpJ?=
 =?utf-8?B?VkNza1p0UGIxbTJpVFZ1YVJoMHZhYkZEUk1YTXZ1K3J5bGtyZWZNZHFiY1Q3?=
 =?utf-8?B?Q0NPT3hLVnMvdVNmMk1jL0VRZGZydkx1WDgzWFJISnQ2a0R0ZTFvM2JWYnJr?=
 =?utf-8?B?cUdSblIwS0w1dmNJQXJuV2RGcjZaRHZ4TnEwT1UyMHZic3pXTTNsdzNjdDdU?=
 =?utf-8?B?ZkRaa3dBNFFvZHBsVWhhc3AxUmthTlRJRmJuemJTVTUyNC80WGQ0MkZZcUo1?=
 =?utf-8?Q?aSuuh+YPuWEcfuvRODoS31RXhzL6QMrbNX?=
Content-ID: <CBF8E05768CD0D4AA539E52F4C2D8E24@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd541744-bd61-4752-2017-08d8a1f24c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 18:42:10.9319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iE+c7Q9fjqgqirVjn18mnpko59spYoDOd+29+73nf5PAx1cqa59A6zBEcfLuTlt5gPa5i27hj/W6QFZXVGUjI/QOnnDVNIa1dn/Gux5FzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2600
X-OriginatorOrg: intel.com
Message-ID-Hash: HWS2TDV7GJNUYQIPDKZCVE3BVU7UXA7W
X-Message-ID-Hash: HWS2TDV7GJNUYQIPDKZCVE3BVU7UXA7W
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HWS2TDV7GJNUYQIPDKZCVE3BVU7UXA7W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-12-16 at 11:39 +0000, Joao Martins wrote:
> On 7/16/20 7:46 PM, Joao Martins wrote:
> > Hey,
> > 
> > This series builds on top of this one[0] and does the following improvements
> > to the Soft-Reserved subdivision:
> > 
> >  1) Support for {create,reconfigure}-device for selecting @align (hugepage size).
> >  Here we add a '-a|--align 4K|2M|1G' option to the existing commands;
> > 
> >  2) Listing improvements for device alignment and mappings;
> >  Note: Perhaps it is better to hide the mappings by default, and only
> >        print with -v|--verbose. This would align with ndctl, as the mappings
> >        info can be quite large.
> > 
> >  3) Allow creating devices from selecting ranges. This allows to keep the
> >    same GPA->HPA mapping as before we kexec the hypervisor with running guests:
> > 
> >    daxctl list -d dax0.1 > /var/log/dax0.1.json
> >    kexec -d -l bzImage
> >    systemctl kexec
> >    daxctl create -u --restore /var/log/dax0.1.json
> > 
> >    The JSON was what I though it would be easier for an user, given that it is
> >    the data format daxctl outputs. Alternatives could be adding multiple:
> >    	--mapping <pgoff>:<start>-<end>
> > 
> >    But that could end up in a gigantic line and a little more
> >    unmanageable I think.
> > 
> > This series requires this series[0] on top of Dan's patches[1]:
> > 
> >  [0] https://lore.kernel.org/linux-nvdimm/20200716172913.19658-1-joao.m.martins@oracle.com/
> >  [1] https://lore.kernel.org/linux-nvdimm/159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com/
> > 
> > The only TODO here is docs and improving tests to validate mappings, and test
> > the restore path.
> > 
> > Suggestions/comments are welcome.
> > 
> There's a couple of issues in this series regarding daxctl-reconfigure options and
> breakage of ndctl with kernels (<5.10) that do not supply a device @align upon testing
> with NVDIMMs. Plus it is missing daxctl-create.sh unit test for @align.
> 
> I will fix those and respin, and probably take out the last patch as it's more RFC-ish and
> in need of feedback.

Sounds good. Any objections to releasing v70 with the initial support,
and then adding this series on for the next one? I'm thinking I'll do a
much quicker v72 release say in early January with this and anything
else that missed v71.

> 
> 	Joao
> 
> > Joao Martins (8):
> >   daxctl: add daxctl_dev_{get,set}_align()
> >   util/json: Print device align
> >   daxctl: add align support in reconfigure-device
> >   daxctl: add align support in create-device
> >   libdaxctl: add mapping iterator APIs
> >   daxctl: include mappings when listing
> >   libdaxctl: add daxctl_dev_set_mapping()
> >   daxctl: Allow restore devices from JSON metadata
> > 
> >  daxctl/device.c                | 154 +++++++++++++++++++++++++++++++++++++++--
> >  daxctl/lib/libdaxctl-private.h |   9 +++
> >  daxctl/lib/libdaxctl.c         | 152 +++++++++++++++++++++++++++++++++++++++-
> >  daxctl/lib/libdaxctl.sym       |   9 +++
> >  daxctl/libdaxctl.h             |  16 +++++
> >  util/json.c                    |  63 ++++++++++++++++-
> >  util/json.h                    |   3 +
> >  7 files changed, 396 insertions(+), 10 deletions(-)
> > 

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
