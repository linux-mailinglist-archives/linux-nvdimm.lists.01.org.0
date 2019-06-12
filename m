Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFC642F33
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Jun 2019 20:42:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B79C2129605B;
	Wed, 12 Jun 2019 11:42:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B911C21290DE4
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 11:42:05 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id m206so12433842oib.12
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tLkmphJnLjEku4wPa26GqmShS2e5likwCcmpQlFLS9E=;
 b=zfGP+t+9ivTiw9crHzyoG37UKVT39+ZjMSRc6i4RLF5qzgoEzM0PJJFpTl3UpomLM/
 kX7wxsRh/bfXL05Kn2SjQT8PDTQbpZvw2lUD2P17lgifKk9462SiGOzy9eolZxENP8tF
 +j8h3CL4xbOvN0NcXJng0ZhfijbK4zlpWlo5g45OKeiNBbSWh4j6EO8XjD4uzxYBWXSc
 XQXw6jfUAUrXoISJcc1nasZDsCw2vNnJrgvivK5m8U97df7yj+O0/KKRytyMUK2vV5wL
 CVPInnibqz35AZHLe+QENPOC6d6PXPPLQ6FBHTljTMKMRhnltIiFojDH2RTb0H3+DeCQ
 awHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tLkmphJnLjEku4wPa26GqmShS2e5likwCcmpQlFLS9E=;
 b=Cq/pX/yi+Tjm5J7X/bS1p2wiyQS4pS7AR2+wRGU+UyhguSc0Y18AMc7RJQMfNBymzr
 e9dnybiSCK5VxtChtJ0RTLGZFRCOLXu4REeci4tcKYE+I6A81MSQZVrN0m221lu9uqd/
 rTgr9bEUfD07p0XORTy8jkGvK8JP2uf1MIG89u1dl0fS81CmeaP/HjM8l4et659/JG/w
 MKjtzM/xoGNNLAzOVpi/YC97C7DQUY8jD8ynXo6f2fFTF+B+yLPWaUr71UmlQZuVsHij
 nDIBa7Nnnw3WNwoh5tGm8Esz4w2fVjoPTa2uZyEvqwUHr3Prkcc0+/5Gb4gcwGhhwSlW
 R7kw==
X-Gm-Message-State: APjAAAVFqEw4R9uWNLsgjoptxHcZevNjccMK35Bk6tEpoN2pSk+Dxsl+
 acCE97OJXmSraYthMA6ZqyQwY0CHYpSMdvYEK1oxFQ==
X-Google-Smtp-Source: APXvYqxw8Jxg8VjrdgkzfIw+Yn35hC16YxwrfmO4tE9KRMFgYTyKNK9pqaozSKJ82RqVYk9X5Uls8HWSSM7jkwOY/uo=
X-Received: by 2002:aca:ed4c:: with SMTP id l73mr412323oih.149.1560364924898; 
 Wed, 12 Jun 2019 11:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
 <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz> <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
 <20190612102917.GB14578@quack2.suse.cz>
 <20190612114721.GB3876@ziepe.ca> <20190612120907.GC14578@quack2.suse.cz>
In-Reply-To: <20190612120907.GC14578@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 12 Jun 2019 11:41:53 -0700
Message-ID: <CAPcyv4ikn219XUgHwsPdYp06vBNAJB9Rk-hjZA-fYT4GB3gi+w@mail.gmail.com>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Dave Chinner <david@fromorbit.com>, Jeff Layton <jlayton@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-xfs <linux-xfs@vger.kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 12, 2019 at 5:09 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 12-06-19 08:47:21, Jason Gunthorpe wrote:
> > On Wed, Jun 12, 2019 at 12:29:17PM +0200, Jan Kara wrote:
> >
> > > > > The main objection to the current ODP & DAX solution is that very
> > > > > little HW can actually implement it, having the alternative still
> > > > > require HW support doesn't seem like progress.
> > > > >
> > > > > I think we will eventually start seein some HW be able to do this
> > > > > invalidation, but it won't be universal, and I'd rather leave it
> > > > > optional, for recovery from truely catastrophic errors (ie my DAX is
> > > > > on fire, I need to unplug it).
> > > >
> > > > Agreed.  I think software wise there is not much some of the devices can do
> > > > with such an "invalidate".
> > >
> > > So out of curiosity: What does RDMA driver do when userspace just closes
> > > the file pointing to RDMA object? It has to handle that somehow by aborting
> > > everything that's going on... And I wanted similar behavior here.
> >
> > It aborts *everything* connected to that file descriptor. Destroying
> > everything avoids creating inconsistencies that destroying a subset
> > would create.
> >
> > What has been talked about for lease break is not destroying anything
> > but very selectively saying that one memory region linked to the GUP
> > is no longer functional.
>
> OK, so what I had in mind was that if RDMA app doesn't play by the rules
> and closes the file with existing pins (and thus layout lease) we would
> force it to abort everything. Yes, it is disruptive but then the app didn't
> obey the rule that it has to maintain file lease while holding pins. Thus
> such situation should never happen unless the app is malicious / buggy.

When you say 'close' do you mean the final release of the fd? The vma
keeps a reference to a 'struct file' live even after the fd is closed.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
