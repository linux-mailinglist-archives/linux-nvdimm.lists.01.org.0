Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D76A5C894A
	for <lists+linux-nvdimm@lfdr.de>; Wed,  2 Oct 2019 15:07:45 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E7665100DC407;
	Wed,  2 Oct 2019 06:09:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B7CD8100DC406
	for <linux-nvdimm@lists.01.org>; Wed,  2 Oct 2019 06:09:01 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id m16so17560876oic.5
        for <linux-nvdimm@lists.01.org>; Wed, 02 Oct 2019 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50mE1GFOx2IDL8fOUBOO94SxADHosM9SfQ7pyxbnHTg=;
        b=OcATdm0fU0HGv1IIhubCuFeqR/P2N37o7xtR/ZD4irFYeHZyY/QMlcxb9A3jVo1gr4
         chbxvSvR7VV0Qigg5Ap4In4xkHjYBGjW81DG45OK+R+st0eaUOvKFdRsNtBGfdXXso+G
         CRT9yAg3GyQINBZ5KBDazaDUYmqZ9vColyWrmK7zf2b7qw3LLSuXB22GA91dRzkb/DN3
         hVBuovDyfmx09Yu6vWFC0lVHAXaZdX+8e6xTLeBTs8iVaP9DmUzHXZJ5SuCoYXwZ14L3
         3WdQyTtyBcH2b1o1IoJ8dDqWwniK/IYku412BJ6lj3HdaGvf3lcdbJk/pu8WTervpUsH
         BKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50mE1GFOx2IDL8fOUBOO94SxADHosM9SfQ7pyxbnHTg=;
        b=l8/MtTk7doRRqiQaxLKndJkSl0vElIxp0ZNFrauGteNK6LTgJaO9jxFkqQ30EjpbiN
         ZDj0K8wZ/s8JH1UF1UCvX1UML0XlxJ5BYBolaFiogVHTUtszLpqbCN/su2zgNcfu3stW
         xm8kNYN1twDsDOr1/NQbxb6snpdv+rIOSNaX7RauM77caVPe2MVQGYY28mjxS8fdhBk4
         rlbJ22LPCfj8Cu9JR2WuUreoKUhmhroMgtDRfxaYKCnTAxxI1DYp3ZI6PJZ+WPZrJitw
         T5jdFu+WWWKZtA9N2yWQZjhWAZnAkXaEr/2FXPROCw1rhm/cduat7F4an6vAwaNCi0mB
         DdfQ==
X-Gm-Message-State: APjAAAW2JraS1fVRlhK4edT65jU+jieP738hzrF0Gt/mUgD4YDt+5uiw
	8cHaopui7gx0LFq1V7izokURQ0v/lsSpPx96e8qvdw==
X-Google-Smtp-Source: APXvYqxGQ01cpMCqhyT0OZic4du6ntHizaukJRygkeedHLWkQjdo8fNGeQWk8deAiGsRuCSgwYPjlJGf+Xhg9J875/c=
X-Received: by 2002:aca:eb09:: with SMTP id j9mr2925590oih.105.1570021659582;
 Wed, 02 Oct 2019 06:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <20190923222620.GC16973@dread.disaster.area> <20190925234602.GB12748@iweiny-DESK2.sc.intel.com>
 <20190930084233.GO16973@dread.disaster.area> <20191001210156.GB5500@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20191001210156.GB5500@iweiny-DESK2.sc.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 2 Oct 2019 06:07:27 -0700
Message-ID: <CAPcyv4jpLYUcqA6D_qfGF4FQCu-SuH67FHLcH0fCQTQ-D+hWzQ@mail.gmail.com>
Subject: Re: Lease semantic proposal
To: Ira Weiny <ira.weiny@intel.com>
Message-ID-Hash: L27Y7EN3XEMZEVY2QTYXBPQIOELVZ5DI
X-Message-ID-Hash: L27Y7EN3XEMZEVY2QTYXBPQIOELVZ5DI
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Chinner <david@fromorbit.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, linux-rdma <linux-rdma@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L27Y7EN3XEMZEVY2QTYXBPQIOELVZ5DI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 1, 2019 at 2:02 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Mon, Sep 30, 2019 at 06:42:33PM +1000, Dave Chinner wrote:
> > On Wed, Sep 25, 2019 at 04:46:03PM -0700, Ira Weiny wrote:
> > > On Tue, Sep 24, 2019 at 08:26:20AM +1000, Dave Chinner wrote:
> > > > Hence, AFIACT, the above definition of a F_RDLCK|F_LAYOUT lease
> > > > doesn't appear to be compatible with the semantics required by
> > > > existing users of layout leases.
> > >
> > > I disagree.  Other than the addition of F_UNBREAK, I think this is consistent
> > > with what is currently implemented.  Also, by exporting all this to user space
> > > we can now write tests for it independent of the RDMA pinning.
> >
> > The current usage of F_RDLCK | F_LAYOUT by the pNFS code allows
> > layout changes to occur to the file while the layout lease is held.
>
> This was not my understanding.

I think you guys are talking past each other. F_RDLCK | F_LAYOUT can
be broken to allow writes to the file / layout. The new unbreakable
case would require explicit SIGKILL as "revocation method of last
resort", but that's the new incremental extension being proposed. No
changes to the current behavior of F_RDLCK | F_LAYOUT.

Dave, the question at hand is whether this new layout lease mode being
proposed is going to respond to BREAK_WRITE, or just BREAK_UNMAP. It
seems longterm page pinning conflicts really only care about
BREAK_UNMAP where pages that were part of the file are being removed
from the file. The unbreakable case can tolerate layout changes that
keep pinned pages mapped / allocated to the file.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
