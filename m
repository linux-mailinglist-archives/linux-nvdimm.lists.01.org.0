Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA4C12402
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 23:19:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D58C721243BD8;
	Thu,  2 May 2019 14:18:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=frowand.list@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5C0D321243BA5
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 14:18:57 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e6so1636227pgc.4
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IMDXeiJnZScTm/Z2fnilFyDCMvT/so814pMi9HZOjlE=;
 b=F6aEAFFTMEY1A2qy1v4j/PN2GP6GkE/6G2UBiv6QtH3csxGy/tWQz9UyALBQT0H1TD
 MeqU6hM9umqY0cg0Apce+C6xD7p/xobhUeh9MvWiRshhDTYwjMCFPRJXDlmB1nI2J9BP
 OzIBfpWyS6JYvMDV31/EOZgJHoSWDTYYtNA+I4V1u8ppBrJn22kX8LSoN6iqCo9WhEY7
 d+Gb6Xl5Xs5otxILTZsg9XkKBj+kf5e2zhHYN3mehnTBbPBGx+Rmo9Huu3e7g+KZRBMy
 FLtK+ZKMR1Bm1xie5Eekig7pGAK9pe7NuFPMeA4bw49W6KmIoFN+i8IYZC8Mr/CFaKXa
 I9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IMDXeiJnZScTm/Z2fnilFyDCMvT/so814pMi9HZOjlE=;
 b=soWKkgu5UUQriwUvWaDH1rfFNypt658hggSoyS4VCnoHPU+TLrYCNS6IxYdGP+FMUe
 s4PGs3QeGtOKfzsBKcs67Zva/QJPsVZKknCBudd+2BRUBf2c2Swsx9WaxVwFT6YJ1Wkw
 49CCXSkpOp3JrO+/QkFyRc65GI7XNO3k3kKUe/sMeENbm+sT7rnP+95a2PCvhWK+i9Sx
 7wfLdB/kLGZXMQ25FGNu/OR1l6u/IO1XTNoxANkw7/DczxaF4KjJfy9449dR07nRG56b
 wqg0Dl2aHGbGq+3gGVoyKqfAfdDIZGNp+/DAFeevYmJREGsatWXZEJ7W2aHnU/9V8N4b
 TuGg==
X-Gm-Message-State: APjAAAVB7u2F5vFBooMnvVH6XG2H4bvzdOoIRbQSMNzwDqW8atnJ90VO
 nrgym07RUPYTXRQxbz5ECgA=
X-Google-Smtp-Source: APXvYqyX3j/ct3IijwmpxxuiCJMGeDGeHP5eVJgN3Sl6Ovmj2WM37sI+ZAhRzZjNxXrFUHk4WRTuBA==
X-Received: by 2002:a65:5089:: with SMTP id r9mr6248599pgp.14.1556831937028;
 Thu, 02 May 2019 14:18:57 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id l1sm232976pgp.9.2019.05.02.14.18.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 May 2019 14:18:56 -0700 (PDT)
Subject: Re: [PATCH v2 04/17] kunit: test: add kunit_stream a std::stream like
 logger
To: Brendan Higgins <brendanhiggins@google.com>,
 Greg KH <gregkh@linuxfoundation.org>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-5-brendanhiggins@google.com>
 <20190502110008.GC12416@kroah.com>
 <CAFd5g47ssM7RQZxQsUJ86UigcF-Uz+Kwv2yvKN_gZK-TtW89bA@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <6fcf1218-a026-fd7b-236f-ea95f6312e1d@gmail.com>
Date: Thu, 2 May 2019 14:18:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g47ssM7RQZxQsUJ86UigcF-Uz+Kwv2yvKN_gZK-TtW89bA@mail.gmail.com>
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
Cc: Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>, linux-kbuild@vger.kernel.org, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/2/19 1:25 PM, Brendan Higgins wrote:
> On Thu, May 2, 2019 at 4:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Wed, May 01, 2019 at 04:01:13PM -0700, Brendan Higgins wrote:
>>> A lot of the expectation and assertion infrastructure prints out fairly
>>> complicated test failure messages, so add a C++ style log library for
>>> for logging test results.
>>
>> Ideally we would always use a standard logging format, like the
>> kselftest tests all are aiming to do.  That way the output can be easily
>> parsed by tools to see if the tests succeed/fail easily.
>>
>> Any chance of having this logging framework enforcing that format as
>> well?
> 
> I agree with your comment on the later patch that we should handle
> this at the wrapper script layer (KUnit tool).

This discussion is a little confusing, because it is spread across two
patches.

I do not agree that this should be handled in the wrapper script, as
noted in my reply to patch 12, so not repeating it here.

-Frank
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
