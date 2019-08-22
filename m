Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742F999F76
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Aug 2019 21:10:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 58D4220214B21;
	Thu, 22 Aug 2019 12:11:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 12713202110D0
 for <linux-nvdimm@lists.01.org>; Thu, 22 Aug 2019 12:11:39 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Aug 2019 12:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; d="scan'208";a="190695444"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga002.jf.intel.com with ESMTP; 22 Aug 2019 12:10:37 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 12:10:36 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 FMSMSX153.amr.corp.intel.com ([169.254.9.165]) with mapi id 14.03.0439.000;
 Thu, 22 Aug 2019 12:10:36 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "justin.he@arm.com" <justin.he@arm.com>, "jmoyer@redhat.com"
 <jmoyer@redhat.com>
Subject: Re: [PATCH 2/2] drivers/dax/kmem: give a warning if
 CONFIG_DEV_DAX_PMEM_COMPAT is enabled
Thread-Topic: [PATCH 2/2] drivers/dax/kmem: give a warning if
 CONFIG_DEV_DAX_PMEM_COMPAT is enabled
Thread-Index: AQHVWRtCI+fbHAl24k6KFAKDmutKnqcH/a+A
Date: Thu, 22 Aug 2019 19:10:35 +0000
Message-ID: <91b07911eb6d307c4cb652da6ec53bad661ec066.camel@intel.com>
References: <20190816111844.87442-1-justin.he@arm.com>
 <20190816111844.87442-3-justin.he@arm.com>
 <x49tva9ni68.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49tva9ni68.fsf@segfault.boston.devel.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <FE4E6340A0DCFB4990BDFDF7F44BCDE4@intel.com>
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

On Thu, 2019-08-22 at 14:55 -0400, Jeff Moyer wrote:
> 
> When using daxctl to online memory, you already get the following
> message:
> 
> libdaxctl: daxctl_dev_disable: dax0.0: error: device model is dax-class
> 
> That's still not very helpful.  It would be better if the message
> suggested a fix (like using migrate-device-model).  Vishal?

Yes, it is on my list to improve this. Currently the man page shows the
above error message, and talks about migrate-device-model, but I
received more feedback to add another bread crumb in the printed message
pointing to migrate-device-model.  I'll send a patch for it soon.

Thanks,
	-Vishal
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
