Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A5365897
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Jul 2019 16:13:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 962F9212B0FC3;
	Thu, 11 Jul 2019 07:16:21 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7ADAE21290D33
 for <linux-nvdimm@lists.01.org>; Thu, 11 Jul 2019 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A+M9EKycY4/Na49/3ZTutvW03nTdeCovAhe5sPEc738=; b=DWaYAaHL39mYbsCRqEJ3S1QQ7
 P02squV/NBUTgulBtI4yUhtjhZPbXviXwn5cZ64a18nBrxMDqHZ9sjyzYhy8rrWsIGViUL4cuiFNR
 13jc9CGjCkCg9vUQQobNtgkPofyl56m4PinPfQAT8yXfkSrKa7TQw4y6e8ow4U8TMK37DxOKX3CX3
 TtYqXc/uTk7W5yiypMbcKX93JyA6IotJW3FcTmtHuDWAS30qOioSZlpdonSH/3GJq3YRLQ3nWrWuK
 /tXAoQynuvEE2hyzve6v52C027MqCmg4zh1ItcUY/JouC54bRwId30BRrUhafL+gbKxIhAS5QCvkO
 4gn8QmF5Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hlZpW-0001Os-V6; Thu, 11 Jul 2019 14:13:50 +0000
Date: Thu, 11 Jul 2019 07:13:50 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
Message-ID: <20190711141350.GS32320@bombadil.infradead.org>
References: <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
 <20190704032728.GK1729@bombadil.infradead.org>
 <20190704165450.GH31037@quack2.suse.cz>
 <20190704191407.GM1729@bombadil.infradead.org>
 <CAPcyv4gUiDw8Ma9mvbW5BamQtGZxWVuvBW7UrOLa2uijrXUWaw@mail.gmail.com>
 <20190705191004.GC32320@bombadil.infradead.org>
 <CAPcyv4jVARa38Qc4NjQ04wJ4ZKJ6On9BbJgoL95wQqU-p-Xp_w@mail.gmail.com>
 <20190710190204.GB14701@quack2.suse.cz>
 <20190710201539.GN32320@bombadil.infradead.org>
 <20190710202647.GA7269@quack2.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190710202647.GA7269@quack2.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: Seema Pandit <seema.pandit@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Boaz Harrosh <openosd@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 10, 2019 at 10:26:47PM +0200, Jan Kara wrote:
> On Wed 10-07-19 13:15:39, Matthew Wilcox wrote:
> > On Wed, Jul 10, 2019 at 09:02:04PM +0200, Jan Kara wrote:
> > > +#define DAX_ENTRY_CONFLICT dax_make_entry(pfn_to_pfn_t(1), DAX_EMPTY)
> > 
> > I was hoping to get rid of DAX_EMPTY ... it's almost unused now.  Once
> > we switch to having a single DAX_LOCK value instead of a single bit,
> > I think it can go away, freeing up two bits.
> > 
> > If you really want a special DAX_ENTRY_CONFLICT, I think we can make
> > one in the 2..4094 range.
> > 
> > That aside, this looks pretty similar to the previous patch I sent, so
> > if you're now happy with this, let's add
> > 
> > #define XA_DAX_CONFLICT_ENTRY xa_mk_internal(258)
> > 
> > to xarray.h and do it that way?
> 
> Yeah, that would work for me as well. The chosen value for DAX_ENTRY_CONFLICT
> was pretty arbitrary. Or we could possibly use:
> 
> #define DAX_ENTRY_CONFLICT XA_ZERO_ENTRY
> 
> so that we don't leak DAX-specific internal definition into xarray.h?

I don't want to use the ZERO entry as our conflict marker because that
could legitimately appear in an XArray.  Not the i_pages XArray today,
but I hold out hope for using that in place of the DAX_ZERO_PAGE bit too.
That's going to be a bit more tricky since we currently distinguish
between DAX_ZERO_PAGE and DAX_ZERO_PAGE | DAX_PMD.

However, the XA_RETRY_ENTRY might be a good choice.  It doesn't normally
appear in an XArray (it may appear if you're looking at a deleted node,
but since we're holding the lock, we can't see deleted nodes).
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
