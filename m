Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1618355
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 May 2019 03:45:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 417952125ADCC;
	Wed,  8 May 2019 18:45:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=18.9.28.11; helo=outgoing.mit.edu; envelope-from=tytso@mit.edu;
 receiver=linux-nvdimm@lists.01.org 
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D5E6121256BC8
 for <linux-nvdimm@lists.01.org>; Wed,  8 May 2019 18:45:08 -0700 (PDT)
Received: from callcc.thunk.org ([66.31.38.53]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x491i7RW019749
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 8 May 2019 21:44:09 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 9759E420024; Wed,  8 May 2019 21:44:07 -0400 (EDT)
Date: Wed, 8 May 2019 21:44:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190509014407.GA7031@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
 Frank Rowand <frowand.list@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Brendan Higgins <brendanhiggins@google.com>, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org,
 sboyd@kernel.org, shuah@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
 Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
 dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
 joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
 knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
 pmladek@suse.com, richard@nod.at, rientjes@google.com,
 rostedt@goodmis.org, wfg@linux.intel.com
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
 Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org,
 Alexander.Levin@microsoft.com, mpe@ellerman.id.au,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org,
 linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com,
 kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au,
 rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com,
 devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com,
 linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr,
 kunit-dev@googlegroups.com, richard@nod.at, sboyd@kernel.org,
 Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 08, 2019 at 05:58:49PM -0700, Frank Rowand wrote:
> 
> If KUnit is added to the kernel, and a subsystem that I am submitting
> code for has chosen to use KUnit instead of kselftest, then yes, I do
> *have* to use KUnit if my submission needs to contain a test for the
> code unless I want to convince the maintainer that somehow my case
> is special and I prefer to use kselftest instead of KUnittest.

That's going to be between you and the maintainer.  Today, if you want
to submit a substantive change to xfs or ext4, you're going to be
asked to create test for that new feature using xfstests.  It doesn't
matter that xfstests isn't in the kernel --- if that's what is
required by the maintainer.

> > supposed to be a simple way to run a large number of small tests that
> > for specific small components in a system.
> 
> kselftest also supports running a subset of tests.  That subset of tests
> can also be a large number of small tests.  There is nothing inherent
> in KUnit vs kselftest in this regard, as far as I am aware.

The big difference is that kselftests are driven by a C program that
runs in userspace.  Take a look at tools/testing/selftests/filesystem/dnotify_test.c
it has a main(int argc, char *argv) function.

In contrast, KUnit are fragments of C code which run in the kernel;
not in userspace.  This allows us to test internal functions inside
complex file system (such as the block allocator in ext4) directly.
This makes it *fundamentally* different from kselftest.

Cheers,

						- Ted
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
