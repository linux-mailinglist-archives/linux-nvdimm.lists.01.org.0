Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5154BE90
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Jun 2019 18:46:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E740321296B0A;
	Wed, 19 Jun 2019 09:46:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1828621289D93
 for <linux-nvdimm@lists.01.org>; Wed, 19 Jun 2019 09:46:36 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 43so2857930otf.8
 for <linux-nvdimm@lists.01.org>; Wed, 19 Jun 2019 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dAeca+NaeasgKg8wLjwxe/d8KFhZwiNtk4NpQn2oH10=;
 b=eEIpXOcPgh/FQm8AcRovuq2bVonIAGIxG4O8hqog+t2sNo8lmrfYIpq/+3PFypMTty
 siI4svCj0XFFk8DvueW2Zz7Zvoia5aS+WjHA2V9kjitsGk2Dr7OrDOGRxd+jgBEHrThr
 EHGL3vlgHvvthlk8Gfj633B1vbDSWX+nCllo+CoYhKFeZWAJNLlFWMmdziVMMg2G+cne
 9LkPYCnW/ZVKV1OTMMtvp9jixEL4J8gu4orI34DCJ30mCCAblY3ezSDjxZuDDDsPUqbB
 ZHR6EtInNGpbX74S1TmPO0TGeYVW9GToDYCY1yWZmGb6+1NQToWu8/vN0HJQG43y5Q4m
 K3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dAeca+NaeasgKg8wLjwxe/d8KFhZwiNtk4NpQn2oH10=;
 b=Pf8shFaPi4U0ylQjs6WXvTbc4queWKptneRBhFG51aj11lEgaR+SgW0NZVy6MXow2d
 CiKaJMvz5BvMQMPLlxct5FQdcJBmGT/TL9r+NeE5ZEMkvm5gShlgKNQFx3jxdrSgJOTZ
 jWkmMmnVl30jOyxcLN7pKafHI18LJx1qeRkvwEEpd9PsuuE0kstTJzmjMGGqWmXeKKz+
 tCrab7dbfRfAJOgyUKA4lC43SObPhyK7/eDfvR95Ukle3F8aVhw/vPLvqj40DexZXxvN
 eO20h/c4i2Y2wE1gQLjkwCH2CaPUp2QBI1yEc4veVQcCunH5qW4uRJBYi+1OkaDgPHLX
 uPGQ==
X-Gm-Message-State: APjAAAUeT48yVHb3aGaQmM5m/8KaCTxIXDenGDrHvAvikh0WTLqFV64N
 KkueNQSEdwzGYSiTvXz8zcVSciAVvIdYlNfX/eHCJg==
X-Google-Smtp-Source: APXvYqxu7jzERtujGtRB1JUPTrrSRxaJnnRx7A59gFxSd7DNSrReLEw7sHQTmTBvokQEtVRT1Qlvl4tg5ll4Z2fBIRs=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr9700022oto.207.1560962794186; 
 Wed, 19 Jun 2019 09:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de>
 <CAPcyv4hBUJB2RxkDqHkfEGCupDdXfQSrEJmAdhLFwnDOwt8Lig@mail.gmail.com>
 <20190619094032.GA8928@lst.de> <20190619163655.GG9360@ziepe.ca>
In-Reply-To: <20190619163655.GG9360@ziepe.ca>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 19 Jun 2019 09:46:23 -0700
Message-ID: <CAPcyv4hYtQdg0DTYjrJxCNXNjadBSWQ5QaMJYsA-QSribKuwrQ@mail.gmail.com>
Subject: Re: dev_pagemap related cleanups v2
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, nouveau@lists.freedesktop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 19, 2019 at 9:37 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jun 19, 2019 at 11:40:32AM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 18, 2019 at 12:47:10PM -0700, Dan Williams wrote:
> > > > Git tree:
> > > >
> > > >     git://git.infradead.org/users/hch/misc.git hmm-devmem-cleanup.2
> > > >
> > > > Gitweb:
> > > >
> > > >     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hmm-devmem-cleanup.2
> >
> > >
> > > Attached is my incremental fixups on top of this series, with those
> > > integrated you can add:
> >
> > I've folded your incremental bits in and pushed out a new
> > hmm-devmem-cleanup.3 to the repo above.  Let me know if I didn't mess
> > up anything else.  I'll wait for a few more comments and Jason's
> > planned rebase of the hmm branch before reposting.
>
> I said I wouldn't rebase the hmm.git (as it needs to go to DRM, AMD
> and RDMA git trees)..
>
> Instead I will merge v5.2-rc5 to the tree before applying this series.
>
> I've understood this to be Linus's prefered workflow.
>
> So, please send the next iteration of this against either
> plainv5.2-rc5 or v5.2-rc5 merged with hmm.git and I'll sort it out.

Just make sure that when you backmerge v5.2-rc5 you have a clear
reason in the merge commit message about why you needed to do it.
While needless rebasing is top of the pet peeve list, second place, as
I found out, is mystery merges without explanations.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
