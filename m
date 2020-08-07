Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F9723EE59
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Aug 2020 15:39:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B36DB1270CEDC;
	Fri,  7 Aug 2020 06:39:06 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DE88F1270CED5
	for <linux-nvdimm@lists.01.org>; Fri,  7 Aug 2020 06:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eNlt5+MOMqdMiipq56av3Q5dInH/0IZEcBwwhkePOhw=; b=jooGZOBZPN+/zhWloZREEQs9Qe
	1Gm0HEqpmKTnkfVygGtCjNGPDIVzbn6Oy4iJaZzm2CfGsgeL8I6RGXh+QirerafkOCyyFLowQfn04
	IChcKEfRifcIOwSxygkNiijBPFeNHpOZTqM6nCUYljV7yii6nwcVfTblozH6g8PM6Q312CvbDI25M
	zjBglzIXAyMENEhkum19A1pCMt7D7s7lweM2Z4sd2VbM7V6c6Cd5CwISpe/CWHJm+3fcz7fTwgtvK
	Rlxfs1dl7r8mlxzgjjjbi+UlFk1MHOgX7V6pvrUvfVUZV9ivnPN/+OOwdWfrzlX5EzJ1coyIw+I7X
	K4lH3vDg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k42aH-0003o5-B8; Fri, 07 Aug 2020 13:38:57 +0000
Date: Fri, 7 Aug 2020 14:38:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [RFC PATCH 0/8] fsdax: introduce FS query interface to support
 reflink
Message-ID: <20200807133857.GC17456@casper.infradead.org>
References: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
Message-ID-Hash: RMXVJIVOKJXBWOTR57CY3EZ3HB7BUK35
X-Message-ID-Hash: RMXVJIVOKJXBWOTR57CY3EZ3HB7BUK35
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RMXVJIVOKJXBWOTR57CY3EZ3HB7BUK35/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Aug 07, 2020 at 09:13:28PM +0800, Shiyang Ruan wrote:
> This patchset is a try to resolve the problem of tracking shared page
> for fsdax.
> 
> Instead of per-page tracking method, this patchset introduces a query
> interface: get_shared_files(), which is implemented by each FS, to
> obtain the owners of a shared page.  It returns an owner list of this
> shared page.  Then, the memory-failure() iterates the list to be able
> to notify each process using files that sharing this page.
> 
> The design of the tracking method is as follow:
> 1. dax_assocaite_entry() associates the owner's info to this page

I think that's the first problem with this design.  dax_associate_entry is
a horrendous idea which needs to be ripped out, not made more important.
It's all part of the general problem of trying to do something on a
per-page basis instead of per-extent basis.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
