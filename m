Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BCA800B8
	for <lists+linux-nvdimm@lfdr.de>; Fri,  2 Aug 2019 21:14:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D86F42130C486;
	Fri,  2 Aug 2019 12:17:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=140.211.169.12; helo=mail.linuxfoundation.org;
 envelope-from=akpm@linux-foundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 90B35213030B6
 for <linux-nvdimm@lists.01.org>; Fri,  2 Aug 2019 12:17:06 -0700 (PDT)
Received: from X1 (unknown [76.191.170.112])
 by mail.linuxfoundation.org (Postfix) with ESMTPSA id 973AE174C;
 Fri,  2 Aug 2019 19:14:34 +0000 (UTC)
Date: Fri, 2 Aug 2019 12:14:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] memremap: move from kernel/ to mm/
Message-Id: <20190802121431.3ef9d271c40703b4145d364e@linux-foundation.org>
In-Reply-To: <20190802083230.GB11000@lst.de>
References: <20190722094143.18387-1-hch@lst.de> <20190802083230.GB11000@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
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
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, 2 Aug 2019 10:32:30 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Andrew,
> 
> I've seen you've queued this up in -mm, but the explicit intent here was
> to quickly merge this after -rc1 so that the move doesn't conflict with
> further development for 5.3.

Didn't know that.

>  Any chance you could send this patch on to Linus?

Sure, I'll add it to today's batch.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
