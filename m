Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE71EB5F5
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 18:17:22 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ADA14100DC409;
	Thu, 31 Oct 2019 10:17:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 721A3100DC407
	for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 10:17:46 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 10:17:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,252,1569308400";
   d="scan'208";a="211608055"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga001.fm.intel.com with ESMTP; 31 Oct 2019 10:17:19 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 fmsmsx107.amr.corp.intel.com ([169.254.6.52]) with mapi id 14.03.0439.000;
 Thu, 31 Oct 2019 10:17:18 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "cai@lca.pw" <cai@lca.pw>, "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v3] nvdimm/btt: fix variable 'rc' set but not used
Thread-Topic: [PATCH v3] nvdimm/btt: fix variable 'rc' set but not used
Thread-Index: AQHVj/RKt9JEPUybdkSDhqnJiJ6bv6d1c4eA
Date: Thu, 31 Oct 2019 17:17:18 +0000
Message-ID: <ab127750fc543ec236dc241255c70dd30abc6f21.camel@intel.com>
References: <1572530719-32161-1-git-send-email-cai@lca.pw>
In-Reply-To: <1572530719-32161-1-git-send-email-cai@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-ID: <DDB80CDF46CFFA46B59DDCF5A958C2D1@intel.com>
MIME-Version: 1.0
Message-ID-Hash: P27YVC7NP2JB75UVIMB6H3WYKNDWE2AQ
X-Message-ID-Hash: P27YVC7NP2JB75UVIMB6H3WYKNDWE2AQ
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P27YVC7NP2JB75UVIMB6H3WYKNDWE2AQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2019-10-31 at 10:05 -0400, Qian Cai wrote:
> drivers/nvdimm/btt.c: In function 'btt_read_pg':
> drivers/nvdimm/btt.c:1264:8: warning: variable 'rc' set but not used
> [-Wunused-but-set-variable]
>     int rc;
>         ^~
> 
> Add a ratelimited message in case a storm of errors is encountered.
> 
> Fixes: d9b83c756953 ("libnvdimm, btt: rework error clearing")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> v3: remove the unused "rc" per Vishal.
> v2: include the block address that is returning an error per Dan.
> 
>  drivers/nvdimm/btt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Looks good,
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

> 
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index 3e9f45aec8d1..5129543a0473 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1261,11 +1261,11 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
>  
>  		ret = btt_data_read(arena, page, off, postmap, cur_len);
>  		if (ret) {
> -			int rc;
> -
>  			/* Media error - set the e_flag */
> -			rc = btt_map_write(arena, premap, postmap, 0, 1,
> -				NVDIMM_IO_ATOMIC);
> +			if (btt_map_write(arena, premap, postmap, 0, 1, NVDIMM_IO_ATOMIC))
> +				dev_warn_ratelimited(to_dev(arena),
> +					"Error persistently tracking bad blocks at %#x\n",
> +					premap);
>  			goto out_rtt;
>  		}
>  

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
