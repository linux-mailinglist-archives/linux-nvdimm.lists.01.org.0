Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1F5CC657
	for <lists+linux-nvdimm@lfdr.de>; Sat,  5 Oct 2019 01:16:07 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2111E10FC325B;
	Fri,  4 Oct 2019 16:17:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=shuah@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3DE3310FC325A
	for <linux-nvdimm@lists.01.org>; Fri,  4 Oct 2019 16:17:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 07CB7215EA;
	Fri,  4 Oct 2019 23:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570230963;
	bh=ed2Oj0Rtnhm1rXJkcqfJxOLIvuDPtA/O2HMmNV71h1A=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=WM0U4KZ8Yc4SM5CiFfv5XPcZ0aRzdXwsYvoXnNevsXnJsPyjQKtdRXjIMQzZ+kVOJ
	 6YPavRWeR2P5RDQEazsuY+5qqP9SteouIZAzdGwtjgnZiXBW45gWTz4CaJtz77mMLh
	 9WfdeFi7Wi/iRWJWlEXKUF33HUEeeyYS7Fk3RiSQ=
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Brendan Higgins <brendanhiggins@google.com>
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20191004213812.GA24644@mit.edu>
 <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org>
 <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org>
 <CAFd5g46pzu=Bh5X7-ttfhTP+NYNDCAxN16OCGFxc5ohjTL-v0g@mail.gmail.com>
From: shuah <shuah@kernel.org>
Message-ID: <b38b118f-9bcb-c2fc-4365-0b94fde4e1ec@kernel.org>
Date: Fri, 4 Oct 2019 17:15:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g46pzu=Bh5X7-ttfhTP+NYNDCAxN16OCGFxc5ohjTL-v0g@mail.gmail.com>
Content-Language: en-US
Message-ID-Hash: Y6MWB7PHBU7AX37VR3A3T5TDWC6SMQPJ
X-Message-ID-Hash: Y6MWB7PHBU7AX37VR3A3T5TDWC6SMQPJ
X-MailFrom: shuah@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@google.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree <devicetree@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, kunit-dev@googlegroups.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-um@lists.infradead.org, Sasha Levin <Alexander.Levin@micro
 soft.com>, "Bird, Timothy" <Tim.Bird@sony.com>, Amir Goldstein <amir73il@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>, Joel Stanley <joel@jms.id.au>, Julia Lawall <julia.lawall@lip6.fr>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, shuah <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y6MWB7PHBU7AX37VR3A3T5TDWC6SMQPJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 10/4/19 5:10 PM, Brendan Higgins wrote:
> On Fri, Oct 4, 2019 at 3:47 PM shuah <shuah@kernel.org> wrote:
>>
>> On 10/4/19 4:27 PM, Brendan Higgins wrote:
>>> On Fri, Oct 04, 2019 at 03:59:10PM -0600, shuah wrote:
>>>> On 10/4/19 3:42 PM, Linus Torvalds wrote:
>>>>> On Fri, Oct 4, 2019 at 2:39 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>>>>>>
>>>>>> This question is primarily directed at Shuah and Linus....
>>>>>>
>>>>>> What's the current status of the kunit series now that Brendan has
>>>>>> moved it out of the top-level kunit directory as Linus has requested?
>>>>>
>>>>
>>>> The move happened smack in the middle of merge window and landed in
>>>> linux-next towards the end of the merge window.
>>>>
>>>>> We seemed to decide to just wait for 5.5, but there is nothing that
>>>>> looks to block that. And I encouraged Shuah to find more kunit cases
>>>>> for when it _does_ get merged.
>>>>>
>>>>
>>>> Right. I communicated that to Brendan that we could work on adding more
>>>> kunit based tests which would help get more mileage on the kunit.
>>>>
>>>>> So if the kunit branch is stable, and people want to start using it
>>>>> for their unit tests, then I think that would be a good idea, and then
>>>>> during the 5.5 merge window we'll not just get the infrastructure,
>>>>> we'll get a few more users too and not just examples.
>>>
>>> I was planning on holding off on accepting more tests/changes until
>>> KUnit is in torvalds/master. As much as I would like to go around
>>> promoting it, I don't really want to promote too much complexity in a
>>> non-upstream branch before getting it upstream because I don't want to
>>> risk adding something that might cause it to get rejected again.
>>>
>>> To be clear, I can understand from your perspective why getting more
>>> tests/usage before accepting it is a good thing. The more people that
>>> play around with it, the more likely that someone will find an issue
>>> with it, and more likely that what is accepted into torvalds/master is
>>> of high quality.
>>>
>>> However, if I encourage arbitrary tests/improvements into my KUnit
>>> branch, it further diverges away from torvalds/master, and is more
>>> likely that there will be a merge conflict or issue that is not related
>>> to the core KUnit changes that will cause the whole thing to be
>>> rejected again in v5.5.
>>>
>>
>> The idea is that the new development will happen based on kunit in
>> linux-kselftest next. It will work just fine. As we accepts patches,
>> they will go on top of kunit that is in linux-next now.
> 
> But then wouldn't we want to limit what KUnit changes are going into
> linux-kselftest next for v5.5? For example, we probably don't want to
> do anymore feature development on it until it is in v5.5, since the
> goal is to make it more stable, right?
> 
> I am guessing that it will probably be fine, but it still sounds like
> we need to establish some ground rules, and play it *very* safe.
> 

How about we identify a small number tests that can add value and focus
on them. I am thinking a number between 2 and 5. This way we get a feel
for the API, if it changes for the better great, if it doesn't have to,
then you know you already did a great job.

Does that sound reasonable to you?

thanks,
-- Shuah
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
