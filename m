Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B5B112092
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Dec 2019 01:15:25 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 783DA10113695;
	Tue,  3 Dec 2019 16:18:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 70D3710113693
	for <linux-nvdimm@lists.01.org>; Tue,  3 Dec 2019 16:18:43 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id j22so5167856oij.9
        for <linux-nvdimm@lists.01.org>; Tue, 03 Dec 2019 16:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9JhZIkY5UYbY9sicT+H9HLXPSEjz22qXNqZGrcjpfw=;
        b=sjADaI35VirKvqsrqcyE6zHoNPjuN6G2m9ZEfOP0vAzlUcOZatDYa+fY1Lh7TSemxA
         E9z4+FLH81bsPE7jhKCCKN1DmErGGdIxeh39qCg4GwDB8ZsVx4r61KmTjQwCb/UuucdY
         MQzoUEuK07SBtKntXdJCpBk0kcT0omifR4aXFxcw7o3rx9lv7uA9aBUSsKzYL5hvmff7
         VBUsVf8LYZp9bvzGB9w4p+HLgV4aSriJTATl3XEvLqXfP38gMCA0YJngB18JE+aJyc3p
         AyoPpUAJe7VB1HdvyAHKuhO3bnO22MuhuJUDQ1jhzTpN+/z3jkA188FqW0RuyD6OHbD0
         B3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9JhZIkY5UYbY9sicT+H9HLXPSEjz22qXNqZGrcjpfw=;
        b=U4JokS+Fbq+uZLIrAxhkNO/T64DuoFq3DqCf0/krw79t+GVeu5fedI4rorm/gpwgEy
         Na49iwUU4+b2QRbrwk8cRd2U0MRn+8DaH9BUIxnJzNCvJEDhERwjI4XDPIxAuYN8fiBN
         RHgS+y3gPzFBPeP6GFCq5OauNFq8IDxcUBPTjdprhFQnbj8FVfy+GnQGeUP5Ov8+hTPf
         SCy+EVjGodw4uqyqoAUBwimfqXyj6D0rMo9iH9Ef3QGJKbKksUvM/pfSqYLBDPk0PqW7
         +MUu4L55U+qGD6lcXb7vz13yhOU5bxjEJRNy0iliTQzv/zgtG3N8DOb4Bf8b6yjygqbs
         p8hw==
X-Gm-Message-State: APjAAAVJnteRFpu2Vit5XN1QIsrPSvztMdfIdGlD9ZVkCGyX1hAjBv5n
	wnAJL8LyadCl0RxocBlWKhCxenh+jiMBNE5VFEhoIQ==
X-Google-Smtp-Source: APXvYqzZunLuEIN9d3ELG/cd3hfZU5berEzOo2/mUNAdgvjVy3WYCgxi0H9bamLriZ+TeAij+34DEI9woMPAH/4Z6q0=
X-Received: by 2002:aca:2405:: with SMTP id n5mr318915oic.73.1575418519668;
 Tue, 03 Dec 2019 16:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20191203034655.51561-1-alastair@au1.ibm.com> <20191203035057.GR20752@bombadil.infradead.org>
 <1e3892815b9684e3fb4f84bd1935ea7e68cd07d8.camel@au1.ibm.com> <20191203124240.GT20752@bombadil.infradead.org>
In-Reply-To: <20191203124240.GT20752@bombadil.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 3 Dec 2019 16:15:08 -0800
Message-ID: <CAPcyv4hccpaw5fFdp7u3Z=C0zNZ1oTBtNfyLhJ16C2Dmq+Qp3Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/27] Add support for OpenCAPI SCM devices
To: Matthew Wilcox <willy@infradead.org>
Message-ID-Hash: ZRFZOOZ4PHJY5T7ZXZKBYBYF2Q3JJ6FG
X-Message-ID-Hash: ZRFZOOZ4PHJY5T7ZXZKBYBYF2Q3JJ6FG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Alastair D'Silva <alastair@au1.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Linux Kern
 el Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZRFZOOZ4PHJY5T7ZXZKBYBYF2Q3JJ6FG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 3, 2019 at 4:43 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Dec 03, 2019 at 03:01:17PM +1100, Alastair D'Silva wrote:
> > On Mon, 2019-12-02 at 19:50 -0800, Matthew Wilcox wrote:
> > > On Tue, Dec 03, 2019 at 02:46:28PM +1100, Alastair D'Silva wrote:
> > > > This series adds support for OpenCAPI SCM devices, exposing
> > >
> > > Could we _not_ introduce yet another term for persistent memory?
> > >
> >
> > "Storage Class Memory" is an industry wide term, and is used repeatedly
> > in the device specifications. It's not something that has been pulled
> > out of thin air.
>
> "Somebody else also wrote down Storage Class Memory".  Don't care.
> Google gets 750k hits for Persistent Memory and 150k hits for
> Storage Class Memory.  This term lost.
>
> > The term is also already in use within the 'papr_scm' driver.
>
> The acronym "SCM" is already in use.  Socket Control Messages go back
> to early Unix (SCM_RIGHTS, SCM_CREDENTIALS, etc).  Really, you're just
> making the case that IBM already uses the term SCM.  You should stop.

I tend to agree. The naming of things under
arch/powerpc/platforms/pseries/ is not under my purview, but
drivers/nvdimm/ is. Since this driver is colocated with the "pmem"
driver let's not proliferate the "scm" vs "pmem" confusion.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
