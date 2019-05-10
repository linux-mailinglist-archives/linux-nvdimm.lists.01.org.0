Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9CA19BB5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 12:34:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1024B212657B7;
	Fri, 10 May 2019 03:34:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CDA35212657B0
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 03:34:04 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k9so4154495oig.9
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 03:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v5i4JvNF6NE98fRMKxmZ6W6+U1GIOfAXdGdvVU9jpjk=;
 b=nGd+cWkGzEXpGtZkuP9oYYd4GvoVDkXbYEKFNyvJGe431T1PPUpkS/xcdVyU93/oC+
 iOY/sgkoPSzzreHzKz9kgEHxhJHg1jJT8nh/GBB77UaWYZ2cmcii9Cf0IBR0PkuXrFU2
 X2zcaWr/4tLTgZ0RLrGMyhMI1p7cfpR2FessPvThJmqe71Qb5xQZDjgKunaL0C5W2w2E
 x4thQ7WxDuTbLul4U5kX4SSYFL36trckMOrHWRhsmbpzjo17LECFKM9VLEYLBlSkUN9W
 WbwCW0njc6inKI9wGkqJbW4iWV889QBYK+bjWkcnAcu6ZIOkfieUOoCuotJ9MJZnAWKM
 Rhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v5i4JvNF6NE98fRMKxmZ6W6+U1GIOfAXdGdvVU9jpjk=;
 b=Exw5i3RoRvaQz7GM5eF0wJ+3db4LZiikodNJi1wRS9OvkpOkxYNrzr3ieYPjZ6RAB2
 qoUuXgjCBJziB+ZDKxZ5MgFr0Lugp+NJkMuH4fcW/2Ak7y8k97/4Ex8tCQJGV3QGYD6+
 p/TfAwR2VaHTAMxVPNNEWdD6BVMOrb6ANbpjNLmsQU5JEe/Ojg3jNbZFZKAKp2twc2V6
 /RilQWyv4HU+f+Q+9OqeRNprpduHB+BoBmlGoUN0/s2CY0x7EJNVet/OHKhpb9AA/4SL
 nEsZw4SrM//Zr7z8nuwJHA4BuPz6JzVMTfMImRiYxEvcKOl9Q1EaMa/xJXji/odg+SNw
 gLJA==
X-Gm-Message-State: APjAAAUgo0XxkjQ5S5wGh/voKNhG65eJ+9865CCtcWrplIakNGmjjBi0
 1Y/HCcdNkYCZDnvLlZWDzrzq3kSjHY98jBoiIO2spg==
X-Google-Smtp-Source: APXvYqw3UEwomNcXxGCJaZ//T6xFRuS5gGaGa2izLjE212DrWEolETcTjMzpUq+WB1E+1p0WPdjF9j5Z9zciCUj1NAM=
X-Received: by 2002:aca:43d5:: with SMTP id q204mr4754067oia.100.1557484443394; 
 Fri, 10 May 2019 03:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-7-brendanhiggins@google.com>
 <CAK7LNAQ+SRMn8UFjW1dZv_TrL0qjD2v2S=rXgtUpiA-urr1DDA@mail.gmail.com>
 <CAFd5g47BNZ0gRz4SXb37XjyXF_LyNZrSmoqDbzaaCUrTg3O7Yg@mail.gmail.com>
 <CAK7LNAR3DW5UxtsTNtW6mtQic8cukJwJ18=KitC2HX+jO5eo4g@mail.gmail.com>
In-Reply-To: <CAK7LNAR3DW5UxtsTNtW6mtQic8cukJwJ18=KitC2HX+jO5eo4g@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 10 May 2019 03:33:52 -0700
Message-ID: <CAFd5g46dE78f3bx33Sv-CPNx9i8VV=v0Ezwytp8eiQU1MzWbbQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] kbuild: enable building KUnit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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
 Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "Cc: Shuah Khan" <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 DTML <devicetree@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Tim Bird <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

> On Fri, May 10, 2019 at 7:27 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > > On Thu, May 2, 2019 at 8:03 AM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > > >
> > > > Add KUnit to root Kconfig and Makefile allowing it to actually be built.
> > > >
> > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > >
> > > You need to make sure
> > > to not break git-bisect'abililty.
> > >
> > >
> > > With this commit, I see build error.
> > >
> > >   CC      kunit/test.o
> > > kunit/test.c:11:10: fatal error: os.h: No such file or directory
> > >  #include <os.h>
> > >           ^~~~~~
> > > compilation terminated.
> > > make[1]: *** [scripts/Makefile.build;279: kunit/test.o] Error 1
> > > make: *** [Makefile;1763: kunit/] Error 2
> >
> > Nice catch! That header shouldn't even be in there.
> >
> > Sorry about that. I will have it fixed in the next revision.
>
>
> BTW, I applied whole of this series
> to my kernel.org repository.
>
> 0day bot started to report issues.
> I hope several reports reached you,
> and they are useful to fix your code.

Yep, I have received several. They are very helpful.

I greatly appreciate it.

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
