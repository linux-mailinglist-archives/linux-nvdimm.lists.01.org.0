Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E440A21B0B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 17:56:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E28CF21275462;
	Fri, 17 May 2019 08:56:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=keescook@chromium.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A055621BC6A80
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 08:56:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r18so3524426pls.13
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nrqjUKLpsCtJJ04ErApfFg0RR5DmaSuhMiOpsYm4b/k=;
 b=E7oWj3DDjt+kEdZeewfLumYWCuhjVUc/osh0djljunRfkteN7XJXNs5MS+RX5GI/Lq
 Puj3Z3HgxCD/6AC6HOECerm430xm+nTSbJv05r7At57ftXWvGwRJYxFFEUoVKbSOr4Gr
 iBqixCpWNw+8db7SWpOHdiN1vkT5zH1by9VEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nrqjUKLpsCtJJ04ErApfFg0RR5DmaSuhMiOpsYm4b/k=;
 b=R2ux/CN8zxe3fa1PWJoiAEZQ6vHQY8YShfjwgKwZ2drNzyh9beh2s6hzZz+AjJj+Oc
 QB3w0vszig8SI8ktzU2Jq8Sbsgwmf70XpHc2zphuiYTBf+upSJvVe5J/kL2efVhaRW/5
 dLMWU7eCxuDnBLE+mabYRGHrhEXtQszqf3DMb8Vk0xVkAop2s3GRGO9RAcOVOvMkCowb
 ncCztD2ThN21RVHEAvH7WJsn30rfIuqP941KHN0fPLSLfSMmro3Kw5KdjYVYv9t7fm8G
 JG9RKVbnwmU628ZpKF6xkwQPmHIA9I50Vd5ePYkdgD1PbihMGmKORMWA3gJhkegAM1QT
 gvYA==
X-Gm-Message-State: APjAAAXe4+dCMvzUIdBkXFoVxd+3BpLA92+02PZFVnRDDGGcdd9yDc+1
 c7oe6zd8kdFQF2sQ4fcEElf1MA==
X-Google-Smtp-Source: APXvYqx5L1JIW0KgYJL4c2qH5Z+VHBDccN7Wk+p90g4IAEzcge2qHeMGOakMMnS0HM9WEXWMQfyTKA==
X-Received: by 2002:a17:902:2bc9:: with SMTP id
 l67mr21517345plb.171.1558108614314; 
 Fri, 17 May 2019 08:56:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id 2sm11532199pgc.49.2019.05.17.08.56.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 May 2019 08:56:53 -0700 (PDT)
Date: Fri, 17 May 2019 08:56:52 -0700
From: Kees Cook <keescook@chromium.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
Message-ID: <201905170855.8E2E1AC616@keescook>
References: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190517084739.GB20550@quack2.suse.cz>
 <CAPcyv4iZZCgcC657ZOysBP9=1ejp3jfFj=VETVBPrgmfg7xUEw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4iZZCgcC657ZOysBP9=1ejp3jfFj=VETVBPrgmfg7xUEw@mail.gmail.com>
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

On Fri, May 17, 2019 at 08:08:27AM -0700, Dan Williams wrote:
> As far as I can see it's mostly check_heap_object() that is the
> problem, so I'm open to finding a way to just bypass that sub-routine.
> However, as far as I can see none of the other block / filesystem user
> copy implementations submit to the hardened checks, like
> bio_copy_from_iter(), and iov_iter_copy_from_user_atomic() . So,
> either those need to grow additional checks, or the hardened copy
> implementation is targeting single object copy use cases, not
> necessarily block-I/O. Yes, Kees, please advise.

The intention is mainly for copies that haven't had explicit bounds
checking already performed on them, yes. Is there something getting
checked out of the slab, or is it literally just the overhead of doing
the "is this slab?" check that you're seeing?

-- 
Kees Cook
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
