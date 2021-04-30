Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3836736F4CD
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Apr 2021 06:16:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3ECC5100EBBB3;
	Thu, 29 Apr 2021 21:16:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7C2D8100EC1D4
	for <linux-nvdimm@lists.01.org>; Thu, 29 Apr 2021 21:16:36 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 341236101B;
	Fri, 30 Apr 2021 04:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1619756195;
	bh=xhexiXbss3a7nAe5J1pREY15jAnW/gq8wn0LwB5fLgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2YqwBTJKXUnmfpyHTuBgrTeLpDen/BK/fRgjhh6RTzcIJReUpeNqFOK5RteKgCCy+
	 KVkkI5XaJeDLq5Ggn3Q0Fv3rE1/FErkuyzAX0dyb+fJLqk1ZvjKq5a+u09bAmjz4Ki
	 az6Om78xeZmHXevcWYARg2t1wDzkMj0Wa0xPl4HU=
Date: Thu, 29 Apr 2021 21:16:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Subject: Re: BUG_ON(!mapping_empty(&inode->i_data))
Message-Id: <20210429211634.de4e0fb98d27b3ab9d05757c@linux-foundation.org>
In-Reply-To: <alpine.LSU.2.11.2104021354150.1029@eggly.anvils>
References: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils>
	<20210331024913.GS351017@casper.infradead.org>
	<alpine.LSU.2.11.2103311413560.1201@eggly.anvils>
	<20210401170615.GH351017@casper.infradead.org>
	<20210402031305.GK351017@casper.infradead.org>
	<20210402132708.GM351017@casper.infradead.org>
	<20210402170414.GQ351017@casper.infradead.org>
	<alpine.LSU.2.11.2104021239060.1092@eggly.anvils>
	<alpine.LSU.2.11.2104021354150.1029@eggly.anvils>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: PQYEDDPDQH6B54SKWCG7AJ3UKD45PY5M
X-Message-ID-Hash: PQYEDDPDQH6B54SKWCG7AJ3UKD45PY5M
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PQYEDDPDQH6B54SKWCG7AJ3UKD45PY5M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2 Apr 2021 14:16:04 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> On Fri, 2 Apr 2021, Hugh Dickins wrote:
> > 
> > There is a "Put holes back where they were" xas_store(&xas, NULL) on
> > the failure path, which I think we would expect to delete empty nodes.
> > But it only goes as far as nr_none.  Is it ok to xas_store(&xas, NULL)
> > where there was no non-NULL entry before?  I should try that, maybe
> > adjusting the !nr_none break will give a very simple fix.
> 
> No, XArray did not like that:
> xas_update() XA_NODE_BUG_ON(node, !list_empty(&node->private_list)).
> 
> But also it's the wrong thing for collapse_file() to do, from a file
> integrity point of view. So far as there is a non-NULL page in the list,
> or nr_none is non-zero, those subpages are frozen at the src end, and
> THP head locked and not Uptodate at the dst end. But go beyond nr_none,
> and a racing task could be adding new pages, which THP collapse failure
> has no right to delete behind its back.
> 
> Not an issue for READ_ONLY_THP_FOR_FS, but important for shmem and future.
> 
> > 
> > Or, if you remove the "static " from xas_trim(), maybe that provides
> > the xas_prune_range() you proposed, or the cleanup pass I proposed.
> > To be called on collapse_file() failure, or when eviction finds
> > !mapping_empty().
> 
> Something like this I think.
> 

I'm not sure this ever was resolved?

Is it the case that the series "Remove nrexceptional tracking v2" at
least exposed this bug?

IOW, what the heck should I do with

mm-introduce-and-use-mapping_empty.patch
mm-stop-accounting-shadow-entries.patch
dax-account-dax-entries-as-nrpages.patch
mm-remove-nrexceptional-from-inode.patch

Thanks.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
