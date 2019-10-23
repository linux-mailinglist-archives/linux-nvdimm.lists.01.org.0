Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 417B9E2661
	for <lists+linux-nvdimm@lfdr.de>; Thu, 24 Oct 2019 00:28:54 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C2E4C100EEB8F;
	Wed, 23 Oct 2019 15:30:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2577B100EEB8E
	for <linux-nvdimm@lists.01.org>; Wed, 23 Oct 2019 15:30:16 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 15:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400";
   d="scan'208";a="349526722"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2019 15:28:48 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 23 Oct 2019 15:28:48 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 fmsmsx124.amr.corp.intel.com ([169.254.8.139]) with mapi id 14.03.0439.000;
 Wed, 23 Oct 2019 15:28:48 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "jmoyer@redhat.com" <jmoyer@redhat.com>, "Weiny, Ira"
	<ira.weiny@intel.com>
Subject: Re: [ndctl patch 3/4] query_fw_finish_status: get rid of redundant
 variable
Thread-Topic: [ndctl patch 3/4] query_fw_finish_status: get rid of redundant
 variable
Thread-Index: AQHVhffdKVQAtmMLOEqII07S9c0vNKdpS+GA
Date: Wed, 23 Oct 2019 22:28:47 +0000
Message-ID: <49b7cb5dae88ada6945b15eb1cf2e5e798173861.camel@intel.com>
References: <20191018202302.8122-1-jmoyer@redhat.com>
	 <20191018202302.8122-4-jmoyer@redhat.com>
	 <20191018205424.GA12760@iweiny-DESK2.sc.intel.com>
	 <x49sgnp7ohp.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49sgnp7ohp.fsf@segfault.boston.devel.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <90DF87AE7696394C8DDF96FAC29448FC@intel.com>
MIME-Version: 1.0
Message-ID-Hash: XHSEBFTLUARX2PCYYBEM2WJEC7N55GQP
X-Message-ID-Hash: XHSEBFTLUARX2PCYYBEM2WJEC7N55GQP
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XHSEBFTLUARX2PCYYBEM2WJEC7N55GQP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2019-10-18 at 17:06 -0400, Jeff Moyer wrote:
> Ira Weiny <ira.weiny@intel.com> writes:
> > On Fri, Oct 18, 2019 at 04:23:01PM -0400, Jeff Moyer wrote:
> > > The 'done' variable only adds confusion.
> > > 
> > > Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> > > ---
> > >  ndctl/dimm.c | 7 +------
> > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > > 
> > > diff --git a/ndctl/dimm.c b/ndctl/dimm.c
> > > index c8821d6..f28b9c1 100644
> > > --- a/ndctl/dimm.c
> > > +++ b/ndctl/dimm.c
> > > @@ -682,7 +682,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
> > >  	struct ndctl_cmd *cmd;
> > >  	int rc;
> > >  	enum ND_FW_STATUS status;
> > > -	bool done = false;
> > >  	struct timespec now, before, after;
> > >  	uint64_t ver;
> > >  
> > > @@ -716,7 +715,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
> > >  					ndctl_dimm_get_devname(dimm));
> > >  			printf("Firmware version %#lx.\n", ver);
> > >  			printf("Cold reboot to activate.\n");
> > > -			done = true;
> > >  			rc = 0;
> > 
> > Do we need "goto out" here?
> 
> Yes, I missed that one.  Thanks.

This actually looks fine, since there is a 'break' down below.

> 
> > >  			break;
> > >  		case FW_EBUSY:

[..]

> > > -	} while (!done);
> > > +	} while (true);
> > 
> > I'm not a fan of "while (true)".  But I'm not the maintainer.  The Logic seems
> > fine otherwise.
> 
> The way things stand today is a mashup of goto vs. break.  I'll
> follow-up with fixed up patch next week if there is consensus on the
> change.  If you have a suggestion for a better way, that's welcome as
> well.
> 
I've applied this as is for v67, we can look at a refactoring for the
while (true) later.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
