Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 180C219952
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 10:12:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 03EB52126578F;
	Fri, 10 May 2019 01:12:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::141; helo=mail-it1-x141.google.com;
 envelope-from=daniel.vetter@ffwll.ch; receiver=linux-nvdimm@lists.01.org 
Received: from mail-it1-x141.google.com (mail-it1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A3B5221265787
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 01:12:25 -0700 (PDT)
Received: by mail-it1-x141.google.com with SMTP id s3so8009890itk.1
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 01:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BBAzF3ukUH/0YN2wqJedYjAOrMYWc/znufhrHMASOjw=;
 b=DTbMLXFLcAiB15aupDILUkfkz5gcC9f94HX5NsBdu7KUdwUxv8H4sA/hHV0eLJv1Zg
 VK8qSoAs3eoT26WJzo3aCh8WcBLCOqjCQC56r8GX2qHK3fUKr0w/DnfabTgCCXRGaun2
 hQtjdrH9YxiarIh9Zizdq7T+K/OxLjodKRv2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BBAzF3ukUH/0YN2wqJedYjAOrMYWc/znufhrHMASOjw=;
 b=TohJPyNaXBl+ebnvEjnHlBOnHRutfJyoIsRhit9uH7T/Mob+9N02YEjRTi4mWrJ5L2
 tjaqXr6O5JzqowPo5/oZ9zm/l9U7uMe062zhOumbOp5DSjfgneJIIXXh934rzbMom4cs
 IGdB2Wl79f+f3xiSpc/0Sc6VwAyWv/5tJsZ69wSRliGOeq6J+Kde05+M3gFKpYhrjfGi
 hlmImv8gAyp5auAVxBST5uX4kxeC/725W3i85YvJslYWHKlHkYDHqwnPljP4p+77qJVt
 HvmMc7n9TdcbE3VBoXxmEgyUVuTcCXoUCC8udIBTaElsfurFBzN+7UVLrYcbUqtl6335
 Kwtg==
X-Gm-Message-State: APjAAAX2EffO3EAF59U4XAC/Z8HKCuR9PBr68GgYPfuBZ4PBrjdE/ed1
 gL2gpmi8ezBZNXaFS1lFK9kVoy7cH1PnaiA+Rbzqaw==
X-Google-Smtp-Source: APXvYqwtKFD3/r+cWIqBKLLuiGzfuFV2T1vL9O4CSxpGbXJpLMcrf9zEidMeL+0DEwVPJdbGFlDa8SqPmFsr6woW+ok=
X-Received: by 2002:a05:660c:4d0:: with SMTP id
 v16mr7006290itk.62.1557475944416; 
 Fri, 10 May 2019 01:12:24 -0700 (PDT)
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
In-Reply-To: <a1b88d5add15d43de0468c32d9a2427629337abb.camel@oracle.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 10 May 2019 10:12:13 +0200
Message-ID: <CAKMK7uFd1xUx8u3xWLwifVSq4OEnMO4S-m0hESe68UzONXnMFg@mail.gmail.com>
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
 Brendan Higgins <brendanhiggins@google.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Shuah Khan <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm@lists.01.org, Frank Rowand <frowand.list@gmail.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 jdike@addtoit.com, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>, linux-kbuild@vger.kernel.org,
 Tim.Bird@sony.com, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>,
 Richard Weinberger <richard@nod.at>, sboyd@kernel.org,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Kees Cook <keescook@google.com>,
 linux-fsdevel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 10, 2019 at 7:49 AM Knut Omang <knut.omang@oracle.com> wrote:
>
> On Thu, 2019-05-09 at 22:18 -0700, Frank Rowand wrote:
> > On 5/9/19 4:40 PM, Logan Gunthorpe wrote:
> > >
> > >
> > > On 2019-05-09 5:30 p.m., Theodore Ts'o wrote:
> > >> On Thu, May 09, 2019 at 04:20:05PM -0600, Logan Gunthorpe wrote:
> > >>>
> > >>> The second item, arguably, does have significant overlap with kselftest.
> > >>> Whether you are running short tests in a light weight UML environment or
> > >>> higher level tests in an heavier VM the two could be using the same
> > >>> framework for writing or defining in-kernel tests. It *may* also be valuable
> > >>> for some people to be able to run all the UML tests in the heavy VM
> > >>> environment along side other higher level tests.
> > >>>
> > >>> Looking at the selftests tree in the repo, we already have similar items to
> > >>> what Kunit is adding as I described in point (2) above. kselftest_harness.h
> > >>> contains macros like EXPECT_* and ASSERT_* with very similar intentions to
> > >>> the new KUNIT_EXECPT_* and KUNIT_ASSERT_* macros.
> > >>>
> > >>> However, the number of users of this harness appears to be quite small. Most
> > >>> of the code in the selftests tree seems to be a random mismash of scripts
> > >>> and userspace code so it's not hard to see it as something completely
> > >>> different from the new Kunit:
> > >>>
> > >>> $ git grep --files-with-matches kselftest_harness.h *
> > >>
> > >> To the extent that we can unify how tests are written, I agree that
> > >> this would be a good thing.  However, you should note that
> > >> kselftest_harness.h is currently assums that it will be included in
> > >> userspace programs.  This is most obviously seen if you look closely
> > >> at the functions defined in the header files which makes calls to
> > >> fork(), abort() and fprintf().
> > >
> > > Ah, yes. I obviously did not dig deep enough. Using kunit for
> > > in-kernel tests and kselftest_harness for userspace tests seems like
> > > a sensible line to draw to me. Trying to unify kernel and userspace
> > > here sounds like it could be difficult so it's probably not worth
> > > forcing the issue unless someone wants to do some really fancy work
> > > to get it done.
> > >
> > > Based on some of the other commenters, I was under the impression
> > > that kselftests had in-kernel tests but I'm not sure where or if they
> > > exist.
> >
> > YES, kselftest has in-kernel tests.  (Excuse the shouting...)
> >
> > Here is a likely list of them in the kernel source tree:
> >
> > $ grep module_init lib/test_*.c
> > lib/test_bitfield.c:module_init(test_bitfields)
> > lib/test_bitmap.c:module_init(test_bitmap_init);
> > lib/test_bpf.c:module_init(test_bpf_init);
> > lib/test_debug_virtual.c:module_init(test_debug_virtual_init);
> > lib/test_firmware.c:module_init(test_firmware_init);
> > lib/test_hash.c:module_init(test_hash_init);  /* Does everything */
> > lib/test_hexdump.c:module_init(test_hexdump_init);
> > lib/test_ida.c:module_init(ida_checks);
> > lib/test_kasan.c:module_init(kmalloc_tests_init);
> > lib/test_list_sort.c:module_init(list_sort_test);
> > lib/test_memcat_p.c:module_init(test_memcat_p_init);
> > lib/test_module.c:static int __init test_module_init(void)
> > lib/test_module.c:module_init(test_module_init);
> > lib/test_objagg.c:module_init(test_objagg_init);
> > lib/test_overflow.c:static int __init test_module_init(void)
> > lib/test_overflow.c:module_init(test_module_init);
> > lib/test_parman.c:module_init(test_parman_init);
> > lib/test_printf.c:module_init(test_printf_init);
> > lib/test_rhashtable.c:module_init(test_rht_init);
> > lib/test_siphash.c:module_init(siphash_test_init);
> > lib/test_sort.c:module_init(test_sort_init);
> > lib/test_stackinit.c:module_init(test_stackinit_init);
> > lib/test_static_key_base.c:module_init(test_static_key_base_init);
> > lib/test_static_keys.c:module_init(test_static_key_init);
> > lib/test_string.c:module_init(string_selftest_init);
> > lib/test_ubsan.c:module_init(test_ubsan_init);
> > lib/test_user_copy.c:module_init(test_user_copy_init);
> > lib/test_uuid.c:module_init(test_uuid_init);
> > lib/test_vmalloc.c:module_init(vmalloc_test_init)
> > lib/test_xarray.c:module_init(xarray_checks);
> >
> >
> > > If they do exists, it seems like it would make sense to
> > > convert those to kunit and have Kunit tests run-able in a VM or
> > > baremetal instance.
> >
> > They already run in a VM.
> >
> > They already run on bare metal.
> >
> > They already run in UML.
> >
> > This is not to say that KUnit does not make sense.  But I'm still trying
> > to get a better description of the KUnit features (and there are
> > some).
>
> FYI, I have a master student who looks at converting some of these to KTF, such as for
> instance the XArray tests, which lended themselves quite good to a semi-automated
> conversion.
>
> The result is also a somewhat more compact code as well as the flexibility
> provided by the Googletest executor and the KTF frameworks, such as running selected
> tests, output formatting, debugging features etc.

So is KTF already in upstream? Or is the plan to unify the KTF and
Kunit in-kernel test harnesses? Because there's tons of these
in-kernel unit tests already, and every merge we get more (Frank's
list didn't even look into drivers or anywhere else, e.g. it's missing
the locking self tests I worked on in the past), and a more structured
approach would really be good.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
