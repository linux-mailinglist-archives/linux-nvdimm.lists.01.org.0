Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FFB277B09
	for <lists+linux-nvdimm@lfdr.de>; Thu, 24 Sep 2020 23:26:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6CA24152E66D8;
	Thu, 24 Sep 2020 14:26:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6AB1C152E66D6
	for <linux-nvdimm@lists.01.org>; Thu, 24 Sep 2020 14:26:32 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z23so707189ejr.13
        for <linux-nvdimm@lists.01.org>; Thu, 24 Sep 2020 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=in8Rg86VvfYuzQh6U7/hDwBGxF8v1AUSBmpO9E789oQ=;
        b=Prvekm5qZ88alNocW0qFgn9cNj4Z7QPimTG+psr7zIONUFcW/sHjWqo//GgbjmL/pf
         Qyi3kbx59KsXbxbt5zVjLpfbDD5wqchk4ncB4m9x1sIIdLR7f/KrMYOWvVfcwXkCNzE0
         mMBAE2hS6VPIeqVq5TwF/2xMYdk/evhZkCGinbxKW92OUZfrQKMIfnXtfyq1OMrF6fiI
         7hM62hDuLhBPU6MmQIBfypJfSQi8cEJujTeoPII/G5Q0qktgQrL9sWDMLtSQcH2vxa1e
         pAec2dHwsj0ZX6DcdP0RlhkEqNAcUa606Ui3etrBGY/9HZZN4lq2/eQdVX6P9Cnh39Wc
         BhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=in8Rg86VvfYuzQh6U7/hDwBGxF8v1AUSBmpO9E789oQ=;
        b=c/CNoAFyyuFiaKU5Yq2NnusEkZV7f4YLO9hUVC5c9K0xl5qlbowSUhzgHioNlJCMcY
         gnZNJ1XqjPsv1ojeoTXJGX1vUNAkSuBVEPw+2LFiMUWSuXMFFAHTO/ll+Xn9GFpW4a36
         IuS0ydqp17jGVsx0UpRl3LcQTPo5jbak5iz9EfVM+unlPtoXHatF8KPf38KVMnApaGgt
         SnEfhMuGjSdQSN+QAarlFAWgcnyD5xSxKRwZN0CDuL6F3Wrd3nLsa+LZ7X11H+tup1CB
         1bSLME4gCPQWo8x9mhfVGATqN5TybpNw6FPykQngUjEmDEYJBlZuGNCxm1Os5CMUh97c
         91WQ==
X-Gm-Message-State: AOAM532AimvogL+GuWhvo6wriLzr7CoSNvQy09kaSqsFAwPDVnk3txXZ
	M8othNYyc4kBrwpVVrtpgC5NMNcC54S48qxIw055jQ==
X-Google-Smtp-Source: ABdhPJwo2nc1Tk13TPjt0rD146GmflS4xaeaqP6B2BkyjnC8iqLNN+AT1GEdOa+lozWWeYUYn6ojXC5A3ZlNsX+AQxo=
X-Received: by 2002:a17:907:4035:: with SMTP id nk5mr592391ejb.418.1600982790747;
 Thu, 24 Sep 2020 14:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159643100485.4062302.976628339798536960.stgit@dwillia2-desk3.amr.corp.intel.com>
 <a3ad70a2-77a8-d50e-f372-731a8e27c03b@redhat.com> <17686fcc-202e-0982-d0de-54d5349cfb5d@oracle.com>
 <9acc6148-72eb-7016-dba9-46fa87ded5a5@redhat.com> <CAPcyv4h5GGV3F-0rFY_pyv9Bj8LAkrwXruxGE=K2y9=dA8oDHw@mail.gmail.com>
 <d160c05b-9caa-1ffb-9c01-5bb261c744b5@redhat.com> <CAPcyv4jf9fK5oOcROMx=c-3q6aGFp89MNi-+GoZ-dy1gdNTrJw@mail.gmail.com>
 <28ad3045-9238-2a77-d74d-9660a36aa4da@redhat.com>
In-Reply-To: <28ad3045-9238-2a77-d74d-9660a36aa4da@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 24 Sep 2020 14:26:19 -0700
Message-ID: <CAPcyv4iQ4VnXMU0+_7rfXwPowgcdoABSFUH4WO_3P9vHtWAzPg@mail.gmail.com>
Subject: Re: [PATCH v4 11/23] device-dax: Kill dax_kmem_res
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: J3VLIOGDBIUGWYOXI7GLTH4NMKSWSFNA
X-Message-ID-Hash: J3VLIOGDBIUGWYOXI7GLTH4NMKSWSFNA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J3VLIOGDBIUGWYOXI7GLTH4NMKSWSFNA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[..]
> > I'm not suggesting to busy the whole "virtio" range, just the portion
> > that's about to be passed to add_memory_driver_managed().
>
> I'm afraid I don't get your point. For virtio-mem:
>
> Before:
>
> 1. Create virtio0 container resource
>
> 2. (somewhen in the future) add_memory_driver_managed()
>  - Create resource (System RAM (virtio_mem)), marking it busy/driver
>    managed
>
> After:
>
> 1. Create virtio0 container resource
>
> 2. (somewhen in the future) Create resource (System RAM (virtio_mem)),
>    marking it busy/driver managed
> 3. add_memory_driver_managed()
>
> Not helpful or simpler IMHO.

The concern I'm trying to address is the theoretical race window and
layering violation in this sequence in the kmem driver:

1/ res = request_mem_region(...);
2/ res->flags = IORESOURCE_MEM;
3/ add_memory_driver_managed();

Between 2/ and 3/ something can race and think that it owns the
region. Do I think it will happen in practice, no, but it's still a
pattern that deserves come cleanup.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
