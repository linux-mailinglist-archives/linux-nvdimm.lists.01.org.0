Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7922310F0A
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Feb 2021 18:47:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D7D06100EBBCB;
	Fri,  5 Feb 2021 09:47:36 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9C5A1100EBBB3
	for <linux-nvdimm@lists.01.org>; Fri,  5 Feb 2021 09:47:33 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z22so9695589edb.9
        for <linux-nvdimm@lists.01.org>; Fri, 05 Feb 2021 09:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xTcvmR9l8LCQBXYg8Iamhidu+elg0BguOpYiNarlS1o=;
        b=2Nd371ZRFVQhcLDBl+lgRXyePXWtyxYWOJdoibdtLDcVEPAclIT57bv/pttx+PCAXR
         hBmJqxqgfkeJaWMPk9JEWID8W0MRGpAu8y556s92b8BOiCmeYQ6ZGW0sLzda8+8lkAbp
         REgbCb3PieFZYRK20QJtBpT5y9Gn2ftYABRS3BLWsPMs8l2VQ97KjoeIOTWmjieqzD3b
         LEeBHKLecTpcdbD+HURjvm7ywhsihC8aaKh3ZPEkc3zgMRIWk2Ul9f2HlG26KsUDHAcS
         1YNsz3o+EivN53VES30cyx/UUga7OecedJiS53u8xBsqu/Mo1pb+A85aYj/4cOJ5B1fU
         7Akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTcvmR9l8LCQBXYg8Iamhidu+elg0BguOpYiNarlS1o=;
        b=JLT2DwIea0KFECEKKj2XX1aj8A1SjeV4W/2QXSmPFPOHwiuOG/84L79x688SskjxTj
         PGwVXUVXZ3pz4o7rtvMhMRlwA85WggjmJs+xJ2dPHnIMxEsjKGq+fHEL3upvaBZVytVa
         56WL5e6Zcg4fI6mJky3kSdPBsv4GB0dGElsgyGAJ6N4e2ByeMoCIC1rUU1IUMby8Pmdp
         A5CS2kieP8170/+Vn2OkYhG/LDY5zEosMZZAcJC5njm4n1a0l0AE4Em0/OkI6VSb8hJK
         Ocs472BbkdLGDPhMGIMmG/W0G9nv+RuzQmK8V/c2ky2iHL+vRgUGvRfgU4aDp61yIiOR
         jmuA==
X-Gm-Message-State: AOAM532rCf7UiZtQR16R4HxDD8pn3Vn5/ErwFSnHdmD7O9rMKap5yXeF
	c/HPJOOFTCY7p1/lTWyJvGMQctQtVdGaKTMvmxfcIw==
X-Google-Smtp-Source: ABdhPJwQ2HYUuz3zhFYfjA72qO6TZMVhKCjykClJyTdj6jByOo8Ou3oLUV5Ufxp7SoTjx4LgEXWEPC1cSmHtgRC1EyI=
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr4539433edc.97.1612547251549;
 Fri, 05 Feb 2021 09:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20210205023956.417587-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20210205023956.417587-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 5 Feb 2021 09:47:32 -0800
Message-ID: <CAPcyv4ghvBwKa6pCfqLxUU9UhK9R3HY4tNrNO115QN00A8zMRw@mail.gmail.com>
Subject: Re: [PATCH] mm/pmem: Avoid inserting hugepage PTE entry with fsdax if
 hugepage support is disabled
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: NWQM2TGWWQAFMXVH4XGJN747S6SX26H7
X-Message-ID-Hash: NWQM2TGWWQAFMXVH4XGJN747S6SX26H7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Jan Kara <jack@suse.cz>, Linux MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NWQM2TGWWQAFMXVH4XGJN747S6SX26H7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ add Andrew ]

On Thu, Feb 4, 2021 at 6:40 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Differentiate between hardware not supporting hugepages and user disabling THP
> via 'echo never > /sys/kernel/mm/transparent_hugepage/enabled'
>
> For the devdax namespace, the kernel handles the above via the
> supported_alignment attribute and failing to initialize the namespace
> if the namespace align value is not supported on the platform.
>
> For the fsdax namespace, the kernel will continue to initialize
> the namespace. This can result in the kernel creating a huge pte
> entry even though the hardware don't support the same.
>
> We do want hugepage support with pmem even if the end-user disabled THP
> via sysfs file (/sys/kernel/mm/transparent_hugepage/enabled). Hence
> differentiate between hardware/firmware lacking support vs user-controlled
> disable of THP and prevent a huge fault if the hardware lacks hugepage
> support.

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I assume this will go through Andrew.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
