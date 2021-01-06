Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB892EB6BC
	for <lists+linux-nvdimm@lfdr.de>; Wed,  6 Jan 2021 01:14:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 30436100EB834;
	Tue,  5 Jan 2021 16:14:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=jianpeng.ma@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 50EDE100EB833
	for <linux-nvdimm@lists.01.org>; Tue,  5 Jan 2021 16:14:13 -0800 (PST)
IronPort-SDR: C9xse6vsDUT81Ofx6Uah1YpsnvQa7nC5NOo0rjarYI6FrYyF3supRakuQs5AEfd37NVTJ7r16y
 a1dhvV+ZgCSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="238753279"
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400";
   d="scan'208";a="238753279"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 16:14:12 -0800
IronPort-SDR: hju67KgG5weEFVAPOUzThk2wotMI9Etu0r8i21yYrgZK+KCzjotw8wv/FJR09mJcv+OtInztHn
 2cNoBYeL6eAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400";
   d="scan'208";a="379073265"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 05 Jan 2021 16:14:12 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 5 Jan 2021 16:14:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Jan 2021 16:14:12 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.50) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 5 Jan 2021 16:14:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOzPlmjaDfTCo3tJg4PPkHb3LQVGEJBxItwe3p1Egy+awu7fLK/kkhIW42S2xtU8jBFoFXHIxY9E6wlZkseKNDCoMWgtNbnNziZH89u8ks8ySZlwzrNHPiu3pLEkCx37RLOr4cbuFXzLzVC4QXAZ+DPqf/WAUcQtV105vd9JjU19b2sjPanF/ejW2qjL6U4/cVtT5Io6W2hOKHIYfEhLyHLrBZtH55H5AelmB3STUkyXOCz1tr9v7THZcA2g1Z5FFbIghVyDPC+AnOZ/OgnRf+tZ1pFpwnEJHCgRkJfq9J8+KoxvXtolVJkimc8ZUWLaohqlW3OZ2HB5KFTiab38kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shheNu7Z3htbJ/X8vKLfmMJ/WbK2GU3TXfZrSfQU8t8=;
 b=MuMG9T8U2nlaJjlyuGjVPO3vN5eSsQHsngvuXWPt8laCi1w1l/01c8UzV7vdrfwJFU0TGc8/wC0xr/EaKeL3qGj1bWADhsOmsIdzgNyNAJfY03RW2g2C9hoZvNmctCPA3tj86koo5o00k7bJwUoOUzFWYdJk93k2nscQmC/XUCOUErou1TQ7Gz3pm0HFP4Y4Dgj2Syf31oMoXuG+u0+FgRFOZp9yK/kbEleMiz2eu8NL9/Ku7eafOcUSlxj7xllwhQ0QVZiXe2V1c4c68WrFRisJxbE1VadjdM/jW0M3TosE/ob/KkbGTu/5MB7qi2OzlRC87JpyZDyYUOy4rIzO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shheNu7Z3htbJ/X8vKLfmMJ/WbK2GU3TXfZrSfQU8t8=;
 b=LmVhPeUNhrGULPs/nkTMgsBGpAg9laDyUDniG40qtJTR9RWaXK4G/LDo7LAEYxO7XzsnbIFeK0reITbLt6FSbLuRMPj2lB8FYVCOa9duron2AsL5uFaj/UY+nq4C+9B6wctATsvKIkVaKieFJwpCYsGyu2THJqH8L1sZQGYvMk0=
Received: from BN7PR11MB2609.namprd11.prod.outlook.com (2603:10b6:406:b1::26)
 by BN6PR11MB1249.namprd11.prod.outlook.com (2603:10b6:404:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 00:14:10 +0000
Received: from BN7PR11MB2609.namprd11.prod.outlook.com
 ([fe80::91bc:e770:d1b6:450b]) by BN7PR11MB2609.namprd11.prod.outlook.com
 ([fe80::91bc:e770:d1b6:450b%3]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 00:14:10 +0000
From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH v2] libnvdimm/pmem: remove unused header.
Thread-Topic: [PATCH v2] libnvdimm/pmem: remove unused header.
Thread-Index: AQHW40FAAZ1XWBy2q0ewEHgbYDwNQ6oZuwug
Date: Wed, 6 Jan 2021 00:14:09 +0000
Message-ID: <BN7PR11MB26090A83632842B5E4F625A2FDD00@BN7PR11MB2609.namprd11.prod.outlook.com>
References: <20201229002635.42555-1-jianpeng.ma@intel.com>
 <CAPcyv4i_HYByH9pLnuZgMgpRW=VkP=FGGStWodko1J5b4mbD+g@mail.gmail.com>
In-Reply-To: <CAPcyv4i_HYByH9pLnuZgMgpRW=VkP=FGGStWodko1J5b4mbD+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18f8b7ac-9f80-46b8-187f-08d8b1d7fd6a
x-ms-traffictypediagnostic: BN6PR11MB1249:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1249D8316D6122C9D738E862FDD00@BN6PR11MB1249.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U+jP857kvJ/eMGH+WMrlij05lpMXKzq5Q5RMXMzzlyS/NymPxtVEislXFdacxLq/aBJclU01pAKdu7JArMzF7wibC+E4XlW+zN08xXs3GG8gwEh/jirw/0ZUuRkHqv0+dREIfoYZ+RhaJerGUcof4rRTlGVjCaBGVU6sBohU0RSSOEy2qjhq2PaB4ydo7Jt94bOq6lxhznSu2Wltx9pxWybAJUpBe5wN0XPuVWdIbIC+IXFuMwKfT2E9PXJhFtJral2QpdTEUApLToWnVvbe7L42hFEPQ9lTW8rvMLT5w/eWOGNuVgom5WIgEdShGM5umeebTtfrFRxU3Wdlzr8z6xUKngyw9cmrvDIDtN8axciyrxMxn7fMB2UE26B5HSj07qgcv1oxAcPR5NRoBzTJIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2609.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(5660300002)(52536014)(55016002)(9686003)(4744005)(6506007)(53546011)(7696005)(6636002)(478600001)(6862004)(33656002)(86362001)(316002)(186003)(54906003)(8676002)(4326008)(26005)(71200400001)(8936002)(66946007)(76116006)(66476007)(66446008)(64756008)(66556008)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YlhpVTJ3UExRNThSYjIxTlBzOE9iNjREcHFQK1ZXRWxvZTFPUkZmNUs5SFBh?=
 =?utf-8?B?eDVKUmptd0duNDFtSXJzTDFvUmdWTzR3ZSsvUldxMjF1dW55d3VINTI0Q3NP?=
 =?utf-8?B?dldEemltTU1yNjBYMzRDZEhBdjUzRWpYcTdRbnZsdm9kOHNpUDN5Uit4dEtO?=
 =?utf-8?B?blNDUGlreVh6UGZjVHRhTWFkajE2eEVMZkcvd3FSbzJnK2tLT2ROZjNEYSs1?=
 =?utf-8?B?bzBwRUMvNm0raWdWbkFhU0dGR3pwTTVJTTF4VnAyVFE3anFSM2ljekVFMmVL?=
 =?utf-8?B?UUNtNVhBNnAvcjNEbmJjZi82Zkdia1VOT1dvV3Z6ek1LN2lUZ3pxYUZBbTh1?=
 =?utf-8?B?Njc5RVUxbmNVMjliS0VDQ0RZdDZIQ0JmZk5rR0FMVGtlbG1qdFMyc0hsVWZH?=
 =?utf-8?B?a2NhTDZoT1Nad09jUUVnTElLUEV0L2o0aEMzc2c0c2ZrSFZ1bVEvQUhkOEJn?=
 =?utf-8?B?RGZjUm9Mb2E4a2pQa2FoeE5tcUo0WG80akdqa2s0UkpyNTNoTEpXZVJIc3Ex?=
 =?utf-8?B?bkxYcHlaOGhORWdpVm0wSnNmeWd5bXhlaC9lcWpxVEo5K2RIZ0wvUXY3bWNn?=
 =?utf-8?B?TlFTVjV1NVJEWStXT3ZKbjRCUGhmd21lNTg0UjY3aDJacEJIemtZOXFQTndi?=
 =?utf-8?B?R0QwYXkzVnI0OVpYNFBNSVhCYjBtQzg0VjZmL1NvSTBrc0pvSTRTdGc0SUxY?=
 =?utf-8?B?N2trU0dsd3grVjEzWG1FeVF5cG0rZUt0YzZ2VEtiYkhKWXBPUFBrOWVMVlJH?=
 =?utf-8?B?bUxlaXE5L1p5b3J5NzJHd211eWF0MC8yTFdPTTlidlJXZE5BOGlpbDgrWURz?=
 =?utf-8?B?RlBVekExOG9sSjJjR0FCeERGUWxiNkc4RjA1WkRPTnBvY0tlYk10UTBFc3kx?=
 =?utf-8?B?dHk0VDV4Y0V5Y3N6Q1BkYkYxclM5bXRNSUJ4WXBMNElsV0VkODVDcnVTRGxo?=
 =?utf-8?B?a2MybUs4bWM3T2V0T1pWdFZlZ2xSdmk2Q0VIc2tSdEtCQUxqN25wRnFTZUNY?=
 =?utf-8?B?RG4zZ0tDZTdtVDR1RWovZnBRZ01JM2g0MmsvODdabkptKzJ4MWJQeWk5N3dJ?=
 =?utf-8?B?cUhEQjFIRmNzQk5hdlJTV0hoTUpHNjBkWkczZFAyaWFEY3RWNjhyWnJSbjda?=
 =?utf-8?B?bVBFd28zRG55NDVNS0ZvWVlsdnNDMzdOcEsyQ1pSVHBCa1pHU3VMd1JjeU1x?=
 =?utf-8?B?R1h1UWdXOTBpTG9OWUpWdldPZTFDcXpQSGpyakRqVmtxQkhob01OOFhQK1pH?=
 =?utf-8?B?TDkyUjJ0TlhLZm9xUW5RTWZZS2l6NWpWYWpkcElXWjk4ZVVHeXgramxpU1N6?=
 =?utf-8?Q?iPZr4fu5NrAPg=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2609.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f8b7ac-9f80-46b8-187f-08d8b1d7fd6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 00:14:09.9199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFw3BlDD5C6NBjAWgxcyRoI9B+4Z1c6psyEZYx3W55xPTjy35pu/rlM9U6auK3PLzShNph4NYMvLiYbsazz60w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1249
X-OriginatorOrg: intel.com
Message-ID-Hash: POERGSOHHETLWFY66GAGPLQ2GV4EXBG2
X-Message-ID-Hash: POERGSOHHETLWFY66GAGPLQ2GV4EXBG2
X-MailFrom: jianpeng.ma@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/POERGSOHHETLWFY66GAGPLQ2GV4EXBG2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Tuesday, January 5, 2021 5:00 PM
> To: Ma, Jianpeng <jianpeng.ma@intel.com>
> Cc: linux-nvdimm <linux-nvdimm@lists.01.org>; Christoph Hellwig
> <hch@lst.de>; Weiny, Ira <ira.weiny@intel.com>
> Subject: Re: [PATCH v2] libnvdimm/pmem: remove unused header.
> 
> On Mon, Dec 28, 2020 at 4:44 PM Jianpeng Ma <jianpeng.ma@intel.com>
> wrote:
> >
> > 'commit a8b456d01cd6 ("bdi: remove BDI_CAP_SYNCHRONOUS_IO")'
> forgot
> > remove the related header file.
> >
> > Fixes: a8b456d01cd6 ("bdi: remove BDI_CAP_SYNCHRONOUS_IO")
> > Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
> > ---
> 
> Applied, thanks, I'll manually drop the Fixes: tag.

Thanks Dan.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
