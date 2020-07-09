Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AAD219809
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jul 2020 07:39:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 41C4F111E7BFD;
	Wed,  8 Jul 2020 22:39:47 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1042; helo=mail-pj1-x1042.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 788DA1118BAE7
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 22:39:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o22so598134pjw.2
        for <linux-nvdimm@lists.01.org>; Wed, 08 Jul 2020 22:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=9c81TSIbCZKp6JD2DVQj8nUdKOC/bv5lSEFksVXMAhY=;
        b=Jz0FOkoBSmF19wKLrGnv6k7IgJCZHMLHAbCVfGOpuUGbMlTFEGyL1f++ecTr2pMGLt
         Y81qlkeL53U6ojq/2hgh8sGpnGiTNRzVD0vD6G1ZSSF3YSFPwL7AQSFd5OAtLVgg1WN8
         /1xxkO80yu6UYV8oHXdTOT8E8rxLEe2ZmYzkRFNh094KmukLkcatg+Sq/+gGNH3j8uBA
         Lhzeh1BirWtWVmLqe+M69FQojhX45hQthpxmnt60yuPRH9PKBk18z0y1J8ZangeNQaBU
         czEXDTVrZBFUwEBvW+AjkHAK1ZEC9UE3R/HWjrc3XzXuwHNTGGWTvdQIkoBKLwBq+Me+
         2jUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9c81TSIbCZKp6JD2DVQj8nUdKOC/bv5lSEFksVXMAhY=;
        b=XHSbNX/M6RoO5f5utsw/dj9I4jdOD+PjEWlP4KbTV5d/L55pGMiBEjgDxvoFXeHS++
         nuA/3kFZM4A4sqH93G6GQNX2JNfoad82N6DlRYxRnixypsGdOj8KDBHb0Ola3Bfg0NaC
         fyO7DHloXSnhwesL8TarJdslcgL+6D0ADhcsAHieM82eCO36xvaMuaH0bUMCZtDbPD3u
         JlLlt8+YUpgn9YAIyRDI8hMxWUYRMC8G7ouE2CRkpS5hpOJTzMT84TsKlyJMpr1xTIqj
         EDpAbE4KYknOaFn16TCNu1MZqbCOyOyeNyWhOClB8tTSQAv9ZskjaVmQz+CxU7jzuKd1
         inwQ==
X-Gm-Message-State: AOAM532LvTbOFMqi8EqV7dckz+xYx2lXzxzz/hRTFw3Id8hqkiMwI4ZO
	bKYvXJqaO2MhJSGb9EiilWhFMw==
X-Google-Smtp-Source: ABdhPJzaMbs69W+izWHsHVKi9/rTQgx7LqOadZ5dQC4MCiXRM1y/J0qQTK3w0q1TBpKXqP7cNGZKlw==
X-Received: by 2002:a17:902:8a8f:: with SMTP id p15mr53204802plo.172.1594273184854;
        Wed, 08 Jul 2020 22:39:44 -0700 (PDT)
Received: from localhost ([203.223.190.240])
        by smtp.gmail.com with ESMTPSA id 15sm1147828pjs.8.2020.07.08.22.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 22:39:44 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Hannes Reinecke <hare@suse.de>, Dan Williams <dan.williams@intel.com>
Subject: Re: [PATCH] libnvdimm: call devm_namespace_disable() on error
In-Reply-To: <20200703111856.40280-1-hare@suse.de>
References: <20200703111856.40280-1-hare@suse.de>
Date: Thu, 09 Jul 2020 11:09:41 +0530
Message-ID: <87zh89qmaq.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: IVJQRZY4WNIHK7HVRQQV5ZMGPZOUOSYQ
X-Message-ID-Hash: IVJQRZY4WNIHK7HVRQQV5ZMGPZOUOSYQ
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Hannes Reinecke <hare@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IVJQRZY4WNIHK7HVRQQV5ZMGPZOUOSYQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Hannes,

Hannes Reinecke <hare@suse.de> writes:

> Once devm_namespace_enable() has been called the error path in the
> calling function will not call devm_namespace_disable(), leaving the
> namespace enabled on error.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/dax/pmem/core.c   |  2 +-
>  drivers/nvdimm/btt.c      |  5 ++++-
>  drivers/nvdimm/claim.c    |  8 +++++++-
>  drivers/nvdimm/pfn_devs.c |  1 +
>  drivers/nvdimm/pmem.c     | 20 ++++++++++----------
>  5 files changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
> index 2bedf8414fff..4b26434f0aca 100644
> --- a/drivers/dax/pmem/core.c
> +++ b/drivers/dax/pmem/core.c
> @@ -31,9 +31,9 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
>  	if (rc)
>  		return ERR_PTR(rc);
>  	rc = nvdimm_setup_pfn(nd_pfn, &pgmap);
> +	devm_namespace_disable(dev, ndns);
>  	if (rc)
>  		return ERR_PTR(rc);
> -	devm_namespace_disable(dev, ndns);
>  
>  	/* reserve the metadata area, device-dax will reserve the data */
>  	pfn_sb = nd_pfn->pfn_sb;
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index 48e9d169b6f9..bd4747f2c99b 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1704,13 +1704,16 @@ int nvdimm_namespace_attach_btt(struct nd_namespace_common *ndns)
>  		dev_dbg(&nd_btt->dev, "%s must be at least %ld bytes\n",
>  				dev_name(&ndns->dev),
>  				ARENA_MIN_SIZE + nd_btt->initial_offset);
> +		devm_namespace_disable(&nd_btt->dev, ndns);
>  		return -ENXIO;
>  	}
>  	nd_region = to_nd_region(nd_btt->dev.parent);
>  	btt = btt_init(nd_btt, rawsize, nd_btt->lbasize, nd_btt->uuid,
>  			nd_region);
> -	if (!btt)
> +	if (!btt) {
> +		devm_namespace_disable(&nd_btt->dev, ndns);
>  		return -ENOMEM;
> +	}
>  	nd_btt->btt = btt;
>  
>  	return 0;
> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> index 45964acba944..15fd1b92d32f 100644
> --- a/drivers/nvdimm/claim.c
> +++ b/drivers/nvdimm/claim.c
> @@ -314,12 +314,18 @@ int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio,
>  	}
>  
>  	ndns->rw_bytes = nsio_rw_bytes;
> -	if (devm_init_badblocks(dev, &nsio->bb))
> +	if (devm_init_badblocks(dev, &nsio->bb)) {
> +		devm_release_mem_region(dev, res->start, size);
>  		return -ENOMEM;
> +	}
>  	nvdimm_badblocks_populate(to_nd_region(ndns->dev.parent), &nsio->bb,
>  			&nsio->res);
>  
>  	nsio->addr = devm_memremap(dev, res->start, size, ARCH_MEMREMAP_PMEM);
> +	if (IS_ERR(nsio->addr)) {
> +		devm_exit_badblocks(dev, &nsio->bb);
> +		devm_release_mem_region(dev, res->start, size);
> +	}
>  
>  	return PTR_ERR_OR_ZERO(nsio->addr);
>  }
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 34db557dbad1..9faa92662643 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -408,6 +408,7 @@ static int nd_pfn_clear_memmap_errors(struct nd_pfn *nd_pfn)
>  				nsoff += chunk;
>  			}
>  			if (rc) {
> +				devm_namespace_disable(&nd_pfn->dev, ndns);

The disable here seems to be wrong.

This function called from the pmem_attach_disk path, where its expected the
namespace is enabled after the setup_pfn. Also in case of an error, we do
another disable in pmem_attach_disk.
Thanks,
Santosh

>  				dev_err(&nd_pfn->dev,
>  					"error clearing %x badblocks at %llx\n",
>  					num_bad, first_bad);
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index d25e66fd942d..4f667fe6ef72 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -401,8 +401,10 @@ static int pmem_attach_disk(struct device *dev,
>  	if (is_nd_pfn(dev)) {
>  		nd_pfn = to_nd_pfn(dev);
>  		rc = nvdimm_setup_pfn(nd_pfn, &pmem->pgmap);
> -		if (rc)
> +		if (rc) {
> +			devm_namespace_disable(dev, ndns);
>  			return rc;
> +		}
>  	}
>  
>  	/* we're attaching a block device, disable raw namespace access */
> @@ -549,17 +551,15 @@ static int nd_pmem_probe(struct device *dev)
>  	ret = nd_pfn_probe(dev, ndns);
>  	if (ret == 0)
>  		return -ENXIO;
> -	else if (ret == -EOPNOTSUPP)
> -		return ret;
> -
> -	ret = nd_dax_probe(dev, ndns);
> -	if (ret == 0)
> -		return -ENXIO;
> -	else if (ret == -EOPNOTSUPP)
> -		return ret;
> -
> +	else if (ret != EOPNOTSUPP) {
> +		ret = nd_dax_probe(dev, ndns);
> +		if (ret == 0)
> +			return -ENXIO;
> +	}
>  	/* probe complete, attach handles namespace enabling */
>  	devm_namespace_disable(dev, ndns);
> +	if (ret == -EOPNOTSUPP)
> +		return ret;
>  
>  	return pmem_attach_disk(dev, ndns);
>  }
> -- 
> 2.16.4
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
