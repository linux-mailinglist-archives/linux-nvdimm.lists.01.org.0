Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC411C13E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 01:22:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1A89210113631;
	Wed, 11 Dec 2019 16:25:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-1.mimecast.com; envelope-from=pbonzini@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1A57C1011351D
	for <linux-nvdimm@lists.01.org>; Wed, 11 Dec 2019 16:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1576110149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfDIK/cTZhxbWFyQXhJ/o6g67eom+8/Zr11enJF7XGs=;
	b=eTYZuIc5RMHwFsodNab0Zj51HhdX5Ny97KLR0wEdwesoON1ldlYjn8XBdi8RWl4UveMXi6
	86PMuMaN1Ov9c6i6SSRqBc4mDnr274sQhE/A04ddQkuN6czwQk/neUhhEyEssFMHDmlO/h
	eXR7tn6G8Lwfb75vO3NgIWqfEw106dI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-vAt6OyaEOimhJBlIW1fQ4g-1; Wed, 11 Dec 2019 19:22:23 -0500
Received: by mail-wm1-f71.google.com with SMTP id o24so74446wmh.0
        for <linux-nvdimm@lists.01.org>; Wed, 11 Dec 2019 16:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KfDIK/cTZhxbWFyQXhJ/o6g67eom+8/Zr11enJF7XGs=;
        b=GDYC29VpNmtDsAfldI9BBrqj80X4i3h87/ngLIkoGk8kEhLYzu6MQsRViW4CDCgC5k
         A8O806rKOONZ3H7v9XqEREYUshC6uaieJh/9yblRtlEAIHQtzqJync8jBcQY5tLBF+K5
         iiKMrB4KhyUWuVxhE7Iqd6GGtwLUV2Y15GiSG+Pc/HOkQm745srmhzBzXq71kq+ENt1o
         wfDTxhPrtnpcxCcAbMU3GknlEgoqshXldVdB1vBMXVyX3YgUEoG4XJHye+cjH71kBASZ
         HxZPwOts28RC9BbCO0bWXy4+2pEScJ7Sw6dUoCoyqycpIsiSyLcKjbvGlwGR1G9ieLtH
         5THg==
X-Gm-Message-State: APjAAAVtFl5yfc6+3SCx0ddaV7an35gI+nYIjL8OwVBY48dLH78KM8Hb
	AC5kqH5n0Vib2LQCDnrE/ZPdl2Rnme5yP2oNUwZoNx5mcf6aG89rVYvlnfVeS2MS5IdUXUtSk+9
	MAUli0/KcagPMamXSxfx3
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr2826047wmc.168.1576110141974;
        Wed, 11 Dec 2019 16:22:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHQ9pKCsQmECWYzfqmUaqKH3GIHVXeXl2UOPNAEoUlpehzQP2zvMDzXZHDtpibHFnJA7IUJQ==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr2826004wmc.168.1576110141556;
        Wed, 11 Dec 2019 16:22:21 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id t12sm4018033wrs.96.2019.12.11.16.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 16:22:21 -0800 (PST)
Subject: Re: [PATCH v4 0/2] kvm: Use huge pages for DAX-backed files
To: Barret Rhoden <brho@google.com>, Dan Williams <dan.j.williams@intel.com>,
 David Hildenbrand <david@redhat.com>, Dave Jiang <dave.jiang@intel.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>
References: <20191211213207.215936-1-brho@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <473dbb9d-b2ab-31ba-48ac-3b8216be46de@redhat.com>
Date: Thu, 12 Dec 2019 01:22:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191211213207.215936-1-brho@google.com>
Content-Language: en-US
X-MC-Unique: vAt6OyaEOimhJBlIW1fQ4g-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: UWYNE4ETVKQV53WHHJNHO6GFVZ6P4WDI
X-Message-ID-Hash: UWYNE4ETVKQV53WHHJNHO6GFVZ6P4WDI
X-MailFrom: pbonzini@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UWYNE4ETVKQV53WHHJNHO6GFVZ6P4WDI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/12/19 22:32, Barret Rhoden wrote:
> This patchset allows KVM to map huge pages for DAX-backed files.
> 
> I held previous versions in limbo while people were sorting out whether
> or not DAX pages were going to remain PageReserved and how that relates
> to KVM.
> 
> Now that that is sorted out (DAX pages are PageReserved, but they are
> not kvm_is_reserved_pfn(), and DAX pages are considered on a
> case-by-case basis for KVM), I can repost this.
> 
> v3 -> v4:
> v3: https://lore.kernel.org/lkml/20190404202345.133553-1-brho@google.com/
> - Rebased onto linus/master
> 
> v2 -> v3:
> v2: https://lore.kernel.org/lkml/20181114215155.259978-1-brho@google.com/
> - Updated Acks/Reviewed-by
> - Rebased onto linux-next
> 
> v1 -> v2:
> https://lore.kernel.org/lkml/20181109203921.178363-1-brho@google.com/
> - Updated Acks/Reviewed-by
> - Minor touchups
> - Added patch to remove redundant PageReserved() check
> - Rebased onto linux-next
> 
> RFC/discussion thread:
> https://lore.kernel.org/lkml/20181029210716.212159-1-brho@google.com/
> 
> Barret Rhoden (2):
>   mm: make dev_pagemap_mapping_shift() externally visible
>   kvm: Use huge pages for DAX-backed files
> 
>  arch/x86/kvm/mmu/mmu.c | 36 ++++++++++++++++++++++++++++++++----
>  include/linux/mm.h     |  3 +++
>  mm/memory-failure.c    | 38 +++-----------------------------------
>  mm/util.c              | 34 ++++++++++++++++++++++++++++++++++
>  4 files changed, 72 insertions(+), 39 deletions(-)
> 

Thanks, with the Acked-by already in place for patch 1 I can pick this up.

Paolo
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
