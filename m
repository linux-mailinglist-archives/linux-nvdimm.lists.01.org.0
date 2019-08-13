Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 644F28B37B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 11:13:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 839DB21329993;
	Tue, 13 Aug 2019 02:15:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D28B521329977
 for <linux-nvdimm@lists.01.org>; Tue, 13 Aug 2019 02:15:23 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h28so76188770lfj.5
 for <linux-nvdimm@lists.01.org>; Tue, 13 Aug 2019 02:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b9ILhd2aCjQh4oMSFsJoowCjN4C8D/s8MJgq4YAEBLc=;
 b=W2oxF32qcEgwvRN+TzYXAddY5GIfE0TU07ZZEMjsnTdZHws8iAZ2t8Ultvl9YT7B9l
 FcqQcsJALGn/N6C5ZuExhftHA8ZS8MNOrSUeIrQu3gBXXLe4ixyR8Oo5hmg4UUGyabxo
 uWv09COtEGpqAdax3WCg5P2ubO3WE1ftRGYMB38Ed3fgj3xpruF/YDRjA5s4U1SsywTz
 raOTZO3u1j8iOcpslIka2xJ8bkvq+QSToLsxoCLDTz8ppRJhCuL8ltvK/wB/IXN51+OA
 Tmzcrff2zT5F1o2XfVqbtXnT9QaUbGOA7cZQ4WzLX6NEXNn++uTMldyauztGbKy/kIWW
 PdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b9ILhd2aCjQh4oMSFsJoowCjN4C8D/s8MJgq4YAEBLc=;
 b=k9PoGYWwxeRGe9mmhrkurSX84E46X6QYAOHUwDCPd4oIA6+RNEYaVGG//mAW04J+65
 l9cWwHnwDvarnXQmsqH5cz4euZWfKRaBOaiwDggTseLJgPYeZFZGp4k34z1e/HEk65WE
 /2UAIY66i+QS4bvYcfX8xOw4DkoCXtXW/sGdFrdQfAGpkC50sOl3voQkSLo4nFGXB1qQ
 QeVHzTOVSAs+umj8qQrVNpXa1lyIdTDbb/6I7I276Kw41m6rd8Qv2n2z0a6PVozM7hWc
 665uyLZ+MaN/gBcn9+rTEZp2USYR8N/flHGn6D+rt7T8JwFkSn1LQIHHZJYDYXLQHKR+
 NVIg==
X-Gm-Message-State: APjAAAW/rkQrkVRMmCKjdX5BiZ4utES6tkFRxQbnSaoqY9pAEG+9L7zc
 Z+nbzWxBpOvcq5XeNBYUBX4yNxtafEJap50+7MV6oA==
X-Google-Smtp-Source: APXvYqwLnkbduPeN9fnl3i+lRRTsMYZatTj1IuJmhpqxnMiio1q0JfaKumMLZmtQt11+bQEG/iQwBN5AGKfhGyCW+Rs=
X-Received: by 2002:ac2:5dd6:: with SMTP id x22mr21614482lfq.92.1565687586809; 
 Tue, 13 Aug 2019 02:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-4-brendanhiggins@google.com>
 <20190812225520.5A67C206A2@mail.kernel.org>
 <20190812233336.GA224410@google.com>
 <20190812235940.100842063F@mail.kernel.org>
 <CAFd5g44xciLPBhH_J3zUcY3TedWTijdnWgF055qffF+dAguhPQ@mail.gmail.com>
 <20190813045623.F3D9520842@mail.kernel.org>
 <CAFd5g46PJNTOUAA4GOOrW==74Zy7u1sRESTanL_BXBn6QykscA@mail.gmail.com>
 <20190813053023.CC86120651@mail.kernel.org>
 <CAFd5g47v7410QRAizPV8zaHrKrc95-Sk-GNzRRVngN741OKnvg@mail.gmail.com>
In-Reply-To: <CAFd5g47v7410QRAizPV8zaHrKrc95-Sk-GNzRRVngN741OKnvg@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 13 Aug 2019 02:12:54 -0700
Message-ID: <CAFd5g452+-6m1eiVK0ccTDkJ2wH8GBwxRDw5owwC8h3NscE1ag@mail.gmail.com>
Subject: Re: [PATCH v12 03/18] kunit: test: add string_stream a std::stream
 like string builder
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

On Tue, Aug 13, 2019 at 2:04 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Mon, Aug 12, 2019 at 10:30 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-08-12 22:02:59)
> > > On Mon, Aug 12, 2019 at 9:56 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Brendan Higgins (2019-08-12 17:41:05)
> > > > > On Mon, Aug 12, 2019 at 4:59 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > > >
> > > > > > > kunit_resource_destroy (respective equivalents to devm_kfree, and
> > > > > > > devres_destroy) and use kunit_kfree here?
> > > > > > >
> > > > > >
> > > > > > Yes, or drop the API entirely? Does anything need this functionality?
> > > > >
> > > > > Drop the kunit_resource API? I would strongly prefer not to.
> > > >
> > > > No. I mean this API, string_stream_clear(). Does anything use it?
> > >
> > > Oh, right. No.
> > >
> > > However, now that I added the kunit_resource_destroy, I thought it
> > > might be good to free the string_stream after I use it in each call to
> > > kunit_assert->format(...) in which case I will be using this logic.
> > >
> > > So I think the right thing to do is to expose string_stream_destroy so
> > > kunit_do_assert can clean up when it's done, and then demote
> > > string_stream_clear to static. Sound good?
> >
> > Ok, sure. I don't really see how clearing it explicitly when the
> > assertion prints vs. never allocating it to begin with is really any
> > different. Maybe I've missed something though.
>
> It's for the case that we *do* print something out. Once we are doing
> printing, we don't want the fragments anymore.

Oops, sorry fat fingered: s/doing/done
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
