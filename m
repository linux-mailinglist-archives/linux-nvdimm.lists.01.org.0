Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B935512FDAF
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Jan 2020 21:20:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 04B0510097DF8;
	Fri,  3 Jan 2020 12:23:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com; envelope-from=westernunion.benin982@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7645B10097DF7
	for <linux-nvdimm@lists.01.org>; Fri,  3 Jan 2020 12:23:29 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id x1so34690863qkl.12
        for <linux-nvdimm@lists.01.org>; Fri, 03 Jan 2020 12:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=40ACnQIUnpge54Cj+EODMXbGQ2AM0yGbootCDBdgIh0=;
        b=JHYDNcOHsw5Vg59sFwNh4MhnXNKJfQKDhV3JhQemZ8O0wjy4NOClQJHVO9/XZY1B2e
         7N2r8FlVbF9YCIZf1O8PJKqvP+J732CrXrgkZLQFQD6r8xa5PmtrOPXurr4eE1D10/dY
         mFNu91hy8xJJRta6mrMYIQyNs0OE0ozgPWJvUT4Jmr91vUmPG9p04hCqKp3daJ6nspkN
         ZTnUyt7jeaXiRVZmI5OCw3hnhqJr3CafoKv3hfbaHkDpeu4215n4LA4JUWv5RDO6VsPp
         wo4bmuxUPsJ+VBxSxq4NIVVGqRtUU4TTV0YA8c6/GhqTjpJxCcyOyITBnIawjrG3MRiM
         hUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=40ACnQIUnpge54Cj+EODMXbGQ2AM0yGbootCDBdgIh0=;
        b=UbPFBvcA7bGkrgXjGFG1Ly/+BAusqS9gLJaetPNPwlTpwllwo6vcH2QyGdiu4UdQD/
         7vyde8gds7JMpAx/FIeKguLuezvONjb6FS+PZPve5uZ1Oo9eU09fuk7pUUQWt0ZjY0PE
         Dtb5URfPKK0UitnUu3ilUy0iqcycbp+fwn2XNGSlLLkl7QjZYMO0he8+BexIryRhSGJu
         cSO5Bw6FtHWXoc7BqFbFc+Lo1QnCGXRY2F/pLALIT0zsw7jwBJb4Eoqt7TVRY+LV8MPl
         V0u9DMMZbgR63IZxZd3AP6jUvxizZbvpzG5xcyNiGmwhOVD5zE3b7rZPDmTP7u4XScaW
         fLhQ==
X-Gm-Message-State: APjAAAXxqoW5kCXW8eHzYgasBJQsbkjDhrGWxxGi6ESpc7xMX++Yknkj
	tSJm0gDO6DNA77G1ibWsKFUtlUOrVvHXk8pchNc=
X-Google-Smtp-Source: APXvYqzazOZ1eDGwLjA5b5joJwHBsXYUc3xk3mwbut9BpsYKwbpZffl6B/gnfGOg4rASQDOizOWq9gQ5QJjCh6l6GTs=
X-Received: by 2002:a37:4141:: with SMTP id o62mr70745354qka.282.1578082808591;
 Fri, 03 Jan 2020 12:20:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac8:4410:0:0:0:0:0 with HTTP; Fri, 3 Jan 2020 12:20:08 -0800 (PST)
From: "Rev.Dr Emmanuel Okoye CEO Ecobank-benin" <westernunion.benin982@gmail.com>
Date: Fri, 3 Jan 2020 21:20:08 +0100
Message-ID: <CAP=nHBJWiJ9KpSSbF4jP9u5UiU5d_kGjSUyPYDmdB2x1uiJFMw@mail.gmail.com>
Subject: I promise you must be happy today, God has uplifted you and your
 family ok
To: undisclosed-recipients:;
Message-ID-Hash: KKUSYM2OTIKUFINUCI35QRDEPCEJIKZA
X-Message-ID-Hash: KKUSYM2OTIKUFINUCI35QRDEPCEJIKZA
X-MailFrom: westernunion.benin982@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KKUSYM2OTIKUFINUCI35QRDEPCEJIKZA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Friend

i hope all is well with you,if so, glory be to God almighty. I'm very
happy to inform you, about my success in getting payment funds under
the cooperation of a new partner from United States of
America.Presently I am in uk for investment projects with my own share
of the total sum. I didn't forget your past efforts. IMF finally
approved your compensation payment funds this morning by prepaid (ATM)
Debit card of US$12,500.000.00Million Dollars, Since you not received
this payment yet, I was not certified
but it is not your fault and not my fault, I hold nothing against
you.than bank official whom has been detaining the transfer in the
bank, trying to claim your funds by themselves.

Therefore, in appreciation of your effort I have raised an
International prepaid (ATM) Debit card of US$12,500.000.00 in your
favor as compensation to you.

Now, i want you to contact my Diplomatic Agent, His name is Mike Benz
on His  e-mail Address (mikebenz550@aol.com

ask Him to send the Prepaid (ATM) Debit card to you. Bear in mind that
the money is in Prepaid (ATM) Debit card, not cash, so you need to
send to him,
your full name
address  where the prepaid (ATM) Debit card will be delivered to you,
including your cell phone number. Finally, I left explicit
instructions with him, on how to send the (ATM CARD) to you.

The Prepaid (ATM) Debit card, will be send to you through my
Diplomatic Agent Mr. Mike Benz immediately you contact him. So contact
my Diplomatic Agent Mr. Mike Benz immediately you receive this letter.
Below is his contact information:

NAME : MIKE BENZ
EMAIL ADDRESS: mikebenz550@aol.com
Text Him, (256) 284-4886

Request for Delivery of the Prepaid (ATM) Debit card  to you today.
Note, please I have paid for the whole service fees for you, so the
only money you will send to my Diplomatic Agent Mr. Mike Benz is
$50.00 for your prepaid (ATM) Debit card DELIVERY FEE to your address
ok.
Let me know once you receive this Card at your address.
Best regards,
Rev.Dr, George Adadar
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
