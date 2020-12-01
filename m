Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2332C9494
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Dec 2020 02:20:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E2CD0100ED4AC;
	Mon, 30 Nov 2020 17:20:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C3BE3100ED4AB
	for <linux-nvdimm@lists.01.org>; Mon, 30 Nov 2020 17:20:31 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id s13so493381ejr.1
        for <linux-nvdimm@lists.01.org>; Mon, 30 Nov 2020 17:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=J+1U/f8XUIfRYcLWaEg2HuJO67e2bBkfXtfCPlsTd8I=;
        b=Uzmqq/O0H8LGO8ruL15nzggaqZT5+d2foYv3eXaSR9eNZIPcQwx9us0q6mHObu0lyZ
         STWaZymD2WDC9z8lUYjT6RDWe1Ek+qgPxfgjzFBmxAcXmnljtAO2Mp2JikFtTsCMyjDT
         FEfHk5WXXH6X6iRsgt740Uon3v/4GujWFcy2/3bL6AoDnJ52xj42AUomdmC1EJjzSPIs
         kkItq0ZgVFlnfGJKJBxKCBA/GwhW9MWHoBpnNLJd1T6y2Tf++ePuwgljIAv++/AM0lLr
         0MyMazwANlgRfgSOINEXOXXHdCDaT2uZHLQTJ8BL2UXzVOErHpCDaktgGpRQ7qV0omJl
         B3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=J+1U/f8XUIfRYcLWaEg2HuJO67e2bBkfXtfCPlsTd8I=;
        b=lA9OcRSzW7YSOLmu6l3wTQPx0i9jBJXZSfgSs8KQNu0EihXxDobbvFHX6br5rHXZVP
         QaS+tmw9UnD51PjpF0HHBMhQvyDfql9mb61YJhhXHg2mnFZHkHvPxhbnrevPSb9jOQzG
         QA5GKg6s0U3jdDZG0j+XqXywjcI7dEQ++acWDYqsaLTsqlkv9q2Er3SqabDmEA1tHybh
         DzWWVQ8pPhB52MG2/jk+jo5tmT+eykXbO0720hnhAe8jlIlRKH7JgyXPW7UKUVmgBWRL
         SDnzUH0c10p37TMMAe+88SDrCMMBlKDaAgVzu6XLBoPm7VdshLYjh7lfp4Fhg7GXtYzw
         YB7w==
X-Gm-Message-State: AOAM532a/V1jS0toHLHOrouw+YfsIbxDn0YR9/xhQNZUNDEruZXzV2CU
	/PABx+tsyFkDERj2bS66Rskc3+LZP0/72jX0mQdtmQ==
X-Google-Smtp-Source: ABdhPJwQsKZvZIvFtzYz5SKLhjU9W4cEeglvDwkZ9WlyzschrlmmfuQnvhrsnqHbTMw6vrio/DD/YMY3EUD2jcR43as=
X-Received: by 2002:a17:906:6bc9:: with SMTP id t9mr641225ejs.472.1606785629524;
 Mon, 30 Nov 2020 17:20:29 -0800 (PST)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 30 Nov 2020 17:20:25 -0800
Message-ID: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
Subject: mapcount corruption regression
To: "Shutemov, Kirill" <kirill.shutemov@intel.com>, Matthew Wilcox <willy@infradead.org>
Message-ID-Hash: 2NSJQSWQP3766AEHAAWPIE4PRAYON2FQ
X-Message-ID-Hash: 2NSJQSWQP3766AEHAAWPIE4PRAYON2FQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2NSJQSWQP3766AEHAAWPIE4PRAYON2FQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Kirill, Willy, compound page experts,

I am seeking some debug ideas about the following splat:

BUG: Bad page state in process lt-pmem-ns  pfn:121a12
page:0000000051ef73f7 refcount:0 mapcount:-1024
mapping:0000000000000000 index:0x0 pfn:0x121a12
flags: 0x2ffff800000000()
raw: 002ffff800000000 dead000000000100 0000000000000000 0000000000000000
raw: 0000000000000000 ffff8a6914886b48 00000000fffffbff 0000000000000000
page dumped because: nonzero mapcount
[..]
CPU: 26 PID: 6127 Comm: lt-pmem-ns Tainted: G           OE     5.10.0-rc4+ #450
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
Call Trace:
 dump_stack+0x8b/0xb0
 bad_page.cold+0x63/0x94
 free_pcp_prepare+0x224/0x270
 free_unref_page+0x18/0xd0
 pud_free_pmd_page+0x146/0x160
 ioremap_pud_range+0xe3/0x350
 ioremap_page_range+0x108/0x160
 __ioremap_caller.constprop.0+0x174/0x2b0
 ? memremap+0x7a/0x110
 memremap+0x7a/0x110
 devm_memremap+0x53/0xa0
 pmem_attach_disk+0x4ed/0x530 [nd_pmem]

It triggers on v5.10-rc4 not on v5.9, but the bisect comes up with an
ambiguous result. I've run the bisect 3 times and landed on:

032c7ed95817 Merge tag 'arm64-upstream' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux

...which does not touch anything near _mapcount. I suspect there is
something unique about the build that lines up the corruption to
happen or not happen.

The test is a simple namespace creation test that results in an
memremap() / ioremap() over several gigabytes of memory capacity. The
-1024 was interesting because that's the GUP_PIN_COUNTING_BIAS, but
that's the _refcount, I did not see any questionable changes to how
_mapcount is manipulated post v5.9. Problem should be reproducible by
running:

make -j TESTS="pmem-ns" check

...in qemu-kvm with some virtual pmem defined:

-object memory-backend-file,id=mem1,share,mem-path=${mem}1,size=$((mem_size+label_size))
-device nvdimm,memdev=mem1,id=nv1,label-size=${label_size}

...where ${mem}1 is a 128GB sparse file $mem_size is 127GB and
$label_size is 128KB.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
