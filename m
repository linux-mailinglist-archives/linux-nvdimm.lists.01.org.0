Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DEA312DA1
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 10:46:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D5CAC100EB842;
	Mon,  8 Feb 2021 01:46:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=tommiirrrch@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 493DB100ED480
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 01:46:30 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m6so9383518pfk.1
        for <linux-nvdimm@lists.01.org>; Mon, 08 Feb 2021 01:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=z7Z/JdX0RhrlgqchmamXWMY47TIIKUp5Zm0+e0J1lMs=;
        b=EBAN8kT/RdDTitIJIwHViEDhHzNJv4CIWk9rs6YltTkWZ458GA493YyOdSoiZ3kf2I
         cdNbMkg2fZDvPvkuycg7WSARNJ/puPrDyOFIWKtgjChKMEIfkIP2Q2XVpBk+DA9Lhucn
         6XQlMQaKQZVW2ZyZN5QBK8n9vbP0QwsOuCEl8YnAfifh/FxrfAzpfX38semmARrCGxh8
         WFi+25A8lhFcplpes37lwhh0IayXXJWFPkoQ+knUplL4fyj/9WvmsAavsN2O11FqYU0q
         sXGcgyuoksh1FLpl3IVpUWra/8A8W9zD+TSlCF6rCGoTQRx8E8R9VquYNvg3vN5bAAWe
         XSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=z7Z/JdX0RhrlgqchmamXWMY47TIIKUp5Zm0+e0J1lMs=;
        b=M6Asqo8ImaTb+ZpkcU//Qex3I/r1ckcXkOllY2+LTnXgpcW77lP+ILD6Qrbm0i+y3a
         T7Zw8CuObmTSlAtmjlq/zH2OTOLy0MEmGN07V9SXeVJMlSlLr0U2Jm9RVblgYQ9Tf/vZ
         ClV/tOTl/oVUi2qQgcHS9H154en4JN+tvWfYxk49crJONav2D+tpHmHqnmXGwfQmxxdg
         iiImrp9v0F5HNrA/WjFrRC68CjjfEVO6GRWZOj0Nz5MvqISu1I5BMthesOi2LmtiRv2z
         35jab0H9Dwo/g9eC2r7olLVdN8N6FAzYmvdBSMwKifLwjebQ4fQP/Yieq3sNeKsUwQZ3
         7h3A==
X-Gm-Message-State: AOAM533aB7lON5BhcHVLLnm6oENXDssMZrEIJY90nrWYPgM030or/1vO
	aEjTeQNlWkZENa/aC6dvvgG1+2Rhmguj3QH65D4=
X-Google-Smtp-Source: ABdhPJybDL+KhCvXPDIs57vnx74bKnUW7LRfIk9mtYaX6Td3ETIAJUIor6BltYlrl2tm2rDxnhIvTg/8Y9D/vq+/hVc=
X-Received: by 2002:a63:c84a:: with SMTP id l10mr16253996pgi.159.1612777589348;
 Mon, 08 Feb 2021 01:46:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:90a:5d0a:0:0:0:0 with HTTP; Mon, 8 Feb 2021 01:46:29
 -0800 (PST)
From: "Mr.Richard Thomas" <tommiirrrch@gmail.com>
Date: Mon, 8 Feb 2021 01:46:29 -0800
Message-ID: <CAGbSTZMAc0EF+BT96=ag5apRs+Aauw-A-2pin2QX1dEQy+tMew@mail.gmail.com>
Subject: Re Thanks.
To: undisclosed-recipients:;
Message-ID-Hash: XR7GVA5XWTLO445A25HYCDUKRLYL4536
X-Message-ID-Hash: XR7GVA5XWTLO445A25HYCDUKRLYL4536
X-MailFrom: tommiirrrch@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: richadtomm@qq.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XR7GVA5XWTLO445A25HYCDUKRLYL4536/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Friend,
I will be pleased if you can allow me to invest $104M Dollars in
Estate Management,in your company or any area you best that will be
of good profit to both of us

Please do well to respond including your information for more details.

Thanks.
Mr.Richard Thomas
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
