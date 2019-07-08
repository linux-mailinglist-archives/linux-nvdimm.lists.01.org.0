Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ECD62CA7
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Jul 2019 01:30:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 734BB212ACEC9;
	Mon,  8 Jul 2019 16:30:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=yzaikin@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 116882194EB76
 for <linux-nvdimm@lists.01.org>; Mon,  8 Jul 2019 16:30:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x4so18909955wrt.6
 for <linux-nvdimm@lists.01.org>; Mon, 08 Jul 2019 16:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qzjDhcxeEToT3yZiM8Zy8MizazxKaWl9Nv1zA5ati/Q=;
 b=MO5bfPAlo2164tEXOEvoEn31sXFfbxysl8zxg0iDgMtpjB+0Man83rHGrqNJFHU/M4
 k1VmfMxXC0K0GeeM72z0/h9spzCqHd6JkY7mNOgPhYwT4Ko502WKF0znu9jU7i5WnqKn
 ASJUxYwvToF4PvX50xXpcvENyfCKZO/7Bc9zX7/vbUN+GtdRNRzDbnkKEh/Pc8zAscXE
 myH5ic2SM34lM7iHSzlnqQHRVNWjCXbBB3hAZOU2sqZZIGIXVcmAmdDMdw9fXi3IK3nG
 /IzgEZtID5c8nBaWttjeJKuLM+LyFmF2x00q4HCwqsoxT09uVeXtFdDZ5zrLcIHOq7ZW
 0gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qzjDhcxeEToT3yZiM8Zy8MizazxKaWl9Nv1zA5ati/Q=;
 b=tn91iHaP7x+opFhLVS+UTGqg+p/N0j1HxGrrRXnqNzqbqVqZch5L6pDpRAA87GA3Tj
 u2++lGdj44qxkJc7PRHHokBMpv6/ZuGqaszoDtRix7kyxRCcp2Xw4mb8JFUS+hPzImn9
 rAby45HkEvcXL+y0vzwOaGqjAqzw/lu7il8/34dvA16hNFsoDITVWxC6E+eBm2t7Hnho
 G+pRWe256zX5TLgayEfeu296/+HwyzKZyb4FhjzjSLasjxA+i6efslQXtNWYVuPMf4J2
 vkUx+BtADwloS6EoeH8NSlIcq0Vg3ObeijIIZnHLcgysFjWs+5mkSJ6Rel+bGCJFFVMU
 nGlw==
X-Gm-Message-State: APjAAAWYz+gOl5PL73sT1S4Q/wIRcjdHqD3nV/a5w5xVgCbw+KCLOxB1
 8b2RIWF/NvpMUdsWH/Wgp2mRrnV7ExvlrAVpRbhH
X-Google-Smtp-Source: APXvYqxGUTEBfLOYYBmqkW9Y3gx856YMuwvyw6A0hzZzCwCPtHxlkAMAZUHZelyyYH7vVuf2EXU3s+RYMrnOp0PzyQU=
X-Received: by 2002:a5d:518c:: with SMTP id k12mr10567419wrv.116.1562628608790; 
 Mon, 08 Jul 2019 16:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-19-brendanhiggins@google.com>
 <20190705204810.GE19023@42.do-not-panic.com>
 <CAFd5g44j7ECQorYLnDQadAaj+yBki98kFjmjejn+3W4eHtqGDA@mail.gmail.com>
In-Reply-To: <CAFd5g44j7ECQorYLnDQadAaj+yBki98kFjmjejn+3W4eHtqGDA@mail.gmail.com>
From: Iurii Zaikin <yzaikin@google.com>
Date: Mon, 8 Jul 2019 16:29:32 -0700
Message-ID: <CAAXuY3q1==RvAiw+gw5kfFJmjdR9JEUnnxou4Sv0POd88aD41w@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
To: Brendan Higgins <brendanhiggins@google.com>
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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

I'm in.

On Mon, Jul 8, 2019 at 4:16 PM Brendan Higgins <brendanhiggins@google.com>
wrote:

> CC'ing Iurii Zaikin
>
> On Fri, Jul 5, 2019 at 1:48 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Jul 03, 2019 at 05:36:15PM -0700, Brendan Higgins wrote:
> > > Add entry for the new proc sysctl KUnit test to the PROC SYSCTL
> section.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > > Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> >
> > Come to think of it, I'd welcome Iurii to be added as a maintainer,
> > with the hope Iurii would be up to review only the kunit changes. Of
> > course if Iurii would be up to also help review future proc changes,
> > even better. 3 pair of eyeballs is better than 2 pairs.
>
> What do you think, Iurii?
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
