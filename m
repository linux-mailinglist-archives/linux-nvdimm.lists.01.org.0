Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 750DE25C622
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Sep 2020 18:06:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1257D126B3ED5;
	Thu,  3 Sep 2020 09:06:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1A764139F60E7
	for <linux-nvdimm@lists.01.org>; Thu,  3 Sep 2020 09:06:09 -0700 (PDT)
IronPort-SDR: H136Ui6qaOJU2hmgd8Y/y3aI1uW7D8ljCdYIBQFkoBxiXEcuU90L0svFFWfwFSyItiIN7JTHBE
 8gVB5ZcBAO2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="221819668"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600";
   d="scan'208";a="221819668"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 09:06:09 -0700
IronPort-SDR: z1gjdGA9MAKoCWyApsGlxTYzXecXmk3TxjxKu0Ur/4UxT/z3/PJMSuI3W5A0oAjmK10ZXzovxd
 WZuiP/MFZ8Wg==
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600";
   d="scan'208";a="478099625"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 09:06:09 -0700
Date: Thu, 3 Sep 2020 09:06:08 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Coly Li <colyli@suse.de>
Subject: Re: [PATCH] dax: fix for do not print error message for
 non-persistent memory block device
Message-ID: <20200903160608.GU878166@iweiny-DESK2.sc.intel.com>
References: <20200903115549.17845-1-colyli@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200903115549.17845-1-colyli@suse.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 7E2X6UGX5RQ2ISGYNAF66VLY5BKBFI4M
X-Message-ID-Hash: 7E2X6UGX5RQ2ISGYNAF66VLY5BKBFI4M
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, dm-devel@redhat.com, Adrian Huang <ahuang12@lenovo.com>, Jan Kara <jack@suse.com>, Mike Snitzer <snitzer@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7E2X6UGX5RQ2ISGYNAF66VLY5BKBFI4M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 03, 2020 at 07:55:49PM +0800, Coly Li wrote:
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
> 
> 
> Fixes: c2affe920b0e ("dax: do not print error message for non-persistent memory block device")
> Signed-off-by: Coly Li <colyli@suse.de>

I hate to do this because I realize this is a bug which people really need
fixed.

However, shouldn't we also check (!dax_dev || !bdev_dax_supported()) as the
_first_ check in __generic_fsdax_supported()?

It seems like the other pr_info's could also be called when DAX is not
supported and we probably don't want them to be?

Perhaps that should be a follow on patch though.  So...

As a direct fix to c2affe920b0e

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Cc: Adrian Huang <ahuang12@lenovo.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jan Kara <jack@suse.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> ---
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
