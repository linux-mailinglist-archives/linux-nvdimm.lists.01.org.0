Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2118141F68
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 Jan 2020 19:44:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4908410097E14;
	Sun, 19 Jan 2020 10:47:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::144; helo=mail-il1-x144.google.com; envelope-from=contecindy5@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 94B6110097E13
	for <linux-nvdimm@lists.01.org>; Sun, 19 Jan 2020 10:47:38 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id v15so25523211iln.0
        for <linux-nvdimm@lists.01.org>; Sun, 19 Jan 2020 10:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/o+CA7VDRA7UR3HGeT8+/tYzwEnOXwq5B8ZHP2/HeYc=;
        b=MveYcniUJUB532f0dlOoihdmkjAHV60cDj8LBHI8M4h+3H+egt8ZCsWSnQoG7CEhld
         h286H+k74rDzfRQOoY/f9M81WRQr88YRuubiH3HanhIDyXki4cyulA7bNdgdh/npcklQ
         CvJo43u8PBPBkMgEH5HatRsI+u5tlB3wEJ1Th3FBUvpApZQxsvg7pL4HfvgLhjM/SAbt
         Wln7BJPpvNYZtoiRQX3zkLZKrm4kgBMldFao5RktgQ8gLQFv0TsxI7xopop5Q61lnjsD
         O+Nqof9tzp5qXVHsDImBQ0OOhN8D0ZvK4JC9Zw+KV08LpajVcASte5dFUKOIeqnCFHwC
         Gp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/o+CA7VDRA7UR3HGeT8+/tYzwEnOXwq5B8ZHP2/HeYc=;
        b=DBKc1JTkI/KVsgYIaJ1XBBxtCFbm75HiiWJVqpSs0iMfNXEfCKWDM8tjbNk/oZpVNk
         1AvRAHwuKLOQQgmr8NRRnFJrdpex49CZu1t4sv2Zddyeh7iIHWg5Y1+e914jz0MJg9gE
         qcHDwqxTd8/BWDIuJNZYgw7Wpv3S8ogvcCk1DIueps1sXiADEuV3guuMYCFSdomw42L1
         iwIALDywlWHTeSi5cVEE5yvdAGUkWchJKbC85R5F5tg+0D996vQMvb0cGvOyNvb4noZo
         JJYQ4DM9BKUE/QLrux2a+MvMMvXDYdOr44Op8sxEvSuOFpOEm0HAMARuUHlvuEussHLi
         zg9g==
X-Gm-Message-State: APjAAAW+sHWtceEcpWYpjQ821xi9bDc4jwBFOfR96qYrAu2hFxWY+2Ip
	1o1p2A+i3OCkmb4b85QSGtD61v4MD3TD8UyFvDs=
X-Google-Smtp-Source: APXvYqzrfoOpFYdPx6ke6uIX585SnMDBN6pXKvD7iN8x9MT//+KimK2aFC33ps3ZC6gjq3Pi1pIlacgfKiFCQZrpYZA=
X-Received: by 2002:a92:d1c1:: with SMTP id u1mr7477573ilg.66.1579459459106;
 Sun, 19 Jan 2020 10:44:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:95c8:0:0:0:0:0 with HTTP; Sun, 19 Jan 2020 10:44:18
 -0800 (PST)
From: Favor Desmond <contecindy5@gmail.com>
Date: Sun, 19 Jan 2020 18:44:18 +0000
Message-ID: <CAOfCPNxgSoAU_ns0j9jYL-ArKfcD=i8NkJvHsR4-OGvFBVDMZg@mail.gmail.com>
Subject: HELLO
To: undisclosed-recipients:;
Message-ID-Hash: CYX3UH57LFV6ORUXSEJ4BIVMNPT6GUKO
X-Message-ID-Hash: CYX3UH57LFV6ORUXSEJ4BIVMNPT6GUKO
X-MailFrom: contecindy5@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: favordens@email.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CYX3UH57LFV6ORUXSEJ4BIVMNPT6GUKO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Dear
Greetings to you,I am Favor Desmond from Ivory coast currently living
in  Togo Republic,I would like to know you more, so that i can tell
you little amount myself and my photo, email address is
favordens@email.com
Thanks
Favor
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
