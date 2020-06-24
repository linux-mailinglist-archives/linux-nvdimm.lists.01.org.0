Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDB2206B93
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jun 2020 07:15:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EE5AD10FC546F;
	Tue, 23 Jun 2020 22:15:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AC09310FC4AD2
	for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 22:15:30 -0700 (PDT)
IronPort-SDR: p1OWr4Y11LeFw+vd/8FApCUTE/UztZkxXjEzQO7uYzvQDjAOUJ2ERElKgSwx4qpPuePUlCW4Qf
 a93A2tUKMKVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="205843754"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800";
   d="scan'208";a="205843754"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 22:15:30 -0700
IronPort-SDR: /Dt28ta8rN+tZIFIxUGmlX1VPGaRWT9vksDFxOabvmB8rrnT9glL1nmSXUdQdyvGojTsAd71jw
 9LiSq+fYg92A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800";
   d="scan'208";a="319347138"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2020 22:15:29 -0700
Date: Tue, 23 Jun 2020 22:15:29 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libnvdimm/security: Fix key lookup permissions
Message-ID: <20200624051529.GC2617015@iweiny-DESK2.sc.intel.com>
References: <159297332630.1304143.237026690015653759.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <159297332630.1304143.237026690015653759.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: CLECPBF7QDMWRZPJA3ILPG3KWO6HEMZ6
X-Message-ID-Hash: CLECPBF7QDMWRZPJA3ILPG3KWO6HEMZ6
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CLECPBF7QDMWRZPJA3ILPG3KWO6HEMZ6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 23, 2020 at 09:35:26PM -0700, Dan Williams wrote:
> As of commit 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather
> than a mask") lookup_user_key() needs an explicit declaration of what it
> wants to do with the key. Add KEY_NEED_SEARCH to fix a warning with the
> below signature, and fixes the inability to retrieve a key.
> 
>     WARNING: CPU: 15 PID: 6276 at security/keys/permission.c:35 key_task_permission+0xd3/0x140
>     [..]
>     RIP: 0010:key_task_permission+0xd3/0x140
>     [..]
>     Call Trace:
>      lookup_user_key+0xeb/0x6b0
>      ? vsscanf+0x3df/0x840
>      ? key_validate+0x50/0x50
>      ? key_default_cmp+0x20/0x20
>      nvdimm_get_user_key_payload.part.0+0x21/0x110 [libnvdimm]
>      nvdimm_security_store+0x67d/0xb20 [libnvdimm]
>      security_store+0x67/0x1a0 [libnvdimm]
>      kernfs_fop_write+0xcf/0x1c0
>      vfs_write+0xde/0x1d0
>      ksys_write+0x68/0xe0
>      do_syscall_64+0x5c/0xa0
>      entry_SYSCALL_64_after_hwframe+0x49/0xb3
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Suggested-by: David Howells <dhowells@redhat.com>
> Fixes: 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather than a mask")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/security.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 89b85970912d..4cef69bd3c1b 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -95,7 +95,7 @@ static struct key *nvdimm_lookup_user_key(struct nvdimm *nvdimm,
>  	struct encrypted_key_payload *epayload;
>  	struct device *dev = &nvdimm->dev;
>  
> -	keyref = lookup_user_key(id, 0, 0);
> +	keyref = lookup_user_key(id, 0, KEY_NEED_SEARCH);
>  	if (IS_ERR(keyref))
>  		return NULL;
>  
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
