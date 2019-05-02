Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3701123F7
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 23:16:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D9A1821243BC7;
	Thu,  2 May 2019 14:16:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 44D5321243BA5
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 14:16:27 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w22so317196pgi.6
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 14:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SXzn4PL7BS9Zk+Qjz5Z6ao7p78pnuZhgvrrpjIHBgqs=;
 b=kCJFdJIIF969KctuD3d2wM6Ofbq6dPOZFLTH8wlGl+7+cVokVRuDwro7NOWN9ohV8k
 ImAl50lyzEBsv7yN+yDsApIRZoLtSCfwhyzyxPvjXoEWcvwOBh4YVBGfYFjfXofVIUhG
 4IdfwHyJltRS5sW89ee6jcilUM33Ka1rf9l/1hx/r4xvkgirrOsCcjMVyOo7fNRjZFEX
 W57GSaPxOGJB3pNyXX+NzqVUj3/2JEPXwOjRvCBv8sNkyMt8fb6SSscfdGTffg6t6JdB
 E1xSneePimV/qvTL3gOacgC8P6jcyMC1ik1HBxyp2Tove1HOXYfOKbo6mTy7cNVaJPvY
 TkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SXzn4PL7BS9Zk+Qjz5Z6ao7p78pnuZhgvrrpjIHBgqs=;
 b=tw2CQZaT7Ri0uKW8rIgjaRanBidfqN0KkWVSV26XW31bdWXfzzGHk+IFGvJ00OmUj8
 kpuTtYbQ/zRO9OlcDnoEFfGt6k5+4TN9JYAgpFpLTqluRrD4t8rpLv9DHR8UdIXCgKTl
 xnUNiGCDAVsudA7gMGIc5yoBMnOSMWQiTmOu3seOVq3CJRGZtxqInBtEc8F8AceY81Z/
 obDx4xqH5+d6LASXaCj75a50jUCKVQUVLjGaLzuo+JI6n7RhbGN1mDqKjoH5+Kbxnfcb
 dmOPhfUBlnevdLEpG9Vp/fUewMIHfRk41Au/6NENnARb6rgz1UEUkgUO1nuTN4s67vJi
 It3A==
X-Gm-Message-State: APjAAAWY/gM+5ZO1+FqbNiNXOo9PRr8yuGo3dq0MMWG7D81H5hRVI49k
 MZOvVxEMHbYYajNnqLaKgyw=
X-Google-Smtp-Source: APXvYqyaAKrOO8dNkOZg12O3d42lENfOgkrL7qBtR/V01hTlj71I+CQb4vEU5IP/L2A0+G0+xdSQEg==
X-Received: by 2002:a63:5f42:: with SMTP id t63mr6174518pgb.275.1556831786717; 
 Thu, 02 May 2019 14:16:26 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id f63sm102173pfc.180.2019.05.02.14.16.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 May 2019 14:16:26 -0700 (PDT)
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
To: Brendan Higgins <brendanhiggins@google.com>,
 Greg KH <gregkh@linuxfoundation.org>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com>
 <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <a49c5088-a821-210c-66de-f422536f5b01@gmail.com>
Date: Thu, 2 May 2019 14:16:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
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
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com,
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

On 5/2/19 11:07 AM, Brendan Higgins wrote:
> On Thu, May 2, 2019 at 4:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Wed, May 01, 2019 at 04:01:21PM -0700, Brendan Higgins wrote:
>>> From: Felix Guo <felixguoxiuping@gmail.com>
>>>
>>> The ultimate goal is to create minimal isolated test binaries; in the
>>> meantime we are using UML to provide the infrastructure to run tests, so
>>> define an abstract way to configure and run tests that allow us to
>>> change the context in which tests are built without affecting the user.
>>> This also makes pretty and dynamic error reporting, and a lot of other
>>> nice features easier.
>>>
>>> kunit_config.py:
>>>   - parse .config and Kconfig files.
>>>
>>> kunit_kernel.py: provides helper functions to:
>>>   - configure the kernel using kunitconfig.
>>>   - build the kernel with the appropriate configuration.
>>>   - provide function to invoke the kernel and stream the output back.
>>>
>>> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>
>> Ah, here's probably my answer to my previous logging format question,
>> right?  What's the chance that these wrappers output stuff in a standard
>> format that test-framework-tools can already parse?  :)
> 
> It should be pretty easy to do. I had some patches that pack up the
> results into a serialized format for a presubmit service; it should be
> pretty straightforward to take the same logic and just change the
> output format.

When examining and trying out the previous versions of the patch I found
the wrappers useful to provide information about how to control and use
the tests, but I had no interest in using the scripts as they do not
fit in with my personal environment and workflow.

In the previous versions of the patch, these helper scripts are optional,
which is good for my use case.  If the helper scripts are required to
get the data into the proper format then the scripts are not quite so
optional, they become the expected environment.  I think the proper
format should exist without the helper scripts.

-Frank
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
