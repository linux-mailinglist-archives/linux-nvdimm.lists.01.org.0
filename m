Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6900152227
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 Feb 2020 22:57:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B3A091007B1F7;
	Tue,  4 Feb 2020 14:00:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f41; helo=mail-qv1-xf41.google.com; envelope-from=brho@google.com; receiver=<UNKNOWN> 
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 691211007B1F3
	for <linux-nvdimm@lists.01.org>; Tue,  4 Feb 2020 14:00:35 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id y8so141017qvk.6
        for <linux-nvdimm@lists.01.org>; Tue, 04 Feb 2020 13:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o8PJJopMHRnW2Lc0cvuzqZJdPgsHNH4EmbqfPi2CudQ=;
        b=OH2U30gH+ZDmHD5RKklKpDEpNSUh2d5eNyvmYsHQBPN7ljSC5DhtSh97amEFql9+83
         HIKukiAIGsoEcookCeIj3IUimjLT45df6BDTvuoIo97U1KeQIHYtNEdNFu5RI5RlTo94
         5wxZ2VMVw23n+ITPWSknknHiTgiwthNe9VreGu8Ak3ShMZuF77zCdXwW+bOD1pC3+TPj
         cHpvtOPMDheERtzU01rUP+UH5fm5uyvTwTXecYfA3Vfie6gNJnHoWPx1I0HaXpEIa7d1
         XDwcPqTpjbFockMXiPTgzD/tqt3FHDIemmXEJopYHIVMf6OPHIBcjBniqMhd7BFvVtsU
         j3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o8PJJopMHRnW2Lc0cvuzqZJdPgsHNH4EmbqfPi2CudQ=;
        b=TR+jAZ4gpWVsiFj0h7y9pFmav/kmTreZsLF/dOjZV4pWvcfgzz6pn2W5G8Tgwj4FYa
         t15zxajFBLg9tJRFqG6bs4wAg/fRRNg5gUqPirW9H6Xun7uFS/EvNcN4hYrzJyk3NBRB
         cizX8+AAuhmTLSmu3q/PrFAnPCu42dt9rkvqRYcNP7OPmdYj7LwLyU7qbQqrUVKPUKPg
         Xd3wbt4VsUS+iwUVx4bazP9gmA98u28BgETIVGWrDcV9CpwlUrwZObzISFNCx512uq/o
         RySwq5enHAtkELTzH80NOb6N3o9Op+aNKcFzCVulagp6S3BLJmOVAWfS0eDJbKtt01e+
         BSJw==
X-Gm-Message-State: APjAAAV0b65Drt5Ul6a+H1jHJ/SumfzG3mLAubt8k3j4bvNdBRvuQM7O
	oHp+OQVDUlOm3cxpGUowR7ORqA==
X-Google-Smtp-Source: APXvYqw8wHQQ0TYYiyrNaAoyP1/6XXQmpVV3cfhOYaaGrRAqGG/43MHnS1ojgBUHUfnNQbnIl0rsDw==
X-Received: by 2002:ad4:4511:: with SMTP id k17mr28109982qvu.135.1580853435966;
        Tue, 04 Feb 2020 13:57:15 -0800 (PST)
Received: from ?IPv6:2620:0:1004:a:6e2b:60f7:b51b:3b04? ([2620:0:1004:a:6e2b:60f7:b51b:3b04])
        by smtp.gmail.com with ESMTPSA id y26sm12042230qtv.28.2020.02.04.13.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 13:57:15 -0800 (PST)
Subject: Re: [PATCH RFC 10/10] nvdimm/e820: add multiple namespaces support
To: Dan Williams <dan.j.williams@intel.com>
References: <20200110190313.17144-1-joao.m.martins@oracle.com>
 <20200110190313.17144-11-joao.m.martins@oracle.com>
 <e605fed8-46f5-6a07-11e6-2cc079a1159b@google.com>
 <CAPcyv4iiSsEOsfEwLQcV3bNDjBSxw1OgWoBdEWPQEymq6=xm-A@mail.gmail.com>
 <ae788015-616f-96e6-3a0e-39c1911c4b01@google.com>
 <CAPcyv4ibWZgCSTqnYLicVR3vXeNKwuWSnV5K8fCwvyhz_h=0GQ@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
Message-ID: <fb4efb83-1a19-4fb7-a32a-477d5b5cd80a@google.com>
Date: Tue, 4 Feb 2020 16:57:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ibWZgCSTqnYLicVR3vXeNKwuWSnV5K8fCwvyhz_h=0GQ@mail.gmail.com>
Content-Language: en-US
Message-ID-Hash: S3HHVWQZO6JX5YJJSLDBPSNXM7TDJVRJ
X-Message-ID-Hash: S3HHVWQZO6JX5YJJSLDBPSNXM7TDJVRJ
X-MailFrom: brho@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Joao Martins <joao.m.martins@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, KVM list <kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Liran Alon <liran.alon@oracle.com>, Nikita Leshenko <nikita.leshchenko@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Matthew Wilcox <willy@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S3HHVWQZO6JX5YJJSLDBPSNXM7TDJVRJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 2/4/20 4:43 PM, Dan Williams wrote:
> Ah, got it, you only ended up at wanting namespace labels because
> there was no other way to carve up device-dax. That's changing as part
> of the efi_fake_mem= enabling and I have a patch set in the works to
> allow discontiguous sub-divisions of a device-dax range. Note that is
> this branch rebases frequently:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/log/?h=libnvdimm-pending

Cool, thanks.  I'll check it out!

Barret
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
