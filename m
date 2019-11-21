Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F4D104CA4
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Nov 2019 08:32:34 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 16EDC100DC2BD;
	Wed, 20 Nov 2019 23:33:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 57123100DC2BC
	for <linux-nvdimm@lists.01.org>; Wed, 20 Nov 2019 23:33:05 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 94so2060084oty.8
        for <linux-nvdimm@lists.01.org>; Wed, 20 Nov 2019 23:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9wDawpHcea7HfUbnxzvdCHT/HpQNck9P448/UedoQM=;
        b=RUey+MSk1Jxsoa8ZqmDeOeA4Qu0lkrGc8OKXCXqKYlNDPNE/RI693KUy2YDy1bs0Bq
         ckWMixCAW5axJ3kJe7EpdMPizq+94X82FKhtwD7vIIOrm5PL4rWL5tMsRQc+gCoqi2TK
         RVgk0Kg9QPwUIVbMM59J11QqVgfeIgZPu4jOo1P8CBl7ke4N9DJQqfgylUSmvoKQKCbj
         mBjTqC/uvyUH/7bVZEmz7QQpfP5gtFAcrfBHGIuVQoZJNq8iC+Dgu0eAy4vcTOSab/Fh
         5mD7rv1Vz3M2bsNxX5R/1UKzn0KB1ehwLLvkMlxZ8kQlbvrKCCz1llIjyOUowure8p6X
         BRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9wDawpHcea7HfUbnxzvdCHT/HpQNck9P448/UedoQM=;
        b=IpuzWkNWsaUN00ddDgr1P6xlpwX/tubSN/mhnLwoK5bnBuoSCq2UTk4GKocCyIrhXb
         YuWsaiMD6BeK9CQ0dWzmkLfMfxO3ZgHDhpaQThutGrDF0aa8dH6+2R0BfcqG4KbXhvX8
         hPYedDjLuJnTGChJs8wb9jN0VmWhdrdUKLvnpjYJ4vVGWc4OgSC4ZEuFwAkThlMfwzp3
         cDf7LLD4e8C/A3gc7N3C627GLAnYUae9Vtz5NvLheh91FsJYzb1FL6gUUhxgS7NEVgEB
         DGwCYfqp0lb7FQUOF6P4W0jTqLpvbBdgxKY143TEPyBgdci8OgfqAaEirVps3k745lQ7
         spRg==
X-Gm-Message-State: APjAAAUb8pBAGZb6cJKTY8G2/ROk9sXM6NxAGq6Mut0fG51N8BgP/Pdx
	+UNRINLtgZvm2gINV1fxdV53sfTx+zu5sKQq4XMjlw==
X-Google-Smtp-Source: APXvYqxVdzze/Bv9h7nJAgHDFshYj18n/blQjGCiUjfCo8aBpbC+/jW+Mgs+B30i9qOHhWav26iyCwsoCBet2GWzaNY=
X-Received: by 2002:a9d:30c8:: with SMTP id r8mr5418112otg.363.1574321547958;
 Wed, 20 Nov 2019 23:32:27 -0800 (PST)
MIME-Version: 1.0
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
In-Reply-To: <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 20 Nov 2019 23:32:16 -0800
Message-ID: <CAPcyv4hJ6gHX=NYz-CoXFSrN93HUT+Xh+DP+QAjzqgGmmghmGA@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: OYYGQFL7G2WQVA6TOUUMWM2PPQVFERML
X-Message-ID-Hash: OYYGQFL7G2WQVA6TOUUMWM2PPQVFERML
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OYYGQFL7G2WQVA6TOUUMWM2PPQVFERML/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 20, 2019 at 11:23 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Nov 20, 2019 at 9:26 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >
> > Pankaj Gupta <pagupta@redhat.com> writes:
> >
> > >  Remove logic to create child bio in the async flush function which
> > >  causes child bio to get executed after parent bio 'pmem_make_request'
> > >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
> > >  data write request.
> > >
> > >  Instead we are performing flush from the parent bio to maintain the
> > >  correct order. Also, returning from function 'pmem_make_request' if
> > >  REQ_PREFLUSH returns an error.
> > >
> > > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> >
> > There's a slight change in behavior for the error path in the
> > virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
> > converted to -EIO.  Now, they are reported as-is.  I think this is
> > actually an improvement.
> >
> > I'll also note that the current behavior can result in data corruption,
> > so this should be tagged for stable.
>
> I added that and was about to push this out, but what about the fact
> that now the guest will synchronously wait for flushing to occur. The
> goal of the child bio was to allow that to be an I/O wait with
> overlapping I/O, or at least not blocking the submission thread. Does
> the block layer synchronously wait for PREFLUSH requests? If not I
> think a synchronous wait is going to be a significant performance
> regression. Are there any numbers to accompany this change?

Why not just swap the parent child relationship in the PREFLUSH case?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
