Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA2B26C414
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 17:22:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BE61014518B2D;
	Wed, 16 Sep 2020 08:22:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=msnitzer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2F60214518B2C
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600269731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cjF2GTwA7gL/I5MK7tLcOog/hAPgLrIkOT7IjuYm6qc=;
	b=IOdVATpa3VhZUzDoVOzj0VDK53uTLDeo7JkC4oBlifPAWua6wRiSv7KMv6u73sgy/+/UAb
	6g7h32KIG9VNvK54xYvYtrmmf42BbHjY4guXJLBjBHb1KciHUG8bw0CwuLB833md2p5MXQ
	YGXictn1FqZg3befLMRXK7DM0T/7GwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-eYS53MYtPuGnamtd7H2f7w-1; Wed, 16 Sep 2020 11:22:07 -0400
X-MC-Unique: eYS53MYtPuGnamtd7H2f7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 302BB186DD2A;
	Wed, 16 Sep 2020 15:22:06 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DB4B51002D60;
	Wed, 16 Sep 2020 15:22:05 +0000 (UTC)
Date: Wed, 16 Sep 2020 11:22:05 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: dm: Call proper helper to determine dax support
Message-ID: <20200916152204.GA29829@redhat.com>
References: <20200916151445.450-1-jack@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20200916151445.450-1-jack@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Message-ID-Hash: PL6WJ3U2VTVVD7HOANRMQZNZX2GDJCOF
X-Message-ID-Hash: PL6WJ3U2VTVVD7HOANRMQZNZX2GDJCOF
X-MailFrom: msnitzer@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Adrian Huang <adrianhuang0701@gmail.com>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PL6WJ3U2VTVVD7HOANRMQZNZX2GDJCOF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 16 2020 at 11:14am -0400,
Jan Kara <jack@suse.cz> wrote:

> DM was calling generic_fsdax_supported() to determine whether a device
> referenced in the DM table supports DAX. However this is a helper for "leaf" device drivers so that
> they don't have to duplicate common generic checks. High level code
> should call dax_supported() helper which that calls into appropriate
> helper for the particular device. This problem manifested itself as
> kernel messages:
> 
> dm-3: error: dax access failed (-95)
> 
> when lvm2-testsuite run in cases where a DM device was stacked on top of
> another DM device.
> 
> Fixes: 7bf7eac8d648 ("dax: Arrange for dax_supported check to span multiple devices")
> Tested-by: Adrian Huang <ahuang12@lenovo.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Looked good:

Acked-by: Mike Snitzer <snitzer@redhat.com>

This fix should Cc stable@ right?

> ---
>  drivers/dax/super.c   |  4 ++++
>  drivers/md/dm-table.c |  3 +--
>  include/linux/dax.h   | 11 +++++++++--
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> This patch should go in together with Adrian's
> https://lore.kernel.org/linux-nvdimm/20200916133923.31-1-adrianhuang0701@gmail.com

Sure, but there really isn't a dependency right?

Dan, will you be picking these up to send to Linux for 5.9-rc?

Thanks,
Mike


> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index e5767c83ea23..b6284c5cae0a 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -325,11 +325,15 @@ EXPORT_SYMBOL_GPL(dax_direct_access);
>  bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
>  		int blocksize, sector_t start, sector_t len)
>  {
> +	if (!dax_dev)
> +		return false;
> +
>  	if (!dax_alive(dax_dev))
>  		return false;
>  
>  	return dax_dev->ops->dax_supported(dax_dev, bdev, blocksize, start, len);
>  }
> +EXPORT_SYMBOL_GPL(dax_supported);
>  
>  size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>  		size_t bytes, struct iov_iter *i)
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 5edc3079e7c1..bed1ff0744ec 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -862,8 +862,7 @@ int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
>  {
>  	int blocksize = *(int *) data;
>  
> -	return generic_fsdax_supported(dev->dax_dev, dev->bdev, blocksize,
> -				       start, len);
> +	return dax_supported(dev->dax_dev, dev->bdev, blocksize, start, len);
>  }
>  
>  /* Check devices support synchronous DAX */
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 6904d4e0b2e0..9f916326814a 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -130,6 +130,8 @@ static inline bool generic_fsdax_supported(struct dax_device *dax_dev,
>  	return __generic_fsdax_supported(dax_dev, bdev, blocksize, start,
>  			sectors);
>  }
> +bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
> +		int blocksize, sector_t start, sector_t len);
>  
>  static inline void fs_put_dax(struct dax_device *dax_dev)
>  {
> @@ -157,6 +159,13 @@ static inline bool generic_fsdax_supported(struct dax_device *dax_dev,
>  	return false;
>  }
>  
> +static inline bool dax_supported(struct dax_device *dax_dev,
> +		struct block_device *bdev, int blocksize, sector_t start,
> +		sector_t len)
> +{
> +	return false;
> +}
> +
>  static inline void fs_put_dax(struct dax_device *dax_dev)
>  {
>  }
> @@ -195,8 +204,6 @@ bool dax_alive(struct dax_device *dax_dev);
>  void *dax_get_private(struct dax_device *dax_dev);
>  long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
>  		void **kaddr, pfn_t *pfn);
> -bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
> -		int blocksize, sector_t start, sector_t len);
>  size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>  		size_t bytes, struct iov_iter *i);
>  size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
> -- 
> 2.16.4
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
