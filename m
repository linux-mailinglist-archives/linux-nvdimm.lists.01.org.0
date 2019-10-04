Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E08D2CC584
	for <lists+linux-nvdimm@lfdr.de>; Fri,  4 Oct 2019 23:59:29 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 998B010097F2D;
	Fri,  4 Oct 2019 15:00:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=shuah@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 35C2610097F2C
	for <linux-nvdimm@lists.01.org>; Fri,  4 Oct 2019 15:00:29 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id F2D2021D81;
	Fri,  4 Oct 2019 21:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570226366;
	bh=W73YLXhXs87A3g1korb/FdZux/uM+XbdVy58joNqtAw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=c7fOk7RUHivPSo4Br+sR7Ulb8toFXC/ZDyjo7M4McI2vK/fU2u5yUL6sgZqCG9/0N
	 ojFH2VfZcCuNDqHBacwdU9j3hm2X7p3FAwv0T6qBCIoIakX+ukDWwwzuMnkOhquBaJ
	 BRLuBCpyg/Pa+cLfW2XKs0phXp09dZr4S7bAKusM=
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Linus Torvalds <torvalds@linux-foundation.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20191004213812.GA24644@mit.edu>
 <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
From: shuah <shuah@kernel.org>
Message-ID: <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org>
Date: Fri, 4 Oct 2019 15:59:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
Content-Language: en-US
Message-ID-Hash: H7RSAHP6RCP4DOYQRS7INAVV55FZ3OQ4
X-Message-ID-Hash: H7RSAHP6RCP4DOYQRS7INAVV55FZ3OQ4
X-MailFrom: shuah@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Brendan Higgins <brendanhiggins@google.com>, Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@google.com>, kieran.bingham@ideasonboard.com, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, robh@kernel.org, Stephen Boyd <sboyd@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, kunit-dev@googlegroups.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-um@lists.infradead.org, Sasha Levin <Alexander.Levin@microsoft.com>, Tim.Bird@sony.com, Amir Goldstein <amir73il@gmail.com>, Dan Carpenter <d
 an.carpenter@oracle.com>, Daniel Vetter <daniel@ffwll.ch>, jdike@addtoit.com, Joel Stanley <joel@jms.id.au>, Julia Lawall <julia.lawall@lip6.fr>, khilman@baylibre.com, knut.omang@oracle.com, Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com, shuah <shuah@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/H7RSAHP6RCP4DOYQRS7INAVV55FZ3OQ4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 10/4/19 3:42 PM, Linus Torvalds wrote:
> On Fri, Oct 4, 2019 at 2:39 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>>
>> This question is primarily directed at Shuah and Linus....
>>
>> What's the current status of the kunit series now that Brendan has
>> moved it out of the top-level kunit directory as Linus has requested?
> 

The move happened smack in the middle of merge window and landed in
linux-next towards the end of the merge window.

> We seemed to decide to just wait for 5.5, but there is nothing that
> looks to block that. And I encouraged Shuah to find more kunit cases
> for when it _does_ get merged.
> 

Right. I communicated that to Brendan that we could work on adding more
kunit based tests which would help get more mileage on the kunit.

> So if the kunit branch is stable, and people want to start using it
> for their unit tests, then I think that would be a good idea, and then
> during the 5.5 merge window we'll not just get the infrastructure,
> we'll get a few more users too and not just examples.
> 
thanks,
-- Shuah
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
