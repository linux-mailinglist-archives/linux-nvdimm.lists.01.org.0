Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F48FB1173
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 16:51:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C8A6F202E6DE4;
	Thu, 12 Sep 2019 07:51:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=216.40.44.216;
 helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from smtprelay.hostedemail.com (smtprelay0216.hostedemail.com
 [216.40.44.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EB8CE202E2938
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 07:51:44 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id 92CC1831D72C;
 Thu, 12 Sep 2019 14:51:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2, 0, 0, , d41d8cd98f00b204, joe@perches.com, :::::::::::,
 RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2909:2917:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7903:7904:8957:10004:10400:10450:10455:10562:10848:11232:11658:11914:12297:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14659:14721:19904:19999:21080:21433:21451:21627:21740:30016:30054:30060:30091,
 0,
 RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,
 CacheIP:none, Bayesian:0.5, 0.5, 0.5, Netcheck:none, DomainCache:0,
 MSF:not bulk, SPF:fn, MSBL:0, DNSBL:neutral, Custom_rules:0:0:0, LFtime:38,
 LUA_SUMMARY:none
X-HE-Tag: yard89_8305e22eeb808
X-Filterd-Recvd-Size: 2937
Received: from XPS-9350.home (unknown [47.151.152.152])
 (Authenticated sender: joe@perches.com)
 by omf12.hostedemail.com (Postfix) with ESMTPA;
 Thu, 12 Sep 2019 14:51:40 +0000 (UTC)
Message-ID: <9d4633cf0bbf531393ce170444d607eb2e915f48.camel@perches.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
From: Joe Perches <joe@perches.com>
To: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Sep 2019 07:51:39 -0700
In-Reply-To: <CAPcyv4iu13D5P+ExdeW8OGMV8g49fMUy52xbYZM+bewwVSwhjg@mail.gmail.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
 <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <CAPcyv4ij3s+9uO0f9aLHGj3=ACG7hAjZ0Rf=tyFmpt3+uQyymw@mail.gmail.com>
 <CANiq72k2so3ZcqA3iRziGY=Shd_B1=qGoXXROeAF7Y3+pDmqyA@mail.gmail.com>
 <e9cb9bc8bd7fe38a5bb6ff7b7222b512acc7b018.camel@perches.com>
 <5eebafcb85a23a59f01681e73c83b387c59f4a4b.camel@perches.com>
 <CAPcyv4iu13D5P+ExdeW8OGMV8g49fMUy52xbYZM+bewwVSwhjg@mail.gmail.com>
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
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, 2019-09-12 at 07:17 -0700, Dan Williams wrote:

> Ok, good to confirm that we do not yet have an objective standard for
> coding style. This means it's not yet something process documentation
> can better standardize for contributors and will be subject to ongoing
> taste debates. Lets reclaim the time to talk about objective items
> that *can* clarified across maintainers.

No, let's not and just clarify whether or not whitespace
style patches are acceptable patch submissions.

Coding style fragmentation is not otherwise acceptable to me.

nvdimm mandating 2 tab indentation when nvdimm itself is not
at all consistent in that regard is also whitespace noise.

> As for libnvdimm at this point I'd rather start with objective
> checkpatch error cleanups and defer the personal taste items.

Fine by me.

I do want to avoid documenting per-subsystem coding styles.

How about adding something to MAINTAINERS like:

A:	Accepting patches by newbies or CodingStyle strict

and checkpatch could be changed turn off a bunch of
whitespace rules on a subsystem basis when run with
-f for files or without -f for a patch.

Most of this comes down to whitespace like

	a = b + c

where it hardly matters if the CodingStyle mandated
space around + is used or

	foo = bar(baz,
			qux)

where qux position is not really important.


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
