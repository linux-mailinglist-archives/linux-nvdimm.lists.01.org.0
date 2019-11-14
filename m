Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D1CFC65F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Nov 2019 13:32:43 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0F963100DC3CD;
	Thu, 14 Nov 2019 04:34:13 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 71626100DC3CB
	for <linux-nvdimm@lists.01.org>; Thu, 14 Nov 2019 04:34:10 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 56E7C68B05; Thu, 14 Nov 2019 13:32:37 +0100 (CET)
Date: Thu, 14 Nov 2019 13:32:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] mm: Cleanup __put_devmap_managed_page() vs
 ->page_free()
Message-ID: <20191114123237.GA31940@lst.de>
References: <157371938291.3055029.12105459405251950438.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <157371938291.3055029.12105459405251950438.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: OUTAOKHFYFD2U45IGUWBEVU7PUPC6PEJ
X-Message-ID-Hash: OUTAOKHFYFD2U45IGUWBEVU7PUPC6PEJ
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: jhubbard@nvidia.com, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OUTAOKHFYFD2U45IGUWBEVU7PUPC6PEJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 14, 2019 at 12:20:13AM -0800, Dan Williams wrote:
> +	if (count > 1) {
> +		/* still busy */
> +		return;
> +	} else if (count == 0) {
> +		/* only triggered by the dev_pagemap shutdown path */
> +		__put_page(page);
> +		return;
> +	} else if (!is_device_private_page(page)) {
> +		/* notify page idle for dax */
> +		wake_up_var(&page->_refcount);
> +		return;
> +	}

No need for an else after a return.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
