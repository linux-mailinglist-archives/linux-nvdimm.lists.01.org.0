Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E9DB16A6
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 01:26:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 92937202E6E1B;
	Thu, 12 Sep 2019 16:26:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.240;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0240.hostedemail.com
 [216.40.44.240])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B2E20202E6E0E
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 16:26:39 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9A7731801A086;
 Thu, 12 Sep 2019 23:26:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::::::,
 RULES_HIT:41:355:379:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3867:3871:3872:3874:4321:4470:5007:6691:10004:10400:10848:11026:11232:11658:11914:12109:12297:12663:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:30054:30090:30091,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:15,
 LUA_SUMMARY:none
X-HE-Tag: skin44_742702c58da54
X-Filterd-Recvd-Size: 1793
Received: from XPS-9350.home (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf10.hostedemail.com (Postfix) with ESMTPA;
 Thu, 12 Sep 2019 23:26:38 +0000 (UTC)
Message-ID: <fdd69f54908d90cd0c93af7b5d80a6c3ca3b5817.camel@perches.com>
Subject: clang-format and 'clang-format on' and 'clang-format off'
From: Joe Perches <joe@perches.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Nick Desaulniers
 <ndesaulniers@google.com>, llvm-dev@lists.llvm.org
Date: Thu, 12 Sep 2019 16:26:37 -0700
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

> > Marking sections _no_auto_format_ isn't really a
> > good solution is it?
> 
> I am thinking about special tables that are hand-crafted or very
> complex macros. For those, yes, I think it is a fine solution.

Can the 'clang-format on/off' trigger be indirected into
something non-clang specific via a macro?

Not every project is going to use only the clang-format tool.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
