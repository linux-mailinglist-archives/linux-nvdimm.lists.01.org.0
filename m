Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EB213758D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Jan 2020 18:56:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 84B9E10097DD5;
	Fri, 10 Jan 2020 09:59:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 79E7C10097DD2
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 09:59:57 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id k14so2782235otn.4
        for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 09:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3PWjx3JfKLsAXlDElcUMaB7uUfwmy5lvbGHGy1SJK4=;
        b=NBesgImpfZTueLo5VrUYb4CNOZNGlX3yIGmQQjVi1E21PwUTORK9s/awLYxZSm3/jv
         ROx1ujiyYMbmujdJFRlG3TVgLdn1kr2CSft9kLvlIpBeE+JLVxXx3/oLKTRqgTPMwF2j
         i+kqaTvGvr7I3bk+/MdgAU/hvHoSLIjoEPbKnMQdmcXnGwsc+WotJ21kMhoKWG9ZJZzb
         i3na2SP3AC40uBhiEqPYbWkbxzHeNsBgFTl/32lSw0/vz82mz3NOMA5g2YpRCvZi7WqE
         kQ/RD1bhkrdjWKC/07DPThVLaTX9KjR531GguSMVO4qlV9/kRDEJszOQmrTyj+2PBRu8
         uAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3PWjx3JfKLsAXlDElcUMaB7uUfwmy5lvbGHGy1SJK4=;
        b=AEmqVWiRIcey9t1V3TxEiEOaTz4WoHwi14dEabnwplWrNVdrJJhVjkKfy6EKNyqhPd
         2Dkm7Fsdtbp+QtWGIFm8mDKEz43W2QsP5rOEjUW8EWslYYEj7EOV8DFbcMfMHeuaI5X0
         W6zmjd84J3wqUQu5UynZ/Amc5OJDpA8n6Hnqjuc116l1+QdDRVcTDOp50FfxcrJggqM2
         F4beSnDawQve+/1RYwvAEBlcHaPkmJCO97ZVPJ2wzKGkuyVytFU8FECovdOHR2ss437x
         VMJeHoewyghKYp/+TQFK2elQy+0oHGKDQNiI9AKsVmoERT0qY4Z9kdVhudG7FgdR4zOE
         Dazw==
X-Gm-Message-State: APjAAAUjlf7y1NzNp5v1BOcURH85rKox68YlWlzgP/FrVRGKrl1uicYc
	y0LyWEXNc6af+B7cXsdldh/YODPEUXDqYYBju7HR7w==
X-Google-Smtp-Source: APXvYqz+QrVu67/pBuFiBABU3ocZu9tMGl2+pqO8AAJy5OPsBl7k+eet4z8xwsrmd8mfOP56/EOK9fZ1Q5ebsSBaRcY=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr3479557oto.207.1578678997162;
 Fri, 10 Jan 2020 09:56:37 -0800 (PST)
MIME-Version: 1.0
References: <157854344810.1994459.8270881085555839853.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200110082017.3485529-1-santosh@fossix.org>
In-Reply-To: <20200110082017.3485529-1-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 Jan 2020 09:56:26 -0800
Message-ID: <CAPcyv4h-ke4Jorqx6md+gfgVupNgXn-qm8Yx7vaLNa4O+91jeg@mail.gmail.com>
Subject: Re: [PATCH ndctl] ndctl/namespace: Fix enable-namespace error for
 seed namespaces
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: KPUCC6EZB3TMKJD6SZX2FSUOLIL3HKV4
X-Message-ID-Hash: KPUCC6EZB3TMKJD6SZX2FSUOLIL3HKV4
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, harish@linux.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KPUCC6EZB3TMKJD6SZX2FSUOLIL3HKV4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 10, 2020 at 12:21 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> 'ndctl enable-namespace all' tries to enable seed namespaces too, which results
> in a error like
>
> libndctl: ndctl_namespace_enable: namespace1.0: failed to enable
>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  ndctl/lib/libndctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
> index 6596f94..4839214 100644
> --- a/ndctl/lib/libndctl.c
> +++ b/ndctl/lib/libndctl.c
> @@ -4010,11 +4010,16 @@ NDCTL_EXPORT int ndctl_namespace_enable(struct ndctl_namespace *ndns)
>         const char *devname = ndctl_namespace_get_devname(ndns);
>         struct ndctl_ctx *ctx = ndctl_namespace_get_ctx(ndns);
>         struct ndctl_region *region = ndns->region;
> +       unsigned long long size = ndctl_namespace_get_size(ndns);
>         int rc;
>
>         if (ndctl_namespace_is_enabled(ndns))
>                 return 0;
>
> +       /* Don't try to enable idle namespace (no capacity allocated) */
> +       if (size == 0)
> +               return -1;

Concept looks good to me, just resend with that -1 changed to a named
error code (-ENXIO).
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
