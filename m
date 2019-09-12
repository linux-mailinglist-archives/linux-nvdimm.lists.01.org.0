Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E522BB09FE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 10:15:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 452C621962301;
	Thu, 12 Sep 2019 01:15:47 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.79;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0079.hostedemail.com
 [216.40.44.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 561C8202C80B7
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 01:15:46 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay05.hostedemail.com (Postfix) with ESMTP id ABE5E1801585D;
 Thu, 12 Sep 2019 08:15:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com,
 :::::::::::::::::::,
 RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2110:2198:2199:2393:2553:2559:2562:2691:2828:2917:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3873:3874:4321:5007:6119:7903:7974:10004:10400:10848:11232:11658:11914:12050:12297:12663:12740:12760:12895:13069:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21080:21324:21627:21740:30054:30060:30090:30091,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:34,
 LUA_SUMMARY:none
X-HE-Tag: help45_1436e6ec66121
X-Filterd-Recvd-Size: 2134
Received: from XPS-9350.home (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf13.hostedemail.com (Postfix) with ESMTPA;
 Thu, 12 Sep 2019 08:15:38 +0000 (UTC)
Message-ID: <be3c626c2e9d14fe2fa9d0403bc02832231cc437.camel@perches.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
From: Joe Perches <joe@perches.com>
To: Dan Williams <dan.j.williams@intel.com>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Sep 2019 01:15:37 -0700
In-Reply-To: <CAPcyv4hzoSp-bFx19Yj71H7x3D66-TE4uCpcHm4S9sJsGtXugA@mail.gmail.com>
References: <cover.1568256705.git.joe@perches.com>
 <CAPcyv4hzoSp-bFx19Yj71H7x3D66-TE4uCpcHm4S9sJsGtXugA@mail.gmail.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, 2019-09-12 at 01:00 -0700, Dan Williams wrote:
> Hi Joe,
> 
> On Wed, Sep 11, 2019 at 7:55 PM Joe Perches <joe@perches.com> wrote:
> > Rather than have a local coding style, use the typical kernel style.
> 
> I'd rather automate this. I'm going to do once-over with clang-format
> and see what falls out.

I am adding Miguel Ojeda to the cc's.

Of course you are welcome to try it, but I believe that
clang-format doesn't work all that well yet.

It's more a work in progress rather than a "standard".

I believe you'll find that the patch series I sent
ends up with a rather more typical kernel style.

I suggest you try to apply the series I sent and then
run clang-format on that and see the differences.

Ideally one day, something tool like clang-format
might be locally applied by every developer for their
own personal style with some other neutral style the
content actually distributed.

cheers, Joe

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
