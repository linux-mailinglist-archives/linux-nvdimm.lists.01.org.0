Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1962D125A2
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 02:41:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B6B8D21244A02;
	Thu,  2 May 2019 17:41:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C8685212449F9
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 17:41:21 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t189so3144558oih.12
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 17:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i/LGIUMFfkHhxCSDT3fm51UOA28cPrGRFTawiLz9qdU=;
 b=FJIAYLW9LNf9oanARKl7TfF4hN+5D95QZaw548QJynu0CjT8BCwlpKeraO6t9YYkOs
 GtNX3/gAG5EXPOJwbqEw8XIrwSSwlKCrob0M1UGIcbcgu72bFgtpR14EttoAsQY2aDgu
 R3g2UNQXhcb3FGDMQxi+sYsTRkYHs3qzvEqqHMGSEtbYKM2QA4nxdIkJahuLnsBoO2+c
 TGr8njZSgd2pD66c4pynpYDwYtRx3F05qDNXkbRYRi3lANeuXFpYdvOTMjhMHRrrhF8P
 3i1MCfzjUMz11YJpZRIR9WsEPFVnmwGmtj8MUe4JYxQcAMMsvhz5BhNLX+0hNU5ukE4d
 83hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i/LGIUMFfkHhxCSDT3fm51UOA28cPrGRFTawiLz9qdU=;
 b=pgqIP5GbSWhFYTnbhasd1Q95T9OHqyx7htf75KyZCsWO4unQDUnNAzP/itHp1x2LxL
 o4HkgUyP1pgEhJesxP5kB9a9soCrgMSKkua6lJ0YQoa9MWv8oLs4mH49H/k5Eivc8JVA
 ++uyxRBRe+dn5ZX57zuw9N2InelvzPHFFQHkDm+naDgo4UPQcTNKxent+ZFiXqC4nV68
 jeXv82tp9/yL/F/J89w105T/XbOvMXeUi5UtPYoRxaQoquNRqqM5G9sHAia2uZdsUKqK
 sHV3ssbVeAfTFaXnBt4h578nQaz1f55+N0lgptNIED+EXQbF/5BiSqCbsNBlR6/XwHnQ
 RdPA==
X-Gm-Message-State: APjAAAWTs+ZcuhiJ2JFUDFcNr/0238hXNDgCTteRCzRdIdjFkopyxNsd
 xg7IeTHf5UntLN+ljvpO/oqZ3PGn0xwFzr8s8BSJ7Q==
X-Google-Smtp-Source: APXvYqx+IeNo/M2uU5es7ZAJsOSGR6b01vZ0dEQaWTEj9cNFRVwEHLuSMfXDE/OIHXARFXXWqbF1LQIlh8BGLZyE6Eo=
X-Received: by 2002:aca:4586:: with SMTP id s128mr4126147oia.148.1556844080319; 
 Thu, 02 May 2019 17:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190502105053.GA12416@kroah.com> <20190502110513.GF12416@kroah.com>
In-Reply-To: <20190502110513.GF12416@kroah.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 2 May 2019 17:41:08 -0700
Message-ID: <CAFd5g46RyQ+jaV3bDejBaeca4Yv3G9ppT5JxdKqZw6PSbiSDYw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Greg KH <gregkh@linuxfoundation.org>
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
 Stephen Boyd <sboyd@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 2, 2019 at 4:05 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, May 02, 2019 at 12:50:53PM +0200, Greg KH wrote:
> > On Wed, May 01, 2019 at 04:01:09PM -0700, Brendan Higgins wrote:
> > > ## TLDR
> > >
> > > I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
> > > 5.2.
> >
> > That might be rushing it, normally trees are already closed now for
> > 5.2-rc1 if 5.1-final comes out this Sunday.
> >
> > > Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
> > > we would merge through your tree when the time came? Am I remembering
> > > correctly?
> >
> > No objection from me.
> >
> > Let me go review the latest round of patches now.
>
> Overall, looks good to me, and provides a framework we can build on.
> I'm a bit annoyed at the reliance on uml at the moment, but we can work
> on that in the future :)

Eh, I mostly fixed that.

I removed the KUnit framework's reliance on UML i.e. the actual tests
now run on any architecture.

The only UML dependent bit is the KUnit wrapper scripts, which could
be made to work to support other architectures pretty trivially. The
only limitation here is that it would be dependent on the actual
workflow you are using.

In anycase, if you are comfortable reading the results in the kernel
logs, then there is no dependence on UML. (I should probably provide
some documentation on that...)

>
> Thanks for sticking with this, now the real work begins...

I don't doubt it.

>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Does this cover all the patches in this set?

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
