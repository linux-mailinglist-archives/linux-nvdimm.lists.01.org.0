Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B2E20D525
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 21:16:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 41541111B33DD;
	Mon, 29 Jun 2020 12:16:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d43; helo=mail-io1-xd43.google.com; envelope-from=markalexandermilley321@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D6115111B33D5
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 12:16:02 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v8so18303626iox.2
        for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 12:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=XdfoRVGuOCD2JOxmLnJxyvoO2f5zjf1xh4i//8cGLHs=;
        b=E57soH+fAZU9oM/uuDn4bCNx2wALmvA7rwFsDeo/VdmyR4hSt+vRDMPW0qpAcJ9V/h
         UbYJ9fIR9BUAZrS+1TfrEzBoFSxbLFUBB/IIzj7rfy4Y1SyxPmM/cs9fEremwVWV5m5u
         b9v38myIgTBJNjasjLIOUO/K2CJS7vPJsURIlWBEC7RA0ax+vZbkexDjvFbqaAUgNm/w
         yj4NkgHNxXLdKOO4AZsIv5vnXx8YMl4s3e1fTXh2Hp6rhwVI9k4nzVvvlc/OSvXrfpbl
         +6DOlsrKa8IKCRxKxdcbetpm2uz+ZUKJBnziwlMhGJ11qW6bGQPIDGjYXF06+gry04Zz
         3NGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=XdfoRVGuOCD2JOxmLnJxyvoO2f5zjf1xh4i//8cGLHs=;
        b=lvXP+O5WsgVw+pU70Gg0MuVjcjoE23sMOv+BnSL4y1C8wkxBo9Lm5Ig40HtP1utpsO
         p+PM6/ze/CzTPYI/pFwYLDV+mr7/6JcR4ZBSu6Jkjn41jxP1DqeYc9f3Zjuinj8n88RS
         tfUiRIcJ79+S17T9TS8BeyGdLQia2WChFmQVfiZ+Oyi61Rg52bUbMl8ABJ6eBeRRFutz
         pRJ/410ib+k+tzINzK5oglNWu2HedtjtJgubKFTZofH/Zfz8cUGbeMvB1D5lYXre/ufk
         ajvYcscUXZfsz7hpE7OxGEPqsJTlk7GPQcxUrK4aNO+46RvOk3PbOVg1JLSuLqKGQ4VU
         Dt8Q==
X-Gm-Message-State: AOAM532+h6Esm3xG5FMvEbrLY98zk/zHKFzzuqNVSrJvDL2yCi+NXlkQ
	eRE9ZSQj1sTCk1AuWJBR2HycEjFQr15zT0sz0TA=
X-Google-Smtp-Source: ABdhPJyNR5zXZ8o09DSJzsSA3OSccnAxM/c9AxKQjYYOZlXvOMCiHs1YW/1gQi1Sa70TQ2VOPtabshfviWRkV7+ICnM=
X-Received: by 2002:a6b:db17:: with SMTP id t23mr18236117ioc.4.1593458159284;
 Mon, 29 Jun 2020 12:15:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6602:1588:0:0:0:0 with HTTP; Mon, 29 Jun 2020 12:15:58
 -0700 (PDT)
From: "mrs.victoria alexander" <markalexandermilley321@gmail.com>
Date: Mon, 29 Jun 2020 12:15:58 -0700
Message-ID: <CAP7XNCwEGQ+-Q==u4yk4yvJdk1X+gsfSU6pUV_hROjmF=p-DHw@mail.gmail.com>
Subject: Hello,
To: undisclosed-recipients:;
Message-ID-Hash: NKWZOQVSZ7IV2QHKG7MUNANNBYDFYFMR
X-Message-ID-Hash: NKWZOQVSZ7IV2QHKG7MUNANNBYDFYFMR
X-MailFrom: markalexandermilley321@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mrs.victoria.alexander2@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NKWZOQVSZ7IV2QHKG7MUNANNBYDFYFMR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear friend,


I have a business container transaction what that some of( $13million dollars)

 I would like to discuss with you. If you are interested, please
contact my email

address (mrs.victoria.alexander2@gmail.com)

My WhatsApp number but only message (+19293737780)

Please do not reply if you are not ready
Thanks
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
