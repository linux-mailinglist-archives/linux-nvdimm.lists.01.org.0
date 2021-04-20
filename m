Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9307F365266
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 08:35:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D552D100EB859;
	Mon, 19 Apr 2021 23:35:19 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 69EE7100ED4A4
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 23:35:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i190so24838672pfc.12
        for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 23:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=7/qJ+cWoLN2A/P8WkshNqGRepxTOeMXYyCN2UuSNZCM=;
        b=jdj4MjgWpF34rkrJSdiyReLgxfoxC7wvQbYHqk2uCdrupaAQ5ie7nx5dLbMkD5r66M
         eTIemT1H6xc97dYEODsbf4M5W192Bxw3tO5T6GpPMKEuRlgb0bKMEdxIzjVbddIviyl1
         7BPdu0ERl5CUaQU5A2E95CN21V3Rsd98UCNF1pBLoYyZ9yluhxjc3kmwZq1P6kBtYBJp
         qFSZw8i5hvT9JVUefGGx4n5Lx2JAx7+67oP7PTEDIMDlU0G6EEHQSnpgkVQDXCYfGMUa
         /Qf895uwty2KlqrtlgB9953Z5JtVIQuj0QTQd9iDHoqexj/HtzZzPPXcZRE7il8M1U0e
         ++KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7/qJ+cWoLN2A/P8WkshNqGRepxTOeMXYyCN2UuSNZCM=;
        b=hInlez0+/WZDl12B8BauWU9cTUkrCUbmSvpYoWgnXsFuLaxxY/4LvOkA8CH9Mh9PQO
         bxWoFKeF8u6aCCB3W6025mzE4XuVZ7gdRNW38vUq5CUw5B1LruxYn5b2QHpZQljUvZHO
         FupeRXdaWjQchQTDxXopFUWYqf6osLI2WAbHHFEAqaBQjVrtKkLiNP3X8cttLKV2imBy
         7d6rqdEZNA06NddILhfVISkTkZcCbyxIv0bkhrgYraXRWPPDIxm3M6FOMkLxFG5PKE+G
         yFn0cH39uVNTS+A1byz61BK567xn0pqo9BKCQe3AJ1kbV4OZhrh06+u172nQxPwdmxWv
         WYng==
X-Gm-Message-State: AOAM5330uhKfGazcnBRrEFkm/mN08AECGevUWbuW6YR1FLASJP78IGGt
	MtyQEFiU+iJvQX5VYhxGzqWofA==
X-Google-Smtp-Source: ABdhPJyB7+uL61SnopVxjLZEHqrP4CokPtaLTSzBN/xx8opJvyhg4vc8W+MeBl/M+6FrIzoA3gw83Q==
X-Received: by 2002:a62:170e:0:b029:1fa:7161:fd71 with SMTP id 14-20020a62170e0000b02901fa7161fd71mr23040906pfx.35.1618900515537;
        Mon, 19 Apr 2021 23:35:15 -0700 (PDT)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id y29sm13989232pfq.29.2021.04.19.23.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 23:35:15 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Zou Wei <zou_wei@huawei.com>, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH -next] tools/testing/nvdimm: Make symbol
 '__nfit_test_ioremap' static
In-Reply-To: <1617779451-81730-1-git-send-email-zou_wei@huawei.com>
References: <1617779451-81730-1-git-send-email-zou_wei@huawei.com>
Date: Tue, 20 Apr 2021 12:05:11 +0530
Message-ID: <87h7k1zco0.fsf@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: EDWVCKATEVPU3YSC3F3P4XIUBPK5WWRL
X-Message-ID-Hash: EDWVCKATEVPU3YSC3F3P4XIUBPK5WWRL
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Zou Wei <zou_wei@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EDWVCKATEVPU3YSC3F3P4XIUBPK5WWRL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi Zou,

Zou Wei <zou_wei@huawei.com> writes:

> The sparse tool complains as follows:
>
> tools/testing/nvdimm/test/iomap.c:65:14: warning:
>  symbol '__nfit_test_ioremap' was not declared. Should it be static?
>
> This symbol is not used outside of security.c, so this

s/security.c/iomap.c/

Thanks,
Santosh

> commit marks it static.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  tools/testing/nvdimm/test/iomap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
> index c62d372..ed563bd 100644
> --- a/tools/testing/nvdimm/test/iomap.c
> +++ b/tools/testing/nvdimm/test/iomap.c
> @@ -62,7 +62,7 @@ struct nfit_test_resource *get_nfit_res(resource_size_t resource)
>  }
>  EXPORT_SYMBOL(get_nfit_res);
>  
> -void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
> +static void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
>  		void __iomem *(*fallback_fn)(resource_size_t, unsigned long))
>  {
>  	struct nfit_test_resource *nfit_res = get_nfit_res(offset);
> -- 
> 2.6.2
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
