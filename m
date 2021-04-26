Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC15636BBCB
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Apr 2021 00:48:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC2FB100EBB75;
	Mon, 26 Apr 2021 15:48:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E7045100EC1CE
	for <linux-nvdimm@lists.01.org>; Mon, 26 Apr 2021 15:48:04 -0700 (PDT)
IronPort-SDR: d+jiBqedjRY7R/mekLbBc067PCLuUsMgBJI9uuTC7QLWGt+uH1CVEFhbSdaC+MIqivMgGpWkrY
 f3n5l23nfZvA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="175898558"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400";
   d="scan'208";a="175898558"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 15:48:04 -0700
IronPort-SDR: 0OoBkbV+1Ox6DgCJsz3p8pRg6Qh4Z7QgEJFLV0iN/+erqAfcNG7xRSGc7htjfewXeCRxv2MdCY
 48Pnrx+6JMhw==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400";
   d="scan'208";a="429568748"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 15:48:03 -0700
Date: Mon, 26 Apr 2021 15:48:03 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v2 1/3] fsdax: Factor helpers to simplify dax fault code
Message-ID: <20210426224803.GR1904484@iweiny-DESK2.sc.intel.com>
References: <20210407133823.828176-1-ruansy.fnst@fujitsu.com>
 <20210407133823.828176-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407133823.828176-2-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: K5STEQB4YABP6OJT753VY7GL2227R2F7
X-Message-ID-Hash: K5STEQB4YABP6OJT753VY7GL2227R2F7
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K5STEQB4YABP6OJT753VY7GL2227R2F7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 07, 2021 at 09:38:21PM +0800, Shiyang Ruan wrote:
> The dax page fault code is too long and a bit difficult to read. And it
> is hard to understand when we trying to add new features. Some of the
> PTE/PMD codes have similar logic. So, factor them as helper functions to
> simplify the code.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/dax.c | 153 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 84 insertions(+), 69 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index b3d27fdc6775..f843fb8fbbf1 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c

[snip]

> @@ -1355,19 +1379,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
>  						 0, write && !sync);
>  
> -		/*
> -		 * If we are doing synchronous page fault and inode needs fsync,
> -		 * we can insert PTE into page tables only after that happens.
> -		 * Skip insertion for now and return the pfn so that caller can
> -		 * insert it after fsync is done.
> -		 */
>  		if (sync) {
> -			if (WARN_ON_ONCE(!pfnp)) {
> -				error = -EIO;
> -				goto error_finish_iomap;
> -			}
> -			*pfnp = pfn;
> -			ret = VM_FAULT_NEEDDSYNC | major;
> +			ret = dax_fault_synchronous_pfnp(pfnp, pfn);

Is there a reason VM_FAULT_MAJOR should be left out here?

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
