Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D1136D13
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Jan 2020 13:31:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D30B10097DD0;
	Fri, 10 Jan 2020 04:34:49 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+524c891bdf23d94d05f7+5983+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CEB8D10097DD0
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 04:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=B/rKaa819gyayiC8Xe2hoNfVxDFo4LjZMb+oCIBCt4A=; b=Mj1/cHpyNqAgv/lVJOV/TP+Zj
	egd1NiWTg95WnXdO8GzEGGiVWXwRU3H+E29g0uVUBnxj9ZG7x0fcYtVBTI//wNlkf+KsAOmx7axTf
	Gc8pv2zZYaPxRunSGtLY4RuN7jj+dSV2b5+aIhFylnGPxBelgs3smecSXa7E34ZnQngJ7W/2xA+1a
	NUzhU4twKo0iuaHP3wTcsVoqDE18tS5u72bzSdI5+qJSI+AHD+3TO72VAqUy9Zy0Y5FPdZH5P/N9h
	2KFuCwQdTla2L7GluHlni2Ux9OYIM+JCNP3jqnY6GtykRDI9mopYWyIA8zDezasfGBpIUQ8Ce3CYo
	VZkuzcBug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iptRn-0003UC-1r; Fri, 10 Jan 2020 12:31:27 +0000
Date: Fri, 10 Jan 2020 04:31:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: dax: Get rid of fs_dax_get_by_host() helper
Message-ID: <20200110123127.GA6558@infradead.org>
References: <20200106181117.GA16248@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200106181117.GA16248@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: YTHZDJZIV6C7XQD6VRHPE73W25NXJTOU
X-Message-ID-Hash: YTHZDJZIV6C7XQD6VRHPE73W25NXJTOU
X-MailFrom: BATV+524c891bdf23d94d05f7+5983+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YTHZDJZIV6C7XQD6VRHPE73W25NXJTOU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 06, 2020 at 01:11:17PM -0500, Vivek Goyal wrote:
> Looks like nobody is using fs_dax_get_by_host() except fs_dax_get_by_bdev()
> and it can easily use dax_get_by_host() instead.
> 
> IIUC, fs_dax_get_by_host() was only introduced so that one could compile
> with CONFIG_FS_DAX=n and CONFIG_DAX=m. fs_dax_get_by_bdev() achieves
> the same purpose and hence it looks like fs_dax_get_by_host() is not
> needed anymore.
>  
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
