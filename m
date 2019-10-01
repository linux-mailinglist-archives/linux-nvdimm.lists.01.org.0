Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF6EC4435
	for <lists+linux-nvdimm@lfdr.de>; Wed,  2 Oct 2019 01:19:14 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 53FC110FC720F;
	Tue,  1 Oct 2019 16:20:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4193C10FC720C
	for <linux-nvdimm@lists.01.org>; Tue,  1 Oct 2019 16:20:35 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 16:19:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,572,1559545200";
   d="scan'208";a="366510345"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 01 Oct 2019 16:19:09 -0700
Date: Tue, 1 Oct 2019 16:19:09 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [ndctl PATCH] libdaxctl: fix memory leaks with daxctl_memory
 objects
Message-ID: <20191001231909.GA11607@iweiny-DESK2.sc.intel.com>
References: <20191001173726.21846-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191001173726.21846-1-vishal.l.verma@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: DLP7QYVM4Y53VWYLPX2CVULXO7WUWUEX
X-Message-ID-Hash: DLP7QYVM4Y53VWYLPX2CVULXO7WUWUEX
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Michal Biesek <michal.biesek@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DLP7QYVM4Y53VWYLPX2CVULXO7WUWUEX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 01, 2019 at 11:37:26AM -0600, 'Vishal Verma' wrote:
> The daxctl_dev_alloc_mem() helper which is used to instantiate a new
> memory object did so, but neglected to attach the memory object to the
> parent 'dev' object. As a result, every invocation of
> 'daxctl_dev_get_memory() resulted in a new, orphan memory object being
> created, which also resulted in libdaxctl leaking memory.
> 
> Fix the parent association for 'mem' objects, and in free_mem, remove
> the check for 'dev' being present - mem objects will always associated
> with a dev.
> 
> Additionally, we were neglecting to free 'mem->mem_buf' in free_mem, so
> fix this up as well.
> 
> Fixes: e8bf803e359b ("libdaxctl: add a 'daxctl_memory' object for memory based operations")
> Link: https://github.com/pmem/ndctl/issues/112
> Reported-by: Michal Biesek <michal.biesek@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Minor NIT below.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  daxctl/lib/libdaxctl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
> index 8abfd64..639224c 100644
> --- a/daxctl/lib/libdaxctl.c
> +++ b/daxctl/lib/libdaxctl.c
> @@ -204,8 +204,9 @@ DAXCTL_EXPORT void daxctl_region_get_uuid(struct daxctl_region *region, uuid_t u
>  
>  static void free_mem(struct daxctl_dev *dev)
>  {
> -	if (dev && dev->mem) {
> +	if (dev->mem) {

There is a comment in daxctl_dev_disable() which says:

        /* If there is a memory object, first free that */

I'm 100% sure that dev can't be NULL there.  So that comment no longer applies.

May want to remove that comment.

Ira

>  		free(dev->mem->node_path);
> +		free(dev->mem->mem_buf);
>  		free(dev->mem);
>  		dev->mem = NULL;
>  	}
> @@ -450,6 +451,7 @@ static struct daxctl_memory *daxctl_dev_alloc_mem(struct daxctl_dev *dev)
>  		goto err_node;
>  	mem->buf_len = strlen(node_base) + 256;
>  
> +	dev->mem = mem;
>  	return mem;
>  
>  err_node:
> -- 
> 2.20.1
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
