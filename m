Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A62CAA0B4A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Aug 2019 22:24:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4537120215F4B;
	Wed, 28 Aug 2019 13:26:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0FD8D20212CBF
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 13:26:36 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Aug 2019 13:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; d="scan'208";a="171666831"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga007.jf.intel.com with ESMTP; 28 Aug 2019 13:24:36 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 FMSMSX103.amr.corp.intel.com ([169.254.2.141]) with mapi id 14.03.0439.000;
 Wed, 28 Aug 2019 13:24:36 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "Jiang, Dave"
 <dave.jiang@intel.com>, "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
 "Busch, Keith" <keith.busch@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH] libnvdimm, region: Use struct_size() in kzalloc()
Thread-Topic: [PATCH] libnvdimm, region: Use struct_size() in kzalloc()
Thread-Index: AQHVH9BpuhzKadnSBkOkhqdJ05WiaacR2OoAgAAMuICAAA1MgA==
Date: Wed, 28 Aug 2019 20:24:35 +0000
Message-ID: <7980d0c0b43bc6f377e0daad4a066f7ab37c2258.camel@intel.com>
References: <20190610210613.GA21989@embeddedor>
 <3e80b36c86942278ee66aebdd5ea2632f104083a.camel@intel.com>
 <d940183a-c00d-3a96-37bb-9553583f160a@embeddedor.com>
In-Reply-To: <d940183a-c00d-3a96-37bb-9553583f160a@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <3847512B969EEA4C94940FD1F358BBD7@intel.com>
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, 2019-08-28 at 14:36 -0500, Gustavo A. R. Silva wrote:

> struct_size() does not apply to those scenarios. See below...
> 
> > [1]: 
> > https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/tree/drivers/nvdimm/region_devs.c#n1030
> 
> struct_size() only applies to structures of the following kind:
> 
> struct foo {
>    int stuff;
>    struct boo entry[];
> };
> 
> and this scenario includes two different structures:
> 
> struct nd_region {
> 	...
>         struct nd_mapping mapping[0];
> };
> 
> struct nd_blk_region {
> 	...
>         struct nd_region nd_region;
> };

Yep - I neglected to actually look at the structures involved - you're
right, it doesn't apply here.

> 
> > [2]: 
> > https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/tree/drivers/nvdimm/region_devs.c#n96
> > 
> 
> In this scenario struct_size() does not apply directly because of the
> following
> logic before the call to devm_kzalloc():

Agreed, I missed that the calculation was more involved here.

Thanks for the clarifications, you can add:
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
