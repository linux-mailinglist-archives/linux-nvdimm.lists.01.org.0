Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19911652DD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Jul 2019 10:10:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E3B51212B7DB0;
	Thu, 11 Jul 2019 01:13:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EE3CC211F9D4F
 for <linux-nvdimm@lists.01.org>; Thu, 11 Jul 2019 01:13:02 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id F3036AD4D;
 Thu, 11 Jul 2019 08:10:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id B5BB21E43B7; Wed, 10 Jul 2019 22:26:47 +0200 (CEST)
Date: Wed, 10 Jul 2019 22:26:47 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
Message-ID: <20190710202647.GA7269@quack2.suse.cz>
References: <20190703195302.GJ1729@bombadil.infradead.org>
 <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
 <20190704032728.GK1729@bombadil.infradead.org>
 <20190704165450.GH31037@quack2.suse.cz>
 <20190704191407.GM1729@bombadil.infradead.org>
 <CAPcyv4gUiDw8Ma9mvbW5BamQtGZxWVuvBW7UrOLa2uijrXUWaw@mail.gmail.com>
 <20190705191004.GC32320@bombadil.infradead.org>
 <CAPcyv4jVARa38Qc4NjQ04wJ4ZKJ6On9BbJgoL95wQqU-p-Xp_w@mail.gmail.com>
 <20190710190204.GB14701@quack2.suse.cz>
 <20190710201539.GN32320@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190710201539.GN32320@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Boaz Harrosh <openosd@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Seema Pandit <seema.pandit@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed 10-07-19 13:15:39, Matthew Wilcox wrote:
> On Wed, Jul 10, 2019 at 09:02:04PM +0200, Jan Kara wrote:
> > +#define DAX_ENTRY_CONFLICT dax_make_entry(pfn_to_pfn_t(1), DAX_EMPTY)
> 
> I was hoping to get rid of DAX_EMPTY ... it's almost unused now.  Once
> we switch to having a single DAX_LOCK value instead of a single bit,
> I think it can go away, freeing up two bits.
> 
> If you really want a special DAX_ENTRY_CONFLICT, I think we can make
> one in the 2..4094 range.
> 
> That aside, this looks pretty similar to the previous patch I sent, so
> if you're now happy with this, let's add
> 
> #define XA_DAX_CONFLICT_ENTRY xa_mk_internal(258)
> 
> to xarray.h and do it that way?

Yeah, that would work for me as well. The chosen value for DAX_ENTRY_CONFLICT
was pretty arbitrary. Or we could possibly use:

#define DAX_ENTRY_CONFLICT XA_ZERO_ENTRY

so that we don't leak DAX-specific internal definition into xarray.h?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
