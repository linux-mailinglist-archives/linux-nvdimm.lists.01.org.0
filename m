Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447AE2176F5
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 20:43:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9F4AA1108EF24;
	Tue,  7 Jul 2020 11:43:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=dave.jiang@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8A24E1108E90D
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 11:43:44 -0700 (PDT)
IronPort-SDR: 2hP69TsVmVVZNIn/hXDZgcy1gfDY8SOGLqyPf2R26DO6IaQuMV8bvGOsnlpok8MIH17qDzozAA
 zu0ggMVaT35A==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="145788655"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800";
   d="scan'208";a="145788655"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 11:43:43 -0700
IronPort-SDR: tE+2wPm6K9iFIacUOg/CLMFS7F3o0A/U57Q/REyznxMLWP6DfLC9mbDVGuTFmLQbBKrGQ2xHoi
 WCUff1u5CFuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800";
   d="scan'208";a="323625145"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.176.45]) ([10.212.176.45])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2020 11:43:43 -0700
Subject: Re: [PATCH] libnvdimm/security: Fix key lookup permissions
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
References: <159297332630.1304143.237026690015653759.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <f220e24b-d8f3-fde6-e590-5e73557b965a@intel.com>
Date: Tue, 7 Jul 2020 11:43:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159297332630.1304143.237026690015653759.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Message-ID-Hash: BWLMNON67GLLODZA3BH2DZMLXGDKDNQS
X-Message-ID-Hash: BWLMNON67GLLODZA3BH2DZMLXGDKDNQS
X-MailFrom: dave.jiang@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BWLMNON67GLLODZA3BH2DZMLXGDKDNQS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit



On 6/23/2020 9:35 PM, Dan Williams wrote:
> As of commit 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather
> than a mask") lookup_user_key() needs an explicit declaration of what it
> wants to do with the key. Add KEY_NEED_SEARCH to fix a warning with the
> below signature, and fixes the inability to retrieve a key.
> 
>      WARNING: CPU: 15 PID: 6276 at security/keys/permission.c:35 key_task_permission+0xd3/0x140
>      [..]
>      RIP: 0010:key_task_permission+0xd3/0x140
>      [..]
>      Call Trace:
>       lookup_user_key+0xeb/0x6b0
>       ? vsscanf+0x3df/0x840
>       ? key_validate+0x50/0x50
>       ? key_default_cmp+0x20/0x20
>       nvdimm_get_user_key_payload.part.0+0x21/0x110 [libnvdimm]
>       nvdimm_security_store+0x67d/0xb20 [libnvdimm]
>       security_store+0x67/0x1a0 [libnvdimm]
>       kernfs_fop_write+0xcf/0x1c0
>       vfs_write+0xde/0x1d0
>       ksys_write+0x68/0xe0
>       do_syscall_64+0x5c/0xa0
>       entry_SYSCALL_64_after_hwframe+0x49/0xb3
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: David Howells <dhowells@redhat.com>
> Fixes: 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather than a mask")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/nvdimm/security.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 89b85970912d..4cef69bd3c1b 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -95,7 +95,7 @@ static struct key *nvdimm_lookup_user_key(struct nvdimm *nvdimm,
>   	struct encrypted_key_payload *epayload;
>   	struct device *dev = &nvdimm->dev;
>   
> -	keyref = lookup_user_key(id, 0, 0);
> +	keyref = lookup_user_key(id, 0, KEY_NEED_SEARCH);
>   	if (IS_ERR(keyref))
>   		return NULL;
>   
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
