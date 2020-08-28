Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8D1255698
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Aug 2020 10:39:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CD75C128A7AC5;
	Fri, 28 Aug 2020 01:39:18 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0A618128A7AC2
	for <linux-nvdimm@lists.01.org>; Fri, 28 Aug 2020 01:39:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so141626pgf.0
        for <linux-nvdimm@lists.01.org>; Fri, 28 Aug 2020 01:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=jpa4VFuD9jxmbmSoDNWkXSi1zk0s2ZQfzuNUi81OTl8=;
        b=jqbBXhFaDlhW7CfKBh/tQe35/3prfBlz3ARgoCNk/z7iABXP+OfdQZxc3dUTVePnP9
         WjXcPb7T+DNKNM6eBgu0BA+Rdev9femuAWlEtY4DaHIBX+mcU8QFeK29I43AlgfbnYws
         fi9xKF0tm4dRWKaUoY2E6kD1LXEqvSxGWzA5NKNumw1Wl5uM+KhCM0yNgxqo1aP4pUli
         L4XTzebYZI5jd0Q6tIRIsc9ExjIC0aMUGltMDYk/1iqEjXMxwxURSWGWvsW+Gdwdy1mN
         1QW7yGYhfJ54EC41jmlUGHUWZYHYJrfex325qI1rXOZvFctvPmGozdPOaH1z12zhuTfs
         E26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jpa4VFuD9jxmbmSoDNWkXSi1zk0s2ZQfzuNUi81OTl8=;
        b=EyLTy+iXmYxY2x7sv/ewxga/8lTY2UBEEBUmH+ztwbPZ64KmGEvvi7iCv+HGqY/TUC
         FEh05ezNV3BjU9yJLrWBLMi8zzdF36ArzBVwBQcfa2N8E/LpdmHkZG4evkBa/cUuos46
         J4T95MkFmNvDKe/CnyfLDtnn+mWlQATjezKuJiwAi8FwSlrnyjneZeKjrpveOzYMcBGD
         K+B1BUlQ3WzTinrF2dQ21Ji7P69SNfjJKW0jErDXpCTyLLcygCD5rwLrdOWl3hRIDRpe
         /DPEddOqTwEiTleN9GD5v/Wbqut136qEYhlu+xnE7pBE4U9PgNw0tNXEWRUazTuA9V8S
         6gRA==
X-Gm-Message-State: AOAM530ixwX0xKum3fNPpB77sGAPkE5uAhQtggOWUSBCCiNbIdiiOlUO
	CUd5N7bQ4Ca5UsIua69r1PaGZA==
X-Google-Smtp-Source: ABdhPJz6Kmyi5acWEsFxJbNT/PkrDyHGoCR0W4ogg24e923q2bqTLkRFipgBfLc4b9gUVhCsACBVbQ==
X-Received: by 2002:a62:2a83:: with SMTP id q125mr376018pfq.274.1598603955956;
        Fri, 28 Aug 2020 01:39:15 -0700 (PDT)
Received: from localhost ([203.223.190.240])
        by smtp.gmail.com with ESMTPSA id 9sm805441pfv.22.2020.08.28.01.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 01:39:15 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Michal Suchanek <msuchanek@suse.de>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 2/2] ndctl/namespace: Suppress ENODEV when processing
 all namespaces.
In-Reply-To: <3905bc44eec1a7251ea67729aee9ecf4d6d33653.1595526596.git.msuchanek@suse.de>
References: <ac216d4887a00c468acfb323920426135f6861dd.1595526596.git.msuchanek@suse.de>
 <3905bc44eec1a7251ea67729aee9ecf4d6d33653.1595526596.git.msuchanek@suse.de>
Date: Fri, 28 Aug 2020 14:09:12 +0530
Message-ID: <87d03bcggf.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: AH4IWITMNGE6W6PCWYF7TUKHVT5I3RH6
X-Message-ID-Hash: AH4IWITMNGE6W6PCWYF7TUKHVT5I3RH6
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michal Suchanek <msuchanek@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AH4IWITMNGE6W6PCWYF7TUKHVT5I3RH6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Michal Suchanek <msuchanek@suse.de> writes:

> When processing all namespaces and no namespaces exist user gets the
> default -ENOENT. Set default rc to 0 when processing all namespaces.
> This avoids confusing error message printed in addition to the message
> saying 0 namespaces were affected.
>
> Before:
>
>  # ndctl check-namespace all
> namespace0.0: namespace_check: namespace0.0: check aborted, namespace online
> error checking namespaces: Device or resource busy
> checked 0 namespaces
>  # ndctl disable-namespace all
> disabled 1 namespace
>  # ndctl check-namespace all
> namespace0.0: namespace_check: Unable to recover any BTT info blocks
> error checking namespaces: No such device or address
> checked 0 namespaces
>  # ndctl destroy-namespace all
> destroyed 1 namespace
>  # ndctl check-namespace all
> error checking namespaces: No such device or address
> checked 0 namespaces
>  # ndctl destroy-namespace all
> error destroying namespaces: No such device or address
> destroyed 0 namespaces
>
> After:
>
>  # ndctl check-namespace all
> namespace0.0: namespace_check: namespace0.0: check aborted, namespace online
> error checking namespaces: Device or resource busy
> checked 0 namespaces
>  # ndctl disable-namespace namespace0.0
> disabled 1 namespace
>  # ndctl check-namespace all
> namespace0.0: namespace_check: Unable to recover any BTT info blocks
> error checking namespaces: No such device or address
> checked 0 namespaces
>  # ndctl destroy-namespace all
> destroyed 1 namespace
>  # ndctl check-namespace all
> checked 0 namespaces
>  # ndctl destroy-namespace all
> destroyed 0 namespaces
>  # ndctl destroy-namespace all
> destroyed 0 namespaces
>
> Note: this does change the return value from -ENOENT to 0 in the cases
> when no namespaces exist and processing all namespaces was requested.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

I missed this patch and had a different approach of solving this, fiddling
around with processed and saved_rc in the end of the function. This is
cleaner.

Nit: The default return value is -ENXIO, if that matters in the commit message.

Reviewed-by: Santosh S <santosh@fossix.org>

Thanks,
Santosh

> ---
>  ndctl/namespace.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index 3fabe4799d75..835f4076008a 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -2112,6 +2112,9 @@ static int do_xaction_namespace(const char *namespace,
>  	if (!namespace && action != ACTION_CREATE)
>  		return rc;
>  
> +	if (namespace && (strcmp(namespace, "all") == 0))
> +		rc = 0;
> +
>  	if (verbose)
>  		ndctl_set_log_priority(ctx, LOG_DEBUG);
>  
> -- 
> 2.26.2
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
