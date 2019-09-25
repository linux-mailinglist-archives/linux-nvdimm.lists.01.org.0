Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2634BE500
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Sep 2019 20:49:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 24E20202F8BB0;
	Wed, 25 Sep 2019 11:51:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 523E8202ECFB1
 for <linux-nvdimm@lists.01.org>; Wed, 25 Sep 2019 11:51:53 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 11:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,549,1559545200"; d="scan'208";a="389321014"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga005.fm.intel.com with ESMTP; 25 Sep 2019 11:49:39 -0700
Date: Wed, 25 Sep 2019 11:49:39 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH] bnvdimm/namsepace: Don't set claim_class on error
Message-ID: <20190925184939.GA11669@iweiny-DESK2.sc.intel.com>
References: <20190925181056.11097-1-ira.weiny@intel.com>
 <ff7ff4f5b4289d189a7c347591a5c35876ea804f.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ff7ff4f5b4289d189a7c347591a5c35876ea804f.camel@intel.com>
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
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/nvdimm/namespace_devs.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> One minor nit below, but otherwise it looks good to me:
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

Thanks...

> 
> > 
> > diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> > index 5b22cecefc99..a020c166e1e7 100644
> > --- a/drivers/nvdimm/namespace_devs.c
> > +++ b/drivers/nvdimm/namespace_devs.c
> > @@ -1510,16 +1510,19 @@ static ssize_t holder_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(holder);
> >  
> > -static ssize_t __holder_class_store(struct device *dev, const char *buf)
> > +static int __holder_class_store(struct device *dev, const char *buf)
> >  {
> >  	struct nd_namespace_common *ndns = to_ndns(dev);
> >  
> >  	if (dev->driver || ndns->claim)
> >  		return -EBUSY;
> >  
> > -	if (sysfs_streq(buf, "btt"))
> > -		ndns->claim_class = btt_claim_class(dev);
> > -	else if (sysfs_streq(buf, "pfn"))
> > +	if (sysfs_streq(buf, "btt")) {
> > +		int rc = btt_claim_class(dev);
> 
> Need a blank line here separating variable declarations and code.

<sigh> yea I know better...  ;-)

V2 sent...

Thanks,
Ira

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
