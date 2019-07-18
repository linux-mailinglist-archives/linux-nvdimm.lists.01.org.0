Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BED16D3C2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 20:21:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9F327212D274B;
	Thu, 18 Jul 2019 11:23:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 39B91212D2742
 for <linux-nvdimm@lists.01.org>; Thu, 18 Jul 2019 11:23:51 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jul 2019 11:21:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,279,1559545200"; d="scan'208";a="187840285"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by fmsmga001.fm.intel.com with ESMTP; 18 Jul 2019 11:21:22 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jul 2019 11:21:21 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.252]) by
 fmsmsx156.amr.corp.intel.com ([169.254.13.183]) with mapi id 14.03.0439.000;
 Thu, 18 Jul 2019 11:21:21 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org"
 <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH v2 4/7] libnvdimm/bus: Prepare the nd_ioctl() path to be
 re-entrant
Thread-Topic: [PATCH v2 4/7] libnvdimm/bus: Prepare the nd_ioctl() path to
 be re-entrant
Thread-Index: AQHVPQdDpdYor48nK0WGPhP15Ls3oabRJnqA
Date: Thu, 18 Jul 2019 18:21:20 +0000
Message-ID: <76c3363adaf3fe1a553876e3b3d5af4af1ab922a.camel@intel.com>
References: <156341206785.292348.1660822720191643298.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156341208947.292348.10560140326807607481.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156341208947.292348.10560140326807607481.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <B3DC67D4B907294FA63B4BFE6BBD8E9C@intel.com>
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


On Wed, 2019-07-17 at 18:08 -0700, Dan Williams wrote:
> In preparation for not holding a lock over the execution of
> nd_ioctl(),
> update the implementation to allow multiple threads to be attempting
> ioctls at the same time. The bus lock still prevents multiple in-
> flight
> ->ndctl() invocations from corrupting each other's state, but static
> global staging buffers are moved to the heap.
> 
> Reported-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/bus.c |   59 +++++++++++++++++++++++++++++++--------
> -----------
>  1 file changed, 37 insertions(+), 22 deletions(-)

Ran tens of iterations of the unit tests with this, and couldn't
reproduce the failure.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Tested-by: Vishal Verma <vishal.l.verma@intel.com>

> 
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index 42713b210f51..a3180c28fb2b 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -970,20 +970,19 @@ static int __nd_ioctl(struct nvdimm_bus
> *nvdimm_bus, struct nvdimm *nvdimm,
>  		int read_only, unsigned int ioctl_cmd, unsigned long
> arg)
>  {
>  	struct nvdimm_bus_descriptor *nd_desc = nvdimm_bus->nd_desc;
> -	static char out_env[ND_CMD_MAX_ENVELOPE];
> -	static char in_env[ND_CMD_MAX_ENVELOPE];
>  	const struct nd_cmd_desc *desc = NULL;
>  	unsigned int cmd = _IOC_NR(ioctl_cmd);
>  	struct device *dev = &nvdimm_bus->dev;
>  	void __user *p = (void __user *) arg;
> +	char *out_env = NULL, *in_env = NULL;
>  	const char *cmd_name, *dimm_name;
>  	u32 in_len = 0, out_len = 0;
>  	unsigned int func = cmd;
>  	unsigned long cmd_mask;
>  	struct nd_cmd_pkg pkg;
>  	int rc, i, cmd_rc;
> +	void *buf = NULL;
>  	u64 buf_len = 0;
> -	void *buf;
>  
>  	if (nvdimm) {
>  		desc = nd_cmd_dimm_desc(cmd);
> @@ -1023,6 +1022,9 @@ static int __nd_ioctl(struct nvdimm_bus
> *nvdimm_bus, struct nvdimm *nvdimm,
>  		}
>  
>  	/* process an input envelope */
> +	in_env = kzalloc(ND_CMD_MAX_ENVELOPE, GFP_KERNEL);
> +	if (!in_env)
> +		return -ENOMEM;
>  	for (i = 0; i < desc->in_num; i++) {
>  		u32 in_size, copy;
>  
> @@ -1030,14 +1032,17 @@ static int __nd_ioctl(struct nvdimm_bus
> *nvdimm_bus, struct nvdimm *nvdimm,
>  		if (in_size == UINT_MAX) {
>  			dev_err(dev, "%s:%s unknown input size cmd: %s
> field: %d\n",
>  					__func__, dimm_name, cmd_name,
> i);
> -			return -ENXIO;
> +			rc = -ENXIO;
> +			goto out;
>  		}
> -		if (in_len < sizeof(in_env))
> -			copy = min_t(u32, sizeof(in_env) - in_len,
> in_size);
> +		if (in_len < ND_CMD_MAX_ENVELOPE)
> +			copy = min_t(u32, ND_CMD_MAX_ENVELOPE - in_len,
> in_size);
>  		else
>  			copy = 0;
> -		if (copy && copy_from_user(&in_env[in_len], p + in_len,
> copy))
> -			return -EFAULT;
> +		if (copy && copy_from_user(&in_env[in_len], p + in_len,
> copy)) {
> +			rc = -EFAULT;
> +			goto out;
> +		}
>  		in_len += in_size;
>  	}
>  
> @@ -1049,6 +1054,12 @@ static int __nd_ioctl(struct nvdimm_bus
> *nvdimm_bus, struct nvdimm *nvdimm,
>  	}
>  
>  	/* process an output envelope */
> +	out_env = kzalloc(ND_CMD_MAX_ENVELOPE, GFP_KERNEL);
> +	if (!out_env) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
>  	for (i = 0; i < desc->out_num; i++) {
>  		u32 out_size = nd_cmd_out_size(nvdimm, cmd, desc, i,
>  				(u32 *) in_env, (u32 *) out_env, 0);
> @@ -1057,15 +1068,18 @@ static int __nd_ioctl(struct nvdimm_bus
> *nvdimm_bus, struct nvdimm *nvdimm,
>  		if (out_size == UINT_MAX) {
>  			dev_dbg(dev, "%s unknown output size cmd: %s
> field: %d\n",
>  					dimm_name, cmd_name, i);
> -			return -EFAULT;
> +			rc = -EFAULT;
> +			goto out;
>  		}
> -		if (out_len < sizeof(out_env))
> -			copy = min_t(u32, sizeof(out_env) - out_len,
> out_size);
> +		if (out_len < ND_CMD_MAX_ENVELOPE)
> +			copy = min_t(u32, ND_CMD_MAX_ENVELOPE - out_len,
> out_size);
>  		else
>  			copy = 0;
>  		if (copy && copy_from_user(&out_env[out_len],
> -					p + in_len + out_len, copy))
> -			return -EFAULT;
> +					p + in_len + out_len, copy)) {
> +			rc = -EFAULT;
> +			goto out;
> +		}
>  		out_len += out_size;
>  	}
>  
> @@ -1073,12 +1087,15 @@ static int __nd_ioctl(struct nvdimm_bus
> *nvdimm_bus, struct nvdimm *nvdimm,
>  	if (buf_len > ND_IOCTL_MAX_BUFLEN) {
>  		dev_dbg(dev, "%s cmd: %s buf_len: %llu > %d\n",
> dimm_name,
>  				cmd_name, buf_len, ND_IOCTL_MAX_BUFLEN);
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto out;
>  	}
>  
>  	buf = vmalloc(buf_len);
> -	if (!buf)
> -		return -ENOMEM;
> +	if (!buf) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
>  
>  	if (copy_from_user(buf, p, buf_len)) {
>  		rc = -EFAULT;
> @@ -1100,17 +1117,15 @@ static int __nd_ioctl(struct nvdimm_bus
> *nvdimm_bus, struct nvdimm *nvdimm,
>  		nvdimm_account_cleared_poison(nvdimm_bus, clear_err-
> >address,
>  				clear_err->cleared);
>  	}
> -	nvdimm_bus_unlock(&nvdimm_bus->dev);
>  
>  	if (copy_to_user(p, buf, buf_len))
>  		rc = -EFAULT;
>  
> -	vfree(buf);
> -	return rc;
> -
> - out_unlock:
> +out_unlock:
>  	nvdimm_bus_unlock(&nvdimm_bus->dev);
> - out:
> +out:
> +	kfree(in_env);
> +	kfree(out_env);
>  	vfree(buf);
>  	return rc;
>  }
> 

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
