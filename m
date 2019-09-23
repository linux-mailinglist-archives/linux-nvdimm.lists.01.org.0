Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B943BBDB4
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Sep 2019 23:18:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A8F7202F5007;
	Mon, 23 Sep 2019 14:21:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=shuah@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DB5C0202EC07D
 for <linux-nvdimm@lists.01.org>; Mon, 23 Sep 2019 14:21:16 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net
 [24.9.64.241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DEFE921655;
 Mon, 23 Sep 2019 21:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569273528;
 bh=uZGy9vlY/pn+dPb1iZcKXB9oWJ1CxU/IxDEL/lnY++Y=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=SGo9W/cpUNl7KLgBfpJognPZxmFKKR4dEP6cA4jJHfYUQWpe3l2mgKE4k6iQx35cy
 ofpQ0Ztxh76B0jNkARdk9GCqGBkkj5Tzt6rUZCw261tq2nb9i+caRKzISInhCp2Dgx
 eN+urP1l4CUPMZHARnlboLegMC/L9Vk8rfBD2WVE=
Subject: Re: [PATCH v18 15/19] Documentation: kunit: add documentation for
 KUnit
To: Randy Dunlap <rdunlap@infradead.org>,
 Brendan Higgins <brendanhiggins@google.com>
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20190923090249.127984-16-brendanhiggins@google.com>
 <d87eba35-ae09-0c53-bbbe-51ee9dc9531f@infradead.org>
 <CAFd5g45y-NWzbn8E8hUg=n4U5E+N6_4D8eCXhQ74Y0N4zqVW=w@mail.gmail.com>
 <d7a61045-8fe6-a104-ece9-67b69c379425@infradead.org>
From: shuah <shuah@kernel.org>
Message-ID: <d5dc04ab-9be5-b258-c302-29f8045d6aaa@kernel.org>
Date: Mon, 23 Sep 2019 15:18:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d7a61045-8fe6-a104-ece9-67b69c379425@infradead.org>
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
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>, shuah <shuah@kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 9/23/19 1:49 PM, Randy Dunlap wrote:
> On 9/23/19 11:06 AM, Brendan Higgins wrote:
>> On Mon, Sep 23, 2019 at 8:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> On 9/23/19 2:02 AM, Brendan Higgins wrote:
>>>> Add documentation for KUnit, the Linux kernel unit testing framework.
>>>> - Add intro and usage guide for KUnit
>>>> - Add API reference
>>>>
>>>> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>>>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>>>> ---
>>>>   Documentation/dev-tools/index.rst           |   1 +
>>>>   Documentation/dev-tools/kunit/api/index.rst |  16 +
>>>>   Documentation/dev-tools/kunit/api/test.rst  |  11 +
>>>>   Documentation/dev-tools/kunit/faq.rst       |  62 +++
>>>>   Documentation/dev-tools/kunit/index.rst     |  79 +++
>>>>   Documentation/dev-tools/kunit/start.rst     | 180 ++++++
>>>>   Documentation/dev-tools/kunit/usage.rst     | 576 ++++++++++++++++++++
>>>>   7 files changed, 925 insertions(+)
>>>>   create mode 100644 Documentation/dev-tools/kunit/api/index.rst
>>>>   create mode 100644 Documentation/dev-tools/kunit/api/test.rst
>>>>   create mode 100644 Documentation/dev-tools/kunit/faq.rst
>>>>   create mode 100644 Documentation/dev-tools/kunit/index.rst
>>>>   create mode 100644 Documentation/dev-tools/kunit/start.rst
>>>>   create mode 100644 Documentation/dev-tools/kunit/usage.rst
>>>
>>>
>>>> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
>>>> new file mode 100644
>>>> index 000000000000..6dc229e46bb3
>>>> --- /dev/null
>>>> +++ b/Documentation/dev-tools/kunit/start.rst
>>>> @@ -0,0 +1,180 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +===============
>>>> +Getting Started
>>>> +===============
>>>> +
>>>> +Installing dependencies
>>>> +=======================
>>>> +KUnit has the same dependencies as the Linux kernel. As long as you can build
>>>> +the kernel, you can run KUnit.
>>>> +
>>>> +KUnit Wrapper
>>>> +=============
>>>> +Included with KUnit is a simple Python wrapper that helps format the output to
>>>> +easily use and read KUnit output. It handles building and running the kernel, as
>>>> +well as formatting the output.
>>>> +
>>>> +The wrapper can be run with:
>>>> +
>>>> +.. code-block:: bash
>>>> +
>>>> +   ./tools/testing/kunit/kunit.py run
>>>> +
>>>> +Creating a kunitconfig
>>>> +======================
>>>> +The Python script is a thin wrapper around Kbuild as such, it needs to be
>>>
>>>                                         around Kbuild. As such,
>>
>> Thanks for pointing this out.
>>
>>>
>>>> +configured with a ``kunitconfig`` file. This file essentially contains the
>>>> +regular Kernel config, with the specific test targets as well.
>>>> +
>>>> +.. code-block:: bash
>>>> +
>>>> +     git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
>>>> +     cd $PATH_TO_LINUX_REPO
>>>> +     ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
>>>> +
>>>> +You may want to add kunitconfig to your local gitignore.
>>>> +
>>>> +Verifying KUnit Works
>>>> +---------------------
>>>> +
>>>> +To make sure that everything is set up correctly, simply invoke the Python
>>>> +wrapper from your kernel repo:
>>>> +
>>>> +.. code-block:: bash
>>>> +
>>>> +     ./tools/testing/kunit/kunit.py
>>>> +
>>>> +.. note::
>>>> +   You may want to run ``make mrproper`` first.
>>>
>>> I normally use O=builddir when building kernels.
>>> Does this support using O=builddir ?
>>
>> Yep, it supports specifying a separate build directory.
>>
>>>> +
>>>> +If everything worked correctly, you should see the following:
>>>> +
>>>> +.. code-block:: bash
>>>> +
>>>> +     Generating .config ...
>>>> +     Building KUnit Kernel ...
>>>> +     Starting KUnit Kernel ...
>>>> +
>>>> +followed by a list of tests that are run. All of them should be passing.
>>>> +
>>>> +.. note::
>>>> +   Because it is building a lot of sources for the first time, the ``Building
>>>> +   kunit kernel`` step may take a while.
>>>> +
>>>> +Writing your first test
>>>> +=======================
>>>
>>> [snip]
>>>
>>>> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
>>>> new file mode 100644
>>>> index 000000000000..c6e69634e274
>>>> --- /dev/null
>>>> +++ b/Documentation/dev-tools/kunit/usage.rst
>>>
>>> TBD...
>>
>> What did you mean by this comment?
> 
> I plan to review usage.rst soon... (To Be Done :)
> 

I would like to apply the series very soon so it gets some soak time
after this move in linux-next and it can still make the rc1.

Since there changes can be addressed after rc1, I would like to not
require Brendan to do another version before I apply.

Hope you are okay with that Randy!

thanks,
-- Shuah
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
