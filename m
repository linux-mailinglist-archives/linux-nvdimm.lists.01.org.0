Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1952051AC
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Jun 2020 14:02:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BBFCF10FC3C35;
	Tue, 23 Jun 2020 05:02:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com; envelope-from=bakert.jg@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9E51710FC3777
	for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 05:02:14 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e12so4220884qtr.9
        for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 05:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=7fNnQnFssZCc2Jtw2cUlJB4v7zrpRiQS682aXMZO9+Q=;
        b=UJLFqH+nz6JL18vmMp9AOPI2FroC31pq+teAwHPNar1eiBQ9Yy+80ms5K4v1/p3T2J
         L2/VBlv2V7VfKE4rYCdbWJvLLZVc6lYLnv+fXOe3DKiEunpb4W19D97rUv9DtkFDrPR6
         bxx9SCKFFR7oxS5wyOawR10NgiPx7iNPtQtk1jgGWBrP8t2WHU3s2Svu9XywyJgiovqp
         l3N+/UeaWFg1/B0rDgEZev7snS4P5yMRqccSmgr8wtgvtp7SCEkaeMIuLfVC1abYn28a
         0lOm8r0Y3ORb/ecNi+nwJO1PSdlC3wO2gaNbjCYRAGTYyl1dNKtQmi5TFLPwZkpxG3z2
         jLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=7fNnQnFssZCc2Jtw2cUlJB4v7zrpRiQS682aXMZO9+Q=;
        b=RGvwSaB56oMfOAHc191uIrbXhronbB+DfQ8JaMM6DqIPKBHbR/a5H7jRsE49XXL9ZP
         hLw0843l6o2ojT+6aZek9JxJReSRBY+fPhydunaJfQLmjdi2wvohZLN+EjGAgHrQxNVI
         csE6IS8b0Dt6nYPz02mgHikoIfVzcBDuRnB/xMnPT4H/g2vquzutqBEYbXB+NbnxSh8/
         b20sVs0+phdo5QeE1i5ixnoyPAk94/Q7l1J8/Gcagp25VP6W5Kodxk9RMpAreE4k/2+y
         P/mlu+PeOVRurZ1CsU/tHwnhCj74wv5yTOmDZ+B62ryTU0ukUgQO28oC2O+HOHzIIFNY
         Ictg==
X-Gm-Message-State: AOAM532dtD/MvOEeEs0/PLzMZBwyifLGhE0Id9g6c3hKf8Xp61sbxfJA
	ctYmyrM+PLfDFIdR773RZXXfFlgMSKenEnJaBi0=
X-Google-Smtp-Source: ABdhPJy9hL0j/lhNbfcB00DeOK7b0U4zsoic5mnnMbHNRRfvtq2YEG4GVY9xM4euUA/qj/6OFeVzDzuTpkOX9D54k0k=
X-Received: by 2002:ac8:2fb0:: with SMTP id l45mr20693117qta.260.1592913733005;
 Tue, 23 Jun 2020 05:02:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:47c2:0:0:0:0:0 with HTTP; Tue, 23 Jun 2020 05:02:12
 -0700 (PDT)
From: YAVUZ BEKTER <bakert.jg@gmail.com>
Date: Tue, 23 Jun 2020 05:02:12 -0700
Message-ID: <CAAUSuTW=r1zPYsLsMYZRnSyv_sPyVA3dnZKNBmSk5AVRmY-kDQ@mail.gmail.com>
Subject: Hello.
To: undisclosed-recipients:;
Message-ID-Hash: BZYVV6NZ7RWRUIAYQYRHQEUS6WQAKPVR
X-Message-ID-Hash: BZYVV6NZ7RWRUIAYQYRHQEUS6WQAKPVR
X-MailFrom: bakert.jg@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: bektery@outlook.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BZYVV6NZ7RWRUIAYQYRHQEUS6WQAKPVR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I am the foreign operations director of Bank of Turkey.
My name is Mr, Yavuz. I have a sensitive investment project to discuss
with you, please reply now.
________________________
Ik ben de directeur buitenlandse activiteiten van de Bank of Turkey.
Mijn naam is meneer Yavuz. Ik moet een gevoelig investeringsproject bespreken
met u, antwoord dan nu.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
