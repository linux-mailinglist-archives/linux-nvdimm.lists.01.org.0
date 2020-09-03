Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 381C325C602
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Sep 2020 18:00:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5F45713A1CFAA;
	Thu,  3 Sep 2020 09:00:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=msnitzer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 51A9D13A1CFA8
	for <linux-nvdimm@lists.01.org>; Thu,  3 Sep 2020 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1599148813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/4Xsunww6H4JCi0h2bUx1iXMO4WLbL8+oemhL6HE4pA=;
	b=HBVFtnxyMcBG40yNm5MSt7JCqIdo6xDj0M+ggVvKxF12ltara7By0neor4HoPVjla35aVv
	nWQl+OR+l4XNU81ek54q1cg3s8Sz8P0oygLz3R4Dm72MVhCshocL/2mqz16gC/Xy5ixjKb
	SVvjkPnj68UA70V2087X27w/7MvPEfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-QRNTW324NtaqNtj3MNXLwQ-1; Thu, 03 Sep 2020 12:00:11 -0400
X-MC-Unique: QRNTW324NtaqNtj3MNXLwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B5D318B9F49;
	Thu,  3 Sep 2020 16:00:09 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D725819D7D;
	Thu,  3 Sep 2020 16:00:05 +0000 (UTC)
Date: Thu, 3 Sep 2020 12:00:05 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Coly Li <colyli@suse.de>
Subject: Re: [PATCH v2] dax: fix for do not print error message for
 non-persistent memory block device
Message-ID: <20200903160005.GA11871@redhat.com>
References: <20200903152839.19040-1-colyli@suse.de>
MIME-Version: 1.0
In-Reply-To: <20200903152839.19040-1-colyli@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Message-ID-Hash: ECEU7Z235YRN77WSWEPGP6PF6FXEAA4N
X-Message-ID-Hash: ECEU7Z235YRN77WSWEPGP6PF6FXEAA4N
X-MailFrom: msnitzer@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, dm-devel@redhat.com, Adrian Huang <ahuang12@lenovo.com>, Jan Kara <jack@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ECEU7Z235YRN77WSWEPGP6PF6FXEAA4N/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 03 2020 at 11:28am -0400,
Coly Li <colyli@suse.de> wrote:

> When calling __generic_fsdax_supported(), a dax-unsupported device may
> not have dax_dev as NULL, e.g. the dax related code block is not enabled
> by Kconfig.
> 
> Therefore in __generic_fsdax_supported(), to check whether a device
> supports DAX or not, the following order should be performed,
> - If dax_dev pointer is NULL, it means the device driver explicitly
>   announce it doesn't support DAX. Then it is OK to directly return
>   false from __generic_fsdax_supported().
> - If dax_dev pointer is NOT NULL, it might be because the driver doesn't
>   support DAX and not explicitly initialize related data structure. Then
>   bdev_dax_supported() should be called for further check.
> 
> IMHO if device driver desn't explicitly set its dax_dev pointer to NULL,
> this is not a bug. Calling bdev_dax_supported() makes sure they can be
> recognized as dax-unsupported eventually.
> 
> This patch does the following change for the above purpose,
>     -       if (!dax_dev && !bdev_dax_supported(bdev, blocksize)) {
>     +       if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {

Don't think I've ever seen a one-liner fix document the diff in its
patch header.  Really no need for that.

> Fixes: c2affe920b0e ("dax: do not print error message for non-persistent memory block device")
> Signed-off-by: Coly Li <colyli@suse.de>
> Reviewed-and-Tested-by: Adrian Huang <ahuang12@lenovo.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jan Kara <jack@suse.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>

Thanks for fixing this,

Reviewed-by: Mike Snitzer <snitzer@redhat.com>


> ---
> Changelog:
> v2: add Reviewed-and-Tested-by from Adrian Huang.
> v1: initial version.
> 
>  drivers/dax/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 32642634c1bb..e5767c83ea23 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -100,7 +100,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
>  		return false;
>  	}
>  
> -	if (!dax_dev && !bdev_dax_supported(bdev, blocksize)) {
> +	if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {
>  		pr_debug("%s: error: dax unsupported by block device\n",
>  				bdevname(bdev, buf));
>  		return false;
> -- 
> 2.26.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
