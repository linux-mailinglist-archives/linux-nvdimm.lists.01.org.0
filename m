Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60197A7725
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Sep 2019 00:39:20 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A5A9B21A07093;
	Tue,  3 Sep 2019 15:40:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DE4F421A07A82
 for <linux-nvdimm@lists.01.org>; Tue,  3 Sep 2019 15:40:27 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Sep 2019 15:39:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,464,1559545200"; d="scan'208";a="182285624"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga008.fm.intel.com with ESMTP; 03 Sep 2019 15:39:15 -0700
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Sep 2019 15:39:15 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 FMSMSX161.amr.corp.intel.com ([10.18.125.9]) with mapi id 14.03.0439.000;
 Tue, 3 Sep 2019 15:39:15 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "Brice.Goglin@inria.fr" <Brice.Goglin@inria.fr>
Subject: Re: daxctl fails to reconfigure to system-ram when DAX modules
 built-in?
Thread-Topic: daxctl fails to reconfigure to system-ram when DAX modules
 built-in?
Thread-Index: AQHVYp1rcYt+hytvZUOKPNNrsTBSq6cbAO+A
Date: Tue, 3 Sep 2019 22:39:14 +0000
Message-ID: <f8b9b5c6830559d00f7d30ed9947602c8471885a.camel@intel.com>
References: <7b6e4dcd-6373-24e2-65f2-d08b2de461fb@inria.fr>
In-Reply-To: <7b6e4dcd-6373-24e2-65f2-d08b2de461fb@inria.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <C74AA55E23A75C4EAD717F1EC6EF8674@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, 2019-09-03 at 23:20 +0200, Brice Goglin wrote:
> Hello
> 
> It looks like daxctl fails to reconfigure to system-ram when
> DAX modules are built-in the kernel:
> 
> $ daxctl reconfigure-device --mode=system-ram dax1.0 -v
> libdaxctl: daxctl_insert_kmod_for_mode: dax1.0: a modalias lookup list
> was not created
> error reconfiguring devices: No such device or address
> reconfigured 0 devices
> 
> It looks like things were failing in kmod_module_new_from_lookup()

Hi Brice,

Thanks for the report - Dave Hansen also hit this recently, and I'll
take a look at kmod builtin detection. I've created a github issue for
this:

https://github.com/pmem/ndctl/issues/108

	-Vishal
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
