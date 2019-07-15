Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4391D69D22
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Jul 2019 22:51:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B7CD521962301;
	Mon, 15 Jul 2019 13:53:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1E865212B5EE4
 for <linux-nvdimm@lists.01.org>; Mon, 15 Jul 2019 13:53:30 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB55B2145D;
 Mon, 15 Jul 2019 20:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563223861;
 bh=6m3JRkZe4W2eR9x3TEB42iTGm06AKnl0iKV7troXRVI=;
 h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
 b=EwqhqpJU1AH9O3azv7tLQPtK6CGIx5+N25Vfxpts0j2Zu9LzI8K3EVF6FF7FMlJqe
 HqZdyATMk1hx4CfnLLeNhVn8jZBCw/KN0Ip/RXuDu+/ZJV8+T7LRYZFf0rRh6wit2r
 FZCr9nMrPp9Qn2lqNejmYhOwnPlNfDt+4lLfsG/0=
MIME-Version: 1.0
In-Reply-To: <CAFd5g45iHnMLOGQbXwzX6F74pkQGKBCSufkpYPOcw_iNSeiQKg@mail.gmail.com>
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-3-brendanhiggins@google.com>
 <20190715202425.CE64C20665@mail.kernel.org>
 <CAFd5g45iHnMLOGQbXwzX6F74pkQGKBCSufkpYPOcw_iNSeiQKg@mail.gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v9 02/18] kunit: test: add test resource management API
User-Agent: alot/0.8.1
Date: Mon, 15 Jul 2019 13:51:00 -0700
Message-Id: <20190715205101.AB55B2145D@mail.kernel.org>
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

Quoting Brendan Higgins (2019-07-15 13:30:22)
> On Mon, Jul 15, 2019 at 1:24 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-07-12 01:17:28)
> > > diff --git a/kunit/test.c b/kunit/test.c
> > > index 571e4c65deb5c..f165c9d8e10b0 100644
> 
> > One solution would be to piggyback on all the existing devres allocation
> > logic we already have and make each struct kunit a device that we pass
> > into the devres functions. A far simpler solution would be to just
> > copy/paste what devres does and use a spinlock and an allocation
> > function that takes GFP flags.
> 
> Yeah, that's what I did originally, but I thought from the discussion
> on patch 01 that you thought a spinlock was overkill for struct kunit.
> I take it you only meant in that initial patch?

Correct. I was only talking about the success bit in there.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
