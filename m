Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77090B26B1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 22:33:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8F82B202EA412;
	Fri, 13 Sep 2019 13:33:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.190;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0190.hostedemail.com
 [216.40.44.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A82C6202EA3ED
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 13:33:11 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id F12BD18224D86;
 Fri, 13 Sep 2019 20:33:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com,
 :::::::::::::::::::::::::::,
 RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3872:3874:4321:4419:4605:5007:6119:6742:7903:10004:10400:10562:10848:10946:10967:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:30054:30090:30091,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:25,
 LUA_SUMMARY:none
X-HE-Tag: tub87_73cd010985e19
X-Filterd-Recvd-Size: 3342
Received: from XPS-9350.home (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf10.hostedemail.com (Postfix) with ESMTPA;
 Fri, 13 Sep 2019 20:33:15 +0000 (UTC)
Message-ID: <8be2df9936fb405ffaee75d6e24bbac0e938a653.camel@perches.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
From: Joe Perches <joe@perches.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Date: Fri, 13 Sep 2019 13:33:14 -0700
In-Reply-To: <20190913161731.6e3405a3@coco.lan>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <yq1o8zqeqhb.fsf@oracle.com> <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
 <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
 <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org>
 <4299c79e33f22e237e42515ea436f187d8beb32e.camel@perches.com>
 <CAL_JsqJju36BZPK6DJab28Ne-ORpEyPpxH0H4DuymxFMabpMRQ@mail.gmail.com>
 <78f67ee934f167b433517da81c6a0d3f35c4b123.camel@perches.com>
 <20190913161731.6e3405a3@coco.lan>
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

On Fri, 2019-09-13 at 16:17 -0300, Mauro Carvalho Chehab wrote:
> Em Fri, 13 Sep 2019 11:42:38 -0700
> Joe Perches <joe@perches.com> escreveu:
[]
> > Just fyi:  for an x86-64 defconfig with gcc 8.3
> > 
> > $ { make clean ; make defconfig ; make -j4 W=1 ; } > make.log 2>&1
> > 
> > There are ~300 W=1 for non kernel-doc -W<foo> warnings.
> > 
> > $ grep -i -P -oh '\[\-W[\w\-]+\]' make.log |sort | uniq -c | sort -rn
> >     163 [-Wmissing-prototypes]
> >      69 [-Wunused-but-set-variable]
> >      16 [-Wempty-body]
> >      10 [-Wtype-limits]
> >       6 [-Woverride-init]
> >       2 [-Wstringop-truncation]
> >       2 [-Wcast-function-type]
> >       1 [-Wunused-but-set-parameter]
> 
> On my eyes, it doesn't sound too much.

In general, I agree and most of these are pretty
trivial to remove.  It'd just take some time to
remove most of the missing-prototypes and
unused-but-set warnings before being able to
enable the warnings at the default W=0.

> I suspect that, 
> with gcc-9, it should produce more warnings, though.

It doesn't though.
At least not so far as I can tell.
gcc-9.1 produces the same output.

$ { make clean ; make defconfig ; make CC=/usr/bin/gcc-9 -j4 W=1 V=1 ; } > make_gcc9.log 2>&1
$  grep -i -P -oh '\[\-W[\w\-]+\]' make_gcc9.log | sort | uniq -c | sort -rn
    163 [-Wmissing-prototypes]
     69 [-Wunused-but-set-variable]
     16 [-Wempty-body]
     10 [-Wtype-limits]
      6 [-Woverride-init]
      2 [-Wstringop-truncation]
      2 [-Wcast-function-type]
      1 [-Wunused-but-set-parameter]


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
