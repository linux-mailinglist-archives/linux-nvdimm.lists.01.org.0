Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF51196FF2
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 04:58:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9EAD9202110DA;
	Tue, 20 Aug 2019 19:59:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 880052020D334
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 19:59:49 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y8so487860oih.10
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 19:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9TZ3h9XIXM46J9xL8jGJCgzDeloZeTOimF9MDrrQtC4=;
 b=qOorDm6PpWOQgpgNZ9zmOr4vJFD6fWmIZseaX2KpEDDmSUDSr1IXX+4fS6N4xb9YQ6
 JeafUS1hPydswBv2jT2nbmW5e3KtNqzCllW3DoP9Ivp9l7s1LyVGLvbQpCXmIdvbjGi/
 Vw7guluARa0Ip4m0K0RZ3094LcmC/4LVARQvNA1uJ509zGMVyPz87TGgjfE8Arwtj20D
 x+VHqobf5iooIqnblgEZSS3mBUK6ZgTXxWpTdtvQMussWhRgurBPgRBEAahbNXCcW47j
 WaLrZ5A2ALTQZeRCdgfEiHjxsTb1DXQJSIq0HNM1AdW9RXdtY9uDZbgW32ANNApRRZOC
 7F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9TZ3h9XIXM46J9xL8jGJCgzDeloZeTOimF9MDrrQtC4=;
 b=lLw38aHlJpSZKeiruBGke7cz5AFLX475tGjzSIyIzxWtdPg26HGx9iUPpwuIhYLwxI
 h3DXEMIFvgwZ2sEa+p/3tosvwnG4FcdQ2GYsjQxeQEoH1XyFUqUfVyyJp2FECRXtNFIJ
 FUekqwngniI4xwEf3cDegcHd3VjTtpvB/yRntRCxJzjjNFH5SemmP/yg8k6mt+0387ZT
 FQWdockZ+egZ4DmPTABRwlEHE6ALmxDaP1JdTjlACRZnSoGxAjA7PP1s99vzHy8OENSi
 td7bnaTP5mEDy356SQTp3PVcX1we9k596w+JUvXAFKQ5MASCo9yVIRq2dUf/IN8Q7VET
 i8/g==
X-Gm-Message-State: APjAAAXHkWWyX+8fnYCIpZB15cgQ68H4SMsM1xmNUwhdEFKS/xMtxdo4
 FiM/6hmnOSg5Vy9x/Gj3NiIX8RHdUXAKyrQodBw/yA==
X-Google-Smtp-Source: APXvYqzy0DftYJ4NNlH1NIMiV5YB0m8M/Dz1VUcVz6X5YJE31Eh5n7ME2g8Oz2MtJxGZ8nCBds6RncjxWyjh/YYH8Xg=
X-Received: by 2002:a05:6808:914:: with SMTP id
 w20mr2162912oih.73.1566356313559; 
 Tue, 20 Aug 2019 19:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190818090557.17853-1-hch@lst.de>
 <20190818090557.17853-3-hch@lst.de>
 <CAPcyv4iYytOoX3QMRmvNLbroxD0szrVLauXFjnQMvtQOH3as_w@mail.gmail.com>
 <20190820132649.GD29225@mellanox.com>
In-Reply-To: <20190820132649.GD29225@mellanox.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 20 Aug 2019 19:58:22 -0700
Message-ID: <CAPcyv4hfowyD4L0W3eTJrrPK5rfrmU6G29_vBVV+ea54eoJenA@mail.gmail.com>
Subject: Re: [PATCH 2/4] memremap: remove the dev field in struct dev_pagemap
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bharata B Rao <bharata@linux.ibm.com>, Linux MM <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Aug 20, 2019 at 6:27 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Aug 19, 2019 at 06:44:02PM -0700, Dan Williams wrote:
> > On Sun, Aug 18, 2019 at 2:12 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > The dev field in struct dev_pagemap is only used to print dev_name in
> > > two places, which are at best nice to have.  Just remove the field
> > > and thus the name in those two messages.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> >
> > Needs the below as well.
> >
> > /me goes to check if he ever merged the fix to make the unit test
> > stuff get built by default with COMPILE_TEST [1]. Argh! Nope, didn't
> > submit it for 5.3-rc1, sorry for the thrash.
> >
> > You can otherwise add:
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >
> > [1]: https://lore.kernel.org/lkml/156097224232.1086847.9463861924683372741.stgit@dwillia2-desk3.amr.corp.intel.com/
>
> Can you get this merged? Do you want it to go with this series?

Yeah, makes some sense to let you merge it so that you can get
kbuild-robot reports about any follow-on memremap_pages() work that
may trip up the build. Otherwise let me know and I'll get it queued
with the other v5.4 libnvdimm pending bits.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
