Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD41919B9B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 12:27:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 17135212657B3;
	Fri, 10 May 2019 03:27:47 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 63F44212657AB
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 03:27:45 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id m204so4190798oib.0
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0uHZ1jppAcFBhTR/1pJQr4fDRVmFHkByLDGRo+AFRuU=;
 b=dsrwv0H2Rfrc01YiHmjTjaNBThgH0Ls0D+S54kv0UogNbIoQQubjPK8qT7L0mF33CS
 aYviEu/LNE9drmcPOAdswXb57a7sipQirjIlQ7Ynd6iOEeUmTl+PCZ+GBOOHxMXwo9/H
 j4gtOzrnEtCf/6EINxveE8MFRW5uJt9rldnOcDpx4xbhTJdLV7YP/WUGh+m3XZLAcGc9
 VEH6sMdw5imAeTPV6OEInKN7s7agTjKI9bFZXH+y+qga4ATyjX3DaKij5ONVkcQdV95p
 PteDCGEucmeJdXRwmJxetOEP+cggWxt3r6pDiaF7DdvsmqnhTbIkbLBpggd06dK5/E3N
 9y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0uHZ1jppAcFBhTR/1pJQr4fDRVmFHkByLDGRo+AFRuU=;
 b=PfF3Hg8MO0/I5VMzytlDdIytcvdLaqEyN4eDSCiLF0HL+DckUsCWXeGURnNZt5IBo5
 WiBpu83MXbHcUtIXPXreVxGcxaFGF5ZMRguWbW6YbcNZwBOOTNTSuU6I1nKG9n8m5aRe
 Xm+gE4MD/evgXu1/mzQWcbjKHn8ehqVzpbnV+m0JTnydNktaX4GYHq+G9wLJ8Lq+ErcD
 nJyhWQTFKd/sBdpWMhfspaqWEvfXmR/5mL1gJL9gDCWBJbVQUlJNMuNmGR048VRT/6Nu
 I74z2fwCU/ZlU9m6glmuSUhQjRTzBBUXWcdkiApFdV7jbMI9b3XfeRGSWDvUXBtlh8AR
 F6Vw==
X-Gm-Message-State: APjAAAU1PsYy/CsT5eDWnmoYZ9iHXdVZbEmJ4tHn5ygALaqQuwjG1tPq
 NSEEfkJzDqNp4xoT4t6/CQfpGhYv9uk09zeHvCHRrA==
X-Google-Smtp-Source: APXvYqzItdyzdcRLdkdQjbdb1r5m6MPSdjbNOyMVXP3tR2XNB/TjHeBcC5zqpfKlvhj2ObI953CDQuJHYFWf+OOgkMY=
X-Received: by 2002:aca:43d5:: with SMTP id q204mr4737682oia.100.1557484064075; 
 Fri, 10 May 2019 03:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-7-brendanhiggins@google.com>
 <CAK7LNAQ+SRMn8UFjW1dZv_TrL0qjD2v2S=rXgtUpiA-urr1DDA@mail.gmail.com>
In-Reply-To: <CAK7LNAQ+SRMn8UFjW1dZv_TrL0qjD2v2S=rXgtUpiA-urr1DDA@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 10 May 2019 03:27:33 -0700
Message-ID: <CAFd5g47BNZ0gRz4SXb37XjyXF_LyNZrSmoqDbzaaCUrTg3O7Yg@mail.gmail.com>
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

> On Thu, May 2, 2019 at 8:03 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Add KUnit to root Kconfig and Makefile allowing it to actually be built.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>
> You need to make sure
> to not break git-bisect'abililty.
>
>
> With this commit, I see build error.
>
>   CC      kunit/test.o
> kunit/test.c:11:10: fatal error: os.h: No such file or directory
>  #include <os.h>
>           ^~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.build;279: kunit/test.o] Error 1
> make: *** [Makefile;1763: kunit/] Error 2

Nice catch! That header shouldn't even be in there.

Sorry about that. I will have it fixed in the next revision.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
