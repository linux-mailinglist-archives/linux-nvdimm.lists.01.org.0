Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2271321AFD
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 17:54:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 72DC521275462;
	Fri, 17 May 2019 08:53:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com;
 envelope-from=keescook@chromium.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 755412126D82A
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 08:53:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id n19so3896719pfa.1
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DeWYh2wXHt0SGoJqX0T0F4RONBrBgIxGbZCJ2kdSH6I=;
 b=kP5ojcPfRjRGKbxsO4pF79WW/kSRZaLu97/2LsHLFWXmA56eKS99Mt+3JVChAIHpWm
 /edz0dqcheadE+lCi2SLduXDhlV/p2PinTyIt4lzceJGxetX1fUXdKy/JmwgB4UYvVNK
 Brmr62mRz4mVtq7sVy58XKgfbiMqAH/4IEa8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DeWYh2wXHt0SGoJqX0T0F4RONBrBgIxGbZCJ2kdSH6I=;
 b=KJ7dN5tYhWEEJkxk3+2a6T1h5oEI8TMnsLxsZuTp/qAY5sVLkMknD6VFWKtgysAcEu
 oBkT5OBkX52jN3Lb5wmIVl5KX5DMn0r4+yw1Yn9mE354PSacYUlPm6C+m9BijEXJdOig
 8iC9R1lY4/c6pRADmnzm/QQ6PVPSdMGahh2J886AMnZMfpJU+vk6mBjELoT5xJu/eFSa
 GXk3jLxq9Hf5cMEHBcyXcyE7Lj2viohPEA/m6BKs9CRrVoNKZ4zX4fkt1W0k7XairgV3
 ie14EIZZVI8YPKbPp9DePkzKguGFpRx790XXuOogiHzGKsCs44cQQWv2RzvJGXGZQD8W
 jWIw==
X-Gm-Message-State: APjAAAVwVlu5M0Pc6LtX0C0pFAHwKkDxA9/Z/TMN8z81doNvVaF6Z/xC
 z2Fi21KHrQAccbZ0TUVjPfDzGQ==
X-Google-Smtp-Source: APXvYqyvXdwCR61IEEY49hfPBp0/QulW7H4+PkBv7xWEeGfEdGz2OO8yjJsd70M5DeFCJZN6lhnfqQ==
X-Received: by 2002:a62:8893:: with SMTP id l141mr4899472pfd.261.1558108436771; 
 Fri, 17 May 2019 08:53:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id m12sm5169259pgi.56.2019.05.17.08.53.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 May 2019 08:53:55 -0700 (PDT)
Date: Fri, 17 May 2019 08:53:54 -0700
From: Kees Cook <keescook@chromium.org>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
Message-ID: <201905170845.1B4E2A03@keescook>
References: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190517084739.GB20550@quack2.suse.cz>
 <2d8b1ba7890940bf8a512d4eef0d99b3@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2d8b1ba7890940bf8a512d4eef0d99b3@AcuMS.aculab.com>
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
 'Jan Kara' <jack@suse.cz>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Al Viro <viro@zeniv.linux.org.uk>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 17, 2019 at 09:06:26AM +0000, David Laight wrote:
> From: Jan Kara
> > Sent: 17 May 2019 09:48
> ...
> > So this last paragraph is not obvious to me as check_copy_size() does a lot
> > of various checks in CONFIG_HARDENED_USERCOPY case. I agree that some of
> > those checks don't make sense for PMEM pages but I'd rather handle that by
> > refining check_copy_size() and check_object_size() functions to detect and
> > appropriately handle pmem pages rather that generally skip all the checks
> > in pmem_copy_from/to_iter(). And yes, every check in such hot path is going
> > to cost performance but that's what user asked for with
> > CONFIG_HARDENED_USERCOPY... Kees?
> 
> Except that all the distros enable it by default.
> So you get the performance cost whether you (as a user) want it or not.

Note that it can be disabled on the kernel command line, but that seems
like a last resort. :)

> 
> I've changed some of our code to use __get_user() to avoid
> these stupid overheads.

__get_user() skips even access_ok() checking too, so that doesn't seem
like a good idea. Did you run access_ok() checks separately? (This
generally isn't recommended.)

The usercopy hardening is intended to only kick in when the copy size
isn't a builtin constant -- it's attempting to do a bounds check on
the size, with the pointer used to figure out what bounds checking is
possible (basically "is this stack? check stack location/frame size"
or "is this kmem cache? check the allocation size") and then do bounds
checks from there. It tries to bail out early to avoid needless checking,
so if there is some additional logic to be added to check_object_size()
that is globally applicable, sure, let's do it.

I'm still not clear from this thread about the case that is getting
tripped/slowed? If you're already doing bounds checks somewhere else
and there isn't a chance for the pointer or size to change, then yeah,
it seems safe to skip the usercopy size checks. But what's the actual
code that is having a problem?

-- 
Kees Cook
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
