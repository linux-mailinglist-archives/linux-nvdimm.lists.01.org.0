Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A78153966
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 21:04:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0E07110FC33FB;
	Wed,  5 Feb 2020 12:07:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3CC0410FC33F8
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 12:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1580933074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1jb9TeXcL+mLndWBR1WKFjkYUCNYgUFm6/IdT2uVWM=;
	b=R6msnIu5n+yjocTa1FovjtMTgosS06LZGAYft1H9jxOAQy1wjjq5h6hjOw3vAQrZ8HC8t+
	1cJrNmkdvX8Km07jkMqEEgbSGc82LIFl3ssWgo5cSgd2yk+nZJXthBxIpIljay4+3yWc+z
	Mg23Z1PJafQ2tRV0eQM+EOT9PW4SvgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-IieA2SHXP2Cyliv94B-pXA-1; Wed, 05 Feb 2020 15:04:29 -0500
X-MC-Unique: IieA2SHXP2Cyliv94B-pXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 988C7107B270;
	Wed,  5 Feb 2020 20:04:28 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 13E1284DB8;
	Wed,  5 Feb 2020 20:04:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id A44F22202E9; Wed,  5 Feb 2020 15:04:25 -0500 (EST)
Date: Wed, 5 Feb 2020 15:04:25 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/5] s390,dax: Add dax zero_page_range operation to
 dcssblk driver
Message-ID: <20200205200425.GF14544@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-3-vgoyal@redhat.com>
 <20200205183205.GB26711@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200205183205.GB26711@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: UXQKW7V656RLZP5SSZWK2EUUCWNX6XW3
X-Message-ID-Hash: UXQKW7V656RLZP5SSZWK2EUUCWNX6XW3
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UXQKW7V656RLZP5SSZWK2EUUCWNX6XW3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 05, 2020 at 10:32:05AM -0800, Christoph Hellwig wrote:
> > diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> > index 63502ca537eb..f6709200bcd0 100644
> > --- a/drivers/s390/block/dcssblk.c
> > +++ b/drivers/s390/block/dcssblk.c
> > @@ -62,6 +62,7 @@ static const struct dax_operations dcssblk_dax_ops = {
> >  	.dax_supported = generic_fsdax_supported,
> >  	.copy_from_iter = dcssblk_dax_copy_from_iter,
> >  	.copy_to_iter = dcssblk_dax_copy_to_iter,
> > +	.zero_page_range = dcssblk_dax_zero_page_range,
> >  };
> >  
> >  struct dcssblk_dev_info {
> > @@ -941,6 +942,12 @@ dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> >  	return __dcssblk_direct_access(dev_info, pgoff, nr_pages, kaddr, pfn);
> >  }
> >  
> > +static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,pgoff_t pgoff,
> > +				       unsigned offset, size_t len)
> > +{
> > +	return generic_dax_zero_page_range(dax_dev, pgoff, offset, len);
> > +}
> 
> Wouldn't this need a forward declaration?  Then again given that dcssblk
> is the only caller of generic_dax_zero_page_range we might as well merge
> the two.  If you want to keep the generic one it could be wired up to
> dcssblk_dax_ops directly, though.

Given dcssblk is the only user, I am inclined to get rid of genric
version. We can add one later if another user shows up.

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
