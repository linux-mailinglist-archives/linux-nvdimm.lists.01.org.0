Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D62A32C4700
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Nov 2020 18:47:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2088D100EE8C8;
	Wed, 25 Nov 2020 09:47:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::e46; helo=mail-vs1-xe46.google.com; envelope-from=3p5i-xw8jdnyjjgk6tsue2jlafk8e2ad.4gedafmp-fn5aeedaklk.st.gj8@trix.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-vs1-xe46.google.com (mail-vs1-xe46.google.com [IPv6:2607:f8b0:4864:20::e46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7DB7D100EE8C8
	for <linux-nvdimm@lists.01.org>; Wed, 25 Nov 2020 09:47:22 -0800 (PST)
Received: by mail-vs1-xe46.google.com with SMTP id g3so559374vso.1
        for <linux-nvdimm@lists.01.org>; Wed, 25 Nov 2020 09:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:message-id:date:subject:from:to;
        bh=oWU5xdvAgHO+cO+LPUq+3kYapd9VlgYn32Y1pL6h0BI=;
        b=gSsWfmHrvHaEHBvnQ0+I3EXdW5XvDxgBDlFLgK2KsmiF1AQgJaMf7ftiv3HPgasBHF
         OnBA2QYL5d0cbe11GvuuQpFZEA9WOUAhCA6/UijUf3X2noA/X4wX76MwKYlrTT03diw2
         9wG+FZA4FhiRo7NxgxmmOfAaNZsaI3Zn4KT2+2hMAYBdkgA+YU9RjXlSWKMLZ9EqiWrL
         xryhTRldoKHqaEiRoiPnpwQxykdZ9p63lR8Nr/qe+gFSZASPYjrcAOGZvaJxQO9OGLcH
         BdLfFs7M/D3QKHVWMfRmShBek8LlBUdrA7EYU1SXO+Klcw6ByF5FqEkmIKq96dMaYEPX
         FPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:message-id:date:subject
         :from:to;
        bh=oWU5xdvAgHO+cO+LPUq+3kYapd9VlgYn32Y1pL6h0BI=;
        b=SUdccYYEZe4qXGvOnDHY+NIIOtupeWiNByLkbN3btnkkrbmWYw6S6yXJwdO++DxpzV
         POCVCgYxPW+e2Hw2A2l7Nz5TjBcAX/B1BZD19DSe/EkaVpJGuJoDQ4vn2yEDGuaLySnY
         3z+xq/2eEnX5kyC7TYQfEQFVHttJCuYyFlfkry+xOdQUseWSpIQASBwNmpUYLsPGPPMO
         ftVNqOGDGAxxD7KfGnzuGRfHLGnisKIR71pfy6sM8eQK9z2eIbEqEwuBSfYgYYLCVZNn
         UMbJalXP0NC1f4HQgukaBQCDrkYZ7vOUfPVaRBa5Rpt2qKnBwp5oVsRn0gjHBYhVMdjN
         74dw==
X-Gm-Message-State: AOAM533pwJxkQZmS/fLFIEVDrrXfK9wiXf5sXmWzZ5SV+gIhWaPPsCPb
	Me/2H4IpitTARCQ9NaP2vo38639clC7EYxj5R21u
MIME-Version: 1.0
X-Received: by 2002:a05:6102:514:: with SMTP id l20mt3192357vsa.54.1606326439257;
 Wed, 25 Nov 2020 09:47:19 -0800 (PST)
X-No-Auto-Attachment: 1
Message-ID: <000000000000ce6c5605b4f204d8@google.com>
Date: Wed, 25 Nov 2020 17:47:21 +0000
Subject: May I humbly solicit your confidence in this transaction!
From: rrose102martins@gmail.com
To: linux-nvdimm@lists.01.org
Message-ID-Hash: FSGYROAT4LELOXFRGU5KR6OVGCBEXMHS
X-Message-ID-Hash: FSGYROAT4LELOXFRGU5KR6OVGCBEXMHS
X-MailFrom: 3p5i-Xw8JDNYJJGK6TSUE2JLAFK8E2AD.4GEDAFMP-FN5AEEDAKLK.ST.GJ8@trix.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: rrose102martins@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FSGYROAT4LELOXFRGU5KR6OVGCBEXMHS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
Content-Transfer-Encoding: 7bit

I've invited you to fill out the following form:
Untitled form

To fill it out, visit:
https://docs.google.com/forms/d/e/1FAIpQLSc9JaaoeFb2fmJkwjQrJup-uzIbb0ZSfvmBqgZSIJg0eP0Sbw/viewform?vc=0&amp;c=0&amp;w=1&amp;flr=0&amp;usp=mail_form_link




 From Mrs. Dorathy Gaby
Abidjan- Cote D&#39;Ivoire

May I humbly solicit your confidence in this transaction, as being utterly
confidential and top secret. But I am assuring you that you shall be very
happy at the end of the day. I decided to contact you due to the urgency of
this transaction, as I wish to repose my trust and confidence on your
discreteness and ability in transaction of this nature. Let me start by
introducing my self properly to you, my name is Mrs. Dorathy Gaby, I am
the regional Bank Manager of BOA Bank Abidjan-Cote D&#39; Ivoire. I came to
know about you in my Private Search for a reliable and reputable foreigner
to handle this Confidential Transaction.

As the regional Bank Manager of BOA BANK; it is my duty to send a financial
report to my head office at the end of each year. On the course of the 2012
year report, We discovered an excess profit of Fifteen Million Us Dollars ,
[ $ 15,000,000.00 ] which we have kept in SUSPENSE ACCOUNT without any
beneficiary.

As an officer of the bank I can not be directly connected to this Fund for
Security Reasons, that is why I am contacting you for us to work together
to get the said Fund into your bank account for INVESTMENT in your Country.

The percentage Ratio is thus: 40% for you , 60 % for me and my colleagues .

Note: There are practically no risks involved in this transaction as it is
100% risk free and will be legally bonded, it will be bank to bank
transfer, all I need from you is to stand as the next of kin / Beneficiary
to the original depositor of this fund who made the deposit with Kumasi
branch so that my Head office can order the transfer to your designated
bank account. If you accept this offer to work with me, if you find this
proposal suitable for you, kindly reply for full details Via email:

dorathygaby3@yahoo.co.jp,

I will appreciate it very much, If this proposal is acceptable by you, do
not make undue advantage of the trust I have bestowed on you, and I assure
you that we shall achieve it successfully.

Best regards,
Mrs. Dorathy Gaby.

Google Forms: Create and analyze surveys.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
