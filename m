Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC3F21D02F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 09:04:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1E2B1116E755C;
	Mon, 13 Jul 2020 00:04:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9990B100A859B
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 00:04:42 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06D72kwV192803;
	Mon, 13 Jul 2020 03:04:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 3277k8b6je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2020 03:04:32 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06D73Eo4195049;
	Mon, 13 Jul 2020 03:04:31 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0b-001b2d01.pphosted.com with ESMTP id 3277k8b6hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2020 03:04:31 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06D71ptl000335;
	Mon, 13 Jul 2020 07:04:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma02fra.de.ibm.com with ESMTP id 327527swte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2020 07:04:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06D73CKd63242314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2020 07:03:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53897AE057;
	Mon, 13 Jul 2020 07:03:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D68F3AE053;
	Mon, 13 Jul 2020 07:03:07 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.203.145])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Mon, 13 Jul 2020 07:03:07 +0000 (GMT)
Date: Mon, 13 Jul 2020 10:03:04 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 08/22] memblock: Introduce a generic
 phys_addr_to_target_node()
Message-ID: <20200713070304.GC11000@linux.ibm.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159457120893.754248.7783260004248722175.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <159457120893.754248.7783260004248722175.stgit@dwillia2-desk3.amr.corp.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_04:2020-07-10,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 phishscore=0
 spamscore=0 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130049
Message-ID-Hash: 4FVWJP4L6QK6KJUR643KC542LI5YCGFX
X-Message-ID-Hash: 4FVWJP4L6QK6KJUR643KC542LI5YCGFX
X-MailFrom: rppt@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Jia He <justin.he@arm.com>, Will Deacon <will@kernel.org>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hch@lst.de, joao.m.martins@oracle.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4FVWJP4L6QK6KJUR643KC542LI5YCGFX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

On Sun, Jul 12, 2020 at 09:26:48AM -0700, Dan Williams wrote:
> Similar to how generic memory_add_physaddr_to_nid() interrogates
> memblock data for numa information, introduce
> get_reserved_pfn_range_from_nid() to enable the same operation for
> reserved memory ranges. Example memory ranges that are reserved, but
> still have associated numa-info are persistent memory or Soft Reserved
> (EFI_MEMORY_SP) memory.

Here again, I would prefer to add a weak default for
phys_to_target_node() because the "generic" implementation is not really
generic.

The fallback to reserved ranges is x86 specfic because on x86 most of the
reserved areas is not in memblock.memory. AFAIK, no other architecture
does this.

And x86 anyway has implementation of phys_to_target_node().

> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Jia He <justin.he@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/memblock.h |    4 +++
>  include/linux/mm.h       |    2 +
>  include/linux/numa.h     |    2 +
>  mm/memblock.c            |   22 ++++++++++++++--
>  mm/page_alloc.c          |   63 +++++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 87 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 017fae833d4a..0655e8376c72 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -234,6 +234,10 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
>  	for (i = -1, __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid); \
>  	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
>  
> +#define for_each_reserved_pfn_range(i, nid, p_start, p_end, p_nid)		\
> +	for (i = -1, __next_reserved_pfn_range(&i, nid, p_start, p_end, p_nid); \
> +	     i >= 0; __next_reserved_pfn_range(&i, nid, p_start, p_end, p_nid))
> +
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
>  				  unsigned long *out_spfn,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1e76ee5da20b..82dac9f42c46 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2438,6 +2438,8 @@ extern unsigned long absent_pages_in_range(unsigned long start_pfn,
>  
>  extern void get_pfn_range_for_nid(unsigned int nid,
>  			unsigned long *start_pfn, unsigned long *end_pfn);
> +extern void get_reserved_pfn_range_for_nid(unsigned int nid,
> +			unsigned long *start_pfn, unsigned long *end_pfn);
>  extern unsigned long find_min_pfn_with_active_regions(void);
>  extern void sparse_memory_present_with_active_regions(int nid);
>  
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index 5d25c5de1322..52b2430bc759 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -19,7 +19,7 @@ int numa_map_to_online_node(int node);
>  
>  /*
>   * Optional architecture specific implementation, users need a "depends
> - * on $ARCH"
> + * on $ARCH" or depends on CONFIG_MEMBLOCK_NUMA_INFO
>   */
>  int phys_to_target_node(phys_addr_t addr);
>  #else
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 39aceafc57f6..43c3abab705e 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1200,11 +1200,11 @@ void __init_memblock __next_mem_range_rev(u64 *idx, int nid,
>  /*
>   * Common iterator interface used to define for_each_mem_pfn_range().
>   */
> -void __init_memblock __next_mem_pfn_range(int *idx, int nid,
> +static void __init_memblock __next_memblock_pfn_range(int *idx, int nid,
>  				unsigned long *out_start_pfn,
> -				unsigned long *out_end_pfn, int *out_nid)
> +				unsigned long *out_end_pfn, int *out_nid,
> +				struct memblock_type *type)
>  {
> -	struct memblock_type *type = &memblock.memory;
>  	struct memblock_region *r;
>  	int r_nid;
>  
> @@ -1230,6 +1230,22 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
>  		*out_nid = r_nid;
>  }
>  
> +void __init_memblock __next_mem_pfn_range(int *idx, int nid,
> +				unsigned long *out_start_pfn,
> +				unsigned long *out_end_pfn, int *out_nid)
> +{
> +	__next_memblock_pfn_range(idx, nid, out_start_pfn, out_end_pfn, out_nid,
> +				  &memblock.memory);
> +}
> +
> +void __init_memblock __next_reserved_pfn_range(int *idx, int nid,
> +				unsigned long *out_start_pfn,
> +				unsigned long *out_end_pfn, int *out_nid)
> +{
> +	__next_memblock_pfn_range(idx, nid, out_start_pfn, out_end_pfn, out_nid,
> +				  &memblock.reserved);
> +}
> +
>  /**
>   * memblock_set_node - set node ID on memblock regions
>   * @base: base of area to set node ID for
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index df8bd169dbb4..94ad77c0c338 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6369,12 +6369,39 @@ void __init_or_memblock get_pfn_range_for_nid(unsigned int nid,
>  		*start_pfn = 0;
>  }
>  
> +/**
> + * get_reserved_pfn_range_for_nid - Return the start and end page frames for a node
> + * @nid: The nid to return the range for. If MAX_NUMNODES, the min and max PFN are returned.
> + * @start_pfn: Passed by reference. On return, it will have the node start_pfn.
> + * @end_pfn: Passed by reference. On return, it will have the node end_pfn.
> + *
> + * Mostly identical to get_pfn_range_for_nid() except it operates on
> + * reserved ranges rather than online memory.
> + */
> +void __init_or_memblock get_reserved_pfn_range_for_nid(unsigned int nid,
> +			unsigned long *start_pfn, unsigned long *end_pfn)
> +{
> +	unsigned long this_start_pfn, this_end_pfn;
> +	int i;
> +
> +	*start_pfn = -1UL;
> +	*end_pfn = 0;
> +
> +	for_each_mem_pfn_range(i, nid, &this_start_pfn, &this_end_pfn, NULL) {
> +		*start_pfn = min(*start_pfn, this_start_pfn);
> +		*end_pfn = max(*end_pfn, this_end_pfn);
> +	}
> +
> +	if (*start_pfn == -1UL)
> +		*start_pfn = 0;
> +}
> +
>  /*
>   * Generic implementation of memory_add_physaddr_to_nid() depends on
>   * architecture using memblock data for numa information.
>   */
>  #ifdef CONFIG_MEMBLOCK_NUMA_INFO
> -int __init_or_memblock memory_add_physaddr_to_nid(u64 addr)
> +static int __init_or_memblock __memory_add_physaddr_to_nid(u64 addr)
>  {
>  	unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
>  	int nid;
> @@ -6384,10 +6411,42 @@ int __init_or_memblock memory_add_physaddr_to_nid(u64 addr)
>  		if (pfn >= start_pfn && pfn <= end_pfn)
>  			return nid;
>  	}
> +	return NUMA_NO_NODE;
> +}
> +
> +int __init_or_memblock memory_add_physaddr_to_nid(u64 addr)
> +{
> +	int nid = __memory_add_physaddr_to_nid(addr);
> +
>  	/* Default to node0 as not all callers are prepared for this to fail */
> -	return 0;
> +	if (nid == NUMA_NO_NODE)
> +		return 0;
> +	return nid;
>  }
>  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> +
> +int __init_or_memblock phys_to_target_node(u64 addr)
> +{
> +	unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
> +	int nid = __memory_add_physaddr_to_nid(addr);
> +
> +	if (nid != NUMA_NO_NODE)
> +		return nid;
> +
> +	/*
> +	 * Search reserved memory ranges since the memory address does
> +	 * not appear to be online
> +	 */
> +	for_each_possible_node(nid) {
> +		if (node_online(nid))
> +			continue;
> +		get_reserved_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> +		if (pfn >= start_pfn && pfn <= end_pfn)
> +			return nid;
> +	}
> +	return NUMA_NO_NODE;
> +}
> +EXPORT_SYMBOL_GPL(phys_to_target_node);
>  #endif /* CONFIG_MEMBLOCK_NUMA_INFO */
>  
>  /*
> 

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
