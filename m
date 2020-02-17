Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2C816134C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Feb 2020 14:27:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0402510FC3410;
	Mon, 17 Feb 2020 05:30:53 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+384e8c264b588af03727+6021+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CC7E410FC338A
	for <linux-nvdimm@lists.01.org>; Mon, 17 Feb 2020 05:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PBhD8cmezTHFasz5vzVH0dWQzfsH7+46R6pRA6K+f/c=; b=HZ73dCSyraHQd8K1CeZ64PsCdb
	wIN4YvlZr163/33vNmQ67J2vp9tS+qcPQW1ItzsLMDNnJC+7Tuz2KbrYzHm1xKuw1VTS/78ev5pS2
	j2n/CW/9K+jHHbPA44C+s92ARIYYRXBM3cxouPjo7Djf80/byoKJDjQHNUp/DIbsp98rfaJLaA8vM
	cQ1gRAAQWXFUcZaa7YETpCSLML5iPt5236UKcQ8Luz36p7yZT3lE1DsOXbnP5Bwx62twtrygAH1vp
	R7c/zuB8gnXOAGsWPKMWVgewHy2rh2pf8bUovUWmwk4+bRHnOB5LR7rN9d1964kXv4BM0NSdpXnxF
	g89Vdhww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j3gQI-0004gP-3m; Mon, 17 Feb 2020 13:26:54 +0000
Date: Mon, 17 Feb 2020 05:26:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 6/7] dax,iomap: Start using dax native
 zero_page_range()
Message-ID: <20200217132654.GE14490@infradead.org>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-7-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200207202652.1439-7-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: DCAS3LEEXWYWPLXV2MMITYJNIONQU5GE
X-Message-ID-Hash: DCAS3LEEXWYWPLXV2MMITYJNIONQU5GE
X-MailFrom: BATV+384e8c264b588af03727+6021+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DCAS3LEEXWYWPLXV2MMITYJNIONQU5GE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 07, 2020 at 03:26:51PM -0500, Vivek Goyal wrote:
> Get rid of calling block device interface for zeroing in iomap dax
> zeroing path and use dax native zeroing interface instead.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
