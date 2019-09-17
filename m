Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D2AB57D9
	for <lists+linux-nvdimm@lfdr.de>; Tue, 17 Sep 2019 23:59:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5CEB121A07A92;
	Tue, 17 Sep 2019 14:58:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D393C2020F949
 for <linux-nvdimm@lists.01.org>; Tue, 17 Sep 2019 14:58:43 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id e18so4295692oii.0
 for <linux-nvdimm@lists.01.org>; Tue, 17 Sep 2019 14:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EW2X0pQcIs7IJCWHWbHBXgfW46P4WEaokqNG2sfuxAw=;
 b=b/X/epPQZvb6OMWkt3514aW9hqQaZrBWb5oRo9t5edo0vozE7mTuXDkbTXriqLoDW/
 7Lpvi/9JIpTNEoEaggzKS3c9BnQE/bWnb654MfzXAJiqtGubvaYUNoeRQY5b0fpbxhcD
 FTdD9L29UX/qm8jcbV9FJoD37EPZivjfBJJ4vawRi5z28eD2KZR6xqWnVyQPBTyuPwm4
 57f5Fk4dstqlRQm2abRzRFEVRoccjyPyyr1CAFZ3Umi45T5j+YTVY3kiUmY2xOx7v0QB
 NVpC00klzKEkF/2JKk87Y1cjVR5AdEYKn3OYS7BunXeat8pzVAqYYlu1dzWT6FLQo/pa
 tSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EW2X0pQcIs7IJCWHWbHBXgfW46P4WEaokqNG2sfuxAw=;
 b=PNUcw6FAcOaa+7Vxef2Y8a46YGhwQEGlETSLriNyerC3wdSS4XvzEtYH4iKga/lTN3
 SCvDdBC+VCi467JI+LcSFOftnOcEzrMgx4z9ChMCvwIAbVHPskFuOoodV36VL/MDC5CA
 zBJVYT26vbenP2ywSp5czMobTFJnpvaIpE7rifFDA00EuyWxNZc476iUbv/gLYPuGiEt
 RH9O2/7559p0Upv3YmDDJbeyW3yzpx/B10HHSL8o3lBNygtJrFqCgIUjRWfxqM9Z2r/l
 er5rIGvNIqPXkAFfsfoy/prgm4EujLdzu3mt/ZOp/ynXkY8pZEOMu0VgCkK2VC75SqLH
 ep8g==
X-Gm-Message-State: APjAAAXrxF1P+9YCrd/TdRcEptWONET1gIfd+DncwWs8LVFFo8RPMFdl
 IF3PKT//1ZNGcr+O/ced5W8POXAUpWVn/B4tF78ItA==
X-Google-Smtp-Source: APXvYqzQPYBb+qMxeV1bDUw+oSHDBJ2boy2cSrkRRU5vlbjTkrG6EugFukBx4w0hTijgZ77pPvyEDk3fuZbESEyn/gI=
X-Received: by 2002:aca:eb09:: with SMTP id j9mr212586oih.105.1568757563411;
 Tue, 17 Sep 2019 14:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <20190913010937.7fc20d93@lwn.net> <20190913114849.GP20699@kadam>
 <20190917161608.GA12866@ziepe.ca>
In-Reply-To: <20190917161608.GA12866@ziepe.ca>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 17 Sep 2019 14:59:11 -0700
Message-ID: <CAPcyv4jR9ufeXyXOwnnPBC2kbHNfamZu93s4hM371=j-sACAjA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
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
Cc: Jens Axboe <axboe@kernel.dk>,
 ksummit <ksummit-discuss@lists.linuxfoundation.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Jonathan Corbet <corbet@lwn.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Sep 17, 2019 at 9:16 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Sep 13, 2019 at 02:48:50PM +0300, Dan Carpenter wrote:
>
> > It used to be that infiniband used "sizeof foo" instead of sizeof(foo)
> > but now there is a new maintainer.
>
> These days I run everything through checkpatch and generally don't
> want to see much deviation from the 'normal' style, a few minor
> clang-format quibbles and other check patch positives excluded.
>
> This means when people touch lines they have to adjust minor things
> like the odd 'sizeof foo' to make it conforming.
>
> Like others there is a big historical mismatch and the best I hope for
> is that new stuff follow the cannonical style. Trying to guess what
> some appropriate mongral style is for each patch is just a waste of my
> time.
>
> I also hold drivers/infiniband as an example of why the column
> alignment style is harmful. That has not aged well and is the cause of
> a lot of ugly things.
>
> > There is one subsystem where the maintainer is super strict rules that
> > you can't use "I" or "we" in the commit message.  So you can't say "I
> > noticed a bug while reviewing", you have to say "The code has a bug".
>
> Ah, the imperative mood nitpick. This one is very exciting to explain
> to non-native speakers. With many regular submitters I'm still at the
> "I wish you would use proper grammer and sentence structure" phase..
>
> These days I just end up copy editing most of the commit messages :(
>
> > I don't think it's shaming, I think it's validating.  Everyone just
> > insists that since it's written in the Book of Rules then it's our fault
> > for not reading it.  It's like those EULA things where there is more
> > text than anyone can physically read in a life time.
>
> Yeah, I tend to agree.
>
> The big special cases with high patch volumes (net being the classic
> example) should remain special.
>
> But everyone else is not special, and shouldn't act the same.
>
> The work people like DanC do with static analysis is valuable, and we
> should not be insisting that those contributors have to jump through a
> thousand special hoops.
>
> I have simply viewed it as the job of the maintainer to run the
> process and deal with minor nit picks on the fly.
>
> Maybe that is what we should be documenting?

In theory, yes, in practice, as long as there is an exception to the
rule, it comes down to a question of "is this case special like net or
not?". I'd rather not waste time debating that on a per-subsystem
basis vs just getting it all documented for contributors.

I do think it is worth clarifying in the guidelines of writing a
profile to make an effort to not be special, and that odd looking
rules will be questioned (like libnvdimm statement continuation), but
lets not fight the new standards fight until it becomes apparent where
the outliers lie.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
