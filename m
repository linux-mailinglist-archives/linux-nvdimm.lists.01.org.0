Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2915354B4
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Jun 2019 02:19:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 28FCB2128D6BB;
	Tue,  4 Jun 2019 17:19:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::242; helo=mail-lj1-x242.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AFAA4211F99AB
 for <linux-nvdimm@lists.01.org>; Tue,  4 Jun 2019 17:19:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a21so6256193ljh.7
 for <linux-nvdimm@lists.01.org>; Tue, 04 Jun 2019 17:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wdmJ9l6dKN/M8KJKaReWlFRx3EElIyLoR59kmGQ0ajY=;
 b=mWp51IFY9ldz1n3pj1fKrjbn8ZSGPWgwyelkcW6/s7v+y0e0DR/V8GR1ZxM1BsBeAX
 mqVaa/tfXDd/6MEO1OGM22zX0t4jPSi2d71oCngZuhbWkZxio6+sFzeQvWqDrIYIpJuw
 nH2s7y3MrUSzM3dAVIORTn4j8f2hTE4FKXFXiB6vbyOyWM+8sm7qnuJAdZe0dYu2FmQB
 G/4Hd50+HcTF52V70z6ii5Z+BoWQp+0M49tLLSAs+EJ/ROKxeK9GHDSjTGCoNxZTB406
 eMV8PQsiA3EH2MFRRpS50GYwQWxdJ7xN9x1Gd1qekPsZCFSmXsLb0mvz92xMWF6zHTLn
 it2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wdmJ9l6dKN/M8KJKaReWlFRx3EElIyLoR59kmGQ0ajY=;
 b=bgvjdhIDf0CBlZ+/MJu3+kdTn2tmjCaj+ujmLqXLiptTaWa5NHzTQ9BdVJCmnztUtT
 rWhAUuMZ1oCiQckjrxPHZZpmKleOytfhycDsVEb6GbRFMopSOI1xMOPEzaRaGYmIO/Ej
 HjFl2VMiOgIrgLKW938M58VBE7dzjEvDhQexPcawRjsk9tHjz2uZs/Bt32Q2DvWf4Ik3
 u4T+RAVSMgXjFFdvac9OCmRvyuVzWlYW2oDj6HjRzIiWfP8y5x7YaddSRx6YQX3MqT2J
 sJMAn00zENpQSiiKFn6uuA2musEfEm/XC35NGdJkP+hmfteamHt+X5AoPCc7yk+ZvKL1
 t22w==
X-Gm-Message-State: APjAAAUwERlGVydfSfqq5affrBwp5MHkxgkqTsYX0+6qYkiQ+zz1sNRe
 crX1CZQCmHsZJ7Nm856MlmsBA8NwlpquB6Yf6O8VWg==
X-Google-Smtp-Source: APXvYqz12ZqA7QhRnSs7NCGRounbiJim0N2d6mvCnGBaDXvxAiRpIwE1RpZWUzCT4YdYhAmjp6wliW9IQj3YJNSuaRI=
X-Received: by 2002:a2e:9e8e:: with SMTP id f14mr3500ljk.120.1559693980056;
 Tue, 04 Jun 2019 17:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-4-brendanhiggins@google.com>
 <20190517174300.7949F20848@mail.kernel.org>
In-Reply-To: <20190517174300.7949F20848@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 4 Jun 2019 17:19:28 -0700
Message-ID: <CAFd5g45WrARi7eXsVKyq2eJH5j+wSrCCaHHSHrMptG7+MnNiTg@mail.gmail.com>
Subject: Re: [PATCH v4 03/18] kunit: test: add string_stream a std::stream
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

On Fri, May 17, 2019 at 10:43 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-05-14 15:16:56)
> > A number of test features need to do pretty complicated string printing
> > where it may not be possible to rely on a single preallocated string
> > with parameters.
> >
> > So provide a library for constructing the string as you go similar to
> > C++'s std::string.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>
> Is there any reason why we can't use the seqfile API for this? These
> both share a similar goal, formatting strings into a buffer to be read
> later. Maybe some new APIs would be needed to extract the buffer
> differently, but I hope we could share the code.

I can see why you are asking. It seems as though they are trying to do
*similar* things, and it seems possible that we might be able to
extract some common functionality out of seq_file that could replace
this; however, it looks like it would be require a significant
refactoring of seq_file to separate out the file system specific bits
from the more general stringbuilder functionality.

In my opinion, a refactoring like this makes no sense in this
patchset; it probably belongs in its own patchset (preferably as a
follow on). I also am not sure if the FS people would appreciate
indirection that serves them no benefit, but I can ask if you like.

> If it can't be used, can you please add the reasoning to the commit text
> here?

Will do.

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
