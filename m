Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F621C493
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 10:22:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A355A212746D6;
	Tue, 14 May 2019 01:22:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E1252212532F5
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 01:22:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r18so3114720pls.13
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 01:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pQNyZmnkLUqdbsnux8K39fvyz0qGerh/7Car1s/R2uk=;
 b=tWPxjZovh3MyjrxN+cixrW9Jv9/RHjc+lJ7GXmNoQ/Ef7+uMw/qQbTw5B9oFRJByIG
 pu9cyVG7MEJ6Vrt9UDR/0OiBNk3XC3mIME5PnMdl1pxZjgK/yYxMK2jT2bktFIZCLj/9
 rAq5RImK1TNYHhzh3BwnBdJnTscEEXpdoCXCZrYFiBJt6MVyxh9eyaIR+hsmrppBY4Er
 Bq/52n3SPw77fLYMMjIJQxNzhUURTmdWpHo3b3rdN6ULdHR6om48a59eyBuoLr8W0DtP
 VybSOjpmoyAKFiH9TuBHDkyK9+loWcz1WQPsILkxRVCB7AQgy3rXyfsfxyR+sEcpOSQW
 MevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pQNyZmnkLUqdbsnux8K39fvyz0qGerh/7Car1s/R2uk=;
 b=CWQSBCkwJRwKT3oP5JHltcS0IIYIkM9NQKkK0saYKQkAayatmB2AzIyfv8DmMvQl4t
 lw883/tQs6xe1CPcbqFkTehLQ6As+W5TnCnvX07fb+9/3JJWrSKGfQsadwOr37aTy4oH
 zO/x+nqJDbBwlk4j3jmS3o/b7kCL4TuFngqXK6FosRYCa6NH7Hni1xPhbq0/ORSxt8AE
 /gt8MP6sP+wMJVyV1HgpwqTUwBKRgd7SKKBkx+z8wEE6CLQnSbODM1RPPWVMRa6L1pVD
 Cx01DF7TLKBUmhmoc7jf/eR9Qoh2oQaYilYNjkUO3UqZfQuuYe2izTdEugYUoH9riavY
 2qzg==
X-Gm-Message-State: APjAAAX0vSxjUlB310t9FOpmCTW76cf0yJx8bZ5FW06WgF+RBf82lm1Z
 1R/0oUgJxy8glxV8iZ6rMpfDbw==
X-Google-Smtp-Source: APXvYqxXP9cCuNSrb6ZlkbjUS9VfrgYUq3KTkMgAUQmqTxOMmXPmYuZ0Q7WN0Be8aLpg1XdbhvZmmA==
X-Received: by 2002:a17:902:28ab:: with SMTP id
 f40mr8616928plb.295.1557822140758; 
 Tue, 14 May 2019 01:22:20 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
 by smtp.gmail.com with ESMTPSA id d67sm23500676pfa.35.2019.05.14.01.22.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 14 May 2019 01:22:19 -0700 (PDT)
Date: Tue, 14 May 2019 01:22:14 -0700
From: Brendan Higgins <brendanhiggins@google.com>
To: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190514082214.GB230665@google.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com> <20190507172256.GB5900@mit.edu>
 <4d963cdc-1cbb-35a3-292c-552f865ed1f7@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4d963cdc-1cbb-35a3-292c-552f865ed1f7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
 dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
 mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 robh@kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com,
 knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, richard@nod.at, sboyd@kernel.org,
 Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 08, 2019 at 05:58:49PM -0700, Frank Rowand wrote:
> Hi Ted,
> 
> On 5/7/19 10:22 AM, Theodore Ts'o wrote:
> > On Tue, May 07, 2019 at 10:01:19AM +0200, Greg KH wrote:
> Not very helpful to cut the text here, plus not explicitly indicating that
> text was cut (yes, I know the ">>>" will be a clue for the careful reader),
> losing the set up for my question.
> 
> 
> >>> My understanding is that the intent of KUnit is to avoid booting a kernel on
> >>> real hardware or in a virtual machine.  That seems to be a matter of semantics
> >>> to me because isn't invoking a UML Linux just running the Linux kernel in
> >>> a different form of virtualization?
> >>>
> >>> So I do not understand why KUnit is an improvement over kselftest.
> >>>
> >>> It seems to me that KUnit is just another piece of infrastructure that I
> >>> am going to have to be familiar with as a kernel developer.  More overhead,
> >>> more information to stuff into my tiny little brain.
> >>>
> >>> I would guess that some developers will focus on just one of the two test
> >>> environments (and some will focus on both), splitting the development
> >>> resources instead of pooling them on a common infrastructure.
> >>>
> >>> What am I missing?
> >>
> >> kselftest provides no in-kernel framework for testing kernel code
> >> specifically.  That should be what kunit provides, an "easy" way to
> >> write in-kernel tests for things.
> >>
> >> Brendan, did I get it right?
> > 
> > Yes, that's basically right.  You don't *have* to use KUnit.  It's
> 
> If KUnit is added to the kernel, and a subsystem that I am submitting
> code for has chosen to use KUnit instead of kselftest, then yes, I do
> *have* to use KUnit if my submission needs to contain a test for the
> code unless I want to convince the maintainer that somehow my case
> is special and I prefer to use kselftest instead of KUnittest.
> 
> 
> > supposed to be a simple way to run a large number of small tests that
> > for specific small components in a system.
> 
> kselftest also supports running a subset of tests.  That subset of tests
> can also be a large number of small tests.  There is nothing inherent
> in KUnit vs kselftest in this regard, as far as I am aware.
> 
> 
> > For example, I currently use xfstests using KVM and GCE to test all of
> > ext4.  These tests require using multiple 5 GB and 20GB virtual disks,
> > and it works by mounting ext4 file systems and exercising ext4 through
> > the system call interfaces, using userspace tools such as fsstress,
> > fsx, fio, etc.  It requires time overhead to start the VM, create and
> > allocate virtual disks, etc.  For example, to run a single 3 seconds
> > xfstest (generic/001), it requires full 10 seconds to run it via
> > kvm-xfstests.
> > 
> 
> 
> > KUnit is something else; it's specifically intended to allow you to
> > create lightweight tests quickly and easily, and by reducing the
> > effort needed to write and run unit tests, hopefully we'll have a lot
> > more of them and thus improve kernel quality.
> 
> The same is true of kselftest.  You can create lightweight tests in
> kselftest.
> 
> 
> > As an example, I have a volunteer working on developing KUinit tests
> > for ext4.  We're going to start by testing the ext4 extent status
> > tree.  The source code is at fs/ext4/extent_status.c; it's
> > approximately 1800 LOC.  The Kunit tests for the extent status tree
> > will exercise all of the corner cases for the various extent status
> > tree functions --- e.g., ext4_es_insert_delayed_block(),
> > ext4_es_remove_extent(), ext4_es_cache_extent(), etc.  And it will do
> > this in isolation without our needing to create a test file system or
> > using a test block device.
> > 
> 
> > Next we'll test the ext4 block allocator, again in isolation.  To test
> > the block allocator we will have to write "mock functions" which
> > simulate reading allocation bitmaps from disk.  Again, this will allow
> > the test writer to explicitly construct corner cases and validate that
> > the block allocator works as expected without having to reverese
> > engineer file system data structures which will force a particular
> > code path to be executed.
> 
> This would be a difference, but mock functions do not exist in KUnit.
> The KUnit test will call the real kernel function in the UML kernel.
> 
> I think Brendan has indicated a desire to have mock functions in the
> future.
> 
> Brendan, do I understand that correctly?

Oh, sorry, I missed this comment from earlier.

Yes, you are correct. Function mocking is a feature I will be
introducing in a follow up patchset (assuming this one gets merged of
course ;-) ).

Cheers!

> -Frank
> 
> > So this is why it's largely irrelevant to me that KUinit uses UML.  In
> > fact, it's a feature.  We're not testing device drivers, or the
> > scheduler, or anything else architecture-specific.  UML is not about
> > virtualization.  What it's about in this context is allowing us to
> > start running test code as quickly as possible.  Booting KVM takes
> > about 3-4 seconds, and this includes initializing virtio_scsi and
> > other device drivers.  If by using UML we can hold the amount of
> > unnecessary kernel subsystem initialization down to the absolute
> > minimum, and if it means that we can communicating to the test
> > framework via a userspace "printf" from UML/KUnit code, as opposed to
> > via a virtual serial port to KVM's virtual console, it all makes for
> > lighter weight testing.
> > 
> > Why did I go looking for a volunteer to write KUnit tests for ext4?
> > Well, I have a plan to make some changes in restructing how ext4's
> > write path works, in order to support things like copy-on-write, a
> > more efficient delayed allocation system, etc.  This will require
> > making changes to the extent status tree, and by having unit tests for
> > the extent status tree, we'll be able to detect any bugs that we might
> > accidentally introduce in the es tree far more quickly than if we
> > didn't have those tests available.  Google has long found that having
> > these sorts of unit tests is a real win for developer velocity for any
> > non-trivial code module (or C++ class), even when you take into
> > account the time it takes to create the unit tests.
> > 
> > 					- Ted>
> > P.S.  Many thanks to Brendan for finding such a volunteer for me; the
> > person in question is a SRE from Switzerland who is interested in
> > getting involved with kernel testing, and this is going to be their
> > 20% project.  :-)
> > 
> > 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
