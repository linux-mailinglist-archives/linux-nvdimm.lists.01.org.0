Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72BB23C5C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 May 2019 17:41:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9CE4C21A07093;
	Mon, 20 May 2019 08:41:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6FE6A211EDB56
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 08:41:01 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g18so13369764otj.11
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5QSUm6/xL4WGvvJmVrGCi+MUsTk2A8AVb5uoylgpYm0=;
 b=yPev5JIATuPBAUeewEekviqNSsYEYMPVj34Ea7J3VHdDWfkJJm/Lss37NJzZXuSbcC
 YRWqEDzGwnKyGJ7cfmBUCwLnOU/8qZso7KUyoxCpR1o8jo9s6hM/D8+pnibzSAEiHUth
 qmci2Y5QYlrrWb6PkGnzvPjqxjjWW/5HxgR5KoDHlQ/Byo2F5xDeeHmYv19+at8R+TMZ
 tu+Vu2APi20B80NNxCZHFz3fpj9rYA8GEe82GaUHJ8I6t+MvUs+Ar9a+Vgx2EB76jf89
 ErQzIHthFAPF1mpVWGOYtN71zpeES9K3vrWlKWx5qmwTMgZWKug91Di3ce4BOAyUnJfW
 dKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5QSUm6/xL4WGvvJmVrGCi+MUsTk2A8AVb5uoylgpYm0=;
 b=ZffoLLKJq712wxwveF0JVi9iM3qMvySrgCx2cvPpMUKhjS9vk8CD5ML306i7pFvWO/
 Eb5hkkUGBsbsHH2+FaKbf964+kGidHa2MnW84WrkVf0CTzWfRH49Ou6TS3UcArbbkULj
 oGa5XCGoPb4TCsNpvL/Vr7AIyUa84hPkuej/EhIbaK5TxoqYlSbBXzkq3iyv732IwLz5
 6avJQbSJsINW0ZNpTo6Qu8wBf3i/S7uMn2TtLhO2x17ePyxkSboS0drI1uG3KVzavm2v
 SaQUu2BmSBuy8VqP7CK79tKllb2Or6rylnfk5ShCLIiPj1wPB+MWpZnxa6pVnKcggWHH
 r6rA==
X-Gm-Message-State: APjAAAVyi1E7EpWr52v48ptTOwX68tyyzppa5xiggUy5umpP6FKLecME
 1vJYuh3B9Ae0XvhDsChj20UFZbV5tzpms59zn7bMtA==
X-Google-Smtp-Source: APXvYqxs3KuEEqHCDOtKW83Hc+3/Eh7qrrFqOEiop9JaJSWQJfM8wgC/rkaym0C4K7iuUNGIYwsqH+mgvaYu198CCOk=
X-Received: by 2002:a05:6830:1182:: with SMTP id
 u2mr34065267otq.71.1558366859535; 
 Mon, 20 May 2019 08:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190517084739.GB20550@quack2.suse.cz>
 <CAPcyv4iZZCgcC657ZOysBP9=1ejp3jfFj=VETVBPrgmfg7xUEw@mail.gmail.com>
 <201905170855.8E2E1AC616@keescook>
 <CAPcyv4g9HpMaifC+Qe2RVbgL_qq9vQvjwr-Jw813xhxcviehYQ@mail.gmail.com>
 <201905171225.29F9564BA2@keescook>
 <CAPcyv4iSeUPWFeSZW-dmYz9TnWhqVCx1Y1VjtUv+125_ZSQaYg@mail.gmail.com>
 <20190520075232.GA30972@quack2.suse.cz>
In-Reply-To: <20190520075232.GA30972@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 20 May 2019 08:40:48 -0700
Message-ID: <CAPcyv4hwiKGDtkT7-r8Ei3kOQBMA3LwDGBNM9H8N6HC5fxi6tw@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
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
Cc: Jeff Smits <jeff.smits@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Kees Cook <keescook@chromium.org>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, May 20, 2019 at 12:52 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 18-05-19 21:46:03, Dan Williams wrote:
> > On Fri, May 17, 2019 at 12:25 PM Kees Cook <keescook@chromium.org> wrote:
> > > On Fri, May 17, 2019 at 10:28:48AM -0700, Dan Williams wrote:
> > > > It seems dax_iomap_actor() is not a path where we'd be worried about
> > > > needing hardened user copy checks.
> > >
> > > I would agree: I think the proposed patch makes sense. :)
> >
> > Sounds like an acked-by to me.
>
> Yeah, if Kees agrees, I'm fine with skipping the checks as well. I just
> wanted that to be clarified. Also it helped me that you wrote:
>
> That routine (dax_iomap_actor()) validates that the logical file offset is
> within bounds of the file, then it does a sector-to-pfn translation which
> validates that the physical mapping is within bounds of the block device.
>
> That is more specific than "dax_iomap_actor() takes care of necessary
> checks" which was in the changelog. And the above paragraph helped me
> clarify which checks in dax_iomap_actor() you think replace those usercopy
> checks. So I think it would be good to add that paragraph to those
> copy_from_pmem() functions as a comment just in case we are wondering in
> the future why we are skipping the checks... Also feel free to add:
>
> Acked-by: Jan Kara <jack@suse.cz>

Will do, thanks Jan.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
