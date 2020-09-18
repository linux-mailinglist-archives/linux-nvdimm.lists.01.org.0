Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4AD2706F5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Sep 2020 22:23:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F41AE151B3B9C;
	Fri, 18 Sep 2020 13:23:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7AAF513F10FE4
	for <linux-nvdimm@lists.01.org>; Fri, 18 Sep 2020 13:23:31 -0700 (PDT)
IronPort-SDR: RpNz31jrTtRApOWN4uZxjYx6RV7Tb8YozP7SoxbU7Ghb+PEivIk6vxcENwVtNyTARpccJTyeC/
 5jfFkt+tJYCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="157422848"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400";
   d="scan'208";a="157422848"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 13:23:26 -0700
IronPort-SDR: juwBc6KyoAHzehehZe3ddvi6QBHz3lSczwM2mLOQX/j+FZulSTgAk1lDQ+l5a15RtLoCIJdpwC
 AUJLkA9mUqlw==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400";
   d="scan'208";a="509028963"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 13:23:24 -0700
Date: Fri, 18 Sep 2020 13:23:23 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] dm/dax: Fix table reference counts
Message-ID: <20200918202323.GL2540965@iweiny-DESK2.sc.intel.com>
References: <160045867590.25663.7548541079217827340.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <160045867590.25663.7548541079217827340.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: TTM57XRTCKKRS7BUVBK5PK2IWXOVWG75
X-Message-ID-Hash: TTM57XRTCKKRS7BUVBK5PK2IWXOVWG75
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com, stable@vger.kernel.org, Jan Kara <jack@suse.cz>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Adrian Huang <ahuang12@lenovo.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TTM57XRTCKKRS7BUVBK5PK2IWXOVWG75/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 18, 2020 at 12:51:15PM -0700, Dan Williams wrote:
> A recent fix to the dm_dax_supported() flow uncovered a latent bug. When
> dm_get_live_table() fails it is still required to drop the
> srcu_read_lock(). Without this change the lvm2 test-suite triggers this
> warning:
> 
>     # lvm2-testsuite --only pvmove-abort-all.sh
> 
>     WARNING: lock held when returning to user space!
>     5.9.0-rc5+ #251 Tainted: G           OE
>     ------------------------------------------------
>     lvm/1318 is leaving the kernel with locks still held!
>     1 lock held by lvm/1318:
>      #0: ffff9372abb5a340 (&md->io_barrier){....}-{0:0}, at: dm_get_live_table+0x5/0xb0 [dm_mod]
> 
> ...and later on this hang signature:
> 
>     INFO: task lvm:1344 blocked for more than 122 seconds.
>           Tainted: G           OE     5.9.0-rc5+ #251
>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>     task:lvm             state:D stack:    0 pid: 1344 ppid:     1 flags:0x00004000
>     Call Trace:
>      __schedule+0x45f/0xa80
>      ? finish_task_switch+0x249/0x2c0
>      ? wait_for_completion+0x86/0x110
>      schedule+0x5f/0xd0
>      schedule_timeout+0x212/0x2a0
>      ? __schedule+0x467/0xa80
>      ? wait_for_completion+0x86/0x110
>      wait_for_completion+0xb0/0x110
>      __synchronize_srcu+0xd1/0x160
>      ? __bpf_trace_rcu_utilization+0x10/0x10
>      __dm_suspend+0x6d/0x210 [dm_mod]
>      dm_suspend+0xf6/0x140 [dm_mod]
> 
> Fixes: 7bf7eac8d648 ("dax: Arrange for dax_supported check to span multiple devices")
> Cc: <stable@vger.kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Reported-by: Adrian Huang <ahuang12@lenovo.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/md/dm.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index fb0255d25e4b..4a40df8af7d3 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1136,15 +1136,16 @@ static bool dm_dax_supported(struct dax_device *dax_dev, struct block_device *bd
>  {
>  	struct mapped_device *md = dax_get_private(dax_dev);
>  	struct dm_table *map;
> +	bool ret = false;
>  	int srcu_idx;
> -	bool ret;
>  
>  	map = dm_get_live_table(md, &srcu_idx);
>  	if (!map)
> -		return false;
> +		goto out;
>  
>  	ret = dm_table_supports_dax(map, device_supports_dax, &blocksize);
>  
> +out:
>  	dm_put_live_table(md, srcu_idx);

Wow that is an odd interface for the kernel.  Especially since map is not
passed back in.  But yea looks correct.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

>  
>  	return ret;
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
