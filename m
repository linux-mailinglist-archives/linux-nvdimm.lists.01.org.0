Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508C76B511
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Jul 2019 05:40:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B18A212BF57B;
	Tue, 16 Jul 2019 20:42:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 777282194EB75
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 20:42:26 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z23so23448523ote.13
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 20:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fQmhXD8ET32ay8TVgJJ0C1kgjcC1NnaxI9Qm/EBOdig=;
 b=bvRfaO1YBsDMsUlDUUMCtTlYZqLd5XT8jtz6vKXq315gt59VA4QSHyLm4vRek1Ici/
 AY4ddzg9xmO0luI6xy4JXvesSLxuVHyFkYTqcKR9/OdhpdsIsMaiGGU3/7lVa/vy8aLg
 kfYGzmdQR60nxqD7X3FbjO+NfJ64RCD51WgRxmylDsgk3CmzaWwX6nt1F4HPUDKfhx1k
 IIoIjuv/UQhkcLBM+SIckRYRt/4pign8uhZEjVFUzxza9WKueKXGxyqbalrddQ5b9CsL
 sd1Y5jJ/jwDL3722blXche5FL9YfuLLe0bWciMhd6k2CyFn1tExVqrp5PGNkLTbTwKyC
 fCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fQmhXD8ET32ay8TVgJJ0C1kgjcC1NnaxI9Qm/EBOdig=;
 b=R6qOP9G9GSBShtC1J9YTUeczCZQUv/a//3JxVA8erP4DurH6Q1oyJYZ9Xto6VjOBSy
 OeQZlBCxDT449L+4Fdk6We6qqsYtTZ8DGH6pPO2ETkQrjtO+Bu6JFinEsJKNZI4kJNfQ
 CPgUFj2Anx8e27eaVuQjDejgJ7mdRZ9WXf65biRkHGep+n/tdRtVYrOPCDj/S6HDwwvx
 236sfvzZQHNoxPlURUbQ1VGIxx40BIFuta+AoxoU5dPAvEPYRjr05qJqIXguPiSmzoeK
 AVmuPMxaprGhBQpfFxeOy1avrpSka0RKPeGueTxZwcbzNJkxW4v66sGB8ToyRDn1nyhf
 +VSg==
X-Gm-Message-State: APjAAAV66TW8akG+xVsNlZT0/wYtCPBdReg2KogX1Y7TYC54B3F6IWLE
 kj40nkuuAQOc/AxyAzYtXZvgYB5D67AGWzkfxWXF/Q==
X-Google-Smtp-Source: APXvYqzfeOGf5vw9dfMRZyRJyKUlcfLJm3DVjzR9MkVP/uGpxjLNl3ZXQKG6aUWp8HK3mCMsfaZNDcsAPgzlEmORx3s=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr27103492otf.126.1563334797431; 
 Tue, 16 Jul 2019 20:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190704165450.GH31037@quack2.suse.cz>
 <20190704191407.GM1729@bombadil.infradead.org>
 <CAPcyv4gUiDw8Ma9mvbW5BamQtGZxWVuvBW7UrOLa2uijrXUWaw@mail.gmail.com>
 <20190705191004.GC32320@bombadil.infradead.org>
 <CAPcyv4jVARa38Qc4NjQ04wJ4ZKJ6On9BbJgoL95wQqU-p-Xp_w@mail.gmail.com>
 <20190710190204.GB14701@quack2.suse.cz>
 <20190710201539.GN32320@bombadil.infradead.org>
 <20190710202647.GA7269@quack2.suse.cz>
 <20190711141350.GS32320@bombadil.infradead.org>
 <20190711152550.GT32320@bombadil.infradead.org>
 <20190711154111.GA29284@quack2.suse.cz>
In-Reply-To: <20190711154111.GA29284@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 16 Jul 2019 20:39:46 -0700
Message-ID: <CAPcyv4hA+44EHpGN9F5eQD5Y_AuyPTKmovNWvccAFGhF_O2JMg@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
To: Jan Kara <jack@suse.cz>
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
 Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jul 12, 2019 at 2:14 AM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 11-07-19 08:25:50, Matthew Wilcox wrote:
> > On Thu, Jul 11, 2019 at 07:13:50AM -0700, Matthew Wilcox wrote:
> > > However, the XA_RETRY_ENTRY might be a good choice.  It doesn't normally
> > > appear in an XArray (it may appear if you're looking at a deleted node,
> > > but since we're holding the lock, we can't see deleted nodes).
> >
> ...
>
> > @@ -254,7 +267,7 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
> >  static void put_unlocked_entry(struct xa_state *xas, void *entry)
> >  {
> >       /* If we were the only waiter woken, wake the next one */
> > -     if (entry)
> > +     if (entry && dax_is_conflict(entry))
>
> This should be !dax_is_conflict(entry)...
>
> >               dax_wake_entry(xas, entry, false);
> >  }
>
> Otherwise the patch looks good to me so feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good, and passes the test case. Now pushed out to
libnvdimm-for-next for v5.3 inclusion:

https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/commit/?h=libnvdimm-for-next&id=23c84eb7837514e16d79ed6d849b13745e0ce688
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
