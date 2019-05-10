Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9882E1A51A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 11 May 2019 00:13:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B2E3F212657A2;
	Fri, 10 May 2019 15:13:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=frowand.list@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 860C02125F1EB
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 15:13:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id i21so3618607pgi.12
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 15:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=k2Aq/0pFsKkTwsuWTj1NhOQs1y2YwfgcFH7dMaJeBgA=;
 b=hoVMY294/X8wHW4bG3jFoSfzQVD5twfR7+jf5iBN6t4WX5nMMkoV4x879lcOfkp7xi
 TvUWJxB+suod2heR5o4T6vWv23l2pqMuzCrv4fEdXGEgqK0X90ApJ5cY0Z79X1LBVTJ/
 JqAVR2W0MAM1Q8gqs9jklHAQ+rVW+OSHi96IhpzOe0hO2navqrCpJJoFLlWQfmM2o2/y
 mj6yh88N0y9hd0Aeu164ynxYT3f21Q3iAe4vxyRctXJmLdad5zASs/mlmCcZUo8WuXrA
 i8XcwIhi8rj5T63Vm+hg8lWmTDSyCji2r5FZFPzu1HJT2UKqowWPtNmhX2OLFeAFY7Nu
 39Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k2Aq/0pFsKkTwsuWTj1NhOQs1y2YwfgcFH7dMaJeBgA=;
 b=TgUfsJYdJD9h4JraFPdLdHdsUo3JILGjAszU21V9ZN+aHFxep59Fk6kcn1k5FggAHR
 UdY5bG75hGjNCNGD+KjfcM7td/KL/LHCNn85N6llf/P63sq2P1lmOg7QFQQNPCAO+yso
 T1tBB1CiftArj8rLeXcQaHeM2o6Njxn1H5vWtsjRgcuAkQBPzWIvPnGfCGCe4D+mIXrX
 yVdLOY4y3wSTSosebCaOa0+NCCSa0Io8aWKjIGOhNCkJVdpq/BM00CPQdyNnTC43lcEW
 nrpCiAcXl6K0qDbhCtCOioC2xl9cb8IsCieq/FgZPlgNj4htvAbXW04hhryca8NwyDVt
 0L4A==
X-Gm-Message-State: APjAAAUbMPRV/W6IJZ6FwBij6nkaDRIO9hx/1TM219tcikFXkGGsCdWU
 bvyFGlzXIwQICMyPFeRtvlc=
X-Google-Smtp-Source: APXvYqwvVtARK+C/DVSVImjE1Mpz8h6dEqd7MNelS+DGBLTa+gNCctcK7PEwWB+Z0fTADxEVolYI6w==
X-Received: by 2002:aa7:8a53:: with SMTP id n19mr17128829pfa.11.1557526424025; 
 Fri, 10 May 2019 15:13:44 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id r5sm6052599pgv.52.2019.05.10.15.13.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 May 2019 15:13:43 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Logan Gunthorpe <logang@deltatee.com>, Theodore Ts'o <tytso@mit.edu>,
 Tim.Bird@sony.com, knut.omang@oracle.com, gregkh@linuxfoundation.org,
 brendanhiggins@google.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org,
 sboyd@kernel.org, shuah@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
 amir73il@gmail.com, dan.carpenter@oracle.com, dan.j.williams@intel.com,
 daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
 khilman@baylibre.com, mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
 rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com
References: <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
 <20190509233043.GC20877@mit.edu>
 <8914afef-1e66-e6e3-f891-5855768d3018@deltatee.com>
 <6d6e91ec-33d3-830b-4895-4d7a20ba7d45@gmail.com>
 <3faa022b-0b70-0375-aa6d-12ea83a2671f@deltatee.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <d148a554-2a71-a5a4-4bb2-d84d2c483277@gmail.com>
Date: Fri, 10 May 2019 15:13:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3faa022b-0b70-0375-aa6d-12ea83a2671f@deltatee.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/10/19 9:17 AM, Logan Gunthorpe wrote:
> 
> 
> On 2019-05-09 11:18 p.m., Frank Rowand wrote:
> 
>> YES, kselftest has in-kernel tests.  (Excuse the shouting...)
> 
> Cool. From my cursory look, in my opinion, these would be greatly
> improved by converting them to the framework Brendan is proposing for Kunit.
> 
>>> If they do exists, it seems like it would make sense to
>>> convert those to kunit and have Kunit tests run-able in a VM or
>>> baremetal instance.
>>
>> They already run in a VM.
>>
>> They already run on bare metal.
>>
>> They already run in UML.
> 
> Simply being able to run in UML is not the only thing here. Kunit
> provides the infrastructure to quickly build, run and report results for
> all the tests from userspace without needing to worry about the details
> of building and running a UML kernel, then parsing dmesg to figure out
> what tests were run or not.

Yes.  But that is not the only environment that KUnit must support to be
of use to me for devicetree unittests (this is not new, Brendan is quite
aware of my needs and is not ignoring them).


>> This is not to say that KUnit does not make sense.  But I'm still trying
>> to get a better description of the KUnit features (and there are
>> some).
> 
> So read the patches, or the documentation[1] or the LWN article[2]. It's
> pretty well described in a lot of places -- that's one of the big
> advantages of it. In contrast, few people seems to have any concept of
> what kselftests are or where they are or how to run them (I was
> surprised to find the in-kernel tests in the lib tree).
> 
> Logan
> 
> [1] https://google.github.io/kunit-docs/third_party/kernel/docs/
> [2] https://lwn.net/Articles/780985/

I have been following the RFC versions.  I have installed the RFC patches
and run them to the extent that they worked (devicetree unittests were
a guinea pig for test conversion in the RFC series, but the converted
tests did not work).  I read portions of the code while trying to
understand the unittests conversion.  I made review comments based on
the portion of the code that I did read.  I have read the documentation
(very nice btw, as I have said before, but should be expanded).

My comment is that the description to submit the patch series should
be fuller -- KUnit potentially has a lot of nice attributes, and I
still think I have only scratched the surface.  The average reviewer
may have even less in-depth knowledge than I do.  And as I have
commented before, I keep diving into areas that I had no previous
experience with (such as kselftest) to be able to properly judge this
patch series.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
