Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC97817F744
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Mar 2020 13:18:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0877210FC360A;
	Tue, 10 Mar 2020 05:19:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1400C10FC3609
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 05:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583842718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=On3jrUJ3qJSEovCH5Mvj0GPbi4DtGWxMoOE2wJW9Vps=;
	b=cmtURjQ9MQtU8tCMp4GnGcZ8yEh5GINTi0XnNkYDrDjGTppzEvHgsJRdzOONfnpf5fCIO7
	JiW2kOPWxtABeW4TfkFt+Vto7TeivTIsVw7LMSQNZSSso/5YReXE4BtkjWPy+ZvzXxHX0w
	NQ263/GdBAZog2Kc9Y2FW3SPbzVx0/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-PbGEKDs0OnqHC_wsSkBcAQ-1; Tue, 10 Mar 2020 08:18:37 -0400
X-MC-Unique: PbGEKDs0OnqHC_wsSkBcAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 983E71402;
	Tue, 10 Mar 2020 12:18:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D0D2F27189;
	Tue, 10 Mar 2020 12:18:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 5F29D220291; Tue, 10 Mar 2020 08:18:32 -0400 (EDT)
Date: Tue, 10 Mar 2020 08:18:32 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
	hch@infradead.org, dan.j.williams@intel.com
Subject: Re: [PATCH v6 0/6] dax/pmem: Provide a dax operation to zero page
 range
Message-ID: <20200310121832.GA38440@redhat.com>
References: <20200228163456.1587-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200228163456.1587-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: Z6F7WXYQUPPZT2RP2UZYCBL27KUZP6SO
X-Message-ID-Hash: Z6F7WXYQUPPZT2RP2UZYCBL27KUZP6SO
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: david@fromorbit.com, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z6F7WXYQUPPZT2RP2UZYCBL27KUZP6SO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 28, 2020 at 11:34:50AM -0500, Vivek Goyal wrote:
> Hi,
> 
> This is V6 of patches. These patches are also available at.

Hi Dan,

Ping. Does this patch series look fine to you?

Vivek

> 
> Changes since V5:
> 
> - Dan Williams preferred ->zero_page_range() to only accept PAGE_SIZE
>   aligned request and clear poison only on page size aligned zeroing. So
>   I changed it accordingly. 
> 
> - Dropped all the modifications which were required to support arbitrary
>   range zeroing with-in a page.
> 
> - This patch series also fixes the issue where "truncate -s 512 foo.txt"
>   will fail if first sector of file is poisoned. Currently it succeeds
>   and filesystem expectes whole of the filesystem block to be free of
>   poison at the end of the operation.
> 
> Christoph, I have dropped your Reviewed-by tag on 1-2 patches because
> these patches changed substantially. Especially signature of of
> dax zero_page_range() helper.
> 
> Thanks
> Vivek
> 
> Vivek Goyal (6):
>   pmem: Add functions for reading/writing page to/from pmem
>   dax, pmem: Add a dax operation zero_page_range
>   s390,dcssblk,dax: Add dax zero_page_range operation to dcssblk driver
>   dm,dax: Add dax zero_page_range operation
>   dax: Use new dax zero page method for zeroing a page
>   dax,iomap: Add helper dax_iomap_zero() to zero a range
> 
>  drivers/dax/super.c           | 20 ++++++++
>  drivers/md/dm-linear.c        | 18 +++++++
>  drivers/md/dm-log-writes.c    | 17 ++++++
>  drivers/md/dm-stripe.c        | 23 +++++++++
>  drivers/md/dm.c               | 30 +++++++++++
>  drivers/nvdimm/pmem.c         | 97 ++++++++++++++++++++++-------------
>  drivers/s390/block/dcssblk.c  | 15 ++++++
>  fs/dax.c                      | 59 ++++++++++-----------
>  fs/iomap/buffered-io.c        |  9 +---
>  include/linux/dax.h           | 21 +++-----
>  include/linux/device-mapper.h |  3 ++
>  11 files changed, 221 insertions(+), 91 deletions(-)
> 
> -- 
> 2.20.1
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
