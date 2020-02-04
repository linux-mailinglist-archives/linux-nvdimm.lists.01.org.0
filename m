Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E5B151E77
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 Feb 2020 17:44:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 855B610FC339A;
	Tue,  4 Feb 2020 08:48:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7571510FC3398
	for <linux-nvdimm@lists.01.org>; Tue,  4 Feb 2020 08:48:02 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id p8so17668836oth.10
        for <linux-nvdimm@lists.01.org>; Tue, 04 Feb 2020 08:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=txCJX4Ne8ohW4iJOJEvhQaXEi/CwoZWs9QB4Yj1b5nw=;
        b=E8BMVd2Oq2XNQz1eagY0Y+rTL0R1OArk+RNjkxQq4QR/Bf7gXbTtfxyrQDEykMnIHR
         ZIYTJAG4piDuOptEAgoIFgtwCU06/9y9sKaoiLmmkpV84rsQOEQ/NAg0IN93tOFX9QzO
         /PnPme6X6LhS85N6jcrz5EqfY+xiY2ggFBHaY+rtueU8D1S8u/NNple1nQKALIFSvNVW
         PaThBkXTx0caPjS/4ue/jNpLbD60+T30X9Gu1bSWJUt80x0TJ5ZoL0cTEE1238+Gvjew
         zoVvC54nNhjGAmzxiEtx5R533wm4iuWhq18ZyJKuk10dgIyMAXqY1KynN1wgW6/XdFhm
         R9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txCJX4Ne8ohW4iJOJEvhQaXEi/CwoZWs9QB4Yj1b5nw=;
        b=q4qM0JtR9Kvi2DkvGthiAapv1sfJBWrs2EmzYzWD5WJJVm7D6aOCEzMhOtgRIrBs7a
         Ov8cpLkuRq/PL7GE1JweduuXvqctlGKek9qxbuRpdBzTHThUF3zXZU9i4TPqClNmcvM+
         4NQpEmZ3hAe4BfqRSJBbj1L3hv4TKF/7HXRvYFkn54RU4appQysYqrJc+8WR+Mg7xdjP
         w3i0yrlZMaNLjDCkVa/HVPstryEkQT3+wVUtni4ZDaRlGxgAzyardF1gX3mNU5XdoLkG
         fuwMIXQsnIl7LOZN8zA3SdtAD/GIP72vqqT3C341xPTLupdTcIuLelOgdGqU7RkNw/SN
         KAgA==
X-Gm-Message-State: APjAAAUG1OqnI/YGTbIi0zTIPdzTjJ1JdQ8QTZ3ghXF1enNM/wMvfGhS
	QGtSmLnY808sKITVDJoXBE+4Ni2qg9DKWpuK4XIkXw==
X-Google-Smtp-Source: APXvYqzgn5XWbVJRcw05AyZXj+WSrtxUuUc1VbpFIxK+pSeYmXs4lh9OAJSchu3D7rwCd4p8faMkZHZi8Bn21THy1dU=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr21603447otm.247.1580834683627;
 Tue, 04 Feb 2020 08:44:43 -0800 (PST)
MIME-Version: 1.0
References: <20200110190313.17144-1-joao.m.martins@oracle.com>
 <20200110190313.17144-11-joao.m.martins@oracle.com> <e605fed8-46f5-6a07-11e6-2cc079a1159b@google.com>
In-Reply-To: <e605fed8-46f5-6a07-11e6-2cc079a1159b@google.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 4 Feb 2020 08:44:31 -0800
Message-ID: <CAPcyv4iiSsEOsfEwLQcV3bNDjBSxw1OgWoBdEWPQEymq6=xm-A@mail.gmail.com>
Subject: Re: [PATCH RFC 10/10] nvdimm/e820: add multiple namespaces support
To: Barret Rhoden <brho@google.com>
Message-ID-Hash: XWVH62JLXYPIWB24CABUGIXLL3RUTPEA
X-Message-ID-Hash: XWVH62JLXYPIWB24CABUGIXLL3RUTPEA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, KVM list <kvm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Liran Alon <liran.alon@oracle.com>, Nikita Leshenko <nikita.leshchenko@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Matthew Wilcox <willy@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XWVH62JLXYPIWB24CABUGIXLL3RUTPEA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 4, 2020 at 7:30 AM Barret Rhoden <brho@google.com> wrote:
>
> Hi -
>
> On 1/10/20 2:03 PM, Joao Martins wrote:
> > User can define regions with 'memmap=size!offset' which in turn
> > creates PMEM legacy devices. But because it is a label-less
> > NVDIMM device we only have one namespace for the whole device.
> >
> > Add support for multiple namespaces by adding ndctl control
> > support, and exposing a minimal set of features:
> > (ND_CMD_GET_CONFIG_SIZE, ND_CMD_GET_CONFIG_DATA,
> > ND_CMD_SET_CONFIG_DATA) alongside NDD_ALIASING because we can
> > store labels.
>
> FWIW, I like this a lot.  If we move away from using memmap in favor of
> efi_fake_mem, ideally we'd have the same support for full-fledged
> pmem/dax regions and namespaces that this patch brings.

No, efi_fake_mem only supports creating dax-regions. What's the use
case that can't be satisfied by just specifying multiple memmap=
ranges?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
