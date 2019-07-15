Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D8769EB8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Jul 2019 00:11:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 73E1321962301;
	Mon, 15 Jul 2019 15:13:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 555A9212B0FEB
 for <linux-nvdimm@lists.01.org>; Mon, 15 Jul 2019 15:13:53 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q10so8053542pff.9
 for <linux-nvdimm@lists.01.org>; Mon, 15 Jul 2019 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gHxJwZ65KY+3dlkcg53YlVURzFgCQ53x+CwfDq4SFas=;
 b=MvXH0Y8+JYN6ezlr5+hNCudCnof36BXSG2llvPNekQW2sBy9YI7G1SGXVvdpQ2yLlf
 lKmujf+vhO+TdWj9V4lOLI5HKJRwOFsNc0Z+HQAqQPNMJNZhG/XUbO9b48lY2JAe2PXf
 C8cLituJqcyPcWhWrYkyYHyARQmMnImIukUwVh64GRNchs/vVW+Y3sNTXsnP2KkMCYsm
 tWZq1xFfkUWrMfYRu8uiUj1FZHlJMuMIXnMs4JzAjkIMXT+CDsY4Zk4nzjtcIDvnC44z
 6Zz6d+u8+o54d/ZpHHJzzRw6Uhf6PoufrWply9sIpa7H/+/YZvqwkPQ/RonuXcI57X3X
 E14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gHxJwZ65KY+3dlkcg53YlVURzFgCQ53x+CwfDq4SFas=;
 b=Q46Q/HZDawP9gFuHyEITspDVv1W3J3h90xxidELXroZQmAQzXrWuO9o8FaCG3yQN5N
 FQV4RF4o8/qiUzPS5tqi/p1FQYyP/YXKZRvFMWZVl5WW8vzhLn8k4kzszqPkBpd1hhyl
 VOWzig5ThfkFaQZQKdPg8lF/wXlUWysbLZwXLZ28peYuG5VUyYpx5VUdgTejpss9THK3
 bE0m11ObPf/jTnauPgVU0b0Qd8EWg3/a9Vb5VZH5esnz4hxWvQGXjyGhVrWym6Qi8+7B
 4MZYZrenMd0Jbu+udLVjTS8ZExajd1C21tl+qUAnq6Tq4A/XOIdfzX8kuLVqLPpdMKlk
 RhfQ==
X-Gm-Message-State: APjAAAWdq13Cp0RPQ0CNBChw+U4mbHlBhBLFb7mAsPetey5tx5tRZrIm
 79Dut3QilXN1X4KlOfYx+ef6d2MC6EuVEdqfwx5S+Q==
X-Google-Smtp-Source: APXvYqyfZTPL0o0YQnU93ejOaxOs5yytKYAJU2sUr1pH6F5nUAdPz6GwWoelLdf7eJ3sfRDvsdaJ2GYy9d2vy6rHMRQ=
X-Received: by 2002:a63:eb51:: with SMTP id b17mr28473124pgk.384.1563228684913; 
 Mon, 15 Jul 2019 15:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-4-brendanhiggins@google.com>
 <20190715204356.4E3F92145D@mail.kernel.org>
 <CAFd5g47481sRaez=yEJN4_ghiXZbxayk1Y04tAZpuzPLsmnhKg@mail.gmail.com>
 <20190715220407.0030420665@mail.kernel.org>
In-Reply-To: <20190715220407.0030420665@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 15 Jul 2019 15:11:13 -0700
Message-ID: <CAFd5g44bE0F=wq_fOAnxFTtoOyx1dUshhDAkKWr5hX9ipJ4Sxw@mail.gmail.com>
Subject: Re: [PATCH v9 03/18] kunit: test: add string_stream a std::stream
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

On Mon, Jul 15, 2019 at 3:04 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-15 14:11:50)
> > On Mon, Jul 15, 2019 at 1:43 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > I also wonder if it would be better to just have a big slop buffer of a
> > > 4K page or something so that we almost never have to allocate anything
> > > with a string_stream and we can just rely on a reader consuming data
> > > while writers are writing. That might work out better, but I don't quite
> > > understand the use case for the string stream.
> >
> > That makes sense, but might that also waste memory since we will
> > almost never need that much memory?
>
> Why do we care? These are unit tests.

Agreed.

> Having allocations in here makes
> things more complicated, whereas it would be simpler to have a pointer
> and a spinlock operating on a chunk of memory that gets flushed out
> periodically.

I am not so sure. I have to have the logic to allocate memory in some
case no matter what (what if I need more memory that my preallocated
chuck?). I think it is simpler to always request an allocation than to
only sometimes request an allocation.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
