Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC622F68E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 Jul 2020 19:25:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AFCC412409D80;
	Mon, 27 Jul 2020 10:25:45 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=212.227.126.134; helo=mout.kundenserver.de; envelope-from=arnd@arndb.de; receiver=<UNKNOWN> 
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 28210123D6104
	for <linux-nvdimm@lists.01.org>; Mon, 27 Jul 2020 10:25:41 -0700 (PDT)
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N8GIa-1kvZ5f2rTc-014D0V for <linux-nvdimm@lists.01.org>; Mon, 27 Jul 2020
 19:25:39 +0200
Received: by mail-qt1-f181.google.com with SMTP id t23so9689888qto.3
        for <linux-nvdimm@lists.01.org>; Mon, 27 Jul 2020 10:25:39 -0700 (PDT)
X-Gm-Message-State: AOAM532uptEjUMrh7Vmxp+8SL9BZG81LMkmnC16eNYfGzaCGDp0lD9/s
	uzyPuwYj6Marq0HzmP9FVM+3YEdWTezz/U7FDVY=
X-Google-Smtp-Source: ABdhPJyHnciMJIel1lwAD5bow/zb/QGlp3YciXK2/NVdtnimMUPJo7yU6pZ4mJlHkwU8BKDS8Pa279r2z6tHPp7qb+M=
X-Received: by 2002:a37:b484:: with SMTP id d126mr23840011qkf.394.1595870737385;
 Mon, 27 Jul 2020 10:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200727162935.31714-1-rppt@kernel.org> <20200727162935.31714-5-rppt@kernel.org>
In-Reply-To: <20200727162935.31714-5-rppt@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 27 Jul 2020 19:25:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Lbjdx_43-b0i1FXEfqaNPbaoXLraa2WikfPHrOZ6Kog@mail.gmail.com>
Message-ID: <CAK8P3a3Lbjdx_43-b0i1FXEfqaNPbaoXLraa2WikfPHrOZ6Kog@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] arch, mm: wire up memfd_secret system call were relevant
To: Mike Rapoport <rppt@kernel.org>
X-Provags-ID: V03:K1:7WTa5hrAS15g5Yq5FXHklLBFy+gpsaKhyLW/Md4C/PVaLjRxXRo
 lX6CU1EzkS968+CwpDajkdhczdgn+eLdOQ6+pCXQYqsb0xYaCH/I9nM7ceKsom3ibXiHqMl
 jlqsrRPLVae669oRxcE8h29tEFHzTR6DC5OLWFwKrbtjo5DJrBY5xZYTdJRLw0nLSmkfvRT
 eqxBTipML/5LxpBdtIq4A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jm4ehSyn+dQ=:nu7IDoZRRAhSZpXHObQ1kK
 FY6cXDt3aTxSLqnP3MXxBjNU5t4rK9U9WgHfyu4sPWij2x5LanC1/5kgznu0oYXxt8db2+vBU
 4Ry7srE77IHHrqdly/x2VyG3vMvK6dpNVJOt0aGqk/7f2NxPau9z26+aTMgNR1cQ0tJv1TeHb
 nEjqq9IW0ippaHfl26P7/BogrL7HeiCvq1ijp429Ilc90zxR08RY+I7GU78z16LyErR1xNBpq
 o1ZyzwQYQRnyAKxLhmYcpfDqBItUlczn1plvCcaRz35uBE09tdrjQaJtkcJVC4C21+ekROPEb
 hm2FYPVFiD86SttgcQ22KhBpeSkFCkspFnUrG/ejdC5B+2qk+TgbFG6alI+Mdt1dZPncXEmta
 hCRtXG/BjfnefTBOQCDh6X1wT4LRw/4mRUwzqZL315EJ+IvZTWqFEjdINn5loLmNwn8GcUgll
 qYy+D9M2g07qhlOiYczqz7tTbZ/mbJNPGIEc+ZbpEqnf3yNlqtIsSRv0FdaFf5ypmuQAA9xDv
 JMro1bFxDaI3Oyyc2XKQZ6Nttey0DZ+KB1JGdHNunxgQDxdbzepbroRx8b3f3Bm2zFuAvJ/b0
 dGCN8Of+oKx+de06gqimoZMtgbDSt3TrVl1hfW6j4c8Pox5b6GxLfKePKgzuMy444dSHuk29I
 CM8B79Yi1u/Cl5YlHinaaee9hUnZeS/XmcJajjcd7znlhYi3E3Pj+mmrZojsBGRMss56B3AjD
 ldVGI7dxi5O84MbYP8vcKNXmQl6t+i2UsqdT9cVBLU8SwmgbmqHvDFkCxbzfIxE8n75rYrFlh
 6sAggyxRnJdgwYpVUncqiS3LvFSs0lassn0ueistaqyVugaqT9DledB0+3N3uqSRIcQaNeqz1
 ex9hhE92MOTYPSlwS4rIKLfDMh1glZlb42P6ulhEmkdKKSGDo4zAd5cvofj+Fuzmkh4at0rp7
 nTotNZD/koceHssWG3BoocYKYXniOOHGZjow7w909gLPT5RlPwzWn
Message-ID-Hash: EYZVLANEBA2LTCN7RHNIPPJ3IVHEY64Q
X-Message-ID-Hash: EYZVLANEBA2LTCN7RHNIPPJ3IVHEY64Q
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <lin
 ux-arm-kernel@lists.infradead.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org, linux-riscv <linux-riscv@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EYZVLANEBA2LTCN7RHNIPPJ3IVHEY64Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 27, 2020 at 6:30 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Wire up memfd_secret system call on architectures that define
> ARCH_HAS_SET_DIRECT_MAP, namely arm64, risc-v and x86.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
