Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF23F119046
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Dec 2019 20:02:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1DEF510113614;
	Tue, 10 Dec 2019 11:05:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 527CD10113613
	for <linux-nvdimm@lists.01.org>; Tue, 10 Dec 2019 11:05:45 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id v140so10883904oie.0
        for <linux-nvdimm@lists.01.org>; Tue, 10 Dec 2019 11:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XYrI9DkfUc2ykiq6b6ysEux5dCVg9XK+T8cZYiLt28=;
        b=IA+2dChlDfueAPMspCYawsRD3X9H0Wwwzfr41KaqFkI6IAc8nEZOV8HPfiTjx4cX+h
         NOG4HQKBvxPWG9XRjxUbQFkFdu33gSd+8OH2wjRLtV5PhOvQF59NMWEJ0eXPJtkbPR97
         c+tsw/LxLBgEJlMezjOddGPM8hiSJzfw81dlgl7ikeDdJVMWFTXVIW+SsDw5Xli09OQq
         hizWOeIPPC+bFLiHh0zhZqbg3RoPisGHjmQ49ZExg0i8VEMoklheqCz6s06gmA9RUaBH
         XYjVIiYGOZfgP2WiEG36lSpbcYU97pSSE/X542nUEOeUX/Q7WeWoHTzcZDQsELqZ9ljW
         YNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XYrI9DkfUc2ykiq6b6ysEux5dCVg9XK+T8cZYiLt28=;
        b=a/S/2t0J1nYxvzTtuQPxHK+7mzvCPzE531Gza+Jz/ddWUL7K8dppJ+mE7K+ikKs+jW
         creDmZjNVm4PP82yh8BE58TAA+6xuX9K8OGC8lEypJteCxqMVdlISFYg22Ew4a7m5o6V
         dHQDhLueyqj04+XzNNV0PpmDeeH/vDTctqeKViN3ETK/axCUofcM/M1JHg8LACXDrF6K
         UAZv3+a2w4rMe3xhIFk13pZA8pXeRV//4FPWLCLHw736oeIdipGuztLtE45H85TyNmXo
         F3C6NOVzxXjVc9k5pvUkO5bLL7a7J6GngfUYgZonGvmJz20uENk/bFuxjFpwBravt7cf
         QvBA==
X-Gm-Message-State: APjAAAWk2AvoZvrliG0ZooDLuQIWuN3AIdfErDrlymvGuoA+E9QOu0Ss
	8ervlyGVyFQ92AnBrWSddIwbO73xWfG3hqlYGMb28w==
X-Google-Smtp-Source: APXvYqzhbUIS0qz2iiMhOt+A1dtTtb1aSQ3/eEB6Et6MMNlT5gWpwSm2wg8yILfXLBA54VBv1V4T2lKa3S1RBjAneoU=
X-Received: by 2002:a05:6808:7da:: with SMTP id f26mr202506oij.73.1576004542592;
 Tue, 10 Dec 2019 11:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20191206053520.235805-1-santosh@fossix.org>
In-Reply-To: <20191206053520.235805-1-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Dec 2019 11:02:11 -0800
Message-ID: <CAPcyv4gh0yJ62Ki2NWmRDOiinqiv2v_snQ3_JWNhqVMfLCQ6Rg@mail.gmail.com>
Subject: Re: [ndctl V2] namespace/create: Don't create multiple namespaces
 unless greedy
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: E4CFCRYZFAKYMINUOPGHNE4DCLBPAM4J
X-Message-ID-Hash: E4CFCRYZFAKYMINUOPGHNE4DCLBPAM4J
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Vaibhav Jain <vaibhav@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E4CFCRYZFAKYMINUOPGHNE4DCLBPAM4J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 5, 2019 at 9:35 PM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> From: Vaibhav Jain <vaibhav@linux.ibm.com>
>
> Currently create-namespace creates two namespaces with the '-f' option
> even without the greedy flag. This behavior got introduced by
> c75f7236d. The earlier behaviour was to create one namespace even with
> the '-f' flag. The earlier behavior:
>
> $ sudo ./ndctl/ndctl create-namespace -s 16M -f
> [sudo] password for santosh:
> {
>   "dev":"namespace1.14",
>   "mode":"fsdax",
>   "map":"dev",
>   "size":"14.00 MiB (14.68 MB)",
>   "uuid":"03f6b921-7684-4736-b2be-87f021996e52",
>   "sector_size":512,
>   "align":65536,
>   "blockdev":"pmem1.14"
> }
>
> After greedy option was introduced:
>
> $ sudo ./ndctl/ndctl create-namespace -s 16M -f
> {
>   "dev":"namespace1.8",
>   "mode":"fsdax",
>   "map":"dev",
>   "size":"14.00 MiB (14.68 MB)",
>   "uuid":"1a9d6610-558b-454e-8b95-76c6201798cb",
>   "sector_size":512,
>   "align":65536,
>   "blockdev":"pmem1.8"
> }
> {
>   "dev":"namespace0.3",
>   "mode":"fsdax",
>   "map":"dev",
>   "size":"14.00 MiB (14.68 MB)",
>   "uuid":"eed9d28b-69a2-4c7c-9503-24e8aee87b1e",
>   "sector_size":512,
>   "align":65536,
>   "blockdev":"pmem0.3"
> }
>
> The force flag makes sense only in the case of a reconfiguration or
> greedy namespace creation.
>
> Fixes: c75f7236d (ndctl/namespace: add a --continue option to create namespaces greedily)
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  ndctl/namespace.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index 7fb0007..b1f2158 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -1388,11 +1388,9 @@ static int do_xaction_namespace(const char *namespace,
>                                         (*processed)++;
>                                         if (param.greedy)
>                                                 continue;
> -                               }
> -                               if (force) {
> -                                       if (rc)
> +                               } else if (param.greedy && force) {
>                                                 saved_rc = rc;
> -                                       continue;
> +                                               continue;

Looks good, applied.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
