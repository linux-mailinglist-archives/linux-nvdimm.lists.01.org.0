Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 222BD8AE6E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 07:03:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D3F392131BA48;
	Mon, 12 Aug 2019 22:06:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 044B72130A4E6
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 22:06:10 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z3so1951745pln.6
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 22:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aKOfFTV6VGP5BNUB1Vnarc/F0DL+26vq0829FAbZrqo=;
 b=svgoSdNRxSLsCnnIOc7xbQg9GgF9oKMJ1Zy9kd11vWwaKXoOnKpb4m3E5VD5iVlgYD
 +Q8GW61vmO7pSODND/EU3ySpZFU6zBm/nnzXrEdbXjYeyp0z5HZ4MlPGEFDVamV7AnNt
 YxSzN7MGuqE5YtmeQLv8pM8cwjVoHM11Q7HgFuNs7NBSHTrEDEHtBfVlPMX1tM122Zoh
 /lJWbiyvCy294xIaxGNy1x0QeVRdkekMXrwW6vrlb0zY+yiiNnJIqQVHv78TipzeF0fL
 lbgrIbrBSmtQjgptdFMq0Sq8pSiArBm+sF/Wu+BeNyqHXo/vQXv7UP+JqfWMmgemFjSH
 IU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aKOfFTV6VGP5BNUB1Vnarc/F0DL+26vq0829FAbZrqo=;
 b=NAWfs9FHtLojPbi/0NrjdXR+iWSJ9IxOaqRbQY1WWogu8aUTmKvkc8I4di076LN7J7
 wTb5OoFvzk9OzQPTYwvbKjvHDswZ1SdVEdcbUnRgXpXkl2dL95FcoZZRP14yRWqxLLwe
 FeSiPooqDj5VkUPahUPb4rZqap3XBe6tUt6KnoWUm/30uwUhGU2d11nmGo7oFMdWSpOH
 etH27jdrAMmLNwuqfwFC0U7UVyr2VThD6av1lbyTu15EdIv6t3/L39xnhyCx1EX9sbf2
 5zbav6sKkhvvESoxHf792PaamOI8PrnbdngaCl7fyB23WwoBUVd+0sBnOEgvB0UK4FLu
 8syQ==
X-Gm-Message-State: APjAAAVe6qiuHv8zGy/kP4NWGxtwV+7uKchMLgxm76+RPpKj9QnTXFa2
 tPXyopbK4XuWVGDeLt9fS/YJdatCNxVGBO0clEeQRg==
X-Google-Smtp-Source: APXvYqwgOw9EQ70Umy0oEnQ5G5LCL6qyMyWjnNbSVpHRs20m04I8HxLTnoiIjpuTiP19er8DvO/pyE/cwQSXqDyWk+Y=
X-Received: by 2002:a17:902:5983:: with SMTP id
 p3mr26758654pli.232.1565672634067; 
 Mon, 12 Aug 2019 22:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-5-brendanhiggins@google.com>
 <20190812234644.E054D20679@mail.kernel.org>
 <CAFd5g44huOiR9B0H1C2TtiPy63BDuwi_Qpb_exF3zmT3ttV8eg@mail.gmail.com>
 <CAFd5g44GxE-p+Jk_46GYA-WWVHLW7w=yE+K_tbbdiniDfrk-2w@mail.gmail.com>
 <20190813045747.3AF0A206C2@mail.kernel.org>
In-Reply-To: <20190813045747.3AF0A206C2@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 12 Aug 2019 22:03:42 -0700
Message-ID: <CAFd5g47OUymztYcWngDUd10WswVOrO-PTmX+KNF_T=cg_OcJNg@mail.gmail.com>
Subject: Re: [PATCH v12 04/18] kunit: test: add assertion printing library
To: Stephen Boyd <sboyd@kernel.org>
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
 shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Aug 12, 2019 at 9:57 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 21:27:05)
> > On Mon, Aug 12, 2019 at 4:56 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Mon, Aug 12, 2019 at 4:46 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Brendan Higgins (2019-08-12 11:24:07)
> > > > > +#define KUNIT_INIT_FAIL_ASSERT_STRUCT(test, type) {                           \
> > > > > +               .assert = KUNIT_INIT_ASSERT_STRUCT(test,                       \
> > > > > +                                                  type,                       \
> > > > > +                                                  kunit_fail_assert_format)   \
> > > >
> > > > This one got indented one too many times?
> > >
> > > Not unless I have been using the wrong formatting for multiline
> > > macros. You can see this commit applied here:
> > > https://kunit.googlesource.com/linux/+/870964da2990920030990dd1ffb647ef408e52df/include/kunit/assert.h#59
> > >
> > > I have test, type, and kunit_fail_assert_format all column aligned (it
> > > just doesn't render nicely in the patch format).
> >
> > Disregard that last comment. I just looked at the line immediately
> > above your comment and thought it looked correct. Sorry about that
> > (you were pointing out that the .assert line looked wrong, correct?).
>
> Yes. .assert is double tabbed?

Yes it is. Sorry about the confusion. Will fix.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
