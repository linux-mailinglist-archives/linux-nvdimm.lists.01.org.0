Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699332E29A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 May 2019 18:55:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2BE422128A64F;
	Wed, 29 May 2019 09:55:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B4F2E2125ADF6
 for <linux-nvdimm@lists.01.org>; Wed, 29 May 2019 09:55:50 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 May 2019 09:55:49 -0700
X-ExtLoop1: 1
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga007.fm.intel.com with ESMTP; 29 May 2019 09:55:48 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 29 May 2019 09:55:48 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.118]) by
 fmsmsx163.amr.corp.intel.com ([169.254.6.185]) with mapi id 14.03.0415.000;
 Wed, 29 May 2019 09:55:48 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v4 03/10] libdaxctl: add interfaces to
 enable/disable devices
Thread-Topic: [ndctl PATCH v4 03/10] libdaxctl: add interfaces to
 enable/disable devices
Thread-Index: AQHVFaQn+suIWnLs/0CjlpLuCaD0P6aB0kMAgAD2hoA=
Date: Wed, 29 May 2019 16:55:47 +0000
Message-ID: <b3bd78d1e81521056b8e74679d7cc68a7d14a70a.camel@intel.com>
References: <20190528222440.30392-1-vishal.l.verma@intel.com>
 <20190528222440.30392-4-vishal.l.verma@intel.com>
 <CAPcyv4hsk66TBg-6V_quSHpZ7fx8S3tu8i4-30nwHoGvSMsZZw@mail.gmail.com>
In-Reply-To: <CAPcyv4hsk66TBg-6V_quSHpZ7fx8S3tu8i4-30nwHoGvSMsZZw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <AD471FCA655DD74FB231897E5B51EB74@intel.com>
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
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


On Tue, 2019-05-28 at 19:13 -0700, Dan Williams wrote:
> On Tue, May 28, 2019 at 3:24 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
> > Add new libdaxctl interfaces to disable a device_dax based devices, and
> > to enable it into a given mode. The modes available are 'device_dax',
> 
> Does this mode name get exposed to the command line interface? If
> "yes", I think this should be 'devdax' to match the ndctl namespace
> mode, or just 'device', but otherwise no "_" in any command-line
> interfaces. Otherwise I think the module names are an internal
> implementation detail of the kernel ABI and need not leak further than
> the libdaxctl to kernel interface.

The command line option is just 'devdax', but good catch in that I will
fix up this commit message.

> 
> > and 'system-ram', where device_dax is the normal device DAX mode used
> > via a character device, and 'system-ram' uses the kernel's 'kmem'
> > facility to hotplug the device into the system's memory space, and can
> > be used as normal system memory.
> > 
> > This adds the following new interfaces:
> > 
> >   daxctl_dev_disable;
> >   daxctl_dev_enable_devdax;
> >   daxctl_dev_enable_ram;
> > 
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
