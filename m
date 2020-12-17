Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3E12DCA1D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 01:48:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 62426100EBB67;
	Wed, 16 Dec 2020 16:48:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9E4F6100EBB62
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 16:48:36 -0800 (PST)
IronPort-SDR: Ct4uLCgDC2AwBMd9ZrINl8OrK3r0HFWMOoS9D/N5+T2IRdqlRo73mVWgXbdm6HEo1E0lj9/C7v
 jdjKFbYCfm5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="193550551"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400";
   d="scan'208";a="193550551"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 16:48:35 -0800
IronPort-SDR: hgsXQMm5c4rmgxskgoLFFzfw3f2aMwDcEdf/Lj7W7dy61PoUaQJ1Oz1o5ieSYMsKsK8lk4k1IL
 6oukriJ9F6wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400";
   d="scan'208";a="337919208"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 16 Dec 2020 16:48:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Dec 2020 16:48:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 16 Dec 2020 16:48:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 16 Dec 2020 16:48:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGHNmPIcovepRsG9HLoX7HOjdgyBMXmq2cWff291qVycolGIR1PlzY9wdN04XaAoUWu9vhUOz8UTvPApEIsCw3AytZPwFeqZ9Bnf7G7OraT1SPT2fI9KCB7iFiWVh5ai3IN6qqJPOpueS+gWwrBepAcHtG5fW5GabkCf/FamuLYDBldVZ3SryARqBa9iU7qahFXfrD5P6qDUzhAUHc2Wxe8937iMyGbCjgw12iyHwrQWVzIpi/N/b6Db9DvXCkrCa3AQek0qqabT0KwCyej8ywpbvXbxxGW0f9A2pXNgVhH/VZ8RfhA805at3hVpjRrsAZXyv4DXDyLyLkFUSaXPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKou8Ccabmz2aJ/94BKakUMWTbIj4vyCjnlqGw9YjSM=;
 b=O7rmWSmpFSXHm9VZ+9RVPjpdpNf84pe7LbIcB/MxA3Amdr9f7tZNWHb6MZ7Mx+aajMaSHD6CWdqQ0LFGNCSVDVo5ni7DKW2SvacryW3ygh/+sM4E2g52gSIwYaG6u32kQlU96hBzdQ8yCVWAbMYzv5O9Q2AWX+/q1c2nSv0Opb4RCTqOPBXIdNdB/g7BtF7iaCj/9WsLRpdUDOY6mxbKr3YLFSe7Qef5tLDP3bIeGooj3nyr/YBCxKDWlDN6EaRtqftX0KujILQzl8pC9dDn3YmzJKRLWOVfuTOzxKX1Kkqjq1Amjsq0/6VqsfnzUGI8qm+CfxEE9GHIbSK29Z/dow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKou8Ccabmz2aJ/94BKakUMWTbIj4vyCjnlqGw9YjSM=;
 b=C8Zhjfidjl2gDuGkjYjQGxXmpGIpD617tB/JndVJFuslbxmQcnrSAcCKZi4VzpHXvZaw0TO60WTwlXA+JhArZ2RkGKQecng/5MvmUmupxvdWSmCXf3cW+y1NnbVihdrcyZdcbZCT5YAzJytCukPBdVQ8GU3c8B1pxUNLcj7TMVI=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by SJ0PR11MB4829.namprd11.prod.outlook.com (2603:10b6:a03:2d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Thu, 17 Dec
 2020 00:48:33 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae%7]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 00:48:33 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
CC: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH daxctl v2 0/5] daxctl: device align support
Thread-Topic: [PATCH daxctl v2 0/5] daxctl: device align support
Thread-Index: AQHW0/2hBW3eE6A3kk2+MM8XoOw+Kqn6dLQA
Date: Thu, 17 Dec 2020 00:48:33 +0000
Message-ID: <e3f1bb4e45f5c81c64372769fb39398d913036e0.camel@intel.com>
References: <20201216224833.6229-1-joao.m.martins@oracle.com>
In-Reply-To: <20201216224833.6229-1-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36863aa3-2f02-46ef-b818-08d8a2257b37
x-ms-traffictypediagnostic: SJ0PR11MB4829:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB4829B534584F8FA4C4444C05C7C40@SJ0PR11MB4829.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Na/ylgWvZ1y/7giEKvj3rOyyZaDzGd6gx7uBt0TLT6ZR9eSMnE/NbzXY7Ey4kOdRYpnCg3Pl+uZbQQYfnCMPQlenGi4se46piI7Pm1WHklAHuK4nj08nzodWyc1zIRRtqEXl0kaC/PZqUsyG5wMI78UeLn1uaD/AGgF72VP3+dXvWBweMyjWVGJYxUpvqWruCvUvMpFo3ErBvx3Wiwgk6zxhitDPahe0g7mOP0/C9Mc0sZbQjeLhrk0QjLAdfCTwdVWVqfL+AhPInT4UvANQn+0CUpBTEbsRmf/3AFFz6Hw79Mfx3n5HxOukrJmWppNHGqVf/a8XwtcUHz0jWEG/4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(66476007)(64756008)(83380400001)(66446008)(86362001)(66946007)(8676002)(36756003)(66556008)(76116006)(478600001)(4326008)(71200400001)(5660300002)(8936002)(6506007)(2616005)(6512007)(186003)(110136005)(2906002)(4001150100001)(26005)(6486002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?U2NFR3NYd3pjTTBUKzA0bXFKZnlhOHo5VW9ZTU5JMkdiNmUvekU0T2E2bDQ5?=
 =?utf-8?B?V2doTEptcS9LNC9mU09GcytnZFBEbHlmZjhjRVNXMWxOcXZGTXdJTVhacU9o?=
 =?utf-8?B?ZkNUKytuYmlXWkJJNW9GOXlKNEY4allGVUVUVkh4eWVNYndxMjhra2MwTkUx?=
 =?utf-8?B?TnF2WXhpS1NQNXh0TVdqSEtZSHNtWndXVnJQbEpVZHRCWVJkbGlrRE15Q1g1?=
 =?utf-8?B?WVNZNXFISE85UmNNSXZBK3lKaTdWUzR3amIzMFJSa1hvK3RLajdXUVlWTGl4?=
 =?utf-8?B?VmF5WWdReFd1ZjVENS95TWNldUwzaDBHbVJmTWFuOGVoUzIra2V1dFVuQWEy?=
 =?utf-8?B?clRqd0IzMWdTZFFZMmdXaUZPditMSDFvVUtHekZhZ0JmSEkxSTdrUUxwZUc5?=
 =?utf-8?B?TGl0c2RSd0dsQ2xyN2FXb3E1aFJ0MVV5c29PSVUxYm43dEZDSG95Vk8zcmdp?=
 =?utf-8?B?cG5LUXIwTG1kelg5cEtoSVhUTVd2SG0ycnU3bEErTVJkTUkreVJNNUEremMz?=
 =?utf-8?B?dHB5WGtWUk80dThNK2V0bWpPMVlXbklBMDhmbFVKbmZJUHZvNW52NFJrQ2NX?=
 =?utf-8?B?NTlCdEpCTTVZOVB0YndUM3FPM1FVSUNOWUtIUWgxS0luakxUN05qVXNuZXRW?=
 =?utf-8?B?VDJjYTdadU5TU1I4R2FsdTZ0MjE0VThPRWFJcTRjemNFOWtzelFoczU3N0FV?=
 =?utf-8?B?MFEwRFVBNEd6ZU5JdzJ0MXkyMUwxVXRTUWxXVVh3WXhYVkpaYThNWlNOa3ZQ?=
 =?utf-8?B?SzNrQU9DQXkycTRBdklwdWd5cGEvTWlqci8rYmNpL2xzNnAxZHNlTENVcFNN?=
 =?utf-8?B?N3FMTEhhZkVzUGV1QndEODFaUXd4NEwvYkdRRmFSZHF0WGxHdHhML3p5aE1J?=
 =?utf-8?B?M1VSRGF0WUJvdzc0bjc3RVlUU1hGVzk4TmsxRFlGRzg0SW9JU2YvWmM4akho?=
 =?utf-8?B?RTBFUUR5T2JsbmF6RTNJQjQ4c1laWjBYSXVPUjhGWjdZRFZyWTFXeE05WEdP?=
 =?utf-8?B?a1Y0MHV3dGttcHNWOFVzZFY0WnJUT3R6Vzh0T0tvUkVhQTVEVklteXZhQk5t?=
 =?utf-8?B?VWFCYVBPMCtlNHB4RVhZWVlzQVpudVROWnp1SHFobjVrSG1EUHFTU0NveG5T?=
 =?utf-8?B?SjlWVWh1UFJMeThjdU8zenptNDVmbnRwT0FPRHVUU3NOZ1RJODlTZ3U4bXRt?=
 =?utf-8?B?RlhyTFZEVXZ1Nm9EWWJrZ1NDQWJJSU5XaWpBMndiQmxvYlhKTlJpQ2dicFZO?=
 =?utf-8?B?V2t0ZFo0L1c2ZUpVYXpZVTNPcUtJaUVzcG9wVmJZVjd2a0VFOVpiemMrTWtU?=
 =?utf-8?Q?C0W6oqmpxTJfrnUSm2qYqEbX6Xn2St4hD8?=
Content-ID: <CA7FE9BBC37CE847B8D45FA4090716B0@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36863aa3-2f02-46ef-b818-08d8a2257b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 00:48:33.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nfgk/hFmpNp2hce63uT2K5pgu/X50wQt3qtW/YAe3LQ3M4HR+5r3g1THAiCEZxjkHY+ygJlRgZ2Th/PmXWPsHBWsTu4yND+cy5Txjyuc1Q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4829
X-OriginatorOrg: intel.com
Message-ID-Hash: RS2JOFUTVTY4MLKIB6NGBTEUWIC2JSPY
X-Message-ID-Hash: RS2JOFUTVTY4MLKIB6NGBTEUWIC2JSPY
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RS2JOFUTVTY4MLKIB6NGBTEUWIC2JSPY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-12-16 at 22:48 +0000, Joao Martins wrote:
> Hey,
> 
> This series adds support for:
> 
>  1) {create,reconfigure}-device for selecting @align (hugepage size).
>  Here we add a '-a|--align 4K|2M|1G' option to the existing commands;
> 
>  2) Listing now displays align (if supported).
> 
> Testing requires a 5.10+ kernel. 
> 
> v1 -> v2:
>   * Fix listing of dax devices on kernels that don't support align;
>   * Adds a unit test for align;
>   * Remove the mapping part to a later series;
> 

These all look good to me, I've applied them and pushed a branch out,
'jm/devdax_subdiv'. As Dan mentioned in the other thread, if you had a
respin of the provisioning flows patches, we can add them in.

Thanks for the quick turnaround on these!

> Joao Martins (5):
>   daxctl: add daxctl_dev_{get,set}_align()
>   util/json: Print device align
>   daxctl: add align support in reconfigure-device
>   daxctl: add align support in create-device
>   daxctl/test: Add a test for daxctl-create with align
> 
>  Documentation/daxctl/daxctl-create-device.txt      |  8 +++++
>  Documentation/daxctl/daxctl-reconfigure-device.txt | 12 ++++++++
>  daxctl/device.c                                    | 32 ++++++++++++++++---
>  daxctl/lib/libdaxctl-private.h                     |  1 +
>  daxctl/lib/libdaxctl.c                             | 36 ++++++++++++++++++++++
>  daxctl/lib/libdaxctl.sym                           |  2 ++
>  daxctl/libdaxctl.h                                 |  2 ++
>  test/daxctl-create.sh                              | 29 +++++++++++++++++
>  util/json.c                                        |  9 +++++-
>  9 files changed, 125 insertions(+), 6 deletions(-)
> 

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
