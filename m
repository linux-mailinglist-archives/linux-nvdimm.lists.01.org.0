Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E29A9228833
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jul 2020 20:27:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C5616123636D0;
	Tue, 21 Jul 2020 11:27:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 301B8123636CF
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jul 2020 11:27:55 -0700 (PDT)
IronPort-SDR: 2ts3VmrxB+iR3A3z4FLu0FaVCI0KB0qgXVUAuagZCxQYslDbjVMtjHOSrDJwocpAxtvPnCx5vu
 R0+XVKKrGlgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147706124"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800";
   d="scan'208";a="147706124"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 11:27:52 -0700
IronPort-SDR: 8SS/eSxq+8x4Xe0Rj7KfU1feTol8vL9N7S2189eBYTRMeIcTleOFT/MB8GImGv6MwBXNpK+mrp
 SzNNxDnh7Wrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800";
   d="scan'208";a="392433983"
Received: from vverma7-mobl4.lm.intel.com (HELO localhost6.localdomain6) ([10.255.75.30])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2020 11:27:51 -0700
Message-ID: <3a1ed55273a2c901228f5f6bc1824707a70d6dcb.camel@intel.com>
Subject: Re: [ndctl PATCH] papr: Check for command type in
 papr_xlat_firmware_status()
From: Vishal Verma <vishal.l.verma@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm@lists.01.org
Date: Tue, 21 Jul 2020 12:27:51 -0600
In-Reply-To: <20200721114326.305790-1-vaibhav@linux.ibm.com>
References: <20200721114326.305790-1-vaibhav@linux.ibm.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Message-ID-Hash: PWN36HJOBBAQJSLRNOFJYFJSFYB6ZTG7
X-Message-ID-Hash: PWN36HJOBBAQJSLRNOFJYFJSFYB6ZTG7
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PWN36HJOBBAQJSLRNOFJYFJSFYB6ZTG7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2020-07-21 at 17:13 +0530, Vaibhav Jain wrote:
> We recently discovered intermittent failures while reading label-area
> of PAPR-NVDimms and the command 'read-labels' would in such a case
> generated empty output like below:
> 
> $ sudo ndctl read-labels -j nmem0
> [
> ]
> read 0 nmem
> 
> Upon investigation we found that this was caused by a spurious error
> code returned from ndctl_cmd_submit_xlat() when its called from
> ndctl_dimm_read_label_extent() while trying to read the label-area
> contents of the NVDIMM.
> 
> Digging further it was relieved that ndctl_cmd_submit_xlat() would
> always call papr_xlat_firmware_status() via pointer
> 'papr_dimm_ops->xlat_firmware_status' to retrieve translated firmware
> status for all ndctl_cmds even though they arent really PAPR PDSM
> commands.
> 
> In this case ndctl_cmd->type == ND_CMD_GET_CONFIG_DATA and was
> represented by type 'struct nd_cmd_get_config_data_hdr' and
> papr_xlat_firmware_status() incorrectly assumed it to be of type
> 'struct nd_pkg_pdsm' and wrongly dereferenced it returning an invalid
> value.
> 
> A proper fix for this would probably need introducing a new ndctl_cmd
> callback like 'ndctl_cmd.get_xlat_firmware_status' similar to one
> introduced in [1]. However such a change could be disruptive, hence
> the patch introduces a small workaround in papr_xlat_firmware_status()
> that checks if the 'struct ndctl_cmd *' provided if of correct type
> CMD_CALL and if not then it ignores it and return '0'
> 
> References:
> [1]: commit fa754dd8acdb ("ndctl/dimm: Rework dimm command status
> reporting")
> 
> Fixes: 151d2876c49e ("papr: Add scaffolding to issue and handle PDSM requests")
> Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  ndctl/lib/papr.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/ndctl/lib/papr.c b/ndctl/lib/papr.c
> index d9ce253369b3..63561f8f9797 100644
> --- a/ndctl/lib/papr.c
> +++ b/ndctl/lib/papr.c
> @@ -56,9 +56,7 @@ static u32 papr_get_firmware_status(struct ndctl_cmd *cmd)
>  
>  static int papr_xlat_firmware_status(struct ndctl_cmd *cmd)
>  {
> -	const struct nd_pkg_pdsm *pcmd = to_pdsm(cmd);
> -
> -	return pcmd->cmd_status;
> +	return (cmd->type == ND_CMD_CALL) ? to_pdsm(cmd)->cmd_status : 0;

Is this correct? -- for non ND_CMD_CALL commands this will always return a 0,
and it seems like you will lose any error state for commands
like ND_CMD_SET_CONFIG_DATA.

>  }
>  
>  /* Verify if the given command is supported and valid */

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
