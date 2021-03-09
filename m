Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E724F331FD4
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Mar 2021 08:31:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B2E47100EBB9D;
	Mon,  8 Mar 2021 23:31:16 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4E3BA100EBB9C
	for <linux-nvdimm@lists.01.org>; Mon,  8 Mar 2021 23:31:13 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id AEA8B68B05; Tue,  9 Mar 2021 08:31:10 +0100 (CET)
Date: Tue, 9 Mar 2021 08:31:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libnvdimm: Let revalidate_disk() revalidate region
 read-only
Message-ID: <20210309073110.GA3140@lst.de>
References: <161527286194.446794.5215036039655765042.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161527286194.446794.5215036039655765042.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: LP32TJ5C3JKSFCESVGMFBVBULJNQHAUK
X-Message-ID-Hash: LP32TJ5C3JKSFCESVGMFBVBULJNQHAUK
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>, kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LP32TJ5C3JKSFCESVGMFBVBULJNQHAUK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 08, 2021 at 10:54:22PM -0800, Dan Williams wrote:
> Previous kernels allowed the BLKROSET to override the disk's read-only
> status. With that situation fixed the pmem driver needs to rely on
> revalidate_disk() to clear the disk read-only status after the host
> region has been marked read-write.
> 
> Recall that when libnvdimm determines that the persistent memory has
> lost persistence (for example lack of energy to flush from DRAM to FLASH
> on an NVDIMM-N device) it marks the region read-only, but that state can
> be overridden by the user via:
> 
>    echo 0 > /sys/bus/nd/devices/regionX/read_only
> 
> ...to date there is no notification that the region has restored
> persistence, so the user override is the only recovery.

I've just resent my series to kill of ->revalidate_disk for good, so this
obvious makes me a little unhappy.  Given that ->revalidate_disk
only ends up beeing called from the same path that ->open is called,
why can't you just hook this up from the open method?

Also any reason the sysfs attribute can't just directly propagate the
information to the disk?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
