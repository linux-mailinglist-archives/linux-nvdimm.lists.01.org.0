Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F295B25F5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 21:17:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2D904202EA40A;
	Fri, 13 Sep 2019 12:17:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Permerror (SPF Permanent Error: Void lookup limit of 2 exceeded)
 identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=mchehab@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9E3E8202E8428
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 12:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rlRJRtbWGqF5qJn2FgghKNYZdCECrxLGGuNAvdpBnhE=; b=soQppz2sjZ542l4x8+d2PrSGd
 JUy0I/+m3xaGNL+3TaQdmws2k+87EdwqozCJbNQoNkOdYssAzSQft6aYDAKIOS6S+ZIbjO0ujXi4U
 Z8tWDGTXggK7USMOULInO7NZgGXRQvg83VfEBJiD3nE28UFgdO0JDMb8qcdJwfHetcRB/NBAgJObA
 Ie+2H2YULowfnE+GM/bw+v48uAfTloz7RO4/9G94UX2N4vuUNNy9xZUD796Bo6JJbJ6iWYK5QILFF
 7WuNSj1MHoyTRMQ1c3suXpO0RgUhE+F2F6et9sk6WaTHgecOGqrygNc2HRphWdHBmlKmHZcau7Qu5
 slqT0cpBg==;
Received: from 177.96.232.144.dynamic.adsl.gvt.net.br ([177.96.232.144]
 helo=coco.lan)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8r4b-0000J3-2S; Fri, 13 Sep 2019 19:17:37 +0000
Date: Fri, 13 Sep 2019 16:17:31 -0300
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
Message-ID: <20190913161731.6e3405a3@coco.lan>
In-Reply-To: <78f67ee934f167b433517da81c6a0d3f35c4b123.camel@perches.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <yq1o8zqeqhb.fsf@oracle.com>
 <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
 <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
 <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org>
 <4299c79e33f22e237e42515ea436f187d8beb32e.camel@perches.com>
 <CAL_JsqJju36BZPK6DJab28Ne-ORpEyPpxH0H4DuymxFMabpMRQ@mail.gmail.com>
 <78f67ee934f167b433517da81c6a0d3f35c4b123.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
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
Cc: Bart Van Assche <bvanassche@acm.org>,
 ksummit <ksummit-discuss@lists.linuxfoundation.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robherring2@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Steve French <stfrench@microsoft.com>, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Em Fri, 13 Sep 2019 11:42:38 -0700
Joe Perches <joe@perches.com> escreveu:

> On Fri, 2019-09-13 at 15:26 +0100, Rob Herring wrote:
> > On Fri, Sep 13, 2019 at 3:12 PM Joe Perches <joe@perches.com> wrote:  
> > > On Thu, 2019-09-12 at 13:01 -0700, Bart Van Assche wrote:
> > >   
> > > > Another argument in favor of W=1 is that the formatting of kernel-doc
> > > > headers is checked only if W=1 is passed to make.  
> > > 
> > > Actually, but for the fact there are far too many
> > > to generally enable that warning right now,
> > > (an x86-64 defconfig has more than 1000)
> > > that sounds pretty reasonable to me.  
> 
> > It's in the 1000s on arm because W=1 turns on more checks in building
> > .dts files. There are lots of duplicates as most of the dts content is
> > as an include file (e.g. board dts includes soc dts).  
> 
> Yeah, dts[i] files in arm compilations are very noisy at W=1
> so moving those message types to W=2 seems sensible.
> 
> $ { opt="ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnueabi-" ; make $opt clean ; make $opt defconfig ; make $opt W=1 -j4 ; } > arm_make.log 2>&1
> 
> $ grep -i -P 'dtsi?:.*warning' arm_make.log | wc -l
> 69164

Yeah, makes sense moving them to W=2, or to make them somehow produce
less noise.

> Just fyi:  for an x86-64 defconfig with gcc 8.3
> 
> $ { make clean ; make defconfig ; make -j4 W=1 ; } > make.log 2>&1
> 
> There are ~300 W=1 for non kernel-doc -W<foo> warnings.
> 
> $ grep -i -P -oh '\[\-W[\w\-]+\]' make.log |sort | uniq -c | sort -rn
>     163 [-Wmissing-prototypes]
>      69 [-Wunused-but-set-variable]
>      16 [-Wempty-body]
>      10 [-Wtype-limits]
>       6 [-Woverride-init]
>       2 [-Wstringop-truncation]
>       2 [-Wcast-function-type]
>       1 [-Wunused-but-set-parameter]

On my eyes, it doesn't sound too much. I suspect that, 
with gcc-9, it should produce more warnings, though.

Perhaps we could "promote" most of those to W=0.

> 
> And there are ~1000 kernel-doc only messages in various files

A significant amount of those warnings appear with "make htmldocs".

Not having the kernel-doc warning as part of W=0 helps to make
very hard to have them cleared.

IMHO, those should be enabled by default with W=0, at least for the
files that are included on some kernel-doc tag.

I mean, perhaps, when W=0, Kernel build could run:

	$ ./scripts/kernel-doc -none $(git grep kernel-doc:: Documentation/|cut -d: -f4-|sort|uniq|grep -vE "\bsource\b")

That produces 165 warnings (against v5.3-rc4 + media -next patches).

Thanks,
Mauro
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
