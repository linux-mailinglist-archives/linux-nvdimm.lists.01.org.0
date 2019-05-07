Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25DE157EF
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 May 2019 05:14:20 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B90C6212532FB;
	Mon,  6 May 2019 20:14:18 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=frowand.list@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id ADB3C212532F4
 for <linux-nvdimm@lists.01.org>; Mon,  6 May 2019 20:14:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c6so2640078pfa.10
 for <linux-nvdimm@lists.01.org>; Mon, 06 May 2019 20:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XPy6o0NjYz38vWpV6pc1h2A6N4smSYs4Cq49Ux9zwV8=;
 b=uTQNGYZ1XWIvXYHBEeJQovmqhK2Jtpq+d64Qro6G5OKceot5sQNTlLbfduNr0K3PGx
 CsKeB5E/nKLx2mO5rHvB5C3cSTlrSg27HAg1bLnsc6sS6Ob71hOBqLsY7CZ9Kc78pahW
 2bjV9Jxur71IdhgsqsXU4h/nzLhauMpdelIF+i15235Qca74Y0OgvP33q3BLK9LqDfFd
 Xr/fhjikEY63MLGvaPSmYU14OjokXybBFpWj/AGZsAXkXpEZkB0f6qswg2ygyAISGWpA
 7eDh4rZZ2yShjUppASxA0qxx7J3s6zLlj/zKwFDiXJf9dX+MaLJqGhuEngD27vSXcDZx
 mNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XPy6o0NjYz38vWpV6pc1h2A6N4smSYs4Cq49Ux9zwV8=;
 b=gGk42u2dnyI7VOyGX4g+s382PoCKuze6tDJ5uBlZCfTXkIigkUSrIDN15hs8oPhQSl
 wqOtQgImMr6u/UnaQy1facevDS/tjlWw5WTaWQ9bLsSSG5OWEiPPKQkcFNjEbwG6K+Uf
 Oevu8N6k9ettSfZU/KUvWv9fGqVpz3TpLnKHf0ySnfBWtPbzeIc6rCbQmy6nUcYsdS3t
 Dkw9rb0CDftg/h1NZCNaSKxN+9ISzIKIm7LUCe7VcQhqj1k0VPEARZ9hfGldJK6ZttkV
 9OFwS+3uFRdBCvLXl47Fbrk3/jWIeZrOWOwdw/0VQWZulf9b8vDbVuj5LG+p4KHtpQy7
 AYvA==
X-Gm-Message-State: APjAAAW82OZQCdYA5YkRC+SsFP7yg10BV+RWdb36KNQKUdGDnPgoJZdJ
 /Dds1hhnMP/iwY+4AEqA/FM=
X-Google-Smtp-Source: APXvYqwISNSy9xefPMYRgOslBbKIROeiQ4y33+rxQnv0dnHw2MR5wA3FiL1meR7p3JPjBqzEw/Pz1Q==
X-Received: by 2002:a65:4802:: with SMTP id h2mr34368073pgs.98.1557198856091; 
 Mon, 06 May 2019 20:14:16 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id m11sm17053726pgd.12.2019.05.06.20.14.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 May 2019 20:14:15 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Brendan Higgins <brendanhiggins@google.com>, gregkh@linuxfoundation.org,
 keescook@google.com, kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
 robh@kernel.org, sboyd@kernel.org, shuah@kernel.org
References: <20190501230126.229218-1-brendanhiggins@google.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
Date: Mon, 6 May 2019 20:14:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501230126.229218-1-brendanhiggins@google.com>
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
 dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
 linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
 khilman@baylibre.com, knut.omang@oracle.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 richard@nod.at, linux-kernel@vger.kernel.org, daniel@ffwll.ch,
 mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/1/19 4:01 PM, Brendan Higgins wrote:
> ## TLDR
> 
> I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
> 5.2.
> 
> Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
> we would merge through your tree when the time came? Am I remembering
> correctly?
> 
> ## Background
> 
> This patch set proposes KUnit, a lightweight unit testing and mocking
> framework for the Linux kernel.
> 
> Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> it does not require installing the kernel on a test machine or in a VM
> and does not require tests to be written in userspace running on a host
> kernel. Additionally, KUnit is fast: From invocation to completion KUnit
> can run several dozen tests in under a second. Currently, the entire
> KUnit test suite for KUnit runs in under a second from the initial
> invocation (build time excluded).
> 
> KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> Googletest/Googlemock for C++. KUnit provides facilities for defining
> unit test cases, grouping related test cases into test suites, providing
> common infrastructure for running tests, mocking, spying, and much more.

As a result of the emails replying to this patch thread, I am now
starting to look at kselftest.  My level of understanding is based
on some slide presentations, an LWN article, https://kselftest.wiki.kernel.org/
and a _tiny_ bit of looking at kselftest code.

tl;dr; I don't really understand kselftest yet.


(1) why KUnit exists

> ## What's so special about unit testing?
> 
> A unit test is supposed to test a single unit of code in isolation,
> hence the name. There should be no dependencies outside the control of
> the test; this means no external dependencies, which makes tests orders
> of magnitudes faster. Likewise, since there are no external dependencies,
> there are no hoops to jump through to run the tests. Additionally, this
> makes unit tests deterministic: a failing unit test always indicates a
> problem. Finally, because unit tests necessarily have finer granularity,
> they are able to test all code paths easily solving the classic problem
> of difficulty in exercising error handling code.

(2) KUnit is not meant to replace kselftest

> ## Is KUnit trying to replace other testing frameworks for the kernel?
> 
> No. Most existing tests for the Linux kernel are end-to-end tests, which
> have their place. A well tested system has lots of unit tests, a
> reasonable number of integration tests, and some end-to-end tests. KUnit
> is just trying to address the unit test space which is currently not
> being addressed.

My understanding is that the intent of KUnit is to avoid booting a kernel on
real hardware or in a virtual machine.  That seems to be a matter of semantics
to me because isn't invoking a UML Linux just running the Linux kernel in
a different form of virtualization?

So I do not understand why KUnit is an improvement over kselftest.

It seems to me that KUnit is just another piece of infrastructure that I
am going to have to be familiar with as a kernel developer.  More overhead,
more information to stuff into my tiny little brain.

I would guess that some developers will focus on just one of the two test
environments (and some will focus on both), splitting the development
resources instead of pooling them on a common infrastructure.

What am I missing?

-Frank


> 
> ## More information on KUnit
> 
> There is a bunch of documentation near the end of this patch set that
> describes how to use KUnit and best practices for writing unit tests.
> For convenience I am hosting the compiled docs here:
> https://google.github.io/kunit-docs/third_party/kernel/docs/
> Additionally for convenience, I have applied these patches to a branch:
> https://kunit.googlesource.com/linux/+/kunit/rfc/v5.1-rc7/v1
> The repo may be cloned with:
> git clone https://kunit.googlesource.com/linux
> This patchset is on the kunit/rfc/v5.1-rc7/v1 branch.
> 
> ## Changes Since Last Version
> 
> None. I just rebased the last patchset on v5.1-rc7.
> 

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
