Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC5915BBBA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Feb 2020 10:32:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0617210FC339D;
	Thu, 13 Feb 2020 01:35:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com; envelope-from=mingo.kernel.org@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 86AFD1007B18B
	for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 01:35:49 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p17so5770067wma.1
        for <linux-nvdimm@lists.01.org>; Thu, 13 Feb 2020 01:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Szpi62myEK2IMzveHJnGljROe4VEIiMR6+A5LS1u+08=;
        b=IZ/jRT8tVuua0sL39WTc+wyGo7krKaHTgpTnUl6GA1IzY929+tYE9xzDHAPJ7eTUO4
         ewWD2AVTtOansBKEcImgFyD7gZaWyArRt8E4YCpaAgHfU8WHenLdRYHI4xn8aASzxx79
         Ki6UFtPL8l51d6rRU+Ku9dAGw/oAWy/+YbVcLRm0aGNzTvj9oW3bFAbNM2aYs0W3QG5W
         DL1T4RR4+IfykhyLhURbuLf1MT9uIEnqFMTovXQLXmhV0F8nHfMhqg9U1C25ocG9RUUP
         nZiL9rIzo9xWbB5is9YKKSA4GKFwUsl08AgZMdpUceBZ2bfFJc3BmsqHDu7tyHSP4GfX
         2AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Szpi62myEK2IMzveHJnGljROe4VEIiMR6+A5LS1u+08=;
        b=OwmgTl3X3fLONDRQ3oAX6afZp59w+JkHw3fdnwvBtmyDkgGmiN+6LZIUVIqR287Z20
         Z6oaZ3M2vFve259wr9xUJPwLh+xwbK/YEAs1iL7EJQQX2KxMZGDmVnUwZMkPJy37M5dy
         0iZZNk33fMi6LeX4fO0pWj4NC6Ya1ICNk1Iy9VQWN87iWOq5ouOkb4cUFIzY6qRVrEy7
         FZ36YXChmyCLZ0VEkWi/vlkU09puMDznCsJ5HfBU+bubRWhx2Jc2M7TPDhne0Bf4lfC9
         CGZ5IOoqJGG+nCOWTzLo0qGRI90nBg44zS25nXkGifdO14ivzQm+7THMYuSLPb+JvXtj
         cUBw==
X-Gm-Message-State: APjAAAUWPpogoT+VsOCrilNiPqfM7NtxwzQ1tpRuL+AJJKrKOC0j8eCZ
	v9Ztv+69rie8kXMoCmzgh40=
X-Google-Smtp-Source: APXvYqzsD2FBaQGfErOtCUuWNM+0vrFghHrVr/9Xriu0M2+OB7g2HYg2A1mGS+dIBGwoOTZNi3+MgA==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr4886871wmc.137.1581586350475;
        Thu, 13 Feb 2020 01:32:30 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l2sm2160747wme.1.2020.02.13.01.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 01:32:29 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 13 Feb 2020 10:32:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 4/6] x86/mm: Introduce CONFIG_KEEP_NUMA
Message-ID: <20200213093227.GA90266@gmail.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157966229575.2508551.1892426244277171485.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <157966229575.2508551.1892426244277171485.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 2K6IDVYS6GFOVA6GXAURCA3OSWBFWPW6
X-Message-ID-Hash: 2K6IDVYS6GFOVA6GXAURCA3OSWBFWPW6
X-MailFrom: mingo.kernel.org@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: tglx@linutronix.de, mingo@redhat.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, hch@lst.de, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2K6IDVYS6GFOVA6GXAURCA3OSWBFWPW6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


* Dan Williams <dan.j.williams@intel.com> wrote:

> Currently x86 numa_meminfo is marked __initdata in the
> CONFIG_MEMORY_HOTPLUG=n case. In support of a new facility to allow
> drivers to map reserved memory to a 'target_node'
> (phys_to_target_node()), add support for removing the __initdata
> designation for those users. Both memory hotplug and
> phys_to_target_node() users select CONFIG_KEEP_NUMA to tell the arch to
> maintain its physical address to numa mapping infrastructure post init.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/mm/numa.c   |    6 +-----
>  include/linux/numa.h |    6 ++++++
>  mm/Kconfig           |    5 +++++
>  3 files changed, 12 insertions(+), 5 deletions(-)

The concept and the x86 portions look sane, just a few minor nits:

> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 99f7a68738f0..5289d9d6799a 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -25,11 +25,7 @@ nodemask_t numa_nodes_parsed __initdata;
>  struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
>  EXPORT_SYMBOL(node_data);
>  
> -static struct numa_meminfo numa_meminfo
> -#ifndef CONFIG_MEMORY_HOTPLUG
> -__initdata
> -#endif
> -;
> +static struct numa_meminfo numa_meminfo __initdata_numa;
>  
>  static int numa_distance_cnt;
>  static u8 *numa_distance;
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index 20f4e44b186c..c005ed6b807b 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -13,6 +13,12 @@
>  
>  #define	NUMA_NO_NODE	(-1)
>  
> +#ifdef CONFIG_KEEP_NUMA
> +#define __initdata_numa
> +#else
> +#define __initdata_numa __initdata
> +#endif
> +
>  #ifdef CONFIG_NUMA
>  int numa_map_to_online_node(int node);
>  #else
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ab80933be65f..001f1185eadf 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -139,6 +139,10 @@ config HAVE_FAST_GUP
>  config ARCH_KEEP_MEMBLOCK
>  	bool
>  
> +# Keep arch numa mapping infrastructure post-init.

s/numa/NUMA

Please also capitalize consistently in the rest of the series.

> +config KEEP_NUMA
> +	bool


So most of our recent new NUMA options followed the naming pattern of:

  CONFIG_NUMA_*

Such as CONFIG_NUMA_BALANCING or CONFIG_NUMA_EMU.

So I'd suggesting naming it to CONFIG_NUMA_KEEP, or, a bit more 
descriptively, such as CONFIG_NUMA_KEEP_MAPPING or such?

'Keeping NUMA' is kind of lame - of course we keep NUMA. ;-)

Thanks,

	Ingo
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
