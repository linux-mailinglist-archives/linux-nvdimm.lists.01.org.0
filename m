Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B631A457
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 23:12:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 499422126CFA5;
	Fri, 10 May 2019 14:12:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=frowand.list@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B191E212657B2
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 14:12:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s11so3827163pfm.12
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 14:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=+ESw1rm0vOQ8XrrTL92EUV44kZc8ZXapKKTT6DaubOw=;
 b=abQaEAUT/PwZVqII0uePTmS9FBR01d5OlkiCxRNEH2BX3NkEApVpdySLV3IoMgo3eE
 MP1rCnCnuCPSjhTkzHIQIu9EjwponUbG5NaVheL2B404JO3C7VDo9y+Mqy+KY7Lg/zk4
 HZTfCWvMUNfLp0nVXqu1vIXWG6DicO5EafSNtq2E9JGj8YNzk+9a7zc27b0qnafPNljm
 IM58BuLw+T91Vgkv/o68Z8iYzoCT3SgFEQ+60d0CSXdbj6HfDIyr/aisHXQJRc+XYuor
 tOktoH4JOGyFwmXPs1QyTI/Nhvaq7L9FFdinnXWtQ6JoCZdVbpWiloLrGBNB+AoVHD1q
 8ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+ESw1rm0vOQ8XrrTL92EUV44kZc8ZXapKKTT6DaubOw=;
 b=ktJ5d3qnQ/HVB1/Z2Ct/LRLddzPa6PDCsNaXCXYomRDLxz9c408r46VSRDiO1pvgiS
 P9owOVktNPqRd8mEXDmda9esyPxDvll5WccXwj2b7/9oy6Ha9Z95g/KvKb2VwPYDPvPW
 Xttq7M6Qycf/Xnot9YSTIXZXYiTNNRpnyA+Mn+f/iNviiO2ovNj1mhyiwwjRhuY+1tdn
 KSy1OesB1HGG5p4MzER15yGnfsHT9rXS7NJpTHt6+UjUkSv57u22Sdsk+3MYU5UUsJbV
 DiQ8jzHtmyxUrCexQI5CQFe/2OeODdEYWso4KNfq0BXvBlEpWm58/JofkEApbEVc02e1
 r8+w==
X-Gm-Message-State: APjAAAVucYnlkKwXCk3jjbA6q5cMxz+udEyLDjEydxZDQwAWkfW8Mzv6
 xzGO/Yyqm49PpNlTSRNMuMw=
X-Google-Smtp-Source: APXvYqwYkJPgFPW1Q2jECQKvaMp3I+Sd6dA//ZzL+oYRc3FbXlWvh0CqFEtZZOyMry0CoGOK+X3rcA==
X-Received: by 2002:a62:6842:: with SMTP id d63mr17487032pfc.9.1557522763176; 
 Fri, 10 May 2019 14:12:43 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id r8sm7860997pfn.11.2019.05.10.14.12.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 May 2019 14:12:42 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Theodore Ts'o <tytso@mit.edu>, Tim.Bird@sony.com, knut.omang@oracle.com,
 gregkh@linuxfoundation.org, brendanhiggins@google.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org,
 sboyd@kernel.org, shuah@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
 amir73il@gmail.com, dan.carpenter@oracle.com, dan.j.williams@intel.com,
 daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
 khilman@baylibre.com, logang@deltatee.com, mpe@ellerman.id.au,
 pmladek@suse.com, richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
 wfg@linux.intel.com
References: <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com>
 <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <80c72e64-2665-bd51-f78c-97f50f9a53ba@gmail.com>
Date: Fri, 10 May 2019 14:12:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509214233.GA20877@mit.edu>
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

On 5/9/19 2:42 PM, Theodore Ts'o wrote:
> On Thu, May 09, 2019 at 11:12:12AM -0700, Frank Rowand wrote:
>>
>>    "My understanding is that the intent of KUnit is to avoid booting a kernel on
>>    real hardware or in a virtual machine.  That seems to be a matter of semantics
>>    to me because isn't invoking a UML Linux just running the Linux kernel in
>>    a different form of virtualization?
>>
>>    So I do not understand why KUnit is an improvement over kselftest.
>>
>>    ...
>>
>>    What am I missing?"
> 
> One major difference: kselftest requires a userspace environment; it
> starts systemd, requires a root file system from which you can load
> modules, etc.  Kunit doesn't require a root file system; doesn't
> require that you start systemd; doesn't allow you to run arbitrary
> perl, python, bash, etc. scripts.  As such, it's much lighter weight
> than kselftest, and will have much less overhead before you can start
> running tests.  So it's not really the same kind of virtualization.
> 
> Does this help?
> 
> 					- Ted
> 

I'm back to reply to this subthread, after a delay, as promised.

That is the type of information that I was looking for, so
thank you for the reply.

However, the reply is incorrect.  Kselftest in-kernel tests (which
is the context here) can be configured as built in instead of as
a module, and built in a UML kernel.  The UML kernel can boot,
running the in-kernel tests before UML attempts to invoke the
init process.

No userspace environment needed.  So exactly the same overhead
as KUnit when invoked in that manner.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
