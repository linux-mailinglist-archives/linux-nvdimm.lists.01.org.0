Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F6B2C7AD9
	for <lists+linux-nvdimm@lfdr.de>; Sun, 29 Nov 2020 20:11:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2E5DB100EC1F5;
	Sun, 29 Nov 2020 11:11:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b47; helo=mail-yb1-xb47.google.com; envelope-from=3qvldxw4jddsyfixijloofpz0ydjxfi.zljifkru-ksafjjifpqp.xy.lod@trix.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-yb1-xb47.google.com (mail-yb1-xb47.google.com [IPv6:2607:f8b0:4864:20::b47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B3751100ED48C
	for <linux-nvdimm@lists.01.org>; Sun, 29 Nov 2020 11:10:59 -0800 (PST)
Received: by mail-yb1-xb47.google.com with SMTP id n186so13192986ybg.17
        for <linux-nvdimm@lists.01.org>; Sun, 29 Nov 2020 11:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:message-id:date:subject:from:to;
        bh=tBP5m1HdxHvk4zQrR7WW7cgTyRwh84Bh3mz2x4taqqw=;
        b=LCLYobB7QXHlc3qoq/Wk/ps0H4rhg5xGNlzy21vKN32Kdgs/xSNey8yMfhfR4DxIjT
         j62KzK1vfT4wxoZksprjmQg3oJMe5VDzhH5Trp4grwtDHXjQ3zcRovrFge48gH4a90DP
         6DnxPP/l5staNwNg2j5OgfLjyIpsOwSaMMI3YMRyUMKwiZX+Slik8qdZVkIskP0ctJ7R
         97OkpQLjtrWPfgu1FO9hhZ2xZSfR2e+RYwN6SftqWlR51z1qm6uMbtWivrhZcN/bW7a+
         LVECt7kumYnDxWB83UaHureqkDtJ3YrZNTKrDC1YSAiVOGJie2craSUKjuhAqNwjKrd0
         xq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:message-id:date:subject
         :from:to;
        bh=tBP5m1HdxHvk4zQrR7WW7cgTyRwh84Bh3mz2x4taqqw=;
        b=JhETVNALFNn+UTUW9i+DyGlHduW4FwV0mquhimwOsofyQ1a63DjSC0Pr99pdcGDZV3
         GeTxAzYklw/iPR07tYT3Ekw6qf9s4JrEtrQf0W8KRgYOA055vJkoF2Wg8OSnz+mTEDPw
         V5ezC0wUT//gPhW/LcrPDvILeW4G5J1mgfJcV4Ewb8eVEyhYKpO7zZptF7VVYwLO7vsk
         1v5S4qzUgMVxltbeIxhPmuf0bqpbb2Bdr4qusDMbSAjiP8JG+Y8S8YoGM6j7zW58x9ir
         zmZYVJGA+gMPMaAmLWFHBpW9NdQKIWaoOZ0K2kaSCqi6zjCK2M41A55tFMP9owsT5GQX
         5rSA==
X-Gm-Message-State: AOAM530T8mEP010l42mb4G6Xzd/FJ/dSc7gNA/EPEd71DHXyPCRTN3C/
	jw/1pPk4dAzmW6dLa7F1aMlbYC5CUWnrcSbhs0s2
MIME-Version: 1.0
X-Received: by 2002:a25:8b82:: with SMTP id j2mt20427379ybl.276.1606677058380;
 Sun, 29 Nov 2020 11:10:58 -0800 (PST)
X-No-Auto-Attachment: 1
Message-ID: <00000000000055789105b543a7a8@google.com>
Date: Sun, 29 Nov 2020 19:10:59 +0000
Subject: Congratulation! (Mega Millions Lottery)
From: bilalmorris231@gmail.com
To: linux-nvdimm@lists.01.org
Message-ID-Hash: NC3ZS3INKBWZD53UVU5OXF2LNNU4PNC4
X-Message-ID-Hash: NC3ZS3INKBWZD53UVU5OXF2LNNU4PNC4
X-MailFrom: 3QvLDXw4JDDsYfiXijloofpz0ydjXfi.Zljifkru-ksafjjifpqp.xy.lod@trix.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: bilalmorris231@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NC3ZS3INKBWZD53UVU5OXF2LNNU4PNC4/>
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
https://docs.google.com/forms/d/e/1FAIpQLSejitRsY0yrE6F4TILKy0bfmau43DYeveiXnH_uGVxYOKKetw/viewform?vc=0&amp;c=0&amp;w=1&amp;flr=0&amp;usp=mail_form_link

Congratulations You have won $ 850,000.00USD Your E-Mail Name Is Among
the Lucky Winners at Mega Millions Lottery Online promo, Ticket Number
(88910), For more information contact us Via Tel: +44} 7045746552. or
reply to this email: peterjeng042@gmail.com

Your winning reference numbers are PMG / EBD / 850AF and will Instruct you
on claim arrangements for your winning prize.

Please note this, You are only required to forward your Name and your  
Address.

Your Full Name.
Your Age.
Your Country / Home Address.
Your Telephone Number.
Your Occupation.

Thank you and once More Congratulations.

Yours faithfully,
Agent Morris Bilal.
Claims / verification Agent,

Google Forms: Create and analyze surveys.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
