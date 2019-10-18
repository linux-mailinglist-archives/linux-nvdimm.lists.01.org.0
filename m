Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D63DD511
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Oct 2019 00:49:24 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 648B81007B9B6;
	Fri, 18 Oct 2019 15:51:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 64C951007B9B5
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 15:51:24 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 15:49:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,313,1566889200";
   d="scan'208";a="190502863"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2019 15:49:19 -0700
Date: Fri, 18 Oct 2019 15:49:18 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [ndctl patch 3/4] query_fw_finish_status: get rid of redundant
 variable
Message-ID: <20191018224918.GB12995@iweiny-DESK2.sc.intel.com>
References: <20191018202302.8122-1-jmoyer@redhat.com>
 <20191018202302.8122-4-jmoyer@redhat.com>
 <20191018205424.GA12760@iweiny-DESK2.sc.intel.com>
 <x49sgnp7ohp.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <x49sgnp7ohp.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: LNV6EWKNDYYB42KWBGEFPFC6QJA4VCS6
X-Message-ID-Hash: LNV6EWKNDYYB42KWBGEFPFC6QJA4VCS6
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LNV6EWKNDYYB42KWBGEFPFC6QJA4VCS6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 18, 2019 at 05:06:10PM -0400, Jeff Moyer wrote:
> Ira Weiny <ira.weiny@intel.com> writes:
> 
> > On Fri, Oct 18, 2019 at 04:23:01PM -0400, Jeff Moyer wrote:
> >> The 'done' variable only adds confusion.
> >> 
> >>  			goto out;
> >>  		}
> >> -	} while (!done);
> >> +	} while (true);
> >
> > I'm not a fan of "while (true)".  But I'm not the maintainer.  The Logic seems
> > fine otherwise.
> 
> The way things stand today is a mashup of goto vs. break.  I'll
> follow-up with fixed up patch next week if there is consensus on the
> change.  If you have a suggestion for a better way, that's welcome as
> well.

Yea that is the reason I did not object strongly.  I don't have a good idea of
how to clean the loop up without a pretty big refactoring.  Which I'm not
prepared to do.  :-/  So if Vishal is ok with it, I am.

Ira

> 
> Thanks for looking, Ira!
> 
> -Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
