Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B347731BF33
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Feb 2021 17:30:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DCF8E100EB324;
	Mon, 15 Feb 2021 08:30:19 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com; envelope-from=groeck7@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 021A7100EB82A
	for <linux-nvdimm@lists.01.org>; Mon, 15 Feb 2021 08:30:16 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id h38so1645234ooi.8
        for <linux-nvdimm@lists.01.org>; Mon, 15 Feb 2021 08:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xZjHpynkO+jEqpoKJ7WUe4G5S6bqtxbRdwfSHl/HMrc=;
        b=jFo/wSwluSwMjlgb2z0JQRyhDpb3qIx8XNZ8qwfCj6NbhGG1ZoZO/yFSb3g3yGhis0
         5AReuZqH6EfN/tfoCx32nOFo7Ig9SCuPm2MtrLbfPjvh2KMpDLuajyIvdOWnVVfkhXrY
         XjwbovzeG4Mv96pwlYJ5AbIcAByssG1DRoO3CXM3zhprfBHdaOfBqu+hKinQAT7TxfBA
         bkhJNH6aEVGgs2F9y8QtbTnYy0QLgPY5rrAdzUTpbcTNvRpXCdiuwY7njJfwsAOAfSg9
         OoIjvVGnuZM5vxGZoIeW4W9rSz4TqN8/0nFKFCoHU8i94rRrFKn5I7f2X1bC5CDLbgqM
         go6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xZjHpynkO+jEqpoKJ7WUe4G5S6bqtxbRdwfSHl/HMrc=;
        b=nEQhXDEDMJg/FkZ8A3K0hXQFp9UzipKTjaOLzpEZnwI/uSvR20DRermEcJFbFXmJgX
         59v50tGtNxGNvfMuqMW5fDbjcTMWjsvC/bZjZ+1Bl5SoPQPBImmGE5/C9t/E7XaFdGcT
         izf3idoMxm1Vw+aMpJL4zEMvkW9e1zau1cxy2vH1FJB1FDjud+/D9OHi3zVyMW7iKqJW
         qeaCifwDJfNKDITKpKSMJf4tzTFlYWIuBKA3Dg4d08xXcfLC1t1OqJ+zMbcTwCMh39uV
         ZrQm76BwiV9jg2wG8j+7wT3/yioyU4mu4zWWePUZUuMkGCfiKPViyri7ZllGw2V1Mw+N
         H3Ng==
X-Gm-Message-State: AOAM533fyoxNflmSutXUNcaRAeNBxnbDP2vgyQfglLPeorVo4A/BD2eL
	PG7r41s68fUB20OB2JG4rZA=
X-Google-Smtp-Source: ABdhPJxFxNxXETq3ks4F+XSxZSd8J7B6SpNWE+i6QDVDnydfjooydiKQhpY7tRCSKEA/Q+tkXCXvtg==
X-Received: by 2002:a4a:a105:: with SMTP id i5mr11372483ool.54.1613406615929;
        Mon, 15 Feb 2021 08:30:15 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f76sm2183491oig.52.2021.02.15.08.30.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Feb 2021 08:30:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 15 Feb 2021 08:30:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v3 3/9] cxl/mem: Register CXL memX devices
Message-ID: <20210215163014.GA116265@roeck-us.net>
References: <20210212222541.2123505-1-ben.widawsky@intel.com>
 <20210212222541.2123505-4-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210212222541.2123505-4-ben.widawsky@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Message-ID-Hash: 4ZXUUIO36BYFXC63SFFU7K2GS2VSTEXL
X-Message-ID-Hash: 4ZXUUIO36BYFXC63SFFU7K2GS2VSTEXL
X-MailFrom: groeck7@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4ZXUUIO36BYFXC63SFFU7K2GS2VSTEXL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 12, 2021 at 02:25:35PM -0800, Ben Widawsky wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Create the /sys/bus/cxl hierarchy to enumerate:
> 
> * Memory Devices (per-endpoint control devices)
> 
> * Memory Address Space Devices (platform address ranges with
>   interleaving, performance, and persistence attributes)
> 
> * Memory Regions (active provisioned memory from an address space device
>   that is in use as System RAM or delegated to libnvdimm as Persistent
>   Memory regions).
> 
> For now, only the per-endpoint control devices are registered on the
> 'cxl' bus. However, going forward it will provide a mechanism to
> coordinate cross-device interleave.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> (v2)

arm:allmodconfig, i386:allyesconfig, mips:allmodconfig:

drivers/cxl/mem.c:335:2: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
  335 |  writeq(cmd_reg, cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);

In file included from <command-line>:
drivers/cxl/mem.c: In function '__cxl_mem_mbox_send_cmd':
include/linux/compiler_types.h:320:38: error: call to '__compiletime_assert_266' declared with attribute error: FIELD_GET: mask is zero

and many similar errors.

Guenter
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
