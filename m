Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD7D295FFB
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Oct 2020 15:26:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 204121622046C;
	Thu, 22 Oct 2020 06:26:46 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+1ec22d3227dac79b61d2+6269+infradead.org+hch@casper.srs.infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 68A631622046A
	for <linux-nvdimm@lists.01.org>; Thu, 22 Oct 2020 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=WDc4vjUT22x0uDWdml0ad2Zl1+
	deq3uUi1p3+tR87hRyCPjmVK9SaCuTdqWrvA3s93Kk6YaJ9T3XMfwGaku4+N64ElW5l26vkdKQdFj
	/eUb9mb+qGTFLzuQHUkO70UsPT5gTQW8HM/Zt4qxFyau2w1HSnUIMW0i3NSsRh8kmkE+kDv21KNWx
	GpHXdVRhL39adxcW3JBfyKouPZeqfuEmL1+Top+i2rMwA1V/mmm//TSMypQGZBlcdklbneAqYQGvJ
	Y/+EVPO2yiXsQN6ghXmrMrKAiAkJootpROdWTZalb8y58MdwnMoP6PvpplZ9l8BIimSKZATwHnpSw
	ZJg9BNNw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVabv-00072e-PZ; Thu, 22 Oct 2020 13:26:31 +0000
Date: Thu, 22 Oct 2020 14:26:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] mm/mremap_pages: Fix static key devmap_managed_key
 updates
Message-ID: <20201022132631.GA26823@infradead.org>
References: <20201022060753.21173-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201022060753.21173-1-aneesh.kumar@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: EOYS4HHFC42M47CWDDYVMISWX4XSQ23F
X-Message-ID-Hash: EOYS4HHFC42M47CWDDYVMISWX4XSQ23F
X-MailFrom: BATV+1ec22d3227dac79b61d2+6269+infradead.org+hch@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, akpm@linux-foundation.org, Christoph Hellwig <hch@infradead.org>, Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-nvdimm@lists.01.org, Jason Gunthorpe <jgg@mellanox.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EOYS4HHFC42M47CWDDYVMISWX4XSQ23F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
