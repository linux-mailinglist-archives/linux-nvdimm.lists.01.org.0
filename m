Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE5F153917
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 20:28:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D985A10FC33F2;
	Wed,  5 Feb 2020 11:31:23 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+a2b935cbc3c12af13a1b+6009+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C7E6410FC33EF
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 11:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QABBpGTAcCBsCMraQQqa4epo9mEJxyTHyWGoCeCqXq4=; b=UZeijFCYL90Ju1tY93FKw+Ovyk
	zxCkS0hA6/VyUT88ABiVyLEvL2YmCfkBb+A5F9s0mC8s/ttjcpKCfkawMH5vbl1cVbvyllyb9Vray
	Qwx98snsC4nwoQ5uqWqpLG8lnEtICzQlig426NvljpsdDTZQdxM+8yA3CUKBDNloVPOLA+KWNl3gY
	pdTHrBK7bfxsxTOpOGv7f+mlSVW8M+AsZNqpHtb+Sm+AQQSgJ6Z8JKOPjNysr0WkZweH/5Q8c8rJ8
	9KXmVJsMkUkhbLDV0rPwbmOXJ95a3EArWndpMQa6OY8loopDTn0OYvPKz6m+2I4y/7wPWkESncpiB
	u/TaB2UQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izQLC-0000eg-2S; Wed, 05 Feb 2020 19:28:02 +0000
Date: Wed, 5 Feb 2020 11:28:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch] dax: pass NOWAIT flag to iomap_apply
Message-ID: <20200205192802.GA2425@infradead.org>
References: <x49r1z86e1d.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <x49r1z86e1d.fsf@segfault.boston.devel.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: QCFVRD2XSEQHCCT3W2PWRRZRX6PFB67C
X-Message-ID-Hash: QCFVRD2XSEQHCCT3W2PWRRZRX6PFB67C
X-MailFrom: BATV+a2b935cbc3c12af13a1b+6009+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, willy@infradead.org, jack@suse.cz
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QCFVRD2XSEQHCCT3W2PWRRZRX6PFB67C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 05, 2020 at 02:15:58PM -0500, Jeff Moyer wrote:
> fstests generic/471 reports a failure when run with MOUNT_OPTIONS="-o
> dax".  The reason is that the initial pwrite to an empty file with the
> RWF_NOWAIT flag set does not return -EAGAIN.  It turns out that
> dax_iomap_rw doesn't pass that flag through to iomap_apply.
> 
> With this patch applied, generic/471 passes for me.
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
