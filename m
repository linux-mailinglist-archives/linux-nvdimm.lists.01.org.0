Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E7035AAE7
	for <lists+linux-nvdimm@lfdr.de>; Sat, 10 Apr 2021 06:48:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5BC24100ED4A4;
	Fri,  9 Apr 2021 21:47:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.218.48; helo=mail-ej1-f48.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3021C100EF27B
	for <linux-nvdimm@lists.01.org>; Fri,  9 Apr 2021 21:47:55 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id r12so11765931ejr.5
        for <linux-nvdimm@lists.01.org>; Fri, 09 Apr 2021 21:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUlfB1PxZBzlfWVsuUB7DoL8DuKow3SV9dkNKtJvQl8=;
        b=PzQhs3H25xBuEYyUuPo1yLzVyCoU4N/t0VWEL8AOXuDQSs2wcAI9VZN8o2dgCSRUDe
         X4d2cIwPXZynRMrC+yajC5Pbc4DGfcF3gk/k4cW3ioDxu/YJaocpElpdw4OYTY2ZfDZg
         gSlXC2FKii/z7NsYL7TiXKIEac6Eg4wXWRkdWWf0grlxBEElUHiKKaBFJU2a1wjCbPSw
         sY/vf+WF4e7Rsu3iRK5EshDj5I60pMUAkIGZN+8lE+8av/dC3Nva4u5+28P0zVaI0cps
         CTs15kwMvwxv+x6cnQ3D3H/eI7nml7J/FwbGneMTipx6oUtGiA3/kH1Dt170mFCZL4Dp
         Jzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUlfB1PxZBzlfWVsuUB7DoL8DuKow3SV9dkNKtJvQl8=;
        b=U9jCYHhxzL9YHVy5GBPGUQ+gEFk7KDkSPza8W4D3usnXWocXitFwN/G83XDpia5Qj7
         Gr0YMQGx/2uzj40BuEUv6bW0bbiYR8vijoRZkmrAHOPegFUw9Qm4tTw5zekBvCOLQvBp
         6imVj7CU6Wnah6VpKUkWSTwUdr9cROq5JSLQ3bTnsTB93WtWYLpZaQ9oBPWhJff4PpP6
         Xtrjxq5o8fotj3wukvTbi5pDSCP29LbG9REB/2h8LcfGeOQU+FTCt2N0jaX9te+KIxnT
         MTkJMfSCpMEOSzAZ6rYAB/3DET7LfdFoCSiGUccljfUcQnjGZVyxQIbZ6hdylRuARcbN
         U7mA==
X-Gm-Message-State: AOAM531vsl6ZLSIpNxVoeaW1VirKEbni+Tmjqw9WIxDguN0wSLQzTqjY
	pkBADPsOKn1KJCLMpPzKXFCPqfrsLzmTGiKa9f8X6A==
X-Google-Smtp-Source: ABdhPJw3BRny/nJ7YDCP9ZhZf9s/VYBIkbIoCCUxoMpLv6fa/HUI85KJ0IONcGK3hVwT7KMYKnW6xjZIQ3UXjJYi0BU=
X-Received: by 2002:a17:906:ef2:: with SMTP id x18mr19292226eji.323.1618030013674;
 Fri, 09 Apr 2021 21:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210402092555.208590-1-vaibhav@linux.ibm.com>
In-Reply-To: <20210402092555.208590-1-vaibhav@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 9 Apr 2021 21:46:45 -0700
Message-ID: <CAPcyv4io=1xkqNYbMxrrAgY_TzD1_W0cLQvirk1EuurjA_+h=A@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/region: Update nvdimm_has_flush() to handle ND_REGION_ASYNC
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: 3KMBMRSFQ6MAOG55FTQST7E2LS6DN23B
X-Message-ID-Hash: 3KMBMRSFQ6MAOG55FTQST7E2LS6DN23B
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Aneesh Kumar K <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shivaprasad G Bhat <sbhat@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3KMBMRSFQ6MAOG55FTQST7E2LS6DN23B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 2, 2021 at 2:26 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> In case a platform doesn't provide explicit flush-hints but provides an
> explicit flush callback via ND_REGION_ASYNC region flag, then
> nvdimm_has_flush() still returns '0' indicating that writes do not
> require flushing. This happens on PPC64 with patch at [1] applied,
> where 'deep_flush' of a region was denied even though an explicit
> flush function was provided.
>
> Fix this by adding a condition to nvdimm_has_flush() to test for the
> ND_REGION_ASYNC flag on the region and see if a 'region->flush'
> callback is assigned.

Looks good.

>
> References:
> [1] "powerpc/papr_scm: Implement support for H_SCM_FLUSH hcall"
> https://lore.kernel.org/linux-nvdimm/161703936121.36.7260632399 582101498.stgit@e1fbed493c87

Looks like a typo happened in that link, I can fix that up. I'll also
change this to the canonical "Link:" tag for references.

>
> Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  drivers/nvdimm/region_devs.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index ef23119db574..e05cc9f8a9fd 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1239,6 +1239,11 @@ int nvdimm_has_flush(struct nd_region *nd_region)
>                         || !IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API))
>                 return -ENXIO;
>
> +       /* Test if an explicit flush function is defined */
> +       if (test_bit(ND_REGION_ASYNC, &nd_region->flags) && nd_region->flush)
> +               return 1;
> +
> +       /* Test if any flush hints for the region are available */
>         for (i = 0; i < nd_region->ndr_mappings; i++) {
>                 struct nd_mapping *nd_mapping = &nd_region->mapping[i];
>                 struct nvdimm *nvdimm = nd_mapping->nvdimm;
> @@ -1249,8 +1254,8 @@ int nvdimm_has_flush(struct nd_region *nd_region)
>         }
>
>         /*
> -        * The platform defines dimm devices without hints, assume
> -        * platform persistence mechanism like ADR
> +        * The platform defines dimm devices without hints nor explicit flush,
> +        * assume platform persistence mechanism like ADR
>          */
>         return 0;
>  }
> --
> 2.30.2
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
