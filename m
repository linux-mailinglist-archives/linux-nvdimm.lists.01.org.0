Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4783339F9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Mar 2021 11:29:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 11309100EB325;
	Wed, 10 Mar 2021 02:29:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4E0B7100EC1E8
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 02:29:11 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id B81D1AE42;
	Wed, 10 Mar 2021 10:29:10 +0000 (UTC)
Subject: Re: [PATCH v2] include: Remove pagemap.h from blkdev.h
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20210309195747.283796-1-willy@infradead.org>
From: Coly Li <colyli@suse.de>
Message-ID: <4d6e3281-98e5-e161-3883-00ccc88e1682@suse.de>
Date: Wed, 10 Mar 2021 18:29:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210309195747.283796-1-willy@infradead.org>
Content-Language: en-US
Message-ID-Hash: T3CZ4H5OO7KOB4ECPJ3XDOPENMFPFTV3
X-Message-ID-Hash: T3CZ4H5OO7KOB4ECPJ3XDOPENMFPFTV3
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T3CZ4H5OO7KOB4ECPJ3XDOPENMFPFTV3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/10/21 3:57 AM, Matthew Wilcox (Oracle) wrote:
> My UEK-derived config has 1030 files depending on pagemap.h before
> this change.  Afterwards, just 326 files need to be rebuilt when I
> touch pagemap.h.  I think blkdev.h is probably included too widely,
> but untangling that dependency is harder and this solves my problem.
> x86 allmodconfig builds, but there may be implicit include problems
> on other architectures.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> v2: Fix CONFIG_SWAP=n implicit use of pagemap.h by swap.h.  Increases
>     the number of files from 240, but that's still a big win -- 68%
>     reduction instead of 77%.
> 
>  block/blk-settings.c      | 1 +
>  drivers/block/brd.c       | 1 +
>  drivers/block/loop.c      | 1 +
>  drivers/md/bcache/super.c | 1 +
>  drivers/nvdimm/btt.c      | 1 +
>  drivers/nvdimm/pmem.c     | 1 +
>  drivers/scsi/scsicam.c    | 1 +
>  include/linux/blkdev.h    | 1 -
>  include/linux/swap.h      | 1 +
>  9 files changed, 8 insertions(+), 1 deletion(-)
> 
[snipped]

> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 71691f32959b..f154c89d1326 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -16,6 +16,7 @@
>  #include "features.h"
>  
>  #include <linux/blkdev.h>
> +#include <linux/pagemap.h>
>  #include <linux/debugfs.h>
>  #include <linux/genhd.h>
>  #include <linux/idr.h>[snipped]

For bcache part, Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
