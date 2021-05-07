Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B9376D85
	for <lists+linux-nvdimm@lfdr.de>; Sat,  8 May 2021 01:58:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 71DFF100EAAE8;
	Fri,  7 May 2021 16:58:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=keescook@chromium.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 76815100EAAE5
	for <linux-nvdimm@lists.01.org>; Fri,  7 May 2021 16:57:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 69so1450627plc.5
        for <linux-nvdimm@lists.01.org>; Fri, 07 May 2021 16:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2iQQvEB0+fCpb/rAB5HWawShZb8qZlIcaFuxaSL0oes=;
        b=EqhSZy45d2y8OQQwraWGhlD9n54vClwPwSn7UuK9xZviJIBJseEIUX0aF36GebrTNP
         3Y9esEq2VEVMdpYAd+09juu7yIqSSNYhNNt+rVs1po+n6QlJ3kc6cbxhUV5wUfFprLGx
         TjvIY1CeOIbcMr4b7WQIEnR9bfI+n///RODlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2iQQvEB0+fCpb/rAB5HWawShZb8qZlIcaFuxaSL0oes=;
        b=Oz3Cv97X0F4/0rSvxQoKc7WpxbfEAWbAT3Y4Hdnz/H+mP2irEzIJrQqEe0yQGsD9b5
         elRjyBF1y7TyEavBFD4xxqP7+6hdUaErw0cj33KVO1NQHMl3LcyghKYm5ILEcqGD0tQZ
         DkpvTIFtXUjg/smcPrjGJDokJOtJ9dEFXvNai7iojvUN4FnCbRxmg4caEEBLGzrdKeS2
         NcXhb8UXAbVwlPNY3jZ1GiaUd3sVis+yoHe4arzBNg8+Y1xgqIV4m4QaQL66tgy7X4fC
         qNW7AKlVA4ar7iNyNfikk3Kt5cHahN8TorbCesccmHIy4HFmrW4Y/nU5cnXDBdKR4UiM
         iC9w==
X-Gm-Message-State: AOAM531IQ11ZJNXYCNMPAZODhIxw5kLZTxQJ9Jg33gJKLtBW8iRcK6ij
	DXb0ViOoxVtb6WhbVlv0uG6zgg==
X-Google-Smtp-Source: ABdhPJwW5et97Z//abVIXmo2gBu5V8/Vzg230KpxBawys34RoMW6n/H4x7d7dTWApKrw1+7V8ZstIg==
X-Received: by 2002:a17:902:ff09:b029:ed:3b29:ff43 with SMTP id f9-20020a170902ff09b02900ed3b29ff43mr12583115plj.14.1620431878548;
        Fri, 07 May 2021 16:57:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ha14sm5011198pjb.40.2021.05.07.16.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 16:57:56 -0700 (PDT)
Date: Fri, 7 May 2021 16:57:55 -0700
From: Kees Cook <keescook@chromium.org>
To: James Bottomley <jejb@linux.ibm.com>
Subject: Re: [PATCH v18 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <202105071620.E834B1FA92@keescook>
References: <20210303162209.8609-1-rppt@kernel.org>
 <20210505120806.abfd4ee657ccabf2f221a0eb@linux-foundation.org>
 <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
 <202105060916.ECDEC21@keescook>
 <9e1953a1412fad06a9f7988a280d2d9a74ab0464.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9e1953a1412fad06a9f7988a280d2d9a74ab0464.camel@linux.ibm.com>
Message-ID-Hash: X6QUDYLYV34JL4CXV36NXYDDCAFWBGT5
X-Message-ID-Hash: X6QUDYLYV34JL4CXV36NXYDDCAFWBGT5
X-MailFrom: keescook@chromium.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shak
 eel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X6QUDYLYV34JL4CXV36NXYDDCAFWBGT5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 06, 2021 at 11:47:47AM -0700, James Bottomley wrote:
> On Thu, 2021-05-06 at 10:33 -0700, Kees Cook wrote:
> > On Thu, May 06, 2021 at 08:26:41AM -0700, James Bottomley wrote:
> [...]
> > > > I think that a very complete description of the threats which
> > > > this feature addresses would be helpful.  
> > > 
> > > It's designed to protect against three different threats:
> > > 
> > >    1. Detection of user secret memory mismanagement
> > 
> > I would say "cross-process secret userspace memory exposures" (via a
> > number of common interfaces by blocking it at the GUP level).
> > 
> > >    2. significant protection against privilege escalation
> > 
> > I don't see how this series protects against privilege escalation.
> > (It protects against exfiltration.) Maybe you mean include this in
> > the first bullet point (i.e. "cross-process secret userspace memory
> > exposures, even in the face of privileged processes")?
> 
> It doesn't prevent privilege escalation from happening in the first
> place, but once the escalation has happened it protects against
> exfiltration by the newly minted root attacker.

So, after thinking a bit more about this, I don't think there is
protection here against privileged execution. This feature kind of helps
against cross-process read/write attempts, but it doesn't help with
sufficiently privileged (i.e. ptraced) execution, since we can just ask
the process itself to do the reading:

$ gdb ./memfd_secret
...
ready: 0x7ffff7ffb000
Breakpoint 1, ...
(gdb) compile code unsigned long addr = 0x7ffff7ffb000UL; printf("%016lx\n", *((unsigned long *)addr));
55555555555555555

And since process_vm_readv() requires PTRACE_ATTACH, there's very little
difference in effort between process_vm_readv() and the above.

So, what other paths through GUP exist that aren't covered by
PTRACE_ATTACH? And if none, then should this actually just be done by
setting the process undumpable? (This is already what things like gnupg
do.)

So, the user-space side of this doesn't seem to really help. The kernel
side protection is interesting for kernel read/write flaws, though, in
the sense that the process is likely not being attacked from "current",
so a kernel-side attack would need to either walk the page tables and
create new ones, or spawn a new userspace process to do the ptracing.

So, while I like the idea of this stuff, and I see how it provides
certain coverages, I'm curious to learn more about the threat model to
make sure it's actually providing meaningful hurdles to attacks.

-- 
Kees Cook
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
