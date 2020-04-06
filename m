Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDD19F4DF
	for <lists+linux-nvdimm@lfdr.de>; Mon,  6 Apr 2020 13:39:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3777E10FD2AD7;
	Mon,  6 Apr 2020 04:40:35 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 170BE10FCD94C
	for <linux-nvdimm@lists.01.org>; Mon,  6 Apr 2020 04:40:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o26so7394361pgc.12
        for <linux-nvdimm@lists.01.org>; Mon, 06 Apr 2020 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=TVo5U5Qk5KaqTFJoyOHQL8+EKyddqtlkeUHweeNyqZ0=;
        b=Bg4UnCw71mE6R7n9jpyaZnzOESPfO6Wit11wTpFxMDPw49+X04Pb6K1jOQlOGtHDNd
         h8tF7fYVjKY8stF+XSvQUC11ANVsiWo1O6sAgMFcPZwO4ooakFm/sn4WGHqhipGfpysv
         c0kUJhCdFD3STqO2qxzw9FQtB08Q3bosms+xaVlMo8FXBb062gcRf3/3nyAzMSwVhpFN
         S5nus6FmbpkaH/DWRbSK+qLc5LGPQmSFBJB0zYzHrwNwAZ5kko6ZG+X6AM8EUo6smY5x
         0sLSij6oDqNgX8w97KZ1kQHxOFb3h9zZ9a96Jsyc0aze/BmiMzlQDcO6SYhekOr5VAdZ
         bX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TVo5U5Qk5KaqTFJoyOHQL8+EKyddqtlkeUHweeNyqZ0=;
        b=U0CfjyNwWashhQwPQbB5M6UH43wVPQ7Nl2Gu+VlQcOqyesTdXZFjOUn48rsJBiEG0A
         e0w7ST14qws2Zd3qCY4G0iKwGMcZACjocLDNo8QDdU52aL8fNZrydJ0C5qz1IGS5cHmz
         LLFk1JvGbyerPNx2twVq1Nf6sjESzWIzAVtXaT4EjttUY22BsdJLE388Jov0kTB3qV83
         fAUxXDTvjCZD3OqCCjx10D3j0zDhZAhG9XwQ0LzXlNavUdRE1qYL+JvrMQuUOnFd47Cw
         PrDK9xUkHNdnTx2LqpJNyAOyIXQk2KO82DBaGnphO9776KGdrnrnlgw3rYrGQxja1SnI
         A9uQ==
X-Gm-Message-State: AGi0PuaLSy8RYPkkHK/anDRc96M9HFcaCU1Y5zif+n03qxYe3V+N1nPO
	PMnuOcMDx2JycDP4PwxnbZUeVA==
X-Google-Smtp-Source: APiQypKLlKv3itN7zUskK0eyz5PUt+BHkJHMpS3KUA+Nl/n4TD0WuaCwUjCt4m4BTAB2Z8JkReTz2Q==
X-Received: by 2002:a63:82c2:: with SMTP id w185mr21453657pgd.382.1586173183152;
        Mon, 06 Apr 2020 04:39:43 -0700 (PDT)
Received: from localhost ([2401:4900:3608:7cce:5302:f185:2859:b4e1])
        by smtp.gmail.com with ESMTPSA id u13sm10593150pgp.49.2020.04.06.04.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 04:39:42 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Michal Suchanek <msuchanek@suse.de>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH] ndctl/namespace: skip zero namespaces when processing
In-Reply-To: <20200403210514.21786-1-msuchanek@suse.de>
References: <20200403210514.21786-1-msuchanek@suse.de>
Date: Mon, 06 Apr 2020 17:09:36 +0530
Message-ID: <87zhboc07b.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: QL7IXTQACMRQMY2TQUM7VM47Q2NYAPSM
X-Message-ID-Hash: QL7IXTQACMRQMY2TQUM7VM47Q2NYAPSM
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michal Suchanek <msuchanek@suse.de>, jack@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QL7IXTQACMRQMY2TQUM7VM47Q2NYAPSM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Michal Suchanek <msuchanek@suse.de> writes:

> Hello,
>
> this is a fix for github issue #41. I tested on system with vpmem with
> ndctl 64.1 that the issue is fixed. master builds with the fix applied.
>
> 8<-------------------------------------------------------------------->8
>
> The kernel always creates zero length namespace with uuid 0 in each
> region.
>
> When processing all namespaces the user gets confusing errors from ndctl
> trying to process this namespace. Skip it.
>
> The user can still specify the namespace by name directly in case
> processing it is desirable.
>
> Fixes: #41
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  ndctl/namespace.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Santosh S <santosh@fossix.org>

Tested on a vpmem system with master branch, and I can see the issue got fixed.

# ./ndctl/ndctl enable-namespace all
error enabling namespaces: No such device or address
enabled 24 namespaces

After this patch

# ./ndctl/ndctl enable-namespace all 
enabled 24 namespaces

Thanks,
Santosh

>
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index 0550580707e8..6f4a4b5b8883 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -2128,9 +2128,19 @@ static int do_xaction_namespace(const char *namespace,
>  			ndctl_namespace_foreach_safe(region, ndns, _n) {
>  				ndns_name = ndctl_namespace_get_devname(ndns);
>  
> -				if (strcmp(namespace, "all") != 0
> -						&& strcmp(namespace, ndns_name) != 0)
> -					continue;
> +				if (strcmp(namespace, "all") == 0) {
> +					static const uuid_t zero_uuid;
> +					uuid_t uuid;
> +
> +					ndctl_namespace_get_uuid(ndns, uuid);
> +					if (!ndctl_namespace_get_size(ndns) &&
> +					    !memcmp(uuid, zero_uuid, sizeof(uuid_t)))
> +						continue;
> +				} else {
> +					if (strcmp(namespace, ndns_name) != 0)
> +						continue;
> +				}
> +
>  				switch (action) {
>  				case ACTION_DISABLE:
>  					rc = ndctl_namespace_disable_safe(ndns);
> -- 
> 2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
