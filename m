Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513A88AE84
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 07:06:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 304132131D579;
	Mon, 12 Aug 2019 22:08:34 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6C6862131D569
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 22:08:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w26so5613836pfq.12
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 22:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Abf3cK9D+gRrRGwQh2kwak/YzDDkHOqgDtvVTIo4q7A=;
 b=Y+dmDbanwPRKrcGCv4/WQS9jtPyx6cpYSiNcTCluUKOVyeyn7wl8RZe0u1cf6FlML6
 wfRe3v8dcFvKIShJjXRgh8cEGNhzCFLCfZTUSJEGO2Ea0/S9/l8EIDzT2hfdmu4vYl3/
 XIR90pnuI3K4kV1d5Bm11Pn57c+GfE4dVDOOxOsnLShgWMYlA1pJcJoF7sOPZtexCwYP
 ELhxZQwrFnEmjZhgXx2mjuE3HiLK9TadecMdLzAo0eHIWgo1V1G1uOa5P7ZTv3NrW55Q
 IwxyHJePJisriyJmWo1d+yNh53aHnfmOSYFZCbC26Ph2JuMFkmU8c4wQttP2Gfux7zEx
 HKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Abf3cK9D+gRrRGwQh2kwak/YzDDkHOqgDtvVTIo4q7A=;
 b=P4AqipLhg7ois8vqE48C6C0Tm+3jaNv5Ej89FWAr3jYFhY0+xIahqAUCpfgKcLWz10
 vUkxPWhcauBuXOaSfHPBW7skalmg4DyL9N4AF+FzNAOjX61u+ApHbSwygEQ85bF37ivk
 LNEu/PFAaxFDHIY6hUIhOCZ++OTkpz/lghBtz1osMUuYR4fU/3+K6bpihewMhtAEV7Qr
 F7hB4AWTZaij68jVj9vln2FOObsxU7UTs65/6f6xEP2QaxxhVNKO7t7nBkFP8r0vaxCn
 fv2x83XwvBHhlG3aX99sRfZsZWD8qiMiP+l4b80hhTHyG6brB4HQ9IJCYjLxl7pXFCb0
 mX/w==
X-Gm-Message-State: APjAAAWljAlyxyuJmAmDDAJcB/peLGpkY++sgHEXdX/2TRTKb7GmiRGT
 PrhoPHgUZ9e8SmkXe76nyADOxRC4gjf2G7dnw63naw==
X-Google-Smtp-Source: APXvYqzlm/LZa7vLxmhuF4EQXYFyYKJYlrIat9BhnUUptmEmQR49KGysQZ4JhDoNNZWx7O5yEaH2e2yfA6hMO6s/qoE=
X-Received: by 2002:a63:205f:: with SMTP id r31mr30781941pgm.159.1565672775425; 
 Mon, 12 Aug 2019 22:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-11-brendanhiggins@google.com>
 <20190813042455.4A04320644@mail.kernel.org>
In-Reply-To: <20190813042455.4A04320644@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 12 Aug 2019 22:06:04 -0700
Message-ID: <CAFd5g46LHq1sQaio2Vj5jt54YN-Y2HuCT8FbALQhJoekkYJ-uQ@mail.gmail.com>
Subject: Re: [PATCH v12 10/18] kunit: test: add tests for kunit test abort
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

On Mon, Aug 12, 2019 at 9:24 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 11:24:13)
> > +
> > +static int kunit_try_catch_test_init(struct kunit *test)
> > +{
> > +       struct kunit_try_catch_test_context *ctx;
> > +
> > +       ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
>
> Can this fail? Should return -ENOMEM in that case?

Yes, I should do that.

> > +       test->priv = ctx;
> > +
> > +       ctx->try_catch = kunit_kmalloc(test,
> > +                                      sizeof(*ctx->try_catch),
> > +                                      GFP_KERNEL);
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
