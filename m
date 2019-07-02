Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8F25D85D
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 01:18:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 80CD7211F35FF;
	Tue,  2 Jul 2019 16:18:02 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 034D8211E094D
 for <linux-nvdimm@lists.01.org>; Tue,  2 Jul 2019 16:18:00 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w196so431252oie.7
 for <linux-nvdimm@lists.01.org>; Tue, 02 Jul 2019 16:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u5UwRiHjXkEAlhFHmvxN8ePNlS4fXC/47jr2WEGpIzo=;
 b=OuN/4ptiyR+plJoUbh14HMfrLiUOlvumFP0tzROycbsFqfygYxNO3xqFi028k9qP6U
 2hsxYQ/2r3+ffTRQvqv/sCf8RYf+3AvuvLqH7ogDKbeVFyv/k7MsfBkCxG4uRyEvLytD
 3hBMhCKOWYcfttKhsfT8Y19T3NlQHBTeuu1o3bC0SKi1LDuyTUAXjHnls8TPzw595KLC
 nNTom92Iwyk5ROjrmSXSDkHChpxbNbnGWGRWyw3laBL4fIp/E7U50dYgr8AGkfNKV1ux
 j9NiIvFe4orlhguGifJ7Su4YhO973/sL8kBVtipoBIsWxN1zYFyjnK/YO/aROHHw66yH
 203w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u5UwRiHjXkEAlhFHmvxN8ePNlS4fXC/47jr2WEGpIzo=;
 b=Jyetar7D1F7eZ6g7pptxUiMv0z50trT39kNPTvjMEO0nLLyUPuXRpWSfsWRBHcKvhO
 gn91L1EL1EmQgucYv4iW7/EjJ/LA/v/FEiOYF4L47KfjAG6iO4I7pB3QJJ0BVvkdSuG4
 PcjaSkJj0a+J+tbpsLKHUTyFIrjstXoliJKAHNBMAHLRCir9Z1hCfZQbEuh/SAF6wWau
 Permg3YONFyy48EhhXntWDNRds1Go3UxXD3A4xfgYZMt48GtRoc2NYwBxvsc4I8DBkY3
 m5nJ5r9tlsuha5r9G/cP7FqtrU/Tu50+p53jhrBM7I2ncqagTJKfYuivr4QBd2YC1H04
 uDig==
X-Gm-Message-State: APjAAAWtTvYUYknVBLx/R7mUYNn6Q0ZAW0M0KwJ/sB7R0RmVnvesw7mP
 2nfST1+qLt9o9rM2UVoyccPDu9Rr8u1Td5qkGnw3SA==
X-Google-Smtp-Source: APXvYqyLlYpHy9+AMc/X38t5BFMinZJQ01XTqDg0vHmjdWTN0eXoTzXdkzMkhqYvcnewmJArWXl9rZoSGD4d6S4ISik=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr4183998oih.73.1562109479302; 
 Tue, 02 Jul 2019 16:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190701062020.19239-1-hch@lst.de> <20190701082517.GA22461@lst.de>
 <20190702184201.GO31718@mellanox.com>
In-Reply-To: <20190702184201.GO31718@mellanox.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 2 Jul 2019 16:17:48 -0700
Message-ID: <CAPcyv4iWXJ-c7LahPD=Qt4RuDNTU7w_8HjsitDuj3cxngzb56g@mail.gmail.com>
Subject: Re: dev_pagemap related cleanups v4
To: Jason Gunthorpe <jgg@mellanox.com>
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jul 2, 2019 at 11:42 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Jul 01, 2019 at 10:25:17AM +0200, Christoph Hellwig wrote:
> > And I've demonstrated that I can't send patch series..  While this
> > has all the right patches, it also has the extra patches already
> > in the hmm tree, and four extra patches I wanted to send once
> > this series is merged.  I'll give up for now, please use the git
> > url for anything serious, as it contains the right thing.
>
> Okay, I sorted it all out and temporarily put it here:
>
> https://github.com/jgunthorpe/linux/commits/hmm
>
> Bit involved job:
> - Took Ira's v4 patch into hmm.git and confirmed it matches what
>   Andrew has in linux-next after all the fixups
> - Checked your github v4 and the v3 that hit the mailing list were
>   substantially similar (I never did get a clean v4) and largely
>   went with the github version
> - Based CH's v4 series on -rc7 and put back the removal hunk in swap.c
>   so it compiles
> - Merge'd CH's series to hmm.git and fixed all the conflicts with Ira
>   and Ralph's patches (such that swap.c remains unchanged)
> - Added Dan's ack's and tested-by's

Looks good. Test merge (with some collisions, see below) also passes
my test suite.

>
> I think this fairly closely follows what was posted to the mailing
> list.
>
> As it was more than a simple 'git am', I'll let it sit on github until
> I hear OK's then I'll move it to kernel.org's hmm.git and it will hit
> linux-next. 0-day should also run on this whole thing from my github.
>
> What I know is outstanding:
>  - The conflicting ARM patches, I understand Andrew will handle these
>    post-linux-next
>  - The conflict with AMD GPU in -next, I am waiting to hear from AMD

Just a heads up that this also collides with the "sub-section" patches
in Andrew's tree. The resolution is straightforward, mostly just
colliding updates to arch_{add,remove}_memory() call sites in
kernel/memremap.c and collisions with pgmap_altmap() usage.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
