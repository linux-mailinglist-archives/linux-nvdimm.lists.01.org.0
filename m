Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD2812DAE
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 14:33:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D07A32124B903;
	Fri,  3 May 2019 05:33:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=207.54.116.67; helo=ale.deltatee.com;
 envelope-from=logang@deltatee.com; receiver=linux-nvdimm@lists.01.org 
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A5F5421244A7F
 for <linux-nvdimm@lists.01.org>; Fri,  3 May 2019 05:33:51 -0700 (PDT)
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134]
 helo=[172.20.29.49])
 by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <logang@deltatee.com>)
 id 1hMXNQ-0007dH-Hy; Fri, 03 May 2019 06:33:22 -0600
To: Brendan Higgins <brendanhiggins@google.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-9-brendanhiggins@google.com>
 <0a605543-477a-1854-eb35-6e586606889b@deltatee.com>
 <CAFd5g47hxAd=+72xbPJbWPdZCXRXmtLpsGhUh=zc7MSwfcaGJQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b2379db6-634a-001e-6f67-37427d8a2666@deltatee.com>
Date: Fri, 3 May 2019 06:33:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g47hxAd=+72xbPJbWPdZCXRXmtLpsGhUh=zc7MSwfcaGJQ@mail.gmail.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 173.228.226.134
X-SA-Exim-Rcpt-To: wfg@linux.intel.com, rostedt@goodmis.org,
 rientjes@google.com, richard@nod.at, pmladek@suse.com, mpe@ellerman.id.au,
 knut.omang@oracle.com, khilman@baylibre.com, julia.lawall@lip6.fr,
 joel@jms.id.au, jdike@addtoit.com, daniel@ffwll.ch, dan.j.williams@intel.com,
 dan.carpenter@oracle.com, amir73il@gmail.com, Tim.Bird@sony.com,
 Alexander.Levin@microsoft.com, linux-um@lists.infradead.org,
 linux-nvdimm@lists.01.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, shuah@kernel.org, sboyd@kernel.org,
 robh@kernel.org, mcgrof@kernel.org, kieran.bingham@ideasonboard.com,
 keescook@google.com, gregkh@linuxfoundation.org, frowand.list@gmail.com,
 brendanhiggins@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
 GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v2 08/17] kunit: test: add support for test abort
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>, linux-kbuild@vger.kernel.org, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>



On 2019-05-03 12:48 a.m., Brendan Higgins wrote:
> On Thu, May 2, 2019 at 8:15 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>> On 2019-05-01 5:01 p.m., Brendan Higgins wrote:
>>> +/*
>>> + * struct kunit_try_catch - provides a generic way to run code which might fail.
>>> + * @context: used to pass user data to the try and catch functions.
>>> + *
>>> + * kunit_try_catch provides a generic, architecture independent way to execute
>>> + * an arbitrary function of type kunit_try_catch_func_t which may bail out by
>>> + * calling kunit_try_catch_throw(). If kunit_try_catch_throw() is called, @try
>>> + * is stopped at the site of invocation and @catch is catch is called.
>>
>> I found some of the C++ comparisons in this series a bit distasteful but
>> wasn't going to say anything until I saw the try catch.... But looking
>> into the implementation it's just a thread that can exit early which
>> seems fine to me. Just a poor choice of name I guess...
> 
> Guilty as charged (I have a long history with C++, sorry). Would you
> prefer I changed the name? I just figured that try-catch is a commonly
> understood pattern that describes exactly what I am doing.

It is a commonly understood pattern, but I don't think it's what the
code is doing. Try-catch cleans up an entire stack and allows each level
of the stack to apply local cleanup. This implementation simply exits a
thread and has none of that complexity. To me, it seems like an odd
abstraction here as it's really just a test runner that can exit early
(though I haven't seen the follow-up UML implementation).

I would prefer to see this cleaned up such that the abstraction matches
more what's going on but I don't feel that strongly about it so I'll
leave it up to you to figure out what's best unless other reviewers have
stronger opinions.

>>
>> [snip]
>>
>>> +static void __noreturn kunit_abort(struct kunit *test)
>>> +{
>>> +     kunit_set_death_test(test, true);
>>> +
>>> +     kunit_try_catch_throw(&test->try_catch);
>>> +
>>> +     /*
>>> +      * Throw could not abort from test.
>>> +      *
>>> +      * XXX: we should never reach this line! As kunit_try_catch_throw is
>>> +      * marked __noreturn.
>>> +      */
>>> +     WARN_ONCE(true, "Throw could not abort from test!\n");
>>> +}
>>> +
>>>  int kunit_init_test(struct kunit *test, const char *name)
>>>  {
>>>       spin_lock_init(&test->lock);
>>> @@ -77,6 +103,7 @@ int kunit_init_test(struct kunit *test, const char *name)
>>>       test->name = name;
>>>       test->vprintk = kunit_vprintk;
>>>       test->fail = kunit_fail;
>>> +     test->abort = kunit_abort;
>>
>> There are a number of these function pointers which seem to be pointless
>> to me as you only ever set them to one function. Just call the function
>> directly. As it is, it is an unnecessary indirection for someone reading
>> the code. If and when you have multiple implementations of the function
>> then add the pointer. Don't assume you're going to need it later on and
>> add all this maintenance burden if you never use it..
> 
> Ah, yes, Frank (and probably others) previously asked me to remove
> unnecessary method pointers; I removed all the totally unused ones. As
> for these, I don't use them in this patchset, but I use them in my
> patchsets that will follow up this one. These in particular are
> present so that they can be mocked out for testing.

Adding indirection and function pointers solely for the purpose of
mocking out while testing doesn't sit well with me and I don't think it
should be a pattern that's encouraged. Adding extra complexity like this
to a design to make it unit-testable doesn't seem like something that
makes sense in kernel code. Especially given that indirect calls are
more expensive in the age of spectre.

Also, mocking these particular functions seems like it's an artifact of
how you've designed the try/catch abstraction. If the abstraction was
more around an abort-able test runner then it doesn't make sense to need
to mock out the abort/fail functions as you will be testing overly
generic features of something that don't seem necessary to the
implementation.

>>
>> [snip]
>>
>>> +void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch)
>>> +{
>>> +     try_catch->run = kunit_generic_run_try_catch;
>>> +     try_catch->throw = kunit_generic_throw;
>>> +}
>>
>> Same here. There's only one implementation of try_catch and I can't
>> really see any sensible justification for another implementation. Even
>> if there is, add the indirection when the second implementation is
>> added. This isn't C++ and we don't need to make everything a "method".
> 
> These methods are for a UML specific implementation in a follow up
> patchset, which is needed for some features like crash recovery, death
> tests, and removes dependence on kthreads.
> 
> I know this probably sounds like premature complexity. Arguably it is
> in hindsight, but I wrote those features before I pulled out these
> interfaces (they were actually both originally in this patchset, but I
> dropped them to make this patchset easier to review). I can remove
> these methods and add them back in when I actually use them in the
> follow up patchsets if you prefer.

Yes, remove them now and add them back when you use them in follow-up
patches. If reviewers find problems with the follow-up patches or have a
better suggestion on how to do what ever it is you are doing, then you
just have this unnecessary code and there's wasted developer time and
review bandwidth that will need to be spent cleaning it up.

Thanks,

Logan
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
