Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35129125B2
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 02:44:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4067D21244A05;
	Thu,  2 May 2019 17:44:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E3954212449F7
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 17:44:17 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id y64so3230447oia.7
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 17:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A2hincFuCgvv5JHuCTV0zjcSgRetC4sQsA2RxJqwbHE=;
 b=OmqtnHqhiWeR9Oui8paJzv152rY6QABSkuQBz4HTi+7RcYfpqAMASWqQsmYpDFgDN6
 8u4QGxIX+281+PUfSj8hi/U7tm8NJ9VAxVw6f/1fIubO5IRk2JSVgWheDKh9YqA4Wsbf
 24sX8hJEdjs5npjlV/LbLiqkJxkPc5vfXFxPFLtHmaYVvwOT1Kl25XRCnzlFSWh2Q25H
 cUcrTa1e6pmnoMfZEaTHDQhpE68nGq58M6J2ln/kAXPBqhupBP9xcAgry1zyiFWDMuo5
 NRZs5NySNRdFsKgdLNe5bdoZ8f/LlUzn/ZIEd8r9DQV7aKNkXapSSaI0cJxyrsljswdm
 UMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A2hincFuCgvv5JHuCTV0zjcSgRetC4sQsA2RxJqwbHE=;
 b=pDhH28sn+AcEg8yZ4gR7kfRc2C8KQJd6T60N9SB+wkdbAUcplOamg8bpC3m4fqc1Jz
 J09mctQnhVxOZu5O3QmL0j1Ak5a3Phnhvp9zXVsRMCPOA7Om9zmiS4tnn9xgnsOmrbYT
 e9rJ4EcDq/1il1Nk/LnU6i//5w8O2dklsO9zUBJ1LNMOL8vMFdWavN5a8Jms3oRCWnFK
 fDeu+PFv8VHgcdtufqbtuTEHK52kIIazjEAqTKDza5dIcUvb1JRcf4hXECWoPkmIoIbw
 9YHdZNwkwcB992sD6x07DPL2/5ob8u/fQb4/pRE/6jT2bzsrho7w7X7GC/WTFOxbR5V0
 3KiQ==
X-Gm-Message-State: APjAAAXg62RSo2NJBg8Exuw8LPCRSX23pBE7R7jBtarXT0GH7kTuYGBW
 ZcVSe5ScKMRwEr3x1F+HDcKw4E0lh/7E0iImujzkqA==
X-Google-Smtp-Source: APXvYqyH7XhI3a/DkRyh575w1BCN/DsRH5SQN4U4GjnrWhviWpfRz21kNlgkWO7kwhjd2fwRpqP4aZoATeVVAm4A6kc=
X-Received: by 2002:aca:4586:: with SMTP id s128mr4131634oia.148.1556844256812; 
 Thu, 02 May 2019 17:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190502105053.GA12416@kroah.com>
 <76e84d54-6b7e-8cc1-492b-43822fc43ac4@kernel.org>
In-Reply-To: <76e84d54-6b7e-8cc1-492b-43822fc43ac4@kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 2 May 2019 17:44:05 -0700
Message-ID: <CAFd5g47JiSXHvMEu9NovkGdG7ugMCwVO0pGwT7bC=NCghD0w-g@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
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
Cc: Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org,
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>,
 Knut Omang <knut.omang@oracle.com>,
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
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 2, 2019 at 7:04 AM shuah <shuah@kernel.org> wrote:
>
> On 5/2/19 4:50 AM, Greg KH wrote:
> > On Wed, May 01, 2019 at 04:01:09PM -0700, Brendan Higgins wrote:
> >> ## TLDR
> >>
> >> I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
> >> 5.2.
> >
> > That might be rushing it, normally trees are already closed now for
> > 5.2-rc1 if 5.1-final comes out this Sunday.
> >
> >> Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
> >> we would merge through your tree when the time came? Am I remembering
> >> correctly?
> >
> > No objection from me.
> >
>
> Yes. I can take these through kselftest tree when the time comes.

Awesome.

> Agree with Greg that 5.2 might be rushing it. 5.3 would be a good
> target.

Whoops. I guess I should have sent this out a bit earlier. Oh well, as
long as we are on our way!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
