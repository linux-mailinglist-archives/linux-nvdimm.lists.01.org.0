Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3113109E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 May 2019 16:52:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 68362212909C3;
	Fri, 31 May 2019 07:52:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AA77F2128DD5E
 for <linux-nvdimm@lists.01.org>; Fri, 31 May 2019 07:52:36 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id j49so9413483otc.13
 for <linux-nvdimm@lists.01.org>; Fri, 31 May 2019 07:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dazNgH0WSo6RBdntgfM2itxBiI4ct6zLibwem/T/a7w=;
 b=j/GsBEIAjVbZy5Y3mimHxH4kZFIlLlKkT8Acinmv2sLTumtJSAz4+K45i94HMcU8B5
 5vuoBjVllo8eLWfIEEGmSHN3y18C2+WtOf2ld9xfh/eBfNzfI08ywejx6/WFhh2Qh1Js
 U/xC31+TIvuIg3zpSPwdusI6fAgBAbuf9ZVsZWxcMq9qesaxUCnyu+Jm/j/acoKaQrVk
 /xZ6KTMGmaqDluJACKDkBZki6qenzP6ucLDP6nqi5PMISHPe9me9sBfBu16SCQ9MmPmY
 x6x0pxCLwDJjV9HwPASaVKILGYScIoM8oWLKnlfoOZ9C4wOlTg6towcaz/+2kExeQ+Ur
 a5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dazNgH0WSo6RBdntgfM2itxBiI4ct6zLibwem/T/a7w=;
 b=uTadcOVA/a9KeKsgn0PMiQs31qiwLm5aB/a8tyxacs6ohMuSxk1NHQ4pQJnvKCiEhy
 0vILBMoJGrMJXkqQRjgyCHezezKgX27b342BPbs5u0gck5bMFOKYYVFIA9mhy5ayfps1
 AHZpo6j8uaNa3pAsM3emnavyYrgjpGybW5zpVKTAYdFGWAKHhzdq3sOUrFCqYUhZoBZS
 8+IL/xn49DxUB2StqRLazzbROcBHiZV4S8WNJjciD5+MRJHDSKo1XeDh5R7aLg+KccP3
 ZcqLz18X8BsQ3zP8d6hDhxfZTcICYWMcArCzdYAPnhaKrXyqRcneZwiEoiYK2Qt7jQim
 ZhXQ==
X-Gm-Message-State: APjAAAVNcc1OisJ43VsuP8/DCsK7oDxQr9Sh+FgI/DnGrQedcooFlQNe
 EDGc7oEtnSz1oMj8zDrnLYtN1KXdIyvV1SRoJob4mA==
X-Google-Smtp-Source: APXvYqz4eQwsdM8n+GXsG5v0XO/vAmXg8NEkFxvIGNZys/6jEKVlKq5wCfwFwo8AbFTYskZ23wp82lAK4anye2kHMfM=
X-Received: by 2002:a05:6830:1417:: with SMTP id
 v23mr1948581otp.71.1559314356156; 
 Fri, 31 May 2019 07:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155925716783.3775979.13301455166290564145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <4965161.Uu1Nigf0I0@kreacher>
In-Reply-To: <4965161.Uu1Nigf0I0@kreacher>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 31 May 2019 07:52:24 -0700
Message-ID: <CAPcyv4ib1twvDBz6W=JU18JyvtYmyHeAU4iOruRGHf_cY+3Yvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] acpi: Drop drivers/acpi/hmat/ directory
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
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
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 X86 ML <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 31, 2019 at 1:24 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Friday, May 31, 2019 12:59:27 AM CEST Dan Williams wrote:
> > As a single source file object there is no need for the hmat enabling to
> > have its own directory.
>
> Well, I asked Keith to add that directory as the code in hmat.c is more related to mm than to
> the rest of the ACPI subsystem.

...but hmat/hmat.c does not say anything about mm?

> Is there any problem with retaining it?

It feels redundant for no benefit to type hmat/hmat.c. How about create:

    drivers/acpi/numa/ or drivers/acpi/mm/

...and move numa.c and hmat.c there if you want to separate mm
concerns from the rest of drivers/acpi/?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
