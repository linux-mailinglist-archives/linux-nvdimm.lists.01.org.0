Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F811A2E32
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Apr 2020 06:11:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B7D6110113FCE;
	Wed,  8 Apr 2020 21:12:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::244; helo=mail-lj1-x244.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C87E410113FC7
	for <linux-nvdimm@lists.01.org>; Wed,  8 Apr 2020 21:12:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z26so5875295ljz.11
        for <linux-nvdimm@lists.01.org>; Wed, 08 Apr 2020 21:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZV2tyyn5kRqCcuYzyXRvuvJ3LvB/Ij4cHXWeK01HzY=;
        b=gwLIomC7wLBmb6JFfXV96AHH+ECKwQVO7CEBA3QESJy1aFRjCCjozlVwvUf1aCLCsj
         8jaUU8mqD94X0bBewdTWHRVlAhvr8lSsF8tT+bastkAziEMAu/ftwTQbFrchjedOpQw7
         UWlNvtjMfgbVHPwRtbHBjzt9Zvmeqs6ZbdTVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZV2tyyn5kRqCcuYzyXRvuvJ3LvB/Ij4cHXWeK01HzY=;
        b=DNugE72ZlIzZfR24Upm4/pW08lnfvV1BKcBzlZ5A5fmYWhH4gMZONFXLCh2Gls9ryg
         MR9oRC83wOyOWoyP9dDH0TzJnknsvnYnBNAg71ZrlFE1TWPu91uMWmemTFJZ6qss5mq+
         vEsyS8zFzAYWBiU4snqJnQuGgw0S9E7QE5JLKl7dadwPWRyZrSgm/oiwirVhiqGsJiWb
         E3xYVeh302NgctMAIUZUUQDN+TPVNs0LAtj7qtgOxNZxd4ETrroNJQzRavAcL9Zh6DaZ
         t+WrOe7J6JZr+Wf+MzZR7htJmkpm4JylA8SNQPfYdXRNBZsDvNB1ZATkCToU6VVzvXL9
         V53g==
X-Gm-Message-State: AGi0Pub0KIlYwiuHyAjuptfB08VhV3OlEuCGKSTb0BG5SdzCMDpgH+hx
	VbPjmso3L9djdANu/31/HsVlR0INdyY=
X-Google-Smtp-Source: APiQypJOffT7mQXYtowrPdtgaD4w3AwD+zvHDdCbJVDJfW27piU9NbicfU/DNXLOCITVMc+Hr0yF9g==
X-Received: by 2002:a2e:8850:: with SMTP id z16mr6803369ljj.284.1586405507368;
        Wed, 08 Apr 2020 21:11:47 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id c22sm2211935ljh.66.2020.04.08.21.11.46
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 21:11:46 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 142so5446659ljj.7
        for <linux-nvdimm@lists.01.org>; Wed, 08 Apr 2020 21:11:46 -0700 (PDT)
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr6845493ljp.204.1586405505983;
 Wed, 08 Apr 2020 21:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4gKr57qNnMEupjcjQmH9Vy_iZuLPE1VA36QAkKhzEbzSA@mail.gmail.com>
In-Reply-To: <CAPcyv4gKr57qNnMEupjcjQmH9Vy_iZuLPE1VA36QAkKhzEbzSA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Apr 2020 21:11:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whm-J+j86gqWA93tpBHDfOwsLGt=dV2px8bUL7pbRR4ug@mail.gmail.com>
Message-ID: <CAHk-=whm-J+j86gqWA93tpBHDfOwsLGt=dV2px8bUL7pbRR4ug@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm for v5.7
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: 7CVIWA3I24FEI7OTRI6OYZJZHSDQZEDM
X-Message-ID-Hash: 7CVIWA3I24FEI7OTRI6OYZJZHSDQZEDM
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7CVIWA3I24FEI7OTRI6OYZJZHSDQZEDM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 7, 2020 at 1:12 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
>       mm/memremap_pages: Introduce memremap_compat_align()

Why is this an exported function that just returns a constant?

Why isn't it just a #define (or inline) in a header file?

Yes, yes, it would need to be conditional on not having that
CONFIG_ARCH_HAS_MEMREMAP_COMPAT_ALIGN, but it does look strange.

I've pulled it, since it doesn't matter that much, but I find it silly
to have full-fledged functions - and exported them GPL-only - to
return a constant. Crazy.

             Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
