Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BA383AD8
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Aug 2019 23:12:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 840D621311C1B;
	Tue,  6 Aug 2019 14:14:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 807EF21306CDA
 for <linux-nvdimm@lists.01.org>; Tue,  6 Aug 2019 14:14:38 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id s20so30611410otp.4
 for <linux-nvdimm@lists.01.org>; Tue, 06 Aug 2019 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SxfvXS8dkeLPpXkICvCXwX+4rlE1NK6AW+Bou/1xFzU=;
 b=yPVtcuImiPOLRP461tix/AcQLCmPpM2hT6wfZ3z3u8rK+/Z4Wcy9TZYR1+pBKb1sEv
 8s5ZXsKoBm0t/6DdFcCMSQQnCtMuYyJQRjyChWPlRiCLIdVoUKmVW20uRNmVEQwz55Q0
 bE/hu0rH2S8PkC3OoCF8CUVDVOjsDrmQt5AwkwC3N5pRqe3g/DntzunlOcmsfFn2MCbD
 i/D13Z/hbxjfwNu62slNJ6Upz8aIY9OSQn0Oh9mvcGHdw8JdOq4oK7LKRHM//+sN1MJN
 6p+ftsIHRD7HxlD2OO+al3P77mmVq899M63tNAeQ9Mm+CdQEQz3bbwdYoFTGtLZ1zNlr
 Fcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SxfvXS8dkeLPpXkICvCXwX+4rlE1NK6AW+Bou/1xFzU=;
 b=Pv1cCa/fkXhTdTOgXKJhWy8Zn1z/q9kHxkWpdO13HpkhgjBPyIuuUwbXlML4Rei/gA
 QEaaVgCxsH2EE7A0HafaMBl58rQfZitoZdM7rQynASk7gtzstrzB6+1jnbEpZ7l7szpC
 8ZB+WBhHgV7YgcvxNObqXeZPIsVJaMvYnVjKnj4igyDBH6eIhmD+N4hsEwm+Bwe37tk5
 8voQqNTDPwSMCxqdWvOwF+bbJucwnV0wXk4m2DO1wiB82cAZnrdoq9e6LR3KdbYt7v+y
 lZncrdp0ii8wlHV0u1YR/RXaUG18Qq/KlomiG0BsCn/dCLaIQpwtXcHQi1Qo9vR8cxCR
 lSLA==
X-Gm-Message-State: APjAAAWQVO17dtA5yJJc4gbtGNdgZUXGJflk88/RAs0UaXOQjgNn48wk
 hD7btBOfSCQCAmD6cJ3Vb5Jt1CbkrlgbcJXvB0YJdQ==
X-Google-Smtp-Source: APXvYqw9o9Yb/ND1MDNnGatZSfaVVbG1TKnSQ9e0LNGeNp1/ZpabJ2T1j/9smMMqoDrW/seGup0iO9zq36rzrSQKj2U=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr4580336otn.247.1565125927538; 
 Tue, 06 Aug 2019 14:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <1565112345-28754-1-git-send-email-jane.chu@oracle.com>
 <1565112345-28754-3-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1565112345-28754-3-git-send-email-jane.chu@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 6 Aug 2019 14:11:56 -0700
Message-ID: <CAPcyv4jgtYMKgEB4jnQ0g4fQPO39BCOmQM8Zo231=_D7L6wH=A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS if mmaped more than once
To: Jane Chu <jane.chu@oracle.com>
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
Cc: Linux MM <linux-mm@kvack.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Aug 6, 2019 at 10:28 AM Jane Chu <jane.chu@oracle.com> wrote:
>
> Mmap /dev/dax more than once, then read the poison location using address
> from one of the mappings. The other mappings due to not having the page
> mapped in will cause SIGKILLs delivered to the process. SIGKILL succeeds
> over SIGBUS, so user process looses the opportunity to handle the UE.
>
> Although one may add MAP_POPULATE to mmap(2) to work around the issue,
> MAP_POPULATE makes mapping 128GB of pmem several magnitudes slower, so
> isn't always an option.
>
> Details -
>
> ndctl inject-error --block=10 --count=1 namespace6.0
>
> ./read_poison -x dax6.0 -o 5120 -m 2
> mmaped address 0x7f5bb6600000
> mmaped address 0x7f3cf3600000
> doing local read at address 0x7f3cf3601400
> Killed
>
> Console messages in instrumented kernel -
>
> mce: Uncorrected hardware memory error in user-access at edbe201400
> Memory failure: tk->addr = 7f5bb6601000
> Memory failure: address edbe201: call dev_pagemap_mapping_shift
> dev_pagemap_mapping_shift: page edbe201: no PUD
> Memory failure: tk->size_shift == 0
> Memory failure: Unable to find user space address edbe201 in read_poison
> Memory failure: tk->addr = 7f3cf3601000
> Memory failure: address edbe201: call dev_pagemap_mapping_shift
> Memory failure: tk->size_shift = 21
> Memory failure: 0xedbe201: forcibly killing read_poison:22434 because of failure to unmap corrupted page
>   => to deliver SIGKILL
> Memory failure: 0xedbe201: Killing read_poison:22434 due to hardware memory corruption
>   => to deliver SIGBUS
>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Suggested-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Looks good, ignore the checkpatch warning about too long subject line,
looks appropriate to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
