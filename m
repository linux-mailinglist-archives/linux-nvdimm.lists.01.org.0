Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD906EB792
	for <lists+linux-nvdimm@lfdr.de>; Thu, 31 Oct 2019 19:52:37 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4D12E100DC40B;
	Thu, 31 Oct 2019 11:53:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B0C07100DC409
	for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 11:53:00 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 94so6287303oty.8
        for <linux-nvdimm@lists.01.org>; Thu, 31 Oct 2019 11:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYRjCBcUieFp8SY1pnriDREcCj2OwMvbpAzz3GKZ7Os=;
        b=wf9R4I/Wykhk/kHwmOZ7FRs4N35oAAhUfY5GRF+DFlKW5EiSgSR2pXJt1J6k/Q3RLo
         7a64QeW1z2IuKa9ck31zLngJN4vriBtnWn4ndnJ5olzxAyzkzkm6jPz1b97mZFEU5zDe
         J9exZ8VvtyOMfKilxM2QRww6cOxodEiE76K4NU6ST36IEvJgHTgIZevrU8k/rBSBaLea
         iGCNw3p3/bmine6URHtrbcyED10l9J35GYI09pi+bF9n+9J8LaBN952ah6RbdAitHG26
         Ucxgy51+TPJx5SLmK/XjA1u3xevLh6mcHFIseDpW1TW3GStwQ4eETMjUTdoIN2bbJb9O
         rODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYRjCBcUieFp8SY1pnriDREcCj2OwMvbpAzz3GKZ7Os=;
        b=rmMgCeDgIuajDmIulvjMAbCUGpLuvBryK3N8k5cK7nmbkcpS/cYbH/D+KE7j8rlfzA
         BU3we0csWb4qSOAp3lP/GP+SoaU1B3F9uT7GaJy58k0hCwu2xNwgyON65YAa3UP/NHxs
         tECt6JumGvsRzBEABrm4CO5UURLZWLDjH+BOzWJwkwE3k/050hwf3UXCPBHbMixNYnSo
         efAQ5EV3aOlWE2GcR+HVnafQCvvUAJmlpS8Z3vNAdBk63LvqvwCP5hrW8WOvylGtsUOX
         0/x6lAiZwlA7euH1fWB/zZ2w4O70Un+M+u/WiyW3yA19c4zrmF8z8kkpf2mO77vJC+bi
         ydqQ==
X-Gm-Message-State: APjAAAUq/aY4cTaJMtSewAQfkUfwZ/dRZSNyo0lO3row2xkyInB4Br74
	zkBu1AM1rNmbp2cRcI72D2GMQmYVOm42SOCPOK1gfw==
X-Google-Smtp-Source: APXvYqzGMPfd8YmZZoaXQ3mv6ldCKjnvcxqVGiUXhhD1NjbBuSU+CTvnMNyxCZ+rxtdGwHUtER6TwMy7k01RaFGkiEw=
X-Received: by 2002:a9d:5f11:: with SMTP id f17mr5559358oti.207.1572547953910;
 Thu, 31 Oct 2019 11:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191031105741.102793-1-aneesh.kumar@linux.ibm.com> <20191031105741.102793-2-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20191031105741.102793-2-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 31 Oct 2019 11:52:23 -0700
Message-ID: <CAPcyv4jv+zx7PSLGuxaa1OMQmmEnws2VgUN43YqqEvoh1yFowA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] libnvdimm/namespace: Differentiate between probe
 mapping and runtime mapping
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: TRWQ3K6ND7H7ZPCPNX5D4NBNODBVAJQV
X-Message-ID-Hash: TRWQ3K6ND7H7ZPCPNX5D4NBNODBVAJQV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TRWQ3K6ND7H7ZPCPNX5D4NBNODBVAJQV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 31, 2019 at 3:58 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> The nvdimm core currently maps the full namespace to an ioremap range
> while probing the namespace mode. This can result in probe failures on
> architectures that have limited ioremap space.
>
> For example, with a large btt namespace that consumes most of I/O remap
> range, depending on the sequence of namespace initialization, the user
> can find a pfn namespace initialization failure due to unavailable I/O
> remap space which nvdimm core uses for temporary mapping.
>
> nvdimm core can avoid this failure by only mapping the reserved info
> block area to check for pfn superblock type and map the full namespace
> resource only before using the namespace.
>
> Given that personalities like BTT can be layered on top of any namespace
> type create a generic form of devm_nsio_enable (devm_namespace_enable)
> and use it inside the per-personality attach routines. Now
> devm_namespace_enable() is always paired with disable unless the mapping
> is going to be used for long term runtime access.

Looks good to me, applied.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
