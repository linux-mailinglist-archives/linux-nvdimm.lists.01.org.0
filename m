Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989ED1AD0B6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Apr 2020 22:02:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6015D100DCB7F;
	Thu, 16 Apr 2020 13:02:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AF287100DCB7D
	for <linux-nvdimm@lists.01.org>; Thu, 16 Apr 2020 13:02:29 -0700 (PDT)
IronPort-SDR: D6/4E+9KkOkCTb26tkvqPcuqzAWOk02xB+k1kyj3nZegTyOwKPFu0o1frpHrtmcy4hUnICgqAt
 ZLVyDQQTqI+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 13:02:08 -0700
IronPort-SDR: 9CJHJYympMg+/RoJNd54+3+uQwgayr6sXg3cY2YOolw0JoPj5mn4ju3PjHqVcGol+DN0Ioh5zD
 nj5ye7yLgLdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200";
   d="scan'208";a="272183147"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga002.jf.intel.com with ESMTP; 16 Apr 2020 13:02:07 -0700
Date: Thu, 16 Apr 2020 13:02:07 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [ndctl PATCH] libndctl: Fix buffer 'offset' calculation in
 do_cmd()
Message-ID: <20200416200207.GN2309605@iweiny-DESK2.sc.intel.com>
References: <20200416185223.48486-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200416185223.48486-1-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: W45BOF5HENDJCNEXDJSQRPRP3YNSD6B6
X-Message-ID-Hash: W45BOF5HENDJCNEXDJSQRPRP3YNSD6B6
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W45BOF5HENDJCNEXDJSQRPRP3YNSD6B6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 17, 2020 at 12:22:23AM +0530, Vaibhav Jain wrote:
> The 'for' loop in do_cmd() that generates multiple ioctls to
> libnvdimm assumes that each ioctl will result in transfer of
> 'iter->max_xfer' bytes. Hence after each successful iteration the
> buffer 'offset' is incremented by 'iter->max_xfer'.
> 
> This is in contrast to similar implementation in libnvdimm kernel
> function nvdimm_get_config_data() which increments the buffer offset
> by 'cmd->in_length' thats the actual number of bytes transferred from
> the dimm/bus control function.
> 
> The implementation in kernel function nvdimm_get_config_data() is more
> accurate compared to one in do_cmd() as former doesn't assume that
> config/label-area data size is in multiples of 'iter->max_xfer'.
> 
> Hence the patch updates do_cmd() to increment the buffer 'offset'
> variable by 'cmd->get_xfer()' rather than 'iter->max_xfer' after each
> iteration.

This commit message is not correct.  The problem is that commit
a2fd7017b72d113ff7dfcf1b92b6a0a4de34c8b3 introduced the concept of
{get,set}_xfer() and did not change the loop iterator to match.

Having the loop iterator match is not 100% required here as ->set_xfer() will
only change alter the cmd length written on the final command when the loop is
exiting anyway.

That said should set_xfer() ever do something more clever using get_xfer() is
cleaner.

> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  ndctl/lib/libndctl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index cda17ff32410..24fa67f0ccd0 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -3089,7 +3089,7 @@ NDCTL_EXPORT int ndctl_cmd_xlat_firmware_status(struct ndctl_cmd *cmd)
>  static int do_cmd(int fd, int ioctl_cmd, struct ndctl_cmd *cmd)
>  {
>  	int rc;
> -	u32 offset;
> +	u32 offset = 0;
>  	const char *name, *sub_name = NULL;
>  	struct ndctl_dimm *dimm = cmd->dimm;
>  	struct ndctl_bus *bus = cmd_to_bus(cmd);
> @@ -3116,7 +3116,7 @@ static int do_cmd(int fd, int ioctl_cmd, struct ndctl_cmd *cmd)
>  			return rc;
>  	}
>  
> -	for (offset = 0; offset < iter->total_xfer; offset += iter->max_xfer) {
> +	while (offset < iter->total_xfer) {

FWIW I prefer for loops if possible.

>  		cmd->set_xfer(cmd, min(iter->total_xfer - offset,
>  				iter->max_xfer));
>  		cmd->set_offset(cmd, offset);
> @@ -3136,6 +3136,8 @@ static int do_cmd(int fd, int ioctl_cmd, struct ndctl_cmd *cmd)
>  			rc = offset + cmd->get_xfer(cmd) - rc;
>  			break;
>  		}
> +
> +		offset += cmd->get_xfer(cmd) - rc;

Why "- rc"?  Doesn't this break WRITE?

Ira

>  	}
>  
>  	dbg(ctx, "bus: %d dimm: %#x cmd: %s%s%s total: %d max_xfer: %d status: %d fw: %d (%s)\n",
> -- 
> 2.25.2
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
