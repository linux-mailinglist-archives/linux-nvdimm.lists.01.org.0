Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE02D1BA396
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 Apr 2020 14:28:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 441D81009D30D;
	Mon, 27 Apr 2020 05:27:56 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 85AE81009D30A
	for <linux-nvdimm@lists.01.org>; Mon, 27 Apr 2020 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Wzixkdd1MP05tKyiJudvvJUbNJ4oUXlhwu6lo0T90lk=; b=h4uZN/H6Mu3d0zPdDsclCVH32p
	44gY3nD6XgbLkqBBMl44AzSP/BJE3KBzRAPQwmBogEvavTEhIQUL3ocaF+cw7UkzuVAwITD4seBgk
	Pp8Hl1+tIQ8RODfstqU0/krSNx7E830cBVrxSyf5dfg0gpQoKrJKe2M5AynwMKOl0n3mi6Pl4oFKf
	efaEddM5vpsfG757hkc2v8IEonhVlf8jAZ4wp/U05w15FPDDSa7fkY0VDdkD1WHqV691GKsmZEkS8
	SOQI03I+FKN/fUWcflc8dcvjdXytbEbhLDXDLTXiJZruWD/RddNBs2RHT5uDy951iViKV1ctgL7yg
	iJXmOD4A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jT2sG-0003WE-Dr; Mon, 27 Apr 2020 12:28:36 +0000
Date: Mon, 27 Apr 2020 05:28:36 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [RFC PATCH 0/8] dax: Add a dax-rmap tree to support reflink
Message-ID: <20200427122836.GD29705@bombadil.infradead.org>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
Message-ID-Hash: 4F5VIDHBLEDHUYPDQQBNKS44WUZENACB
X-Message-ID-Hash: 4F5VIDHBLEDHUYPDQQBNKS44WUZENACB
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4F5VIDHBLEDHUYPDQQBNKS44WUZENACB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 27, 2020 at 04:47:42PM +0800, Shiyang Ruan wrote:
> This patchset is a try to resolve the shared 'page cache' problem for
> fsdax.
> 
> In order to track multiple mappings and indexes on one page, I
> introduced a dax-rmap rb-tree to manage the relationship.  A dax entry
> will be associated more than once if is shared.  At the second time we
> associate this entry, we create this rb-tree and store its root in
> page->private(not used in fsdax).  Insert (->mapping, ->index) when
> dax_associate_entry() and delete it when dax_disassociate_entry().

Do we really want to track all of this on a per-page basis?  I would
have thought a per-extent basis was more useful.  Essentially, create
a new address_space for each shared extent.  Per page just seems like
a huge overhead.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
