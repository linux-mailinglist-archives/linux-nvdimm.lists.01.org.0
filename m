Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A5D15EBA
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 May 2019 10:01:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A3B452125331E;
	Tue,  7 May 2019 01:01:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 571062122CA93
 for <linux-nvdimm@lists.01.org>; Tue,  7 May 2019 01:01:22 -0700 (PDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6057820B7C;
 Tue,  7 May 2019 08:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1557216081;
 bh=QzyiMEIgGcOHF7/0RhAcYYAteXaKFmx6V5mlxAloU/E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JYZnGuH3Pbk4yrhdCzdKoMJOLOSIlgRBPlakGO9b31IdpbGDZVFQSkxHJZke5YiqF
 kLlxf+8LdYwPSAUw422OvFILYSfk5W9idQInw+r9Pj1esrAbnpH/5dYqp76eoeqJjE
 y7EgY8L7QWLFChBoIcI/eDpJ/HS6IYXXX+xBrQeg=
Date: Tue, 7 May 2019 10:01:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190507080119.GB28121@kroah.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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

On Mon, May 06, 2019 at 08:14:12PM -0700, Frank Rowand wrote:
> On 5/1/19 4:01 PM, Brendan Higgins wrote:
> > ## TLDR
> > 
> > I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
> > 5.2.
> > 
> > Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
> > we would merge through your tree when the time came? Am I remembering
> > correctly?
> > 
> > ## Background
> > 
> > This patch set proposes KUnit, a lightweight unit testing and mocking
> > framework for the Linux kernel.
> > 
> > Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> > it does not require installing the kernel on a test machine or in a VM
> > and does not require tests to be written in userspace running on a host
> > kernel. Additionally, KUnit is fast: From invocation to completion KUnit
> > can run several dozen tests in under a second. Currently, the entire
> > KUnit test suite for KUnit runs in under a second from the initial
> > invocation (build time excluded).
> > 
> > KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> > Googletest/Googlemock for C++. KUnit provides facilities for defining
> > unit test cases, grouping related test cases into test suites, providing
> > common infrastructure for running tests, mocking, spying, and much more.
> 
> As a result of the emails replying to this patch thread, I am now
> starting to look at kselftest.  My level of understanding is based
> on some slide presentations, an LWN article, https://kselftest.wiki.kernel.org/
> and a _tiny_ bit of looking at kselftest code.
> 
> tl;dr; I don't really understand kselftest yet.
> 
> 
> (1) why KUnit exists
> 
> > ## What's so special about unit testing?
> > 
> > A unit test is supposed to test a single unit of code in isolation,
> > hence the name. There should be no dependencies outside the control of
> > the test; this means no external dependencies, which makes tests orders
> > of magnitudes faster. Likewise, since there are no external dependencies,
> > there are no hoops to jump through to run the tests. Additionally, this
> > makes unit tests deterministic: a failing unit test always indicates a
> > problem. Finally, because unit tests necessarily have finer granularity,
> > they are able to test all code paths easily solving the classic problem
> > of difficulty in exercising error handling code.
> 
> (2) KUnit is not meant to replace kselftest
> 
> > ## Is KUnit trying to replace other testing frameworks for the kernel?
> > 
> > No. Most existing tests for the Linux kernel are end-to-end tests, which
> > have their place. A well tested system has lots of unit tests, a
> > reasonable number of integration tests, and some end-to-end tests. KUnit
> > is just trying to address the unit test space which is currently not
> > being addressed.
> 
> My understanding is that the intent of KUnit is to avoid booting a kernel on
> real hardware or in a virtual machine.  That seems to be a matter of semantics
> to me because isn't invoking a UML Linux just running the Linux kernel in
> a different form of virtualization?
> 
> So I do not understand why KUnit is an improvement over kselftest.
> 
> It seems to me that KUnit is just another piece of infrastructure that I
> am going to have to be familiar with as a kernel developer.  More overhead,
> more information to stuff into my tiny little brain.
> 
> I would guess that some developers will focus on just one of the two test
> environments (and some will focus on both), splitting the development
> resources instead of pooling them on a common infrastructure.
> 
> What am I missing?

kselftest provides no in-kernel framework for testing kernel code
specifically.  That should be what kunit provides, an "easy" way to
write in-kernel tests for things.

Brendan, did I get it right?

thanks,

greg k-h
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
