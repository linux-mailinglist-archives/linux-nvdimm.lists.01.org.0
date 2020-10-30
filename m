Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D28D2A0A42
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Oct 2020 16:49:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7ACCA164FC4CF;
	Fri, 30 Oct 2020 08:49:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::846; helo=mail-qt1-x846.google.com; envelope-from=38twcxxejdna2wxd407f3a8wevmnm28w47.ya8749gj-9hz48874efe.mn.ad2@trix.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-qt1-x846.google.com (mail-qt1-x846.google.com [IPv6:2607:f8b0:4864:20::846])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1A253164FC4CE
	for <linux-nvdimm@lists.01.org>; Fri, 30 Oct 2020 08:49:06 -0700 (PDT)
Received: by mail-qt1-x846.google.com with SMTP id d6so4248451qtp.2
        for <linux-nvdimm@lists.01.org>; Fri, 30 Oct 2020 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:message-id:date:subject:from:to;
        bh=upBallN9p2EMXqbXVKfQ7Iw18NmeaHyPq73hkSMMbac=;
        b=ss6NVvvSpBvi3jEZe4MxVTqEi/Dz/2iVrEYjJwEzZua4aFoXsSfpHHDAap6P2nBdbT
         D14uLkxfuH34eZLv7u2M2LZMjYxSG2hyNepKTf9QE4hIe/LYLP6tpSbOj8qcWZPmVCvA
         ho96epMF9iS4u8RbSYiyKOIG2wLNfOXgZMNhBy8CHVEUmUrUQNugZyAbU+q9oEIMp3WS
         4GsZ4s4kpIRkoyP2soGus870obmHUmwjyvuKSQKSvmH+kyZp3rGiV6sW9Qb3BuncRA9l
         KVH/HOf3DKM7NaOEvFMzzXhYcSdmzSixm+z7AOP1YXBmzOWlNf2ZXFtVK/3ws+3z6nTS
         4A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:message-id:date:subject
         :from:to;
        bh=upBallN9p2EMXqbXVKfQ7Iw18NmeaHyPq73hkSMMbac=;
        b=W+hnM5L+mdrWw/CuZYiJIcvtK9yPeWqI1PNvtHvMG9mq0Ansi1kF865cw6YQfZuJLJ
         oq1gvFEEWuAPXbJMDHk8reEPnRIX92AF4wdxhYVaNSqN9fJ9HGWzFv0sUazxhgplLhYD
         B4TNYPHJCPTZd/Anai/Gjijfp+G3wX32k0t+vmmJAs3hlltB+KDBKB6eNT3FpOHGGa4d
         mrJBvYlbG1t9Hfq/CY5QFlRuZZpYQ1stj9jnYFcBTj2MWTIqNb6Rkdx22BQxxGDi6ljL
         Pa7tnnk1Qsc0ALlfhQlSRBBRHydmxlmWGJ16o63/2FwbxcoKtLaf+nlaiqVbph1FEjyE
         DCAw==
X-Gm-Message-State: AOAM530edeePwYoh1jIdJGYopd1GZXsU++iLF7o9h67c/UZyAkZD6oK6
	ad8Miqgd7JeZm1BfSI18/jUszK92X8S+3MXbRvvb
MIME-Version: 1.0
X-Received: by 2002:ac8:1401:: with SMTP id k1mt2862152qtj.227.1604072945166;
 Fri, 30 Oct 2020 08:49:05 -0700 (PDT)
X-No-Auto-Attachment: 1
Message-ID: <00000000000017368605b2e55606@google.com>
Date: Fri, 30 Oct 2020 15:49:05 +0000
Subject: Hi;
From: gabrielthomas9010@gmail.com
To: linux-nvdimm@lists.01.org
Message-ID-Hash: V73JRHX73WMYMM547SRNH6KPC4DT6ZXD
X-Message-ID-Hash: V73JRHX73WMYMM547SRNH6KPC4DT6ZXD
X-MailFrom: 38TWcXxEJDNA2wxD407F3A8wEVMNM28w47.yA8749GJ-9Hz48874EFE.MN.AD2@trix.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: gabrielthomas9010@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V73JRHX73WMYMM547SRNH6KPC4DT6ZXD/>
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
https://docs.google.com/forms/d/e/1FAIpQLScuNN46De4NTNDuI_3Rm2L6CNABd5Ra0TyGG6ZxgVbAw2h7Ug/viewform?vc=0&amp;c=0&amp;w=1&amp;flr=0&amp;usp=mail_form_link

  Hi,
Hope I am not intruding on your space here.
If you are interested in equity or loan financing,
I would be glad to assist.
We are a private financial firm that acquires well established small and  
lower
middle market businesses with predictable revenue and cash flow;
typically partnering with industry professionals
to operate them.
We also have a Capital Formation Division that assists companies at
all levels of development raise
capital through hedge funds. We charge %1 commission at the successful
closing of any deal.
Additionally, we also fund
secured as well as unsecured lines of credit and term loans.
Would that be something of interest to you and your group?
Please let me know your thoughts.
Sorry if you get this message in your spam box, poor network
connection may be responsible for such.
Best regards...... Gennadiy Medovoy.

Google Forms: Create and analyze surveys.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
