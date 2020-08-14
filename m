Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E10244D55
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Aug 2020 19:10:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B8F71313D5D7;
	Fri, 14 Aug 2020 10:10:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 831811313D5D7
	for <linux-nvdimm@lists.01.org>; Fri, 14 Aug 2020 10:10:12 -0700 (PDT)
IronPort-SDR: qhzJ6F2ZyqoA5vrB9lMhpCCjXyMMmj+Z6WvM7wYKt8H2KXPSpCWwO1Wg3rAw47lJOf9H2HupML
 5Qvdy2IaSv5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="134512823"
X-IronPort-AV: E=Sophos;i="5.76,313,1592895600";
   d="scan'208";a="134512823"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 10:10:06 -0700
IronPort-SDR: Cp6itaVGonyNUKcEiO366ZJ9krA+qVT4np+ED814mQm5fM8nI4/GrFwV888bHjHAPPag9JjpXO
 H74OosB/hqTQ==
X-IronPort-AV: E=Sophos;i="5.76,313,1592895600";
   d="scan'208";a="496239063"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 10:10:06 -0700
Date: Fri, 14 Aug 2020 10:10:06 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH] libnvdimm: Add a NULL entry to
 'nvdimm_firmware_attributes'
Message-ID: <20200814171005.GB3142014@iweiny-DESK2.sc.intel.com>
References: <20200814150509.225615-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814150509.225615-1-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: FTCHIYRVKBJWB6TOFLRTV7VJZHY3ZCMS
X-Message-ID-Hash: FTCHIYRVKBJWB6TOFLRTV7VJZHY3ZCMS
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Sandipan Das <sandipan@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FTCHIYRVKBJWB6TOFLRTV7VJZHY3ZCMS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Aug 14, 2020 at 08:35:09PM +0530, Vaibhav Jain wrote:
> We recently discovered a kernel oops with 'papr_scm' module while
> booting ppc64 phyp guest with following back-trace:
> 
> BUG: Kernel NULL pointer dereference on write at 0x00000188
> Faulting instruction address: 0xc0000000005d7084
> Oops: Kernel access of bad area, sig: 11 [#1]
> <snip>
> Call Trace:
>  internal_create_group+0x128/0x4c0 (unreliable)
>  internal_create_groups.part.4+0x70/0x130
>  device_add+0x458/0x9c0
>  nd_async_device_register+0x28/0xa0 [libnvdimm]
>  async_run_entry_fn+0x78/0x1f0
>  process_one_work+0x2c0/0x5b0
>  worker_thread+0x88/0x650
>  kthread+0x1a8/0x1b0
>  ret_from_kernel_thread+0x5c/0x6c
> 
> A bisect lead to the 'commit 48001ea50d17f ("PM, libnvdimm: Add runtime
> firmware activation support")' and on investigation discovered that
> the newly introduced 'struct attribute *nvdimm_firmware_attributes[]'
> is missing a terminating NULL entry in the array. This causes a loop
> in sysfs's 'create_files()' to read garbage beyond bounds of
> 'nvdimm_firmware_attributes' and trigger the oops.
> 
> Fixes: 48001ea50d17f ("PM, libnvdimm: Add runtime firmware activation support")
> Reported-by: Sandipan Das <sandipan@linux.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/dimm_devs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index 61374def51555..b59032e0859b7 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -529,6 +529,7 @@ static DEVICE_ATTR_ADMIN_RW(activate);
>  static struct attribute *nvdimm_firmware_attributes[] = {
>  	&dev_attr_activate.attr,
>  	&dev_attr_result.attr,
> +	NULL,
>  };
>  
>  static umode_t nvdimm_firmware_visible(struct kobject *kobj, struct attribute *a, int n)
> -- 
> 2.26.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
