Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522691F001D
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 20:53:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D52501009F03B;
	Fri,  5 Jun 2020 11:48:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3FAEF1009F039
	for <linux-nvdimm@lists.01.org>; Fri,  5 Jun 2020 11:47:58 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id mb16so11233713ejb.4
        for <linux-nvdimm@lists.01.org>; Fri, 05 Jun 2020 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wXRpz2lO6/EOGfJ7wZsfK0zV1iD673YONFZjRSp4YU=;
        b=iKWRTV0fZquwi8iYFrkllclkIkc7zyKFSFgwvw7q0Imsb4KMrLzP4VVUhGt1LuBa8T
         Vw++I+nmdtz98fAE9YJdNN5t+SVzWVZ8qDJO5jU8NN3ZKmONh8Qx4Iu77rQLTQ5uejMZ
         D0BFVTZYTCtAm3LEA2zTLSO9V57sDTGidb2VhiM2fRaH/37KPY7alcjVDyuS9G8qaPcU
         vlN2VuZl/iwFq+Q+8fq/Q57B9zZLoWbF/pW2slR7RMoxbdOy3DWBdPx/sQrX5DDjPo6Y
         phhV46CTXBvrevlVtRXv/trhbz9NqPDDyN4wspBdd6grTMSBSy4kOx1ngMJYHCFJAjJQ
         66Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wXRpz2lO6/EOGfJ7wZsfK0zV1iD673YONFZjRSp4YU=;
        b=qI8HGh0jd77gAdUTpbaAA3nGlaaHINspoaFX+Gh66Ggp6ypr5+LGAUPaVzyQGaFynP
         dUcSV7d1gMBb9XRdBmZU9IttrSaG72/UOnJkJpejBoZVZUnmAwa538Dx6K0xUx7BMaUE
         +bKNbdHB3qYCVCLkCme6Kzn74XnQI5LvGV+DwRpImY09USyys9AZP6OrpHI9tAiK1QOZ
         7X4+svMzz+PLSbgPUKiuBG3t6aoF01ziu2OjQ0YI+nz8pLwveM3I5quopm54OCDxFKA9
         6wJOJpbYBPC5hWwWWpbE+Xop3IKCcBuEJm31n3efxk8ifcV5NVuQrMBOfLGMcjpmqDt6
         q57Q==
X-Gm-Message-State: AOAM531WSHBSTNFR8qXKGATFORnLFTgAhdjHRzp3JMH+BW67gkqEjjMP
	OfXFMyn4/PUvB21w0ljVQfpv0Afqvl+zXsR8u5L0pw==
X-Google-Smtp-Source: ABdhPJxs7csibmk0TeBntMIz0H3+ay+u3BDdAOdGFjfKRP1Y9+NBaeTwCa5nIEk5ZkPdDkGUIIzHH5GRRsX6FrAoLps=
X-Received: by 2002:a17:906:468e:: with SMTP id a14mr2823668ejr.124.1591383188826;
 Fri, 05 Jun 2020 11:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <159062136234.2192412.7285856919306307817.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159062136234.2192412.7285856919306307817.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 5 Jun 2020 11:52:57 -0700
Message-ID: <CAPcyv4j6QNheK-mmgZ9dTAY_yaX5hU8_wJCpmshJgCxbt8eyOg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Renovate memcpy_mcsafe with copy_mc_to_{user, kernel}
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Message-ID-Hash: GOEKWZGNRLMCKVUINH3ACXQI3DZEZG2Q
X-Message-ID-Hash: GOEKWZGNRLMCKVUINH3ACXQI3DZEZG2Q
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Mikulas Patocka <mpatocka@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GOEKWZGNRLMCKVUINH3ACXQI3DZEZG2Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, May 27, 2020 at 4:32 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Changes since v4 [1]:
> - Fix up .gitignore for PowerPC test artifacts (Michael)
>
> - Collect Michael's Ack.
>
> [1]: http://lore.kernel.org/r/159010126119.975921.6614194205409771984.stgit@dwillia2-desk3.amr.corp.intel.com
>
> ---
>
> The primary motivation to go touch memcpy_mcsafe() is that the existing
> benefit of doing slow "handle with care" copies is obviated on newer
> CPUs. With that concern lifted it also obviates the need to continue to
> update the MCA-recovery capability detection code currently gated by
> "mcsafe_key". Now the old "mcsafe_key" opt-in to perform the copy with
> concerns for recovery fragility can instead be made an opt-out from the
> default fast copy implementation (enable_copy_mc_fragile()).
>
> The discussion with Linus on the first iteration of this patch
> identified that memcpy_mcsafe() was misnamed relative to its usage. The
> new names copy_mc_to_user() and copy_mc_to_kernel() clearly indicate the
> intended use case and lets the architecture organize the implementation
> accordingly.
>
> For both powerpc and x86 a copy_mc_generic() implementation is added as
> the backend for these interfaces.
>
> Patches are relative to tip/master.

I have not heard any additional feedback, or seen tip-bot traffic. Is
this still under consideration for v5.8? The kernel's behavior on new
platforms regresses without this, recoverable #MC escalates to panic.


>
> ---
>
> Dan Williams (2):
>       x86, powerpc: Rename memcpy_mcsafe() to copy_mc_to_{user,kernel}()
>       x86/copy_mc: Introduce copy_mc_generic()
>
>
>  arch/powerpc/Kconfig                               |    2
>  arch/powerpc/include/asm/string.h                  |    2
>  arch/powerpc/include/asm/uaccess.h                 |   40 +++--
>  arch/powerpc/lib/Makefile                          |    2
>  arch/powerpc/lib/copy_mc_64.S                      |    4
>  arch/x86/Kconfig                                   |    2
>  arch/x86/Kconfig.debug                             |    2
>  arch/x86/include/asm/copy_mc_test.h                |   75 +++++++++
>  arch/x86/include/asm/mcsafe_test.h                 |   75 ---------
>  arch/x86/include/asm/string_64.h                   |   32 ----
>  arch/x86/include/asm/uaccess.h                     |   21 +++
>  arch/x86/include/asm/uaccess_64.h                  |   20 --
>  arch/x86/kernel/cpu/mce/core.c                     |    8 -
>  arch/x86/kernel/quirks.c                           |    9 -
>  arch/x86/lib/Makefile                              |    1
>  arch/x86/lib/copy_mc.c                             |   64 ++++++++
>  arch/x86/lib/copy_mc_64.S                          |  165 ++++++++++++++++++++
>  arch/x86/lib/memcpy_64.S                           |  115 --------------
>  arch/x86/lib/usercopy_64.c                         |   21 ---
>  drivers/md/dm-writecache.c                         |   15 +-
>  drivers/nvdimm/claim.c                             |    2
>  drivers/nvdimm/pmem.c                              |    6 -
>  include/linux/string.h                             |    9 -
>  include/linux/uaccess.h                            |    9 +
>  include/linux/uio.h                                |   10 +
>  lib/Kconfig                                        |    7 +
>  lib/iov_iter.c                                     |   43 +++--
>  tools/arch/x86/include/asm/mcsafe_test.h           |   13 --
>  tools/arch/x86/lib/memcpy_64.S                     |  115 --------------
>  tools/objtool/check.c                              |    5 -
>  tools/perf/bench/Build                             |    1
>  tools/perf/bench/mem-memcpy-x86-64-lib.c           |   24 ---
>  tools/testing/nvdimm/test/nfit.c                   |   48 +++---
>  .../testing/selftests/powerpc/copyloops/.gitignore |    2
>  tools/testing/selftests/powerpc/copyloops/Makefile |    6 -
>  .../selftests/powerpc/copyloops/copy_mc_64.S       |    1
>  .../selftests/powerpc/copyloops/memcpy_mcsafe_64.S |    1
>  37 files changed, 451 insertions(+), 526 deletions(-)
>  rename arch/powerpc/lib/{memcpy_mcsafe_64.S => copy_mc_64.S} (98%)
>  create mode 100644 arch/x86/include/asm/copy_mc_test.h
>  delete mode 100644 arch/x86/include/asm/mcsafe_test.h
>  create mode 100644 arch/x86/lib/copy_mc.c
>  create mode 100644 arch/x86/lib/copy_mc_64.S
>  delete mode 100644 tools/arch/x86/include/asm/mcsafe_test.h
>  delete mode 100644 tools/perf/bench/mem-memcpy-x86-64-lib.c
>  create mode 120000 tools/testing/selftests/powerpc/copyloops/copy_mc_64.S
>  delete mode 120000 tools/testing/selftests/powerpc/copyloops/memcpy_mcsafe_64.S
>
> base-commit: 229aaa8c059f2c908e0561453509f996f2b2d5c4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
