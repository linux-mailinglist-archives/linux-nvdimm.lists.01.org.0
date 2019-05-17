Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193AF21C01
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 18:49:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 678C121274216;
	Fri, 17 May 2019 09:48:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com;
 envelope-from=keescook@chromium.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CBB4D21243BAB
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 09:40:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a5so3569423pls.12
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4baC9hVmPvCMRjjnr6WrMvdeGCowj8DhAHmgc2PUmc8=;
 b=b9XzwC9QDGBg9qLVMgJWRML5ZZz5Kd9Me3loTz5rnrV+Gm+nteKj0X6uqTPOiPnXUu
 AD7VHIV6giGlxx5J7w4vopdCZSjd47gFjQ9n+/adpvlKujkJMtOb2XKfI408I29n0AnW
 96QnHtqye/BCD+PLwXdbtsaFDBqofGB940e0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4baC9hVmPvCMRjjnr6WrMvdeGCowj8DhAHmgc2PUmc8=;
 b=eqno5sPRRiNrRBPG8/pVfL+QUuuCxK4SUNEp23DxtO53+Ff100iKIjaV9ap3gdWLmR
 DmZcdfEdEok/Ylu+eS1jeVbW3nSRseqo8lJhrHsCJFPSjfb2tltyPD2zOn2ATP0NUuSN
 FMbuJjNt4GMHZUEd5bajUzCaNH/qzRWivtHQ3AdB8bx2D9mzHxkDFtjvDNUMtWYtId0a
 lQIVsBQZuQfcrVGfLM07tJu4rtEudQVbX/XKK6PXOJgSgZSrPYk0eURKKDaF2VfIb1AE
 knFcUxcRSNAWW/lKkgWtB+uA3YRB1hgVQuY6So1VQxsKhomzsaGkAT7HDeuEBCzJvFAg
 E/hg==
X-Gm-Message-State: APjAAAWznlT3uu+hdVG8pftnihRySetuxcCr+6FOhdwo4+T0o03GMdXq
 BO0u+pZyJy6l22Wh17RINcgbbg==
X-Google-Smtp-Source: APXvYqxT4MWydQqGVRl8y+8BCJCWqRoi8v5dpo8YXASLwcoHuift9vY3I4Y0ejr9OwtLsAO8IKoMAA==
X-Received: by 2002:a17:902:778d:: with SMTP id
 o13mr1115077pll.275.1558111233247; 
 Fri, 17 May 2019 09:40:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id d186sm14225137pfd.183.2019.05.17.09.40.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 May 2019 09:40:32 -0700 (PDT)
Date: Fri, 17 May 2019 09:40:31 -0700
From: Kees Cook <keescook@chromium.org>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
Message-ID: <201905170938.99AACF0D@keescook>
References: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190517084739.GB20550@quack2.suse.cz>
 <2d8b1ba7890940bf8a512d4eef0d99b3@AcuMS.aculab.com>
 <201905170845.1B4E2A03@keescook>
 <ac76e29576b14fcb9a18e5a9e6ab8394@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ac76e29576b14fcb9a18e5a9e6ab8394@AcuMS.aculab.com>
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

On Fri, May 17, 2019 at 04:14:03PM +0000, David Laight wrote:
> From: Kees Cook
> > Sent: 17 May 2019 16:54
> ...
> > > I've changed some of our code to use __get_user() to avoid
> > > these stupid overheads.
> > 
> > __get_user() skips even access_ok() checking too, so that doesn't seem
> > like a good idea. Did you run access_ok() checks separately? (This
> > generally isn't recommended.)
> 
> Of course, I'm not THAT stupid :-)

Right, yes, I know. :) I just wanted to double-check since accidents
can happen. The number of underscores on these function is not really
a great way to indicate what they're doing. ;)

-- 
Kees Cook
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
