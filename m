Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ABFB351E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 16 Sep 2019 09:08:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 40B73202C80BA;
	Mon, 16 Sep 2019 00:07:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+e4e939a9a6de604c6042+5867+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1421B202C8091
 for <linux-nvdimm@lists.01.org>; Mon, 16 Sep 2019 00:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8KvjgvpB0tliOwRlNgu9kfQS7Ox5dSnaO0U89tZHGOM=; b=NQuqs9yqPA4Q9D4/DHzCx89Wc
 7HTNu9ysGDnp2hsPL7Xka8MLU53zrYlCBlzj0HVfZrf9q5Sd5EhdyEzAIvv0tCneXrvCQl16yWTFN
 FJXpwMnJVs5xjMQ/ucfi1NZhm7WSRGajfkGiBWxZ9m04boDLEFqpcoZTagMpeLoGbUOO7aakzp451
 U5jI2MNXwByuOO9Ar6glN1Ooc0SLI+YMdaYQ8tWqxQFjnkcjLoSBsuw9MdIT5XrHeK1O/71MGFQnK
 Isr6yKzw3uvUTQT3fI9i2i32z/vrDmGmYrZ+DTSK+r2eJ4yBk/+H67s5INsLwGc5GoTpc6MZ8XPXn
 XAYRzPizg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red
 Hat Linux)) id 1i9l75-0007Uj-FY; Mon, 16 Sep 2019 07:07:56 +0000
Date: Mon, 16 Sep 2019 00:07:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 01/13] nvdimm: Use more typical whitespace
Message-ID: <20190916070755.GA22009@infradead.org>
References: <cover.1568256705.git.joe@perches.com>
 <7a5598bda6a3d18d75c3e76ab89d9d95e8952500.1568256705.git.joe@perches.com>
 <20190912121707.GA16029@infradead.org>
 <33c0f43ef2334de5885e5fcf041483a2afb13787.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33c0f43ef2334de5885e5fcf041483a2afb13787.camel@perches.com>
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
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Sep 12, 2019 at 08:01:45AM -0700, Joe Perches wrote:
> On Thu, 2019-09-12 at 05:17 -0700, Christoph Hellwig wrote:
> > Instead of arguing what is better just stick to what the surrounding
> > code does.
> 
> That's not always feasible nor readable.
> 
> Especially for the logic inversion blocks where
> the existing code does unreadable and error prone
> things like hiding semicolons immediately after
> comments.
> 
> 	if (foo)
> 		/* longish comment */;
> 	else {
> 		<code>;
> 	}

Which has nothing to do with your patch.

> > Or in other words:  Feel free to be a codingstyle nazi for your code
> > (I am for some of mine), but leave others peoples code alone with
> > "cleanup" patches.
> 
> My point was to avoid documenting per-subsystem
> coding style rules.

It is called common sense.  In many cases different parts of the
subsystem might have slight variations.  Just stick to your
preferred style in the bounds of coding style.  Maintainers will
either remind you if they feel strongly that they have a slightly
different preference or just fix it up.  What we really don't need
need it whitespace cleanup patches in the micro variation area.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
