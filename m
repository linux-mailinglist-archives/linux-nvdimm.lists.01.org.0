Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33817BE3C0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Sep 2019 19:49:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A878202F8BA8;
	Wed, 25 Sep 2019 10:51:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6819E202EA40A
 for <linux-nvdimm@lists.01.org>; Wed, 25 Sep 2019 10:51:23 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 10:49:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; d="scan'208";a="188843951"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga008.fm.intel.com with ESMTP; 25 Sep 2019 10:49:10 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Sep 2019 10:49:09 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.68]) by
 fmsmsx163.amr.corp.intel.com ([169.254.6.229]) with mapi id 14.03.0439.000;
 Wed, 25 Sep 2019 10:49:09 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "dan.carpenter@oracle.com"
 <dan.carpenter@oracle.com>, "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH] libnvdimm/namespace: Fix a signedness bug in
 __holder_class_store()
Thread-Topic: [PATCH] libnvdimm/namespace: Fix a signedness bug in
 __holder_class_store()
Thread-Index: AQHVc5B5rM1ZYUSIHUSOStf/1XoAG6c9GkyAgAAAZICAAAaWgA==
Date: Wed, 25 Sep 2019 17:49:08 +0000
Message-ID: <c4a097f38fb4a51c9bca183bf72b356f00826c10.camel@intel.com>
References: <20190925110008.GK3264@mwanda>
 <71808ca30f4e367931bf58fa3e1798371c2a5044.camel@intel.com>
 <2807E5FD2F6FDA4886F6618EAC48510E8991FB01@CRSMSX101.amr.corp.intel.com>
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E8991FB01@CRSMSX101.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <82D51A1FF533B84288B2B0655C7F884C@intel.com>
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
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, 2019-09-25 at 11:25 -0600, Weiny, Ira wrote:
> > On Wed, 2019-09-25 at 14:00 +0300, Dan Carpenter wrote:
> > > The "ndns->claim_class" variable is an enum but in this case GCC will
> > > treat it as an unsigned int so the error handling is never triggered.
> > > 
> > > Fixes: 14e494542636 ("libnvdimm, btt: BTT updates for UEFI 2.7
> > > format")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >  drivers/nvdimm/namespace_devs.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/nvdimm/namespace_devs.c
> > > b/drivers/nvdimm/namespace_devs.c index cca0a3ba1d2c..669985527716
> > > 100644
> > > --- a/drivers/nvdimm/namespace_devs.c
> > > +++ b/drivers/nvdimm/namespace_devs.c
> > > @@ -1529,7 +1529,7 @@ static ssize_t __holder_class_store(struct device
> > *dev, const char *buf)
> > >  		return -EINVAL;
> > > 
> > >  	/* btt_claim_class() could've returned an error */
> > > -	if (ndns->claim_class < 0)
> > > +	if ((int)ndns->claim_class < 0)
> > >  		return ndns->claim_class;
> > > 
> > >  	return 0;
> > 
> > Looks straightforward, and a good catch.
> > Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> 
> I'm not sure this is really a good fix.  This leaves ndns->claim_class set to an invalid value.  Is that ok?
> 

Hm, it is just in a store operation for the holder_class sysfs
attribute. if claim_class was negative, that store will just fail.

From the userspace side, this means the 'mode' enforcement API will
fail. Typically, 'ndctl' doesn't require the enforcement to succeed,
since we can disambiguate namespaces even without it, so it doesn't
block namespace creation etc.

On the kernel side, claim_class gets used by btt_devs.c during probe,
and looks like this case, as it currently stands, would fail the BTT
probe (nd_btt_probe()). I think this is what we want?

I guess it can be made a bit clearer by storing NVDIMM_CCLASS_UNKNOWN
explicitly in holder_class_store(), but that can be a separate
improvement from what this patch is addressing.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
