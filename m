Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F44535FD55
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Apr 2021 23:33:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D52DC100EB34D;
	Wed, 14 Apr 2021 14:33:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.208.50; helo=mail-ed1-f50.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CDA2C100EB32F
	for <linux-nvdimm@lists.01.org>; Wed, 14 Apr 2021 14:33:53 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id w23so25462116edx.7
        for <linux-nvdimm@lists.01.org>; Wed, 14 Apr 2021 14:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+EL53n0yuorpfM8ie1VXCwkfxK+pJPw69S7mTIt8DE=;
        b=0tr5XttJwbvea5EmEXKETAgihhgArhValkDY6QV52Pgie1fo8twOPe56FbMI5H9QUp
         ZkL2JpeyHdxVyvBu10a3ikiauCGmNxyBmo1qx8fY879eH4giNDCFrdUi+KxI1qcREw9m
         zNtext8+fcYXOvqY/Mtq/zET9XWIrHLB9FRqBVYnHzaOpN5h1g85xPRZ+RfbjdBhvQ3M
         aZy+ZL0NmvyHYkZMn+FQDCQQbuLXBjQHNphYtIo1ibtKLuTGM5L75QdnBYt2iWtiCIbq
         uChl4ul+z4qvQnMxGGYPMdPcZXz5jQtVQg1SmMBLWm4TTaBXmRGL4LSWCUV87y7oPAdS
         7gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+EL53n0yuorpfM8ie1VXCwkfxK+pJPw69S7mTIt8DE=;
        b=K1OjOzaeJhjvXBzf67fGXMIwYn9Kdfs82pKqQaELDYNm2M070IUx0JJGbNKI48V4pP
         HNAcTpnK4qItym0NObao7szFgCJMHzwdA3KshPew/Fm4aK+u7X1gD2xQG+mGOBJKjVkW
         wQngId0GH1IMid0o+1uLaswL9u0+G7PJj4CWzA1EMhzPDg3lQYjvS80UUwdsocttQWa0
         OWWcfDn87ufI3c/knfHehbdpn/vJ3oxbQCfPfXxchRsusHAe509+8EQEJ0bEcrwzG4JN
         ni5vG8dKuwu+jV3haz2mr0ypc81DbUg1zhyv6PogXUxDLDv63SSUDJaBDRmlCjiBm2NP
         R+Tg==
X-Gm-Message-State: AOAM533fCpOIu1aHykNX2CsoH+hqGZVz9fSm4msl2rH/iPAererfJioP
	xX3aii5EslsgDDIvfly2eKh31c8YlGPaNbB+8xywmQ==
X-Google-Smtp-Source: ABdhPJx2m8GLYdi4bgKhHMXOir3vZoU1jwxM4yQbbNjzw7AislrWHIKadhfbXeg9srvTbLQFSv4rr7zEZV+rj12WwME=
X-Received: by 2002:aa7:cd7b:: with SMTP id ca27mr298423edb.354.1618435971843;
 Wed, 14 Apr 2021 14:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210414124026.332472-1-vaibhav@linux.ibm.com>
In-Reply-To: <20210414124026.332472-1-vaibhav@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 14 Apr 2021 14:32:40 -0700
Message-ID: <CAPcyv4iU3cmjRsDevDJmJc72xo-QffUu3SGCwvRh5bitG-facw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/papr_scm: Reduce error severity if nvdimm stats inaccessible
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: LOFBNY3D2TB2OA3KFPHD6LWDIXINMPBP
X-Message-ID-Hash: LOFBNY3D2TB2OA3KFPHD6LWDIXINMPBP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LOFBNY3D2TB2OA3KFPHD6LWDIXINMPBP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 14, 2021 at 5:40 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Currently drc_pmem_qeury_stats() generates a dev_err in case
> "Enable Performance Information Collection" feature is disabled from
> HMC. The error is of the form below:
>
> papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Failed to query
>          performance stats, Err:-10
>
> This error message confuses users as it implies a possible problem
> with the nvdimm even though its due to a disabled feature.
>
> So we fix this by explicitly handling the H_AUTHORITY error from the
> H_SCM_PERFORMANCE_STATS hcall and generating a warning instead of an
> error, saying that "Performance stats in-accessible".
>
> Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 835163f54244..9216424f8be3 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -277,6 +277,9 @@ static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
>                 dev_err(&p->pdev->dev,
>                         "Unknown performance stats, Err:0x%016lX\n", ret[0]);
>                 return -ENOENT;
> +       } else if (rc == H_AUTHORITY) {
> +               dev_warn(&p->pdev->dev, "Performance stats in-accessible");
> +               return -EPERM;

So userspace can spam the kernel log? Why is kernel log message needed
at all? EPERM told the caller what happened.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
