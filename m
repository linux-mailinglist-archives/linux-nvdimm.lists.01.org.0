Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AAA344DFA
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Mar 2021 19:01:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65CA5100EB826;
	Mon, 22 Mar 2021 11:01:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mradegoodchild20@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E4001100EB825
	for <linux-nvdimm@lists.01.org>; Mon, 22 Mar 2021 11:00:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ha17so8911031pjb.2
        for <linux-nvdimm@lists.01.org>; Mon, 22 Mar 2021 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kdSuiPiCok/V/ZRO+z0oQ1ETdmBVSIRqHPQ+1VarpDs=;
        b=AmpFNWMGkbH/ovsc+UbaLmDhebQGItq/7gLz5DxZ9Bd2uyOK/mU+sUDzhGax8MG/f4
         OM39ZWGY//6Af//XgUWf4GL68tzbmQid3GYY+u1slQm6YGKak7gmvxQTUyAerd6OAClj
         8RxMrvUmLMJH5YJMKo3MpTZ5025w/txOBMLXO2MIndsL8Hekwen75LMip5RB6ZbYLogH
         MPFewuJA+iqYypvpIL1xevfOq43wkyTz1gRIbRXP7gLwJ++Gr9hq1XTYdWqTzoNkeJ9Q
         u9Z0VM83vOcQ2G2QeVui8NYpkBMD1+A3QjtauWnsk0Bt86HbWt3OaaximU3ByyHktnVz
         76Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kdSuiPiCok/V/ZRO+z0oQ1ETdmBVSIRqHPQ+1VarpDs=;
        b=YNCx6tjtzLu0YX9SsO8lZ1/yYRJg4E38+dRWuCmOQyokOkZhSN3kG+QZdjOc1tOSAX
         qYKja3p11oDRs1a4t/ojiQrv06v7VHhakTEIpgGzAM7il8vx1B5EF98ZBqBvCPWRbhta
         7YmdcdtMMwdYKI/dofAHENeLn7Xqn3Mdl1waaOMemwAkQKv8KQ+tcCWrnqp2NN7l3Vsc
         xq6Or8emjf+ZFl9TeXhymo6YntEqNfuVy9wun8opOJ6zTYvjbkr92mtKqbaaGbUPaPhd
         Re+Y8ElHgP83sEvoTujJGbVcI0nJfNflX6BPRJycn3f/t2UzZwZ0VoPdZlTgGVdbGLPE
         kK4Q==
X-Gm-Message-State: AOAM530hdQLT+NTU/7EUxI0Iww6owREdFG6frukIeGI39otZ8xQQBOsO
	DsFgNf978euHB6oruw/ZbjLv9RURw0D46fvFoo0=
X-Google-Smtp-Source: ABdhPJxurfzVGVQam89WbaiN5kN1lLzhMTLO+g9Nuj6D86g2kmfPu010angJ5nh0QMQyUKzT7eWFfSgmIHf/yT/r220=
X-Received: by 2002:a17:90a:be09:: with SMTP id a9mr249581pjs.219.1616436054558;
 Mon, 22 Mar 2021 11:00:54 -0700 (PDT)
MIME-Version: 1.0
From: Sir Robert Edward <sirrobertedward22@gmail.com>
Date: Mon, 22 Mar 2021 18:02:46 +0000
Message-ID: <CAPtWORD5CK77zE2Q_BADxKUABr=cR-bShSLy+3G7F_N3xRhJhg@mail.gmail.com>
Subject: I have a donation
To: undisclosed-recipients:;
Message-ID-Hash: BB36EOUCRV54X5HZ33XKB7OVQYIMBPKC
X-Message-ID-Hash: BB36EOUCRV54X5HZ33XKB7OVQYIMBPKC
X-MailFrom: mradegoodchild20@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BB36EOUCRV54X5HZ33XKB7OVQYIMBPKC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I have a donation of 1.5 million usd for you kindly reply back for more
details.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
