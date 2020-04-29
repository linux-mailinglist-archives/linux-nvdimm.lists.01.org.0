Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4795B1BE420
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Apr 2020 18:42:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 69EA310057C14;
	Wed, 29 Apr 2020 09:40:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.128.67; helo=mail-wm1-f67.google.com; envelope-from=wei.liu.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DEE801007B64E
	for <linux-nvdimm@lists.01.org>; Wed, 29 Apr 2020 09:40:54 -0700 (PDT)
Received: by mail-wm1-f67.google.com with SMTP id r26so2765282wmh.0
        for <linux-nvdimm@lists.01.org>; Wed, 29 Apr 2020 09:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b1NmnG+Bha+R6DCsicsXkjR18of0wt/SYtjmCqwDrqU=;
        b=gBBQsLcKVeFLlHtuCG/7NLq2cK6dmTSQXuMdaqi8JoCULjARML8/9Kh4WuN1yd5pAu
         P7H/6F727RvEXYXfzyUnmgRCBP2kV8kZvcfrgSI0nHk44TrraTX2aMiKnxzEnaxQylU1
         mhWrS0917hAwTGkxcFC6v84iTT2On2YJd979BBxx62iK9fnxv073fPtEgvp1sf1Ekis1
         hyVVAWae8cF2ItLaGwGfKngS6wH+0LK8VdLdCBAZCjD2BShveqaHwrBx7IvhM39eUIYZ
         WO4iwJbLJlu8VXLEk3CwoDsRQwFZOjUOp3ZmjLk1f/JF52sisngHvcw5qyvE8U5QDwtM
         OEUA==
X-Gm-Message-State: AGi0PuZlq04CGPnYXqLIJdbedAzQghxjWs0VzQ8xnRGEYAVr9vEqKHpM
	gF00HvPvR1OlmiOX2wjLYDE=
X-Google-Smtp-Source: APiQypK92COmCk6jtDXQuM8RbqIzlQmTZkmvIjtD7/GMtqebIJTWbJ+7ip3K+A9bRbw+AFyvMNQEDw==
X-Received: by 2002:a1c:2383:: with SMTP id j125mr4175112wmj.6.1588178518352;
        Wed, 29 Apr 2020 09:41:58 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i25sm8360761wml.43.2020.04.29.09.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 09:41:57 -0700 (PDT)
Date: Wed, 29 Apr 2020 16:41:55 +0000
From: Wei Liu <wei.liu@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 1/3] mm/memory_hotplug: Prepare passing flags to
 add_memory() and friends
Message-ID: <20200429164154.ctflq4ouwrwwe4wq@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <20200429160803.109056-1-david@redhat.com>
 <20200429160803.109056-2-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200429160803.109056-2-david@redhat.com>
User-Agent: NeoMutt/20180716
Message-ID-Hash: PZOYAOGJL2PAYRXGTLKYGUC3TG3Y6J5B
X-Message-ID-Hash: PZOYAOGJL2PAYRXGTLKYGUC3TG3Y6J5B
X-MailFrom: wei.liu.linux@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jason Wang <jasowang@redhat.com>, Boris Ostrovsky 
 <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Pingfan Liu <kernelfans@gmail.com>, Leonardo Bras <leobras.c@gmail.com>, Nathan Lynch <nathanl@linux.ibm.com>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>, Wei Yang <richard.weiyang@gmail.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Eric Biederman <ebiederm@xmission.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PZOYAOGJL2PAYRXGTLKYGUC3TG3Y6J5B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 29, 2020 at 06:08:01PM +0200, David Hildenbrand wrote:
> We soon want to pass flags - prepare for that.
> 
> This patch is based on a similar patch by Oscar Salvador:
> 
> https://lkml.kernel.org/r/20190625075227.15193-3-osalvador@suse.de
> 
[...]
> ---
>  drivers/hv/hv_balloon.c                         |  2 +-

> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 32e3bc0aa665..0194bed1a573 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -726,7 +726,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  
>  		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
>  		ret = add_memory(nid, PFN_PHYS((start_pfn)),
> -				(HA_CHUNK << PAGE_SHIFT));
> +				(HA_CHUNK << PAGE_SHIFT), 0);
>  
>  		if (ret) {
>  			pr_err("hot_add memory failed error is %d\n", ret);

Acked-by: Wei Liu <wei.liu@kernel.org>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
