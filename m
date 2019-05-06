Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F8B15602
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 May 2019 00:25:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F0B5D212532E2;
	Mon,  6 May 2019 15:25:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3743A211EB815
 for <linux-nvdimm@lists.01.org>; Mon,  6 May 2019 15:17:57 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 May 2019 15:17:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,439,1549958400"; d="scan'208";a="168681699"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by fmsmga002.fm.intel.com with ESMTP; 06 May 2019 15:17:56 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.30]) by
 fmsmsx104.amr.corp.intel.com ([169.254.3.3]) with mapi id 14.03.0415.000;
 Mon, 6 May 2019 15:17:56 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Hansen, Dave"
 <dave.hansen@intel.com>
Subject: Re: [ndctl PATCH 0/8] daxctl: add a new reconfigure-device command
Thread-Topic: [ndctl PATCH 0/8] daxctl: add a new reconfigure-device command
Thread-Index: AQHVAffGQKFRM5+KSUiubBX/eR5CJaZfHL+AgAAGroCAAAEWAA==
Date: Mon, 6 May 2019 22:17:55 +0000
Message-ID: <6d832ef8fa6e0f1201048021dd1aa18b359efc25.camel@intel.com>
References: <20190503213231.12280-1-vishal.l.verma@intel.com>
 <12edf619-be22-8ae9-77c0-8a81cb353a87@intel.com>
 <e251c59c27e52515a0eb9f93ec1990d37cb8b31d.camel@intel.com>
In-Reply-To: <e251c59c27e52515a0eb9f93ec1990d37cb8b31d.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <9833C5939E7A7E40AF816810441DBF53@intel.com>
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
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


On Mon, 2019-05-06 at 22:14 +0000, Verma, Vishal L wrote:
> On Mon, 2019-05-06 at 14:50 -0700, Dave Hansen wrote:
> > This all looks quite nice to me.  Thanks, Vishal!
> > 
> > One minor nit: for those of us new to daxctl and friends, they can
> > be
> > a
> > bit hard to get started with.  Could you maybe add a few example
> > invocations to the Documentation, or even this cover letter to help
> > us
> > newbies get started?
> 
> Yes, good idea, I'll add an examples section to the Documentation page
> (other commands do this, and this should too), and add those to the
> cover letter as well for v2.

I meant to add, for now, a few of the most useful invocations probably
look like:

1. # daxctl reconfigure-device --mode=system-ram dax0.0
(this will also online the memory sections)

2. # daxctl reconfigure-device --mode=system-ram --no-online dax0.0
(this will *not* online the memory sections)

3. # daxctl reconfigure-device --mode=devdax --attempt-offline dax0.0
(this requires Pavel's patches for kmem-unbind, and won't work with
vanilla v5.1)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
