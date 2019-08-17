Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D0C90C9C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 17 Aug 2019 05:57:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A4D0B202E8431;
	Fri, 16 Aug 2019 20:59:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 20966202B75FA
 for <linux-nvdimm@lists.01.org>; Fri, 16 Aug 2019 20:59:41 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id q20so10647274otl.0
 for <linux-nvdimm@lists.01.org>; Fri, 16 Aug 2019 20:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5JkAhLV4VoRnu2crZGL/J2yHThD4/hsSp7D/mpQ+b1s=;
 b=PLgTwvnO1F/glwSZqKSngpyzUq0vFd7nv9qzk0tkt39wZ4ihb11tnzHU/LqfTd0yVJ
 axw13Ep9GpgY89HHCRMt5qUEKZjV9fpXHekdl9moJRSsSmy+onoBfwnsmjsxfxgdFpuF
 UY5cJrgDOiWiNiT1c8BfhSIr6K4z3xB0kAEVeYHl0c6rrXqpT4vxHNa+wRXkaONde3aK
 cq2b6g1enF0XB8LwfJxyibCWbp16a+UJXk+Gury67BoYPTB3sy04w+RGXID/OjvfkmYd
 JEcGSzTjVP1+Q5GvY+6ZYPwGiUpU8/wluREQDwHDBdiY/jgkdG85+6s3b2IvImiQK0uj
 u4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5JkAhLV4VoRnu2crZGL/J2yHThD4/hsSp7D/mpQ+b1s=;
 b=BQOHFuHaoHOVFAm73ppoIBoXkv5Vh5MW/arya/HKLFE/mcSCrcAPIfCWurRUi6FOYd
 ZZvTQjFK16s+RZS/Xvj6flwH//1svRUg4n8DKLPk4s/MUNCzLuP6szcjeYvTUkjSNFIk
 O71SSGhmtfjY7d/KWjZuMuxK39JKjYP57/ZDXBTRwbBq2kTua8NWKVCawpLduqSlZHHy
 0D4mo0nqJbEjkRB9uUYyTUTO6oLs0KBXd/qOvNhzwDSFmZ7mR/dVlSKaqwtyB46xW3Rk
 C4zoHeR64TmTWoD5gfjEd5T0upkEB9ULfsUAXAaGX1jpXkRVMh+IqnecrVTrpUPpTeBF
 HScg==
X-Gm-Message-State: APjAAAVmmis3QtJVlr3E8+GUjrRw07yuOcY/zLt5eumKOSYKvvu279d0
 QiG2geoNi4+8q5VqkzpJ5r7CqlduISe1q63h8hf7TQ==
X-Google-Smtp-Source: APXvYqz/7KefU1PepmrlXbJuNHdv1LcskjRo2dk3pgYqgdNtUmZnRstkYW16mDX9ocpLJMiCLBg7bb1GGPv5FPxEOVQ=
X-Received: by 2002:a05:6830:1e05:: with SMTP id
 s5mr9263489otr.247.1566014275232; 
 Fri, 16 Aug 2019 20:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <1565991345.8572.28.camel@lca.pw>
 <CAPcyv4i9VFLSrU75U0gQH6K2sz8AZttqvYidPdDcS7sU2SFaCA@mail.gmail.com>
 <0FB85A78-C2EE-4135-9E0F-D5623CE6EA47@lca.pw>
In-Reply-To: <0FB85A78-C2EE-4135-9E0F-D5623CE6EA47@lca.pw>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Aug 2019 20:57:40 -0700
Message-ID: <CAPcyv4h9Y7wSdF+jnNzLDRobnjzLfkGLpJsML2XYLUZZZUPsQA@mail.gmail.com>
Subject: Re: devm_memremap_pages() triggers a kasan_add_zero_shadow() warning
To: Qian Cai <cai@lca.pw>
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
Cc: Linux MM <linux-mm@kvack.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kasan-dev@googlegroups.com, linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Aug 16, 2019 at 8:34 PM Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Aug 16, 2019, at 5:48 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Aug 16, 2019 at 2:36 PM Qian Cai <cai@lca.pw> wrote:
> >>
> >> Every so often recently, booting Intel CPU server on linux-next triggers this
> >> warning. Trying to figure out if  the commit 7cc7867fb061
> >> ("mm/devm_memremap_pages: enable sub-section remap") is the culprit here.
> >>
> >> # ./scripts/faddr2line vmlinux devm_memremap_pages+0x894/0xc70
> >> devm_memremap_pages+0x894/0xc70:
> >> devm_memremap_pages at mm/memremap.c:307
> >
> > Previously the forced section alignment in devm_memremap_pages() would
> > cause the implementation to never violate the KASAN_SHADOW_SCALE_SIZE
> > (12K on x86) constraint.
> >
> > Can you provide a dump of /proc/iomem? I'm curious what resource is
> > triggering such a small alignment granularity.
>
> This is with memmap=4G!4G ,
>
> # cat /proc/iomem
[..]
> 100000000-155dfffff : Persistent Memory (legacy)
>   100000000-155dfffff : namespace0.0
> 155e00000-15982bfff : System RAM
>   155e00000-156a00fa0 : Kernel code
>   156a00fa1-15765d67f : Kernel data
>   157837000-1597fffff : Kernel bss
> 15982c000-1ffffffff : Persistent Memory (legacy)
> 200000000-87fffffff : System RAM

Ok, looks like 4G is bad choice to land the pmem emulation on this
system because it collides with where the kernel is deployed and gets
broken into tiny pieces that violate kasan's. This is a known problem
with memmap=. You need to pick an memory range that does not collide
with anything else. See:

    https://nvdimm.wiki.kernel.org/how_to_choose_the_correct_memmap_kernel_parameter_for_pmem_on_your_system

...for more info.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
