Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE411D7AF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 21:08:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6BAD110113679;
	Thu, 12 Dec 2019 12:11:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com; envelope-from=brho@google.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E03BA10113677
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 12:11:30 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 2so1422303pfx.6
        for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 12:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aJrWupuoqlaE+s8IR7dca1FQsV4mMbu8eS/d2O5egGs=;
        b=nAuBzaZ+M+jU9nrAWBIdAEOhgQaiL9q7FlV99s2L52qnyjGadAJ83ru2N1aLv4ymbI
         iVLz0nc9/aARTcufEm2u3ijh7pYZzCvqEVP4PMX5VTo71rUNDqyrRTjpiaixcRgds8I9
         VRkPInO7qAnHDfzLkFgt44gmER5AcTNO0w/gs/WBjtpQDhnllAIylznHTIlsopMn6df3
         auMaJiKcjyOeJk97/R6Xh6LncbaErvwiexu1ld6WqzUD/trx9J7mZP0Q5u4CT1I45snZ
         eVbXTPSXqOjg5grHcF9/d3UlX2UXs8/IjIF+hAGoyc8irYKiKTb7iAexn4HQ7NifbTCY
         xalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJrWupuoqlaE+s8IR7dca1FQsV4mMbu8eS/d2O5egGs=;
        b=eq0eWkhRnNJbzqtXbu0fGm72YYAicOeElzAqOK3If1XNzkS6uFRE2g7d6vgjZherfd
         QYpB47oq20Din41sPAhOEoQg78ZhrSfvZKlgH+qEfvaTZZaK3OgNHM2tLpjLF/O67KVI
         PJfBQbNovgkktW9jT90rEKCoP9a6nDWvsMsSY23F+GfI8fWN0rV7Tlze8RNd+yJCwBXR
         +LzzQZfQCrbKURyyM3KO0CCTkNN3wOwa2VH+4IKLKgjhusJdPbKeVkUAHswyT1rxrE0x
         MGN+WtdI6cDR2uSi9l/8XlyDNL0LiSm3Lfg9pdVQy/KE/IlR+sNzJb47qXZMjhzBOTEc
         xDeA==
X-Gm-Message-State: APjAAAU/ks4al5XXR2v0D9VUDGGGWYrkg7bfJeWMVvXazh95W32xha4n
	vZInRQXdUgJfIceh2NvsYT+N3g==
X-Google-Smtp-Source: APXvYqzwcu39VfGPwDpwrOKuS2wqc4pCHbQDMsKrEcbai6c25uGI5sp3lG7XYlmkvLROu8NJdfy3sQ==
X-Received: by 2002:a63:e17:: with SMTP id d23mr12668781pgl.173.1576181287757;
        Thu, 12 Dec 2019 12:08:07 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id g19sm8087571pfh.134.2019.12.12.12.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 12:08:07 -0800 (PST)
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To: Dan Williams <dan.j.williams@intel.com>
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
 <20191212173413.GC3163@linux.intel.com>
 <CAPcyv4hkz8XCETELBaUOjHQf3=VyVB=KWeRVEPYejvdsg3_MWA@mail.gmail.com>
 <b50720a2-5358-19ea-a45e-a0c0628c68b0@google.com>
 <CAPcyv4h19dKGpz0XzEHz0nOddnRAefE=rOuhGTHEL6FPhqk8GQ@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
Message-ID: <7e3d9ac4-5577-c8a3-a23c-655266376101@google.com>
Date: Thu, 12 Dec 2019 15:08:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h19dKGpz0XzEHz0nOddnRAefE=rOuhGTHEL6FPhqk8GQ@mail.gmail.com>
Content-Language: en-US
Message-ID-Hash: KPW77ORVQ5CI3YF2QNL2KL7NQM7B2SLS
X-Message-ID-Hash: KPW77ORVQ5CI3YF2QNL2KL7NQM7B2SLS
X-MailFrom: brho@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Sean Christopherson <sean.j.christopherson@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zeng, Jason" <jason.zeng@intel.com>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KPW77ORVQ5CI3YF2QNL2KL7NQM7B2SLS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 12/12/19 2:48 PM, Dan Williams wrote:
> On Thu, Dec 12, 2019 at 11:16 AM Barret Rhoden <brho@google.com> wrote:
>>
>> On 12/12/19 12:37 PM, Dan Williams wrote:
>>> Yeah, since device-dax is the only path to support longterm page
>>> pinning for vfio device assignment, testing with device-dax + 1GB
>>> pages would be a useful sanity check.
>>
>> What are the issues with fs-dax and page pinning?  Is that limitation
>> something that is permanent and unfixable (by me or anyone)?
> 
> It's a surprisingly painful point of contention...

Thanks for the info; I'll check out those threads.

[snip]

>> I'd like to put a lot more in a DAX/pmem region than just a guest's
>> memory, and having a mountable filesystem would be extremely convenient.
> 
> Why would page pinning be involved in allowing the guest to mount a
> filesystem on guest-pmem? That already works today, it's just the
> device-passthrough that causes guest memory to be pinned indefinitely.

I'd like to mount the pmem filesystem on the *host* and use its files 
for the guest's memory.  So far I've just been making an ext4 FS on 
/dev/pmem0 and creating a bunch of files in the FS.  Some of the files 
are the guest memory: one file for each VM.  Other files are just 
metadata that the host uses.

That all works right now, but I'd also like to use VFIO with the guests.

Thanks,

Barret



_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
