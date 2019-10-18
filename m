Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D714ADD0AC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Oct 2019 22:54:28 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F19A510FCB926;
	Fri, 18 Oct 2019 13:56:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7FB3610FCB925
	for <linux-nvdimm@lists.01.org>; Fri, 18 Oct 2019 13:56:31 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 13:54:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,313,1566889200";
   d="scan'208";a="371575061"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 18 Oct 2019 13:54:25 -0700
Date: Fri, 18 Oct 2019 13:54:25 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [ndctl patch 3/4] query_fw_finish_status: get rid of redundant
 variable
Message-ID: <20191018205424.GA12760@iweiny-DESK2.sc.intel.com>
References: <20191018202302.8122-1-jmoyer@redhat.com>
 <20191018202302.8122-4-jmoyer@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191018202302.8122-4-jmoyer@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: IW2PNG4JVFMWDN36NF3HQ4VOCMFMUWIR
X-Message-ID-Hash: IW2PNG4JVFMWDN36NF3HQ4VOCMFMUWIR
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IW2PNG4JVFMWDN36NF3HQ4VOCMFMUWIR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 18, 2019 at 04:23:01PM -0400, Jeff Moyer wrote:
> The 'done' variable only adds confusion.
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> ---
>  ndctl/dimm.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/ndctl/dimm.c b/ndctl/dimm.c
> index c8821d6..f28b9c1 100644
> --- a/ndctl/dimm.c
> +++ b/ndctl/dimm.c
> @@ -682,7 +682,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
>  	struct ndctl_cmd *cmd;
>  	int rc;
>  	enum ND_FW_STATUS status;
> -	bool done = false;
>  	struct timespec now, before, after;
>  	uint64_t ver;
>  
> @@ -716,7 +715,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
>  					ndctl_dimm_get_devname(dimm));
>  			printf("Firmware version %#lx.\n", ver);
>  			printf("Cold reboot to activate.\n");
> -			done = true;
>  			rc = 0;

Do we need "goto out" here?

>  			break;
>  		case FW_EBUSY:
> @@ -753,7 +751,6 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
>  				ndctl_dimm_get_devname(dimm));
>  		case FW_EINVAL_CTX:
>  		case FW_ESEQUENCE:
> -			done = true;
>  			rc = -ENXIO;
>  			goto out;
>  		case FW_ENORES:
> @@ -761,17 +758,15 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
>  				"Firmware update sequence timed out: %s\n",
>  				ndctl_dimm_get_devname(dimm));
>  			rc = -ETIMEDOUT;
> -			done = true;
>  			goto out;
>  		default:
>  			fprintf(stderr,
>  				"Unknown update status: %#x on DIMM %s\n",
>  				status, ndctl_dimm_get_devname(dimm));
>  			rc = -EINVAL;
> -			done = true;
>  			goto out;
>  		}
> -	} while (!done);
> +	} while (true);

I'm not a fan of "while (true)".  But I'm not the maintainer.  The Logic seems
fine otherwise.

Ira

>  
>  out:
>  	ndctl_cmd_unref(cmd);
> -- 
> 2.19.1
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
