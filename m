Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859F362CB2
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Jul 2019 01:35:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1E09C212ACEDD;
	Mon,  8 Jul 2019 16:35:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=yzaikin@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EF410212ACEC9
 for <linux-nvdimm@lists.01.org>; Mon,  8 Jul 2019 16:34:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 31so2136329wrm.1
 for <linux-nvdimm@lists.01.org>; Mon, 08 Jul 2019 16:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+0bgA4UqbyynY1WKuo34XLnfT2RL8oF6dGSsO++vmwI=;
 b=Vvu+7XyZ+bf18JzhxWs9WUla5B97kN6JNUGK09wQnbC1To+ikzJLjWemzYQ4bSdXem
 Lb4Ujrcwm/h5eSGI7UR+HmJu9labaWTTr2uGAMIQle4ZAoZT+/Rr04O/5fXMa+UDK/dI
 PiWmvqDOuBeRwnaNj0eFrE7zYpPFf5ZW5v1/snESkLUrZhzUeLNH4C7U1TAT94jY3ioz
 eEbjqFsIRgjTDidMp1LOdKzZIEzJRV4P4q40BE/P564YjPoiVk+St3f2/qGgJ0XbufeM
 E4LGboUMF+nD44IlGbVNDieKQG3KCLdUF/egpt+dZ1xlDy4X/3SK1jXeVQiIZHm6dFjh
 zhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+0bgA4UqbyynY1WKuo34XLnfT2RL8oF6dGSsO++vmwI=;
 b=oKI0cQqdSd3HCpE0e83cWmSx3Wf01x21pJgLB5bwj3jZA+00RPVagzykurv1CC5inp
 Jy026FfUOn939uyyqRVSHEJ+y8oS1Pqxrn6XZZt/G8H0iecBtSj0nR2UkBLhTz+71OVy
 EJ6YPYUqdfkmgommpdRRWITHJgQy6fC8lFNfa8243kG8EVmskT+k/MA6Oxndkpq22a+8
 YzqnQoRD+nZKuPRVVu+awyx50Ltg+3481+tsPjdH4txIxL4e8Z9opLG3Gj+YUU8hF1Wv
 P/nQs+ZissxBbEMI8hoeay8utWm/hrZhfBPpJr47tJVsI1RxxhKqaYP1feqPSGjWRZc/
 Jamg==
X-Gm-Message-State: APjAAAWfOWZ6ntFeINn+vWb5nBq/93R7a4ouu+gK1bmAJIt6JB88ZL4n
 Hm0MG8RpkVYW6uqVk7AufByyrbgZ03eaydLHRpY2
X-Google-Smtp-Source: APXvYqy2agX+h3NF02X+WujT1yk9yb+IABwJhy8IpnbR3/useLGvEwjfJj5ObeDsKZRewf4wva8AmF6fHX7xEyn/0ZQ=
X-Received: by 2002:a5d:4ec1:: with SMTP id s1mr19532947wrv.19.1562628896307; 
 Mon, 08 Jul 2019 16:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-19-brendanhiggins@google.com>
 <20190705204810.GE19023@42.do-not-panic.com>
 <CAFd5g44j7ECQorYLnDQadAaj+yBki98kFjmjejn+3W4eHtqGDA@mail.gmail.com>
 <CAAXuY3q1==RvAiw+gw5kfFJmjdR9JEUnnxou4Sv0POd88aD41w@mail.gmail.com>
In-Reply-To: <CAAXuY3q1==RvAiw+gw5kfFJmjdR9JEUnnxou4Sv0POd88aD41w@mail.gmail.com>
From: Iurii Zaikin <yzaikin@google.com>
Date: Mon, 8 Jul 2019 16:34:20 -0700
Message-ID: <CAAXuY3ov7s28BQ0VxzkfAHR6NZiBq-YfnJ_510VN22DMhEyCBg@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
To: Brendan Higgins <brendanhiggins@google.com>
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
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

> On Mon, Jul 8, 2019 at 4:16 PM Brendan Higgins <brendanhiggins@google.com> wrote:
>>
>> CC'ing Iurii Zaikin
>>
>> On Fri, Jul 5, 2019 at 1:48 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>> >
>> > On Wed, Jul 03, 2019 at 05:36:15PM -0700, Brendan Higgins wrote:
>> > > Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section.
>> > >
>> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>> > > Acked-by: Luis Chamberlain <mcgrof@kernel.org>
>> >
>> > Come to think of it, I'd welcome Iurii to be added as a maintainer,
>> > with the hope Iurii would be up to review only the kunit changes. Of
>> > course if Iurii would be up to also help review future proc changes,
>> > even better. 3 pair of eyeballs is better than 2 pairs.
>>
>> What do you think, Iurii?

I'm in.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
