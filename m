Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EA518016E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Mar 2020 16:19:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ACF2410FC361A;
	Tue, 10 Mar 2020 08:20:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 886D110FC33E8
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 08:19:59 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 08:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400";
   d="scan'208";a="234378139"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 10 Mar 2020 08:19:07 -0700
Date: Tue, 10 Mar 2020 08:19:07 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 02/20] dax: Create a range version of
 dax_layout_busy_page()
Message-ID: <20200310151906.GA670549@iweiny-DESK2.sc.intel.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200304165845.3081-3-vgoyal@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: RTY7EZIQCUXKRA6ODGLEFLI3TBC5JZLS
X-Message-ID-Hash: RTY7EZIQCUXKRA6ODGLEFLI3TBC5JZLS
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RTY7EZIQCUXKRA6ODGLEFLI3TBC5JZLS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 04, 2020 at 11:58:27AM -0500, Vivek Goyal wrote:
>  
> +	/* If end == 0, all pages from start to till end of file */
> +	if (!end) {
> +		end_idx = ULONG_MAX;
> +		len = 0;

I find this a bit odd to specify end == 0 for ULONG_MAX...

>  }
> +EXPORT_SYMBOL_GPL(dax_layout_busy_page_range);
> +
> +/**
> + * dax_layout_busy_page - find first pinned page in @mapping
> + * @mapping: address space to scan for a page with ref count > 1
> + *
> + * DAX requires ZONE_DEVICE mapped pages. These pages are never
> + * 'onlined' to the page allocator so they are considered idle when
> + * page->count == 1. A filesystem uses this interface to determine if
> + * any page in the mapping is busy, i.e. for DMA, or other
> + * get_user_pages() usages.
> + *
> + * It is expected that the filesystem is holding locks to block the
> + * establishment of new mappings in this address_space. I.e. it expects
> + * to be able to run unmap_mapping_range() and subsequently not race
> + * mapping_mapped() becoming true.
> + */
> +struct page *dax_layout_busy_page(struct address_space *mapping)
> +{
> +	return dax_layout_busy_page_range(mapping, 0, 0);

... other functions I have seen specify ULONG_MAX here.  Which IMO makes this
call site more clear.

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
