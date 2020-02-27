Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6D8172460
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Feb 2020 18:02:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 18E3410FC363E;
	Thu, 27 Feb 2020 09:03:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F0D9C10FC363E
	for <linux-nvdimm@lists.01.org>; Thu, 27 Feb 2020 09:03:28 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id 2so2861381oiz.5
        for <linux-nvdimm@lists.01.org>; Thu, 27 Feb 2020 09:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/jADGYHp0JHjLbfNvifObEsHN9b9nWgTjEodPO7hm0=;
        b=KPfzjDQtTnijJToFyDXktoC2udwyOzB0B5n85vP7uYekSEu8BkMpLT/ZI8CK3gNjgz
         S4lijftXsqXG4e0UvQY/lM0ScFXNOzHZ8nfP6HW//fgk3or+XDKKdQ3oUsEwbm9kjbSt
         YvZJdY2AqXxidZDU2pvSxjgcEExZaJPMc5a8U6aBVjmcc0vMBekyiq3voRqtqk0KSPAx
         RFvfSk+LlSSPZbVx4Jl7Nqwk1QcuKaWmy4niKZ4SeXt+CXOmgUmLp6ojW6ui9knkVAbw
         O56thY8gft/GhQJUltLLBZzs0iZAZiPm7sIaskKsb2nHEkfDNZ+AvKn6WunU3y1NY3xL
         bvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/jADGYHp0JHjLbfNvifObEsHN9b9nWgTjEodPO7hm0=;
        b=JuJVElwIeTjprKyDPvknKth+8hm0Wtb2d4GHvBeqJOnuyvf1mrqb/2pmpGTjvDWk7t
         YaK/Nu8Ybsgj9Zg+b6BfES9KNJN4zHxOCAwABCIOyeJfAy+B/EcZGvVN8JIehXM+4fXn
         2ESq0EjLvDj4/PCzms3QmDHLoceoTGf3Jp/g8Ph83XD6IPg6INZONbusKtcP/qM9MlWj
         S5oHjRTqn8+A6Pt1Tm+GZXY2FChnos2Oa56yrWnzI5nuOly3ZvCPpUpxRDXygMD1PB02
         HbjJ9uhT25sVgPXLYggIQ3h/vInbq5TJctE/ye0DIgu5uLhDmw++e9KHHFoztSs6NB51
         ZEVw==
X-Gm-Message-State: APjAAAXyDm9hSNzxvp71ZnRwIguFLfFWfB4YSkl3plwUTLyc5oEoX7sC
	oq5EhuDxzTkMuj6MfOzhW2jpIM6tzUaDsI9ZBHe8AQ==
X-Google-Smtp-Source: APXvYqypU1i0qqgWCthMIeErQC/uy0wM3eA252xRldHq9XOYpqruxDhwC/BTw+uhQHICN4k+v1Tc+9XvQsy7JvHRZsw=
X-Received: by 2002:aca:aa0e:: with SMTP id t14mr4256386oie.149.1582822956078;
 Thu, 27 Feb 2020 09:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20200221032720.33893-1-alastair@au1.ibm.com> <20200221032720.33893-16-alastair@au1.ibm.com>
In-Reply-To: <20200221032720.33893-16-alastair@au1.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 27 Feb 2020 09:02:25 -0800
Message-ID: <CAPcyv4jiXZrTNTOb8aY8nehVBphCOKbtDKK9ouddiHnEZSYW3A@mail.gmail.com>
Subject: Re: [PATCH v3 15/27] powerpc/powernv/pmem: Add support for near
 storage commands
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Message-ID-Hash: IA5RDIAINSXXDFH6BZC4ZUQ4NDNUPUT7
X-Message-ID-Hash: IA5RDIAINSXXDFH6BZC4ZUQ4NDNUPUT7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: alastair@d-silva.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashev
 skiy <aik@ozlabs.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IA5RDIAINSXXDFH6BZC4ZUQ4NDNUPUT7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 20, 2020 at 7:28 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> From: Alastair D'Silva <alastair@d-silva.org>
>
> Similar to the previous patch, this adds support for near storage commands.

Similar comment as the last patch. This changelog does not give the
reviewer any frame of reference to review the patch.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
