Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9346C442CD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 18:26:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8961C212966EA;
	Thu, 13 Jun 2019 09:26:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6750921296410
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 09:26:06 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w7so14893533oic.3
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 09:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wjBnZv2pCLDEwG4yb+2F3joyqEyCgCcLuoiul4+lDtg=;
 b=KHbKhiCEqP27YRm90NCLuB4c2IplNhmcOcBL7/TKZlk3SiaZQfwA9S0uY/GsQv03Pr
 aBL2AWfi8XTIFaky9LKQqE+K/NfNYYNrlmFC/I9jOaxHcs4tAfHfjcUQbqcl3RnXxild
 Tu3HngJ2BWQbjHKSA518A7LMdZsRAI0y2xoRezHhz45e3uyBcpgMb0voTy98I6u2hRnp
 NYEu7LcFVoYX1llZ3PhX+HJY3OdLwk1vk8E00NF1S8iWedYKuEKJl7E8AOFKwK6O5TC3
 f4HIkh3G/dWUfgrFHj9h1Gd+qxz3edzqRbXtlNTkaPme0fjX3JDzh/8PrIf6qw6dZLSg
 gtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wjBnZv2pCLDEwG4yb+2F3joyqEyCgCcLuoiul4+lDtg=;
 b=YlLT/3x8AkU/l5pMs058JeetfZ9FDAZRk+Fb44R/Fry34FU52KL49tHgT0aM8UQquU
 LQkteqyggjUVIXLuH4/x78Y7FJmggSevlzOzmu3j5F6G9hP0zFHXg/u0tG5KyjoIg/4n
 PoZsT+8jmlZD1y6jzRqsEhHoEPkflWf1m1jhxf2KI6xfYpAA8knDIHUk3DamCfC7Xw9l
 EavItCzuMpqmZZyo4D0oGskFtiO0u7TEY7hdAAlN+l+bD1jvEDowPp0lWqExqf0y9crx
 WrWpGfhHVLcNRxZZ6m3s+KzFt1rpH7PfLfvnw3lKhriqW9fASVeQ35mSVVk4z/oGlK57
 xuqg==
X-Gm-Message-State: APjAAAWxDu2UelCfbuwCNm7d6SRAD4qXJrH2Odt/gAipczVOwY0lfhiJ
 3YNZDVJPOUD3I5KQNN8rQxn664w4mXgMKz0z+bS7aA==
X-Google-Smtp-Source: APXvYqyIpO3hOidIsXLbc4Y7aCrEkKlPPSiQhXNkmA/XJwYbaL526BswBcBQAMtK33IEuzEN5c+1wA+6c6zViqiveWY=
X-Received: by 2002:aca:7c5:: with SMTP id 188mr3423005oih.70.1560443165189;
 Thu, 13 Jun 2019 09:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
 <20190612102917.GB14578@quack2.suse.cz> <20190612114721.GB3876@ziepe.ca>
 <20190612120907.GC14578@quack2.suse.cz> <20190612191421.GM3876@ziepe.ca>
 <20190612221336.GA27080@iweiny-DESK2.sc.intel.com>
 <CAPcyv4gkksnceCV-p70hkxAyEPJWFvpMezJA1rEj6TEhKAJ7qQ@mail.gmail.com>
 <20190612233324.GE14336@iweiny-DESK2.sc.intel.com>
 <CAPcyv4jf19CJbtXTp=ag7Ns=ZQtqeQd3C0XhV9FcFCwd9JCNtQ@mail.gmail.com>
 <20190613151354.GC22901@ziepe.ca>
In-Reply-To: <20190613151354.GC22901@ziepe.ca>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 13 Jun 2019 09:25:54 -0700
Message-ID: <CAPcyv4hZsxd+eUrVCQmm-O8Zcu16O5R1d0reTM+JBBn7oP7Uhw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Dave Chinner <david@fromorbit.com>, Jeff Layton <jlayton@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-xfs <linux-xfs@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 13, 2019 at 8:14 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jun 12, 2019 at 06:14:46PM -0700, Dan Williams wrote:
> > > Effectively, we would need a way for an admin to close a specific file
> > > descriptor (or set of fds) which point to that file.  AFAIK there is no way to
> > > do that at all, is there?
> >
> > Even if there were that gets back to my other question, does RDMA
> > teardown happen at close(fd), or at final fput() of the 'struct
> > file'?
>
> AFAIK there is no kernel side driver hook for close(fd).
>
> rdma uses a normal chardev so it's lifetime is linked to the file_ops
> release, which is called on last fput. So all the mmaps, all the dups,
> everything must go before it releases its resources.

Oh, I must have missed where this conversation started talking about
the driver-device fd. I thought we were talking about the close /
release of the target file that is MAP_SHARED for the memory
registration. A release of the driver fd is orthogonal to coordinating
/ signalling actions relative to the leased file.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
