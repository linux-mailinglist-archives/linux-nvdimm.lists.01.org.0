Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0691B15F6
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 21:30:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 41796100A0281;
	Mon, 20 Apr 2020 12:29:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6B230100A0280
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 12:29:20 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so8907917ejd.8
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 12:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ce20/CIQIX522RaPVTyPTfJEPqiyAriKhvUnxTulqdM=;
        b=Ew/qZu4sDhUqxZ/TYFqRH0ERtCxbKG4Z8viu2sPjWVDAgBWlvcnLRlRx5rwXTM/Oah
         mIYHqq0r+8iblP15rxoSx33CEyZunyDuuLZACk8dgur1ueNplknlYmcAylmjCtPf23DA
         W9fH6ydZ1sJNeXLG+uo/C5iF+Bx7zwA18kCdy3xNxw5iz8+YxTIHSDrMrmLspd9T1TpP
         ntKFG8X9R+1/qJUVjBuCLfLmn2FSJJekaPBY9XT3Vh9StB1/hFnewJwuLeKxA0WHVKuW
         mtpVxRXs6eZYVS5FIIcDdh1u3GSNKMaWuB1GMxDd8IXaXWIKV6KMRQ2rSrylkdDm8eYG
         MzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ce20/CIQIX522RaPVTyPTfJEPqiyAriKhvUnxTulqdM=;
        b=doWzKVIFiWRXwtEEOYfgfZXSFSasafqbwT0sTx3cStKXNZJfDwLdu/kl8tVdbiDPn6
         9+c5Ti7MfHtK3RFqZyHLJIan7w3hkt7neBozW6pkyZ0fddhBBqEGfp9kG1kf8nzZ+rMo
         m289Vtf4z7QuSUjLK0GVY6tE2Oql45u7rVZM2MBDHkGizYh/9s69fHcdRIK0+KVfRUwo
         f5WaWe0LI/4fsxwjGd4ptIpXenyoP+dw7cxQgP4/3bT6+EL/Uf5aV8Z1uFD4WDgRZqpJ
         pXZqgaeDrRARGz5JEGsTybkyJWG9RLDuv/UZUwrTwL3/cDS8b42CWl5xNCHn9T7BqhnS
         x/VQ==
X-Gm-Message-State: AGi0PuZmC70RcZGVpboOOxiTKaijiF1q6NgtelA1HZ8bGZJIx7dS/sNm
	3/Gan6zzIyMXBOqGyHiSBJy2tlXme0ARTb6o3ep1OQ==
X-Google-Smtp-Source: APiQypK9aQrIzZ87xSipVCdNGdFMMM1E4PzK+Awa+HpCEy9iTdMb3+e2PhmQ2RqaH5oAUbvtfE2smMIkNiOOGSkMCww=
X-Received: by 2002:a17:906:6d8e:: with SMTP id h14mr17131940ejt.123.1587410964104;
 Mon, 20 Apr 2020 12:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
 <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
 <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
 <CAHk-=wjSqtXAqfUJxFtWNwmguFASTgB0dz1dT3V-78Quiezqbg@mail.gmail.com>
 <CAPcyv4hrfZsg48Gw_s7xTLLhjLTk_U+PV0MsLnG+xh3652xFCQ@mail.gmail.com> <CAHk-=wgcc=5kiph7o+aBZoWBCbu=9nQDQtD41DvuRRrqixohUA@mail.gmail.com>
In-Reply-To: <CAHk-=wgcc=5kiph7o+aBZoWBCbu=9nQDQtD41DvuRRrqixohUA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 20 Apr 2020 12:29:12 -0700
Message-ID: <CAPcyv4iTaBNPMwqUwas+J4rxd867QL7JnQBYB8NKnYaTA-R_Tw@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: P2XM7OOHPCDVADRVCP6MXNVQDR3YROCV
X-Message-ID-Hash: P2XM7OOHPCDVADRVCP6MXNVQDR3YROCV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andy Lutomirski <luto@amacapital.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck <tony.luck@intel.com>, Erwin Tsaur <erwin.tsaur@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P2XM7OOHPCDVADRVCP6MXNVQDR3YROCV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 20, 2020 at 12:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Apr 20, 2020 at 11:20 AM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> I really really detest the whole mcsafe garbage. And I absolutely
> *ABHOR* how nobody inside of Intel has apparently ever questioned the
> brokenness at a really fundamental level.
>
> That "I throw my hands in the air and just give up" thing is a
> disease. It's absolutely not "what else could we do".

So I grew up in the early part of my career validating ARM CPUs where
a data-abort was either precise or imprecise and the precise error
could be handled like a page fault as you know which instruction
faulted and how to restart the thread. So I didn't take x86 CPU
designers' word for it, I honestly thought that "hmm the x86 machine
check thingy looks like it's trying to implement precise vs imprecise
data-aborts, and precise / synchronous is maybe a good thing because
it's akin to a page fault". I didn't consider asynchronous to be
better because that means there is a gap between when the data
corruption is detected and when it might escape the system that some
external agent could trust the result and start acting on before the
asynchronous signal is delivered.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
