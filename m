Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0491A500
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 23:59:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6E3622126CFA3;
	Fri, 10 May 2019 14:59:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=frowand.list@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 61D5321265785
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 14:59:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z16so3606959pgv.11
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yNAZPIEWNbmSlYZ8cwgLvGUHP7GJ7j4IEkuELxGfk0s=;
 b=M75wJRMlTFKFQZt/4lcsEpc28kWArJrJmT5HCKU13g4oH2NsIrZzva7FuMESIwUaug
 /fvkswVnILiTiW05mV1JTsJ9qSjyZiEJ/Y6S6R06NUYCcA5iNBktNNcWyizdTFGuuQRD
 /hmqK/DlfROd6H61mHhYKwqipBgC8mVdZOCX7Jr8NfRB9rc5yUcYlwH0s3/SWF2V8mXV
 Qbw11wy7BgvyefxXnFOHUXbY1k8OyXm/tFTNwUfkELzk+gh9nN9whZP9qrww07t67fWd
 5gfCoauICfytsG9xXmnrXV7JXS/PKtV0cFdj+JWB0HrIpnLyG/fWh+20T5LILsvpe2TV
 NZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yNAZPIEWNbmSlYZ8cwgLvGUHP7GJ7j4IEkuELxGfk0s=;
 b=f6CEqvCH8ZWGOG0IACGpkhmJtDBMRuUIVToqPBNbXhmyoaSl4bjZqtPWwxPOt4QsyD
 eoOizWYkbdyNkpxzf++U0N6fDjetpp9Giez9onLJslAKrmziuefDJfCMdQV5CYK1FzeG
 Ol8ilB0WNF5L8OVozIT4YAofsEpL3ZGwQXxxTVKR7Xqn1VeKNSCK/66JwcFWtS08qZkw
 Hx6zwMNprvRGg37nxTa8+sUQB3QBquTt/5qCevU8Lm8DWflZzP73K9mrgnmpmzHtQhAk
 AZnymnavqspPVlaNtXVst+xc2btMgdsYgk+N4iMwRvWcP7Kq1WvgudLb9TbyXGVoQ85y
 VPJg==
X-Gm-Message-State: APjAAAXXp/utxjZA4eoFEbUlOaK6THSg/X+gt1YeWkvQOV43nxRugSlv
 yuXIV1shUBNkRwE/pLr0/o4=
X-Google-Smtp-Source: APXvYqzwLG/ip9y2rSWBrrsziwNUWUrXqMPGpN9xj3mZ3KbDjfj4L+HtB/GWWvD5+3lbuqHaEotsIg==
X-Received: by 2002:a65:49c7:: with SMTP id t7mr16632359pgs.324.1557525568984; 
 Fri, 10 May 2019 14:59:28 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id m17sm9063088pfi.17.2019.05.10.14.59.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 May 2019 14:59:28 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Brendan Higgins <brendanhiggins@google.com>,
 Daniel Vetter <daniel@ffwll.ch>
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
 <a1b88d5add15d43de0468c32d9a2427629337abb.camel@oracle.com>
 <CAKMK7uFd1xUx8u3xWLwifVSq4OEnMO4S-m0hESe68UzONXnMFg@mail.gmail.com>
 <CAFd5g47Fvafwgh15JNfxSBRf5qqG2z+V+XGAB2cJtNnHFTiFfQ@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <8abaf5f2-dd33-98d0-7b34-b57de7fe7c8b@gmail.com>
Date: Fri, 10 May 2019 14:59:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g47Fvafwgh15JNfxSBRf5qqG2z+V+XGAB2cJtNnHFTiFfQ@mail.gmail.com>
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
Cc: Petr Mladek <pmladek@suse.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Shuah Khan <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>,
 Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Kees Cook <keescook@google.com>,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/10/19 3:23 AM, Brendan Higgins wrote:
>> On Fri, May 10, 2019 at 7:49 AM Knut Omang <knut.omang@oracle.com> wrote:
>>>
>>> On Thu, 2019-05-09 at 22:18 -0700, Frank Rowand wrote:
>>>> On 5/9/19 4:40 PM, Logan Gunthorpe wrote:
>>>>>
>>>>>
>>>>> On 2019-05-09 5:30 p.m., Theodore Ts'o wrote:
>>>>>> On Thu, May 09, 2019 at 04:20:05PM -0600, Logan Gunthorpe wrote:
>>>>>>>
>>>>>>> The second item, arguably, does have significant overlap with kselftest.
>>>>>>> Whether you are running short tests in a light weight UML environment or
>>>>>>> higher level tests in an heavier VM the two could be using the same
>>>>>>> framework for writing or defining in-kernel tests. It *may* also be valuable
>>>>>>> for some people to be able to run all the UML tests in the heavy VM
>>>>>>> environment along side other higher level tests.
>>>>>>>
>>>>>>> Looking at the selftests tree in the repo, we already have similar items to
>>>>>>> what Kunit is adding as I described in point (2) above. kselftest_harness.h
>>>>>>> contains macros like EXPECT_* and ASSERT_* with very similar intentions to
>>>>>>> the new KUNIT_EXECPT_* and KUNIT_ASSERT_* macros.
>>>>>>>
>>>>>>> However, the number of users of this harness appears to be quite small. Most
>>>>>>> of the code in the selftests tree seems to be a random mismash of scripts
>>>>>>> and userspace code so it's not hard to see it as something completely
>>>>>>> different from the new Kunit:
>>>>>>>
>>>>>>> $ git grep --files-with-matches kselftest_harness.h *
>>>>>>
>>>>>> To the extent that we can unify how tests are written, I agree that
>>>>>> this would be a good thing.  However, you should note that
>>>>>> kselftest_harness.h is currently assums that it will be included in
>>>>>> userspace programs.  This is most obviously seen if you look closely
>>>>>> at the functions defined in the header files which makes calls to
>>>>>> fork(), abort() and fprintf().
>>>>>
>>>>> Ah, yes. I obviously did not dig deep enough. Using kunit for
>>>>> in-kernel tests and kselftest_harness for userspace tests seems like
>>>>> a sensible line to draw to me. Trying to unify kernel and userspace
>>>>> here sounds like it could be difficult so it's probably not worth
>>>>> forcing the issue unless someone wants to do some really fancy work
>>>>> to get it done.
>>>>>
>>>>> Based on some of the other commenters, I was under the impression
>>>>> that kselftests had in-kernel tests but I'm not sure where or if they
>>>>> exist.
>>>>
>>>> YES, kselftest has in-kernel tests.  (Excuse the shouting...)
>>>>
>>>> Here is a likely list of them in the kernel source tree:
>>>>
>>>> $ grep module_init lib/test_*.c
>>>> lib/test_bitfield.c:module_init(test_bitfields)
>>>> lib/test_bitmap.c:module_init(test_bitmap_init);
>>>> lib/test_bpf.c:module_init(test_bpf_init);
>>>> lib/test_debug_virtual.c:module_init(test_debug_virtual_init);
>>>> lib/test_firmware.c:module_init(test_firmware_init);
>>>> lib/test_hash.c:module_init(test_hash_init);  /* Does everything */
>>>> lib/test_hexdump.c:module_init(test_hexdump_init);
>>>> lib/test_ida.c:module_init(ida_checks);
>>>> lib/test_kasan.c:module_init(kmalloc_tests_init);
>>>> lib/test_list_sort.c:module_init(list_sort_test);
>>>> lib/test_memcat_p.c:module_init(test_memcat_p_init);
>>>> lib/test_module.c:static int __init test_module_init(void)
>>>> lib/test_module.c:module_init(test_module_init);
>>>> lib/test_objagg.c:module_init(test_objagg_init);
>>>> lib/test_overflow.c:static int __init test_module_init(void)
>>>> lib/test_overflow.c:module_init(test_module_init);
>>>> lib/test_parman.c:module_init(test_parman_init);
>>>> lib/test_printf.c:module_init(test_printf_init);
>>>> lib/test_rhashtable.c:module_init(test_rht_init);
>>>> lib/test_siphash.c:module_init(siphash_test_init);
>>>> lib/test_sort.c:module_init(test_sort_init);
>>>> lib/test_stackinit.c:module_init(test_stackinit_init);
>>>> lib/test_static_key_base.c:module_init(test_static_key_base_init);
>>>> lib/test_static_keys.c:module_init(test_static_key_init);
>>>> lib/test_string.c:module_init(string_selftest_init);
>>>> lib/test_ubsan.c:module_init(test_ubsan_init);
>>>> lib/test_user_copy.c:module_init(test_user_copy_init);
>>>> lib/test_uuid.c:module_init(test_uuid_init);
>>>> lib/test_vmalloc.c:module_init(vmalloc_test_init)
>>>> lib/test_xarray.c:module_init(xarray_checks);
>>>>
>>>>
>>>>> If they do exists, it seems like it would make sense to
>>>>> convert those to kunit and have Kunit tests run-able in a VM or
>>>>> baremetal instance.
>>>>
>>>> They already run in a VM.
>>>>
>>>> They already run on bare metal.
>>>>
>>>> They already run in UML.
>>>>
>>>> This is not to say that KUnit does not make sense.  But I'm still trying
>>>> to get a better description of the KUnit features (and there are
>>>> some).
>>>
>>> FYI, I have a master student who looks at converting some of these to KTF, such as for
>>> instance the XArray tests, which lended themselves quite good to a semi-automated
>>> conversion.
>>>
>>> The result is also a somewhat more compact code as well as the flexibility
>>> provided by the Googletest executor and the KTF frameworks, such as running selected
>>> tests, output formatting, debugging features etc.
>>
>> So is KTF already in upstream? Or is the plan to unify the KTF and
> 
> I am not certain about KTF's upstream plans, but I assume that Knut
> would have CC'ed me on the thread if he had started working on it.
> 
>> Kunit in-kernel test harnesses? Because there's tons of these
> 
> No, no plan. Knut and I talked about this a good while ago and it
> seemed that we had pretty fundamentally different approaches both in
> terms of implementation and end goal. Combining them seemed pretty
> infeasible, at least from a technical perspective. Anyway, I am sure
> Knut would like to give him perspective on the matter and I don't want
> to say too much without first giving him a chance to chime in on the
> matter.
> 
> Nevertheless, I hope you don't see resolving this as a condition for
> accepting this patchset. I had several rounds of RFC on KUnit, and no
> one had previously brought this up.

I seem to recall a request in reply to the KUnit RFC email threads to
work together.

However whether that impacts acceptance of this patch set is up to
the maintainer and how she wants to resolve the potential collision
of KUnit and KTF (if there is indeed any sort of collision).


>> in-kernel unit tests already, and every merge we get more (Frank's
>> list didn't even look into drivers or anywhere else, e.g. it's missing
>> the locking self tests I worked on in the past), and a more structured
>> approach would really be good.
> 
> Well, that's what I am trying to do. I hope you like it!
> 
> Cheers!
> .
> 

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
