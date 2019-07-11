Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEC7657E1
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Jul 2019 15:28:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BAB29212B5EE4;
	Thu, 11 Jul 2019 06:31:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2CDD921A07A80
 for <linux-nvdimm@lists.01.org>; Thu, 11 Jul 2019 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qQDTG34nBen/nM9O8f+a+MBGBH0+G5+6en1FIsdsBzQ=; b=W+v4En8WpGKHHhb5uk9cn5YEj
 gMBk1sMls9oDVSUMnffjOdYoC42wy0L2mrdb8o+2nRCt3WJcfJWdpJmZdwFH7zES2pWupJCUFZdpd
 +I0ZEZ52/7VuJmRzXFkuCHrqNnocufRvwVqTWFL84Zv2FBGtFMXone6sHQPuWsD3NHowMNRs2z0f7
 EEm1jKIO9RQ8O8rAIcVGKaJlZ7YjDe4dFqP6S38khRcqg/4f/fhU2/h5XGx35pJ4tyHd/WIhuiZAS
 fepWgCd+ombLf62ZVAnnAYieZTutsx+4AKG4jD7zCntmeAryEPk4KQ+vNqva9zXi8VGg4PP5+X3Ao
 VyIPQLmeg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hlZ7k-0002ft-Fx; Thu, 11 Jul 2019 13:28:36 +0000
Date: Thu, 11 Jul 2019 06:28:36 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
Message-ID: <20190711132836.GR32320@bombadil.infradead.org>
References: <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
 <20190704032728.GK1729@bombadil.infradead.org>
 <20190704165450.GH31037@quack2.suse.cz>
 <20190704191407.GM1729@bombadil.infradead.org>
 <CAPcyv4gUiDw8Ma9mvbW5BamQtGZxWVuvBW7UrOLa2uijrXUWaw@mail.gmail.com>
 <20190705191004.GC32320@bombadil.infradead.org>
 <CAPcyv4jVARa38Qc4NjQ04wJ4ZKJ6On9BbJgoL95wQqU-p-Xp_w@mail.gmail.com>
 <20190710190204.GB14701@quack2.suse.cz>
 <20190711030855.GO32320@bombadil.infradead.org>
 <20190711074859.GA8727@quack2.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190711074859.GA8727@quack2.suse.cz>
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

On Thu, Jul 11, 2019 at 09:48:59AM +0200, Jan Kara wrote:
> On Wed 10-07-19 20:08:55, Matthew Wilcox wrote:
> > On Wed, Jul 10, 2019 at 09:02:04PM +0200, Jan Kara wrote:
> > > @@ -848,7 +853,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
> > >  	if (unlikely(dax_is_locked(entry))) {
> > >  		void *old_entry = entry;
> > >  
> > > -		entry = get_unlocked_entry(xas);
> > > +		entry = get_unlocked_entry(xas, 0);
> > >  
> > >  		/* Entry got punched out / reallocated? */
> > >  		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
> > 
> > I'm not sure about this one.  Are we sure there will never be a dirty
> > PMD entry?  Even if we can't create one today, it feels like a bit of
> > a landmine to leave for someone who creates one in the future.
> 
> I was thinking about this but dax_writeback_one() doesn't really care what
> entry it gets. Yes, in theory it could get a PMD when previously there was
> PTE or vice-versa but we check that PFN's match and if they really do
> match, there's no harm in doing the flushing whatever entry we got back...
> And the checks are simpler this way.

That's fair.  I'll revert this part to the way you had it.

I actually want to get rid of the PFN match check too; it doesn't really
buy us much.  We already check whether the TOWRITE bit is set, and that
should accomplish the same thing.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
