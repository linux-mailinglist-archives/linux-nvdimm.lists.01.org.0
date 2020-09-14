Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D338E268AB0
	for <lists+linux-nvdimm@lfdr.de>; Mon, 14 Sep 2020 14:12:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C98D913FDE40F;
	Mon, 14 Sep 2020 05:12:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com; envelope-from=dhlcouriercompanymiami@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A7A3F13FDE40F
	for <linux-nvdimm@lists.01.org>; Mon, 14 Sep 2020 05:12:10 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k14so1403362edo.1
        for <linux-nvdimm@lists.01.org>; Mon, 14 Sep 2020 05:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=gxYQz48aGorfvze6exW0FuIKKJvVhs5z+cRnEenJUaY=;
        b=cPk7UQKPAY0niCC6TT/oxTcpG9PIqKuJjnFPhX009+46qVktiRiBKwDBcFRtrWEs1o
         1xFbX7WY2jqSEjRbFHVe4t/wUIE6CTFZxqDPJJ1CDk8fInyxRi3MX1nCr+zDlg13hFie
         7doyZvJE/Yi6MLdh9kCGahrbMB9ndy16NeuJZOcD58EqroamjeuwAkYuVAmAJbaxmPSG
         VDG4+iZXzl1VwJ5ehrIM2SkcpZEpr6I1W1LK/aeNlrGRtPxsQm8a+fhqXC7ZmlSBQrKk
         u/8iSae7nzJg2hXHqZ6Jka3y/FUzDduN2HiBKCWk9yHfhPoNjDXpgyCdPC/dcFMH+Pbn
         zooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=gxYQz48aGorfvze6exW0FuIKKJvVhs5z+cRnEenJUaY=;
        b=nrAIfF5aCJYZDXCJG4UAOC2r5QQPbJcxwwzC3GkxFvlqloT/EiEsN86+VG3qwScRNG
         PRVovvwBDpbdTWh8rqLYUk17mRc5aR/NHyIln67hBe1Ps7MpyT5ldNNQQx6KMpKJbwM3
         Dfp0g9HYaPsnw6PJOt7FQoMYmbqWVHAGd83/XZKAqLgc5UePvL5922uq1291e562yqrj
         jFMtM+/yT6Q6YTZoo3xUWU88zOZ3RYLyy4g3PA0VvVFRV7vLmRlBRtp8ifGeqAfOIQWw
         1c0Kvpn7j8vhNsSihSLr/WG8oZgtT9yghUIbfGXgMgwKhD18ya7UMVMY7qcdLfuIyHHM
         I86w==
X-Gm-Message-State: AOAM532h8V5M2UGiH3LbqdeaYGIbhgyo6HjBJtgqH53BOIdAhzNoLddg
	hBDMuc45rRe2376liSWLKoKRVpPWHyH3rUFwC78=
X-Google-Smtp-Source: ABdhPJxZz1oFec8IgYwjxdPSB+qicpvrLFlZS4jLHZckqIY73ppaLdSbxRoFMaVkJ4G7dB1zJybtU3kR3TkSTMXhYq4=
X-Received: by 2002:a05:6402:483:: with SMTP id k3mr17175269edv.24.1600085528853;
 Mon, 14 Sep 2020 05:12:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:6945:0:0:0:0 with HTTP; Mon, 14 Sep 2020 05:12:08
 -0700 (PDT)
From: Ms Mary Mcniff <dhlcouriercompanymiami@gmail.com>
Date: Mon, 14 Sep 2020 05:12:08 -0700
Message-ID: <CAG_Oktof2_498qkjG+mO797FoacJjAguWDbkUTYfcGTEHEQ5QQ@mail.gmail.com>
Subject: Your Respond ASAP
To: undisclosed-recipients:;
Message-ID-Hash: 6OKZRUNFELEIUDW7FM2X2OSVJH4OVAOU
X-Message-ID-Hash: 6OKZRUNFELEIUDW7FM2X2OSVJH4OVAOU
X-MailFrom: dhlcouriercompanymiami@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mrsmegwilliam6@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6OKZRUNFELEIUDW7FM2X2OSVJH4OVAOU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

-- 
From Chief Compliance Officer, Citigroup Inc CITIBANK
388 Greenwich St, New York, 10013, United States United.
PAYMENT CODE: FRB010
Swift: PTBLBXXX
==============================================

Attention: Beneficiary,

We write to inform you that Series of meetings have been held over the
past 2 weeks with the Secretary General of United Nations,U.S
Department of State and Dubai Union Organization this ended last
week.And parcel is under our custody right now, It will deliver to you
within 24 hours once you clear the charges which will cost you
according to the BANKERS COURIER SERVICES that wish to deliver your
ATM CARD card to
you immediately.

However, it is the pleasure of this office to inform you that your ATM
CARD number; is 29741733 and it has been approved and upgraded in your
favor .you call me for the pin code numbers. The ATM CARD value is us
$10.5 Million only.

Kindly contact the paying bank for the claim of your ATM visa card
payment fund $10,500,000.00 through the below contact information;

Contact Person:Mr Williams S Young
Director of Financial Controller
Bank Name: CITIBANK
Bank address; 388 Greenwich St,
New York City,10013, United States
Email:mrsmegwilliam6@gmail.com

Reconfirm the following information?

(1)Your Full Name=============
(2)Mobile Phone Number======
(3)Current Home Address==== ====
(4)Fax Number================
(5)Passport/Drivers license ======

Endeavor to keep me posted once you contacted the officer in charge
through the above mentioned information.

Your timely response is highly appreciated.To this end, you are
required to forward your payment information as follows to enable us
load your fund into the card with your information and deliver it to
your door step. as the BANKERS COURIER SERVICES are in charge of the
delivery services to your destination.

Yours truly;

Ms Mary Mcniff.
Chief Compliance Officer, Citigroup Inc
FEDERAL RESERVE SYSTEM.
Email: marymcniff7@gmail.com.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
