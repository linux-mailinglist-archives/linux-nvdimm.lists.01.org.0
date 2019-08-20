Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF359690C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Aug 2019 21:08:35 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B594921962301;
	Tue, 20 Aug 2019 12:09:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=shuah@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 365642020F932
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 12:09:50 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net
 [24.9.64.241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EDF8A2082F;
 Tue, 20 Aug 2019 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566328112;
 bh=EQcE7jgODYPqBxFha4axxuVZtCHbZv+lyg0wG/vxuqE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=V//JOo/nBlns1BIGxHPsWcL0jiR9TJx2KmCu8eYP4YNIYAdhdLuzoIx3vOjLgJOWf
 qywhT+G/ZqWkgzBVmgCpi40PPee/iCkXqnClTUaQ9H817cboZ6rQYsqsdhOXzkxXEe
 SSvE0tF9mSLKe15z7ad2lgpjVB8OR8ObBpC4AYuQ=
Subject: Re: [PATCH v13 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Brendan Higgins <brendanhiggins@google.com>
References: <20190814055108.214253-1-brendanhiggins@google.com>
 <5b880f49-0213-1a6e-9c9f-153e6ab91eeb@kernel.org>
 <20190820182450.GA38078@google.com>
From: shuah <shuah@kernel.org>
Message-ID: <e8eaf28e-75df-c966-809a-2e3631353cc9@kernel.org>
Date: Tue, 20 Aug 2019 13:08:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820182450.GA38078@google.com>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org,
 amir73il@gmail.com, dri-devel@lists.freedesktop.org,
 Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com,
 mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
 robh@kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com,
 knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org, shuah <shuah@kernel.org>,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, kunit-dev@googlegroups.com, tytso@mit.edu,
 richard@nod.at, sboyd@kernel.org, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org,
 daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 8/20/19 12:24 PM, Brendan Higgins wrote:
> On Tue, Aug 20, 2019 at 11:24:45AM -0600, shuah wrote:
>> On 8/13/19 11:50 PM, Brendan Higgins wrote:
>>> ## TL;DR
>>>
>>> This revision addresses comments from Stephen and Bjorn Helgaas. Most
>>> changes are pretty minor stuff that doesn't affect the API in anyway.
>>> One significant change, however, is that I added support for freeing
>>> kunit_resource managed resources before the test case is finished via
>>> kunit_resource_destroy(). Additionally, Bjorn pointed out that I broke
>>> KUnit on certain configurations (like the default one for x86, whoops).
>>>
>>> Based on Stephen's feedback on the previous change, I think we are
>>> pretty close. I am not expecting any significant changes from here on
>>> out.
>>>
>>
>> Hi Brendan,
>>
>> I found checkpatch errors in one or two patches. Can you fix those and
>> send v14.
> 
> Hi Shuah,
> 
> Are you refering to the following errors?
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> #144: FILE: include/kunit/test.h:456:
> +#define KUNIT_BINARY_CLASS \
> +       kunit_binary_assert, KUNIT_INIT_BINARY_ASSERT_STRUCT
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> #146: FILE: include/kunit/test.h:458:
> +#define KUNIT_BINARY_PTR_CLASS \
> +       kunit_binary_ptr_assert, KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT
> 
> These values should *not* be in parentheses. I am guessing checkpatch is
> getting confused and thinks that these are complex expressions, when
> they are not.
> 
> I ignored the errors since I figured checkpatch was complaining
> erroneously.
> 
> I could refactor the code to remove these macros entirely, but I think
> the code is cleaner with them.
> 

Please do. I am not veru sure what value these macros add.

thanks,
-- Shuah
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
