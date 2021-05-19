Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFFB388493
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 May 2021 03:50:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D4FFB100EB859;
	Tue, 18 May 2021 18:49:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 761AC100EF25B
	for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 18:49:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h16so13434724edr.6
        for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 18:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oy9iy31YW42GgULMnDfqqrgoX8PmHZpkik30uv+f1aA=;
        b=tvQ2E7Kd2+Hf+RN1JCJdnQu6RymaGP0zziznDt8ISnI+jG1I9F5rTtPCJWa6PikhKh
         XFhKmAAqHeMsUAOgy6hUDl59IPnHpchWu1cnHTyyjxMolBXIohuKR723SkE7OCNxzAbK
         oygZjSu1ZC0vRf3URWfxhzVNd3YMtTfsohBEjCi0q+/uREUxDQtHtMXYqH6q8d9eUBIB
         218/C9Rmj+pEf1HRmaUjm/IPbnYkBLCQnR3DkYGpm/9v4+VmsDb6lUfsBZ8rq8wjdtNW
         PEFTJvZlWna6c3qGn3K9JEbsQ5ZbIkKlwDebT3ZVImG1L8u/VdgWTl83Y5Z5wVd6ZNag
         17jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oy9iy31YW42GgULMnDfqqrgoX8PmHZpkik30uv+f1aA=;
        b=QWRsurxIUsECw+b1vbxCLnHWiEC8D1NLb1oDyEw6ygko1rHg+6nCdr0yBT2ARsBcFZ
         LjMy+5ZnzmxvCtYwmFnCZF4a5U6GF9Q++KbdN5gg1v3T6/oG9hv+QampmIpErivJx1Hp
         BkXnep0saQeEiDpg7DWY6uhZgk39wW/6SH1nIT/WZGLyNOHB/R8Jm3v0IjbUDC64LoA1
         ux35T/hGhwleP+bQYAeVuW/ObS6+sMnF4GjNJShjMRhqoJOBXXKguu2cWUJaBPMbCky+
         yLMTQWZC2qCstsHzYeOmgXOBFIEt0X5ah98rOB33f+Fi5T40KGJBniJfbGNgshRtMBVs
         FptQ==
X-Gm-Message-State: AOAM530t/sniRT1HQYfBjo2BnL+4c7vKq3a5VkZLQqUInhQuTb5DJkcr
	uyts36aIM+iiU3d6c3eljiwYxto6zLshzVP6AQacHA==
X-Google-Smtp-Source: ABdhPJzCebUO43WPo6zd3pAT6bxEi4LXjBLrk7zln8XX7z9KqzudweIVCjqD+YotU9S81wu4CFwPj9RiJ4aku6RH+xo=
X-Received: by 2002:a50:ff13:: with SMTP id a19mr10495865edu.300.1621388993652;
 Tue, 18 May 2021 18:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210513184734.29317-1-rppt@kernel.org> <20210513184734.29317-7-rppt@kernel.org>
 <20210518102424.GD82842@C02TD0UTHF1T.local> <d99864e677cec4ed83e52c4417c58bbe5fd728b1.camel@linux.ibm.com>
In-Reply-To: <d99864e677cec4ed83e52c4417c58bbe5fd728b1.camel@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 18 May 2021 18:49:42 -0700
Message-ID: <CAPcyv4hwZ2e-xzsySOjaJXDSXRKctsoGA5zW-enTn2Y9ezWPVw@mail.gmail.com>
Subject: Re: [PATCH v19 6/8] PM: hibernate: disable when there are active
 secretmem users
To: James Bottomley <jejb@linux.ibm.com>
Message-ID-Hash: PPTELKUQPWSN4F7ECP5OCM32NPWRNXKL
X-Message-ID-Hash: PPTELKUQPWSN4F7ECP5OCM32NPWRNXKL
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmerdabbelt@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafa
 el J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-riscv@lists.infradead.org, X86 ML <x86@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PPTELKUQPWSN4F7ECP5OCM32NPWRNXKL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 18, 2021 at 6:33 PM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Tue, 2021-05-18 at 11:24 +0100, Mark Rutland wrote:
> > On Thu, May 13, 2021 at 09:47:32PM +0300, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > >
> > > It is unsafe to allow saving of secretmem areas to the hibernation
> > > snapshot as they would be visible after the resume and this
> > > essentially will defeat the purpose of secret memory mappings.
> > >
> > > Prevent hibernation whenever there are active secret memory users.
> >
> > Have we thought about how this is going to work in practice, e.g. on
> > mobile systems? It seems to me that there are a variety of common
> > applications which might want to use this which people don't expect
> > to inhibit hibernate (e.g. authentication agents, web browsers).
>
> If mobile systems require hibernate, then the choice is to disable this
> functionality or implement a secure hibernation store.   I also thought
> most mobile hibernation was basically equivalent to S3, in which case
> there's no actual writing of ram into storage, in which case there's no
> security barrier and likely the inhibition needs to be made a bit more
> specific to the suspend to disk case?
>
> > Are we happy to say that any userspace application can incidentally
> > inhibit hibernate?
>
> Well, yes, for the laptop use case because we don't want suspend to
> disk to be able to compromise the secret area.  You can disable this
> for mobile if you like, or work out how to implement hibernate securely
> if you're really suspending to disk.

Forgive me if this was already asked and answered. Why not document
that secretmem is ephemeral in the case of hibernate and push the
problem to userspace to disable hibernation? In other words
hibernation causes applications to need to reload their secretmem, it
will be destroyed on the way down and SIGBUS afterwards. That at least
gives a system the flexibility to either sacrifice hibernate for
secretmem (with a userspace controlled policy), or sacrifice secretmem
using processes for hibernate.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
