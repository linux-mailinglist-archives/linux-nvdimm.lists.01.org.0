Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC741D8320
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Oct 2019 00:02:16 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B67110FCC42D;
	Tue, 15 Oct 2019 15:05:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3DE8810FCC42C
	for <linux-nvdimm@lists.01.org>; Tue, 15 Oct 2019 15:05:10 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 60so18364622otu.0
        for <linux-nvdimm@lists.01.org>; Tue, 15 Oct 2019 15:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jtOZCetYUsXhpNpVA58OlhfbLjdY11Hx60Lh2ugc+08=;
        b=wDV1hamYv5KqJhN1ecA5M2SKVTYix6I/LJbkd9CSz//JQoHHkr64tBohIY0rCJHp9w
         CZFmhCav8aPUXZP9e8jsWj0gfWEwXTOkIuAOnWssbKDCXcU8xFK9SjjEp3Q5xZpHRRpP
         kH4lNr/DQ/EPR5KKZhs+aQcrW0mL8fMqCf7eYSwLfPA3abNJBqpxxo+F1lpOdCchdNhu
         0lvo28mVYk4JSL63RxcWubwy5dYaOzY6JrdFrk5vB2T8XwEfMjaJFQsQNBNGIZ0pCKLh
         IbntGpEUNq/jEOIaSkhAT2p8f3O2137D4ueHPX2JHIDoXW60Ulcs2+fuL33+SXSWSPim
         Mcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jtOZCetYUsXhpNpVA58OlhfbLjdY11Hx60Lh2ugc+08=;
        b=njPsrA3MYurs6bEzHYk2XKvC7e4Nagz9gklQX0pIRW5JUaFcv9iLECQrtwM6ycEZPJ
         YL/dJDve0zuhRUfQ+tZ2MWTt4ON6xV5m2o+F8OUu5OdBNApnXJPwoqbBRBdXGVrjsc1Z
         WQ8cHwFZmR6xwTXnWn3XQVeDZ1SNC/kMweVugucvVWpg84f2kiTjZwp8BAAXqynPmUQt
         tTCuTuQ0TzGsKZoGXY+d3nrx2LIu9vSFuVolPj/NKYgAMsoiLbrgkmXVpzLZt8jzNSEY
         XRKppgOXCIRuPqWEu+sfsTJ/foMk/aS4vr4g8uOUCDJaMCSuBoCng/Z4eov/t43UB/Ui
         spqA==
X-Gm-Message-State: APjAAAVkQ0Bc7il0gkCeL2fXsxGH0TepMcR4w2uo6mYUMgQx2/mcXGnP
	ESKSwKPHbeRgBFFOCuDAD2MX2Rt4NOjCCR0uX1HrTA==
X-Google-Smtp-Source: APXvYqzPzSUdQX9cSGFEHru4nlzetdTS1vpg3FVAzQxZ+QSebAzzX9ly7t79ddu+5rbI5+/JKBdzyPmlLUFz/mtUpWY=
X-Received: by 2002:a9d:5f11:: with SMTP id f17mr4011356oti.207.1571176931026;
 Tue, 15 Oct 2019 15:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191015153302.15750-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20191015153302.15750-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 15 Oct 2019 15:02:00 -0700
Message-ID: <CAPcyv4ihjGGAOF0NK_23yuOpsdBY7M=UZWNt1KN3WnP_e9WZOg@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] libnvdimm/nsio: differentiate between probe
 mapping and runtime mapping
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: WDGW2RLSCM6XBPDZHRLQNTC33P2PJKLJ
X-Message-ID-Hash: WDGW2RLSCM6XBPDZHRLQNTC33P2PJKLJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WDGW2RLSCM6XBPDZHRLQNTC33P2PJKLJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 15, 2019 at 8:33 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> nvdimm core currently maps the full namespace to an ioremap range
> while probing the namespace mode. This can result in probe failures
> on architectures that have limited ioremap space.

Is there a #define for that limit?

> nvdimm core can avoid this failure by only mapping the reserver block area to
> check for pfn superblock type and map the full namespace resource only before
> using the namespace. nvdimm core use ioremap range only for the raw and btt
> namespace and we can limit the max namespace size for these two modes. For
> both fsdax and devdax this change enables nvdimm to map namespace larger
> that ioremap limit.

If the direct map has more space I think it would be better to add a
way to use that to map for all namespaces rather than introduce
arbitrary failures based on the mode.

I would buy a performance argument to avoid overmapping, but for
namespace access compatibility where an alternate mapping method would
succeed I think we should aim for that to be used instead. Thoughts?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
