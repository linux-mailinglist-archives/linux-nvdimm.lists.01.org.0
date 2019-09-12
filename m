Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE82B1633
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 00:15:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 497C0202E6E09;
	Thu, 12 Sep 2019 15:15:11 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.161;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0161.hostedemail.com
 [216.40.44.161])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 33581202B75E6
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 15:15:09 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 58571181D3368;
 Thu, 12 Sep 2019 22:15:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::::,
 RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2110:2393:2525:2553:2559:2563:2682:2685:2687:2693:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4043:4321:4362:4470:5007:6117:6119:6691:7688:7903:8603:8957:9010:9025:10004:10400:10848:11026:11232:11658:11914:12043:12050:12297:12438:12555:12663:12679:12740:12760:12895:12986:13161:13229:13439:14096:14097:14181:14659:14721:21080:21365:21433:21451:21627:21939:30029:30054:30090:30091,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:30,
 LUA_SUMMARY:none
X-HE-Tag: pin05_49dff1f532f1d
X-Filterd-Recvd-Size: 3395
Received: from XPS-9350.home (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf08.hostedemail.com (Postfix) with ESMTPA;
 Thu, 12 Sep 2019 22:15:07 +0000 (UTC)
Message-ID: <2e3b15aea8645f38cea9442a4b6eb95f5b33eec6.camel@perches.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
From: Joe Perches <joe@perches.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Nick Desaulniers
 <ndesaulniers@google.com>
Date: Thu, 12 Sep 2019 15:15:06 -0700
In-Reply-To: <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com>
References: <cover.1568256705.git.joe@perches.com>
 <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
 <CANiq72kTsf=0rEufDMo7BzMNv1dqc5=ws7fSd=H_e=cpHR24Kg@mail.gmail.com>
 <4df0a07ec8f1391acfa987ecef184a50e7831000.camel@perches.com>
 <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com>
User-Agent: Evolution 3.32.1-2 
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, 2019-09-12 at 23:58 +0200, Miguel Ojeda wrote:
> On Thu, Sep 12, 2019 at 11:08 PM Joe Perches <joe@perches.com> wrote:
> > Please name the major projects and then point to their
> > .clang-format equivalents.
> > 
> > Also note the size/scope/complexity of the major projects.
> 
> Mozilla, WebKit, LLVM and Microsoft. They have their style distributed
> with the official clang-format, not sure if they enforce it.
> 
> Same for Chromium/Chrome, but it looks like they indeed enforce it:

thanks for that list.

> > I used the latest one, and quite a bit of the conversion
> > was unpleasant to read.
> 
> It would be good to see particularly bad snippets to see if we can do
> something about them (and, if needed, try to improve clang-format to
> support whatever we need).

As I mentioned earlier, look at the __stringify conversion.
Also the C() blocks.

btw: emacs 'mark-whole-buffer indent-region',
the tool I used for each file in patch 1, also
made a mess of the C() block.

> Did you tweak the parameters with the new ones?

No.  I used

$ clang-format --version
clang-format version 10.0.0 (git://github.com/llvm/llvm-project.git 305b961f64b75e73110e309341535f6d5a48ed72)

and the existing .clang_format from
next-20190904 35394d031b710e832849fca60d0f53b513f0c390

> I am preparing an RFC
> patch for an updated .clang-format configuration that improves quite a
> bit the results w.r.t. to the current one (and allows for some leeway
> on the developer's side, which helps prevent some cases too).

Well, one day no doubt an automated tool will be
more useful for the kernel.  Hope you keep at it
and good luck.

> > Marking sections _no_auto_format_ isn't really a
> > good solution is it?
> 
> I am thinking about special tables that are hand-crafted or very
> complex macros. For those, yes, I think it is a fine solution. That is
> why clang-format has that feature to begin with, and you can see an
> example in Mozilla's style guide which points here:
> 
>   https://github.com/mozilla/gecko-dev/blob/master/xpcom/io/nsEscape.cpp#L22
> 
> Cheers,
> Miguel

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
