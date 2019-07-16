Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DC46AF59
	for <lists+linux-nvdimm@lfdr.de>; Tue, 16 Jul 2019 20:56:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0E531212BC499;
	Tue, 16 Jul 2019 11:58:37 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1A24721A143EF
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 11:58:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 19so9548298pfa.4
 for <linux-nvdimm@lists.01.org>; Tue, 16 Jul 2019 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZybekRt/woJPUqImfzbAl3ncwjUgoXdjZVOXaEHk8I8=;
 b=j9eLSBzu7vGeOp+9v4PjjMY8Y60gIHirQjt/95JgwPIeMch+f2SZ4m2BcsmqzLNPnA
 y6mKbUvfRgB58Dd24aP06L/LHkjitHNk2jtHnbwOvIcJMeUwKyAY7Zj3rZzVz85nZG+R
 H6nYqq0HtuMcKgj4ph8KvSOJ57XFS8xQJyN4O9EfZBueGH2zgw2CSiJKxHwffHaRiCZU
 F2ZM5rxXlitmIEXm2ndwKKQaLdsI3EeFpaR3+KwtG2rjkMO/QifOGpG1dhcUu5Cz8T3g
 tXwTsXzmF1fc22PaEHeit7cbJ2ZXrz0nkagsUOfmTF+46/GQqdl6HnMMZCq90oDQiUGy
 RAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZybekRt/woJPUqImfzbAl3ncwjUgoXdjZVOXaEHk8I8=;
 b=S3wTcqc+hJjVRAFJHG+ibm3/ijvYOl2xstb/BzofHL/MKDYC2dIgaW43ZFI0bk9sOy
 dDRdYczBQgYXl0Q/xKSofPH7FnVSwqWmAiCCx46wMIQBQSONN7W2BysR2/4Hj7owQ+HD
 wJ8MH+kOV5USHrJ3uTh6YnmYQJmntj2djkS0h3cbHqIsdrF/OudD9mxgQZS5CTDPclz8
 LRCS6HMnZ+DLhs3QbsCx17/Ucu7Wc+muCN/jvJvuF/HaXyM/ovv0inDMqoqKZVtmmIks
 oFpfota3BsE58ziWetfXI87zVOK/RfF/A6K64ahBMhwXs0hnQmCh+2MotzIVfmGRRacU
 RMaw==
X-Gm-Message-State: APjAAAXiztyOm5rH+trSNNk/fS5riKds04udyWZWeKtcHQJ9K53glFZA
 yqiwGmAvmoPmrn4k4sSD1BJKyb/mI6ga8FUPoYMTIA==
X-Google-Smtp-Source: APXvYqwkl9ifterOK2ove6KXh9jZEcTxm4XlxkMBt5KD+9P3zl/wFtgkQs2T9gGivENnFOevPZS3P3oa9+3ivqemHYQ=
X-Received: by 2002:a63:205f:: with SMTP id r31mr35946123pgm.159.1563303365863; 
 Tue, 16 Jul 2019 11:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-4-brendanhiggins@google.com>
 <20190715204356.4E3F92145D@mail.kernel.org>
 <CAFd5g47481sRaez=yEJN4_ghiXZbxayk1Y04tAZpuzPLsmnhKg@mail.gmail.com>
 <20190715220407.0030420665@mail.kernel.org>
 <CAFd5g44bE0F=wq_fOAnxFTtoOyx1dUshhDAkKWr5hX9ipJ4Sxw@mail.gmail.com>
 <CAFd5g47y4vDB2P=EsGN8305LGeQPCTveNs-Jd5-=6K-XKY==CA@mail.gmail.com>
 <20190716153400.5CB182054F@mail.kernel.org>
In-Reply-To: <20190716153400.5CB182054F@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 16 Jul 2019 11:55:54 -0700
Message-ID: <CAFd5g47Nawp7V8=hetgBQWzWqmEyAz1GtWWwMrb9k=CCR33inQ@mail.gmail.com>
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

On Tue, Jul 16, 2019 at 8:34 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-15 15:43:20)
> > On Mon, Jul 15, 2019 at 3:11 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Mon, Jul 15, 2019 at 3:04 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Brendan Higgins (2019-07-15 14:11:50)
> > > > > On Mon, Jul 15, 2019 at 1:43 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > > >
> > > > > > I also wonder if it would be better to just have a big slop buffer of a
> > > > > > 4K page or something so that we almost never have to allocate anything
> > > > > > with a string_stream and we can just rely on a reader consuming data
> > > > > > while writers are writing. That might work out better, but I don't quite
> > > > > > understand the use case for the string stream.
> > > > >
> > > > > That makes sense, but might that also waste memory since we will
> > > > > almost never need that much memory?
> > > >
> > > > Why do we care? These are unit tests.
> > >
> > > Agreed.
> > >
> > > > Having allocations in here makes
> > > > things more complicated, whereas it would be simpler to have a pointer
> > > > and a spinlock operating on a chunk of memory that gets flushed out
> > > > periodically.
> > >
> > > I am not so sure. I have to have the logic to allocate memory in some
> > > case no matter what (what if I need more memory that my preallocated
> > > chuck?). I think it is simpler to always request an allocation than to
> > > only sometimes request an allocation.
> >
> > Another even simpler alternative might be to just allocate memory
> > using kunit_kmalloc as we need it and just let the kunit_resource code
> > handle cleaning it all up when the test case finishes.
>
> Sure, sounds like a nice way to avoid duplicating similar logic to
> maintain a list of things to free later.

I think I will go that route for now.

> >
> > What do you think?
>
> If you go the allocation route then you'll need to have the flags to
> know what context you're in to allocate appropriately. Does that mean
> all the string operations will now take GFP flags?

We could set the GFP flags in the constructor, store them in a field,
and then just reuse them.

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
