Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 921B72E32C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 May 2019 19:25:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A5BE2128D888;
	Wed, 29 May 2019 10:25:26 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B617D21276B97
 for <linux-nvdimm@lists.01.org>; Wed, 29 May 2019 10:25:24 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 May 2019 10:25:23 -0700
X-ExtLoop1: 1
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga001.fm.intel.com with ESMTP; 29 May 2019 10:25:23 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.118]) by
 FMSMSX106.amr.corp.intel.com ([169.254.5.141]) with mapi id 14.03.0415.000;
 Wed, 29 May 2019 10:25:23 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v4 02/10] libdaxctl: cache 'subsystem' in daxctl_ctx
Thread-Topic: [ndctl PATCH v4 02/10] libdaxctl: cache 'subsystem' in daxctl_ctx
Thread-Index: AQHVFaQmdZa7lMTe6Ui4i4g71pQjZaaBtIyAgAEcgQA=
Date: Wed, 29 May 2019 17:25:23 +0000
Message-ID: <8bd400d85de8e4edf151b74c1fc5b857954ea37b.camel@intel.com>
References: <20190528222440.30392-1-vishal.l.verma@intel.com>
 <20190528222440.30392-3-vishal.l.verma@intel.com>
 <CAPcyv4heAvTzOePSe=uJ_+p4gOqG9d9Eqec_nA21P8KzzXS+kw@mail.gmail.com>
In-Reply-To: <CAPcyv4heAvTzOePSe=uJ_+p4gOqG9d9Eqec_nA21P8KzzXS+kw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <9511843EF9A92C47A82DEDDA7EDBF15A@intel.com>
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

On Tue, 2019-05-28 at 17:27 -0700, Dan Williams wrote:
> On Tue, May 28, 2019 at 3:24 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
> > The 'DAX subsystem' in effect is determined at region or device init
> > time, and dictates the sysfs base paths for all device/region
> > operations. In preparation for adding bind/unbind functionality, cache
> > the subsystem as determined at init time in the library context.
> 
> I'm missing how this patch determines the subsystem at init time? ...more below.
> 
[..]

> >  }
> > @@ -454,14 +456,18 @@ static void dax_devices_init(struct daxctl_region *region)
> >         for (i = 0; i < ARRAY_SIZE(dax_subsystems); i++) {
> >                 char *region_path;
> > 
> > -               if (i == DAX_BUS)
> > +               if (i == DAX_BUS) {
> >                         region_path = region->region_path;
> > -               else if (i == DAX_CLASS) {
> > +                       if (ctx->subsys == DAX_UNKNOWN)
> > +                               ctx->subsys = DAX_BUS;
> > +               } else if (i == DAX_CLASS) {
> >                         if (asprintf(&region_path, "%s/dax",
> >                                                 region->region_path) < 0) {
> >                                 dbg(ctx, "region path alloc fail\n");
> >                                 continue;
> >                         }
> > +                       if (ctx->subsys == DAX_UNKNOWN)
> > +                               ctx->subsys = DAX_CLASS;
> >                 } else
> >                         continue;
> >                 sysfs_device_parse(ctx, region_path, daxdev_fmt, region,
> 
> dax_devices_init() is just blindly looping through both device models
> attempting to add devices. If this patch was detecting device-models I
> would expect it would be looking for the first successful
> sysfs_device_parse() to judge which of those blind shots actually
> worked.

I see - I was definitely misunderstanding how this worked. I'll fix up
for v5, essentially something like:

-               sysfs_device_parse(ctx, region_path, daxdev_fmt, region,
-                               add_dax_dev);
+               if (sysfs_device_parse(ctx, region_path, daxdev_fmt, region,
+                               add_dax_dev) == 0)
+                       ctx->subsys = i;



_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
