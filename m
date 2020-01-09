Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D0313615B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jan 2020 20:47:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 58B8A10097DFB;
	Thu,  9 Jan 2020 11:51:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com; envelope-from=brho@google.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E4BF510097DF7
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jan 2020 11:51:05 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id i23so3862325pfo.2
        for <linux-nvdimm@lists.01.org>; Thu, 09 Jan 2020 11:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tOr15WETxbkLw/hVhIIJI77xVs+gy+a9H8+1jFpIRfc=;
        b=cG0QOwda3n2lMKGGwl2gvG+FY0g5k14CGaWhbv4nmRcoT2JX4qtut3O08AYJiZSsJ1
         cr8cRqsI97d5/bOkzP8tKl3Tt9qtR5JvXtPKrWUCiPl4DV38hUy0eNUJDkm8kHbJEuBE
         yaFZx1vNucRxrssnQpATjd86jpNCMGp+2Uyc8U06zuHuUL2AoQcrnZJ+y884oRxt8t+n
         VRC8uxlGUAtadaiER22t+8Zb5vtrFxei+x4QHt8BHfVM01jX4dRRdZl9Mv3Dje2YTVYW
         tV4Ihp6XBYA3izk3Ms3j7QY4sBnbwek7lIwiWDhHQ5xPFFbll2klVlmKSmR8wUaYCyZ9
         y5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tOr15WETxbkLw/hVhIIJI77xVs+gy+a9H8+1jFpIRfc=;
        b=L98HgrXH+LrhSKr3CkFmMsfk0NRfCsa9OyYn7RFT4NDji9RCQfxYW4NZinsEdXMhub
         IQrvcbw6u/WuCEl2rAIAWN2gqORhtTKF99UTihGVUFPya99636l+mQ0bfECZjP1YdMLI
         18fIOVsL28lNBBX2Ne1GKcbBnjtTHc4WbjQlI2VeRQnDonJiqDlDZobxvHhPpyUyKLEp
         p4kHyIhbyvGwD/TbiNuuois2xqovTYqjt3hHvyxDZNbp5YSlkcz5eByYrXsEzy1OGoIo
         MaDACtKJ6dHHgBCaW7cb3+/04gqFcIoLPZf+lDvYg2A7BG5b4X8ksr9uZmVveeKU5bXp
         49rw==
X-Gm-Message-State: APjAAAUpOHIrFIivD8tIfYmRHwC/g9iT5b1wAx3B1o/CkLRjS2stoKAu
	2Pr62g7iqNZuXkb5yEhYHFZp1+Jf/VuoFLDd
X-Google-Smtp-Source: APXvYqzh23zJ0M/6YUkb1gak5IeC/b1rxGMe/2+na8ui5AM37mG7vNvlQ/Y50JVkaXV8dlCW2yJyFQ==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr235672pfh.124.1578599265739;
        Thu, 09 Jan 2020 11:47:45 -0800 (PST)
Received: from gnomeregan01.cam.corp.google.com ([2620:15c:6:14:50b7:ffca:29c4:6488])
        by smtp.googlemail.com with ESMTPSA id z130sm8572761pgz.6.2020.01.09.11.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 11:47:44 -0800 (PST)
Subject: Re: [PATCH 00/14] KVM: x86/mmu: Huge page fixes, cleanup, and DAX
To: Sean Christopherson <sean.j.christopherson@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200108202448.9669-1-sean.j.christopherson@intel.com>
From: Barret Rhoden <brho@google.com>
Message-ID: <e3e12d17-32e4-84ad-94da-91095d999238@google.com>
Date: Thu, 9 Jan 2020 14:47:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108202448.9669-1-sean.j.christopherson@intel.com>
Content-Language: en-US
Message-ID-Hash: IQC6VZDLWTGFKQDHOQDNPOV2HAHBQ2LS
X-Message-ID-Hash: IQC6VZDLWTGFKQDHOQDNPOV2HAHBQ2LS
X-MailFrom: brho@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paul Mackerras <paulus@ozlabs.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, syzbot+c9d1fb51ac9d0d10c39d@syzkaller.appspotmail.com, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, Jason Zeng <jason.zeng@intel.com>, Liran Alon <liran.alon@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IQC6VZDLWTGFKQDHOQDNPOV2HAHBQ2LS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Hi -

On 1/8/20 3:24 PM, Sean Christopherson wrote:
> This series is a mix of bug fixes, cleanup and new support in KVM's
> handling of huge pages.  The series initially stemmed from a syzkaller
> bug report[1], which is fixed by patch 02, "mm: thp: KVM: Explicitly
> check for THP when populating secondary MMU".
> 
> While investigating options for fixing the syzkaller bug, I realized KVM
> could reuse the approach from Barret's series to enable huge pages for DAX
> mappings in KVM[2] for all types of huge mappings, i.e. walk the host page
> tables instead of querying metadata (patches 05 - 09).

Thanks, Sean.  I tested this patch series out, and it works for me. 
(Huge KVM mappings of a DAX file, etc.).

Thanks,

Barret


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
