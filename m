Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F030C156004
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Feb 2020 21:44:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A55710FC359A;
	Fri,  7 Feb 2020 12:47:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=cristinamedina0010@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2E20310FC3599
	for <linux-nvdimm@lists.01.org>; Fri,  7 Feb 2020 12:47:27 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 77so591523oty.6
        for <linux-nvdimm@lists.01.org>; Fri, 07 Feb 2020 12:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=8cDRXBFOpE9J1p6S5H+HXSQg9q3m7pUJ3iUuQ5MPcDc=;
        b=WJgFJ9PR0yBQ+ciD08Pby60OVZzn3dTgtieZ17slfRQssKmPnwQmAwZPgDIpR6heck
         dDY9m0nAiR73dL1CtCDLlqWI9lV6barO9i6phYUUcmMyI9lhyUunotwwGjtLNjZZXHps
         B+ZJy7kS8IDHqb+LatDXLkBcGkPTiMku+kX9Fb92ZmFsnK1n3liOHkc4TmrSz2VBzqpm
         gOXxQUuwBna/l8aq9nu864h1RGE/T5vMQdJwoV4IagKfmqrsTX7n4WpDLnLJobosvK0X
         9Z7fBUirFx02ZREq+PBFhuGxFcksAi/eOnsjoHpvtfcuXe3k+tw0qtyYWnKvHtkX+Drl
         CMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=8cDRXBFOpE9J1p6S5H+HXSQg9q3m7pUJ3iUuQ5MPcDc=;
        b=IJ9DgfgfolUnkykQc8aa8bK1X5J1zHkqm3k8A5eYZ6Qc0n+m+VUs2Cui1TMpuCa0Ev
         PJp7TYtBynIMEVQeYGMsEtON5lvwegYyLFIQbVdHRCxACmXUk7wuVyG5lwjO5RzFXI9j
         tphfjUdz0VeQiQyqPw2LunOpg5LbV3vD7zhXFbswW5LhJL6HB4hmf9Z27PohFsj43L62
         OKk5fQoyKpR95vMgQP58u3sahC9Mavftr4ITngqpVpylIW04N4nd5InzgXXZwP6TyOBV
         LzMslJHEIoIwztN14yfGZItiJ//TIA6CmdQu+XaeA6kXY1080yLiFgr1g/V4TYri8jxR
         MqSA==
X-Gm-Message-State: APjAAAWtVGvLUnPwaKePUVR8NWYGfFl9L942/Hs66x5e6k2KLX0lmt7s
	MzKzRuB5N0ZeB6d0oyuh+gll6/DfbDs7pY55bcc=
X-Google-Smtp-Source: APXvYqxZ0BHxezvYatUCwR5ujJY2IO6fZCUlpHww8WEnDHAAAY+0VvtiMdEe6JnWZWwDRH8AP8uVvx3q0Y+IviYPdhQ=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr948882otk.64.1581108248790;
 Fri, 07 Feb 2020 12:44:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:d508:0:0:0:0:0 with HTTP; Fri, 7 Feb 2020 12:44:08 -0800 (PST)
From: "Mr. Theophilus Odadudu" <cristinamedina0010@gmail.com>
Date: Fri, 7 Feb 2020 15:44:08 -0500
Message-ID: <CAPNvSTj-8q7w5QPmnH26+_3xCKjEWyE+9xcb8QyQs9Xie+iYgg@mail.gmail.com>
Subject: LETTER OF INQUIRY
To: undisclosed-recipients:;
Message-ID-Hash: RUMR7BHAYVTNOIPBL34UPCX44WVAM3XS
X-Message-ID-Hash: RUMR7BHAYVTNOIPBL34UPCX44WVAM3XS
X-MailFrom: cristinamedina0010@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: auch197722@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RUMR7BHAYVTNOIPBL34UPCX44WVAM3XS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Good Day,

I work as a clerk in a Bank here in Nigeria, I have a very
confidential Business Proposition for you. There is a said amount of
money floating in the bank unclaimed, belonging to the bank Foreign
customer who die with his family in the Ethiopian Airline crash of
March 11, 2019.

I seek your good collaboration to move the fund for our benefit. we
have agreed that 40% be yours once you help claim.

Do get back to with 1) Your Full Name: (2) Residential Address: (3)
Phone, Mobile  (4) Scan Copy of Your ID. to apply for claims of the
funds.

Regards
Theophilus Odadudu
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
