Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D071219820
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jul 2020 07:58:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A6DA111F370A;
	Wed,  8 Jul 2020 22:57:58 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8A460111E7BFD
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 22:57:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so388121plo.7
        for <linux-nvdimm@lists.01.org>; Wed, 08 Jul 2020 22:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=4sDYmu482bY1BrQBt6HZKsmlilbAMUNkWKPaetKFPVE=;
        b=hDZTlVHZJsdM//L7VumfGc1QTBStnyU1YKV4XDDqFlgV0xwn2M//IAK+6JgcZz5A2M
         Qvt2Pj0uxnLYKSNEv2l21dRzWSVZkk1ydhLlrv42q7KwuQHCQ8/bByni8yW2JE0/uCnP
         0kSsdAAoQ7g0o1nkwfdWtU1kW+nA0aIByH1x7c4qPjNUiN/0tmNFcGWGFiLdWetikFTA
         A9yTBeiFICbIv7SDcJ2ZJTgJ/Zy0tb9V9R2Co+GZuIPufnb7r7vgherRLYz8l5hhS1vV
         t7ai4Rtkz8Pwsz4dGAFEOfOe7wmVhmR46snvZo86tj/0r9/LG3B0ximreW8EuohHHet9
         VuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4sDYmu482bY1BrQBt6HZKsmlilbAMUNkWKPaetKFPVE=;
        b=lJzfmXiAw6F1ZfufzL3TMDO7gYpLWkxARlNzSJIAC2nSsZXjNidT9sFHRLAYbuJVhw
         uyuPo570jaq7xAcahiYRHpk32pkOm4NBUwaQMQXD91A0DMlgWDq2MD1MaLeqZa1LdW9v
         9+CQUSCLUm+F/LKaJuPrxbfYQvO+xVsr3uCAfsaLczVIT5ziMIbz+FzZ4TvDfDdRoE8C
         poh2fayXaeYMBv5MUaXqVntpwOi2HUXCxU/ccTFJ7PRqv4ZOuNgdJRwx6OA61Ox402sJ
         464RRKZMYqt/AXj0LwtYD3Lb71P+Jz6567zNmNHkccOzf03W3hI08C/nr9M74EFt/0mI
         675Q==
X-Gm-Message-State: AOAM533To8EEjO0zrdWZ+PIx4Uj0hGPK73Wy4RpF+saCEGYbhP9ZQNWN
	qfk7LSJMQp3LZ2bwJnDpxYaDIQ==
X-Google-Smtp-Source: ABdhPJypnNM8wDlk1LExEYG+9hPU1VeLZQKck6m4Bbd/cNT8JszyzoYu+gll8w8zLr8Q6ubsxQy6UA==
X-Received: by 2002:a17:90a:f2c3:: with SMTP id gt3mr13734065pjb.92.1594274275218;
        Wed, 08 Jul 2020 22:57:55 -0700 (PDT)
Received: from localhost ([203.223.190.240])
        by smtp.gmail.com with ESMTPSA id h17sm1511700pgl.22.2020.07.08.22.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 22:57:54 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Hannes Reinecke <hare@suse.de>, Dan Williams <dan.williams@intel.com>
Subject: Re: [PATCH] libnvdimm: call devm_namespace_disable() on error
In-Reply-To: <20200703111856.40280-1-hare@suse.de>
References: <20200703111856.40280-1-hare@suse.de>
Date: Thu, 09 Jul 2020 11:27:52 +0530
Message-ID: <87sge1qlgf.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: JOHFASEHHOZEONDD6IXWIW4A7IPKEPPX
X-Message-ID-Hash: JOHFASEHHOZEONDD6IXWIW4A7IPKEPPX
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Hannes Reinecke <hare@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JOHFASEHHOZEONDD6IXWIW4A7IPKEPPX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi! Hannes,

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

[snip]

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

As mentioned in the previous mail, when rc != 0, disable is called again
here.

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
                        ^ -EOPNOTSUPP

Thanks,
Santosh
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
