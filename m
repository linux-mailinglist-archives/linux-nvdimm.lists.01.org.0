Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183B81A423
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 22:54:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 57913212657A1;
	Fri, 10 May 2019 13:54:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AEF142125F1F1
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 13:54:30 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 203so5470256oid.13
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 13:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wT/cEmU9OzhSA7tBC6sHp/9lnFjqpmjhDQ7p3B9EpFU=;
 b=evlcGdIsJdYGFkgmf7g49h2klNY0YDgLam0NSxBlsjnIvCyifza0rgc7Kq0J5qmAdA
 hd0xvzMMOFTjDkUqtbp9Csqd/JIB4Q/9pyDFXYsatysjFYSayOB6R/17rqPL3dsDFKbu
 CpB1t/Y5N1NsJdrqQqSqw8dZUeUluYMIMdDGCs+6m3ley31zma2gSaxhU1ecliKiQuHb
 STHQGjDC5w8qxg8OQKDXhctVTJVc43Ml5hH1/yZ8PBYWnwVLGMbfwFwUGqvcrrN1U/Nb
 /FIgrQ/F3IDvmmebdaC68E2dZKT6zjcG9rqNRGXkw9XZeR6dne5aQ/sOdhecRUXr+TGP
 otBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wT/cEmU9OzhSA7tBC6sHp/9lnFjqpmjhDQ7p3B9EpFU=;
 b=d4B5HG4ZBWiWPxmKck8uJEJn2tkhXs8MvOlEQLFTzCCBOzfCcDOaLBvVDDQtwYHK8R
 i5E63n7L6FiCcUPk5rtXhU764++3umVPEnntLw9gboG6PC38oRdPnYgitXzF0Fe9S6hl
 3KlhEYQ4xUTOpkS2KJ/Rtxh/Fc+BscQl0rlW1nyBPdN8YBlQCH2ZMFxw0UGJ/Y28nI6t
 4k3Kkrs2e8tmNA7bnIdwUMrKhybY0W3GjwFIi8siSYdvVP35NjfXmyqFNEwYEJ2qzBki
 yKitf6Yt61PE9T8Fy66jn+jy7TxiZVMn+HtnPzkUnlDTUHGgruHYE+66ilt9TVNN178l
 g08w==
X-Gm-Message-State: APjAAAUMJdDxW4NiHIwa0tApcNiAypf0/9zEVxiApoDU46g6PYFIe1Zn
 PkNZLG5kUA/GbOPUOPc82154MFR9qgaj7d4hVEdrcw==
X-Google-Smtp-Source: APXvYqxNRJu9bl2nkU6ZH1vsxWTQf0PljIkMEjB45yiEnJh9bpnswNueDFN5FM9uV7Z740rv+OdGOJvcAow2vcCRmeo=
X-Received: by 2002:aca:4586:: with SMTP id s128mr6126273oia.148.1557521668652; 
 Fri, 10 May 2019 13:54:28 -0700 (PDT)
MIME-Version: 1.0
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
 <1781164863be8d21a7e1890ae6dfee9be101d0a0.camel@oracle.com>
In-Reply-To: <1781164863be8d21a7e1890ae6dfee9be101d0a0.camel@oracle.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 10 May 2019 13:54:16 -0700
Message-ID: <CAFd5g46fn4nB-nd27-qj8BoC2h-dTCa=WMGoFNhgXDXY0xOdeg@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Knut Omang <knut.omang@oracle.com>
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
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>,
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
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 10, 2019 at 5:13 AM Knut Omang <knut.omang@oracle.com> wrote:
> On Fri, 2019-05-10 at 03:23 -0700, Brendan Higgins wrote:
> > > On Fri, May 10, 2019 at 7:49 AM Knut Omang <knut.omang@oracle.com> wrote:
> > > >
> > > > On Thu, 2019-05-09 at 22:18 -0700, Frank Rowand wrote:
> > > > > On 5/9/19 4:40 PM, Logan Gunthorpe wrote:
> > > > > >
> > > > > >
> > > > > > On 2019-05-09 5:30 p.m., Theodore Ts'o wrote:
> > > > > >> On Thu, May 09, 2019 at 04:20:05PM -0600, Logan Gunthorpe wrote:
> > > > > >>>
> > > > > >>> The second item, arguably, does have significant overlap with kselftest.
> > > > > >>> Whether you are running short tests in a light weight UML environment or
> > > > > >>> higher level tests in an heavier VM the two could be using the same
> > > > > >>> framework for writing or defining in-kernel tests. It *may* also be valuable
> > > > > >>> for some people to be able to run all the UML tests in the heavy VM
> > > > > >>> environment along side other higher level tests.
> > > > > >>>
> > > > > >>> Looking at the selftests tree in the repo, we already have similar items to
> > > > > >>> what Kunit is adding as I described in point (2) above. kselftest_harness.h
> > > > > >>> contains macros like EXPECT_* and ASSERT_* with very similar intentions to
> > > > > >>> the new KUNIT_EXECPT_* and KUNIT_ASSERT_* macros.
> > > > > >>>
> > > > > >>> However, the number of users of this harness appears to be quite small. Most
> > > > > >>> of the code in the selftests tree seems to be a random mismash of scripts
> > > > > >>> and userspace code so it's not hard to see it as something completely
> > > > > >>> different from the new Kunit:
> > > > > >>>
> > > > > >>> $ git grep --files-with-matches kselftest_harness.h *
> > > > > >>
> > > > > >> To the extent that we can unify how tests are written, I agree that
> > > > > >> this would be a good thing.  However, you should note that
> > > > > >> kselftest_harness.h is currently assums that it will be included in
> > > > > >> userspace programs.  This is most obviously seen if you look closely
> > > > > >> at the functions defined in the header files which makes calls to
> > > > > >> fork(), abort() and fprintf().
> > > > > >
> > > > > > Ah, yes. I obviously did not dig deep enough. Using kunit for
> > > > > > in-kernel tests and kselftest_harness for userspace tests seems like
> > > > > > a sensible line to draw to me. Trying to unify kernel and userspace
> > > > > > here sounds like it could be difficult so it's probably not worth
> > > > > > forcing the issue unless someone wants to do some really fancy work
> > > > > > to get it done.
> > > > > >
> > > > > > Based on some of the other commenters, I was under the impression
> > > > > > that kselftests had in-kernel tests but I'm not sure where or if they
> > > > > > exist.
> > > > >
> > > > > YES, kselftest has in-kernel tests.  (Excuse the shouting...)
> > > > >
> > > > > Here is a likely list of them in the kernel source tree:
> > > > >
> > > > > $ grep module_init lib/test_*.c
> > > > > lib/test_bitfield.c:module_init(test_bitfields)
> > > > > lib/test_bitmap.c:module_init(test_bitmap_init);
> > > > > lib/test_bpf.c:module_init(test_bpf_init);
> > > > > lib/test_debug_virtual.c:module_init(test_debug_virtual_init);
> > > > > lib/test_firmware.c:module_init(test_firmware_init);
> > > > > lib/test_hash.c:module_init(test_hash_init);  /* Does everything */
> > > > > lib/test_hexdump.c:module_init(test_hexdump_init);
> > > > > lib/test_ida.c:module_init(ida_checks);
> > > > > lib/test_kasan.c:module_init(kmalloc_tests_init);
> > > > > lib/test_list_sort.c:module_init(list_sort_test);
> > > > > lib/test_memcat_p.c:module_init(test_memcat_p_init);
> > > > > lib/test_module.c:static int __init test_module_init(void)
> > > > > lib/test_module.c:module_init(test_module_init);
> > > > > lib/test_objagg.c:module_init(test_objagg_init);
> > > > > lib/test_overflow.c:static int __init test_module_init(void)
> > > > > lib/test_overflow.c:module_init(test_module_init);
> > > > > lib/test_parman.c:module_init(test_parman_init);
> > > > > lib/test_printf.c:module_init(test_printf_init);
> > > > > lib/test_rhashtable.c:module_init(test_rht_init);
> > > > > lib/test_siphash.c:module_init(siphash_test_init);
> > > > > lib/test_sort.c:module_init(test_sort_init);
> > > > > lib/test_stackinit.c:module_init(test_stackinit_init);
> > > > > lib/test_static_key_base.c:module_init(test_static_key_base_init);
> > > > > lib/test_static_keys.c:module_init(test_static_key_init);
> > > > > lib/test_string.c:module_init(string_selftest_init);
> > > > > lib/test_ubsan.c:module_init(test_ubsan_init);
> > > > > lib/test_user_copy.c:module_init(test_user_copy_init);
> > > > > lib/test_uuid.c:module_init(test_uuid_init);
> > > > > lib/test_vmalloc.c:module_init(vmalloc_test_init)
> > > > > lib/test_xarray.c:module_init(xarray_checks);
> > > > >
> > > > >
> > > > > > If they do exists, it seems like it would make sense to
> > > > > > convert those to kunit and have Kunit tests run-able in a VM or
> > > > > > baremetal instance.
> > > > >
> > > > > They already run in a VM.
> > > > >
> > > > > They already run on bare metal.
> > > > >
> > > > > They already run in UML.
> > > > >
> > > > > This is not to say that KUnit does not make sense.  But I'm still trying
> > > > > to get a better description of the KUnit features (and there are
> > > > > some).
> > > >
> > > > FYI, I have a master student who looks at converting some of these to KTF, such as
> > for
> > > > instance the XArray tests, which lended themselves quite good to a semi-automated
> > > > conversion.
> > > >
> > > > The result is also a somewhat more compact code as well as the flexibility
> > > > provided by the Googletest executor and the KTF frameworks, such as running selected
> > > > tests, output formatting, debugging features etc.
> > >
> > > So is KTF already in upstream? Or is the plan to unify the KTF and
> >
> > I am not certain about KTF's upstream plans, but I assume that Knut
> > would have CC'ed me on the thread if he had started working on it.
>
> You are on the Github watcher list for KTF?

Yep! I have been since LPC in 2017.

> Quite a few of the commits there are preparatory for a forthcoming kernel patch set.
> I'll of course CC: you on the patch set when we send it to the list.

Awesome! I appreciate it.

>
> > > Kunit in-kernel test harnesses? Because there's tons of these
> >
> > No, no plan. Knut and I talked about this a good while ago and it
> > seemed that we had pretty fundamentally different approaches both in
> > terms of implementation and end goal. Combining them seemed pretty
> > infeasible, at least from a technical perspective. Anyway, I am sure
> > Knut would like to give him perspective on the matter and I don't want
> > to say too much without first giving him a chance to chime in on the
> > matter.
>
> I need more time to study KUnit details to say, but from a 10k feet perspective:
> I think at least there's a potential for some API unification, in using the same macro
> names. How about removing the KUNIT_ prefix to the test macros ;-) ?

Heh, heh. That's actually the way I had it in the earliest versions of
KUnit! But that was pretty much the very first thing everyone
complained about. I think I went from no prefix (like you are
suggesting) to TEST_* before the first version of the RFC at the
request of several people I was kicking the idea around with, and then
I think I was asked to go from TEST_* to KUNIT_* in the very first
revision of the RFC.

In short, I am sympathetic to your suggestion, but I think that is
non-negotiable at this point. The community has a clear policy in
place on the matter, and at this point I would really prefer not to
change all the symbol names again.

> That would make the names shorter, saving typing when writing tests, and storage ;-)
> and also make the names more similar to KTF's, and those of user land unit test

You mean the Googletest/Googlemock expectations/assertions?

It's a great library (with not so great a name), but unfortunately it
is written in C++, which I think pretty much counts it out here.

> frameworks? Also it will make it possible to have functions compiling both with KTF and
> KUnit, facilitating moving code between the two.

I think that would be cool, but again, I don't think this will be
possible with Googletest/Googlemock.

>
> Also the string stream facilities of KUnit looks interesting to share.

I am glad you think so!

If your biggest concern on my side is test macro names (which I think
is a no-go as I mentioned above), I think we should be in pretty good
shape once you are ready to move forward. Besides, I have a lot more
KUnit patches coming after this: landing this patchset is just the
beginning. So how about we keep moving forward on this patchset?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
