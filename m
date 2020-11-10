Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1222ADE62
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Nov 2020 19:32:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 05CDB16640203;
	Tue, 10 Nov 2020 10:32:48 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6A0B116640202
	for <linux-nvdimm@lists.01.org>; Tue, 10 Nov 2020 10:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s71PQJ0UzgiTWz5YQZpQUhxr7/w5u3caoT/K4RDIPRw=; b=AIuMRPehUeZ/ksaab33AT0JXnz
	9kPsJQcNZl3yNNhnaxyynjksTTm9RVFLMbjMaLfIvSsFjfE6ksS7zexZ7TF68qnilzkW0KiQ3Q3ph
	NV3DSewBJAE/ted1ZMeZHbbynz9hbTuqHItNZ6NyUZ32iEhQXhH74E3K/TejeIXBS7bxSqm/Kr652
	+7MbPyIrDnFV49hbQxErREOwi9A4WEFh1zLI2itBU1+syY+VgM49pJabCOI7lFUOHmGwn6eNM6JsT
	asxGjvtIou0BGnUwvVivMJUtKogEuyRzpaYmlv8thcn21/UJ2rCu+KmZOZ4LeqYkC9EIMHah68j8u
	LA0ftvXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcYRa-0002Oe-6v; Tue, 10 Nov 2020 18:32:38 +0000
Date: Tue, 10 Nov 2020 18:32:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] mm: unexport follow_pte_pmd
Message-ID: <20201110183238.GL17076@casper.infradead.org>
References: <20201029101432.47011-1-hch@lst.de>
 <20201029101432.47011-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201029101432.47011-2-hch@lst.de>
Message-ID-Hash: U4ZKEG6JPKRE6QUMVHAUD22EK4KC6JKL
X-Message-ID-Hash: U4ZKEG6JPKRE6QUMVHAUD22EK4KC6JKL
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U4ZKEG6JPKRE6QUMVHAUD22EK4KC6JKL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 29, 2020 at 11:14:31AM +0100, Christoph Hellwig wrote:
> follow_pte_pmd is only used by the DAX code, which can't be modular.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
