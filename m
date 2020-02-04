Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A76152059
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 Feb 2020 19:20:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C314F10FC339E;
	Tue,  4 Feb 2020 10:23:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=brho@google.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2567410FC339D
	for <linux-nvdimm@lists.01.org>; Tue,  4 Feb 2020 10:23:43 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id e8so4986088plt.9
        for <linux-nvdimm@lists.01.org>; Tue, 04 Feb 2020 10:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CAMBy3NGAyHNH2wCGCsteiJRgCMQA3d7e+wpMMPzaNM=;
        b=dBA6JtY8VAIHgTSG/m3Mm694yoeeGq0PpedkAvgfVdygHk+yDxvbEkaI0OZgAruXCd
         Oqxs/pAIkdyQh3FUG6RW6hx5Jm+8ioqk1rDFVpeB4P7NAkkgWAwIHKgE5toPWVQ/Gfp4
         spH3EiYZ+2IrGNIGbKXv45ye3A6lTdm7929uTztEkFX0h/iyZ/JsRt5CDrtU/vfVKq4d
         gbIZHXJKSkEDYaUeRZlPLXThNErMfFRfj3ZS5FK665oPREjtQwyQaLevKqdqy4HinU68
         F7UvQkHg8tQdVE6eajwq41kb0fIzVHYnWkT+AJoHJ1OQFbiJxHHeWYi12IuU9pcbg+4j
         zxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CAMBy3NGAyHNH2wCGCsteiJRgCMQA3d7e+wpMMPzaNM=;
        b=FS+1L/83dqD5c63fZonu719DCn+fRmffoEOETdvorQ9x4xyhj/E5bX0t4JLzDk3uWC
         A5p0AQsSwpL2Cl6Rcprz2jdO/Z3++7NXGgSt/Lp2vYFF4OmDbohn5MpvHSxdERy4irqv
         ukV3E1aPvBrsggu+9N4byMdkz4qQA7amw3ThpdTJDndHDWr8E2cvwqq1sshYbYLQnOuA
         ZIYCUdTRC39/Hd7rv84eLZkuno6bCVl5AI1u59VZsIqpA+B1DmfZzUPGRaeWqenoSpqr
         pxx2HS9E5f7/ximSVYg+rCUAWFdtnoCi8ljpA6t/+iYrK6p/MeDSPnQWgFydRaLSCZ6v
         bINw==
X-Gm-Message-State: APjAAAUopsyIdLnh7x0mPJNo+QiM7gzRtUS+pWSIRPzC/Gg4sH8p5eea
	gIUjizM4IbNl9rn7DQyxzcRaJ4AZa4tgBsha
X-Google-Smtp-Source: APXvYqwRjsxFHkomjw16464hTqweh60BpZMJ6xeDoW9lFDkzNpbofpmThIZb3diiY9PJQguYwiSX3A==
X-Received: by 2002:a17:90a:cb11:: with SMTP id z17mr468603pjt.122.1580840424859;
        Tue, 04 Feb 2020 10:20:24 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:50b7:ffca:29c4:6488])
        by smtp.googlemail.com with ESMTPSA id f127sm25578589pfa.112.2020.02.04.10.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 10:20:24 -0800 (PST)
Subject: Re: [PATCH RFC 10/10] nvdimm/e820: add multiple namespaces support
To: Dan Williams <dan.j.williams@intel.com>
References: <20200110190313.17144-1-joao.m.martins@oracle.com>
 <20200110190313.17144-11-joao.m.martins@oracle.com>
 <e605fed8-46f5-6a07-11e6-2cc079a1159b@google.com>
 <CAPcyv4iiSsEOsfEwLQcV3bNDjBSxw1OgWoBdEWPQEymq6=xm-A@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
Message-ID: <ae788015-616f-96e6-3a0e-39c1911c4b01@google.com>
Date: Tue, 4 Feb 2020 13:20:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iiSsEOsfEwLQcV3bNDjBSxw1OgWoBdEWPQEymq6=xm-A@mail.gmail.com>
Content-Language: en-US
Message-ID-Hash: RA3MLTUKHWAA2RR6CKP6TFHA5KPH4HCX
X-Message-ID-Hash: RA3MLTUKHWAA2RR6CKP6TFHA5KPH4HCX
X-MailFrom: brho@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Joao Martins <joao.m.martins@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, KVM list <kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Liran Alon <liran.alon@oracle.com>, Nikita Leshenko <nikita.leshchenko@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Matthew Wilcox <willy@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RA3MLTUKHWAA2RR6CKP6TFHA5KPH4HCX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Hi -

On 2/4/20 11:44 AM, Dan Williams wrote:
> On Tue, Feb 4, 2020 at 7:30 AM Barret Rhoden <brho@google.com> wrote:
>>
>> Hi -
>>
>> On 1/10/20 2:03 PM, Joao Martins wrote:
>>> User can define regions with 'memmap=size!offset' which in turn
>>> creates PMEM legacy devices. But because it is a label-less
>>> NVDIMM device we only have one namespace for the whole device.
>>>
>>> Add support for multiple namespaces by adding ndctl control
>>> support, and exposing a minimal set of features:
>>> (ND_CMD_GET_CONFIG_SIZE, ND_CMD_GET_CONFIG_DATA,
>>> ND_CMD_SET_CONFIG_DATA) alongside NDD_ALIASING because we can
>>> store labels.
>>
>> FWIW, I like this a lot.  If we move away from using memmap in favor of
>> efi_fake_mem, ideally we'd have the same support for full-fledged
>> pmem/dax regions and namespaces that this patch brings.
> 
> No, efi_fake_mem only supports creating dax-regions. What's the use
> case that can't be satisfied by just specifying multiple memmap=
> ranges?

I'd like to be able to create and destroy dax regions on the fly.  In 
particular, I want to run guest VMs using the dax files for guest 
memory, but I don't know at boot time how many VMs I'll have, or what 
their sizes are.  Ideally, I'd have separate files for each VM, instead 
of a single /dev/dax.

I currently do this with fs-dax with one big memmap region (ext4 on 
/dev/pmem0), and I use the file system to handle the 
creation/destruction/resizing and metadata management.  But since fs-dax 
won't work with device pass-through, I started looking at dev-dax, with 
the expectation that I'd need some software to manage the memory (i.e. 
allocation).  That led me to ndctl, which seems to need namespace labels 
to have the level of control I was looking for.

Thanks,

Barret
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
