Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E0A1DC2BC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 May 2020 01:20:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 418F311F7C101;
	Wed, 20 May 2020 16:17:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AC91E11F7C0DD
	for <linux-nvdimm@lists.01.org>; Wed, 20 May 2020 16:16:57 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id k19so5120651edv.9
        for <linux-nvdimm@lists.01.org>; Wed, 20 May 2020 16:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tc0I6urtskm+twxwz/NGJT1Fvw9HtL85DhhFQkA7q70=;
        b=tFn30hyc7c8T1GLyXVacCW73cbyAnx2CNQ6K780rjbsGBTOfgwebkIf5I96Rl7wERl
         Jyyv+ZCENOxtwKQA2zK6MWEYs5O/cBFKKOOzj8NM5NwuasyZE30SRzP5Ify3VdISBZt6
         ZiI184ML0h0N9pHISJNunovWRlQv4yo4mr0Fpv4x/XiCeSQmYYoV6w5zqA5ak6RlfLL5
         cfMtCJIP10Vr9PSInxN616iYRCWIlYKVgPa6moEGd2pkF8K6gpYaHfsYPBjymtUJrKmT
         geEyG86U8mc7kZh2NGzSqguQURvECbbE/mgu1yUVnW6Sp0/m/fHuNDlg5KFxovyr/nh3
         n5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tc0I6urtskm+twxwz/NGJT1Fvw9HtL85DhhFQkA7q70=;
        b=M11RoosCYHSbZwCzTwomWRctU2gvw5YPPC9EpfcvDOM0xoZmUXKbdCc5n2ilz1HyrW
         Zlp9lH7g0NUTrGfHrrKmIrVdzCPjmsqU3OXPJ477aYpUdMJJHtjOAyf/T8s11bqvPBCI
         lxCFDT3v0/dD3Qa5EQjbCKQy+ONh8qmUOdFWTtzwoEnHiCn0WQ+Lbom5QqNW9teUHljt
         I0VX4vumVzIv+u4/fG8BtPrP0MFK9OqywDid6g7Mhl6fjR/wGNArmtiMObLPu9kvA3Vb
         jPkuy1A/fdMj9dsSZr3+0j9H1H8u6xtvU8zFgcKI/YLjkyzOUNjMAaIlbute7ajfTYhK
         ZFqw==
X-Gm-Message-State: AOAM532u9szm1UKLeEeyVlrJ1p27DnXqKkaLS/GotcQKeSKV0Nla55Ja
	WMu1/MRfmZ4Eii2ENQlIQ81gqKgHPx2Ry1k+nMT1IQ==
X-Google-Smtp-Source: ABdhPJyT2e8nVsy8ow2UwtBv3h0+hZkmEUYKdZaEA5EIgAVEiqcdFBDQwCDKBLev8zW6hQIrcRiZjUWZuMKKGAnOd6g=
X-Received: by 2002:a50:c2d9:: with SMTP id u25mr5877197edf.123.1590016822832;
 Wed, 20 May 2020 16:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200520225026.29426-1-vishal.l.verma@intel.com>
In-Reply-To: <20200520225026.29426-1-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 20 May 2020 16:20:10 -0700
Message-ID: <CAPcyv4iK4Gag845dA3KG0QPxTQ2=jABB1w7xMkZnaL4_CckDrQ@mail.gmail.com>
Subject: Re: [PATCH] nvdimm/region: always show the 'align' attribute
To: Vishal Verma <vishal.l.verma@intel.com>
Message-ID-Hash: I6VKIPVGYGN6Z3HD37COKT6IRUHPFGWX
X-Message-ID-Hash: I6VKIPVGYGN6Z3HD37COKT6IRUHPFGWX
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I6VKIPVGYGN6Z3HD37COKT6IRUHPFGWX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 20, 2020 at 3:50 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> It is possible that a platform that is capable of 'namespace labels'
> comes up without the labels properly initialized. In this case, the
> region's 'align' attribute is hidden. Howerver, once the user does
> initialize he labels, the 'align' attribute still stays hidden, which is
> unexpected.
>
> The sysfs_update_group() API is meant to address this, and could be
> called during region probe, but it has entanglements with the device
> 'lockdep_mutex'. Therefore, simply make the 'align' attribute always

Looks good, I would just say "device_lock" here. The "lockdep_mutex"
is just a stand-in to show "device_lock" problems since the mutex that
device_lock() acquires is marked like this:

    lockdep_set_novalidate_class(&dev->mutex);

...I can fix this up on applying.

> visible. It doesn't matter what it says for label-less namespaces, since
> it is not possible to change their allocation anyway.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/nvdimm/region_devs.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index ccbb5b43b8b2..4502f9c4708d 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -679,18 +679,8 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
>                 return a->mode;
>         }
>
> -       if (a == &dev_attr_align.attr) {
> -               int i;
> -
> -               for (i = 0; i < nd_region->ndr_mappings; i++) {
> -                       struct nd_mapping *nd_mapping = &nd_region->mapping[i];
> -                       struct nvdimm *nvdimm = nd_mapping->nvdimm;
> -
> -                       if (test_bit(NDD_LABELING, &nvdimm->flags))
> -                               return a->mode;
> -               }
> -               return 0;
> -       }
> +       if (a == &dev_attr_align.attr)
> +               return a->mode;
>
>         if (a != &dev_attr_set_cookie.attr
>                         && a != &dev_attr_available_size.attr)
> --
> 2.26.2
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
