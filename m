Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9CD20A01B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Jun 2020 15:36:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8279410FCDC93;
	Thu, 25 Jun 2020 06:36:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::e41; helo=mail-vs1-xe41.google.com; envelope-from=ginathompson2034@gmail.com; receiver=<UNKNOWN> 
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1FF4510FC54C7
	for <linux-nvdimm@lists.01.org>; Thu, 25 Jun 2020 06:36:43 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id f24so3567259vsg.1
        for <linux-nvdimm@lists.01.org>; Thu, 25 Jun 2020 06:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=AsfmWHlmY1hf5RoZsp1JqUwmS/HKOOtA25m2BINWtYU=;
        b=XdDapqz52RH1WXf/C2bSo5WDMujL+hIMybFHCZCmPe0OXiJY//L1awfT5BfQzRZWbp
         c4hEiZ3OIvnDk7gc+m88mSMhV9TZUzGxSBqyBiZjOeh3PDmkt+gTNsqGrr8mSvkW8Z4o
         Tceacl9fTXXYxGPVefCUQzW57eYAAGpRarJhiSv7U7in6/1gYF7Ue5jwcs1VzY8edCwl
         2F+lcMV7WmHRbIC+heG4pHpUpSwdrdJIzCowjUyYGXDEIYrqfV1SUa0w2Xt9Db5PHrM+
         qLmQNUshOp6kLVb4zZGPwnMPnm/7N2XTTo7712dQplLjnMLv+3vNN6O/Q1nd/n5RRtwo
         5YwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=AsfmWHlmY1hf5RoZsp1JqUwmS/HKOOtA25m2BINWtYU=;
        b=gh+EjLzxvTNCPIFOLQbU9A4puDsfh9VkNrN/K2hmAcJYBQU4YJeEQT2+Qink+Xs8Md
         oO+JJGpzRecBmurMPdt8rRpFAkC+F1gZ1cwkZPNIrCEIQzsAYdOAvrWT7CRPx58c6t2l
         8at6QphhfThgYbt13ZTcGONzI9fPu26KY9ToGbnCGVIQ7TBF2DfnJvuyL38mKKVqHb+p
         lL1Q5i9ry1Xs6hRp3cPgfy24zBdYuVQPg5i1Wbr65xA+8zPnCCxuBl1kFBfjIgcouMSD
         3U0PK3/qTA3rocvI5dnLUmLKDlGJqztpW9aJtEcNs3gN99BIjq5n/VmajJhUh2POwXtD
         5GDA==
X-Gm-Message-State: AOAM532L0/+T8d6ChuMkoV4wXpubgu+MSkDjEPxY3GCofFydq0O2kfqQ
	9LB+98kJSdr2+muJLxttAVUrG4a+3ZR7LIjH/W8=
X-Google-Smtp-Source: ABdhPJzoXRu8od47h8I5E7BVk+B7iRIuQP2P/EbQwOgPtnPRWT+mQ/efLsbKdGEHEAVZontqZujAE8/waRtoYFYtz2I=
X-Received: by 2002:a67:8b86:: with SMTP id n128mr30298692vsd.59.1593092202953;
 Thu, 25 Jun 2020 06:36:42 -0700 (PDT)
MIME-Version: 1.0
From: gina thompson <ginathompson2034@gmail.com>
Date: Thu, 25 Jun 2020 13:36:25 +0000
Message-ID: <CAHBJkWF+SV8oizaA+BkXiVCXZA=rATxJGaFE6j8siCGjRs25Bw@mail.gmail.com>
Subject: GOOD NEW FROM GINA THOMPSON!!
To: undisclosed-recipients:;
Message-ID-Hash: 76ZVTQBMYJRILFOWV2WHODJ46OKIF6DL
X-Message-ID-Hash: 76ZVTQBMYJRILFOWV2WHODJ46OKIF6DL
X-MailFrom: ginathompson2034@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: ginathomson@ukr.net
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/76ZVTQBMYJRILFOWV2WHODJ46OKIF6DL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Mrs. Gina Thompson
Manager Accounts/Audit Department.
London United Kingdom,
2000/2020 SCAM VICTIMS COMPENSATIONS PAYMENTS.

REF/PAYMENTS CODE: UBA/ZENITH BANK/055740 ($950,000.00USD.)

This is to bring to your notice that we are delegated from the UNITED
NATIONS in Central Bank to pay 150 victims of scam $950,000.00USD. (Nine
hundred And Fifty Thousand United States Dollars Only each).You are listed
and approved for this payment as one of the scammed victims to be paid this
amount, get back to this office as soon as possible for the immediate
payments of your $950,000.00USD. compensations funds.

On this faithful recommendations, I want you to know that during the last
U.N. meetings, it was alarming on the money lost by various individuals to
the scams artists operating in syndicates all over the world today. And In
other to compensate victims, the UNITED NATIONS Body is now paying 150
victims $950,000.00USD. USD each in accordance with the UNITED NATIONS
recommendations.

Due to the corrupt and inefficient Banking Systems, the payments are to be
paid by UBA Bank and Zenith Bank plc which are the corresponding paying
bank under funding assistance by BRITISH GOVERNMENT via ATM CARD, which
will be delivered directly to your doorstep by the FedEx Dispatching
Officer Mr. Edward P. Ambrose. Also, the benefactor of this compensation
award will have to be first cleared and recommended for payment by the debt
settlement office.

According to the number of applicants at hand, 114 Beneficiaries has been
paid, over a half of the victims are from the United States, we still have
an outstanding of 36 scam victims left to be paid. Other victims who have
not been contacted can submit their application as well for scrutiny and
possible consideration.

Please reconfirm to us your home address  to avoid any wrong delivery such
as:- Reply to Email ginathomson@ukr.net

(1) Your Full Name

(2) Your Home address
(3) Your Direct Phone Number
(4) Age

We will advise you on how to process and receive your payment within 48
hours as soon as we get your response today with your reconfirmed
information as requested above.

Response with the required information for the immediate release of your
payment to you within the next 48 hours.

Thanks for your co-operation.
Respectively

Mrs. Gina Thompson
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
