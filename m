Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9725421E2E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 21:26:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 94D7721260A59;
	Fri, 17 May 2019 12:25:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=keescook@chromium.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8D22421250450
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 12:25:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g69so3768406plb.7
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 12:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6m950k0wpGbiOzwRM0Zmf6vFeYvepUmTaDILG4jsOaE=;
 b=MRIUWXTdcwy3u1sW6nKHueYTSpb0gJ7fF8cYZVlfUuPds94ETgvDpGDxvTp+t1DlXI
 4AS+i7KmUjpAsXiZRYObHC7OVDJTf5O0aN4echqrlAa/dV2kkHUWDEIBh4xDmFPN2mZI
 OV8PFvr7njJVJaL9n7a1Kz3M75K/90YxuX/n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6m950k0wpGbiOzwRM0Zmf6vFeYvepUmTaDILG4jsOaE=;
 b=YTZXHbOTKjubTZsiYCw45wOKsZ/ihjZoHD5YLbahtCdHSaoMermcAi3t7xIIIvO+Uv
 P+vc6hgeFgJjzGi7LRSuwjKz+3hYuccTnxaHYI6Jev5PZUywPwX2EnJPifA27e785odT
 UvSdIVSlK7HGSuokXSUKbAfOko4f+0iax0vTudtUQh3UNZk1/TMglzVWyBRTfCUT3qKZ
 rNA4W/7+6vaxl0VeuSaiRP06ZnUYbyt8xaSeGCc0UrEpP/9SnyZxkJ2RH2ajS+QUDYa5
 rLykJrOg1zUQP/YEniwGFPoASMOgqkVKpfiTGHj3EVitXS12hQv3j8diVlQh4nu4XmEl
 qBcw==
X-Gm-Message-State: APjAAAWOP1x7i+zDB1Ph5hoxJWAquzrt3wVeR5ozNMpZPOWfkaVQzkme
 PXUsPzOXV4+yNNzgmMvsIL3R+g==
X-Google-Smtp-Source: APXvYqx1H180sw6ugMRwdB57GS4R9rz+Su7MJuu5k1RoAAIBbeI3A+RJSaekWJWtXdGn9n8Fk40Phg==
X-Received: by 2002:a17:902:2d03:: with SMTP id
 o3mr23240811plb.309.1558121156947; 
 Fri, 17 May 2019 12:25:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id g22sm11186901pfo.28.2019.05.17.12.25.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 May 2019 12:25:55 -0700 (PDT)
Date: Fri, 17 May 2019 12:25:54 -0700
From: Kees Cook <keescook@chromium.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
Message-ID: <201905171225.29F9564BA2@keescook>
References: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190517084739.GB20550@quack2.suse.cz>
 <CAPcyv4iZZCgcC657ZOysBP9=1ejp3jfFj=VETVBPrgmfg7xUEw@mail.gmail.com>
 <201905170855.8E2E1AC616@keescook>
 <CAPcyv4g9HpMaifC+Qe2RVbgL_qq9vQvjwr-Jw813xhxcviehYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4g9HpMaifC+Qe2RVbgL_qq9vQvjwr-Jw813xhxcviehYQ@mail.gmail.com>
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
 Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 17, 2019 at 10:28:48AM -0700, Dan Williams wrote:
> On Fri, May 17, 2019 at 8:57 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, May 17, 2019 at 08:08:27AM -0700, Dan Williams wrote:
> > > As far as I can see it's mostly check_heap_object() that is the
> > > problem, so I'm open to finding a way to just bypass that sub-routine.
> > > However, as far as I can see none of the other block / filesystem user
> > > copy implementations submit to the hardened checks, like
> > > bio_copy_from_iter(), and iov_iter_copy_from_user_atomic() . So,
> > > either those need to grow additional checks, or the hardened copy
> > > implementation is targeting single object copy use cases, not
> > > necessarily block-I/O. Yes, Kees, please advise.
> >
> > The intention is mainly for copies that haven't had explicit bounds
> > checking already performed on them, yes. Is there something getting
> > checked out of the slab, or is it literally just the overhead of doing
> > the "is this slab?" check that you're seeing?
> 
> It's literally the overhead of "is this slab?" since it needs to go
> retrieve the struct page and read that potentially cold cacheline. In
> the case where that page is on memory media that is higher latency
> than DRAM we get the ~37% performance loss that Jeff measured.

Ah-ha! Okay, I understand now; thanks!

> The path is via the filesystem ->write_iter() file operation. In the
> DAX case the filesystem traps that path early, before submitting block
> I/O, and routes it to the dax_iomap_actor() routine. That routine
> validates that the logical file offset is within bounds of the file,
> then it does a sector-to-pfn translation which validates that the
> physical mapping is within bounds of the block device.
> 
> It seems dax_iomap_actor() is not a path where we'd be worried about
> needing hardened user copy checks.

I would agree: I think the proposed patch makes sense. :)

-- 
Kees Cook
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
