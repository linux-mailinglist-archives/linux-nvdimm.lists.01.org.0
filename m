Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09425162B9C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 18:10:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1C7E610FC33E6;
	Tue, 18 Feb 2020 09:11:01 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+407f53ceaa3a8fe198ff+6022+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F07F310FC33E6
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 09:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FMtS++UxKyfh+g0VsO76i6wRu/DQe7FSEBQsPlMCkME=; b=ErgdrkXZ3+X5SfKFrikmqUXKf3
	HPM9t9RkonupUYNYNEhrORKUT8MPYZNTQOBp9LCQzBIn/lHky+EOAiPFydTPp+VYPpaqT7Mapi7NV
	GmPWyI2UgRprBGCY0cOunBPWOTpbfht7kRvCzMhBH2dAgleAj9Spemp2V4NutFawSAXd8vaN+8Sgk
	L7UUAluxSSxWpPtycv24IW/MRPat084z1jbQ1yU8RZkNS+ZyICtBCN/q/YYyKgA9Khmp9Go2ZZWZW
	c7WNZeEl2hUKmwNDSCo2+72YcgPNOIqxEhXXC/KUXHLBT0S1VGt9ZX6ClrZnznILfN9LFBnBXuPXP
	MTu4Ue2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j46Nq-0000qW-2x; Tue, 18 Feb 2020 17:10:06 +0000
Date: Tue, 18 Feb 2020 09:10:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [dm-devel] [PATCH v4 3/7] dax, pmem: Add a dax operation
 zero_page_range
Message-ID: <20200218171006.GC30766@infradead.org>
References: <20200217181653.4706-1-vgoyal@redhat.com>
 <20200217181653.4706-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200217181653.4706-4-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: MWQRGQEK4YB4SSZHKNMFQ6H43Y5DHC2K
X-Message-ID-Hash: MWQRGQEK4YB4SSZHKNMFQ6H43Y5DHC2K
X-MailFrom: BATV+407f53ceaa3a8fe198ff+6022+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MWQRGQEK4YB4SSZHKNMFQ6H43Y5DHC2K/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> +static int pmem_dax_zero_page_range(struct dax_device *dax_dev, u64 offset,
> +				    size_t len)
> +{
> +	struct pmem_device *pmem = dax_get_private(dax_dev);
> +	blk_status_t rc;
> +
> +	rc = pmem_do_write(pmem, ZERO_PAGE(0), 0, offset, len);
> +	return blk_status_to_errno(rc);

No real need for the rc variable here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
