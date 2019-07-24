Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 839F9723C8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jul 2019 03:38:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 823D1212D2755;
	Tue, 23 Jul 2019 18:41:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8A9552194EB70
 for <linux-nvdimm@lists.01.org>; Tue, 23 Jul 2019 18:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AFwPz9F7BR2KO7EHQe4D2tuUr0dHyiHUKqAqUScb/5k=; b=RULrgcX43IxPsdqZAr6lzCNtc
 zncXOGdm5at73wpugQrjVm/0D5jAFMwnWKMKvNEA4wlnwbE6pgoawegICLrGsEQBv3zxPp/3b/kuy
 irE/ozw1NZOQwzdR1gpTm0V1AtY6m0TW83pVr89t+9aWKmjX7SJCi7nfKmLroTQsKWOB+LVwEItZC
 qlFd1a/r5p9/fZ+bovKzNcmCrBIXwIgFiTVdaetrzDdeLU1VPV7tJXwY4XA7Gr5jj19De7QnjImV2
 +emEkD2xFmY7RB4rzv8jQmLp24bAE5Y8MPNZ8EYASJsS1q40hA7KT+nJarwSVQNPfOCF6U0kNje1W
 SSuCf5tTg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hq6Eq-0008Ul-UO; Wed, 24 Jul 2019 01:38:40 +0000
Date: Tue, 23 Jul 2019 18:38:40 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH] mm/memory-failure: Poison read receives SIGKILL instead
 of SIGBUS if mmaped more than once
Message-ID: <20190724013840.GS363@bombadil.infradead.org>
References: <1563925110-19359-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1563925110-19359-1-git-send-email-jane.chu@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: linux-mm@kvack.org, n-horiguchi@ah.jp.nec.com, linux-kernel@vger.kernel.org,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jul 23, 2019 at 05:38:30PM -0600, Jane Chu wrote:
> @@ -331,16 +330,21 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>  		tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
>  
>  	/*
> -	 * In theory we don't have to kill when the page was
> -	 * munmaped. But it could be also a mremap. Since that's
> -	 * likely very rare kill anyways just out of paranoia, but use
> -	 * a SIGKILL because the error is not contained anymore.
> +	 * Indeed a page could be mmapped N times within a process. And it's possible

You should run this patch through checkpatch.pl so I don't have to tell
you whats wrong with the trivial aspects of it ;-)

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
