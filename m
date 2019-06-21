Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 944834EE9A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Jun 2019 20:15:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 005042129F11B;
	Fri, 21 Jun 2019 11:15:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=18.9.28.11; helo=outgoing.mit.edu; envelope-from=tytso@mit.edu;
 receiver=linux-nvdimm@lists.01.org 
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4B72221290DC5
 for <linux-nvdimm@lists.01.org>; Fri, 21 Jun 2019 11:15:07 -0700 (PDT)
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com
 [104.133.0.109] (may be forged)) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5LIDgGF021070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2019 14:13:44 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
 id 441B9420484; Fri, 21 Jun 2019 14:13:42 -0400 (EDT)
Date: Fri, 21 Jun 2019 14:13:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: shuah <shuah@kernel.org>
Subject: Re: [PATCH v5 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190621181342.GA17166@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, shuah <shuah@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Brendan Higgins <brendanhiggins@google.com>,
 gregkh@linuxfoundation.org, jpoimboe@redhat.com,
 keescook@google.com, kieran.bingham@ideasonboard.com,
 mcgrof@kernel.org, peterz@infradead.org, robh@kernel.org,
 sboyd@kernel.org, yamada.masahiro@socionext.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
 Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
 amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
 jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
 khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
 mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
 richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
 wfg@linux.intel.com
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <10feac3e-7621-65e5-fbf0-9c63fcbe09c9@gmail.com>
 <69809117-dcda-160a-ee0a-d1d3b4c5cd8a@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69809117-dcda-160a-ee0a-d1d3b4c5cd8a@kernel.org>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org,
 amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>,
 dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
 yamada.masahiro@socionext.com, mpe@ellerman.id.au,
 linux-kselftest@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 robh@kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com,
 knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com,
 kunit-dev@googlegroups.com, richard@nod.at, sboyd@kernel.org,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch,
 keescook@google.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 21, 2019 at 08:59:48AM -0600, shuah wrote:
> > > ### But wait! Doesn't kselftest support in kernel testing?!
> > >
> > > ....
> 
> I think I commented on this before. I agree with the statement that
> there is no overlap between Kselftest and KUnit. I would like see this
> removed. Kselftest module support supports use-cases KUnit won't be able
> to. I can build an kernel with Kselftest test modules and use it in the
> filed to load and run tests if I need to debug a problem and get data
> from a system. I can't do that with KUnit.
> 
> In my mind, I am not viewing this as which is better. Kselftest and
> KUnit both have their place in the kernel development process. It isn't
> productive and/or necessary to comparing Kselftest and KUnit without a
> good understanding of the problem spaces for each of these.
>
> I would strongly recommend not making reference to Kselftest and talk
> about what KUnit offers.

Shuah,

Just to recall the history, this section of the FAQ was added to rebut
the ***very*** strong statements that Frank made that there was
overlap between Kselftest and Kunit, and that having too many ways for
kernel developers to do the identical thing was harmful (he said it
was too much of a burden on a kernel developer) --- and this was an
argument for not including Kunit in the upstream kernel.

If we're past that objection, then perhaps this section can be
dropped, but there's a very good reason why it was there.  I wouldn't
Brendan to be accused of ignoring feedback from those who reviewed his
patches.   :-)

						- Ted
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
