Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D04F31608D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 09:06:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1E7BB100EAB43;
	Wed, 10 Feb 2021 00:06:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=zoueramama@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E0DF5100F227D
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 00:06:09 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d13so784348plg.0
        for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 00:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/0aCRHWtWFpd8qwJ7XC/WL6q5q7heg/nHjQPf8xaKIc=;
        b=Nki2PzmeJfmqJ1a8vx3A3TCJeOqUo7VDP5MjJK+XOnELis7dOQ12VK0fBalai4PAb1
         OtE18k0MRq/ik2otNUOFcK9tebX41ZauHs8GGUQH76J7fEOhwibIPZlDfZb2zvglgQmC
         LT7Fe1yjpJNtEVdv0+syaw2HGE/YEyDXc9rx4Pg2SK6rNeg6Wq3OTRjLO7HVdKPauXL+
         J0S34WKlcBE1K9E3YDk/aN/7wQKpbNPuySGbn+ecFW1J4cm1JVwMqexp7K7lrx8l4cgZ
         9zWHKCeZJdUC0/ICNJC1k//pK0HVg96r1le4OxuOZfGaQooV8I5c+1gaB4EyPnaXzsus
         h1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/0aCRHWtWFpd8qwJ7XC/WL6q5q7heg/nHjQPf8xaKIc=;
        b=KnJPxIg0741wa855ooM1hhfir94Pp7QDsoF9RKV9wqwLM0TZM696SJjIiBeEPEGwYk
         9o6SOEut/sCOYMWgSbDxIhQad1IJ+mGFr22+6KKWrkyd5dZlVqNQzkb6PGX9aiUjShVE
         WnA163aIrPKntzVYZK19uVnvOgVwRbKgVIWcZ75DZaZPQkw4ixIXhAJYqIyesH4PYPAd
         8mOzsk0x+bBOCxVsMljWLQzcLPxzXlXFynns3GI9xkCj5Vxq7Qc8qb1MvKGIlVmJttN0
         0Cjgpyo8XPycYhKfR/EDe+dsytU5WoH8PPBMCiUMQAI6YJo0h8w87jH0tlhv52LTTxkO
         ++0A==
X-Gm-Message-State: AOAM5303jVUkp4QStCy+u4pxq/7Ee/1jKyrhgw1vIT87f/Tva8aRxU3n
	nrnVXidTqpGsvQQtD/ryjFWhQ9c2YH0o8XIATMU=
X-Google-Smtp-Source: ABdhPJy1B2laa/3agR7ZvELcriRqO3+Xui38Uu4+I18cif9zQ6Lk9AesD91akiN4pizv1LkXLKIQnEppSNupBFhJ150=
X-Received: by 2002:a17:902:9b90:b029:e0:6c0:df4f with SMTP id
 y16-20020a1709029b90b02900e006c0df4fmr1911331plp.60.1612944369219; Wed, 10
 Feb 2021 00:06:09 -0800 (PST)
MIME-Version: 1.0
From: Lieutenant emilio soto <lieutenantemiliosoto@gmail.com>
Date: Wed, 10 Feb 2021 08:05:36 +0000
Message-ID: <CAPxJFwa2X_oVrKT3LhseL=D_qkOvTMU3jsfQ5DyAL3Kuu=4UqA@mail.gmail.com>
Subject: 
To: undisclosed-recipients:;
Message-ID-Hash: 4NT6HVWJBS36F4COKEQS3SBZQVZNHUZM
X-Message-ID-Hash: 4NT6HVWJBS36F4COKEQS3SBZQVZNHUZM
X-MailFrom: zoueramama@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4NT6HVWJBS36F4COKEQS3SBZQVZNHUZM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello
 What a wonderful day, can I talk to you please I want to talk to you.
Emilio Soto
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
