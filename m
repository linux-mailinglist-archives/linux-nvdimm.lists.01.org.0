Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC192AAEA9
	for <lists+linux-nvdimm@lfdr.de>; Mon,  9 Nov 2020 02:16:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CC612165C1E23;
	Sun,  8 Nov 2020 17:16:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com; envelope-from=enbyamy@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9717F165C1E22
	for <linux-nvdimm@lists.01.org>; Sun,  8 Nov 2020 17:16:07 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id k26so8624684oiw.0
        for <linux-nvdimm@lists.01.org>; Sun, 08 Nov 2020 17:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2/k++WtMKcdAwUJoZnUHARNnkvDkyVkfviJV8vQ0AXc=;
        b=Sb/V1Rh5clTWSq/YDAk+HsgCFqbWxE6dcSidSePur9n/v0jNkJAmPLaOaFN6Bh/7ha
         X4Fv+8jzOhUTIOsFDlwGAwDB/eGAV6JBVzMWT6Zv/0sDsFr29ai8Z4+8Uh84ihWfeUBv
         rnd20sQN/vsVmzU/f00Gz0ABpMOH0XbIwB14V95zah3Xlr2wGoM9cWrbHC+CXo0z6I97
         DdfLHZR2oGnrhvCVN7VBw3XcJv2gdO+/IUroAYTe3GTBqiS8XJH7MtliGzkXoeOz6v5C
         QXAA7XOci3yZqTrF6QenpbIW37Zn6jJcBqhh757d8Lg559K8ZW1r/zRAe33+01e1F60s
         sVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2/k++WtMKcdAwUJoZnUHARNnkvDkyVkfviJV8vQ0AXc=;
        b=eNekOei62Py5OIcWa4ztNYkZK0rorZGduTAP2EUG5d2SATY/Dm9ftQigDvHLBa03Q1
         hRYLWbsxYYS1VzfCxT04tEopt6vxSIE66ZQcMOGlOjIpZISTzZ14VkB7DkxmEihMQc7s
         wdXRWxHZYrttHnzW+ZvMNiGMh4vUycQUWMG9qvqTy5YJj6VpKSa+w/diQEutzWFqfwVq
         kUdNOfGpLHJPV0r+1PS/A2Ns8HpJd0sD+ycTdwDuCzQnq/XUn/CMKYYTddNcQbqsOQXV
         TI6AJABEojOI3XBbHkhyFhpz/6RZoppTbqwtK4Ankx7UQ+9h7/db9pr79rVS2mPw15LS
         g2eA==
X-Gm-Message-State: AOAM5331iJHAjt4MhgwzpyEV1LFBwM2P741QGuRd3fUoGw8Ffm3pUwd5
	UsHs0nAhQY3uhcaBxmEfcgxRbN9swysLMmT+cPQ=
X-Google-Smtp-Source: ABdhPJzO+xGFTUHJ0xu9qUxdaV0uv2eHULnJc9pbzR/MzJWxzg5gALpbmiBlOBqy454JfLCwf+Q2xiG56xNDcJXPh5E=
X-Received: by 2002:a05:6808:2c4:: with SMTP id a4mr7341812oid.114.1604884566155;
 Sun, 08 Nov 2020 17:16:06 -0800 (PST)
MIME-Version: 1.0
From: Amy Parker <enbyamy@gmail.com>
Date: Sun, 8 Nov 2020 17:15:55 -0800
Message-ID: <CAE1WUT6O6uP12YMU1NaU-4CR-AaxRUhhWHY=zUtNXpHUfxrF=A@mail.gmail.com>
Subject: Best solution for shifting DAX_ZERO_PAGE to XA_ZERO_ENTRY
To: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
	Matthew Wilcox <willy@infradead.org>, dan.j.williams@intel.com, Jan Kara <jack@suse.cz>
Message-ID-Hash: I4TTJHTQVUMRD54YNRHZKQ62APDEH6HB
X-Message-ID-Hash: I4TTJHTQVUMRD54YNRHZKQ62APDEH6HB
X-MailFrom: enbyamy@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I4TTJHTQVUMRD54YNRHZKQ62APDEH6HB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I've been writing a patch to migrate the defined DAX_ZERO_PAGE
to XA_ZERO_ENTRY for representing holes in files. XA_ZERO_ENTRY
is defined in include/linux/xarray.h, where it's defined using
xa_mk_internal(257). This function returns a void pointer, which
is incompatible with the bitwise arithmetic it is performed on with.

Currently, DAX_ZERO_PAGE is defined as an unsigned long,
so I considered typecasting it. Typecasting every time would be
repetitive and inefficient. I thought about making a new definition
for it which has the typecast, but this breaks the original point of
using already defined terms.

Should we go the route of adding a new definition, we might as
well just change the definition of DAX_ZERO_PAGE. This would
break the simplicity of the current DAX bit definitions:

#define DAX_LOCKED      (1UL << 0)
#define DAX_PMD               (1UL << 1)
#define DAX_ZERO_PAGE  (1UL << 2)
#define DAX_EMPTY      (1UL << 3)

Any thoughts on this, and what could be the best solution here?

Best regards,
Amy Parker
(they/them)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
