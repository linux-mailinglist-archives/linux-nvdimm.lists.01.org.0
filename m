Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F363511D6EA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 20:16:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A7E7610113674;
	Thu, 12 Dec 2019 11:20:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1043; helo=mail-pj1-x1043.google.com; envelope-from=brho@google.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D9FAB10113317
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 11:19:58 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id r11so1450340pjp.12
        for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 11:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MNaR/QuknJAHIB0pQcQsq4R3Kk/5rQ+DPsOAQIxnnSw=;
        b=KAaolzVGGhfdtct3LZlhCTEopQdtdhFue5scfWobqwTsj8pWuL8PPQeLqKwSEwDDPT
         RH6zj3ONxLD+ZNNz2rnjB8aOkq+zyRGMUKrwm47RHKOKhZLJjBMEFm+Oprp2T+rETJsj
         u3YQMbP2yvBsoYxCqcj4VtuRXuZgqZI06zy9VGC0ph50IaQHvHUlW6pvuzBQqamMWb/6
         MxKKPVfqkUfpOJKet7l4NXuP1wWltJKpviBeyXO6YQd5nklpHbB09zTViE0KGCvRYD1e
         mgR27tzL277oAJHraSihXtCCjBO3L65OKHZ0vDGDPX7aHDav/w/EBjeVOcSGNbXhWfOg
         tltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MNaR/QuknJAHIB0pQcQsq4R3Kk/5rQ+DPsOAQIxnnSw=;
        b=dMiIApcULGy0EERfzDWpPUVla0itNgJ6dffPO6GWSc0h6W4DtP3h16Ihm1pMn5hU8F
         5mWIUsWZthKKvn3jEuLx80l3DrhuuBYyayuapaP6ki6XLscrAI/RhYUv2BQVh+R/lSWi
         sCbH83vxO9TPtDydzlSWgR+1vxXi79VcpLJJiDl/kmsWxKy2qQqT20GTMj2sJZt94rbO
         yNX9INFs0eluqkcMIMGDWBtjo4YIucVJTZg+b8MIAxaaUx3167pE9Gm2UV646zRltBbU
         67tJ65zuq46HixJVF1rr5FkByfq8DfQgn/yzqSPB+9hMLUVOFRnqX3IYaCc02H7K8DGs
         imdA==
X-Gm-Message-State: APjAAAUYzKSsZDuqNmlcuMCS2wmqtOwhcYFYk7Gwadqj8YGrLkpObDRW
	JIJCOGXifVM1quQTzoT7jSCw8Q==
X-Google-Smtp-Source: APXvYqx/9O2gkZlxhLDydhoZN8PUSRgnOhN7UqLc/bxYHtv2gdkUDry2PRLvM5QCHRSKPYXaQiMGYg==
X-Received: by 2002:a17:90b:85:: with SMTP id bb5mr11377895pjb.22.1576178195916;
        Thu, 12 Dec 2019 11:16:35 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id e1sm8314913pfl.98.2019.12.12.11.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 11:16:35 -0800 (PST)
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To: Dan Williams <dan.j.williams@intel.com>
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
 <20191212173413.GC3163@linux.intel.com>
 <CAPcyv4hkz8XCETELBaUOjHQf3=VyVB=KWeRVEPYejvdsg3_MWA@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
Message-ID: <b50720a2-5358-19ea-a45e-a0c0628c68b0@google.com>
Date: Thu, 12 Dec 2019 14:16:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hkz8XCETELBaUOjHQf3=VyVB=KWeRVEPYejvdsg3_MWA@mail.gmail.com>
Content-Language: en-US
Message-ID-Hash: FN74TNI7JOEGXCJ4HJ3EJSK7MNNVIGSF
X-Message-ID-Hash: FN74TNI7JOEGXCJ4HJ3EJSK7MNNVIGSF
X-MailFrom: brho@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Sean Christopherson <sean.j.christopherson@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zeng, Jason" <jason.zeng@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FN74TNI7JOEGXCJ4HJ3EJSK7MNNVIGSF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12/12/19 12:37 PM, Dan Williams wrote:
> Yeah, since device-dax is the only path to support longterm page
> pinning for vfio device assignment, testing with device-dax + 1GB
> pages would be a useful sanity check.

What are the issues with fs-dax and page pinning?  Is that limitation 
something that is permanent and unfixable (by me or anyone)?

I'd like to put a lot more in a DAX/pmem region than just a guest's 
memory, and having a mountable filesystem would be extremely convenient.

Thanks,

Barret

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
