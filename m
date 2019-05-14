Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3669B1CEBE
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 20:12:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 687D02127544E;
	Tue, 14 May 2019 11:12:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2635E21244A6A
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 11:12:39 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z3so9019214pgp.8
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=N4UQ8E37RD8PM/SrG8N/O0bEDGjz00r1+gSc2WyT1f4=;
 b=Do+8Q+pHF8OB+tlzSEbCAlPOY5hObzGGmcvPm0YH3pOm8OWb+2EG6k/+3FX9ODnKET
 HeeejJJzGaiMQRAOmVbGKQQo9GMUp77yZaFJ+oq5A5++UZ2bqGz1eozejMrClIviWLaH
 6NqHaVQChwYnFjxvjCGyJrQCTbtCzP1YDVjWmeDvwiekfu/CIsr1rAo7eeV2cOghCM3s
 jg1XfDoXavpa+8h5sP6zhUgTkyTdA3gv3smrtEjkWIEZtUEMHzNqwHjzR4ACtYGyLA5t
 PjdZhQFtOg524SURCKg00duz4q2SfEaie9Z/aI0bjh6oNPjygJN8c7oYJhw88kmkUhL7
 hq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=N4UQ8E37RD8PM/SrG8N/O0bEDGjz00r1+gSc2WyT1f4=;
 b=aM6R4J73n237L0s5eyz8CgBkdauKIR3bkxRv9ikX6ubu8Xe55lEqjeVgA8vVruaLOm
 fvc/NIHr5l4ABLt8KXJq2XkNnQ7FatYl2XUjNYOGjb6pUbLb3YHtT5iDh74Oys3cmVad
 FOIMqZO942mpigUk+iaKSgOzFW/OF3klLllp17x7OliZJK1uRyqkm82zaxp6cIPlo+ys
 b3SApMzQbU79TsXZmAy5V/w01V4losNMyc5rOAIyXqBfVx5dKU7N7Q+6UyrC5Eb4rCsP
 N+GGFwKYIkMNJ0SgGThlIIjexdl9mEXeAJNJYA5QYZmvZHU2eQbgVnzx/4/wM9baszmU
 vyFg==
X-Gm-Message-State: APjAAAVrdNKGQF4kiAhl1PKhHL5dQbMVNMMnQgeiN0DTujuMSBpFf4rj
 HR9FZtSyj5oWRlWrGX+iwK6mRg==
X-Google-Smtp-Source: APXvYqzF1W3MvAqglRw1f3U3GzCogO4oDzfR+rvBgcAvxH3aiWBoZY2un6t4j9IVvIzAxmzzun0V4w==
X-Received: by 2002:a62:d244:: with SMTP id c65mr3681839pfg.173.1557857559066; 
 Tue, 14 May 2019 11:12:39 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
 by smtp.gmail.com with ESMTPSA id w189sm22611956pfw.147.2019.05.14.11.12.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 14 May 2019 11:12:38 -0700 (PDT)
Date: Tue, 14 May 2019 11:12:33 -0700
From: Brendan Higgins <brendanhiggins@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 08/18] objtool: add kunit_try_catch_throw to the
 noreturn list
Message-ID: <20190514181233.GB109557@google.com>
References: <20190514054251.186196-1-brendanhiggins@google.com>
 <20190514054251.186196-9-brendanhiggins@google.com>
 <20190514065643.GC2589@hirez.programming.kicks-ass.net>
 <20190514081223.GA230665@google.com>
 <20190514084655.GK2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190514084655.GK2589@hirez.programming.kicks-ass.net>
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

On Tue, May 14, 2019 at 10:46:55AM +0200, Peter Zijlstra wrote:
> On Tue, May 14, 2019 at 01:12:23AM -0700, Brendan Higgins wrote:
> > On Tue, May 14, 2019 at 08:56:43AM +0200, Peter Zijlstra wrote:
> > > On Mon, May 13, 2019 at 10:42:42PM -0700, Brendan Higgins wrote:
> > > > This fixes the following warning seen on GCC 7.3:
> > > >   kunit/test-test.o: warning: objtool: kunit_test_unsuccessful_try() falls through to next function kunit_test_catch()
> > > > 
> > > 
> > > What is that file and function; no kernel tree near me seems to have
> > > that.
> > 
> > Oh, sorry about that. The function is added in the following patch,
> > "[PATCH v3 09/18] kunit: test: add support for test abort"[1].
> > 
> > My apologies if this patch is supposed to come after it in sequence, but
> > I assumed it should come before otherwise objtool would complain about
> > the symbol when it is introduced.
> 
> Or send me all patches such that I have context, or have a sane
> Changelog that gives me context. Just don't give me one patch with a
> crappy changelog.

I will provide more context in the next revision.

Sorry about that!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
