Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCBB286165
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Oct 2020 16:41:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A06261568D65B;
	Wed,  7 Oct 2020 07:41:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=18.9.28.11; helo=outgoing.mit.edu; envelope-from=tytso@mit.edu; receiver=<UNKNOWN> 
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F3F971568D659
	for <linux-nvdimm@lists.01.org>; Wed,  7 Oct 2020 07:41:36 -0700 (PDT)
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 097EfEdZ005736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Oct 2020 10:41:15 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
	id 3E8A6420107; Wed,  7 Oct 2020 10:41:14 -0400 (EDT)
Date: Wed, 7 Oct 2020 10:41:14 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] ext4/xfs: add page refcount helper
Message-ID: <20201007144114.GB235506@mit.edu>
References: <20201006230930.3908-1-rcampbell@nvidia.com>
 <CAPcyv4gYtCmzPOWErYOkCCfD0ZvLcrgfR8n2kG3QPMww9B0gyg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gYtCmzPOWErYOkCCfD0ZvLcrgfR8n2kG3QPMww9B0gyg@mail.gmail.com>
Message-ID-Hash: WGOYG3RKMOPZ6TIXJJDRZUFNFFKYT4CO
X-Message-ID-Hash: WGOYG3RKMOPZ6TIXJJDRZUFNFFKYT4CO
X-MailFrom: tytso@mit.edu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ralph Campbell <rcampbell@nvidia.com>, Linux MM <linux-mm@kvack.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Andreas Dilger <adilger.kernel@dilger.ca>, "Darrick J. Wong" <darrick.wong@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WGOYG3RKMOPZ6TIXJJDRZUFNFFKYT4CO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 06, 2020 at 07:40:05PM -0700, Dan Williams wrote:
> On Tue, Oct 6, 2020 at 4:09 PM Ralph Campbell <rcampbell@nvidia.com> wrote:
> >
> > There are several places where ZONE_DEVICE struct pages assume a reference
> > count == 1 means the page is idle and free. Instead of open coding this,
> > add a helper function to hide this detail.
> >
> > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >
> > I'm resending this as a separate patch since I think it is ready to
> > merge. Originally, this was part of an RFC and is unchanged from v3:
> > https://lore.kernel.org/linux-mm/20201001181715.17416-1-rcampbell@nvidia.com
> >
> > It applies cleanly to linux-5.9.0-rc7-mm1 but doesn't really
> > depend on anything, just simple merge conflicts when applied to
> > other trees.
> > I'll let the various maintainers decide which tree and when to merge.
> > It isn't urgent since it is a clean up patch.
> 
> Thanks Ralph, it looks good to me. Jan, or Ted care to ack? I don't
> have much else pending for dax at the moment as Andrew is carrying my
> dax updates for this cycle. Andrew please take this into -mm if you
> get a chance. Otherwise I'll cycle back to it when some other dax
> updates arrive in my queue.

Acked-by: Theodore Ts'o <tytso@mit.edu> # for fs/ext4/inode.c
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
