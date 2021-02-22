Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E48321FE6
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 20:17:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 72BED100EB848;
	Mon, 22 Feb 2021 11:17:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6F0A7100EB845
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 11:17:53 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id lu16so31054516ejb.9
        for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 11:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mL0bjhfITdu5839ghM56EtmuJ0mV3o1IEyaUJSuFMFs=;
        b=0VKXgI+d4N8/TsZjQE/E5fkYxDFeC7KFxegFQ1tUDUQWXj1P6cXOsiH5slGqxqrmbb
         dBx4HcRD8Hzu5KRTHX5N1ybYz5yC5e7kYtwfTlsuU2esXKkYljaX8VDDRS1DaE/uHUin
         QAGppPvDyByXQFp+iE9GKGPwF3A2dB1mFytnHdtGJw+XJLGP5r33xK45enAbysyTaEHa
         57tTo6DZyOE+uYzDNdPTZAL71cYVMSUiSI5K7sek4p2eMAFj1YmFFfuyLNvbSLKSE5kW
         D+y3PQVbEo19hoNoanDSrLywkZqhcPGuG5KVCRRj/oMJKHnyCwkRLTAD6EZO4JnoconN
         aV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mL0bjhfITdu5839ghM56EtmuJ0mV3o1IEyaUJSuFMFs=;
        b=JWVYop/xP6S8lo5b2e3dqYyelL4K8v/wTo/wyzWgpBk4bletJCGgUPuY2VmIiHO5cP
         GWioDkFDyhU4WoAZuR/ac/GcQaKH9yVSLLKFe5j2whHZUfDCj/Vqo8VsgrJyMgAl6dmY
         RAA6KZnlUrDtLAYCi2iGKXAkAaWeeQ6FhL32eaF8Sd8DsHbVciZyeHfnWQv/7nolCKHr
         8S5TK0qoV9JHNmT9P92MNRb4t9NQht5tb46us7SnmkP3Hs2jDpK5BVgZcNC4IaetJxZL
         n6kj2iaXILqyQ6m3lUslLO/4qPuvcTOSTngseHHMSaC/nCre9W7mKcgGh4EyYKugxMms
         kpdw==
X-Gm-Message-State: AOAM533lE1wVv0AhsKsd7sJ4/v6X9uem7u4F+XFdRIr5H9MtKnW623i9
	6i6vhHgJH9ls16Q5akL4AmZ+iH6JIWBPJUkFr6Q5zw==
X-Google-Smtp-Source: ABdhPJwkiWshDLTsz8a3A7EzLjYNcKqX6Z1F01E3QE0NjkocZdW4txgaDcjEXqIRRI2IV4obwnL12Zk+rIG7YnuhZ4g=
X-Received: by 2002:a17:906:8692:: with SMTP id g18mr22575502ejx.418.1614021471495;
 Mon, 22 Feb 2021 11:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20210208084920.2884-1-rppt@kernel.org> <20210208084920.2884-9-rppt@kernel.org>
 <20210222073452.GA30403@codon.org.uk> <20210222102359.GE1447004@kernel.org>
In-Reply-To: <20210222102359.GE1447004@kernel.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 22 Feb 2021 11:17:46 -0800
Message-ID: <CAPcyv4hCXZFmeMkKxN54Yw3ZbvoYQ3Z9y9Ayv42i6u+24Bkmqg@mail.gmail.com>
Subject: Re: [PATCH v17 08/10] PM: hibernate: disable when there are active
 secretmem users
To: Mike Rapoport <rppt@kernel.org>
Message-ID-Hash: HC5U36C46OP6GWGA3256GJGGPN5DZ3JZ
X-Message-ID-Hash: HC5U36C46OP6GWGA3256GJGGPN5DZ3JZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Matthew Garrett <mjg59@srcf.ucam.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shua
 h Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-riscv@lists.infradead.org, X86 ML <x86@kernel.org>, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HC5U36C46OP6GWGA3256GJGGPN5DZ3JZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 22, 2021 at 2:24 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Feb 22, 2021 at 07:34:52AM +0000, Matthew Garrett wrote:
> > On Mon, Feb 08, 2021 at 10:49:18AM +0200, Mike Rapoport wrote:
> >
> > > It is unsafe to allow saving of secretmem areas to the hibernation
> > > snapshot as they would be visible after the resume and this essentially
> > > will defeat the purpose of secret memory mappings.
> >
> > Sorry for being a bit late to this - from the point of view of running
> > processes (and even the kernel once resume is complete), hibernation is
> > effectively equivalent to suspend to RAM. Why do they need to be handled
> > differently here?
>
> Hibernation leaves a copy of the data on the disk which we want to prevent.

Why not document that users should use data at rest protection
mechanisms for their hibernation device? Just because secretmem can't
assert its disclosure guarantee does not mean the hibernation device
is untrustworthy.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
