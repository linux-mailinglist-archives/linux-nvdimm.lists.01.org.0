Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E89F7321E8A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Feb 2021 18:53:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E3D1100EB83D;
	Mon, 22 Feb 2021 09:53:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com; envelope-from=davidheiser4568@gmail.com; receiver=<UNKNOWN> 
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4AA4E100EB83C
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 09:53:15 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id p21so7028028lfu.11
        for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 09:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=n3eH8fc7c63400pMFay9v4NYcLZ+o0vJKsl88V8S4Zg=;
        b=Lc5cM7iHAG/fCwsxyCBON+72NWRqTjdcXQ37KsesMNQRSSqNi3GhZA06aF1nxK3cW2
         KPSnjozIEcDr9CWyO5IS0zipNGSBseUiUIOwrKTS1SqMuIWeODYOhc+I2c3c0D3MgQRA
         q2OEsOAf0A3SnerfXsx/9hYim8LP8rPGr7EDK8jpxqZRjIhp2nrvoEhU6ZjzxVG5E+o+
         DZo0ENCEE39N/ReWySWodt1T7mo1fc7v36I8byNj3ZHkXJdDch+tnVVryKmVKthYku2J
         2HXfq0fPwrZoUGEQUXTVUJsWDj2/PIJRpYXoAsgIocCkDvA+qNBZAqLzwILBcLeoEJ/b
         G2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=n3eH8fc7c63400pMFay9v4NYcLZ+o0vJKsl88V8S4Zg=;
        b=LsOiJ6zqqvKcgW/3fkYItv+kuJULATnbw11wn36jQzqsRl0ugM3KuzRP+2gQqBydnU
         R5YyCfMcJ8UYiypS/guDQqk6bDF/lXX3v42kBrVYFmUTsORw9m0jhTmlo/vc9RJg9Ffa
         mQZ0awybcJYvuHvibVsxo2nuPNEdal08ZhJ1vfGT5nWGvffePAN64CdTlwaanx3Y08ln
         p53PYNvGcEjcGhAqL7n+T0ugg+0obUavLKjLT7CNt8cGKnyeqpdFePVHgukxK9Nof7Tv
         pY7o2363oYP2ShGBObifk+MjKfMoTppZ74QWFBhvksIac47g8yVOF/9i/75MS9223LWE
         Fzew==
X-Gm-Message-State: AOAM532Vl80HCVBoaVO4edob6firZBZaw+OxzId3r+jTol+TBsWcbPF2
	0wnP5btIvv7WZZJTaP2UQvNU2OFp0efDIV4V06A=
X-Google-Smtp-Source: ABdhPJx9G8NgrdU1VtDNaZfSe4+hVzo3Crdz1mFUHTb6REXg42OHt+i19FBLJd0S9ecA+NsvAVs6nKKmwGdpIVIwlCM=
X-Received: by 2002:a05:6512:3194:: with SMTP id i20mr14633840lfe.283.1614016393316;
 Mon, 22 Feb 2021 09:53:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a19:7dc2:0:0:0:0:0 with HTTP; Mon, 22 Feb 2021 09:53:12
 -0800 (PST)
From: Mark Jackson <davidheiser4568@gmail.com>
Date: Mon, 22 Feb 2021 09:53:12 -0800
Message-ID: <CABH_sfJEcnGnLbgED+zHQh559sb7sSU6Jvm4xwkASVwt5GicWw@mail.gmail.com>
Subject: Your ATM CARD For Compensation
To: undisclosed-recipients:;
Message-ID-Hash: KRT7T4CBQF2R4KLQEENRDEV3K27LKUFS
X-Message-ID-Hash: KRT7T4CBQF2R4KLQEENRDEV3K27LKUFS
X-MailFrom: davidheiser4568@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KRT7T4CBQF2R4KLQEENRDEV3K27LKUFS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

My Dear Friend

This letter is to acknowledge the substantial contributions of time and
energy you have made in trying to assist to claim the fund through
your account, despite that it failed us because of your inability to
continue financing the transaction.

Besides I'm happy to inform you that I have succeeded in transferring
the fund out of my home Country with the help of a new partner from
Tuvalu.

I am now in Tuvalu for investment and Tuvalu is composed of 9 coral
atolls along a 360 mile chain in Polynesia. They gained independence
in 1978 the former Ellice Islands.

Therefore in appreciation of your earlier assistance, I have decided to
compensate you with the sum of $850.000.00 USD which I raised in ATM
CARD on your favour.

This fund I have given to you has been deposited with a bank which has
already opened an account and issued to you ATM CARD worth
US$850.000.00 (Eight Hundred and Fifty Thousand United States Dollars)
The ATM CARD is withdrawable from any ATM Machine in the world.

So feel free and contact my Personal assistance (PA) in Benin
Republic, his name is Mr.Stephen Pena

Address: Carre 1299, Ste Rita City
Cotonou,Benin Republic

Email: ( spenaneoris@gmail.com )

and instruct him to send the ATM CARD to you.

Please do let me know immediately you receive it.

Regards,
Mr.Mark Jackson
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
