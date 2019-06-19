Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 095FB4BE09
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Jun 2019 18:27:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 703F521296B07;
	Wed, 19 Jun 2019 09:27:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2B53D2128A631
 for <linux-nvdimm@lists.01.org>; Wed, 19 Jun 2019 09:27:48 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z23so19884431ote.13
 for <linux-nvdimm@lists.01.org>; Wed, 19 Jun 2019 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sYm3Qu3GmGDbz1iuXTNe7mnFVkd+TNgT0k6IWwxysEE=;
 b=bQxaHy910j6x38V8Y/vXBzNsIRs9m485vwvTdEtDdezgAlfp4sbeCqQJDrgzlVd/2X
 cA7ywo2xqJRXweho1/Tk3BlC4M5zGpUElK5yQp6xAwBf7D+nnGLVOlNWoXbopMsjYAf/
 mYzE2L9ds2G5UFPq7wxbGsdf7sBJ9ZOPYyLdSTRI7xT2c4YUEjVc0Alm83+eoAHZspF9
 qSTPs3HQA1k9eWtmhp3yT+4TAf2czjK5Ofa1X2so4Y5Kvw6aXlTxpIGW7Q1b1PhDTbqL
 /Mt5QOPpJrXSTf/PYdwS1K4nrv9uKYMaLfgGaUkwKsiJlG0+cwiaCgQfia7efDjLeBe2
 7dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sYm3Qu3GmGDbz1iuXTNe7mnFVkd+TNgT0k6IWwxysEE=;
 b=o0YfFcUt8/s7no/Epzkqwf0KgMiJfgnwEeFLPXUfuUwZYykBbgClyZ5Wj0i0vigXGp
 Iw59rjj8cIltlhmqK/jW6UFKsQdvTXpgUuJX122hia6MvMU/nrYzW0xO1k7D/jfPJP6o
 i+YH/JlENCWtOR2GevTxL/BPK12VzVSVvRte/9zJVlqX+3KI9SLn7XOV+4uPUDBQt51p
 d4mCHM9Kra9cIKLarTacJxod9j+jf94k8hqQ8lHUILdnGu7D8yPBI8jqCpGqVKKU9maU
 AtuQWH0A/6eB222hSDDcZmk7pmp/hRvKhs5CMPHspx17cpL9sJLnrjOODPtdI83NBnn1
 OHxQ==
X-Gm-Message-State: APjAAAW+FKI8CfG540aTnsR6AVRXvS6wJgWI6ipd63WnJdsXT1LbWYYH
 /8OM4GBVWd531Af523QtY+8JJ2D1bjwbIHMqOCfzdQ==
X-Google-Smtp-Source: APXvYqyPiqsjOVAtYsRiCTCDyTqNTQ8I78Y7xY6a9lxN195JvlaNEod1fL5YZ587kRZQU+mrqYASgfo65cFu2zdLthE=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr9628583oto.207.1560961667174; 
 Wed, 19 Jun 2019 09:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <156080474760.3765313.13075804303259765566.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190619112302.GA10534@lst.de>
In-Reply-To: <20190619112302.GA10534@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 19 Jun 2019 09:27:36 -0700
Message-ID: <CAPcyv4gLOqgRLiVoVJiSaY=QE=yOO0mg04oDFe+jXRj=G2xJRA@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: Enable unit test infrastructure compile checks
To: Christoph Hellwig <hch@lst.de>
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
Cc: =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 19, 2019 at 4:23 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 17, 2019 at 01:52:27PM -0700, Dan Williams wrote:
> > The infrastructure to mock core libnvdimm routines for unit testing
> > purposes is prone to bitrot relative to refactoring of that core.
> > Arrange for the unit test core to be built when CONFIG_COMPILE_TEST=y.
> > This does not result in a functional unit test environment, it is only a
> > helper for 0day to catch unit test build regressions.
>
> Looks fine:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> I'm still curious what the point of hiding kernel code in tools/
> is vs fully integrating it with the build system.

The separation of tools/ is due to way the "--wrap=" ldflag behaves.
It can only wrap symbols across a module linking boundary. So to
produce a setup where libnvdimm is ingesting faked responses it all
needs to be built as external modules and relinked.

It's an inelegant way to get some test coverage beyond what qemu-kvm
can do, my hope is that down the road I can use the new Kunit
infrastructure to do something similar in a cleaner / more formal way.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
