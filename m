Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F242182E4
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 May 2019 02:43:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 57C5D21256BB6;
	Wed,  8 May 2019 17:43:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=frowand.list@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5B8BA211F9D43
 for <linux-nvdimm@lists.01.org>; Wed,  8 May 2019 17:43:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v80so334072pfa.3
 for <linux-nvdimm@lists.01.org>; Wed, 08 May 2019 17:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1+Jfl9iXviaxHbmbhnDjk1eQnpFz6l/2Nut9ww82zvo=;
 b=a3KgZzLZ0y84UNUIY8RS+nYDRzFkAivRDtTwVjhJ1vYp+v2Z6HVSzmnnRowbVUedfI
 93zPM5T0iF4iJCU1PddnaPwpC/nrCINNvHKs9PmQ0ayrLgURqYfh7EH67znRVZxTURN5
 VsMO/ROT48Ly/mYey3OTt/dpawpdAk7DUuJetc8MAAQuinmU4P2PjwyMam4VRQGyIo8C
 F5An8gjuExmDUN5kMRWiGJsQOqa4gz/Zgv9YpcjdE85z0otG8d1GXhf4e05Hdx2o8s1c
 hn9kGYBDYT3L0e4JtQg2AhBurTKMtE9VNzBNe+yPm2LTyV/rg3Wp/BZ+nH8mhD2rC6M3
 7+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1+Jfl9iXviaxHbmbhnDjk1eQnpFz6l/2Nut9ww82zvo=;
 b=jtq7qvVYjGIHkrSP1ix2OmYUGz+aoQE8a507S6gvwLpk02GZA01JKmVaxadGEJQ+A4
 9TBuHVgFpcUIwmTUNxYgsfBxhGTnUg6Mux4qq2SvDvvGm8Y18pcShVfEFe2laZNjuUng
 xmA4Invqn2fYpfbgbn6zP83cCykdxYUoVu5GQv6Dr0AJd5JOKzyHQUj9gk6r2rmismM2
 m/leOhRRnOHMpT1txNi0fMnZXy2r9oFp8Q6ileQrwsZAvi2lyYMdE4FWNo5xmHmWLy03
 mEtbP7Jx9YwaKQJuDWLBmETvuxrdkyW3gBN+bZpL4LZvN3d95WOUpRjGl4JxG6RQj+kk
 h6XQ==
X-Gm-Message-State: APjAAAUHWMaF+7GX9JPK1Dsa+eeBfHUwxVQ8kq2ExSSFjh8ZSldSNODU
 1ScL9VIDwRGuMcQLjzrQzfk=
X-Google-Smtp-Source: APXvYqzW2wEIzqNsRgYl9IE5EX5P/24Mi1edBj4NYy1YPo+96Z3/rjpt+DtwN4pC4yu/pBUKvsKvyA==
X-Received: by 2002:a65:628b:: with SMTP id f11mr1432751pgv.95.1557362619650; 
 Wed, 08 May 2019 17:43:39 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id 63sm543120pfu.95.2019.05.08.17.43.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 May 2019 17:43:38 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Greg KH <gregkh@linuxfoundation.org>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
Date: Wed, 8 May 2019 17:43:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507080119.GB28121@kroah.com>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
 Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org,
 Alexander.Levin@microsoft.com, mpe@ellerman.id.au,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org,
 linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com,
 kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au,
 rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com,
 devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com,
 linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr,
 kunit-dev@googlegroups.com, richard@nod.at, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch,
 keescook@google.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/7/19 1:01 AM, Greg KH wrote:
> On Mon, May 06, 2019 at 08:14:12PM -0700, Frank Rowand wrote:
>> On 5/1/19 4:01 PM, Brendan Higgins wrote:
>>> ## TLDR
>>>
>>> I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
>>> 5.2.
>>>
>>> Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
>>> we would merge through your tree when the time came? Am I remembering
>>> correctly?
>>>
>>> ## Background
>>>
>>> This patch set proposes KUnit, a lightweight unit testing and mocking
>>> framework for the Linux kernel.
>>>
>>> Unlike Autotest and kselftest, KUnit is a true unit testing framework;
>>> it does not require installing the kernel on a test machine or in a VM
>>> and does not require tests to be written in userspace running on a host
>>> kernel. Additionally, KUnit is fast: From invocation to completion KUnit
>>> can run several dozen tests in under a second. Currently, the entire
>>> KUnit test suite for KUnit runs in under a second from the initial
>>> invocation (build time excluded).
>>>
>>> KUnit is heavily inspired by JUnit, Python's unittest.mock, and
>>> Googletest/Googlemock for C++. KUnit provides facilities for defining
>>> unit test cases, grouping related test cases into test suites, providing
>>> common infrastructure for running tests, mocking, spying, and much more.
>>
>> As a result of the emails replying to this patch thread, I am now
>> starting to look at kselftest.  My level of understanding is based
>> on some slide presentations, an LWN article, https://kselftest.wiki.kernel.org/
>> and a _tiny_ bit of looking at kselftest code.
>>
>> tl;dr; I don't really understand kselftest yet.
>>
>>
>> (1) why KUnit exists
>>
>>> ## What's so special about unit testing?
>>>
>>> A unit test is supposed to test a single unit of code in isolation,
>>> hence the name. There should be no dependencies outside the control of
>>> the test; this means no external dependencies, which makes tests orders
>>> of magnitudes faster. Likewise, since there are no external dependencies,
>>> there are no hoops to jump through to run the tests. Additionally, this
>>> makes unit tests deterministic: a failing unit test always indicates a
>>> problem. Finally, because unit tests necessarily have finer granularity,
>>> they are able to test all code paths easily solving the classic problem
>>> of difficulty in exercising error handling code.
>>
>> (2) KUnit is not meant to replace kselftest
>>
>>> ## Is KUnit trying to replace other testing frameworks for the kernel?
>>>
>>> No. Most existing tests for the Linux kernel are end-to-end tests, which
>>> have their place. A well tested system has lots of unit tests, a
>>> reasonable number of integration tests, and some end-to-end tests. KUnit
>>> is just trying to address the unit test space which is currently not
>>> being addressed.
>>
>> My understanding is that the intent of KUnit is to avoid booting a kernel on
>> real hardware or in a virtual machine.  That seems to be a matter of semantics
>> to me because isn't invoking a UML Linux just running the Linux kernel in
>> a different form of virtualization?
>>
>> So I do not understand why KUnit is an improvement over kselftest.
>>
>> It seems to me that KUnit is just another piece of infrastructure that I
>> am going to have to be familiar with as a kernel developer.  More overhead,
>> more information to stuff into my tiny little brain.
>>
>> I would guess that some developers will focus on just one of the two test
>> environments (and some will focus on both), splitting the development
>> resources instead of pooling them on a common infrastructure.
>>
>> What am I missing?
> 
> kselftest provides no in-kernel framework for testing kernel code
> specifically.  That should be what kunit provides, an "easy" way to
> write in-kernel tests for things.

kselftest provides a mechanism for in-kernel tests via modules.  For
example, see:

  tools/testing/selftests/vm/run_vmtests invokes:
    tools/testing/selftests/vm/test_vmalloc.sh
      loads module:
        test_vmalloc
        (which is built from lib/test_vmalloc.c if CONFIG_TEST_VMALLOC)

A very quick and dirty search (likely to miss some tests) finds modules:

  test_bitmap
  test_bpf
  test_firmware
  test_printf
  test_static_key_base
  test_static_keys
  test_user_copy
  test_vmalloc

-Frank

> 
> Brendan, did I get it right?
> 
> thanks,
> 
> greg k-h
> .
> 

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
