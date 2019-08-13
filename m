Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAE78BEE8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 18:48:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6DEFF2132D764;
	Tue, 13 Aug 2019 09:50:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CE06C2131D597
 for <linux-nvdimm@lists.01.org>; Tue, 13 Aug 2019 09:50:30 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 06A2D20842;
 Tue, 13 Aug 2019 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565714898;
 bh=+ClQXQZYMO3oD0vJh2iCm8rSEOKMIpNSMDMOjbE3t+k=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=pjR7+sDpG5QV8mqVLOqQHM+8vC+tRobkv0ngA4hd4MBaO/KrG4XqTeZ1bpn5bn1bq
 KhfBsT1su6Wd2h61ArrsWNQlNeGWtPTPht9QXac/YRw1heGospZwGZg3FIXZ4HQ+Nu
 vKsI/4s3VfFW3biZ3Mbn7FIY6xfwnAsdy1fw46EY=
MIME-Version: 1.0
In-Reply-To: <CAFd5g452+-6m1eiVK0ccTDkJ2wH8GBwxRDw5owwC8h3NscE1ag@mail.gmail.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812225520.5A67C206A2@mail.kernel.org>
 <20190812233336.GA224410@google.com>
 <20190812235940.100842063F@mail.kernel.org>
 <CAFd5g44xciLPBhH_J3zUcY3TedWTijdnWgF055qffF+dAguhPQ@mail.gmail.com>
 <20190813045623.F3D9520842@mail.kernel.org>
 <CAFd5g46PJNTOUAA4GOOrW==74Zy7u1sRESTanL_BXBn6QykscA@mail.gmail.com>
 <20190813053023.CC86120651@mail.kernel.org>
 <CAFd5g47v7410QRAizPV8zaHrKrc95-Sk-GNzRRVngN741OKnvg@mail.gmail.com>
 <CAFd5g452+-6m1eiVK0ccTDkJ2wH8GBwxRDw5owwC8h3NscE1ag@mail.gmail.com>
Subject: Re: [PATCH v12 03/18] kunit: test: add string_stream a std::stream
 like string builder
From: Stephen Boyd <sboyd@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
User-Agent: alot/0.8.1
Date: Tue, 13 Aug 2019 09:48:17 -0700
Message-Id: <20190813164818.06A2D20842@mail.kernel.org>
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

Quoting Brendan Higgins (2019-08-13 02:12:54)
> On Tue, Aug 13, 2019 at 2:04 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Mon, Aug 12, 2019 at 10:30 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Brendan Higgins (2019-08-12 22:02:59)
> > > > However, now that I added the kunit_resource_destroy, I thought it
> > > > might be good to free the string_stream after I use it in each call to
> > > > kunit_assert->format(...) in which case I will be using this logic.
> > > >
> > > > So I think the right thing to do is to expose string_stream_destroy so
> > > > kunit_do_assert can clean up when it's done, and then demote
> > > > string_stream_clear to static. Sound good?
> > >
> > > Ok, sure. I don't really see how clearing it explicitly when the
> > > assertion prints vs. never allocating it to begin with is really any
> > > different. Maybe I've missed something though.
> >
> > It's for the case that we *do* print something out. Once we are doing
> > printing, we don't want the fragments anymore.
> 
> Oops, sorry fat fingered: s/doing/done

Yes, but when we print something out we've run into some sort of problem
and then the test is over. So freeing the memory when it fails vs. when
the test is over seems like a minor difference. Or is it also used to
print other informational messages while the test is running?

I'm not particularly worried here, just trying to see if less code is
possible.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
