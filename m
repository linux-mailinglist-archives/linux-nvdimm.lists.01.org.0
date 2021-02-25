Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7875A324CE4
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Feb 2021 10:33:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E8F8100F226D;
	Thu, 25 Feb 2021 01:33:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=sgtlisasgtlisa022@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ACC96100F226B
	for <linux-nvdimm@lists.01.org>; Thu, 25 Feb 2021 01:33:53 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id t26so3421361pgv.3
        for <linux-nvdimm@lists.01.org>; Thu, 25 Feb 2021 01:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PgToqvIJxXMVQUqbnA47Q3CgNtMXVZPw4XHkSzrxjPY=;
        b=EoK5uGxNAooqERM0wzSJIC+AzW+OPLYFWe2gvaMZgtU7Sp3f5b9Kjg3qPuc0w2wMkc
         5ehXMEjYTsSgK3NP+f000DRKkOrxWI+OSvB+tGVPBQPNwJZO3Cms+hncIeU+SqCKIGNe
         YVzFySLLkGHyEUx9QwepAT1UqSV+negDbPUvMoXOYRP9S3t/9V9teawuUBVRUDv+Orwz
         FSnibxlItTnwpIbqjSW+K2gMMcMdXeFZCnXewhsJG14QWGT1FsVK17q0dmLVEQXpZF+z
         boWr0iBlgorZM+VVudgyFVXbR5GUAl85NLy4QDGco126beHSPFdQMGBiYCcBC9R36OK7
         6iyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PgToqvIJxXMVQUqbnA47Q3CgNtMXVZPw4XHkSzrxjPY=;
        b=ODDgR3s5ukn/TD7BfhqC6ijhtchvojm4YQ1zlGpB7GEbpjp74Uy+N9A4R/jQEq+Wuv
         HwTNgMNwsGUHeEBJ8AOAB61n5SM4w74yArWwCMJf66/3gguR3UH20Tf3GgMmvWXLOUdg
         7uux2Sn+2LsB+orgR527ST932DEhj98x5FwtM4ju8xKx8KfkvazXtQPydK3Ax25Q4UnW
         EWG5jSRxt9uf2zkv8PW0Tzg38N2UWPyt99ANYqXcUfKF2MfXH9rMmv2VAKkAyTN1356v
         JCp6oOZoF5ROR6YpX6mmqwkkJ1MDSDfcITUPXrh7z1LxCT3YZ1oVwjPlPMDseVZ0TNDc
         iYMQ==
X-Gm-Message-State: AOAM530R+GT7AjfR/OsAaAYwAK1KPj9FB/w387ss5gQ3r+hrCVs2Qw88
	3+mgfCnbTvUWd/2eR+77YD9vFqhl5TmwFRxP4J8=
X-Google-Smtp-Source: ABdhPJz30XTc1102fDvmW+pRsyCGn7qbaREko59Vt+9lfecPdSV+/TmFbuU1v/a2u8mWsN+hO/83EA7JLDVvuyi7SFU=
X-Received: by 2002:a63:fa50:: with SMTP id g16mr2336748pgk.86.1614245633223;
 Thu, 25 Feb 2021 01:33:53 -0800 (PST)
MIME-Version: 1.0
From: "DR. JUSTICE  THOMSON." <justicethomson1@gmail.com>
Date: Thu, 25 Feb 2021 01:33:41 -0800
Message-ID: <CABXfhsvWYKVgPWEa7Tu+z0p8w=--mOBZthHP+C4BXQqMS=_bVA@mail.gmail.com>
Subject: Hi
To: undisclosed-recipients:;
Message-ID-Hash: K4Z6RBRTK6MSRDUCLKEAPUUJA446UZV7
X-Message-ID-Hash: K4Z6RBRTK6MSRDUCLKEAPUUJA446UZV7
X-MailFrom: sgtlisasgtlisa022@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K4Z6RBRTK6MSRDUCLKEAPUUJA446UZV7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I have a good news for you.Please contact me for more details. Sorry if
you received this letter in your spam, Due to recent connection error
here in my country.

Looking forward for your immediate response to me through my private e-
mail id: (Justicethomson1@gmail.com)

Best Regards,

Regards,
Mr Justice Thomson
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
