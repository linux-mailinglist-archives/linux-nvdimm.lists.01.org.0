Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F357B8AE64
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 07:03:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B20692131BA2C;
	Mon, 12 Aug 2019 22:05:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 669222130A4E6
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 22:05:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w2so63296pfi.3
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 22:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4cO9jrOGgF5wujsFXMHtoYNXvgUhydDYlF08f1pq39E=;
 b=IJDEFp+tZg956HdkEB/yKpoKHOFoi1PcVpOx5zPUJll5AJ5C8M+CFwUO+F8F8Q/rit
 8HcowooFg6ntqkIFuj6R4k+GwmJgIitCqOV2QvGuxn7m9MQGXg9qvC85ytvNf5bcYus+
 EprLmHUXh9bThNArfUe3XOKZVbo/EBN6VgqZBcT95WmmKJTlRd528A9f6TQgIETjut1/
 wI8daRdYTmSq6wYQl4NTMhJ/qVqO63tEGOCbSOifsskf9GK6VMybLklO81hLBeB9tly/
 80uCE+R8Iy4Fzfqk20iE8S9pCq3TNIClCmZ4T12ccP5rxSYxtRJSh6xSaDrQfj2wM6vG
 UTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4cO9jrOGgF5wujsFXMHtoYNXvgUhydDYlF08f1pq39E=;
 b=dxO08U3iLErigoEjKcD2a41yC9mIqyjOK2gezRrY+uzag0AQvEY5f7tBFQPT/ILpng
 kTVm0WKe88hNmuX9E3XgNJBPvRQ8eJ51KZ7AR/XUeT5ZIVWVfOcUoWfmDePBaqbqq0O4
 1Ta/C69WJX278fppWX5g0HyNZcHiuuXMJGAfKoDfTylz40YPeLJmEXHrAMkZaJWTf1QQ
 IXiL4Y9MSiHi1qtYFUl81LoRLHWvY78u6paRlrDVDtdP4qbLZwl1V6ZVcLZ+2UPqd0Tj
 /CmbsdvWSWLCM7ROwl8QVaYYDFHb22FWvnZjQi+IxjCbMpgm622nKGbLFUKxVp5ZyLP8
 5YXw==
X-Gm-Message-State: APjAAAXmt96uBrXdieYnEz/ZXCjXVf/4+RHb+r6KWnZA8e683QNWzDXn
 ui6umPN7pp9vQTU4iaV/BoJkYgGZPLlomUb7wtx5pg==
X-Google-Smtp-Source: APXvYqxe3Yuc1/IPYBDWpkhdxK9MrqBlpBCfUzv/UyMf8npsBcj76TlFOcJ9beMy4gx9z+/oMn0KOERMMEUsJXLW4tU=
X-Received: by 2002:aa7:8f2e:: with SMTP id y14mr9786090pfr.113.1565672590442; 
 Mon, 12 Aug 2019 22:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-4-brendanhiggins@google.com>
 <20190812225520.5A67C206A2@mail.kernel.org>
 <20190812233336.GA224410@google.com>
 <20190812235940.100842063F@mail.kernel.org>
 <CAFd5g44xciLPBhH_J3zUcY3TedWTijdnWgF055qffF+dAguhPQ@mail.gmail.com>
 <20190813045623.F3D9520842@mail.kernel.org>
In-Reply-To: <20190813045623.F3D9520842@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 12 Aug 2019 22:02:59 -0700
Message-ID: <CAFd5g46PJNTOUAA4GOOrW==74Zy7u1sRESTanL_BXBn6QykscA@mail.gmail.com>
Subject: Re: [PATCH v12 03/18] kunit: test: add string_stream a std::stream
 like string builder
To: Stephen Boyd <sboyd@kernel.org>
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
Cc: Petr Mladek <pmladek@suse.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Aug 12, 2019 at 9:56 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 17:41:05)
> > On Mon, Aug 12, 2019 at 4:59 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > > kunit_resource_destroy (respective equivalents to devm_kfree, and
> > > > devres_destroy) and use kunit_kfree here?
> > > >
> > >
> > > Yes, or drop the API entirely? Does anything need this functionality?
> >
> > Drop the kunit_resource API? I would strongly prefer not to.
>
> No. I mean this API, string_stream_clear(). Does anything use it?

Oh, right. No.

However, now that I added the kunit_resource_destroy, I thought it
might be good to free the string_stream after I use it in each call to
kunit_assert->format(...) in which case I will be using this logic.

So I think the right thing to do is to expose string_stream_destroy so
kunit_do_assert can clean up when it's done, and then demote
string_stream_clear to static. Sound good?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
