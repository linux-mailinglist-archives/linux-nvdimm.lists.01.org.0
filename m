Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E9F96D9A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 01:23:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A92BB20212CA5;
	Tue, 20 Aug 2019 16:24:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 610962020D32C
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 16:24:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y1so234467plp.9
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 16:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BgeboBXYdH2mwUYNdA3OBv6wqHBTlo9IT3Q8RNantq8=;
 b=Rni4clsu++7h96C43S+JbBXXkW3gKlVOYt85WpUO9PVUNOQAyZoV9ZeqzedJ1OVMFx
 8rIO1yErMiuPpLQ9sjtVMHG1jFX4fJklQ/PjHt12vwHBikcFbmL+JH4XebCtdX0yR6Ne
 /Ku/wtLkEaRcfVrBLNhoOWWl506znCj2wEM8/+jrC4flwkKt3STFQoP7x3bxbt5r7719
 hdp/sy/7uU7ZgdFgwJ1AO9EAvZQT6mQ9FyOhMFksTEDFwGUKQRR3mFtVrfEUr8Q5ksgi
 nF8kmhxSBCnQuM25k/D9rldBfN5XmkaaeL1KNxMPXXyinqbNL7GUBH09SVaM/WlOuE59
 VQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BgeboBXYdH2mwUYNdA3OBv6wqHBTlo9IT3Q8RNantq8=;
 b=h5ODQYxQDSKv2kGZWnXwN2D9c03jVS2LT7H7bo9KfuQXVVu89d4HlqM/3Qa059QaBQ
 ChIglLkHwr5BAgV8kCVY1BLNLPk3+mXgLkO5kZ6VKrLdkNL1VCqYlaJEH8gkczdpyjvl
 V/HOIBJZFp+1ova6Fwt2doXP23rEsnmDqV0LMJ4uPxsVaER/iFnUM0kprxeHiplEULV8
 rrRQSU5FDhkoylaby1ekIwMjYq3uu98l99Ou0c+ov0lyTFl1jFi+lkh/P2ciIz5/5aP+
 rlavoJ3N0h+Vo8KGUIBv95fqFGPvzdWhpLkAGg711re47puqTqfn3ze3jTjdMzQF8O0o
 5Gtg==
X-Gm-Message-State: APjAAAWu0nkStjfTAMNfai7Jt+AVxfta78IofnRPCIZU3t75f3EKPnD0
 oCJZXzNd5piVhWfkWW1qOsmA1y7N3rN3oT8l14s/oQ==
X-Google-Smtp-Source: APXvYqxXREKtyoSmqThzifpm0xupcZJncgCG4zF1cdnP+ZHsoxUg77sjBGnyRvdHt5/5lrCrktItt1lg4/mEcxF/N4g=
X-Received: by 2002:a17:902:7049:: with SMTP id
 h9mr31488817plt.232.1566343416854; 
 Tue, 20 Aug 2019 16:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190814055108.214253-1-brendanhiggins@google.com>
 <5b880f49-0213-1a6e-9c9f-153e6ab91eeb@kernel.org>
 <20190820182450.GA38078@google.com>
 <e8eaf28e-75df-c966-809a-2e3631353cc9@kernel.org>
 <CAFd5g44JT_KQ+OxjVdG0qMWuaEB0Zq5x=r6tLsqJdncwZ_zbGA@mail.gmail.com>
In-Reply-To: <CAFd5g44JT_KQ+OxjVdG0qMWuaEB0Zq5x=r6tLsqJdncwZ_zbGA@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 20 Aug 2019 16:23:25 -0700
Message-ID: <CAFd5g44aO40G7Wc-51EPyhWZgosN4ZHwwSjKe7CU_vi2OD7eKA@mail.gmail.com>
Subject: Re: [PATCH v13 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: shuah <shuah@kernel.org>
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
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>,
 Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Aug 20, 2019 at 2:26 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Aug 20, 2019 at 12:08 PM shuah <shuah@kernel.org> wrote:
> >
> > On 8/20/19 12:24 PM, Brendan Higgins wrote:
> > > On Tue, Aug 20, 2019 at 11:24:45AM -0600, shuah wrote:
> > >> On 8/13/19 11:50 PM, Brendan Higgins wrote:
> > >>> ## TL;DR
> > >>>
> > >>> This revision addresses comments from Stephen and Bjorn Helgaas. Most
> > >>> changes are pretty minor stuff that doesn't affect the API in anyway.
> > >>> One significant change, however, is that I added support for freeing
> > >>> kunit_resource managed resources before the test case is finished via
> > >>> kunit_resource_destroy(). Additionally, Bjorn pointed out that I broke
> > >>> KUnit on certain configurations (like the default one for x86, whoops).
> > >>>
> > >>> Based on Stephen's feedback on the previous change, I think we are
> > >>> pretty close. I am not expecting any significant changes from here on
> > >>> out.
> > >>>
> > >>
> > >> Hi Brendan,
> > >>
> > >> I found checkpatch errors in one or two patches. Can you fix those and
> > >> send v14.
> > >
> > > Hi Shuah,
> > >
> > > Are you refering to the following errors?
> > >
> > > ERROR: Macros with complex values should be enclosed in parentheses
> > > #144: FILE: include/kunit/test.h:456:
> > > +#define KUNIT_BINARY_CLASS \
> > > +       kunit_binary_assert, KUNIT_INIT_BINARY_ASSERT_STRUCT
> > >
> > > ERROR: Macros with complex values should be enclosed in parentheses
> > > #146: FILE: include/kunit/test.h:458:
> > > +#define KUNIT_BINARY_PTR_CLASS \
> > > +       kunit_binary_ptr_assert, KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT
> > >
> > > These values should *not* be in parentheses. I am guessing checkpatch is
> > > getting confused and thinks that these are complex expressions, when
> > > they are not.
> > >
> > > I ignored the errors since I figured checkpatch was complaining
> > > erroneously.
> > >
> > > I could refactor the code to remove these macros entirely, but I think
> > > the code is cleaner with them.
> > >
> >
> > Please do. I am not veru sure what value these macros add.
>
> Alright, I will have something for you later today.

I just sent a new revision with the fix.

Cheers
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
