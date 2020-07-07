Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AABF5216C58
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 13:55:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 055451108DED2;
	Tue,  7 Jul 2020 04:55:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.221.68; helo=mail-wr1-f68.google.com; envelope-from=mstsxfx@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2C8DB11075BCF
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 04:54:58 -0700 (PDT)
Received: by mail-wr1-f68.google.com with SMTP id z13so44838052wrw.5
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jul 2020 04:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PaBT0lPoXs7IdlUtnsvP+VH1DgYh/P2jJzUAU6vUbNU=;
        b=nmrMypnHAQrW8TDRsD/Mam7E7Y70+I2H/Ee08apMqDjWcBsAIsIxOh134pRpKLUBMJ
         S6tfB5XLRIv4ZR0jdpvM2KG1Xc4fQFMF7ChqTPddrEgS7jhbBC1eN5q1eK4uqvIXYN67
         yeLxHP5RsLpzFMPPYnRQwJoDCGORtyq221ylQVwvuzbiPCzTbABLVCRRCkKxN31k4c7J
         YM2R9yBoCFapxTwr4EmY7Hsss2cIX49SnZh9rzfh3Dx+zunJ5EiWojFpyE5xyxkHktNV
         WZKCp32kX6TkiUX8U4RKeKSeeEwqKEL6ub42b8tgiCuWwqziV56dXGC/xfE4BYcnHKuG
         n6aQ==
X-Gm-Message-State: AOAM5306OzKkY7t9pvwbs0vn+YmwY1kAXFYxV0zmJjq6g+IMLS3dqV/3
	7tPVdAmB7rbJleyOgt513nc=
X-Google-Smtp-Source: ABdhPJzjupRW40+WN4FUZja0iCFY7iXyazV3EiU8SfOuII8h8MCdacV4SFghHmY4jlkuWGms463J9Q==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr54625097wru.399.1594122896601;
        Tue, 07 Jul 2020 04:54:56 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id m10sm791787wru.4.2020.07.07.04.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 04:54:55 -0700 (PDT)
Date: Tue, 7 Jul 2020 13:54:54 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Jia He <justin.he@arm.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Message-ID: <20200707115454.GN5913@dhcp22.suse.cz>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200707055917.143653-2-justin.he@arm.com>
Message-ID-Hash: B3AG2YVZTK66VCJ7AEOPGOWMS5GIDVN3
X-Message-ID-Hash: B3AG2YVZTK66VCJ7AEOPGOWMS5GIDVN3
X-MailFrom: mstsxfx@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B3AG2YVZTK66VCJ7AEOPGOWMS5GIDVN3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 07-07-20 13:59:15, Jia He wrote:
> This exports memory_add_physaddr_to_nid() for module driver to use.
> 
> memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> NUMA_NO_NID is detected.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  arch/arm64/mm/numa.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index aafcee3e3f7e..7eeb31740248 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
>  
>  /*
>   * We hope that we will be hotplugging memory on nodes we already know about,
> - * such that acpi_get_node() succeeds and we never fall back to this...
> + * such that acpi_get_node() succeeds. But when SRAT is not present, the node
> + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
>   */
>  int memory_add_physaddr_to_nid(u64 addr)
>  {
> -	pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);

Does it make sense to export a noop function? Wouldn't make more sense
to simply make it static inline somewhere in a header? I haven't checked
whether there is an easy way to do that sanely bu this just hit my eyes.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
