Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 565C5153971
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 21:16:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B39210FC33FA;
	Wed,  5 Feb 2020 12:19:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8732910FC33FA
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 12:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1580933764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBo9DQfjyQsmash9SqN2EqoK/zg+EtLGHPHtcOK8vGE=;
	b=hA5Nm/G4kfyrl02XzLbcPbXhsylNF9fo/6V2UE326fl2RDdyENOHvhinfzScQjBq1iU6Bk
	Ri94IorPgh6KHZamMrAiV+OkBKYzLI2hU8d+YxJudJBSlCvEOBvDqi1kXJjbBUkOUUwFIQ
	A/XPLL6cN9KZVz0KE5a3oUK9kohXjyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-dsbORKesME6VsCwfyKBLlA-1; Wed, 05 Feb 2020 15:16:02 -0500
X-MC-Unique: dsbORKesME6VsCwfyKBLlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E57AD8018A5;
	Wed,  5 Feb 2020 20:16:00 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3E70F10013A1;
	Wed,  5 Feb 2020 20:15:58 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id CD4472202E9; Wed,  5 Feb 2020 15:15:57 -0500 (EST)
Date: Wed, 5 Feb 2020 15:15:57 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/5] dax,iomap: Add helper dax_iomap_zero() to zero a
 range
Message-ID: <20200205201557.GH14544@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-6-vgoyal@redhat.com>
 <20200205183609.GE26711@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200205183609.GE26711@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: 6J4QGPUSG63C2ESFG4YFHIZN4MGEXE57
X-Message-ID-Hash: 6J4QGPUSG63C2ESFG4YFHIZN4MGEXE57
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6J4QGPUSG63C2ESFG4YFHIZN4MGEXE57/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 05, 2020 at 10:36:09AM -0800, Christoph Hellwig wrote:
> > +int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
> > +			      struct iomap *iomap)
> >  {
> >  	pgoff_t pgoff;
> >  	long rc, id;
> > +	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
> >  
> > -	rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
> > +	rc = bdev_dax_pgoff(iomap->bdev, sector, PAGE_SIZE, &pgoff);
> >  	if (rc)
> >  		return rc;
> >  
> >  	id = dax_read_lock();
> > -	rc = dax_zero_page_range(dax_dev, pgoff, offset, size);
> > +	rc = dax_zero_page_range(iomap->dax_dev, pgoff, offset, size);
> >  	dax_read_unlock(id);
> >  	return rc;
> >  }
> > -EXPORT_SYMBOL_GPL(__dax_zero_page_range);
> > +EXPORT_SYMBOL_GPL(dax_iomap_zero);
> 
> This function is only used by fs/iomap/buffered-io.c, so no need to
> export it.

Will do.

> 
> >  #ifdef CONFIG_FS_DAX
> > -int __dax_zero_page_range(struct block_device *bdev,
> > -		struct dax_device *dax_dev, sector_t sector,
> > -		unsigned int offset, unsigned int length);
> > +int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
> > +			      struct iomap *iomap);
> >  #else
> > -static inline int __dax_zero_page_range(struct block_device *bdev,
> > -		struct dax_device *dax_dev, sector_t sector,
> > -		unsigned int offset, unsigned int length)
> > +static inline int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
> > +				 struct iomap *iomap)
> >  {
> >  	return -ENXIO;
> >  }
> 
> Given that the only caller is under an IS_DAX() check you could just
> declare the function unconditionally and let the compiler optimize
> away the guaranteed dead call for the !CONFIG_FS_DAX case, like we
> do with various other functions.

Sure, will do.

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
