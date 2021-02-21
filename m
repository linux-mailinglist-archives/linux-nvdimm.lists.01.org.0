Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C48232082F
	for <lists+linux-nvdimm@lfdr.de>; Sun, 21 Feb 2021 04:47:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B85F100EBBB3;
	Sat, 20 Feb 2021 19:47:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9CA0F100EC1CC
	for <linux-nvdimm@lists.01.org>; Sat, 20 Feb 2021 19:47:05 -0800 (PST)
IronPort-SDR: UVhKQZzctThx99DRfAjwBfAj2Sa2nJfvowvhtH3ZlluZhlDlTv5TVXTt1hnrR9QowdWyzmtE1E
 zdFRwq3YoSJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9901"; a="171841109"
X-IronPort-AV: E=Sophos;i="5.81,194,1610438400";
   d="scan'208";a="171841109"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 19:47:04 -0800
IronPort-SDR: NQUZQkOffegfvlmDz8DEVmZW4xAEpO3VT8A2fC1d1RnTxw/3Uhz8BRmbKTzn4aqLt6gOAe8Fpn
 QX9TYuwfddDg==
X-IronPort-AV: E=Sophos;i="5.81,194,1610438400";
   d="scan'208";a="401826933"
Received: from aevangel-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 19:47:04 -0800
Date: Sat, 20 Feb 2021 19:47:03 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/mem: Fixes to IOCTL interface
Message-ID: <20210221034703.ncetonon7iseqd72@intel.com>
References: <20210220215641.604535-1-ben.widawsky@intel.com>
 <CAPcyv4gfoe=QGuKV19ay51D-cqzRqTMLpD-p5whnJbYkKoGtBA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gfoe=QGuKV19ay51D-cqzRqTMLpD-p5whnJbYkKoGtBA@mail.gmail.com>
Message-ID-Hash: B76ZCNBQVSMQD2EQJTPGOKJF2MTQW7GP
X-Message-ID-Hash: B76ZCNBQVSMQD2EQJTPGOKJF2MTQW7GP
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, Alison Schofield <alison.schofield@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B76ZCNBQVSMQD2EQJTPGOKJF2MTQW7GP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21-02-20 18:38:36, Dan Williams wrote:
> On Sat, Feb 20, 2021 at 1:57 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > When submitting a command for userspace, input and output payload bounce
> > buffers are allocated. For a given command, both input and output
> > buffers may exist and so when allocation of the input buffer fails, the
> > output buffer must be freed. As far as I can tell, userspace can't
> > easily exploit the leak to OOM a machine unless the machine was already
> > near OOM state.
> >
> > This bug was introduced in v5 of the patch and did not exist in prior
> > revisions.
> >
> 
> Thanks for the quick turnaround, but I think that speed introduced
> some issues...
> 
> > While here, adjust the variable 'j' found in patch review by Konrad.
> 
> Please split this pure cleanup to its own patch. The subject says
> "Fixes", but it's only the one fix.
> 

This was intentional. I pinged you internally to just drop it if you don't like
to combine these kind of things. It didn't feel worthwhile to introduce a new
patch to change the 'j'. I agree with Konrad that 'j' is not the best variable
name to use. Konrad, maybe you'd like to send a fixup for that one?

I will drop this hunk.

> >
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Reported-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> Since the commit is upstream add a "Fixes" line:
> 
> Fixes: 583fa5e71cae ('cxl/mem: Add basic IOCTL interface")
> 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Jonathan and I didn't pre-review this.

My bad on this. It was a mistake that I pulled the info from the original patch
I was fixing.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
