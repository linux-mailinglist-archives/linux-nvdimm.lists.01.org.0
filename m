Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D7778EF7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jul 2019 17:19:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5B003212E470A;
	Mon, 29 Jul 2019 08:21:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id ACAED212AB4D4
 for <linux-nvdimm@lists.01.org>; Mon, 29 Jul 2019 08:21:35 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id o101so62900366ota.8
 for <linux-nvdimm@lists.01.org>; Mon, 29 Jul 2019 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rCT6H9w7mRPFe9tLjSH6a/cwajZAI16F1Mz9k4S0jwo=;
 b=bw8SQC4b3IVQPpG8+lymx/5VvfWVb17DQbUIblaNzQ+DivE/9bZrLa1es+hytSIsb4
 st4IVP90+jBqEINN4yoCPm61vk9e/iayOi66FNlhn5dYMF3FkwdxXmRS9QBPg3jZ/EBI
 1/zEryAVLcFGSYfWtnkGzTIacI0eDBEQI3LL2MJwDFGuXVFaoLNEvv7HU4DOrtwcyX3c
 8BoKKJMt1wbDx1ZPmjpdztw6bJ+1/eFNc+39XbtVdYu3o5Zp2RLdaBT9RRza5m3Xo+CG
 XWE9Km4WBRApykf0CL9lWcPxOvhP4EisuNC6Ehj9bIcJ/nbDXkwpossXNQEbG2s8wOKw
 coIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rCT6H9w7mRPFe9tLjSH6a/cwajZAI16F1Mz9k4S0jwo=;
 b=cJaRoqY8pNC8HXhW9v6yQfu60zZsnrs7kQ61TX50WC7IotPvup4CEmncOjz1gUiv54
 +YJ/ucLHCEBX5WmnXtbQgLj+PTPCrTcgEjrVFUTTuI0po5imDzQTzURCwoZd2p8Y8nI5
 8JyJqWUF3LK6dDq1OKCopXYfcYC1sP+dRCboxj9a0y3nxR5tcTQjg7qFdAQ/O3l/39Cm
 F+cQU8NhSJFP7788av1CM2q9aakQDf23bkDKfRSIdIW7UFDOWVCnSsfqDQAwE4Ks5CR9
 KxZxyKuxMNilBq5EX7MiCiNeszEAOMlFmwiJg3p2oEHajiiFrNJUrB6Qu583b34jNJ2f
 vs7Q==
X-Gm-Message-State: APjAAAV60UzP64tELq1n8L54DjFE1B7QVQazND6P+d5xhEbR3REbnZUL
 N1im40eEmbI2BNoA3dY74gRrJUXu3sU828kqTflXyg==
X-Google-Smtp-Source: APXvYqxYWAjs7eLjr+8klpuvyVa2e+dzwHIBnTZXXBRs/ed3hhF2B01PvzuOFqm6GTJEk7S3DAaC0Ry44CTuealvMbg=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr80213537otf.126.1564413543911; 
 Mon, 29 Jul 2019 08:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4gUiDw8Ma9mvbW5BamQtGZxWVuvBW7UrOLa2uijrXUWaw@mail.gmail.com>
 <20190705191004.GC32320@bombadil.infradead.org>
 <CAPcyv4jVARa38Qc4NjQ04wJ4ZKJ6On9BbJgoL95wQqU-p-Xp_w@mail.gmail.com>
 <20190710190204.GB14701@quack2.suse.cz>
 <20190710201539.GN32320@bombadil.infradead.org>
 <20190710202647.GA7269@quack2.suse.cz>
 <20190711141350.GS32320@bombadil.infradead.org>
 <20190711152550.GT32320@bombadil.infradead.org>
 <20190711154111.GA29284@quack2.suse.cz>
 <CAPcyv4hA+44EHpGN9F5eQD5Y_AuyPTKmovNWvccAFGhF_O2JMg@mail.gmail.com>
 <20190729120228.GC17833@quack2.suse.cz>
In-Reply-To: <20190729120228.GC17833@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 29 Jul 2019 08:18:52 -0700
Message-ID: <CAPcyv4hMJnMYAW=qcZWcadMoofgsnoQ66Xk5O6ZpxKCK4Yfr5g@mail.gmail.com>
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

On Mon, Jul 29, 2019 at 5:02 AM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 16-07-19 20:39:46, Dan Williams wrote:
> > On Fri, Jul 12, 2019 at 2:14 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 11-07-19 08:25:50, Matthew Wilcox wrote:
> > > > On Thu, Jul 11, 2019 at 07:13:50AM -0700, Matthew Wilcox wrote:
> > > > > However, the XA_RETRY_ENTRY might be a good choice.  It doesn't normally
> > > > > appear in an XArray (it may appear if you're looking at a deleted node,
> > > > > but since we're holding the lock, we can't see deleted nodes).
> > > >
> > > ...
> > >
> > > > @@ -254,7 +267,7 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
> > > >  static void put_unlocked_entry(struct xa_state *xas, void *entry)
> > > >  {
> > > >       /* If we were the only waiter woken, wake the next one */
> > > > -     if (entry)
> > > > +     if (entry && dax_is_conflict(entry))
> > >
> > > This should be !dax_is_conflict(entry)...
> > >
> > > >               dax_wake_entry(xas, entry, false);
> > > >  }
> > >
> > > Otherwise the patch looks good to me so feel free to add:
> > >
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> >
> > Looks good, and passes the test case. Now pushed out to
> > libnvdimm-for-next for v5.3 inclusion:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/commit/?h=libnvdimm-for-next&id=23c84eb7837514e16d79ed6d849b13745e0ce688
>
> Thanks for picking up the patch but you didn't apply the fix I've mentioned
> above. So put_unlocked_entry() is not waking up anybody anymore... Since
> this got already to Linus' tree, I guess a separate fixup patch is needed
> (attached).

Sigh, indeed. I think what happened is I applied the fixup locally,
tested it, and then later reapplied the patch from the list as I was
integrating the new automatic "Link:" generation script that has been
proposed on the ksummit list.

I'll get this pushed immediately.

Lesson learned: no manual local fixups, ask for resends to always be
able to pull the exact contents from the list.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
