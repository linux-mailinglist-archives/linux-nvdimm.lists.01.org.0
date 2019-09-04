Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA03A93B1
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Sep 2019 22:27:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5D16D20260CE5;
	Wed,  4 Sep 2019 13:28:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CAE6C20216B8B
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 13:28:13 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 13:27:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,468,1559545200"; d="scan'208";a="190278561"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by FMSMGA003.fm.intel.com with ESMTP; 04 Sep 2019 13:27:08 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 4 Sep 2019 13:27:08 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 FMSMSX109.amr.corp.intel.com ([169.254.15.42]) with mapi id 14.03.0439.000;
 Wed, 4 Sep 2019 13:27:07 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH 2/2] libdaxctl: fix device reconfiguration with
 builtin drivers
Thread-Topic: [ndctl PATCH 2/2] libdaxctl: fix device reconfiguration with
 builtin drivers
Thread-Index: AQHVYr1QvsvbA51m90uXy4ZXOZ4cwacbPpeAgAEvhYA=
Date: Wed, 4 Sep 2019 20:27:07 +0000
Message-ID: <be47815b3d454ce76a81799ba355b5579713c916.camel@intel.com>
References: <20190904010819.11012-1-vishal.l.verma@intel.com>
 <20190904010819.11012-2-vishal.l.verma@intel.com>
 <CAPcyv4ipdLhKSUVZ-U3ZFpcuw=tJJTq1ZW5x6vJ-bJNReyjJbQ@mail.gmail.com>
In-Reply-To: <CAPcyv4ipdLhKSUVZ-U3ZFpcuw=tJJTq1ZW5x6vJ-bJNReyjJbQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <659598B110F2684398092EAA311BD800@intel.com>
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
Cc: "Brice.Goglin@inria.fr" <Brice.Goglin@inria.fr>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, 2019-09-03 at 19:20 -0700, Dan Williams wrote:
> 
> > +static int try_kmod_builtin(struct daxctl_dev *dev, const char *mod_name)
> > +{
> > +       const char *devname = daxctl_dev_get_devname(dev);
> > +       struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
> > +       struct kmod_module *kmod;
> > +       int rc = -ENXIO;
> > +
> > +       rc = kmod_module_new_from_name(ctx->kmod_ctx, mod_name, &kmod);
> > +       if (rc < 0) {
> > +               err(ctx, "%s: failed getting module for: %s: %s\n",
> > +                       devname, mod_name, strerror(-rc));
> > +               return rc;
> > +       }
> > +
> > +       if (kmod_module_get_initstate(kmod) != KMOD_MODULE_BUILTIN)
> > +               return -ENXIO;
> > +
> > +       dbg(ctx, "%s inserting module: %s\n", devname,
> > +               kmod_module_get_name(kmod));
> > +       rc = kmod_module_probe_insert_module(kmod,
> > +                       KMOD_PROBE_APPLY_BLACKLIST,
> > +                       NULL, NULL, NULL, NULL);
> > +       if (rc < 0) {
> > +               err(ctx, "%s: insert failure: %d\n", devname, rc);
> > +               return rc;
> > +       }
> > +       dev->module = kmod;
> > +
> > +       return 0;
> > +}
> > +
> >  static int daxctl_insert_kmod_for_mode(struct daxctl_dev *dev,
> >                 const char *mod_name)
> >  {
> > @@ -877,6 +908,8 @@ static int daxctl_insert_kmod_for_mode(struct daxctl_dev *dev,
> >         int rc = -ENXIO;
> > 
> >         if (dev->kmod_list == NULL) {
> 
> Hmm, why wait until now to check if this list is NULL. How about fall
> back to kmod_module_new_from_name() at to_module_list() time? That
> would seem to simplify this follow up routine to not need to worry
> about working around a NULL list.

So we moved the list checking to later in the process around v4 of the
original series, so that we don't unnecessarily fail add_dax_dev() if
for some reason a list wasn't created.

Also, we use mod_name = dax_modules[mode] during an 'enable' to
determine the module name to use for the fallback - we wouldn't have
this at add_dax_dev() time.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
