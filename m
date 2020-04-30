Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF481BFBFF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Apr 2020 16:03:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B05DE100E5CF6;
	Thu, 30 Apr 2020 07:02:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::141; helo=mail-lf1-x141.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 10AD8100E5CF4
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 07:02:06 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j14so1303685lfg.9
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 07:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqs6/WoFCiYvtJs2NOyJ4iHVgMuqbT1GqHeEFPhOPPQ=;
        b=O8t7ysvn4JbuCgfHB0iclVfyXqKjhyJMADH7fryiwgDIaikCUb2xUHFTGkfrv/kOGT
         ChdTR92r6FB9qFSdR0QPOufTNyG3cZsWdSpf9JRI7IcOooSDszEv4yLEcFZtwKJToURL
         x34EdQwoyAhaLyKmaBh1g7sFR+CWi6lGqj6Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqs6/WoFCiYvtJs2NOyJ4iHVgMuqbT1GqHeEFPhOPPQ=;
        b=fJXR0peGf9+IJasU2TBaSdbPlACFG3xgdPcAUsKgdD93VsSWnxHnQryExHgX29qF8+
         OYA2zu5q9Q/rTHbvdtjZH7WgR65TaE8S8H5sWZmpWWyN8vWNNaF2tiPoPlSQujOcb0Cb
         eBO/L6COqOuKeyjClY7HRlhey1N9vCN4gDS/eo24jyiBP9YSV5TZZWNbbyQ5mLRQbDUb
         aJYCmbpWcsMtfuH9DTKef45sOzITB31pZPGGfDxH8lM264eBsdf+OkCSgOPWMo3q3hzh
         +IpqkDI/iZNhWal63mKWaUqCQLM5aP4NOXV/nC5YtvR9Gl42aOt5hF9QaRqlV/ls3v/F
         oj2A==
X-Gm-Message-State: AGi0PuZ3j4zYWCHgCAarpZ/WfBdQYImedXq5RDYPskaqZefjQ9TREnx1
	p6BZE36J2ZqN7n1I7c/NSi9cVopuYk0=
X-Google-Smtp-Source: APiQypK++MPQ5tKfG7IB7N99iCdSYK5XgZ4/ukzbrq7VUO3tSqG6qawLlshHhePmRRF2yjqpAtopmA==
X-Received: by 2002:a05:6512:74:: with SMTP id i20mr2266885lfo.104.1588255392881;
        Thu, 30 Apr 2020 07:03:12 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id a13sm4434782ljm.25.2020.04.30.07.03.11
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:03:12 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id a21so6598064ljb.9
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 07:03:11 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr2483575ljj.265.1588255391241;
 Thu, 30 Apr 2020 07:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Apr 2020 07:02:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
Message-ID: <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: 6BPCSJ4IJKRE3LTXX2DN6Z5OVQKCPATM
X-Message-ID-Hash: 6BPCSJ4IJKRE3LTXX2DN6Z5OVQKCPATM
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6BPCSJ4IJKRE3LTXX2DN6Z5OVQKCPATM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2020 at 1:41 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> With the above realizations the name "mcsafe" is no longer accurate and
> copy_safe() is proposed as its replacement. x86 grows a copy_safe_fast()
> implementation as a default implementation that is independent of
> detecting the presence of x86-MCA.

How is this then different from "probe_kernel_read()" and
"probe_kernel_write()"? Other than the obvious "it does it for both
reads and writes"?

IOW, wouldn't it be sensible to try to match the naming and try to
find some unified model for all these things?

"probe_kernel_copy()"?

              Linus
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
