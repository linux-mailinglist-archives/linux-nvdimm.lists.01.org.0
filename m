Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F28CA145
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Oct 2019 17:41:38 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B66D100DC423;
	Thu,  3 Oct 2019 08:42:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 09249100DC422
	for <linux-nvdimm@lists.01.org>; Thu,  3 Oct 2019 08:42:45 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 08:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,252,1566889200";
   d="scan'208";a="198560163"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Oct 2019 08:41:33 -0700
Date: Thu, 3 Oct 2019 08:41:33 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [ndctl PATCH] libdaxctl: fix memory leaks with daxctl_memory
 objects
Message-ID: <20191003154132.GA31174@iweiny-DESK2.sc.intel.com>
References: <20191001173726.21846-1-vishal.l.verma@intel.com>
 <20191001231909.GA11607@iweiny-DESK2.sc.intel.com>
 <796dc27db614dfd931b2568162f5f885195ba408.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <796dc27db614dfd931b2568162f5f885195ba408.camel@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: OYJGPSLLZ4ZB7BPS3FGXCFHEEXQHLIGX
X-Message-ID-Hash: OYJGPSLLZ4ZB7BPS3FGXCFHEEXQHLIGX
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Biesek, Michal" <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OYJGPSLLZ4ZB7BPS3FGXCFHEEXQHLIGX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 02, 2019 at 05:01:24PM -0700, 'Vishal Verma' wrote:
> On Tue, 2019-10-01 at 16:19 -0700, Ira Weiny wrote:
> > 
> > > diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
> > > index 8abfd64..639224c 100644
> > > --- a/daxctl/lib/libdaxctl.c
> > > +++ b/daxctl/lib/libdaxctl.c
> > > @@ -204,8 +204,9 @@ DAXCTL_EXPORT void daxctl_region_get_uuid(struct daxctl_region *region, uuid_t u
> > >  
> > >  static void free_mem(struct daxctl_dev *dev)
> > >  {
> > > -	if (dev && dev->mem) {
> > > +	if (dev->mem) {
> > 
> > There is a comment in daxctl_dev_disable() which says:
> > 
> >         /* If there is a memory object, first free that */
> > 
> > I'm 100% sure that dev can't be NULL there.  So that comment no longer applies.
> > 
> > May want to remove that comment.
> > 
> Hm, I'm not sure I follow.
> 
> Yes, dev can't be null there, but 'mem' can me. Hence the comment saying
> if /mem/ is present, free it.
> 
> The check in free_mem() only checks for non-NULL mem too.

Ah yea ok.  Sorry
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
