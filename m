Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D90D15BDC3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Feb 2020 12:37:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 075EC10FC33E6;
	Thu, 13 Feb 2020 03:41:15 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1DA8F10FC33E5
	for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 03:41:13 -0800 (PST)
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
	by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1j2CoR-0008Dp-Bg; Thu, 13 Feb 2020 12:37:43 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
	id E2B141013A6; Thu, 13 Feb 2020 12:37:42 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dan Williams <dan.j.williams@intel.com>, mingo@redhat.com
Subject: Re: [PATCH v4 5/6] x86/numa: Provide a range-to-target_node lookup facility
In-Reply-To: <157966230092.2508551.3905721944859436879.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com> <157966230092.2508551.3905721944859436879.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Thu, 13 Feb 2020 12:37:42 +0100
Message-ID: <874kvu3egp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: NXO4WOX45QDECEQM2QJXLVOCFKLZBXAX
X-Message-ID-Hash: NXO4WOX45QDECEQM2QJXLVOCFKLZBXAX
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, kbuild test robot <lkp@intel.com>, hch@lst.de, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NXO4WOX45QDECEQM2QJXLVOCFKLZBXAX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:
> +/**
> + * numa_move_memblk - Move one numa_memblk from one numa_meminfo to another
> + * @dst: numa_meminfo to move block to
> + * @idx: Index of memblk to remove
> + * @src: numa_meminfo to remove memblk from
> + *
> + * If @dst is non-NULL add it at the @dst->nr_blks index and increment
> + * @dst->nr_blks, then remove it from @src.

This is not correct. It's suggesting that these operations are only
happening when @dst is non-NULL. Remove is unconditional though.

Also this is called with &numa_reserved_meminfo as @dst argument, which is:

> +static struct numa_meminfo numa_reserved_meminfo __initdata_numa;

So how would @dst ever be NULL?
 
> + */
> +static void __init numa_move_memblk(struct numa_meminfo *dst, int idx,
> +		struct numa_meminfo *src)
> +{
> +	if (dst) {
> +		memcpy(&dst->blk[dst->nr_blks], &src->blk[idx],
> +				sizeof(struct numa_memblk));
> +		dst->nr_blks++;
> +	}
> +	numa_remove_memblk_from(idx, src);
> +}

...

> -		/* make sure all blocks are inside the limits */
> +		/* move / save reserved memory ranges */
> +		if (!memblock_overlaps_region(&memblock.memory,
> +					bi->start, bi->end - bi->start)) {
> +			numa_move_memblk(&numa_reserved_meminfo, i--, mi);

Thanks,

        tglx
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
