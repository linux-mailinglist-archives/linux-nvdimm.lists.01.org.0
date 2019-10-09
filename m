Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B618D073E
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Oct 2019 08:31:49 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E425E10FC6F06;
	Tue,  8 Oct 2019 23:34:12 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+f63ded96593ba29bc59d+5890+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E6E3910FC6F05
	for <linux-nvdimm@lists.01.org>; Tue,  8 Oct 2019 23:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=8EvJWeGlkis4V2qIrGZdCq8ITBADZ0WXtWxnOLtuFGc=; b=C9FuX4qvjvy4ms/l5dezaCgWE
	D90I0HKSpMbtznxYLCsHSjqrHs2J/MkxPIYVYyX6kwEf0OrcwIbT/Sx1DH6pVAnrXYSnK0FmCR3j7
	Z4petnP2+b93gL/dw8bLlqDNEVkEO7Q0utY6Q4Htm0fOEcHQcIKmB5jRi0BROdB87VX1wplpBEiLB
	epblpnpy35u27Tokbyn1wtomolNlbxxZltrtlhQwOQP6cd8kbnrCQpslH9Uo8A6rPPh26ZyPjT9pf
	a8p0zyqwI7Hed+GDLTLw6QaNwS9mX2s3omcgw/10Yf5nZl7LTpjteApAupK6H4Qgcx2tqT/QMkyDC
	U35ZF3mVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iI5Vg-0002v9-Dc; Wed, 09 Oct 2019 06:31:44 +0000
Date: Tue, 8 Oct 2019 23:31:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [RFC PATCH 0/7] xfs: add reflink & dedupe support for fsdax.
Message-ID: <20191009063144.GA4300@infradead.org>
References: <20190731114935.11030-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190731114935.11030-1-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: FPU3IC3ZCCZR75WX7ZIDTUZTJ3T62V2R
X-Message-ID-Hash: FPU3IC3ZCCZR75WX7ZIDTUZTJ3T62V2R
X-MailFrom: BATV+f63ded96593ba29bc59d+5890+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, darrick.wong@oracle.com, linux-kernel@vger.kernel.org, rgoldwyn@suse.de, gujx@cn.fujitsu.com, david@fromorbit.com, qi.fuli@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FPU3IC3ZCCZR75WX7ZIDTUZTJ3T62V2R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Btw, I just had a chat with Dan last week on this.  And he pointed out
that while this series deals with the read/write path issues of 
reflink on DAX it doesn't deal with the mmap side issue that
page->mapping and page->index can point back to exactly one file.

I think we want a few xfstests that reflink a file and then use the
different links using mmap, as that should blow up pretty reliably.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
