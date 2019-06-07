Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5127396C0
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Jun 2019 22:23:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F313021295B00;
	Fri,  7 Jun 2019 13:23:37 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8FAD621148DBD
 for <linux-nvdimm@lists.01.org>; Fri,  7 Jun 2019 13:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=29IHtlE/6a2OmsjukbA5ARdURIqIUHQIsBKMPglCt88=; b=euVUIRYYwirfKp1eF63MPhWtA
 h65H/xfzayNNM0RK/crrmRly06xyRlwtDyji01aJeYiGVMptnaDAKUx9v3C+Tj9+gAuorKlIW4S82
 d5CbwG/lfyaVEto7ZGvkHohrnf1BDq3S8TNorgQtXkHeOO6qeNxRcHtxWT70zbL09KPXIXLcOztpf
 WPbsInwzqHPV5HeY/6U6DSshJLL2Euuq3AozPw2bsWLcfaArkkWmvnnj4yL9+n801n1I86FcCBnLM
 CIYfFTKfY0lcDpIOXbzn/F6YLyZo/q8T9EN7vbD4EZn1M12pslE/PKEydQVfUEp9iW4P2VRlNvlpo
 XJ8JVqfJA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hZLOe-0006dJ-IG; Fri, 07 Jun 2019 20:23:32 +0000
Date: Fri, 7 Jun 2019 13:23:32 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 07/10] lib/memregion: Uplevel the pmem "region" ida to
 a global allocator
Message-ID: <20190607202332.GB32656@bombadil.infradead.org>
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155993567002.3036719.5748845658364934737.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155993567002.3036719.5748845658364934737.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: x86@kernel.org, ard.biesheuvel@linaro.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 07, 2019 at 12:27:50PM -0700, Dan Williams wrote:
> diff --git a/lib/memregion.c b/lib/memregion.c
> new file mode 100644
> index 000000000000..f6c6a94c7921
> --- /dev/null
> +++ b/lib/memregion.c
> @@ -0,0 +1,15 @@
> +#include <linux/idr.h>
> +
> +static DEFINE_IDA(region_ids);
> +
> +int memregion_alloc(gfp_t gfp)
> +{
> +	return ida_alloc(&region_ids, gfp);
> +}
> +EXPORT_SYMBOL(memregion_alloc);
> +
> +void memregion_free(int id)
> +{
> +	ida_free(&region_ids, id);
> +}
> +EXPORT_SYMBOL(memregion_free);

Does this trivial abstraction have to live in its own file?  I'd make
memregion_alloc/free static inlines that live in a header file, then
all you need do is find a suitable .c file to store memregion_ids in,
and export that one symbol instead of two.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
