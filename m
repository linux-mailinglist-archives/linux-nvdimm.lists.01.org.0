Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB90D225D79
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jul 2020 13:30:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08D1E12385F8E;
	Mon, 20 Jul 2020 04:30:38 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=212.227.126.134; helo=mout.kundenserver.de; envelope-from=arnd@arndb.de; receiver=<UNKNOWN> 
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D47F012385F8A
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 04:30:34 -0700 (PDT)
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MCska-1k6Jho00PI-008tD9 for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020
 13:30:32 +0200
Received: by mail-qt1-f178.google.com with SMTP id g13so12601240qtv.8
        for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 04:30:31 -0700 (PDT)
X-Gm-Message-State: AOAM530S7J/ixSDXugeX0E2U7qNI9Yi13jGeqdAXXNCeIdUFPRZemWkL
	5oygvVbsQFudZZmpX1wGaOq1X+0dU9QQE56oZGQ=
X-Google-Smtp-Source: ABdhPJybaWn8qrmG7q01lgvZCZBti2IcqiiH7/UJUKpkh5l1pzukFrbCvJJFdRaOz1n0M6O3nf2Yvp55077wbmpCEEY=
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr20996310qko.138.1595244629225;
 Mon, 20 Jul 2020 04:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
In-Reply-To: <20200720092435.17469-4-rppt@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 20 Jul 2020 13:30:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com>
Message-ID: <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
To: Mike Rapoport <rppt@kernel.org>
X-Provags-ID: V03:K1:bG+54+abyrBEW8hKb6a+84xT9TijIiEjLPipeyI7axptWjMjXu1
 KKTQ2w7jzOUKVU1Wz6pJD6Gw9AMAbGmCoeRNDyUzh5WMHQ3ymNisdLZCWXCrw+741t1OvnG
 7rsZQ8ymqqMG6AGS3adZLxX6Pl/WTZQCR03hMaHEJTg2YVlKBsVOZNa0YZdrBFrqS7wwd45
 4QL522XTCbMVNspDTEGUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mRRTgqd1FkI=:tc8K/nqbxof4UVgloPkgZH
 YjFuq2dTGKCuUDrRyxhHIeIHCLw7vW8cjqgBp61wKigni2yRhWUopqV59jxc2KS9En61whIDT
 zGkytcXbrFgFtVD1i1MWyR8UaSNMayg0I5qrCXo0ekWdLOf2JMur7LVoWKh8JBgcnafPTyMQU
 8jB30BufmEwl1uv1+xKpRiCcFITX+rkFIM27HInJS4EKxgmzl1s97Zoiwt+ChXkBrzyhY5kpq
 LQA1JKqY10YkSzJWWmg4pWTcFT1lGTJn2gXDAlvHWZEmlOMW8xz6mervXz6YJzDOhltVoqTpF
 tTbB0QbNYfIuQAYv44vlT2QHnWPqYxRhwITkLSemRCuRBbj7ToeNLbktcVogYSMu7LdWANf31
 datFAw0tZFEln40lZVaOzgFV1TGVlQjcUsUKaWkBS2rix9fDgT9x0aKbvg/oxZEQ7TAvgwypM
 U7Bps8K6G+m3YkA3HCJ40xwItr9x5QIqRhPWzULhifJmjfRDI+yGI1ndnOntBCmKH3nuzEJxG
 NMv0RTjRHq2NU9YmcOt7erKpHGAGfdktWYhFX8NJAf0bFlS9ZXNFdwM0QvFxDP8V5bcOxV1uq
 LzLICei5sCv3Rr/mokvlLucbgbhdiMOLnbzhbpvHtmu3NxfT3SXCkfR+Hrv8bq3vjkIStOJz+
 KCa1W3mmgsjoruQxs2Cn5IInacCBJyyzsnYfQs3vugo+/0l041YH7qW7FXHRzPQZUtUntHUFE
 WNd97BE+TrqjPVQBfcErVk503wqbYmiHw1JDKPsvxRr01aHIZVxZJyEgU3A0Z89mvPczn4iJW
 LIXnXKwQwNNXDYxK1LGPfPZ8NbocQHTLz3EY/3W8YgqEeeMBSEdNQxaA7pAuWRoPMS3aZYPXa
 VQ/yMnnkgOgqvWOEJfh7d0RZ6Se4SkfdwOSywN+GTz+RFbX4SOu9qLcOJdgp44jGAp0P7zSF3
 4bMOqNSS3+0rM9s37c1EmybY/gYaAsD175J4Nd4UZ3B33BEDFPvYw
Message-ID-Hash: NZ5FYYB7NSJPOEDBIK5IYZKHGEJ2MM6H
X-Message-ID-Hash: NZ5FYYB7NSJPOEDBIK5IYZKHGEJ2MM6H
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux 
 FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org, linux-riscv <linux-riscv@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, linaro-mm-sig@lists.linaro.org, Sumit Semwal <sumit.semwal@linaro.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NZ5FYYB7NSJPOEDBIK5IYZKHGEJ2MM6H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 20, 2020 at 11:25 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Introduce "secretmemfd" system call with the ability to create memory areas
> visible only in the context of the owning process and not mapped not only
> to other processes but in the kernel page tables as well.
>
> The user will create a file descriptor using the secretmemfd system call
> where flags supplied as a parameter to this system call will define the
> desired protection mode for the memory associated with that file
> descriptor. Currently there are two protection modes:
>
> * exclusive - the memory area is unmapped from the kernel direct map and it
>               is present only in the page tables of the owning mm.
> * uncached  - the memory area is present only in the page tables of the
>               owning mm and it is mapped there as uncached.
>
> For instance, the following example will create an uncached mapping (error
> handling is omitted):
>
>         fd = secretmemfd(SECRETMEM_UNCACHED);
>         ftruncate(fd, MAP_SIZE);
>         ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
>                    fd, 0);
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

I wonder if this should be more closely related to dmabuf file
descriptors, which
are already used for a similar purpose: sharing access to secret memory areas
that are not visible to the OS but can be shared with hardware through device
drivers that can import a dmabuf file descriptor.

      Arnd
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
