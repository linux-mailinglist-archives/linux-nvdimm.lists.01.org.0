Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B9E252576
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Aug 2020 04:26:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2B1A611FBA415;
	Tue, 25 Aug 2020 19:26:30 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E4807111F31E2
	for <linux-nvdimm@lists.01.org>; Tue, 25 Aug 2020 19:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sxFvO/GLCLgBRfmkOAspDUyP4lpcTibuAN2MiSmiuaE=; b=ncJE4xT0RV0DL88DyjXY0ZZWNX
	c5H0dGv17CatAlJxzga6RRk56Q8fwDpXIuW7EEgf7tICAzbPlgtNvK36sFxtwQvfroJ8qKcfn9ct+
	v4xOejFU30Eo6Um3PIONALTAT6Ii6GySy9Kynet63yIETPr4X7Oj3m9vt0bUhKXato+jPPJgzIcmN
	xCRFwAEBsbxCuWcC3955WsJF+6u+RN5YmHIZREM7WnjcBaZxITdzSi1qvAFtPV8idzN0tt+oTQK6S
	sSkJThXGSEmeNs+teYiAx47mwssooc7xfO79kmW10tUeb6CG3YyCKJVsgR67CM/sfzG2kQmIpROjy
	HXDE9yLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAl8p-0003AS-OR; Wed, 26 Aug 2020 02:26:23 +0000
Date: Wed, 26 Aug 2020 03:26:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 5/9] iomap: Support arbitrarily many blocks per page
Message-ID: <20200826022623.GQ17456@casper.infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-6-willy@infradead.org>
 <20200825210203.GJ6096@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200825210203.GJ6096@magnolia>
Message-ID-Hash: FBBZ3OIQ7PKPI433YMZP2IGNYJAXYVRV
X-Message-ID-Hash: FBBZ3OIQ7PKPI433YMZP2IGNYJAXYVRV
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FBBZ3OIQ7PKPI433YMZP2IGNYJAXYVRV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 25, 2020 at 02:02:03PM -0700, Darrick J. Wong wrote:
> >  /*
> > - * Structure allocated for each page when block size < PAGE_SIZE to track
> > + * Structure allocated for each page when block size < page size to track
> >   * sub-page uptodate status and I/O completions.
> 
> "for each regular page or head page of a huge page"?  Or whatever we're
> calling them nowadays?

Well, that's what I'm calling a "page" ;-)

How about "for each page or THP"?  The fact that it's stored in the
head page is incidental -- it's allocated for the THP.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
