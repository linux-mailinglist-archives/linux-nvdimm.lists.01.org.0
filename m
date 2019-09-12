Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D48FB0EBA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 14:17:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E6F8121962301;
	Thu, 12 Sep 2019 05:17:20 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+925f5eb4b30b3cab9222+5863+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B8AA2202E291C
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hc4pr/JgOy8jge1sULbZMWg1OXydBU1WsUPv7831t4U=; b=asDt2qezyg+T7KO3RqFIU5Nr8
 HAh9g7yO3V9DqeenDcb1NJOtekvqnlAUigcLmAZHgHCxv6ywixvMIVuSoDFxY5JnSQ6TpXdreb5BB
 Tx9wqCcvzXgxhDmyCW0XW2ZE77irAHhbW93bViqYhBe+Cw03/MYqVLQRdtHFwaevhEFCkr6sOh3pm
 5EPTIlU4AflqwXpAt9RfZMqqh64FDzFJnBe/GVZ1mppcdVydHn7AkdOd3GhEYMz4w85J1hwDFIVWv
 aSuoFTcEPICHlG7QLLXtWwY2kxCl6WIYk1j5MFzRYaqKdmtbf4MZRSmn9w1HtXz7N5gI7fZlah+Xn
 BJNhWlCfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red
 Hat Linux)) id 1i8O27-0004Uq-Gs; Thu, 12 Sep 2019 12:17:07 +0000
Date: Thu, 12 Sep 2019 05:17:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 01/13] nvdimm: Use more typical whitespace
Message-ID: <20190912121707.GA16029@infradead.org>
References: <cover.1568256705.git.joe@perches.com>
 <7a5598bda6a3d18d75c3e76ab89d9d95e8952500.1568256705.git.joe@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7a5598bda6a3d18d75c3e76ab89d9d95e8952500.1568256705.git.joe@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

>  static void append_badrange_entry(struct badrange *badrange,
> -		struct badrange_entry *bre, u64 addr, u64 length)
> +				  struct badrange_entry *bre, u64 addr, u64 length)

Please stop sending this kind of crap.  Two tabs are a very common
style used in a lot of the kernel, and some people actually prefer it.

Instead of arguing what is better just stick to what the surrounding
code does.

Or in other words:  Feel free to be a codingstyle nazi for your code
(I am for some of mine), but leave others peoples code alone with
"cleanup" patches.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
