Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4C715D4E2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Feb 2020 10:42:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 062DD10FC33EC;
	Fri, 14 Feb 2020 01:45:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CC34D10FC33EA
	for <linux-nvdimm@lists.01.org>; Fri, 14 Feb 2020 01:45:26 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 00004ACC6;
	Fri, 14 Feb 2020 09:42:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 7AD7D1E0D3F; Thu, 13 Feb 2020 21:58:43 +0100 (CET)
Date: Thu, 13 Feb 2020 21:58:43 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] tools/testing/nvdimm: Fix compilation failure without
 CONFIG_DEV_DAX_PMEM_COMPAT
Message-ID: <20200213205843.GA6600@quack2.suse.cz>
References: <20200123154720.12097-1-jack@suse.cz>
 <x498sl73nsc.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4jKKfWCNHtxQDYcKV_6hMXWrATkppQ4v=4E0teOmT8+mg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4jKKfWCNHtxQDYcKV_6hMXWrATkppQ4v=4E0teOmT8+mg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: B2FI7R7QG5FVHDFKTBW5XDOELNFE777Y
X-Message-ID-Hash: B2FI7R7QG5FVHDFKTBW5XDOELNFE777Y
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B2FI7R7QG5FVHDFKTBW5XDOELNFE777Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed 12-02-20 12:49:41, Dan Williams wrote:
> On Wed, Feb 12, 2020 at 6:04 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >
> > Jan Kara <jack@suse.cz> writes:
> >
> > > When a kernel is configured without CONFIG_DEV_DAX_PMEM_COMPAT, the
> > > compilation of tools/testing/nvdimm fails with:
> > >
> > >   Building modules, stage 2.
> > >   MODPOST 11 modules
> > > ERROR: "dax_pmem_compat_test" [tools/testing/nvdimm/test/nfit_test.ko] undefined!
> > >
> > > Fix the problem by calling dax_pmem_compat_test() only if the kernel has
> > > the required functionality.
> > >
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> >
> > What's the motivation?  Is this just to fix randconfig builds?  The
> > reason I ask is that the test suite will expect to be able to find the
> > dax_pmem_compat module, so it doesn't make sense to me to disable those
> > tests only in the kernel as you'll hit a problem when running the tests
> > anyway.
> 
> Yeah, at a minimum you'd also need to go fix up nfit_test_init() to
> not check for the dax_pmem_compat module:
> 
> https://github.com/pmem/ndctl/blob/master/test/core.c#L119

OK.

> > But, I understand if you want to prevent build bots from hitting
> > compilation failures due to this.
> 
> Hmm, build bots would only hit what's covered by
> CONFIG_NVDIMM_TEST_BUILD, and that's only building
> tools/testing/nvdimm/test/iomap.c.
> 
> Jan, were you just looking to use nfit_test outside of running the
> ndctl test suites? Or was this just a drive-by compilation test?

The problem is following: We build our distro kernels without
CONFIG_DEV_DAX_PMEM_COMPAT because we don't need that functionality. And
Jing Han (from Intel ;) is now complaining that he cannot compile and run
the ndctl testsuite on our kernels... It seems stupid to enable that config
option for all distro users just to be able to run the testsuite but OTOH
it would be neat to be able to run the testsuite with stock distro
config.

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
