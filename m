Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65867262C3B
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Sep 2020 11:43:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A9A1113C9D90D;
	Wed,  9 Sep 2020 02:43:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.221.65; helo=mail-wr1-f65.google.com; envelope-from=wei.liu.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0C5E713C735CC
	for <linux-nvdimm@lists.01.org>; Wed,  9 Sep 2020 02:43:55 -0700 (PDT)
Received: by mail-wr1-f65.google.com with SMTP id s12so2178790wrw.11
        for <linux-nvdimm@lists.01.org>; Wed, 09 Sep 2020 02:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=itunWBeUEUF+I5zgor+uJyYhdBRIEn0Nbwdk7PfivcQ=;
        b=PwJkrf4j9y2CR0WlTG/cvmSuZwoYzGxYvrWpTNpo+H5vyZ7AKYV5Uu5+hv7aFCEp4v
         MBfjj7sjjSXXF3jdHclYA9hiZjR+yvVAggBDOVRR+VvrPVYxp4S3y49vDETCpNWHym0n
         d7L5TIqdw26r2RpftXLKIFEyA74pvwzStIHRbgBwr1KwUVpcmexFuk4VdQvEKy6weHMr
         33Axiz2W/VZzGjrB+qc455cOAUrpFs+Oh6RVr+sGxbkQRsiEkIxILLzUtDQUboiwfA1i
         QiiBLwL6CLC8cL0NEYxIaciCCwCRb5acHOUBOD03Cf4eV3smTiUjElED4ZbQ0Rs7pmsa
         hWgA==
X-Gm-Message-State: AOAM530hwTeuc5FTIFl9dmqAvYYLnz9x53YmcjVRuDUa1tCQd5aqeFTZ
	SktkLVi937UcSS7q62U2tZ8=
X-Google-Smtp-Source: ABdhPJw4m6JIIMVzIcBEfdyNOEzdxl4ubsib7FAe+AQwVP/swI1ur/mk9/fv0YgWwez/zmAN9CDF6A==
X-Received: by 2002:adf:f552:: with SMTP id j18mr3339957wrp.128.1599644633198;
        Wed, 09 Sep 2020 02:43:53 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y1sm3048033wmi.36.2020.09.09.02.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 02:43:52 -0700 (PDT)
Date: Wed, 9 Sep 2020 09:43:51 +0000
From: Wei Liu <wei.liu@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 7/7] hv_balloon: try to merge system ram resources
Message-ID: <20200909094351.2a6lpsqoqj6b4nk2@liuwe-devbox-debian-v2>
References: <20200908201012.44168-1-david@redhat.com>
 <20200908201012.44168-8-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200908201012.44168-8-david@redhat.com>
User-Agent: NeoMutt/20180716
Message-ID-Hash: HG6MHVMPH3FUKKCPQI5Q4JMAHYJRQLHH
X-Message-ID-Hash: HG6MHVMPH3FUKKCPQI5Q4JMAHYJRQLHH
X-MailFrom: wei.liu.linux@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HG6MHVMPH3FUKKCPQI5Q4JMAHYJRQLHH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 08, 2020 at 10:10:12PM +0200, David Hildenbrand wrote:
> Let's try to merge system ram resources we add, to minimize the number
> of resources in /proc/iomem. We don't care about the boundaries of
> individual chunks we added.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
