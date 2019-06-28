Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3885A11D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 18:39:17 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B9AD3212AB4F0;
	Fri, 28 Jun 2019 09:39:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 45F51212AB4DE
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 09:39:13 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id s20so6603598otp.4
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5XLI89+7Lb6wfVp1bMUmxbBSBywMikjF0UqTHc4ZmMY=;
 b=uhN/KAyqmQJIfXv831E6f5gCDD4M7DPJutn9seJLci/a+sjZWkNPOQkf4lWIlPxwGD
 wMJOdt7G3K51qZNGI32EaXEHFWXMsveXMVkqEPxlkaTlEw1EBzhFfuapGlvfNcBcrdL8
 f/oqvyCxWz01YIuY/ynYX7NCy59SZ0R5gEnlrM241o+azp5zCI0tGPyPwJCui9wr6IgY
 jtsQL9yrZizohktvGl0vlFQn2LyUDsaLvo9BzEfVLM292cR04kl53Lpy8I5hyHVV6Ru8
 hH0ENXRysaq4iaAGqfrO2x1mMegw9G1ixN1TNPBbhj80FdYkvhaMt1tohfYCgxXPvFfq
 l7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5XLI89+7Lb6wfVp1bMUmxbBSBywMikjF0UqTHc4ZmMY=;
 b=YaJmqtOVo+cRzWqwlA5QvprMIdqolfS6t3pHV4X1Lmk5PZrkC5NL1RpliWtof1d/6x
 OGLp0ZxSP1+mMmovpmu0WpXkuNei7Oyqgb7maKU/xbePV4VlLu9ZUsLzV+gvSzzlkJGO
 cbmcmLCKCAvOOTVaX7jLDvcuBPs8JtwcC3E9NAU17RELCRazbO26Ygd5UVHRNNyiElKo
 xKNwYUp8I/wM/7kKidLKHN973OriejWFmRVF4ZGK3SIcyEbd1Igvc/iGEdf7cvemRMxE
 zx5j+DaRvmqyIz/4Va6UGwiMxtbFq4U8Svz7OYnmb+I9qx3tjJ2y/4NF+qbVcjCX4AkW
 H6DA==
X-Gm-Message-State: APjAAAW4TDqet1dl4dens/aOXAA1vp84XK3/jgnMhfDCb+W+n0eR/csl
 GDl3gK2+FlF3JEEEKTOayJBUtmYfc/oofpYeJJ2CbA==
X-Google-Smtp-Source: APXvYqy7YGYkJSjiaanIgBTFDjBOm0MW6GQ0Eu+LrM/c/o1FCTwV4rvL/QeDyZWVusE9P5L/uXi6G63VRJfQmLXqzk4=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr8613500oto.207.1561739952508; 
 Fri, 28 Jun 2019 09:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <156159454541.2964018.7466991316059381921.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190627123415.GA4286@bombadil.infradead.org>
 <CAPcyv4jQP-SFJGor-Q3VCRQ0xwt3MuVpH2qHx2wzyRA88DGQww@mail.gmail.com>
 <CAPcyv4jjqooboxivY=AsfEPhCvxdwU66GpwE9vM+cqrZWvtX3g@mail.gmail.com>
 <CAPcyv4h6HgNE38RF5TxO3C268ZvrxgcPNrPWOt94MnO5gP_pjw@mail.gmail.com>
 <CAPcyv4gwd1_VHk_MfHeNSxyH+N1=aatj9WkKXqYNPkSXe4bFDg@mail.gmail.com>
 <20190627195948.GB4286@bombadil.infradead.org>
 <CAPcyv4iB3f1hDdCsw=Cy234dP-RXpxGyXDoTwEU8nt5qUDEVQg@mail.gmail.com>
 <20190628163721.GC4286@bombadil.infradead.org>
In-Reply-To: <20190628163721.GC4286@bombadil.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 28 Jun 2019 09:39:01 -0700
Message-ID: <CAPcyv4jeRwhYWnGw9RrfDA54RRa9LK4JPuF3zQ-av=HdRqCTJw@mail.gmail.com>
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
To: Matthew Wilcox <willy@infradead.org>
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
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 28, 2019 at 9:37 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jun 27, 2019 at 07:39:37PM -0700, Dan Williams wrote:
> > On Thu, Jun 27, 2019 at 12:59 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > On Thu, Jun 27, 2019 at 12:09:29PM -0700, Dan Williams wrote:
> > > > > This bug feels like we failed to unlock, or unlocked the wrong entry
> > > > > and this hunk in the bisected commit looks suspect to me. Why do we
> > > > > still need to drop the lock now that the radix_tree_preload() calls
> > > > > are gone?
> > > >
> > > > Nevermind, unmapp_mapping_pages() takes a sleeping lock, but then I
> > > > wonder why we don't restart the lookup like the old implementation.
> > >
> > > If something can remove a locked entry, then that would seem like the
> > > real bug.  Might be worth inserting a lookup there to make sure that it
> > > hasn't happened, I suppose?
> >
> > Nope, added a check, we do in fact get the same locked entry back
> > after dropping the lock.
>
> Okay, good, glad to have ruled that out.
>
> > The deadlock revolves around the mmap_sem. One thread holds it for
> > read and then gets stuck indefinitely in get_unlocked_entry(). Once
> > that happens another rocksdb thread tries to mmap and gets stuck
> > trying to take the mmap_sem for write. Then all new readers, including
> > ps and top that try to access a remote vma, then get queued behind
> > that write.
> >
> > It could also be the case that we're missing a wake up.
>
> That was the conclusion I came to; that one thread holding the mmap sem
> for read isn't being woken up when it should be.  Just need to find it ...
> obviously it's something to do with the PMD entries.

Can you explain to me one more time, yes I'm slow on the uptake on
this, the difference between xas_load() and xas_find_conflict() and
why it's ok for dax_lock_page() to use xas_load() while
grab_mapping_entry() uses xas_find_conflict()?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
