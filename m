Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51140CE57B
	for <lists+linux-nvdimm@lfdr.de>; Mon,  7 Oct 2019 16:40:58 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3CAF5100DC2A0;
	Mon,  7 Oct 2019 07:43:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=srs0=axjo=ya=goodmis.org=rostedt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A913010FC585E
	for <linux-nvdimm@lists.01.org>; Mon,  7 Oct 2019 07:43:32 -0700 (PDT)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4F3372084D;
	Mon,  7 Oct 2019 14:40:50 +0000 (UTC)
Date: Mon, 7 Oct 2019 10:40:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20191007104048.66ae7e59@gandalf.local.home>
In-Reply-To: <CAHk-=wjcJxypxUOSF-jc=SQKT1CrOoTMyT7soYzbvK3965JmCA@mail.gmail.com>
References: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
	<56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org>
	<20191004222714.GA107737@google.com>
	<ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org>
	<20191004232955.GC12012@mit.edu>
	<CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com>
	<63e59b0b-b51e-01f4-6359-a134a1f903fd@kernel.org>
	<CAFd5g47wji3T9RFmqBwt+jPY0tb83y46oj_ttOq=rTX_N1Ggyg@mail.gmail.com>
	<544bdfcb-fb35-5008-ec94-8d404a08fd14@kernel.org>
	<CAFd5g467PkfELixpU0JbaepEAAD_ugAA340-uORngC-eXsQQ-g@mail.gmail.com>
	<20191006165436.GA29585@mit.edu>
	<CAHk-=wjcJxypxUOSF-jc=SQKT1CrOoTMyT7soYzbvK3965JmCA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Message-ID-Hash: XU36YTPXJFJQMSEMJTTOOYMOOTIUGWUD
X-Message-ID-Hash: XU36YTPXJFJQMSEMJTTOOYMOOTIUGWUD
X-MailFrom: SRS0=AXjO=YA=goodmis.org=rostedt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Theodore Y. Ts'o" <tytso@mit.edu>, Brendan Higgins <brendanhiggins@google.com>, shuah <shuah@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@google.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree <devicetree@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, kunit-dev@googlegroups.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-um@lists.infradead.org, Sasha Levin
  <Alexander.Levin@microsoft.com>, "Bird, Timothy" <Tim.Bird@sony.com>, Amir Goldstein <amir73il@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>, Joel Stanley <joel@jms.id.au>, Julia Lawall <julia.lawall@lip6.fr>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, David Rientjes <rientjes@google.com>, wfg@linux.intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XU36YTPXJFJQMSEMJTTOOYMOOTIUGWUD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, 6 Oct 2019 10:18:11 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Oct 6, 2019 at 9:55 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > Well, one thing we *can* do is if (a) if we can create a kselftest
> > branch which we know is stable and won't change, and (b) we can get
> > assurances that Linus *will* accept that branch during the next merge
> > window, those subsystems which want to use kself test can simply pull
> > it into their tree.  
> 
> Yes.
> 
> At the same time, I don't think it needs to be even that fancy. Even
> if it's not a stable branch that gets shared between different
> developers, it would be good to just have people do a "let's try this"
> throw-away branch to use the kunit functionality and verify that
> "yeah, this is fairly convenient for ext4".
> 
> It doesn't have to be merged in that form, but just confirmation that
> the infrastructure is helpful before it gets merged would be good.

Can't you just create an ext4 branch that has the kselftest-next branch
in it, that you build upon. And push that after the kunit test is
merged?

In the past I've had to rely on other branches in next, and would just
hold two branches myself. One with everything not dependent on the other
developer's branch, and one with the work that was. At the merge
window, I would either merge the two or just send two pull requests
with the two branches.

-- Steve
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
