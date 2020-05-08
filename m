Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014121CB253
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 May 2020 16:52:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8A3D6118531C7;
	Fri,  8 May 2020 07:50:32 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=216.40.44.130; helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com; receiver=<UNKNOWN> 
Received: from smtprelay.hostedemail.com (smtprelay0130.hostedemail.com [216.40.44.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B708F118531C2
	for <linux-nvdimm@lists.01.org>; Fri,  8 May 2020 07:50:30 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
	by smtprelay01.hostedemail.com (Postfix) with ESMTP id D2C28100E7B40;
	Fri,  8 May 2020 14:52:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:800:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3167:3352:3622:3865:3866:3867:3870:3871:3872:4250:4321:5007:6119:7903:10004:10400:10848:11026:11232:11658:11914:12296:12297:12663:12740:12760:12895:13069:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21080:21627:30054:30070:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fuel50_505bb413ac133
X-Filterd-Recvd-Size: 2104
Received: from XPS-9350.home (unknown [47.151.136.130])
	(Authenticated sender: joe@perches.com)
	by omf14.hostedemail.com (Postfix) with ESMTPA;
	Fri,  8 May 2020 14:52:32 +0000 (UTC)
Message-ID: <ff1fcc5b32a9ad209660c7cfe7e212c1a16ba10d.camel@perches.com>
Subject: Re: [PATCH v7 2/5] seq_buf: Export seq_buf_printf() to external
 modules
From: Joe Perches <joe@perches.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, Borislav Petkov <bp@alien8.de>
Date: Fri, 08 May 2020 07:52:30 -0700
In-Reply-To: <87blmy8wm8.fsf@linux.ibm.com>
References: <20200508104922.72565-1-vaibhav@linux.ibm.com>
	 <20200508104922.72565-3-vaibhav@linux.ibm.com>
	 <20200508113100.GA19436@zn.tnic> <87blmy8wm8.fsf@linux.ibm.com>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Message-ID-Hash: ZN44QYEWAXDRZX3IMQ634WVGBWQK4LUM
X-Message-ID-Hash: ZN44QYEWAXDRZX3IMQ634WVGBWQK4LUM
X-MailFrom: joe@perches.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>, Piotr Maziarz <piotrx.maziarz@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZN44QYEWAXDRZX3IMQ634WVGBWQK4LUM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2020-05-08 at 17:30 +0530, Vaibhav Jain wrote:
> Hi Boris,
> 
> Borislav Petkov <bp@alien8.de> writes:
> 
> > On Fri, May 08, 2020 at 04:19:19PM +0530, Vaibhav Jain wrote:
> > > 'seq_buf' provides a very useful abstraction for writing to a string
> > > buffer without needing to worry about it over-flowing. However even
> > > though the API has been stable for couple of years now its stills not
> > > exported to external modules limiting its usage.
> > > 
> > > Hence this patch proposes update to 'seq_buf.c' to mark
> > > seq_buf_printf() which is part of the seq_buf API to be exported to
> > > external GPL modules. This symbol will be used in later parts of this
> > 
> > What is "external GPL modules"?
> I am referring to Kernel Loadable Modules with MODULE_LICENSE("GPL")
> here.

Any reason why these Kernel Loadable Modules with MODULE_LICENSE("GPL")
are not in the kernel tree?

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
