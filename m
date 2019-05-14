Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806551C540
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 10:48:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AA05321275441;
	Tue, 14 May 2019 01:48:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 89E0E2125330C
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6D6XPiWXHxqHbgGlzUb4e9FTkb9mj+8eXq8zwFhMaYI=; b=gQyJ4Bn+wwRdSW9t/2bWSVmyc
 AwkGokt1sRtEs0MFOzfvXdxNauIujIkO6DiCAA3SOTN0UFbrDi+SLIZripyW+aGfpCexFCP0BzvAH
 IlYP9j/H30eFgvgo9ZkFb3AKPBLsupHh7y68WZsbeVhh54K9lwJtSLIvcIDJS1VEaRQGKi/fVSfGS
 48zJdBoc3DzvL/pKKac0qDcALZBmcyi0ZeXu7FkhM4YyodyeuMGqq3ZAdBYQrpl3nrJxsVTrtSutJ
 0YkFNQHEEV1TPeoT3CoGRRj7cYr67v35O8QkZL1uGCglGPoJ5gpayGhWwv0+XlAiPH89k4GZ/Z81C
 usWzVhhCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQT5N-0006we-E6; Tue, 14 May 2019 08:46:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 662E32029FD7A; Tue, 14 May 2019 10:46:55 +0200 (CEST)
Date: Tue, 14 May 2019 10:46:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v3 08/18] objtool: add kunit_try_catch_throw to the
 noreturn list
Message-ID: <20190514084655.GK2589@hirez.programming.kicks-ass.net>
References: <20190514054251.186196-1-brendanhiggins@google.com>
 <20190514054251.186196-9-brendanhiggins@google.com>
 <20190514065643.GC2589@hirez.programming.kicks-ass.net>
 <20190514081223.GA230665@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190514081223.GA230665@google.com>
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
 yamada.masahiro@socionext.com, mpe@ellerman.id.au,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org,
 kbuild test robot <lkp@intel.com>, linux-nvdimm@lists.01.org,
 frowand.list@gmail.com, knut.omang@oracle.com, kieran.bingham@ideasonboard.com,
 wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr,
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 tytso@mit.edu, richard@nod.at, sboyd@kernel.org, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org,
 daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org,
 khilman@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 14, 2019 at 01:12:23AM -0700, Brendan Higgins wrote:
> On Tue, May 14, 2019 at 08:56:43AM +0200, Peter Zijlstra wrote:
> > On Mon, May 13, 2019 at 10:42:42PM -0700, Brendan Higgins wrote:
> > > This fixes the following warning seen on GCC 7.3:
> > >   kunit/test-test.o: warning: objtool: kunit_test_unsuccessful_try() falls through to next function kunit_test_catch()
> > > 
> > 
> > What is that file and function; no kernel tree near me seems to have
> > that.
> 
> Oh, sorry about that. The function is added in the following patch,
> "[PATCH v3 09/18] kunit: test: add support for test abort"[1].
> 
> My apologies if this patch is supposed to come after it in sequence, but
> I assumed it should come before otherwise objtool would complain about
> the symbol when it is introduced.

Or send me all patches such that I have context, or have a sane
Changelog that gives me context. Just don't give me one patch with a
crappy changelog.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
