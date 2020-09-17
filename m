Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0052526D687
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Sep 2020 10:28:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D5AC013E4E33E;
	Thu, 17 Sep 2020 01:28:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ACE0C13E4E33A
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 01:28:13 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 63CD3B264;
	Thu, 17 Sep 2020 08:28:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id A47C21E12E1; Thu, 17 Sep 2020 10:08:33 +0200 (CEST)
Date: Thu, 17 Sep 2020 10:08:33 +0200
From: Jan Kara <jack@suse.cz>
To: Mike Snitzer <snitzer@redhat.com>
Subject: Re: dm: Call proper helper to determine dax support
Message-ID: <20200917080833.GB9555@quack2.suse.cz>
References: <20200916151445.450-1-jack@suse.cz>
 <20200916152204.GA29829@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200916152204.GA29829@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: VWJHE7DIERBC46OZAZGNZB7EMYNP3LIW
X-Message-ID-Hash: VWJHE7DIERBC46OZAZGNZB7EMYNP3LIW
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, linux-nvdimm@lists.01.org, Adrian Huang <adrianhuang0701@gmail.com>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VWJHE7DIERBC46OZAZGNZB7EMYNP3LIW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed 16-09-20 11:22:05, Mike Snitzer wrote:
> On Wed, Sep 16 2020 at 11:14am -0400,
> Jan Kara <jack@suse.cz> wrote:
> 
> > DM was calling generic_fsdax_supported() to determine whether a device
> > referenced in the DM table supports DAX. However this is a helper for "leaf" device drivers so that
> > they don't have to duplicate common generic checks. High level code
> > should call dax_supported() helper which that calls into appropriate
> > helper for the particular device. This problem manifested itself as
> > kernel messages:
> > 
> > dm-3: error: dax access failed (-95)
> > 
> > when lvm2-testsuite run in cases where a DM device was stacked on top of
> > another DM device.
> > 
> > Fixes: 7bf7eac8d648 ("dax: Arrange for dax_supported check to span multiple devices")
> > Tested-by: Adrian Huang <ahuang12@lenovo.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Looked good:
> 
> Acked-by: Mike Snitzer <snitzer@redhat.com>

Thanks!

> This fix should Cc stable@ right?

Yes, it should go to stable.

> >  drivers/dax/super.c   |  4 ++++
> >  drivers/md/dm-table.c |  3 +--
> >  include/linux/dax.h   | 11 +++++++++--
> >  3 files changed, 14 insertions(+), 4 deletions(-)
> > 
> > This patch should go in together with Adrian's
> > https://lore.kernel.org/linux-nvdimm/20200916133923.31-1-adrianhuang0701@gmail.com
> 
> Sure, but there really isn't a dependency right?

Yes, it isn't a context or strict functional dependency. But without this
patch Adrian's patch just trades one set of warnings for another set of
warnings...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
