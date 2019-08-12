Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D308A880
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 22:41:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF0E82130C4AA;
	Mon, 12 Aug 2019 13:43:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 88BCB21309D33
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 13:43:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id i30so1575348pfk.9
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 13:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MJnh/DbbwUp2ykhuWtKroei6fTXCscBWC620YMU78kw=;
 b=vB8BBLTcHyR/6MmManbwUwxuFJIulQIi8ssstEWavyxVjDjZTqCdDV4k+GvQznx2Gu
 BYrmoSxq/p6EpObadBuog/qnQED0Er2g3FPY/R5mmU2+6prANR/EPeaPhjZJhguiIiRP
 laVlnix+3k3ldsZoV0C1xagsklVYtYidBM9aE1xGrFVcLjBbwRpW6HahGY9+Avp/kWLm
 T5NAN/tqvOLG0auDu2paiIhDdkHD9xVBreQFe50Qz3Fk4VEdJTBMNP4enXfrvN3t06qW
 EUgtNhbhUYFQV5XLv75AMMsdUTUbhRhJq5GaejhlsHjGOrbIRPayAm9bBTghIOMPNAZO
 gGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MJnh/DbbwUp2ykhuWtKroei6fTXCscBWC620YMU78kw=;
 b=Eb+MhSNyCYBop60EGK5OcAi+vvAmsGb7I4SrTvUCXSEUo6ukwf8xEiJ8sdgwLHq14O
 yPVUjWqYbGtE3n/f+uQ6uhYGm+SssAb0TMEUUsyMZpGUErpd3ioqGZx6chCUj8FldQMf
 strw1tiUgQW5Sr2rPhfr75G8B1KiZy15YLc7MHMtQ2qqmoxTZBiWxg/c5P5t/S2b/zSw
 XHPAKKUZIlABEiMRbLBJGdY0R/E8syBuh+wD+FscjvIg+ca6ChEB0OmIwA4HCglCkedH
 BKfFFdVV7NGAzZ4yj5G0r2NKINSKsyRwno76VOc9OyjW9+U3Sob9M0PBQFbnoZzKv3Na
 6pBw==
X-Gm-Message-State: APjAAAXrjE1NZHu9tZZn1MdQqicF7j3tAcSUY8MqGAjT+CA8wB9nbjJA
 deRodg+iOQ00/dtY5a7rJjWfeBd4FbOKXN04blYcSg==
X-Google-Smtp-Source: APXvYqzmkY3rA1NydAKLLowsftOVMQA6KoE5ccWG/aJPzsMG71zwm21zQ2Wdnhb2Togz1F6UwE1Me36C6jQdnlOZ3bs=
X-Received: by 2002:a63:b919:: with SMTP id z25mr31379684pge.201.1565642496668; 
 Mon, 12 Aug 2019 13:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190716175021.9CA412173C@mail.kernel.org>
 <20190719000834.GA3228@google.com>
 <20190722200347.261D3218C9@mail.kernel.org>
 <CAFd5g45hdCxEavSxirr0un_uLzo5Z-J4gHRA06qjzcQrTzmjVg@mail.gmail.com>
 <20190722235411.06C1320840@mail.kernel.org>
 <20190724073125.xyzfywctrcvg6fmh@pathway.suse.cz>
 <CAFd5g47v3Mr4GEGOjqyYy9Jwwm+ow7ypbu9j88rxEN06QCzdxQ@mail.gmail.com>
 <20190726083148.d4gf57w2nt5k7t6n@pathway.suse.cz>
 <CAFd5g46iAhDZ5C_chi7oYLVOkwcoj6+0nw+kPWuXhqWwWKd9jA@mail.gmail.com>
 <CAFd5g473iFfvBnJs2pcwuJYgY+DpgD6RLzyDFL1otUuScgKUag@mail.gmail.com>
 <20190801211447.6D3D7206A2@mail.kernel.org>
 <CAFd5g47tk8x5iet=xfPVO6MphD3SsLtYQLrCi5O2h0bvdXwHtA@mail.gmail.com>
In-Reply-To: <CAFd5g47tk8x5iet=xfPVO6MphD3SsLtYQLrCi5O2h0bvdXwHtA@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 12 Aug 2019 13:41:24 -0700
Message-ID: <CAFd5g44bovSiiqGCip1Q4zBOUauXMcryxnPs8miOa0-QrPW61Q@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like
 logger
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Timothy Bird <Tim.Bird@sony.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Kevin Hilman <khilman@baylibre.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>,
 Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>,
 kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>,
 Richard Weinberger <richard@nod.at>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Aug 1, 2019 at 2:43 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Thu, Aug 1, 2019 at 2:14 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-08-01 11:59:57)
> > > On Thu, Aug 1, 2019 at 11:55 AM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > > >
> > > > On Fri, Jul 26, 2019 at 1:31 AM Petr Mladek <pmladek@suse.com> wrote:
> > > >
> > > > > To be honest I do not fully understand KUnit design. I am not
> > > > > completely sure how the tested code is isolated from the running
> > > > > system. Namely, I do not know if the tested code shares
> > > > > the same locks with the system running the test.
> > > >
> > > > No worries, I don't expect printk to be the hang up in those cases. It
> > > > sounds like KUnit has a long way to evolve before printk is going to
> > > > be a limitation.
> > >
> > > So Stephen, what do you think?
> > >
> > > Do you want me to go forward with the new kunit_assert API wrapping
> > > the string_stream as I have it now? Would you prefer to punt this to a
> > > later patch? Or would you prefer something else?
> > >
> >
> > I like the struct based approach. If anything, it can be adjusted to
> > make the code throw some records into a spinlock later on and delay the
> > formatting of the assertion if need be.
>
> That's a fair point.
>
> > Can you resend with that
> > approach? I don't think I'll have any more comments after that.

I sent a new revision, v12, that incorporates the kunit_assert stuff.

Let me know what you think!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
