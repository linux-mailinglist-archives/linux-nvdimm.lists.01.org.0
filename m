Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A53A77CF
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Sep 2019 02:18:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4C44F21A070B6;
	Tue,  3 Sep 2019 17:19:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 461EB21A07094
 for <linux-nvdimm@lists.01.org>; Tue,  3 Sep 2019 17:19:48 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 90so14930773otg.10
 for <linux-nvdimm@lists.01.org>; Tue, 03 Sep 2019 17:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d9/JJ3504uaFpnndap0ZdEi3nmofy/wlLvrQnd0615M=;
 b=rcM4gz1Cb6K4hT6CTsEccpNH/E9IrxqknY8JEySfBny9P6+5mUPlk3SH3j8CUy+xSi
 8Ri4JmCW6FylN7YQ2wBsrdcPY+s8UdGySx7Ip802gnTuUPlPFUVHp2e5t348lAPd//do
 IZKo+NzVMrIpsYaGlDVonTFCezMeAaM4vICxcw41mAZqUN6fOVKvz6F9UCxkb21+87FX
 tXtgTc/6RWn52UwVcATCGZTEVypV/sr/E3IHVVtfoz6kmGkagV4jh5B4cro+iaF9/OG6
 6c/5czvdSEkTeZWPFFxUtk9vSJFvmwMyYGop7oe3L/kb1x3scnrujk1WIFvMBFsRGAyo
 xDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d9/JJ3504uaFpnndap0ZdEi3nmofy/wlLvrQnd0615M=;
 b=ZWzrD0WU7JhlENxxLsDRpPb+5ITem7LarJ95zZSsitl9BakjKV33F7Xzna/cdgOu0G
 1Z9I0DzJazPMKvz0U7ju3ioGFZVvLUJrHHmQDOSplWQpGi2gbKC1oezEHNLxUfjoeATc
 zfFHppaBQ082jLGsQzpz2C2VF2pPQMs5/uo6Q15+cgnii8xHMiXUR9LNjLA0FzDwlmCo
 uFBAy25/w5f3ruEhmGWy8I41K/KZczTaJGVq62eoUzOmbhPWjS+3qHDESLkKr99aZ7RO
 U+2MEBxQYqc/iwqwwuG8V8BmaLHdbsWTrsspPYnAQHs1OPVfeK7Agqn37QnEseSqTFA1
 UsfA==
X-Gm-Message-State: APjAAAU5YNT3MNzrwDwHEai7txUawn1+7TIY+MoN2T6QyB8795uSAXwz
 t3mf3p273RkTWTBRjv45dwQj/T+2zV10nrr07nDEPA==
X-Google-Smtp-Source: APXvYqxWSsECod6pK4c5mYqYjfGfK0Ah/tNecXXpvEwdfOhleNK3Vmi25BdZu2A3aMmpx9OOqigsInlbgslW5ZLO+vk=
X-Received: by 2002:a9d:2642:: with SMTP id a60mr5366376otb.247.1567556316168; 
 Tue, 03 Sep 2019 17:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190819133451.19737-1-aneesh.kumar@linux.ibm.com>
 <20190819133451.19737-8-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190819133451.19737-8-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 3 Sep 2019 17:18:25 -0700
Message-ID: <CAPcyv4gzb73mUCz7yJV8cxArVydBFHAHJqJ3jV2JRhVNFyvyWA@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] libnvdimm/dax: Pick the right alignment default
 when creating dax devices
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Aneesh,

Patches 1 through 6 look ok, but I feel compelled to point out that
the patches deploy a different indentation style than the surrounding
code. I rely on the vim "=" operator to indent 2 tabs when for
multi-line if statements, i.e. this:

        if (!nd_supported_alignment(align) &&
                        !memcmp(pfn_sb->signature, DAX_SIG, PFN_SIG_LEN)) {
                dev_err(&nd_pfn->dev, "init failed, alignment mismatch: "
                                "%ld:%ld\n", nd_pfn->align, align);
                return -EOPNOTSUPP;
        }

...instead of this:

        if (!nd_supported_alignment(align) &&
            !memcmp(pfn_sb->signature, DAX_SIG, PFN_SIG_LEN)) {
                dev_err(&nd_pfn->dev, "init failed, alignment mismatch: "
                        "%ld:%ld\n", nd_pfn->align, align);
                return -EOPNOTSUPP;
        }

Could you reflow / resend for v7 after addressing the below comments?
To be clear I don't mind the lined up style, but mixed style within
the same file is distracting.

On Mon, Aug 19, 2019 at 6:35 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Allow arch to provide the supported alignments and use hugepage alignment only
> if we support hugepage. Right now we depend on compile time configs whereas this
> patch switch this to runtime discovery.
>
> Architectures like ppc64 can have THP enabled in code, but then can have
> hugepage size disabled by the hypervisor. This allows us to create dax devices
> with PAGE_SIZE alignment in this case.
>
> Existing dax namespace with alignment larger than PAGE_SIZE will fail to
> initialize in this specific case. We still allow fsdax namespace initialization.
>
> With respect to identifying whether to enable hugepage fault for a dax device,
> if THP is enabled during compile, we default to taking hugepage fault and in dax
> fault handler if we find the fault size > alignment we retry with PAGE_SIZE
> fault size.
>
> This also addresses the below failure scenario on ppc64
>
> ndctl create-namespace --mode=devdax  | grep align
>  "align":16777216,
>  "align":16777216
>
> cat /sys/devices/ndbus0/region0/dax0.0/supported_alignments
>  65536 16777216
>
> daxio.static-debug  -z -o /dev/dax0.0
>   Bus error (core dumped)
>
>   $ dmesg | tail
>    lpar: Failed hash pte insert with error -4
>    hash-mmu: mm: Hashing failure ! EA=0x7fff17000000 access=0x8000000000000006 current=daxio
>    hash-mmu:     trap=0x300 vsid=0x22cb7a3 ssize=1 base psize=2 psize 10 pte=0xc000000501002b86
>    daxio[3860]: bus error (7) at 7fff17000000 nip 7fff973c007c lr 7fff973bff34 code 2 in libpmem.so.1.0.0[7fff973b0000+20000]
>    daxio[3860]: code: 792945e4 7d494b78 e95f0098 7d494b78 f93f00a0 4800012c e93f0088 f93f0120
>    daxio[3860]: code: e93f00a0 f93f0128 e93f0120 e95f0128 <f9490000> e93f0088 39290008 f93f0110
>
> The failure was due to guest kernel using wrong page size.
>
> The namespaces created with 16M alignment will appear as below on a config with
> 16M page size disabled.
>
> $ ndctl list -Ni
> [
>   {
>     "dev":"namespace0.1",
>     "mode":"fsdax",
>     "map":"dev",
>     "size":5351931904,
>     "uuid":"fc6e9667-461a-4718-82b4-69b24570bddb",
>     "align":16777216,
>     "blockdev":"pmem0.1",
>     "supported_alignments":[
>       65536
>     ]
>   },
>   {
>     "dev":"namespace0.0",
>     "mode":"fsdax",    <==== devdax 16M alignment marked disabled.

Why is fsdax disabled? It's fine for the fsdax case to fall back to
smaller faults. Or, this running into the case where the stored page
size is larger than the currently running PAGE_SIZE?

>     "map":"mem",
>     "size":5368709120,
>     "uuid":"a4bdf81a-f2ee-4bc6-91db-7b87eddd0484",
>     "state":"disabled"
>   }
> ]
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/libnvdimm.h |  9 ++++++++
>  arch/powerpc/mm/Makefile             |  1 +
>  arch/powerpc/mm/nvdimm.c             | 34 ++++++++++++++++++++++++++++
>  arch/x86/include/asm/libnvdimm.h     | 19 ++++++++++++++++
>  drivers/nvdimm/nd.h                  |  6 -----
>  drivers/nvdimm/pfn_devs.c            | 32 +++++++++++++++++++++++++-
>  include/linux/huge_mm.h              |  7 +++++-
>  7 files changed, 100 insertions(+), 8 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/libnvdimm.h
>  create mode 100644 arch/powerpc/mm/nvdimm.c
>  create mode 100644 arch/x86/include/asm/libnvdimm.h
>
> diff --git a/arch/powerpc/include/asm/libnvdimm.h b/arch/powerpc/include/asm/libnvdimm.h
> new file mode 100644
> index 000000000000..d35fd7f48603
> --- /dev/null
> +++ b/arch/powerpc/include/asm/libnvdimm.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_LIBNVDIMM_H
> +#define _ASM_POWERPC_LIBNVDIMM_H
> +
> +#define nd_pfn_supported_alignments nd_pfn_supported_alignments
> +extern unsigned long *nd_pfn_supported_alignments(void);
> +extern unsigned long nd_pfn_default_alignment(void);
> +
> +#endif
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index 0f499db315d6..42e4a399ba5d 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -20,3 +20,4 @@ obj-$(CONFIG_HIGHMEM)         += highmem.o
>  obj-$(CONFIG_PPC_COPRO_BASE)   += copro_fault.o
>  obj-$(CONFIG_PPC_PTDUMP)       += ptdump/
>  obj-$(CONFIG_KASAN)            += kasan/
> +obj-$(CONFIG_NVDIMM_PFN)               += nvdimm.o
> diff --git a/arch/powerpc/mm/nvdimm.c b/arch/powerpc/mm/nvdimm.c
> new file mode 100644
> index 000000000000..a29a4510715e
> --- /dev/null
> +++ b/arch/powerpc/mm/nvdimm.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <asm/pgtable.h>
> +#include <asm/page.h>
> +
> +#include <linux/mm.h>
> +/*
> + * We support only pte and pmd mappings for now.
> + */
> +const unsigned long *nd_pfn_supported_alignments(void)
> +{
> +       static unsigned long supported_alignments[3];
> +
> +       supported_alignments[0] = PAGE_SIZE;
> +
> +       if (has_transparent_hugepage())
> +               supported_alignments[1] = HPAGE_PMD_SIZE;
> +       else
> +               supported_alignments[1] = 0;
> +
> +       supported_alignments[2] = 0;
> +       return supported_alignments;
> +}

I'd prefer to not create a powerpc specific object file especially
because nothing in the above looks powerpc specific. Anything that
prevents just making this the common implementation?

> +
> +/*
> + * Use pmd mapping if supported as default alignment
> + */
> +unsigned long nd_pfn_default_alignment(void)
> +{
> +
> +       if (has_transparent_hugepage())
> +               return HPAGE_PMD_SIZE;
> +       return PAGE_SIZE;
> +}
> diff --git a/arch/x86/include/asm/libnvdimm.h b/arch/x86/include/asm/libnvdimm.h
> new file mode 100644
> index 000000000000..3d5361db9164
> --- /dev/null
> +++ b/arch/x86/include/asm/libnvdimm.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_LIBNVDIMM_H
> +#define _ASM_X86_LIBNVDIMM_H
> +
> +static inline unsigned long nd_pfn_default_alignment(void)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       return HPAGE_PMD_SIZE;
> +#else
> +       return PAGE_SIZE;
> +#endif
> +}
> +
> +static inline unsigned long nd_altmap_align_size(unsigned long nd_align)
> +{
> +       return PMD_SIZE;
> +}
> +
> +#endif
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index e89af4b2d8e9..401a78b02116 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -289,12 +289,6 @@ static inline struct device *nd_btt_create(struct nd_region *nd_region)
>  struct nd_pfn *to_nd_pfn(struct device *dev);
>  #if IS_ENABLED(CONFIG_NVDIMM_PFN)
>
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -#define PFN_DEFAULT_ALIGNMENT HPAGE_PMD_SIZE
> -#else
> -#define PFN_DEFAULT_ALIGNMENT PAGE_SIZE
> -#endif
> -
>  int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns);
>  bool is_nd_pfn(struct device *dev);
>  struct device *nd_pfn_create(struct nd_region *nd_region);
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 22db77ac3d0e..7dc0b5da4c6b 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -10,6 +10,7 @@
>  #include <linux/slab.h>
>  #include <linux/fs.h>
>  #include <linux/mm.h>
> +#include <asm/libnvdimm.h>
>  #include "nd-core.h"
>  #include "pfn.h"
>  #include "nd.h"
> @@ -103,6 +104,8 @@ static ssize_t align_show(struct device *dev,
>         return sprintf(buf, "%ld\n", nd_pfn->align);
>  }
>
> +#ifndef nd_pfn_supported_alignments
> +#define nd_pfn_supported_alignments nd_pfn_supported_alignments
>  static const unsigned long *nd_pfn_supported_alignments(void)
>  {
>         /*
> @@ -125,6 +128,7 @@ static const unsigned long *nd_pfn_supported_alignments(void)
>
>         return data;
>  }
> +#endif
>
>  static ssize_t align_store(struct device *dev,
>                 struct device_attribute *attr, const char *buf, size_t len)
> @@ -302,7 +306,7 @@ struct device *nd_pfn_devinit(struct nd_pfn *nd_pfn,
>                 return NULL;
>
>         nd_pfn->mode = PFN_MODE_NONE;
> -       nd_pfn->align = PFN_DEFAULT_ALIGNMENT;
> +       nd_pfn->align = nd_pfn_default_alignment();
>         dev = &nd_pfn->dev;
>         device_initialize(&nd_pfn->dev);
>         if (ndns && !__nd_attach_ndns(&nd_pfn->dev, ndns, &nd_pfn->ndns)) {
> @@ -412,6 +416,20 @@ static int nd_pfn_clear_memmap_errors(struct nd_pfn *nd_pfn)
>         return 0;
>  }
>
> +static bool nd_supported_alignment(unsigned long align)
> +{
> +       int i;
> +       const unsigned long *supported = nd_pfn_supported_alignments();
> +
> +       if (align == 0)
> +               return false;
> +
> +       for (i = 0; supported[i]; i++)
> +               if (align == supported[i])
> +                       return true;
> +       return false;
> +}
> +
>  /**
>   * nd_pfn_validate - read and validate info-block
>   * @nd_pfn: fsdax namespace runtime state / properties
> @@ -496,6 +514,18 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
>                 return -EOPNOTSUPP;
>         }
>
> +       /*
> +        * Check whether the we support the alignment. For Dax if the
> +        * superblock alignment is not matching, we won't initialize
> +        * the device.
> +        */
> +       if (!nd_supported_alignment(align) &&
> +           !memcmp(pfn_sb->signature, DAX_SIG, PFN_SIG_LEN)) {

^^^ more indentation reflow.

> +               dev_err(&nd_pfn->dev, "init failed, alignment mismatch: "
> +                       "%ld:%ld\n", nd_pfn->align, align);
> +               return -EOPNOTSUPP;
> +       }
> +
>         if (!nd_pfn->uuid) {
>                 /*
>                  * When probing a namepace via nd_pfn_probe() the uuid
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 45ede62aa85b..4fa91f9bd0da 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -108,7 +108,12 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>
>         if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
>                 return true;
> -
> +       /*
> +        * For dax let's try to do hugepage fault always. If we don't support
> +        * hugepages we will not have enabled namespaces with hugepage alignment.
> +        * This also means we try to handle hugepage fault on device with
> +        * smaller alignment. But for then we will return with VM_FAULT_FALLBACK
> +        */

Please fix this comment up to not use the word "we". This should also
get an ack from linux-mm folks. "We" in the above alternately means
"we: the runtime/compile-tims platform setting", or "we: the kernel
implementation".
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
