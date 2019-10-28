Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 183A6E7B32
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Oct 2019 22:13:45 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8B919100EA63A;
	Mon, 28 Oct 2019 14:14:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 66949100EA639
	for <linux-nvdimm@lists.01.org>; Mon, 28 Oct 2019 14:14:28 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 14:13:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,241,1569308400";
   d="scan'208";a="198729509"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 28 Oct 2019 14:13:39 -0700
Date: Mon, 28 Oct 2019 14:13:39 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [ndctl patch 3/4] query_fw_finish_status: get rid of redundant
 variable
Message-ID: <20191028211338.GA9826@iweiny-DESK2.sc.intel.com>
References: <20191018202302.8122-1-jmoyer@redhat.com>
 <20191018202302.8122-4-jmoyer@redhat.com>
 <20191018205424.GA12760@iweiny-DESK2.sc.intel.com>
 <x49sgnp7ohp.fsf@segfault.boston.devel.redhat.com>
 <49b7cb5dae88ada6945b15eb1cf2e5e798173861.camel@intel.com>
 <7187044f4f6dca57f43879cd2d493949735f63a2.camel@intel.com>
 <20191025222115.GA6536@iweiny-DESK2.sc.intel.com>
 <x49v9s8veyb.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <x49v9s8veyb.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: ZJPV4HYC73UBFHGY2NEC7DHER2DOMJZF
X-Message-ID-Hash: ZJPV4HYC73UBFHGY2NEC7DHER2DOMJZF
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZJPV4HYC73UBFHGY2NEC7DHER2DOMJZF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 28, 2019 at 03:37:48PM -0400, Jeff Moyer wrote:
> Ira Weiny <ira.weiny@intel.com> writes:
> 
> >> (Watching the unit test run fall into an infinite loop..) Nope, the
> >> break is in the switch scope, the while loop needs the 'goto out'.
> >> 
> >> Yes this bit definitely needs to be refactored :)
> >
> > How about this patch instead?  Untested.
> 
> I'm not a fan of the looping with gotos.

Me either... But... the logic here is not the same.

>
> I think separating out the
> waiting for busy to its own function would make this more clear.
> Looking more closely, there are other issues.  The timeout code looks at
> the seconds, but ignores the fractions, so you could be off by almost an
> entire second, there.

For this operation that is probably not a big deal.  We should be waiting much
longer than the operation should take anyway.

>
> It also doens't retry the sleep if interrupted.

This could be an issue.

> Finally, I find the variables names to be highly confusing.
> 
> I've decided not to fix those last two bugs just yet, but here's a patch
> that shows the dirction I think it should go.  Compile-tested only for
> now.  Let me know what you think.

I thought about doing something similar but to make the logic the same it
becomes a bit awkward.

> 
> Ira, I used the same base as you.  If you updated ndctl, you'll have to
> revert 9e0391e057b36 to apply this patch.
> 
> Cheers,
> Jeff
> 
> diff --git a/ndctl/dimm.c b/ndctl/dimm.c
> index c8821d6..701f58b 100644
> --- a/ndctl/dimm.c
> +++ b/ndctl/dimm.c
> @@ -674,6 +674,41 @@ out:
>  	return rc;
>  }
>  
> +static void wait_for_cmd_completion(struct ndctl_cmd *cmd, struct fw_info *fw,
> +				    struct timespec *start)
> +{
> +	enum ND_FW_STATUS status;
> +	struct timespec sleeptime, now;
> +	int rc;
> +
> +	sleeptime.tv_nsec = fw->query_interval / 1000;
> +	sleeptime.tv_sec = 0;
> +
> +	while ((status = ndctl_cmd_fw_xlat_firmware_status(cmd)) == FW_EBUSY) {
> +
> +		rc = clock_gettime(CLOCK_MONOTONIC, &now);
> +		if (rc < 0)
> +			break;
> +
> +		/*
> +		 * If we expire max query time, we timed out
> +		 */
> +		if (now.tv_sec - start->tv_sec > fw->max_query / 1000000)
> +			break;
> +
> +		/*
> +		 * Sleep the interval dictated by firmware before
> +		 * query again.
> +		 */
> +		rc = nanosleep(&sleeptime, NULL);
> +		if (rc < 0)
> +			break;

You need ndctl_cmd_submit() here to be the same logic.

> +
> +	}
> +
> +	return;
> +}
> +
>  static int query_fw_finish_status(struct ndctl_dimm *dimm,
>  		struct action_context *actx)
>  {
> @@ -682,98 +717,65 @@ static int query_fw_finish_status(struct ndctl_dimm *dimm,
>  	struct ndctl_cmd *cmd;
>  	int rc;
>  	enum ND_FW_STATUS status;
> -	bool done = false;
> -	struct timespec now, before, after;
> +	struct timespec start;
>  	uint64_t ver;
>  
>  	cmd = ndctl_dimm_cmd_new_fw_finish_query(uctx->start);
>  	if (!cmd)
>  		return -ENXIO;
>  
> -	rc = clock_gettime(CLOCK_MONOTONIC, &before);
> +	rc = clock_gettime(CLOCK_MONOTONIC, &start);
>  	if (rc < 0)
> -		goto out;
> -
> -	now.tv_nsec = fw->query_interval / 1000;
> -	now.tv_sec = 0;
> -
> -	do {
> -		rc = ndctl_cmd_submit(cmd);
> -		if (rc < 0)
> -			break;
> +		goto unref;
>  
> -		status = ndctl_cmd_fw_xlat_firmware_status(cmd);
> -		switch (status) {
> -		case FW_SUCCESS:
> -			ver = ndctl_cmd_fw_fquery_get_fw_rev(cmd);
> -			if (ver == 0) {
> -				fprintf(stderr, "No firmware updated.\n");
> -				rc = -ENXIO;
> -				goto out;
> -			}
> -
> -			printf("Image updated successfully to DIMM %s.\n",
> -					ndctl_dimm_get_devname(dimm));
> -			printf("Firmware version %#lx.\n", ver);
> -			printf("Cold reboot to activate.\n");
> -			done = true;
> -			rc = 0;
> -			break;
> -		case FW_EBUSY:
> -			/* Still on going, continue */
> -			rc = clock_gettime(CLOCK_MONOTONIC, &after);
> -			if (rc < 0) {
> -				rc = -errno;
> -				goto out;
> -			}
> +	rc = ndctl_cmd_submit(cmd);
> +	if (rc < 0)
> +		goto unref;
>  
> -			/*
> -			 * If we expire max query time,
> -			 * we timed out
> -			 */
> -			if (after.tv_sec - before.tv_sec >
> -					fw->max_query / 1000000) {
> -				rc = -ETIMEDOUT;
> -				goto out;
> -			}
> +	wait_for_cmd_completion(cmd, fw, &start);

wait_for_cmd_completion() does not call ndctl_cmd_submit()

Now I find it odd that we need to resubmit the command but I assume the logic
is correct.  Therefore we need to go back and call ndctl_cmd_submit() again.

Or is this not required?

anyway that is why I went ahead and used the goto...

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
