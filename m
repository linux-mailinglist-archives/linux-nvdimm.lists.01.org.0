Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1011AF3A4
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:47:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B29510FC62D4;
	Sat, 18 Apr 2020 11:47:12 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=216.40.44.228; helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com; receiver=<UNKNOWN> 
Received: from smtprelay.hostedemail.com (smtprelay0228.hostedemail.com [216.40.44.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A5A4D10FC62D0
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:47:10 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
	by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3F8761802EC1C;
	Sat, 18 Apr 2020 18:47:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3867:3868:3871:3874:4321:5007:6119:6120:6742:6743:7903:10004:10400:10848:11232:11658:11914:12297:12679:12740:12760:12895:13069:13311:13357:13439:14659:21080:21451:21627:21966:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: loss63_59e6ce4dc9051
X-Filterd-Recvd-Size: 2163
Received: from XPS-9350.home (unknown [47.151.136.130])
	(Authenticated sender: joe@perches.com)
	by omf12.hostedemail.com (Postfix) with ESMTPA;
	Sat, 18 Apr 2020 18:46:57 +0000 (UTC)
Message-ID: <6bb8d99e6e56fa1622fc7238c1ae37c3b3510ded.camel@perches.com>
Subject: Re: [RFC PATCH 1/9] kernel.h: add do_empty() macro
From: Joe Perches <joe@perches.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Date: Sat, 18 Apr 2020 11:44:43 -0700
In-Reply-To: <20200418184111.13401-2-rdunlap@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
	 <20200418184111.13401-2-rdunlap@infradead.org>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Message-ID-Hash: 7Y35BD42QMAELYVM7KFCII7FB3L74PYJ
X-Message-ID-Hash: 7Y35BD42QMAELYVM7KFCII7FB3L74PYJ
X-MailFrom: joe@perches.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7Y35BD42QMAELYVM7KFCII7FB3L74PYJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2020-04-18 at 11:41 -0700, Randy Dunlap wrote:
> Add the do_empty() macro to silence gcc warnings about an empty body
> following an "if" statement when -Wextra is used.
> 
> However, for debug printk calls that are being disabled, use either
> no_printk() or pr_debug() [and optionally dynamic printk debugging]
> instead.
[]
> +#define do_empty()		do { } while (0)

If this is really useful
(I think the warning is somewhat silly)

bikeshed:

I think do_nothing() is more descriptive

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
