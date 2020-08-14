Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD89244C21
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Aug 2020 17:29:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 62FC31311C13D;
	Fri, 14 Aug 2020 08:29:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.66; helo=mail-ot1-f66.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0D2771311C13B
	for <linux-nvdimm@lists.01.org>; Fri, 14 Aug 2020 08:29:05 -0700 (PDT)
Received: by mail-ot1-f66.google.com with SMTP id q9so7855136oth.5
        for <linux-nvdimm@lists.01.org>; Fri, 14 Aug 2020 08:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBVBMvKKxks/kGkJ4ndBszEEsQk9CsCHA7aFPfw0OnY=;
        b=q3XWFgVkBAOBVF4ByZYkohyisvMTCZRXwmxWbfG9sYABzrk6Q5O12x2byx0bOM7M+v
         LF6G4k422LVCXwICkpMSpRUdrxkdQpDQ6SCHjpxsNPwRUC20up4cS+jG31coQxt9RiiV
         GdwhXtN+zfUIdRqZYN5ZHBVhkaOUZKbzoRPd+HfCABug606jw8kN3ylCHF5280aH2OHk
         zwn700MLWrVaMo6mJ4ekTPBQu976MCTsj++YxqLTUj603Z4ldmNNzAMfCYYGHaZXRa2K
         kuzoOK76yhOvUOuUu8udsxRw0oYjuQsPJhasc7eWAIRdYovww53ypsgD5h7zKmktI39l
         urTQ==
X-Gm-Message-State: AOAM530rUPguOVo/qxLrc4u1siApuE7PRr0xT8U8Hkoa+WDGFEXyhIaa
	FJPpRO6v84NMiSh2yZXw8OqyK/WaAZ/VbBgB/Y0=
X-Google-Smtp-Source: ABdhPJz1T4tJ8ofzUGM0XQjCNBZ6PvK5Zq6i4UC8Y+eAkenmq/nx3KmnaWGeq6j/7fuAaFaAt8U6C3Dv5bPtU6dw8Nw=
X-Received: by 2002:a05:6830:1c74:: with SMTP id s20mr2165582otg.167.1597418944007;
 Fri, 14 Aug 2020 08:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <1597286952-5706-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1597286952-5706-1-git-send-email-wangqing@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Aug 2020 17:28:52 +0200
Message-ID: <CAJZ5v0h=UmD33X_i80X3ww7nC=xQL7V8XaoNq2XvU_XcdQGfZQ@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: Use kobj_to_dev() instead
To: Wang Qing <wangqing@vivo.com>, Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: NDFTULT32OOQLNMXAVY4AM2QGDW2NGNE
X-Message-ID-Hash: NDFTULT32OOQLNMXAVY4AM2QGDW2NGNE
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NDFTULT32OOQLNMXAVY4AM2QGDW2NGNE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 13, 2020 at 4:54 AM Wang Qing <wangqing@vivo.com> wrote:
>
> Use kobj_to_dev() instead of container_of()
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>

LGTM

Dan, any objections?

> ---
>  drivers/acpi/nfit/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index fa4500f..3bb350b
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1382,7 +1382,7 @@ static bool ars_supported(struct nvdimm_bus *nvdimm_bus)
>
>  static umode_t nfit_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
>
>         if (a == &dev_attr_scrub.attr && !ars_supported(nvdimm_bus))
> @@ -1667,7 +1667,7 @@ static struct attribute *acpi_nfit_dimm_attributes[] = {
>  static umode_t acpi_nfit_dimm_attr_visible(struct kobject *kobj,
>                 struct attribute *a, int n)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct nvdimm *nvdimm = to_nvdimm(dev);
>         struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>
> --
> 2.7.4
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
