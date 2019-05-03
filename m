Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C26133C8
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 20:59:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8F6832124B918;
	Fri,  3 May 2019 11:59:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=frowand.list@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0462721237812
 for <linux-nvdimm@lists.01.org>; Fri,  3 May 2019 11:59:36 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id ck18so3120698plb.1
 for <linux-nvdimm@lists.01.org>; Fri, 03 May 2019 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ADpdDwLHxFyfFWAX1if0+NpffCsUFbkjDEInr1QTSC4=;
 b=VrvZIthSvvpLa9ofdi1TVHc0CvLr2VIODR9OjnFm+Up9we0zDAZUBWMLlTbOSItHKo
 Pbam23b4EY+ccSifRG/ZxjMcIQVAiXiA3KyIi8wmckJ7RJLpCpUuffuKoF64akwkaZ+a
 3QcFYyfiYX8VkGbLXp+59LQq0XggiQTSFvsoJX1JIXyAy+67nRdTPeZZes4fPGEw0SNJ
 /9swLP5EtM7Jh7wPv9iAEyde8+QQDQGJVMKmJBfXFZRut96aOVsFH2VBxXFKDhAr7gl6
 0FaZZo8MGkaVEpcuBTPxzyLi+qG9bWgEYJF7h83gR5avy0pM2sQoY06ujQlTV4yL6n8q
 BstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ADpdDwLHxFyfFWAX1if0+NpffCsUFbkjDEInr1QTSC4=;
 b=c7AHJHIBJBXvCP3NUnFqP7y4ZAySTFKICVhfJHRMWPItkfIerYZZkCKHvUnOkp53HP
 4lTx61I63LNgGnCqCJUmix8/xvh1eTLWbskt1RfuM/BK/sp3FBO9GvfBK1Lp/vOySqOw
 UgTlUB0LvIsKI1Mo5EePNU1FAjsPcjvOLhsjLS6aH0roQYKj1jfMTLN6q0fehTW78NtO
 /bywcxLiHjAQujw6aygaVdVsdgb8NmhqSJVoXAtLsCecltNSG8G3IKHmdNIjIpBGusMO
 gj4PvOX2b1FJ11CRMD+Nr8RbVdAVjnx2H1GcWaYYWaCDgamcXide3GljHUdP9l1yLTog
 Kd8w==
X-Gm-Message-State: APjAAAU1Nt2lVfGvDQQY2/UlSXS8oi9C1Iqk3K+J0pcgHtuRlpjduM+s
 gy2+OhnY+7DegDuryBUSNKM=
X-Google-Smtp-Source: APXvYqxqbfGXr3FDXhDmUCd7JmX5osXVjgyq86nBDxgo3T0uzvTwYN2tw6/OWvrILTq7mQlibweAAw==
X-Received: by 2002:a17:902:bf44:: with SMTP id
 u4mr12529409pls.171.1556909976558; 
 Fri, 03 May 2019 11:59:36 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id l2sm3517136pgl.2.2019.05.03.11.59.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 03 May 2019 11:59:35 -0700 (PDT)
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
To: Brendan Higgins <brendanhiggins@google.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com>
 <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
 <a49c5088-a821-210c-66de-f422536f5b01@gmail.com>
 <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
 <1a5f3c44-9fa9-d423-66bf-45255a90c468@gmail.com>
 <CAFd5g45RYm+zfdJXnyp2KZZH5ojfOzy++aq+4zBeE5VDu6WgEw@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <052fa196-4ea9-8384-79b7-fe6bacc0ee82@gmail.com>
Date: Fri, 3 May 2019 11:59:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g45RYm+zfdJXnyp2KZZH5ojfOzy++aq+4zBeE5VDu6WgEw@mail.gmail.com>
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
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/2/19 10:36 PM, Brendan Higgins wrote:
> On Thu, May 2, 2019 at 6:45 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 5/2/19 4:45 PM, Brendan Higgins wrote:
>>> On Thu, May 2, 2019 at 2:16 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>
>>>> On 5/2/19 11:07 AM, Brendan Higgins wrote:
>>>>> On Thu, May 2, 2019 at 4:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>>>
>>>>>> On Wed, May 01, 2019 at 04:01:21PM -0700, Brendan Higgins wrote:
>>>>>>> From: Felix Guo <felixguoxiuping@gmail.com>
>>>>>>>
>>>>>>> The ultimate goal is to create minimal isolated test binaries; in the
>>>>>>> meantime we are using UML to provide the infrastructure to run tests, so
>>>>>>> define an abstract way to configure and run tests that allow us to
>>>>>>> change the context in which tests are built without affecting the user.
>>>>>>> This also makes pretty and dynamic error reporting, and a lot of other
>>>>>>> nice features easier.
>>>>>>>
>>>>>>> kunit_config.py:
>>>>>>>   - parse .config and Kconfig files.
>>>>>>>
>>>>>>> kunit_kernel.py: provides helper functions to:
>>>>>>>   - configure the kernel using kunitconfig.
>>>>>>>   - build the kernel with the appropriate configuration.
>>>>>>>   - provide function to invoke the kernel and stream the output back.
>>>>>>>
>>>>>>> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
>>>>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>>>>>
>>>>>> Ah, here's probably my answer to my previous logging format question,
>>>>>> right?  What's the chance that these wrappers output stuff in a standard
>>>>>> format that test-framework-tools can already parse?  :)
>>>
>>> To be clear, the test-framework-tools format we are talking about is
>>> TAP13[1], correct?
>>
>> I'm not sure what the test community prefers for a format.  I'll let them
>> jump in and debate that question.
>>
>>
>>>
>>> My understanding is that is what kselftest is being converted to use.
>>>
>>>>>
>>>>> It should be pretty easy to do. I had some patches that pack up the
>>>>> results into a serialized format for a presubmit service; it should be
>>>>> pretty straightforward to take the same logic and just change the
>>>>> output format.
>>>>
>>>> When examining and trying out the previous versions of the patch I found
>>>> the wrappers useful to provide information about how to control and use
>>>> the tests, but I had no interest in using the scripts as they do not
>>>> fit in with my personal environment and workflow.
>>>>
>>>> In the previous versions of the patch, these helper scripts are optional,
>>>> which is good for my use case.  If the helper scripts are required to
>>>
>>> They are still optional.
>>>
>>>> get the data into the proper format then the scripts are not quite so
>>>> optional, they become the expected environment.  I think the proper
>>>> format should exist without the helper scripts.
>>>
>>> That's a good point. A couple things,
>>>
>>> First off, supporting TAP13, either in the kernel or the wrapper
>>> script is not hard, but I don't think that is the real issue that you
>>> raise.
>>>
>>> If your only concern is that you will always be able to have human
>>> readable KUnit results printed to the kernel log, that is a guarantee
>>> I feel comfortable making. Beyond that, I think it is going to take a
>>> long while before I would feel comfortable guaranteeing anything about
>>> how will KUnit work, what kind of data it will want to expose, and how
>>> it will be organized. I think the wrapper script provides a nice
>>> facade that I can maintain, can mediate between the implementation
>>> details and the user, and can mediate between the implementation
>>> details and other pieces of software that might want to consume
>>> results.
>>>
>>> [1] https://testanything.org/tap-version-13-specification.html
>>
>> My concern is based on a focus on my little part of the world
>> (which in _previous_ versions of the patch series was the devicetree
>> unittest.c tests being converted to use the kunit infrastructure).
>> If I step back and think of the entire kernel globally I may end
>> up with a different conclusion - but I'm going to remain myopic
>> for this email.
>>
>> I want the test results to be usable by me and my fellow
>> developers.  I prefer that the test results be easily accessible
>> (current printk() implementation means that kunit messages are
>> just as accessible as the current unittest.c printk() output).
>> If the printk() output needs to be filtered through a script
>> to generate the actual test results then that is sub-optimal
>> to me.  It is one more step added to my workflow.  And
>> potentially with an embedded target a major pain to get a
>> data file (the kernel log file) transferred from a target
>> to my development host.
> 
> That's fair. If that is indeed your only concern, then I don't think
> the wrapper script will ever be an issue for you. You will always be
> able to execute a given test the old fashioned/manual way, and the
> wrapper script only summarizes results, it does not change the
> contents.
> 
>>
>> I want a reported test failure to be easy to trace back to the
>> point in the source where the failure is reported.  With printk()
>> the search is a simple grep for the failure message.  If the
>> failure message has been processed by a script, and then the
>> failure reported to me in an email, then I may have to look
>> at the script to reverse engineer how the original failure
>> message was transformed into the message that was reported
>> to me in the email.  Then I search for the point in the
>> source where the failure is reported.  So a basic task has
>> just become more difficult and time consuming.
> 
> That seems to be a valid concern. I would reiterate that you shouldn't
> be concerned by any processing done by the wrapper script itself, but
> the reality is that depending on what happens with automated
> testing/presubmit/CI other people might end up parsing and
> transforming test results - it might happen, it might not.

You seem to be missing my point.

Greg asked that the output be in a standard format.

You replied that the standard format could be created by the wrapper script.

Now you say that "it might happen, it might not".  In other words the output
may or may not end up in the standard format.

As Greg points out in comments to patch 12:

  "The core of kunit should also log the messages in this format as well,
  and not rely on the helper scripts as Frank points out, not everyone
  will use/want them.  Might as well make it easy for everyone to always
  do the right thing and not force it to always be added in later."

I am requesting that the original message be in the standard format.  Of
course anyone is free to transform the messages in later processing, no
big deal.


> I currently
> have a CI system set up for KUnit on my public repo that I don't think
> you would be offended by, but I don't know what we are going to do
> when it comes time to integrate with existing upstream CI systems.
> 
> In anycase, I don't think that either sticking with or doing away with
> the wrapper script is going to have any long term bearing on what
> happens in this regard.
> 
> Cheers
> 

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
