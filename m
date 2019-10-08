Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A08D018E
	for <lists+linux-nvdimm@lfdr.de>; Tue,  8 Oct 2019 21:55:23 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2D27910FC3C81;
	Tue,  8 Oct 2019 12:57:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=currency1000000@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 12CE610FC3C80
	for <linux-nvdimm@lists.01.org>; Tue,  8 Oct 2019 12:57:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r9so16818828edl.10
        for <linux-nvdimm@lists.01.org>; Tue, 08 Oct 2019 12:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=d9t6Rq0RbZ7PXIZmIcLbP2JTBMFny2QBILsKgMXZe9M=;
        b=aMQQgi7dIXVBnmVMSSMCLgb3oXTzeafbZdgWl2Y7dgh9d3yilS1+9yTnvWoS7+GzUk
         LWbTYKnbDzuBJ3/U6U4a0Txwis4unkVKDohWYyBjnKYrTLghN7laSYeGp1/FcmznDyEO
         GS9pgiMN+uT0qCjbihaa5wuvtHOM98vqOW8UVjJ7Cv+EprgLSNS8LJdhrjnJyNqQEN56
         5sfOyU15h4kpoOXNgzNljIz5N8IZnpl4XHLYJYLCwvTOpHMRDfM3ywlgrk+4Qs+isMtv
         bwWMXB9P8rpPXCaQx70qpw2S2sG0Q07XznOIe3PPQ9uFVdh7+iWMtRM+rtyrWFblwrYM
         wXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=d9t6Rq0RbZ7PXIZmIcLbP2JTBMFny2QBILsKgMXZe9M=;
        b=h0BOMP322Uc1sa6BDej4T7ywyM2B2TfV7a82U/8aQWUSXXtH5kRgXJndWB59Ws5iWF
         mGOLE02bkJMO8pIY18kL865u+9PR3b9St/7NoT+WkuqS1V+VOIrOyq4Q6DCctGd5dR8y
         cHjy9y1YHlyGT1yEUUNitNx40eZkvKtnRIU4Ciir42o9lOw1PjIAQabY5z+NLXwyfpsH
         n138FoS61vAC3E4atFCLQQa+Sy0vaoEW5ZEHK0aXxQJtdUZ3zPy4gty6zV1x+G6eL2u/
         IB6DTGEGlBRUZk63KWgYkKXvIXinipfV2IkyXiyO1T5O/SF635ypQ0dyGPzHjF6Puk6z
         77bQ==
X-Gm-Message-State: APjAAAVHG/f3bShbpmL9RpFZ2E0TDhOhQPA5Bm3Jw0GOSwAlGQxXknUR
	Xh+gO8R9hMEpOfoLFSmmkzMpM67EglcEQTbFMw4=
X-Google-Smtp-Source: APXvYqxaZfvXk0/G1PfPN40JEbEfue6b7v2Lk/SQWmnUxoxmnZyxXwpPNC4UPIh9mJw4kQ9atMHeHG1Orcb22TWXOSk=
X-Received: by 2002:a50:c306:: with SMTP id a6mr36339639edb.108.1570564517490;
 Tue, 08 Oct 2019 12:55:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:cc89:0:0:0:0 with HTTP; Tue, 8 Oct 2019 12:55:16
 -0700 (PDT)
From: MONEY GRAM <currency1000000@gmail.com>
Date: Tue, 8 Oct 2019 20:55:16 +0100
Message-ID: <CAPqfnSEO==O6BEtBbcMMZfh3qcY4Bz0qndhCqbcLqZx4DCs44A@mail.gmail.com>
Subject: HERE IS YOUR MONEY GRAM PAYMENT HAS BEEN SENT TO YOU HERE IS THE M.T.C.N:78393135
To: undisclosed-recipients:;
Message-ID-Hash: HBIDBKTCXXUOPNQPW7WOT65R3LMA56LI
X-Message-ID-Hash: HBIDBKTCXXUOPNQPW7WOT65R3LMA56LI
X-MailFrom: currency1000000@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: moneygram.1820@outlook.fr
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HBIDBKTCXXUOPNQPW7WOT65R3LMA56LI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

HERE IS YOUR MONEY GRAM PAYMENT HAS BEEN SENT TO YOU HERE IS THE
M.T.C.N:78393135

Attn: Beneficiary,

This is to inform you that the America Embassy office was instructed
to transfer your fund $980,000.00 U.S Dollars compensating all the
SCAM VICTIMS and your email was found as one of the VICTIMS. by
America security leading team and America representative officers so
between today the 8th of October till 1ST Of December 2019 you will
be receiving MONEY GRAM the sum of $6,000 dollars per day. However be informed
that we have already sent the $6,000 dollars this morning to avoid
cancellation of your payment, remain the total sum of $980,000.00.

You have only six hours to call this office upon the receipt of this
email the maximum amount you will be receiving per a day starting from
today's $6,000 and the Money Transfer Control Number of today is
below.

NOTE; The sent $6,000 is on hold because of the instruction from IMF
office, they asked us to place it on hold by requesting the (Clean
Bill Record Certificate) which will cost you $25 in order to fulfill
all the necessary obligation to avoid any hitches while sending you
the payment through MONEY GRAM money transfer, the necessary
obligation I mean here is to obtain the (Clean Bill Record
Certificate)

Below is the information of today track it in our

websitehttps://moneygarm.com/asp/orderStatus.asp?country=global
to see is available to pick up by the receiver, but if we didn't here
from you soon we'll pickup it up from line for security reason to
avoid hackers stealing the money online.

Money Transfer Control Number M.T.C.N)::78393135
SENDERS FIRST NAME: John
SENDERS LAST NAME: Chun
SENDERS COUNTRY...BENIN REPUBLIC
TEXT QUESTION: A
ANSWER: B
AMOUNT: $6,000

We need the below details from you, to enable us place the payment to
your name and transfer the fund to you.

(Full Receivers name)...................
(You're Country)................................
(Address)......................................
(Phone NuMBER-...............................
(You're Age)............................
(OCCUPATION)..REAL ESTATE..................
(A Copy of Your ID CARD).SEE ATTACHMENTS.............

HOWEVER YOU HAVE TO PAY $25 FOR THE (Clean Bill Record Certificate)
AND THAT IS ALL YOU HAVE TO DO ASAP.

The payment will be sending to below information, such as:

Receiver.............. ALAN UDE
Country................Benin Republic
Amount: ....................$25
Question: .....................A
Answer:................... B
Sender...............Name:
MTCN :..............

According to the instruction and order we received from IMF the their
requested $25 must be made directly to the above info's.

Furthermore you are advised to call us as the instruction was passed
that within 6hours without hearing from you, Count your payment
canceled. Number to call is below listed manager director office of
release order:
DR.ALAN UDE
Director MONEY GRAM-Benin
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
