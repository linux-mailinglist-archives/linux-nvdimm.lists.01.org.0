Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6847168334
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Feb 2020 17:24:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 434FD10FC3611;
	Fri, 21 Feb 2020 08:25:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A85F310FC3606
	for <linux-nvdimm@lists.01.org>; Fri, 21 Feb 2020 08:25:23 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id b3so2503521otp.4
        for <linux-nvdimm@lists.01.org>; Fri, 21 Feb 2020 08:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2necOtKPRGOvCKSmF/mkYAKx6vUj3EgsCgdFv1SUhI0=;
        b=cBEVhpXst0AzntwHO7MAAC8tPgH/lHhw3JRg1tiTU84YvfHSiop6h5HEb7dD7ijKuo
         Tkw/ZNf20go4KH7TnldYOoZEAs0/HjhdC6mtapS6+Q3y/I7Q+YrEMV84Zr3jKw37sWpE
         U9Jl8f/7cOVM1MQYH54S4Vp6WSWKpzS2B9dUJOJpX4zoeMiFs4UP17D4CccHDAg8ZFR1
         vCZ/8RYSCxh9NQiUxEt36OEadxPUC7ds7oA0vIxw+TkYSm380z9btYwB+23YYwbo8b8g
         7XRdvaaGovLDozll686+2N7fCxFPusnOHgUUDjTiUfiXQ3pTNjxbkIR85nNqgJmQT6GQ
         8i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2necOtKPRGOvCKSmF/mkYAKx6vUj3EgsCgdFv1SUhI0=;
        b=IAeKApFIARre9m01viIzIoKRd4+ioNBIt4l+bWE+aEWL7EYnjYOeGhOAxjfqzzmkhh
         mXIjOfUznjBRv9x5RLAYLolt3KtnmiQLeWC2ndjogX6pedOCfGdWijY5AU8hMhVK1gBi
         84MX4zmUAVpqQlN88wXa5iprKU536KlYXVIwBv0GpbJjJH3hlmONM8UwRL4e+SQHOr3l
         jjf4qZ1h9hUgW1E4hk09792+pTSWXpHv8fqvwzl8Roi4rZMgkaVq5IPKSprZ1I6+njLT
         8X4wsNDPUojvBi8r1gmdy4pWnP3wmX/idYH3dom461jZUEAbhgagqP/+0KyO0hFidxQ/
         m1ng==
X-Gm-Message-State: APjAAAVZmFa22cxVSZQvaS2cRLpbU90EHG6nZMWISBFpUsfzwTHmJV94
	yFGhtKCxSFcduF+MEeN0EG0mspJi/3RsUWDx3T32ww==
X-Google-Smtp-Source: APXvYqxaf5u3WFzaIFaCrcTuxeBbhT11NwRGTSO9X8QeSchk7dKOD/6D3Clq0uqWRzW41IL9WLcTtDJa9yoQ436XJig=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr27053866otl.71.1582302269868;
 Fri, 21 Feb 2020 08:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20200221032720.33893-1-alastair@au1.ibm.com> <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
In-Reply-To: <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 21 Feb 2020 08:24:18 -0800
Message-ID: <CAPcyv4hzZt0oqWN8y_K70h3C1S1jNw6jfNF3jPujCFmLW+MSvw@mail.gmail.com>
Subject: Re: [PATCH v3 00/27] Add support for OpenCAPI Persistent Memory devices
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Message-ID-Hash: ZBYYPNCZYXGAXBWGACOSXZB62QOEA45B
X-Message-ID-Hash: ZBYYPNCZYXGAXBWGACOSXZB62QOEA45B
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: alastair@d-silva.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashev
 skiy <aik@ozlabs.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZBYYPNCZYXGAXBWGACOSXZB62QOEA45B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 21, 2020 at 8:21 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Feb 20, 2020 at 7:28 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
> >
> > From: Alastair D'Silva <alastair@d-silva.org>
> >
> > This series adds support for OpenCAPI Persistent Memory devices, exposing
> > them as nvdimms so that we can make use of the existing infrastructure.
>
> A single sentence to introduce:
>
> 24 files changed, 3029 insertions(+), 97 deletions(-)
>
> ...is inadequate. What are OpenCAPI Persistent Memory devices? How do
> they compare, in terms relevant to libnvdimm, to other persistent
> memory devices? What challenges do they pose to the existing enabling?
> What is the overall approach taken with this 27 patch break down? What
> are the changes since v2, v1? If you incorporated someone's review
> feedback note it in the cover letter changelog, if you didn't

Assumptions and tradeoffs the implementation considered are also
critical for reviewing the approach.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
