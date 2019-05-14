Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E382D1CB6B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 17:10:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C0869212746C9;
	Tue, 14 May 2019 08:10:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EB2B12125F1DF
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vg3ia/r810H9SSaaH0GiclbWcxBsBWmX3eOHv52f7hg=; b=DmxHDtquirwoRt3leeWs0jqe4p
 OBuVqen+B+T1sPmdQ/Xh/kJtVL1TYRU19cMa/+RiVhkDSyjlRsTaD8G7BLmbV/Erk3ZU9rNHcJAcz
 AzPBib/3h55XEBCNcTmML3raNdaT8gVxGKrIDuTzMFSxcwxp90UfjeuWN/JU3sNy4iFSnaGH6kbtG
 HICqbTL075Zfbakmx1maJv8+hRz1ukLMs87jNeIa2qAUbh4QZQaCfx1yAaQOHVQ0m/aqSDpXot4I5
 fRMJhaeNDyY1S2W6k7vWeIWbdl1vpuIPODlGt6g9JU+fJi9lgIGmpqCHh9KDTrw8etTDZNxt/2mqI
 qo+2U/+g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16]
 helo=midway.dunlab)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQZ3R-0000BE-Iq; Tue, 14 May 2019 15:09:22 +0000
Subject: Re: [PATCH v9 2/7] virtio-pmem: Add virtio pmem driver
To: Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-acpi@vger.kernel.org, qemu-devel@nongnu.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20190514145422.16923-1-pagupta@redhat.com>
 <20190514145422.16923-3-pagupta@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c22d42f6-ef94-0310-36f2-e9085d3464c2@infradead.org>
Date: Tue, 14 May 2019 08:09:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514145422.16923-3-pagupta@redhat.com>
Content-Language: en-US
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: jack@suse.cz, mst@redhat.com, jasowang@redhat.com, david@fromorbit.com,
 lcapitulino@redhat.com, adilger.kernel@dilger.ca, zwisler@kernel.org,
 aarcange@redhat.com, jstaron@google.com, darrick.wong@oracle.com,
 david@redhat.com, willy@infradead.org, hch@infradead.org, nilal@redhat.com,
 lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, yuval.shaia@oracle.com,
 stefanha@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, tytso@mit.edu,
 xiaoguangrong.eric@gmail.com, cohuck@redhat.com, rjw@rjwysocki.net,
 imammedo@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/14/19 7:54 AM, Pankaj Gupta wrote:
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 35897649c24f..94bad084ebab 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -42,6 +42,17 @@ config VIRTIO_PCI_LEGACY
>  
>  	  If unsure, say Y.
>  
> +config VIRTIO_PMEM
> +	tristate "Support for virtio pmem driver"
> +	depends on VIRTIO
> +	depends on LIBNVDIMM
> +	help
> +	This driver provides access to virtio-pmem devices, storage devices
> +	that are mapped into the physical address space - similar to NVDIMMs
> +	 - with a virtio-based flushing interface.
> +
> +	If unsure, say M.

<beep>
from Documentation/process/coding-style.rst:
"Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces."

> +
>  config VIRTIO_BALLOON
>  	tristate "Virtio balloon driver"
>  	depends on VIRTIO

thanks.
-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
