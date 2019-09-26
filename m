Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C60F3BF764
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Sep 2019 19:15:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2C9E121967BC5;
	Thu, 26 Sep 2019 10:17:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2A2132010BCBC
 for <linux-nvdimm@lists.01.org>; Thu, 26 Sep 2019 10:17:14 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 10:15:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; d="scan'208";a="389688203"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2019 10:15:07 -0700
Date: Thu, 26 Sep 2019 10:15:08 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH V3] libnvdimm/namsepace: Don't set claim_class on error
Message-ID: <20190926171507.GA26275@iweiny-DESK2.sc.intel.com>
References: <20190925211348.14082-1-ira.weiny@intel.com>
 <20190926061257.GE29696@kadam>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190926061257.GE29696@kadam>
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
Cc: linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Sep 26, 2019 at 09:12:57AM +0300, Dan Carpenter wrote:
> On Wed, Sep 25, 2019 at 02:13:48PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Don't leave claim_class set to an invalid value if an error occurs in
> > btt_claim_class().
> > 
> > While we are here change the return type of __holder_class_store() to be
> > clear about the values it is returning.
> > 
> > This was found via code inspection.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > V1->V2
> > 	Add space after variable declaration...
> > 
> > V2->V3
> > 	Fix oneliner
> > 	Rebase without Dan Carpenter's patch and give him Reported-by
> > 		credit
> 
> Thanks!  Btw, if it's ever a question of "do you want to redo a patch or
> just transfer to reported by credit?" then always I always want the #2
> option.  It would have taken me several iterations to generate the patch
> you wanted.

Thanks for letting me know!

And thanks for finding this as well.  :-D

Ira

> 
> regards,
> dan carpenter
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
