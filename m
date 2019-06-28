Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F7059140
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 04:39:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 02D01212AB4C1;
	Thu, 27 Jun 2019 19:39:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1929A212AB010
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 19:39:50 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id s20so4486631otp.4
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 19:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i+w5fn2Y32/L39vIbDWdR2CfVz49VqoI4F4CB/r+uKs=;
 b=2BroReMxSyl7fumvZHFYCsXog9so/PwacI6uZo45fszzwoTUhDjTDVIC3dmDgkvhjI
 1vPIrM+hSnKeAwrkzbGzAjTEPTTgmqOwCVSZQUdIDrvAxKA2cMV8Dr6GunOjfoKKRYiR
 i8n913ea5p94gaxe2NpjIpJwUJ2qhzkQ+wHLtf//YGUdDQeqhjuL7sHzp6EjAr//ec01
 XTKGHBCDcdPjUSb8oFPiQDfaUdsVI1ufjKYoVyP6pZsvPych6kooqkVWEaGAH73GpfeW
 Q64A9UAnw0STfqhTNC283nlq9ZOnnmCyzDAjw3roZzNRDyNGYbLpCBliRHdGmg3LI7kY
 Wv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i+w5fn2Y32/L39vIbDWdR2CfVz49VqoI4F4CB/r+uKs=;
 b=ZIlA1Fv3mTCoMwUKsoKNd0r3XjyXsHFuSkUt/PrbDWf7SRRpgee+j0qjZGIsfc2clz
 F1t0bSKViThJi/Q6qHy0VmLk0SBnGZKY4bGOoOvJk6BryxMO3fw6Ox6d0TZG56Rbe2qa
 T4hxRK+WHPlDZfneVUDGzaisZsbMODtitayzJNCrGsj5pztvXTU7jFb261tgdVJkfKsB
 ziQXc64IVbGKi9mYH/CJC+lO7u31Jr/Lo5RIkPlZuPmqK3QZqDrRIpiB+UqYX7wL7hkY
 ihBS5ws+Tk8MkX99PNMhJ8YH7aH2UvWl2SDUTBgTVWwnYJxjN14Q7cfafDBJo3XGR+nW
 oXsQ==
X-Gm-Message-State: APjAAAVmCmtjlYaKPOYK/Rkd4nNFQwvoF9tp37SJFm5ejng7JswrFxsJ
 g/xe9mS88+laHvGXIHFARi+MDvF0rE/B7hdU6BKiFA==
X-Google-Smtp-Source: APXvYqwSf5cu88/vylJhhX2x15ji/SfzGkHLqjJ94ZW0+LXDsKMlI1/GoQT5qpbwxtU93udva3CYg32AyPTcsoNMv3U=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr5967248oto.207.1561689589382; 
 Thu, 27 Jun 2019 19:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <156159454541.2964018.7466991316059381921.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190627123415.GA4286@bombadil.infradead.org>
 <CAPcyv4jQP-SFJGor-Q3VCRQ0xwt3MuVpH2qHx2wzyRA88DGQww@mail.gmail.com>
 <CAPcyv4jjqooboxivY=AsfEPhCvxdwU66GpwE9vM+cqrZWvtX3g@mail.gmail.com>
 <CAPcyv4h6HgNE38RF5TxO3C268ZvrxgcPNrPWOt94MnO5gP_pjw@mail.gmail.com>
 <CAPcyv4gwd1_VHk_MfHeNSxyH+N1=aatj9WkKXqYNPkSXe4bFDg@mail.gmail.com>
 <20190627195948.GB4286@bombadil.infradead.org>
In-Reply-To: <20190627195948.GB4286@bombadil.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 27 Jun 2019 19:39:37 -0700
Message-ID: <CAPcyv4iB3f1hDdCsw=Cy234dP-RXpxGyXDoTwEU8nt5qUDEVQg@mail.gmail.com>
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

On Thu, Jun 27, 2019 at 12:59 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jun 27, 2019 at 12:09:29PM -0700, Dan Williams wrote:
> > > This bug feels like we failed to unlock, or unlocked the wrong entry
> > > and this hunk in the bisected commit looks suspect to me. Why do we
> > > still need to drop the lock now that the radix_tree_preload() calls
> > > are gone?
> >
> > Nevermind, unmapp_mapping_pages() takes a sleeping lock, but then I
> > wonder why we don't restart the lookup like the old implementation.
>
> We have the entry locked:
>
>                 /*
>                  * Make sure 'entry' remains valid while we drop
>                  * the i_pages lock.
>                  */
>                 dax_lock_entry(xas, entry);
>
>                 /*
>                  * Besides huge zero pages the only other thing that gets
>                  * downgraded are empty entries which don't need to be
>                  * unmapped.
>                  */
>                 if (dax_is_zero_entry(entry)) {
>                         xas_unlock_irq(xas);
>                         unmap_mapping_pages(mapping,
>                                         xas->xa_index & ~PG_PMD_COLOUR,
>                                         PG_PMD_NR, false);
>                         xas_reset(xas);
>                         xas_lock_irq(xas);
>                 }
>
> If something can remove a locked entry, then that would seem like the
> real bug.  Might be worth inserting a lookup there to make sure that it
> hasn't happened, I suppose?

Nope, added a check, we do in fact get the same locked entry back
after dropping the lock.

The deadlock revolves around the mmap_sem. One thread holds it for
read and then gets stuck indefinitely in get_unlocked_entry(). Once
that happens another rocksdb thread tries to mmap and gets stuck
trying to take the mmap_sem for write. Then all new readers, including
ps and top that try to access a remote vma, then get queued behind
that write.

It could also be the case that we're missing a wake up.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
