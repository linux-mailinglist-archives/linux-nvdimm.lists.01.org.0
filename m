Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22DA143F6F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jan 2020 15:24:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6AC431007B8CD;
	Tue, 21 Jan 2020 06:27:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=pbonzini@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1CF6B10096C97
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jan 2020 06:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1579616677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iietA04mTbBj3y8KEP1nE87RzCPxCIolbi4wDz4ohvY=;
	b=hS1TIYTWckvN2ywyyQ8N4nv6SHAb2R+9wicb9mjSeh6RYd/4npAGp8HRyNA/h+MG6eY52x
	zens1K71eRocZc4jgmWUFE+O/PeoCqK6NWwPdlgLrF5LWKM6MYsGLR/w/GIxujjtHl1Y2B
	gIDJ2YFJDiUXUMqCl9wJMQBA/tY/YqM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-xOWOOHv7N5SxXIyqEIsYRA-1; Tue, 21 Jan 2020 09:24:35 -0500
Received: by mail-wm1-f72.google.com with SMTP id p2so678068wma.3
        for <linux-nvdimm@lists.01.org>; Tue, 21 Jan 2020 06:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iietA04mTbBj3y8KEP1nE87RzCPxCIolbi4wDz4ohvY=;
        b=dUVy35T8BHVvh25qZWTdBCiKRlRMNvLj4/ggIVXXnFXbOqqqZz70ga72BS6ud6r0oZ
         /2x9iklF5cGnT5IwjU6RBq28weoeR55YEPbyTTjRO746cPvJDnOOhWziFMJinaI4Um7V
         ZjbLJs5TWgVlim8xFhweswMFU7dguSzb1/sZhv0SLpm+IjxF+jn4c/rbsQJxS5zlID3f
         DU4S4nptSs10amIMnMe8bqRSjU2QRG7DPaI5v4M414GeGsRMNECmW6F45fJVOs1wvnwz
         XSBmZ+cpKhlzJDXM4LPFN//vMS9oFF60/i3s87iMouc+4H4D+FqbxV+KzOvrlS65EkPe
         ZPXg==
X-Gm-Message-State: APjAAAXAOnx9LiZYQl8ofDfUFQlEfbIaQdIEaizAoUEGvTsTMowvtrcx
	kQsV/zDwq768QPmLtT0om6NiOhSYUY2+PhJlV9mAi1Gdg4ucn+7kE9H9fhaGs4IFTq8Ztk19vM4
	fgWNMjqRcFYLov98IG6Hw
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr5440092wrt.339.1579616673969;
        Tue, 21 Jan 2020 06:24:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTZsEeiVXo1aYXs9MoGNtX19umLmm3R/ZbsXqxiGO2rVQCtL37lQcA37U+6PdsUBw/nSKlMg==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr5440056wrt.339.1579616673641;
        Tue, 21 Jan 2020 06:24:33 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id m3sm51279088wrs.53.2020.01.21.06.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:24:33 -0800 (PST)
Subject: Re: [PATCH 04/14] KVM: Play nice with read-only memslots when
 querying host page size
To: Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
 <20200108202448.9669-5-sean.j.christopherson@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c091d40-8e32-1e55-2eff-27a4b43e0674@redhat.com>
Date: Tue, 21 Jan 2020 15:24:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200108202448.9669-5-sean.j.christopherson@intel.com>
Content-Language: en-US
X-MC-Unique: xOWOOHv7N5SxXIyqEIsYRA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: I2HUBND656ENBWOWF457Q4IGOQCU7QUQ
X-Message-ID-Hash: I2HUBND656ENBWOWF457Q4IGOQCU7QUQ
X-MailFrom: pbonzini@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paul Mackerras <paulus@ozlabs.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com, Andrea Arcangeli <aarcange@redhat.com>, Barret Rhoden <brho@google.com>, David Hildenbrand <david@redhat.com>, Jason Zeng <jason.zeng@intel.com>, Liran Alon <liran.alon@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I2HUBND656ENBWOWF457Q4IGOQCU7QUQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/01/20 21:24, Sean Christopherson wrote:
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 5f7f06824c2b..d9aced677ddd 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1418,15 +1418,23 @@ EXPORT_SYMBOL_GPL(kvm_is_visible_gfn);
>  
>  unsigned long kvm_host_page_size(struct kvm_vcpu *vcpu, gfn_t gfn)
>  {
> +	struct kvm_memory_slot *slot;
>  	struct vm_area_struct *vma;
>  	unsigned long addr, size;
>  
>  	size = PAGE_SIZE;
>  
> -	addr = kvm_vcpu_gfn_to_hva(vcpu, gfn);
> -	if (kvm_is_error_hva(addr))
> +	/*
> +	 * Manually do the equivalent of kvm_vcpu_gfn_to_hva() to avoid the
> +	 * "writable" check in __gfn_to_hva_many(), which will always fail on
> +	 * read-only memslots due to gfn_to_hva() assuming writes.
> +	 */
> +	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
> +	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
>  		return PAGE_SIZE;
>  
> +	addr = __gfn_to_hva_memslot(slot, gfn);
> +
>  	down_read(&current->mm->mmap_sem);
>  	vma = find_vma(current->mm, addr);
>  	if (!vma)
> 

Even simpler: use kvm_vcpu_gfn_to_hva_prot

-	addr = kvm_vcpu_gfn_to_hva(vcpu, gfn);
+	addr = kvm_vcpu_gfn_to_hva_prot(vcpu, gfn, NULL);

"You are in a maze of twisty little functions, all alike".

Paolo
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
