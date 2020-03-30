Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5575C197998
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Mar 2020 12:46:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5EB6210FC3792;
	Mon, 30 Mar 2020 03:47:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com; envelope-from=ochefut11@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 39B9910FC358B
	for <linux-nvdimm@lists.01.org>; Mon, 30 Mar 2020 03:47:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b12so19425022wmj.3
        for <linux-nvdimm@lists.01.org>; Mon, 30 Mar 2020 03:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=EmnByVjRRIj/dcGI2wocpvR+OQ9kOqGokD1SxfsI6FI=;
        b=MsPDn0mVRTwS/gOLfq5FAQupJIyFg7FxdhWOIDOCFgIF/+PX8LFKDDk2aHWigxv6xG
         IS1ds+1lJDo0kFFZ7vAtcaqRZd45Dl5liOzGnhrID7z4KBTqrb3LMr8LTVnrkGS/CzRK
         Gney0xXrw+Np2CODNEuPF1JZ76CtMxlwegmkw4zDx3eLq5J76X64/vjB/QGsPB/e0rC8
         6nsnZZTu2JS6PCdHvqoar/teA7jKFAf6acBgaW/815K0Rqb+iD6wpjHTRlionE0DS1I4
         LtgXnghOxC+WpGJGrWiZDmfemIX5nl8Dle4woqvxHdf+OGeEk5Pz0wUIyGhRyQ9AgI19
         ycsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=EmnByVjRRIj/dcGI2wocpvR+OQ9kOqGokD1SxfsI6FI=;
        b=fi1aQhWx8r8HkGVtUDQ5PXceLZvlCYoqavDh4jG708jeiW/9IMaCOPmnQ1V18ZvSN0
         1Xj1/6MYfd2/K+aGG7QdJ9C9l+mgjOdDbPLVHPawpNiyE5ibKz5Ty6xv5Qpbu+OETplV
         6fqkMNT1j8ntbElyO97rXYEJC/5EtHU7AJDYMlmBKiAf/v8y59MkdnARH+0EiKL5VtQ1
         uxzVxC9/rXNU9Vm1pam2Xd2dhKaEAqddV8VKwrsKpqovg0k3nFlPEhanAsdMIzMxSTGg
         8D3d6klZFvtHKAq3ETb3Q/Wz2TJbtPMpjMlkKrw5q7C5B0EA85hvwsTi60XdBUV/btJX
         af0Q==
X-Gm-Message-State: ANhLgQ1pZ/s2v6JsC/8qAOeADeC0p5CSNbUf23zuAcdXi8Poi2/TuZIG
	FDv+VgUlrVvWB5s1ZUnJZ0eiiVY8/gBrAL7TjpM=
X-Google-Smtp-Source: ADFU+vukFmkcpgD4u3JZG3O+v+ie64KN+2htgGYPJLVpkvqzzRcVdTEaY4wVr1D0aLXbXT5p1wS8fmvZPrNo5Y7mkok=
X-Received: by 2002:a7b:c404:: with SMTP id k4mr11982233wmi.37.1585565171543;
 Mon, 30 Mar 2020 03:46:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:fcc7:0:0:0:0:0 with HTTP; Mon, 30 Mar 2020 03:46:11
 -0700 (PDT)
From: Harvey Terence <ochefut11@gmail.com>
Date: Mon, 30 Mar 2020 12:46:11 +0200
Message-ID: <CAPCmsMM-ae_SHYLtSBdYMA5UQBHQZpYg4T90AJR+fsuXsyHdTw@mail.gmail.com>
Subject: THANK YOU
To: undisclosed-recipients:;
Message-ID-Hash: EFCJVDF4HT7UBZGOODZ7S4MGYUQT46IU
X-Message-ID-Hash: EFCJVDF4HT7UBZGOODZ7S4MGYUQT46IU
X-MailFrom: ochefut11@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: maab1@yahoo.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EFCJVDF4HT7UBZGOODZ7S4MGYUQT46IU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From Harvey Terence (Mr.)

25 Canada Square, Canary Wharf, London E14 5LB,

Good day

I am Mr. Harvey Terence, Operating Officer of this bank. With your
honest assistant and cooperation, we can finalize this transaction
within 7/14 working days.

 I need a reliable and honest person who will be able to handle this
business opportunity with me because of the need to involve a
foreigner. I am contacting you because of such demand, and I believe
you will work with me to achieve this purpose and will never turn down
my request.

Before the United States of America and Iraqi war, our bank customer
Mr.Hatem Kamil Abdul Fatah, who was the deputy governor of Baghdad in
Iraq and also a business man made a deposit of (GBP10,750,000.00) Ten
Million, Seven Hundred And Fifty Thousand
Pounds Sterling Only in a Bank account number: ABP-LN-685
00/52207712321 over here in our bank.

But I later discovered that the Deputy Governor has been assassinated
in Baghdad by unknown gun men.

Below is the information about his death as a proof and verification
of his assassination In Baghdad:
http://news.bbc.co.uk/go/pr/fr/-/1/hi/world/middle_east/3970619.stm

During my further investigation after hearing of his assassination in
Baghdad, I also discovered that Mr.Hatem Kamil Abdul Fatah did not
declare any next of kin in his official papers including the paper
work of his funds with our bank which might be because he embezzled
this funds while in office and was afraid of revealing his political
dignity when opening the above account number in our bank until his
dead.

My aim of contacting you is to assist me to receive this money in your
bank account over there in your country and let me know how much
commission you will receive out of the total fund when transferred
into your oversea bank account?.

You will diligently transfer the balance to me through another bank
account number from another bank I will forward to you as soon as the
fund is transferred into your over sea account after deducting your
commission from the whole sum or I will come over to your country to
meet with you one on one for sharing of the fund or shall invested the
fund into any lucrative business out there in your country together..

We are going to process and perfect the transaction legally as bank to
bank procedure has been put in place.

I need your urgent reply through my private E-mail address at:
maab1@yahoo.com if you are interested to work with me.

I provide more details on how to process the approval of the fund in
your name to be release for instant bank to bank wire transfer into
any designated bank account of your choice without delay.

Please keep this transaction safe and confidential as exposing this
transaction will jeopardize my reputation in this Bank.

I would like to hear from you in no distant time as soon as you read
this mail through the above stated E-mail address so that we can
proceed accordingly.

Best Regards,

Mr. Harvey Terence
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
