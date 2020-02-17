Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA79B160CB8
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Feb 2020 09:16:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 09C2310FC336D;
	Mon, 17 Feb 2020 00:20:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 151C510FC319F
	for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 00:20:13 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 5ABEDBA1B;
	Mon, 17 Feb 2020 08:16:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id B73FB1E0D47; Mon, 17 Feb 2020 09:16:54 +0100 (CET)
Date: Mon, 17 Feb 2020 09:16:54 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] tools/testing/nvdimm: Fix compilation failure without
 CONFIG_DEV_DAX_PMEM_COMPAT
Message-ID: <20200217081654.GA12032@quack2.suse.cz>
References: <20200123154720.12097-1-jack@suse.cz>
 <x498sl73nsc.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4jKKfWCNHtxQDYcKV_6hMXWrATkppQ4v=4E0teOmT8+mg@mail.gmail.com>
 <20200213205843.GA6600@quack2.suse.cz>
 <CAPcyv4g7kPtuZ4Cix_4eTVX6p-oK3BsNkCkLmn1h=yhcrMYJ8A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4g7kPtuZ4Cix_4eTVX6p-oK3BsNkCkLmn1h=yhcrMYJ8A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: CLMZMO7GKNJCEN3IJCIDYDFN42I2E4SL
X-Message-ID-Hash: CLMZMO7GKNJCEN3IJCIDYDFN42I2E4SL
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CLMZMO7GKNJCEN3IJCIDYDFN42I2E4SL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri 14-02-20 08:13:59, Dan Williams wrote:
> On Fri, Feb 14, 2020 at 1:42 AM Jan Kara <jack@suse.cz> wrote:
> > > > But, I understand if you want to prevent build bots from hitting
> > > > compilation failures due to this.
> > >
> > > Hmm, build bots would only hit what's covered by
> > > CONFIG_NVDIMM_TEST_BUILD, and that's only building
> > > tools/testing/nvdimm/test/iomap.c.
> > >
> > > Jan, were you just looking to use nfit_test outside of running the
> > > ndctl test suites? Or was this just a drive-by compilation test?
> >
> > The problem is following: We build our distro kernels without
> > CONFIG_DEV_DAX_PMEM_COMPAT because we don't need that functionality. And
> > Jing Han (from Intel ;) is now complaining that he cannot compile and run
> > the ndctl testsuite on our kernels... It seems stupid to enable that config
> > option for all distro users just to be able to run the testsuite but OTOH
> > it would be neat to be able to run the testsuite with stock distro
> > config.
> 
> Sounds good, minus the fact that Jing and I were not on the same page.
> I'll send the ndctl fixup.

Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
