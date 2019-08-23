Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C1A9B508
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Aug 2019 19:05:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B33020215F4D;
	Fri, 23 Aug 2019 10:08:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=shuah@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 99C6C20215F42
 for <linux-nvdimm@lists.01.org>; Fri, 23 Aug 2019 10:08:19 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net
 [24.9.64.241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2AE5222CE3;
 Fri, 23 Aug 2019 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566579938;
 bh=nxBLgk8vy88bDQ4Gy8gLYJzufdYGTQ7XtUM6JqEXDA0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=O30aLpnr4wR6RV3N8mtzuIwqjR4pVRciIGqcKMKqRxgQeexe3DQTFu7wLf0ucs6pd
 f7LERWiM15wbjLXop4rZCGtrGB+P5H5sTrfEx/6zUqN9gIAyJVuBsS52i6gSBIEa3N
 Okrm+v4nJmDbL6aK4SO4xEICK/zDQDTaPoFPQAwI=
Subject: Re: [PATCH v14 01/18] kunit: test: add KUnit test runner core
To: Brendan Higgins <brendanhiggins@google.com>
References: <20190820232046.50175-1-brendanhiggins@google.com>
 <20190820232046.50175-2-brendanhiggins@google.com>
 <7f2c8908-75f6-b793-7113-ad57c51777ce@kernel.org>
 <CAFd5g44mRK9t4f58i_YMEt=e9RTxwrrhFY_V2LW_E7bUwR3cdg@mail.gmail.com>
From: shuah <shuah@kernel.org>
Message-ID: <4513d9f3-a69b-a9a4-768b-86c2962b62e0@kernel.org>
Date: Fri, 23 Aug 2019 11:05:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g44mRK9t4f58i_YMEt=e9RTxwrrhFY_V2LW_E7bUwR3cdg@mail.gmail.com>
Content-Language: en-US
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
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>, shuah <shuah@kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 8/23/19 10:48 AM, Brendan Higgins wrote:
> On Fri, Aug 23, 2019 at 8:33 AM shuah <shuah@kernel.org> wrote:
>>
>> Hi Brendan,
>>
>> On 8/20/19 5:20 PM, Brendan Higgins wrote:
>>> Add core facilities for defining unit tests; this provides a common way
>>> to define test cases, functions that execute code which is under test
>>> and determine whether the code under test behaves as expected; this also
>>> provides a way to group together related test cases in test suites (here
>>> we call them test_modules).
>>>
>>> Just define test cases and how to execute them for now; setting
>>> expectations on code will be defined later.
>>>
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>>> ---
>>>    include/kunit/test.h | 179 ++++++++++++++++++++++++++++++++++++++++
>>>    kunit/Kconfig        |  17 ++++
>>>    kunit/Makefile       |   1 +
>>>    kunit/test.c         | 191 +++++++++++++++++++++++++++++++++++++++++++
>>>    4 files changed, 388 insertions(+)
>>>    create mode 100644 include/kunit/test.h
>>>    create mode 100644 kunit/Kconfig
>>>    create mode 100644 kunit/Makefile
>>>    create mode 100644 kunit/test.c
>>>
>>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>>> new file mode 100644
>>> index 0000000000000..e0b34acb9ee4e
>>> --- /dev/null
>>> +++ b/include/kunit/test.h
>>> @@ -0,0 +1,179 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Base unit test (KUnit) API.
>>> + *
>>> + * Copyright (C) 2019, Google LLC.
>>> + * Author: Brendan Higgins <brendanhiggins@google.com>
>>> + */
>>> +
>>> +#ifndef _KUNIT_TEST_H
>>> +#define _KUNIT_TEST_H
>>> +
>>> +#include <linux/types.h>
>>> +
>>> +struct kunit;
>>> +
>>> +/**
>>> + * struct kunit_case - represents an individual test case.
>>> + * @run_case: the function representing the actual test case.
>>> + * @name: the name of the test case.
>>> + *
>>> + * A test case is a function with the signature, ``void (*)(struct kunit *)``
>>> + * that makes expectations (see KUNIT_EXPECT_TRUE()) about code under test. Each
>>> + * test case is associated with a &struct kunit_suite and will be run after the
>>> + * suite's init function and followed by the suite's exit function.
>>> + *
>>> + * A test case should be static and should only be created with the KUNIT_CASE()
>>> + * macro; additionally, every array of test cases should be terminated with an
>>> + * empty test case.
>>> + *
>>> + * Example:
>>
>> Can you fix these line continuations. It makes it very hard to read.
>> Sorry for this late comment. These comments lines are longer than 80
>> and wrap.
> 
> None of the lines in this commit are over 80 characters in column
> width. Some are exactly 80 characters (like above).
> 
> My guess is that you are seeing the diff added text (+ ), which when
> you add that to a line which is exactly 80 char in length ends up
> being over 80 char in email. If you apply the patch you will see that
> they are only 80 chars.
> 
>>
>> There are several comment lines in the file that are way too long.
> 
> Note that checkpatch also does not complain about any over 80 char
> lines in this file.
> 
> Sorry if I am misunderstanding what you are trying to tell me. Please
> confirm either way.
> 

WARNING: Avoid unnecessary line continuations
#258: FILE: include/kunit/test.h:137:
+		 */							       \

total: 0 errors, 2 warnings, 388 lines checked

Go ahead fix these. It appears there are few lines that either longer
than 80. In general, I keep them around 75, so it is easier read.

thanks,
-- Shuah


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
