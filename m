Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E41720D001
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 18:09:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B644111B33D1;
	Mon, 29 Jun 2020 09:09:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 93AE3100A4626
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 09:09:43 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id CD266ACDB;
	Mon, 29 Jun 2020 16:09:41 +0000 (UTC)
Date: Mon, 29 Jun 2020 18:09:40 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v6 6/8] powerpc/pmem: Avoid the barrier in flush routines
Message-ID: <20200629160940.GU21462@kitsune.suse.cz>
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
 <20200629135722.73558-7-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200629135722.73558-7-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 3J2IIVSYENNVF2PFZAWBRJL6HK4NXXRU
X-Message-ID-Hash: 3J2IIVSYENNVF2PFZAWBRJL6HK4NXXRU
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-nvdimm@lists.01.org, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3J2IIVSYENNVF2PFZAWBRJL6HK4NXXRU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Mon, Jun 29, 2020 at 07:27:20PM +0530, Aneesh Kumar K.V wrote:
> nvdimm expect the flush routines to just mark the cache clean. The barrier
> that mark the store globally visible is done in nvdimm_flush().
> 
> Update the papr_scm driver to a simplified nvdim_flush callback that do
> only the required barrier.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/lib/pmem.c                   |  6 ------
>  arch/powerpc/platforms/pseries/papr_scm.c | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
> index 5a61aaeb6930..21210fa676e5 100644
> --- a/arch/powerpc/lib/pmem.c
> +++ b/arch/powerpc/lib/pmem.c
> @@ -19,9 +19,6 @@ static inline void __clean_pmem_range(unsigned long start, unsigned long stop)
>  
>  	for (i = 0; i < size >> shift; i++, addr += bytes)
>  		asm volatile(PPC_DCBSTPS(%0, %1): :"i"(0), "r"(addr): "memory");
> -
> -
> -	asm volatile(PPC_PHWSYNC ::: "memory");
>  }
>  
>  static inline void __flush_pmem_range(unsigned long start, unsigned long stop)
> @@ -34,9 +31,6 @@ static inline void __flush_pmem_range(unsigned long start, unsigned long stop)
>  
>  	for (i = 0; i < size >> shift; i++, addr += bytes)
>  		asm volatile(PPC_DCBFPS(%0, %1): :"i"(0), "r"(addr): "memory");
> -
> -
> -	asm volatile(PPC_PHWSYNC ::: "memory");
>  }
>  
>  static inline void clean_pmem_range(unsigned long start, unsigned long stop)
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 9c569078a09f..9a9a0766f8b6 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -630,6 +630,18 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
>  
>  	return 0;
>  }
> +/*
> + * We have made sure the pmem writes are done such that before calling this
> + * all the caches are flushed/clean. We use dcbf/dcbfps to ensure this. Here
> + * we just need to add the necessary barrier to make sure the above flushes
> + * are have updated persistent storage before any data access or data transfer
> + * caused by subsequent instructions is initiated.
> + */
> +static int papr_scm_flush_sync(struct nd_region *nd_region, struct bio *bio)
> +{
> +	arch_pmem_flush_barrier();
> +	return 0;
> +}
>  
>  static ssize_t flags_show(struct device *dev,
>  			  struct device_attribute *attr, char *buf)
> @@ -743,6 +755,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  	ndr_desc.mapping = &mapping;
>  	ndr_desc.num_mappings = 1;
>  	ndr_desc.nd_set = &p->nd_set;
> +	ndr_desc.flush = papr_scm_flush_sync;

AFAICT currently the only device that implements flush is virtio_pmem.
How does the nfit driver get away without implementing flush?
Also the flush takes arguments that are completely unused but a user of
the pmem region must assume they are used, and call flush() on the
region rather than arch_pmem_flush_barrier() directly.  This may not
work well with md as discussed with earlier iteration of the patchest.

Thanks

Michal
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
