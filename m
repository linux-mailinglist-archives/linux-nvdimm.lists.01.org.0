Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBF2143FCB
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 Jan 2020 15:40:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D16B81007B8D1;
	Tue, 21 Jan 2020 06:44:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=pbonzini@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 10EEA1007B8CF
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jan 2020 06:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1579617648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSSit0Wm+RQr1Jgst7x5naV4XKUyLXD3AhAyDv7TiYs=;
	b=Tj7tj63hMPU19wrJcoj1TH8CGkiDyBpUV3lfXKpgy2kY8apxYkEalVoHqja4B886ckbsla
	+UrtKNn3GJ1fSQym3X5fbjorDKM6/GCXAXtUvWlvrlsa02kmH+/vbw1UsKo+MhYL9VMKoa
	qtADOhqfqaNDHHfMIPqDxYy9/nL2ugM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-GUybz2UgMxahiXajjaLicg-1; Tue, 21 Jan 2020 09:40:46 -0500
Received: by mail-wr1-f69.google.com with SMTP id r2so1393734wrp.7
        for <linux-nvdimm@lists.01.org>; Tue, 21 Jan 2020 06:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JSSit0Wm+RQr1Jgst7x5naV4XKUyLXD3AhAyDv7TiYs=;
        b=gyTYOpZDfBDPoH8TxoZRu6qUwGl9W7rq5RbAvaVKm3tarFrRa1lgAk8a3fxn80eAGZ
         H6ZHWjB7TO8qr4FgEuMPiv5CdmudmkITk3XB5kAzYLhCeMuETryzFY6rwiQ0rE6hq4Xd
         SbtkrX3eOSBRcPm6/oFRUTxay+JvkWTah9jtydPtzQvfxd3uTOmbDVfSpsMxF/EFxAcf
         GQwdZgrkkhaLDe1TKBZUs1xjPuIQibS/jQxxQXGKwJkfHdo/QnKebZOJ0C63r1SKjU7m
         hnlQOAcAhG9aLEut2Ild+RX3g8jJRoijrK8EU0NEQCL/WnCEtwAElhJCjpgxp/EY+0pD
         Vl5g==
X-Gm-Message-State: APjAAAXI3mTd7zZvUozNBckIW/0iVVrhgeESzbqHkdPMbgpM5d/Z1w/m
	njktybPvkV9MXz6MtQfns51RgXtwr7d+aLMinP1KYJK5YrT4olH9oqJX1WkT+VnVWTce1WfaP3t
	2j+cl3xU27nru1bB+ie9W
X-Received: by 2002:a7b:c851:: with SMTP id c17mr4596893wml.71.1579617645322;
        Tue, 21 Jan 2020 06:40:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUkg5d8MSonCO4Ge0L397jZ+4TsON4lVJzpAggAw2WjkJCWhAHkQt1Jw0IPvgT93BvWQD3aw==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr4596848wml.71.1579617645022;
        Tue, 21 Jan 2020 06:40:45 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id b67sm4417502wmc.38.2020.01.21.06.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:40:44 -0800 (PST)
Subject: Re: [PATCH 07/14] KVM: x86/mmu: Walk host page tables to find THP
 mappings
To: Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
 <20200108202448.9669-8-sean.j.christopherson@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e9987a2-c34f-362d-a123-7dc4849811d1@redhat.com>
Date: Tue, 21 Jan 2020 15:40:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200108202448.9669-8-sean.j.christopherson@intel.com>
Content-Language: en-US
X-MC-Unique: GUybz2UgMxahiXajjaLicg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: V2EF7JQDBJR43FSFD2TJ7L2OLD2KWK6W
X-Message-ID-Hash: V2EF7JQDBJR43FSFD2TJ7L2OLD2KWK6W
X-MailFrom: pbonzini@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paul Mackerras <paulus@ozlabs.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com, Andrea Arcangeli <aarcange@redhat.com>, Barret Rhoden <brho@google.com>, David Hildenbrand <david@redhat.com>, Jason Zeng <jason.zeng@intel.com>, Liran Alon <liran.alon@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V2EF7JQDBJR43FSFD2TJ7L2OLD2KWK6W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/01/20 21:24, Sean Christopherson wrote:
> +
> +	/*
> +	 * Manually do the equivalent of kvm_vcpu_gfn_to_hva() to avoid the
> +	 * "writable" check in __gfn_to_hva_many(), which will always fail on
> +	 * read-only memslots due to gfn_to_hva() assuming writes.  Earlier
> +	 * page fault steps have already verified the guest isn't writing a
> +	 * read-only memslot.
> +	 */
> +	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
> +	if (!memslot_valid_for_gpte(slot, true))
> +		return PT_PAGE_TABLE_LEVEL;
> +
> +	hva = __gfn_to_hva_memslot(slot, gfn);
> +

Using gfn_to_memslot_dirty_bitmap is also a good excuse to avoid
kvm_vcpu_gfn_to_hva.

+	slot = gfn_to_memslot_dirty_bitmap(vcpu, gfn, true);
+	if (!slot)
+		return PT_PAGE_TABLE_LEVEL;
+
+	hva = __gfn_to_hva_memslot(slot, gfn);

(I am planning to remove gfn_to_hva_memslot so that __gfn_to_hva_memslot
can lose the annoying underscores).

Paolo
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
