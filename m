Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E64E810E3BF
	for <lists+linux-nvdimm@lfdr.de>; Sun,  1 Dec 2019 22:58:33 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6246A1011362A;
	Sun,  1 Dec 2019 14:01:54 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::742; helo=mail-qk1-x742.google.com; envelope-from=jcm@jonmasters.org; receiver=<UNKNOWN> 
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AF34C10113628
	for <linux-nvdimm@lists.01.org>; Sun,  1 Dec 2019 14:01:51 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id x1so15923888qkl.12
        for <linux-nvdimm@lists.01.org>; Sun, 01 Dec 2019 13:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wGf8SOslmQtXKi1QI9BMUXk6iVKg26mOeGKK2Ks7MYE=;
        b=haC2yWerrh/EPaAEWE30LtPPVcYglspCRi6YH2nLwTymB5BM0YVdLfcoNnZKG3q3Bp
         nOSJ41/CKSvenze+4GkAAoq9bgeuRouOnCj/Es44/V2bwrq26knTKVbWMzAGr0r749mb
         l9l7id8p4zBh9Bje3/MjsdxqHSo5evu/yTNVQi8BvsDS+18ao29L2rZrywVaBAa5E+Bn
         x0RXh5ocXSXB2kcnHvuNdkfBFp74hGdBEPxb3dVc9RanQywc+6L9xpOsFqptvfDXXicS
         mFu5VCz81jgRJ+DlsgqYbP8yL+YXeDjRXyJey+9AqIWUJ9fl43km/G+rUxio59oiON8g
         B+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wGf8SOslmQtXKi1QI9BMUXk6iVKg26mOeGKK2Ks7MYE=;
        b=OE5OPpiSiE6URdoFFGhRRKzGxhOU0THQKrn5XnSXssezt7EE+3imHVPHwuQmzv/ijq
         U+QLXuM9xYkHeBw3pXjTjtyDGDeCH2fPogNVbeVmMrBNKkkMs9O/nn17v6yx9FqAv7iy
         ZComhZxkX2XCEqonyx30+6HxYgiI0GG+Wa6O/3t9V/f81scf8rSHMu9EiUQpTRMEnxOX
         c7UKer5+5x5vVUutdL1YI9PX2NWrFnbhqqMs3cLKP+B7P0PD6GgVkIkFbH9FzgO9JLSm
         KshF6DYkbOOdC1Cx5Qay3VZUb3uc8kx3SoaAl4gbrnvT7ShtSEiDuwz/yNPViABlvXsz
         SLGw==
X-Gm-Message-State: APjAAAVorNTp+sUfyVLelm7SPeodD0BAhFcIWIdbP7Q9w6iS37oIfr5e
	gu1yrGvVcHHmxFm9zwo5rOrxDQ==
X-Google-Smtp-Source: APXvYqyneloIKBeXc5AlpZqXq7qebSG4Sm7XfSawnJmWBKgRDS3WvxrB+RD3J2nDCv0D3KoFXS2jaA==
X-Received: by 2002:a37:434d:: with SMTP id q74mr28864727qka.187.1575237507536;
        Sun, 01 Dec 2019 13:58:27 -0800 (PST)
Received: from independence.bos.jonmasters.org (24-148-33-89.s2391.c3-0.grn-cbr1.chi-grn.il.cable.rcncustomer.com. [24.148.33.89])
        by smtp.gmail.com with ESMTPSA id t38sm4905845qta.78.2019.12.01.13.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2019 13:58:27 -0800 (PST)
Subject: Re: DAX filesystem support on ARMv8
To: Bharat Kumar Gogada <bharatku@xilinx.com>,
 Matthew Wilcox <willy@infradead.org>, Dan Williams <dan.j.williams@intel.com>
References: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
 <CAPcyv4j75cQ4dSqyKGuioyyf0O9r0BG0TjFgv+w=64gLah5z6w@mail.gmail.com>
 <20191112220212.GC7934@bombadil.infradead.org>
 <MN2PR02MB6336070627E66ED8AE646BACA5710@MN2PR02MB6336.namprd02.prod.outlook.com>
From: Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <e01ee855-cb11-d059-6c46-836283b9e251@jonmasters.org>
Date: Sun, 1 Dec 2019 13:54:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <MN2PR02MB6336070627E66ED8AE646BACA5710@MN2PR02MB6336.namprd02.prod.outlook.com>
Content-Language: en-US
Message-ID-Hash: YJ4XDZAYXVWHA7KNLREKMT2VJZ2CLUHA
X-Message-ID-Hash: YJ4XDZAYXVWHA7KNLREKMT2VJZ2CLUHA
X-MailFrom: jcm@jonmasters.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YJ4XDZAYXVWHA7KNLREKMT2VJZ2CLUHA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 11/14/19 1:54 AM, Bharat Kumar Gogada wrote:
>>
>> On Tue, Nov 12, 2019 at 09:15:18AM -0800, Dan Williams wrote:
>>> On Mon, Nov 11, 2019 at 6:12 PM Bharat Kumar Gogada
>> <bharatku@xilinx.com> wrote:
>>>>
>>>> Hi All,
>>>>
>>>> As per Documentation/filesystems/dax.txt
>>>>
>>>> The DAX code does not work correctly on architectures which have
>>>> virtually mapped caches such as ARM, MIPS and SPARC.
>>>>
>>>> Can anyone please shed light on dax filesystem issue w.r.t ARM architecture
>> ?
>>>
>>> The concern is VIVT caches since the kernel will want to flush pmem
>>> addresses with different virtual addresses than what userspace is
>>> using. As far as I know, ARMv8 has VIPT caches, so should not have an
>>> issue. Willy initially wrote those restrictions, but I am assuming
>>> that the concern was managing the caches in the presence of virtual
>>> aliases.
>>
>> The kernel will also access data at different virtual addresses from userspace.
>> So VIVT CPUs will be mmap/read/write incoherent, as well as being flush
>> incoherent.
> 
> Thanks a lot Wilcox and Dan for clarification.
> So the above restriction only applies to ARM architectures with VIVT caches and not
> for VIPT caches.

VMSAv8-64 (Armv8) requires that data caches behave as if they were PIPT. 
Meaning there is not a situation as described above.

Jon.

-- 
Computer Architect
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
