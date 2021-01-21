Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614272FEF64
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Jan 2021 16:49:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A58F2100EB824;
	Thu, 21 Jan 2021 07:49:10 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 274AC100EBBAF
	for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 07:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZL81M5BEqTudNah5tQWg3R+0k1d+KEs2wiEIXk0AHyU=; b=e3+fCJZ4+c/Bd3YFXUnB7wc2QG
	zNZApZUXVsJIXgnQ3uDIrk+MdHuBf/EAIQAJSnrt6uQWYQQLnG987ACUBhaoUtT4BMyP/mF3Vnu+o
	Sn3t0XGgrj/oantRFYObogGn5kFFTLcFx66G5HjEw0Q1G4zvbIqlp5lU8wjt+2Ih1jIWXudnMZVIE
	EdVihksh4xOV1tWg+RnHNpWlmqeYz41Fcqlop7WHGueLMzdxE08vtnXSgAf24+aIk1aE13JpWuHx0
	nQebCiUviossBNnJbDfhqJ/XS9RyRy4zHsANcSszrwiWOxpBQJ//Ou5+u8CsNXSVlCCBxAOkNBPY5
	5my++V+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l2cBU-00HDop-6A; Thu, 21 Jan 2021 15:47:51 +0000
Date: Thu, 21 Jan 2021 15:47:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Expense of read_iter
Message-ID: <20210121154744.GQ2260413@casper.infradead.org>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210107151125.GB5270@casper.infradead.org>
 <17045315-CC1F-4165-B8E3-BA55DD16D46B@gmail.com>
 <2041983017.5681521.1610459100858.JavaMail.zimbra@sjtu.edu.cn>
 <alpine.LRH.2.02.2101131008530.27448@file01.intranet.prod.int.rdu2.redhat.com>
 <1224425872.715547.1610703643424.JavaMail.zimbra@sjtu.edu.cn>
 <20210120044700.GA4626@dread.disaster.area>
 <20210120141834.GA24063@quack2.suse.cz>
 <alpine.LRH.2.02.2101200951070.24430@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2101200951070.24430@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID-Hash: WP7H5CJDR3I77AICOWSAZBFPRQKTZ6JP
X-Message-ID-Hash: WP7H5CJDR3I77AICOWSAZBFPRQKTZ6JP
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>, Zhongwei Cai <sunrise_l@sjtu.edu.cn>, Theodore Ts'o <tytso@mit.edu>, David Laight <David.Laight@aculab.com>, Mingkai Dong <mingkaidong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Whitehouse <swhiteho@redhat.com>, Eric Sandeen <esandeen@redhat.com>, Dave Chinner <dchinner@redhat.com>, Wang Jianchao <jianchao.wan9@gmail.com>, Rajesh Tadakamadla <rajesh.tadakamadla@hpe.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WP7H5CJDR3I77AICOWSAZBFPRQKTZ6JP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 20, 2021 at 10:12:01AM -0500, Mikulas Patocka wrote:
> Do you have some idea how to optimize the generic code that calls 
> ->read_iter?

Yes.

> It might be better to maintain an f_iocb_flags in the
> struct file and just copy that unconditionally.  We'd need to remember
> to update it in fcntl(F_SETFL), but I think that's the only place.

Want to give that a try?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
