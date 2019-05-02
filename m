Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E79112537
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 01:45:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A81CF212449EE;
	Thu,  2 May 2019 16:45:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1CECF21243BA5
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 16:45:41 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j9so2395265oie.10
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 16:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ylV5gAlOXI2nFNZnhMPfqqvANEP1/evAl3taiRkcInQ=;
 b=OrjlPAypoDuLTmMWabsyH76U4J0Mgjkpr3DQnHBX1C/sWw9dQWGJZqdGNPLs+jVmSg
 c3bYyd65ExNrwdSzAF9/C3j2TwsTXUxo6mYRYKux2ifXavoN2kS9n00OiZWShZJ2VN9E
 Jey0nYLCGUng4+ySvL4+XGzNZ7sYP4XCUNcymRLj9xf6jLOnFx+3mvowrkn0pYKwRyZg
 3M2fA5czV+OipZELphNhEy5iD2t61ukDrrNzVoHA9OjKJNH0VGnLzAHCbuiCf9QjtvzN
 IDmzum+SPe0jeiAShs/g76LnFAxiI2OcVPBTp+1OnYkCXtTKkvmMFQSC+CcJJLS2aj7L
 YRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ylV5gAlOXI2nFNZnhMPfqqvANEP1/evAl3taiRkcInQ=;
 b=hkdSNGADbbw7qUIkv+gm3vk0eclDcew6JntL13jLVZ7t0XLXmMraKWudlRCAFq5xH6
 4Ywq9A44kbKAH2KtpPUWzt6LqBTsXl3ZfuoxuAAgFmfbf1qyVyVMeFOm+rC/iqWODDJB
 sDxuamZPkw0EtoNDZNaOdcvA0iI7SaUGuk3rp0+XuIZH0PxJqeaKHDnK5WC02+lThp/L
 xIQlPFV1O3JcukB3p73/jZNnVrsNhY6W7eFh5xp7jj+TO6tkoKRU3UU0NvEE1xGsgb//
 gH0XLxpTBjYOx92onuWd920O+3HOjtLcMkPdcNhyH1PYyshoLhPRqqcnCDV7IA5I2u5G
 mduA==
X-Gm-Message-State: APjAAAW9Kz3g/Lmcz7xNzlD2os3BqMkKLR9Qylxk780EOLwVD8ROEnYu
 WoxVGcHxCu7fLDhVhIvRGYP6SGnlHLlNX+SLrX4rPw==
X-Google-Smtp-Source: APXvYqza1ahwn/TDeWwW8NfzPMf/2RsvBcbxrAIWRnpkKGe/w6LvErCEtGQm7aaUbxq8tyCdcrjFzojfQN03A2rWnss=
X-Received: by 2002:aca:57d8:: with SMTP id l207mr4208582oib.44.1556840740661; 
 Thu, 02 May 2019 16:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com>
 <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
 <a49c5088-a821-210c-66de-f422536f5b01@gmail.com>
In-Reply-To: <a49c5088-a821-210c-66de-f422536f5b01@gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 2 May 2019 16:45:29 -0700
Message-ID: <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
To: Frank Rowand <frowand.list@gmail.com>
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
Cc: Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>, linux-kbuild@vger.kernel.org, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 2, 2019 at 2:16 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 5/2/19 11:07 AM, Brendan Higgins wrote:
> > On Thu, May 2, 2019 at 4:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Wed, May 01, 2019 at 04:01:21PM -0700, Brendan Higgins wrote:
> >>> From: Felix Guo <felixguoxiuping@gmail.com>
> >>>
> >>> The ultimate goal is to create minimal isolated test binaries; in the
> >>> meantime we are using UML to provide the infrastructure to run tests, so
> >>> define an abstract way to configure and run tests that allow us to
> >>> change the context in which tests are built without affecting the user.
> >>> This also makes pretty and dynamic error reporting, and a lot of other
> >>> nice features easier.
> >>>
> >>> kunit_config.py:
> >>>   - parse .config and Kconfig files.
> >>>
> >>> kunit_kernel.py: provides helper functions to:
> >>>   - configure the kernel using kunitconfig.
> >>>   - build the kernel with the appropriate configuration.
> >>>   - provide function to invoke the kernel and stream the output back.
> >>>
> >>> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> >>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> >>
> >> Ah, here's probably my answer to my previous logging format question,
> >> right?  What's the chance that these wrappers output stuff in a standard
> >> format that test-framework-tools can already parse?  :)

To be clear, the test-framework-tools format we are talking about is
TAP13[1], correct?

My understanding is that is what kselftest is being converted to use.

> >
> > It should be pretty easy to do. I had some patches that pack up the
> > results into a serialized format for a presubmit service; it should be
> > pretty straightforward to take the same logic and just change the
> > output format.
>
> When examining and trying out the previous versions of the patch I found
> the wrappers useful to provide information about how to control and use
> the tests, but I had no interest in using the scripts as they do not
> fit in with my personal environment and workflow.
>
> In the previous versions of the patch, these helper scripts are optional,
> which is good for my use case.  If the helper scripts are required to

They are still optional.

> get the data into the proper format then the scripts are not quite so
> optional, they become the expected environment.  I think the proper
> format should exist without the helper scripts.

That's a good point. A couple things,

First off, supporting TAP13, either in the kernel or the wrapper
script is not hard, but I don't think that is the real issue that you
raise.

If your only concern is that you will always be able to have human
readable KUnit results printed to the kernel log, that is a guarantee
I feel comfortable making. Beyond that, I think it is going to take a
long while before I would feel comfortable guaranteeing anything about
how will KUnit work, what kind of data it will want to expose, and how
it will be organized. I think the wrapper script provides a nice
facade that I can maintain, can mediate between the implementation
details and the user, and can mediate between the implementation
details and other pieces of software that might want to consume
results.

[1] https://testanything.org/tap-version-13-specification.html
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
