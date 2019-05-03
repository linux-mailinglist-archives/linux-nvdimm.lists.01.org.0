Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A7A127F5
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 08:48:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E42D21244A1C;
	Thu,  2 May 2019 23:48:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 281552122CABD
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 23:48:42 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id f23so4385187otl.9
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 23:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B/vgrL6mFJjbubEtdk9xy4dCVOTfDfNigFjtHMJz6Hg=;
 b=BWFlXcxdKPCg7HeydPM9nymqdJaKu5v0FhgYXNSsx2wC9FgZ6BWl9owIL4tp34RHzV
 0O2CI2x3Gf2dd6TLPVl+UCJIuR6ugbJgNiJ5ahKuIYIQ+IA6TXvM7s76WSfiT5u9UOjU
 BAmfjJWmXXmLvLfanifCHtnmcT9eQgxYIv2/nMEQ/h+Jh7SQ4Wq8KAXXS2vmQSRvUjv3
 lY5jQIBJ2XBRYHgExTQbP6djFMEjOYOf+5XNpdQj+/aplIkBZPZ/tX1ygb8a9ZyYzeEG
 YiV5A2XgkK4p5mdxg0WTkGqiAuXfNRl77gHQcoJRclt/bqm0TtNUGFDJL3udF8SKeGs/
 dUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B/vgrL6mFJjbubEtdk9xy4dCVOTfDfNigFjtHMJz6Hg=;
 b=N+rP/JnBpOuOARbcUkOP2Ou9WVix/B8asEgLQe/vb2ooz33O/OZgk4dvdaJ+AnRE8b
 /zr8g04uN05m+txtDbSsUzgTn6OeCY0q1oUso5Lsm2N11u7M+YyyhDfQJRF0lY1/WN+J
 pB5xAhMWidkmSBSHLpFeQgw+Uxe2yTCUFiX7Z/o2yNLjx2mrhoO6iyUVrm4x+tOocwvQ
 KwtOSuNC3wqPTTBO8Fk7bIwDqE9ZSY73tZbWfyY5jjuMe2eK3RItO6MR7LBp7Bk+3ADz
 R+H3GtVB1lv6HLF3vk4fcEiSZl7Y8Pc7CUHUcTFP8lg8DhrC8SwltnAj/umZIPLtUINz
 xg8w==
X-Gm-Message-State: APjAAAVWQU1pCGCpiMw9P8J1mZR/N4aqFn4BxJ1jZ5N2z6M/C3HH+gj9
 +qL2mf3jHDLdiouSyHuO61hWC9PNTLG3ZxTp48sJsQ==
X-Google-Smtp-Source: APXvYqyPne+GcGg5xCp23Lwb83V334Sd3k9K4ces08vt/qj/xTxzgyMfUgwlwCqUT5AUGkcD/SfnjL8zKAwKDrfcpHY=
X-Received: by 2002:a9d:5cc3:: with SMTP id r3mr5382470oti.338.1556866121691; 
 Thu, 02 May 2019 23:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-9-brendanhiggins@google.com>
 <0a605543-477a-1854-eb35-6e586606889b@deltatee.com>
In-Reply-To: <0a605543-477a-1854-eb35-6e586606889b@deltatee.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 2 May 2019 23:48:30 -0700
Message-ID: <CAFd5g47hxAd=+72xbPJbWPdZCXRXmtLpsGhUh=zc7MSwfcaGJQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/17] kunit: test: add support for test abort
To: Logan Gunthorpe <logang@deltatee.com>
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
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>, linux-kbuild@vger.kernel.org, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 2, 2019 at 8:15 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-05-01 5:01 p.m., Brendan Higgins wrote:
> > +/*
> > + * struct kunit_try_catch - provides a generic way to run code which might fail.
> > + * @context: used to pass user data to the try and catch functions.
> > + *
> > + * kunit_try_catch provides a generic, architecture independent way to execute
> > + * an arbitrary function of type kunit_try_catch_func_t which may bail out by
> > + * calling kunit_try_catch_throw(). If kunit_try_catch_throw() is called, @try
> > + * is stopped at the site of invocation and @catch is catch is called.
>
> I found some of the C++ comparisons in this series a bit distasteful but
> wasn't going to say anything until I saw the try catch.... But looking
> into the implementation it's just a thread that can exit early which
> seems fine to me. Just a poor choice of name I guess...

Guilty as charged (I have a long history with C++, sorry). Would you
prefer I changed the name? I just figured that try-catch is a commonly
understood pattern that describes exactly what I am doing.

>
> [snip]
>
> > +static void __noreturn kunit_abort(struct kunit *test)
> > +{
> > +     kunit_set_death_test(test, true);
> > +
> > +     kunit_try_catch_throw(&test->try_catch);
> > +
> > +     /*
> > +      * Throw could not abort from test.
> > +      *
> > +      * XXX: we should never reach this line! As kunit_try_catch_throw is
> > +      * marked __noreturn.
> > +      */
> > +     WARN_ONCE(true, "Throw could not abort from test!\n");
> > +}
> > +
> >  int kunit_init_test(struct kunit *test, const char *name)
> >  {
> >       spin_lock_init(&test->lock);
> > @@ -77,6 +103,7 @@ int kunit_init_test(struct kunit *test, const char *name)
> >       test->name = name;
> >       test->vprintk = kunit_vprintk;
> >       test->fail = kunit_fail;
> > +     test->abort = kunit_abort;
>
> There are a number of these function pointers which seem to be pointless
> to me as you only ever set them to one function. Just call the function
> directly. As it is, it is an unnecessary indirection for someone reading
> the code. If and when you have multiple implementations of the function
> then add the pointer. Don't assume you're going to need it later on and
> add all this maintenance burden if you never use it..

Ah, yes, Frank (and probably others) previously asked me to remove
unnecessary method pointers; I removed all the totally unused ones. As
for these, I don't use them in this patchset, but I use them in my
patchsets that will follow up this one. These in particular are
present so that they can be mocked out for testing.

>
> [snip]
>
> > +void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch)
> > +{
> > +     try_catch->run = kunit_generic_run_try_catch;
> > +     try_catch->throw = kunit_generic_throw;
> > +}
>
> Same here. There's only one implementation of try_catch and I can't
> really see any sensible justification for another implementation. Even
> if there is, add the indirection when the second implementation is
> added. This isn't C++ and we don't need to make everything a "method".

These methods are for a UML specific implementation in a follow up
patchset, which is needed for some features like crash recovery, death
tests, and removes dependence on kthreads.

I know this probably sounds like premature complexity. Arguably it is
in hindsight, but I wrote those features before I pulled out these
interfaces (they were actually both originally in this patchset, but I
dropped them to make this patchset easier to review). I can remove
these methods and add them back in when I actually use them in the
follow up patchsets if you prefer.

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
