Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F21B21C9B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 19:38:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4011D21275474;
	Fri, 17 May 2019 10:38:35 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id ACBF52122CA87
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 10:38:32 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 May 2019 10:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,480,1549958400"; d="scan'208";a="172881411"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga002.fm.intel.com with ESMTP; 17 May 2019 10:38:32 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 17 May 2019 10:38:31 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.118]) by
 FMSMSX151.amr.corp.intel.com ([169.254.7.50]) with mapi id 14.03.0415.000;
 Fri, 17 May 2019 10:38:25 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
Subject: Re: [ndctl PATCH v3 00/10] daxctl: add a new reconfigure-device
 command
Thread-Topic: [ndctl PATCH v3 00/10] daxctl: add a new reconfigure-device
 command
Thread-Index: AQHVDDhtWivggYEeR02OP0UA+22Nt6Zv5+sAgAAjo4A=
Date: Fri, 17 May 2019 17:38:24 +0000
Message-ID: <ff36c9ecc9073ea39b0a501d8abf5cfc48db388f.camel@intel.com>
References: <20190516224053.3655-1-vishal.l.verma@intel.com>
 <CA+CK2bCEUjCNGHcfqh+4gxtf80eUkz_swNny6A2mkJwLi6Yn+Q@mail.gmail.com>
In-Reply-To: <CA+CK2bCEUjCNGHcfqh+4gxtf80eUkz_swNny6A2mkJwLi6Yn+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.254.87.144]
Content-ID: <F0122DCDDDDD4F4E8084F936C8C7A5E4@intel.com>
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
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, 2019-05-17 at 11:30 -0400, Pavel Tatashin wrote:
> On Thu, May 16, 2019 at 6:40 PM Vishal Verma <vishal.l.verma@intel.com
> > wrote:
> > Changes in v3:
> >  - In daxctl_dev_get_mode(), remove the subsystem warning, detect
> > dax-class
> >    and simply make it return devdax
> 
> Hi Vishal,
> 
> I am still getting the same error as before:
> 
> # ndctl create-namespace --mode devdax --map mem -e namespace0.0 -f
> [  141.525873] dax0.0 initialised, 524288 pages in 7ms
> libdaxctl: __sysfs_device_parse: dax0.0: add_dev() failed
> ...
> 
> I am building it via buildroot, and can share the initramfs file or
> anything that can help you with fixing this issue.

Hi Pavel,

I've still not been able to hit this in my testing, is it something you
hit only after applying these patches? i.e. does plain v65 work?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
