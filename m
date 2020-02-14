Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CB115D7D6
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Feb 2020 13:57:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A636A10FC3401;
	Fri, 14 Feb 2020 05:00:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9C1A410FC33FB
	for <linux-nvdimm@lists.01.org>; Fri, 14 Feb 2020 05:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581685048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0W1G09myWqh7xVsLTycq4q1u2+SorrNYLpq3JdGz7g=;
	b=GHEv1RJPjYt/B3canbkU8DZfUHA1zTOfDu45UVO2kiQ/TUcj4zFkEXDtXOhCBUwVl+u1h6
	vc8Xj4V/hQDtfzXAAmwzDeWKA0grCRtQNydtIKnXmYyhT8NzjLdwjJ9W1S7OYWateonB6s
	gbfmopYS7vKW5YpheYcNdq2v/ZPgUis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-L4pxzCI4MtmRVwXtGSPurA-1; Fri, 14 Feb 2020 07:57:21 -0500
X-MC-Unique: L4pxzCI4MtmRVwXtGSPurA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ACF8107B267;
	Fri, 14 Feb 2020 12:57:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CCC978ECFA;
	Fri, 14 Feb 2020 12:57:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 4BD172257D2; Fri, 14 Feb 2020 07:57:17 -0500 (EST)
Date: Fri, 14 Feb 2020 07:57:17 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
	hch@infradead.org, dan.j.williams@intel.com
Subject: Re: [PATCH v3 0/7] dax,pmem: Provide a dax operation to zero range
 of memory
Message-ID: <20200214125717.GA18654@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200207202652.1439-1-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: IE4CXSNERYTDRXDRYRWJBB6NX6FIIO2T
X-Message-ID-Hash: IE4CXSNERYTDRXDRYRWJBB6NX6FIIO2T
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IE4CXSNERYTDRXDRYRWJBB6NX6FIIO2T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 07, 2020 at 03:26:45PM -0500, Vivek Goyal wrote:
> Hi,
> 
> This is V3 of patches. I have dropped RFC tag from the series as it
> looks like there is agreement on the interface. These patches are also
> available at.

Hi Dan, Christoph,

Ping for this patch series. How does it look? Do you have concerns?
If not, it will be good if this is merged.

Thanks
Vivek

> 
> https://github.com/rhvgoyal/linux/commits/dax-zero-range-v3
> 
> I posted previous versions here.
> 
> v2:
> https://lore.kernel.org/linux-fsdevel/20200203200029.4592-1-vgoyal@redhat.com/
> v1:
> https://lore.kernel.org/linux-fsdevel/20200123165249.GA7664@redhat.com/
> 
> Changes since V2:
> 
> Primarily took care of comments from Christoph.
> 
> - Changed zero_copy_range() parameters to pass dax device offset as u64.
> - Fixed comment which says current interface only supports zeroing
>   with-in page.
> - Refactored pmem_do_bvec() and reused write side of code in
>   zero_page_range().
> - Removed generic_dax_zero_page_range()
> - Fixed s390 dcssblk.c compilation issue.
> 
> Please review. 
> 
> Thanks
> Vivek
> 
> Vivek Goyal (7):
>   pmem: Add functions for reading/writing page to/from pmem
>   pmem: Enable pmem_do_write() to deal with arbitrary ranges
>   dax, pmem: Add a dax operation zero_page_range
>   s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
>   dm,dax: Add dax zero_page_range operation
>   dax,iomap: Start using dax native zero_page_range()
>   dax,iomap: Add helper dax_iomap_zero() to zero a range
> 
>  drivers/dax/super.c           |  19 ++++++
>  drivers/md/dm-linear.c        |  21 +++++++
>  drivers/md/dm-log-writes.c    |  19 ++++++
>  drivers/md/dm-stripe.c        |  26 ++++++++
>  drivers/md/dm.c               |  31 ++++++++++
>  drivers/nvdimm/pmem.c         | 112 ++++++++++++++++++++++++----------
>  drivers/s390/block/dcssblk.c  |  17 ++++++
>  fs/dax.c                      |  53 ++++------------
>  fs/iomap/buffered-io.c        |   9 +--
>  include/linux/dax.h           |  20 ++----
>  include/linux/device-mapper.h |   3 +
>  11 files changed, 235 insertions(+), 95 deletions(-)
> 
> -- 
> 2.20.1
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
