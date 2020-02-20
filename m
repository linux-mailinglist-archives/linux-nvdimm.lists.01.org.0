Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 778BB1655DF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Feb 2020 04:53:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8860410FC339D;
	Wed, 19 Feb 2020 19:54:00 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 48D6D1003ECBD
	for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 19:53:59 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d9so985654plo.11
        for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 19:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=OJQI1O+wncsLf6OJpSffVkGuuXAMhkTM7kqX4B6lt6Y=;
        b=y3AHXZam2D3GXM3KLC5pe2HF+1CJm9kfrxv9IVzgG18iklkq9hYZW5K5UF523ZShDk
         mznQBo3nu7Lvss08DNyZRw3J7QIDc9mRCzq/qbWOxNmJB1uG7ejJmNXk+jPxaJG4qz2H
         mEoqCx3k5O+exRCektgQING5TAYLD1c5VySDULk5/Vae9pj33D7uVlvJVQ0oN42oOu50
         YTsscrOhNvdLyJLfPyUmNMFxQ2FQG/m3liLn6oIgIGSZivdg5BLzGaqDXyDl+CLUZ3Np
         rZbVV9Zdu8D5CcXWFKcDDtZwI2cTuYOLt7nrLmFiMouGXJVxUC6/4IR76SlUKv0hDVfS
         uJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OJQI1O+wncsLf6OJpSffVkGuuXAMhkTM7kqX4B6lt6Y=;
        b=iaEtvzKNH6SH2TwelvNhjz6jSJdCKPvpkDRo1RB8jRwKGzPNTwCqv3Y3Q0fWWN6ybY
         yEMXhMoIT5M9ZtzPYiEJc2gk8y4V5yEyH577WC86LBurQbZkBKlN1ISd5UcK7wpRAZQi
         9Vo1wmmVribm3svMGbZb4LWlHzjLLU4KqR0R44m3WjYUO7RMf/kvk4zdeElcjqeJ35Xo
         +7HoTah1Q5megycEN6hQfXcTZU8BUy/RvhWKd94hOdKuZgVDRs3MDaMFRM1ja117NkH6
         FGckE+bEKLS95iETJhQySgKPrprCVIqRiyGkbzLdzOEvokrFps47DpYSyekqTqSqQWKc
         6o7Q==
X-Gm-Message-State: APjAAAVOPsD/8+uQ2dcu48eR2XsbpDMmZPNwRLcxOBSPytLkvfXGT4h4
	hRQKXH8/f73kpdMA2kBAfmDYxmrSAjs=
X-Google-Smtp-Source: APXvYqwiSNmLBHsiOzXYcdI+YXYvGM54of2+JeHG9OcsLQ0buksPGXYNtFSZ6iTumQJq04x0+B+qXw==
X-Received: by 2002:a17:902:6ac3:: with SMTP id i3mr29036900plt.111.1582170786235;
        Wed, 19 Feb 2020 19:53:06 -0800 (PST)
Received: from localhost ([129.41.84.76])
        by smtp.gmail.com with ESMTPSA id o16sm1175357pgl.58.2020.02.19.19.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 19:53:05 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 ndctl] ndctl/namespace: Fix enable-namespace error for seed namespaces
In-Reply-To: <20200113042453.3579711-1-santosh@fossix.org>
References: <20200113042453.3579711-1-santosh@fossix.org>
Date: Thu, 20 Feb 2020 09:23:02 +0530
Message-ID: <87h7zlykwx.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: 2GFUWI3VH6WXKY3MIFDXPS4VDGDEGYIJ
X-Message-ID-Hash: 2GFUWI3VH6WXKY3MIFDXPS4VDGDEGYIJ
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2GFUWI3VH6WXKY3MIFDXPS4VDGDEGYIJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Santosh Sivaraj <santosh@fossix.org> writes:

> 'ndctl enable-namespace all' tries to enable seed namespaces too, which results
> in a error like
>
> libndctl: ndctl_namespace_enable: namespace1.0: failed to enable

Dan/Vishal,

Will this patch be taken in the next ndctl release?

Thanks,
Santosh

>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  ndctl/lib/libndctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index 6596f94..9c6ccb8 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -4010,11 +4010,16 @@ NDCTL_EXPORT int ndctl_namespace_enable(struct ndctl_namespace *ndns)
>  	const char *devname = ndctl_namespace_get_devname(ndns);
>  	struct ndctl_ctx *ctx = ndctl_namespace_get_ctx(ndns);
>  	struct ndctl_region *region = ndns->region;
> +	unsigned long long size = ndctl_namespace_get_size(ndns);
>  	int rc;
>  
>  	if (ndctl_namespace_is_enabled(ndns))
>  		return 0;
>  
> +	/* Don't try to enable idle namespace (no capacity allocated) */
> +	if (size == 0)
> +		return -ENXIO;
> +
>  	rc = ndctl_bind(ctx, ndns->module, devname);
>  
>  	/*
> -- 
> 2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
