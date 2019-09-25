Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03810BE6F1
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Sep 2019 23:15:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5AB2321967BC5;
	Wed, 25 Sep 2019 14:17:35 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E4DE4200C6C8B
 for <linux-nvdimm@lists.01.org>; Wed, 25 Sep 2019 14:17:33 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 14:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,549,1559545200"; d="scan'208";a="193907300"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga006.jf.intel.com with ESMTP; 25 Sep 2019 14:15:20 -0700
Date: Wed, 25 Sep 2019 14:15:20 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH V2] bnvdimm/namsepace: Don't set claim_class on error
Message-ID: <20190925211520.GA12748@iweiny-DESK2.sc.intel.com>
References: <20190925184852.11707-1-ira.weiny@intel.com>
 <CAPcyv4jtYxggf-+ZvO5PN3KTMjiqqJrpj_V39_9axJZNpG_EQg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jtYxggf-+ZvO5PN3KTMjiqqJrpj_V39_9axJZNpG_EQg@mail.gmail.com>
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
Cc: kernel-janitors@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Sep 25, 2019 at 12:36:35PM -0700, Dan Williams wrote:
> On Wed, Sep 25, 2019 at 11:49 AM <ira.weiny@intel.com> wrote:
> >

[snip]

> >
> > ---
> > V1->V2
> >         Add space after variable declaration...
> 
> Oh, was also hoping this would address s/bnvdimm/libnvdimm/ in the
> patch subject.

Yea...

> 
> Note, kernel-janitors is for minor spelling fixes and trivial changes
> with no runtime side-effects that might otherwise fall through the
> cracks. This has functional implications so is not a janitorial
> change.

Ah yea I just thought it was ok to let that list know what was going on...
I've removed them from V3.  Sorry.

> 
> One more comment below...
> 

[snip]

> > -
> 
> Since this effectively replaces Dan's patch can you respin without
> that baseline, and just give Dan credit with a Reported-by?

V3 sent.

Ira

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
