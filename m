Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B034BE358
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Sep 2019 19:25:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F4063202F8BA7;
	Wed, 25 Sep 2019 10:27:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id ED6ED202E2917
 for <linux-nvdimm@lists.01.org>; Wed, 25 Sep 2019 10:27:54 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 10:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; d="scan'208";a="196061069"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by FMSMGA003.fm.intel.com with ESMTP; 25 Sep 2019 10:25:37 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Sep 2019 10:25:37 -0700
Received: from crsmsx102.amr.corp.intel.com (172.18.63.137) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Sep 2019 10:25:36 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.249]) by
 CRSMSX102.amr.corp.intel.com ([169.254.2.63]) with mapi id 14.03.0439.000;
 Wed, 25 Sep 2019 11:25:34 -0600
From: "Weiny, Ira" <ira.weiny@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "Williams, Dan J"
 <dan.j.williams@intel.com>, "dan.carpenter@oracle.com"
 <dan.carpenter@oracle.com>
Subject: RE: [PATCH] libnvdimm/namespace: Fix a signedness bug in
 __holder_class_store()
Thread-Topic: [PATCH] libnvdimm/namespace: Fix a signedness bug in
 __holder_class_store()
Thread-Index: AQHVc5B5MqbPUorT3Ue1I+CXzfNkKKc9CYiA//+bscA=
Date: Wed, 25 Sep 2019 17:25:33 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E8991FB01@CRSMSX101.amr.corp.intel.com>
References: <20190925110008.GK3264@mwanda>
 <71808ca30f4e367931bf58fa3e1798371c2a5044.camel@intel.com>
In-Reply-To: <71808ca30f4e367931bf58fa3e1798371c2a5044.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmFhNjYyMTYtY2ZmNi00MDM4LTk1N2MtMDg4ZDViNTQ1ZTkzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSE1jWmRSMTVaQTZvNDJnNmhIRENGUndPa3RXSEZRMVVjTTBMZmZzd25qV2YwNTEycUJva3FndWlVYzdCMk4yUiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
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

> 
> On Wed, 2019-09-25 at 14:00 +0300, Dan Carpenter wrote:
> > The "ndns->claim_class" variable is an enum but in this case GCC will
> > treat it as an unsigned int so the error handling is never triggered.
> >
> > Fixes: 14e494542636 ("libnvdimm, btt: BTT updates for UEFI 2.7
> > format")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/nvdimm/namespace_devs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvdimm/namespace_devs.c
> > b/drivers/nvdimm/namespace_devs.c index cca0a3ba1d2c..669985527716
> > 100644
> > --- a/drivers/nvdimm/namespace_devs.c
> > +++ b/drivers/nvdimm/namespace_devs.c
> > @@ -1529,7 +1529,7 @@ static ssize_t __holder_class_store(struct device
> *dev, const char *buf)
> >  		return -EINVAL;
> >
> >  	/* btt_claim_class() could've returned an error */
> > -	if (ndns->claim_class < 0)
> > +	if ((int)ndns->claim_class < 0)
> >  		return ndns->claim_class;
> >
> >  	return 0;
> 
> Looks straightforward, and a good catch.
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

I'm not sure this is really a good fix.  This leaves ndns->claim_class set to an invalid value.  Is that ok?

Ira

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
