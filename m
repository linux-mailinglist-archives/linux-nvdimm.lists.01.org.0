Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EABB19DC03
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 18:50:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 87560100EAAEC;
	Fri,  3 Apr 2020 09:51:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1DE38100EAAE9
	for <linux-nvdimm@lists.01.org>; Fri,  3 Apr 2020 09:51:24 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id z65so10075488ede.0
        for <linux-nvdimm@lists.01.org>; Fri, 03 Apr 2020 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6glmCooqmX1TL2gqOpcBPZ8TWDFCGWic5SQqj7XIi90=;
        b=JYPaVe/dmUa35Udq2s4/mDDPbRhi0hGH2xYkSv042JInpO5ZklU+21O+7pHBVKRAiO
         XH11Nws4bcVWw68XB+XwrQBGqRVebOZyZF+h8zmYrANJGLAjBgXYUdziXAZ2mJLVC9Wp
         ZtWdVgaxvEoo8Mh+aO4JaTLySNrpJ4XpBW2BFNCPsPWfx+OJr+0gfj57kcYs4rylEb2N
         p9PrtR9l8n/AsrUwuS4Gbelfy0pdiWUQHcyDr9KfCNoE50Se7SusrLjV3AbiqXYE+GZ+
         QXLr0hixNciYfqCk5aCvpo1vQLpGgAbBTlpCidPlopnBxuHebcRk/fRfPbj44FQV5B5n
         yk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6glmCooqmX1TL2gqOpcBPZ8TWDFCGWic5SQqj7XIi90=;
        b=XfxSUCPQJ+BMgpWbfmDjAiLYytRhFmPHa22G1ikkiy/D5RQw7enytAy6AQUwV0P8wP
         hVIoBCjhdIdnzy4RSkIhbnKMMuTr7Pf3SYsDeY9pzS1S2qZHuL7ThNYPdC5CA4YdCpcJ
         dlUWNFN2Ena2ttqjhrexfpv5ydaZ06kSNNXALGCvEvE2XX15tI+K1fH1lAKsum9NHKiJ
         hmrvr3hBmyW2vUNtDZsdmiaNhkpUmlzTi9iP4diYj6Kxt1APxbUooHOonvSbSBn+nSwJ
         y0kt4jFFnf8r/I9eY9Q1o0SoudhY97KXZlqykeIacL0AlmU85ymz0t3JL/J8YAGk/3NB
         HN+w==
X-Gm-Message-State: AGi0PuYYS88LMQWqVAjo+fDHswGMGrHkzFjpXToZFeSWbzCY9nqWRuDT
	6xt/MvkZakCvvDND3+FctXe23Jt1vMROYnZVhe44hvpd
X-Google-Smtp-Source: APiQypKgm80JiuSQ0Y4IHgxQ87n1VvU3bAfZkjSKTAZJqRwKJgOruC1JrK6aBb85XOrH6NVlFiRR4+KIGyuipmoEbXg=
X-Received: by 2002:aa7:c609:: with SMTP id h9mr8398947edq.93.1585932631299;
 Fri, 03 Apr 2020 09:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200331143229.306718-1-vaibhav@linux.ibm.com> <20200331143229.306718-3-vaibhav@linux.ibm.com>
In-Reply-To: <20200331143229.306718-3-vaibhav@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 3 Apr 2020 09:50:19 -0700
Message-ID: <CAPcyv4hehbgfFaXgCnNOrNops_fW5fXacmOzhnne6iy6GgcYVQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] ndctl/uapi: Introduce NVDIMM_FAMILY_PAPR_SCM as a
 new NVDIMM DSM family
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: X256E7RWXHQFFIHEBW2ZOJFROBCMX4D7
X-Message-ID-Hash: X256E7RWXHQFFIHEBW2ZOJFROBCMX4D7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <ellerman@au1.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X256E7RWXHQFFIHEBW2ZOJFROBCMX4D7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 31, 2020 at 7:33 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Add PAPR-scm family of DSM command-set to the white list of NVDIMM
> command sets.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
>
> v4..v5 : None
>
> v3..v4 : None
>
> v2..v3 : Updated the patch prefix to 'ndctl/uapi' [Aneesh]
>
> v1..v2 : None
> ---
>  include/uapi/linux/ndctl.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
> index de5d90212409..99fb60600ef8 100644
> --- a/include/uapi/linux/ndctl.h
> +++ b/include/uapi/linux/ndctl.h
> @@ -244,6 +244,7 @@ struct nd_cmd_pkg {
>  #define NVDIMM_FAMILY_HPE2 2
>  #define NVDIMM_FAMILY_MSFT 3
>  #define NVDIMM_FAMILY_HYPERV 4
> +#define NVDIMM_FAMILY_PAPR_SCM 5

Looks good, but please squash it with patch 3.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
