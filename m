Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C4DCE630
	for <lists+linux-nvdimm@lfdr.de>; Mon,  7 Oct 2019 16:57:42 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D388100DC2AD;
	Mon,  7 Oct 2019 08:00:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=shuah@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 961D8100DC2AB
	for <linux-nvdimm@lists.01.org>; Mon,  7 Oct 2019 08:00:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1E805206C2;
	Mon,  7 Oct 2019 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570460259;
	bh=M/mh7ZDKuNzaoClSYB7rLWBjChHoOPyPKzoupCtmj/s=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=OknCZl7G7XB2x/+wPMOTWsiPriTJeKEbR+zS47+ClfRbCU63jUlK1d+xBxWuJuzCB
	 c521NSoNfrmZ7l21+c+4hgme2giarn46R0KzyXhix6klLtQym1/TJUpxv1eArw06l2
	 ryeCnoXId3pvz7NjvXBDnl/VEqPPEm1JHVs1Iizw=
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
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
 <20191007104048.66ae7e59@gandalf.local.home>
From: shuah <shuah@kernel.org>
Message-ID: <176fa69d-1767-ea9b-476d-c685c2a68d46@kernel.org>
Date: Mon, 7 Oct 2019 08:57:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007104048.66ae7e59@gandalf.local.home>
Content-Language: en-US
Message-ID-Hash: GBAWB42MQIR2QKLYTDA2OABJE3EIKSBM
X-Message-ID-Hash: GBAWB42MQIR2QKLYTDA2OABJE3EIKSBM
X-MailFrom: shuah@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Theodore Y. Ts'o" <tytso@mit.edu>, Brendan Higgins <brendanhiggins@google.com>, Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@google.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree <devicetree@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, kunit-dev@googlegroups.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-um@lists.infradead.org, Sasha Levin <Alexander.Levin@microsof
 t.com>, "Bird, Timothy" <Tim.Bird@sony.com>, Amir Goldstein <amir73il@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>, Joel Stanley <joel@jms.id.au>, Julia Lawall <julia.lawall@lip6.fr>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, David Rientjes <rientjes@google.com>, wfg@linux.intel.com, shuah <shuah@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GBAWB42MQIR2QKLYTDA2OABJE3EIKSBM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 10/7/19 8:40 AM, Steven Rostedt wrote:
> On Sun, 6 Oct 2019 10:18:11 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Sun, Oct 6, 2019 at 9:55 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>>>
>>> Well, one thing we *can* do is if (a) if we can create a kselftest
>>> branch which we know is stable and won't change, and (b) we can get
>>> assurances that Linus *will* accept that branch during the next merge
>>> window, those subsystems which want to use kself test can simply pull
>>> it into their tree.
>>
>> Yes.
>>
>> At the same time, I don't think it needs to be even that fancy. Even
>> if it's not a stable branch that gets shared between different
>> developers, it would be good to just have people do a "let's try this"
>> throw-away branch to use the kunit functionality and verify that
>> "yeah, this is fairly convenient for ext4".
>>
>> It doesn't have to be merged in that form, but just confirmation that
>> the infrastructure is helpful before it gets merged would be good.
> 
> Can't you just create an ext4 branch that has the kselftest-next branch
> in it, that you build upon. And push that after the kunit test is
> merged?
> 
> In the past I've had to rely on other branches in next, and would just
> hold two branches myself. One with everything not dependent on the other
> developer's branch, and one with the work that was. At the merge
> window, I would either merge the two or just send two pull requests
> with the two branches.
> 

I do something similar when I am working on top of a branch that isn't
already in the mainline. In any case, repeating myself

Let's work on top of - it is rebased to 5.4-rc1 and ready for use.

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test

Let's use that for kunit work for 5.5. I won't add any kselftest patches
to it and keep it dedicated for kunit work. When tests are ready for
upstream, I can keep adding them to this branch.

thanks,
-- Shuah
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
