Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBC9BE464
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Sep 2019 20:11:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 46017202F8BAB;
	Wed, 25 Sep 2019 11:13:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B1418202ECFA6
 for <linux-nvdimm@lists.01.org>; Wed, 25 Sep 2019 11:13:42 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 11:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; d="scan'208";a="273046921"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga001.jf.intel.com with ESMTP; 25 Sep 2019 11:11:28 -0700
Date: Wed, 25 Sep 2019 11:11:28 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH] libnvdimm/namespace: Fix a signedness bug in
 __holder_class_store()
Message-ID: <20190925181127.GA6721@iweiny-DESK2.sc.intel.com>
References: <20190925110008.GK3264@mwanda>
 <71808ca30f4e367931bf58fa3e1798371c2a5044.camel@intel.com>
 <2807E5FD2F6FDA4886F6618EAC48510E8991FB01@CRSMSX101.amr.corp.intel.com>
 <c4a097f38fb4a51c9bca183bf72b356f00826c10.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c4a097f38fb4a51c9bca183bf72b356f00826c10.camel@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Sep 25, 2019 at 10:49:08AM -0700, 'Vishal Verma' wrote:
> On Wed, 2019-09-25 at 11:25 -0600, Weiny, Ira wrote:
> > > On Wed, 2019-09-25 at 14:00 +0300, Dan Carpenter wrote:
> > > > The "ndns->claim_class" variable is an enum but in this case GCC will
> > > > treat it as an unsigned int so the error handling is never triggered.
> > > > 
> > > > Fixes: 14e494542636 ("libnvdimm, btt: BTT updates for UEFI 2.7
> > > > format")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > ---
> > > >  drivers/nvdimm/namespace_devs.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/nvdimm/namespace_devs.c
> > > > b/drivers/nvdimm/namespace_devs.c index cca0a3ba1d2c..669985527716
> > > > 100644
> > > > --- a/drivers/nvdimm/namespace_devs.c
> > > > +++ b/drivers/nvdimm/namespace_devs.c
> > > > @@ -1529,7 +1529,7 @@ static ssize_t __holder_class_store(struct device
> > > *dev, const char *buf)
> > > >  		return -EINVAL;
> > > > 
> > > >  	/* btt_claim_class() could've returned an error */
> > > > -	if (ndns->claim_class < 0)
> > > > +	if ((int)ndns->claim_class < 0)
> > > >  		return ndns->claim_class;
> > > > 
> > > >  	return 0;
> > > 
> > > Looks straightforward, and a good catch.
> > > Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> > 
> > I'm not sure this is really a good fix.  This leaves ndns->claim_class set to an invalid value.  Is that ok?
> > 
> 
> Hm, it is just in a store operation for the holder_class sysfs
> attribute. if claim_class was negative, that store will just fail.
> 
> From the userspace side, this means the 'mode' enforcement API will
> fail. Typically, 'ndctl' doesn't require the enforcement to succeed,
> since we can disambiguate namespaces even without it, so it doesn't
> block namespace creation etc.
> 
> On the kernel side, claim_class gets used by btt_devs.c during probe,
> and looks like this case, as it currently stands, would fail the BTT
> probe (nd_btt_probe()). I think this is what we want?
> 
> I guess it can be made a bit clearer by storing NVDIMM_CCLASS_UNKNOWN
> explicitly in holder_class_store(), but that can be a separate
> improvement from what this patch is addressing.

Fair enough I've sent a follow on patch.

Thanks,
Ira

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
