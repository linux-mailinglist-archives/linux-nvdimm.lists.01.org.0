Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E25325D301
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Jul 2019 17:38:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 045F3212ABF67;
	Tue,  2 Jul 2019 08:38:06 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 69E3621962301
 for <linux-nvdimm@lists.01.org>; Tue,  2 Jul 2019 08:38:04 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w79so13411082oif.10
 for <linux-nvdimm@lists.01.org>; Tue, 02 Jul 2019 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ATmVU16yayuH858JtpQ8da12QUT0HIEkBZC0SnOh7VQ=;
 b=lWkCRmDV2TTrVlfmg/FthFEquAfSnTCno0dxpAMUwrCCGDKTnkTRoXST11SO8f7+Tj
 uLeH3pNIUdwbwIKw9S2b2u9/5GT+4Cd/DQWVJu00PiNqkIqKZT3dG3HSbfE+lOZH996I
 trzHcR8MBfHQF8/mw7CdCjBtEpjmMjDT7HHB1rhi1/vT+2K8mXSrNaoJRq28qvxBwYmB
 cZG8TsM5i0PbkuR8K6WNwpeWJRLEmDsvRGmSVEsZEIJpdJDZUOK7He1/4bSzSHiRpel6
 HXuZMpntGPdgHNqEKJv0EbB7LUZ1Vzya7oGE+yGXGO1ybjcsDyuJoGIpg1qd7MMvN0r6
 uV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ATmVU16yayuH858JtpQ8da12QUT0HIEkBZC0SnOh7VQ=;
 b=LTCogy/cflXwCR6OEEKdyBg3SkRm89kLI9p9VMv66NRuO2wa/0ISTsJB6z/fIR+ppq
 yyUhT2XpD7M4iDCn9hG/N4+QCr9lNLt7sZ7BYgiswM1SWWXzS2s59SlCgYNZG2GF7u/k
 D7D8BtsqVNtlZQB/5COPOQ5b5Nzr0YaxxDb3WgyRJH1NmgP0OwRU0GVYKsOcGltDhaeB
 WJ1hZt8tpSNOSCk86z6T88MYP0/4Px+zzU5D0tqj+9YK4/Ffwub515oleFKFwstD6GBz
 jp03vK2XzB9kcaxZXnROAFoCRLSw2tQWkaQ+TTzuo678MMPnrK+UMnS2McUe3dEpCGFu
 WkpA==
X-Gm-Message-State: APjAAAUYjMl3b4jhpUPtS6t5s+eWIl7PlLBaaQa4515ybz7IEH/fr3zn
 zfQcIyLmLEbqsqSSM42AfAXt9E9KM/PR6vn/X9EPjA==
X-Google-Smtp-Source: APXvYqwXecSoHqwn3Yh/wmhCfWrrvRoK57/wvgQNY7Y9kcpgG7iWPbKyR/hOnbbFMByE8MW5gqNtEsleDAoJWtVtsZw=
X-Received: by 2002:aca:ba02:: with SMTP id k2mr3189786oif.70.1562081883341;
 Tue, 02 Jul 2019 08:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4jjqooboxivY=AsfEPhCvxdwU66GpwE9vM+cqrZWvtX3g@mail.gmail.com>
 <CAPcyv4h6HgNE38RF5TxO3C268ZvrxgcPNrPWOt94MnO5gP_pjw@mail.gmail.com>
 <CAPcyv4gwd1_VHk_MfHeNSxyH+N1=aatj9WkKXqYNPkSXe4bFDg@mail.gmail.com>
 <20190627195948.GB4286@bombadil.infradead.org>
 <CAPcyv4iB3f1hDdCsw=Cy234dP-RXpxGyXDoTwEU8nt5qUDEVQg@mail.gmail.com>
 <20190629160336.GB1180@bombadil.infradead.org>
 <CAPcyv4ge3Ht1k_v=tSoVA6hCzKg1N3imhs_rTL3oTB+5_KC8_Q@mail.gmail.com>
 <CAA9_cmcb-Prn6CnOx-mJfb9CRdf0uG9u4M1Vq1B1rKVemCD-Vw@mail.gmail.com>
 <20190630152324.GA15900@bombadil.infradead.org>
 <CAPcyv4j2NBPBEUU3UW1Q5OyOEuo9R5e90HpkowpeEkMsAKiUyQ@mail.gmail.com>
 <20190702033410.GB1729@bombadil.infradead.org>
In-Reply-To: <20190702033410.GB1729@bombadil.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 2 Jul 2019 08:37:52 -0700
Message-ID: <CAPcyv4iEkN1o5HD6Gb9m5ohdAVQhmtiTDcFE+PMQczYx635Vwg@mail.gmail.com>
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

On Mon, Jul 1, 2019 at 8:34 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Jun 30, 2019 at 02:37:32PM -0700, Dan Williams wrote:
> > On Sun, Jun 30, 2019 at 8:23 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > I think my theory was slightly mistaken, but your fix has the effect of
> > > fixing the actual problem too.
> > >
> > > The xas->xa_index for a PMD is going to be PMD-aligned (ie a multiple of
> > > 512), but xas_find_conflict() does _not_ adjust xa_index (... which I
> > > really should have mentioned in the documentation).  So we go to sleep
> > > on the PMD-aligned index instead of the index of the PTE.  Your patch
> > > fixes this by using the PMD-aligned index for PTEs too.
> > >
> > > I'm trying to come up with a clean fix for this.  Clearly we
> > > shouldn't wait for a PTE entry if we're looking for a PMD entry.
> > > But what should get_unlocked_entry() return if it detects that case?
> > > We could have it return an error code encoded as an internal entry,
> > > like grab_mapping_entry() does.  Or we could have it return the _locked_
> > > PTE entry, and have callers interpret that.
> > >
> > > At least get_unlocked_entry() is static, but it's got quite a few callers.
> > > Trying to discern which ones might ask for a PMD entry is a bit tricky.
> > > So this seems like a large patch which might have bugs.
> > >
> > > Thoughts?
> >
> > ...but if it was a problem of just mismatched waitqueue's I would have
> > expected it to trigger prior to commit b15cd800682f "dax: Convert page
> > fault handlers to XArray".
>
> That commit converts grab_mapping_entry() (called by dax_iomap_pmd_fault())
> from calling get_unlocked_mapping_entry() to calling get_unlocked_entry().
> get_unlocked_mapping_entry() (eventually) called __radix_tree_lookup()
> instead of dax_find_conflict().
>
> > This hunk, if I'm reading it correctly,
> > looks suspicious: @index in this case is coming directly from
> > vm->pgoff without pmd alignment adjustment whereas after the
> > conversion it's always pmd aligned from the xas->xa_index. So perhaps
> > the issue is that the lock happens at pte granularity. I expect it
> > would cause the old put_locked_mapping_entry() to WARN, but maybe that
> > avoids the lockup and was missed in the bisect.
>
> I don't think that hunk is the problem.  The __radix_tree_lookup()
> is going to return a 'slot' which points to the canonical slot, no
> matter which of the 512 indices corresponding to that slot is chosen.
> So I think it's going to do essentially the same thing.

Yeah, no warnings on the parent commit for the regression.

I'd be inclined to do the brute force fix of not trying to get fancy
with separate PTE/PMD waitqueues and then follow on with a more clever
performance enhancement later. Thoughts about that?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
