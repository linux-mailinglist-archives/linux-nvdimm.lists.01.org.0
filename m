Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E132D23F385
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Aug 2020 22:05:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E2A6F12BC1B18;
	Fri,  7 Aug 2020 13:05:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A296812BAA74A
	for <linux-nvdimm@lists.01.org>; Fri,  7 Aug 2020 13:05:38 -0700 (PDT)
IronPort-SDR: ElajurXxYs4aPV2l+fix8OiSrtgdek5DiNqwQjYwhH7MlheUcd6oV3UJFt+JOUUlvEnNTo9L8O
 xq8ugne427QA==
X-IronPort-AV: E=McAfee;i="6000,8403,9706"; a="132738286"
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800";
   d="scan'208";a="132738286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 13:05:38 -0700
IronPort-SDR: iN9afJV0a8iKNGDrKwlY/zfIRTfZOsKW1t/FEpub7fHuyHY/ALiRqNmEgG/cOqSeiy78Jgvoay
 show9POj62vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800";
   d="scan'208";a="275462904"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 07 Aug 2020 13:05:38 -0700
Date: Fri, 7 Aug 2020 13:05:38 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 33/38] virtio_pmem: convert to LE accessors
Message-ID: <20200807200537.GD2467625@iweiny-DESK2.sc.intel.com>
References: <20200805134226.1106164-1-mst@redhat.com>
 <20200805134226.1106164-34-mst@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-34-mst@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: 7OFGOFFZB3Q5FYMYAIVA4WDWRRMGP55C
X-Message-ID-Hash: 7OFGOFFZB3Q5FYMYAIVA4WDWRRMGP55C
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7OFGOFFZB3Q5FYMYAIVA4WDWRRMGP55C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 05, 2020 at 09:44:45AM -0400, Michael S. Tsirkin wrote:
> Virtio pmem is modern-only. Use LE accessors for config space.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/nvdimm/virtio_pmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 5e3d07b47e0c..726c7354d465 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -58,9 +58,9 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>  		goto out_err;
>  	}
>  
> -	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> +	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
>  			start, &vpmem->start);
> -	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
> +	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
>  			size, &vpmem->size);

FWIW I think squashing patch 15/38 and this patch would have made more sense.

Acked-by: Ira Weiny <ira.weiny@intel.com>

>  
>  	res.start = vpmem->start;
> -- 
> MST
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
