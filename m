Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81D16D38F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 20:16:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AEF42212D2748;
	Thu, 18 Jul 2019 11:18:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 77FF12194EB76
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 11:18:53 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jul 2019 11:16:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,279,1559545200"; d="scan'208";a="367438718"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga006.fm.intel.com with ESMTP; 18 Jul 2019 11:16:24 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jul 2019 11:16:24 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.252]) by
 FMSMSX154.amr.corp.intel.com ([169.254.6.214]) with mapi id 14.03.0439.000;
 Thu, 18 Jul 2019 11:16:24 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org"
 <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH v2 3/7] libnvdimm/region: Register badblocks before
 namespaces
Thread-Topic: [PATCH v2 3/7] libnvdimm/region: Register badblocks before
 namespaces
Thread-Index: AQHVPQc/XREfWGrWN0m6ePEPd1eCmKbRJRmA
Date: Thu, 18 Jul 2019 18:16:23 +0000
Message-ID: <60f1c499243c2e46fcc5aecc0922a0a5b730b16a.camel@intel.com>
References: <156341206785.292348.1660822720191643298.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156341208365.292348.1547528796026249120.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156341208365.292348.1547528796026249120.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <5BA1DF32AB703E448A19BBC12618BA43@intel.com>
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: "peterz@infradead.org" <peterz@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


On Wed, 2019-07-17 at 18:08 -0700, Dan Williams wrote:
> Namespace activation expects to be able to reference region badblocks.
> The following warning sometimes triggers when asynchronous namespace
> activation races in front of the completion of namespace probing. Move
> all possible namespace probing after region badblocks initialization.
> 
> Otherwise, lockdep sometimes catches the uninitialized state of the
> badblocks seqlock with stack trace signatures like:
> 
>     INFO: trying to register non-static key.
>     pmem2: detected capacity change from 0 to 136365211648
>     the code is fine but needs lockdep annotation.
>     turning off the locking correctness validator.
>     CPU: 9 PID: 358 Comm: kworker/u80:5 Tainted:
> G           OE     5.2.0-rc4+ #3382
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0
> 02/06/2015
>     Workqueue: events_unbound async_run_entry_fn
>     Call Trace:
>      dump_stack+0x85/0xc0
>     pmem1.12: detected capacity change from 0 to 8589934592
>      register_lock_class+0x56a/0x570
>      ? check_object+0x140/0x270
>      __lock_acquire+0x80/0x1710
>      ? __mutex_lock+0x39d/0x910
>      lock_acquire+0x9e/0x180
>      ? nd_pfn_validate+0x28f/0x440 [libnvdimm]
>      badblocks_check+0x93/0x1f0
>      ? nd_pfn_validate+0x28f/0x440 [libnvdimm]
>      nd_pfn_validate+0x28f/0x440 [libnvdimm]
>      ? lockdep_hardirqs_on+0xf0/0x180
>      nd_dax_probe+0x9a/0x120 [libnvdimm]
>      nd_pmem_probe+0x6d/0x180 [nd_pmem]
>      nvdimm_bus_probe+0x90/0x2c0 [libnvdimm]
> 
> Fixes: 48af2f7e52f4 ("libnvdimm, pfn: during init, clear errors...")
> Cc: <stable@vger.kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/region.c |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

This looks good to me,
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

> 
> diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
> index ef46cc3a71ae..488c47ac4c4a 100644
> --- a/drivers/nvdimm/region.c
> +++ b/drivers/nvdimm/region.c
> @@ -34,17 +34,6 @@ static int nd_region_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> -	rc = nd_region_register_namespaces(nd_region, &err);
> -	if (rc < 0)
> -		return rc;
> -
> -	ndrd = dev_get_drvdata(dev);
> -	ndrd->ns_active = rc;
> -	ndrd->ns_count = rc + err;
> -
> -	if (rc && err && rc == err)
> -		return -ENODEV;
> -
>  	if (is_nd_pmem(&nd_region->dev)) {
>  		struct resource ndr_res;
>  
> @@ -60,6 +49,17 @@ static int nd_region_probe(struct device *dev)
>  		nvdimm_badblocks_populate(nd_region, &nd_region->bb,
> &ndr_res);
>  	}
>  
> +	rc = nd_region_register_namespaces(nd_region, &err);
> +	if (rc < 0)
> +		return rc;
> +
> +	ndrd = dev_get_drvdata(dev);
> +	ndrd->ns_active = rc;
> +	ndrd->ns_count = rc + err;
> +
> +	if (rc && err && rc == err)
> +		return -ENODEV;
> +
>  	nd_region->btt_seed = nd_btt_create(nd_region);
>  	nd_region->pfn_seed = nd_pfn_create(nd_region);
>  	nd_region->dax_seed = nd_dax_create(nd_region);
> 

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
