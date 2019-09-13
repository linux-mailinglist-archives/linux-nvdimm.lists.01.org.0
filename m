Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C43C8B2163
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 15:55:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 219DC202EA3E0;
	Fri, 13 Sep 2019 06:55:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Permerror (SPF Permanent Error: Void lookup limit of 2 exceeded)
 identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=mchehab@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E682E202E8427
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bNVVCafqJkMcKoP1y59HFv8nRZ31wfx1kpQ64ijtqic=; b=iK98qwUe7lOp1d7EKY7SRunR0
 JlOgLWm5Fu6g9XFQG1KRkDv+Y0UkI6LgXnV+4TLv+uqQqp6SjUZHhy342WFPU8ErtM2c2hWxh3j2U
 lJkoc/JImKg7rfJvB54cPZVHIS2vg1E8CjdL09vS+vcN/EPqDA6k44scEudr4qd+vzgrMsH6GPHqW
 3+p4AYZdLaRyJ4ygVLqG/8QJ4f7VmWIqojyGf+5liR/oIEh4qx3+FOVFg0iAMnHsPuk7vCxcztdgV
 JbKDP0E9YgdjmUVjZ9hIkTbva1WtTMDiWSiwibb4ud+JDJhkstCYHyPLTWw25+wp37jEmVhG08IJ6
 PAZ5vnqfQ==;
Received: from 177.96.232.144.dynamic.adsl.gvt.net.br ([177.96.232.144]
 helo=coco.lan)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8m2I-0003uH-Lp; Fri, 13 Sep 2019 13:54:55 +0000
Date: Fri, 13 Sep 2019 10:54:46 -0300
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Matthew Wilcox <willy6545@gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
Message-ID: <20190913105446.2b7af558@coco.lan>
In-Reply-To: <CAFhKne8Nbk=OnZO_pqPURneVtxcHqbfkH+xJBrAYfCfsntfQ2g@mail.gmail.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <yq1o8zqeqhb.fsf@oracle.com>
 <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
 <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
 <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org>
 <CAFhKne8Nbk=OnZO_pqPURneVtxcHqbfkH+xJBrAYfCfsntfQ2g@mail.gmail.com>
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
 ksummit-discuss@lists.linuxfoundation.org, linux-nvdimm@lists.01.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Dmitry Vyukov <dvyukov@google.com>, Joe Perches <joe@perches.com>,
 Steve French <stfrench@microsoft.com>, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Em Fri, 13 Sep 2019 08:56:30 -0400
Matthew Wilcox <willy6545@gmail.com> escreveu:

> It's easy enough to move the kernel-doc warnings out from under W=1. I only
> out them there to avoid overwhelming us with new warnings. If they're
> mostly fixed now, let's make checking them the default.

Didn't try doing it kernelwide, but for media we do use W=1 by default,
on our CI instance.

There's a few warnings at EDAC, but they all seem easy enough to be
fixed.

So, from my side, I'm all to make W=1 default.

Regards,
Mauro

> 
> On Thu., Sep. 12, 2019, 16:01 Bart Van Assche, <bvanassche@acm.org> wrote:
> 
> > On 9/12/19 8:34 AM, Joe Perches wrote:  
> > > On Thu, 2019-09-12 at 14:31 +0100, Bart Van Assche wrote:  
> > >> On 9/11/19 5:40 PM, Martin K. Petersen wrote:  
> > >>> * The patch must compile without warnings (make C=1  
> > CF="-D__CHECK_ENDIAN__")  
> > >>>   and does not incur any zeroday test robot complaints.  
> > >>
> > >> How about adding W=1 to that make command?  
> > >
> > > That's rather too compiler version dependent and new
> > > warnings frequently get introduced by new compiler versions.  
> >
> > I've never observed this myself. If a new compiler warning is added to
> > gcc and if it produces warnings that are not useful for kernel code
> > usually Linus or someone else is quick to suppress that warning.
> >
> > Another argument in favor of W=1 is that the formatting of kernel-doc
> > headers is checked only if W=1 is passed to make.
> >
> > Bart.
> >
> > _______________________________________________
> > Ksummit-discuss mailing list
> > Ksummit-discuss@lists.linuxfoundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
> >  



Thanks,
Mauro
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
