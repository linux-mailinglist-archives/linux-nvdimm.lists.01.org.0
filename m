Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C17BD322684
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Feb 2021 08:43:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 546C8100EB32D;
	Mon, 22 Feb 2021 23:43:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d2d; helo=mail-io1-xd2d.google.com; envelope-from=rivaldosetiawan135@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4353E100EB330
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 23:43:02 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id f6so16096956iop.11
        for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 23:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CmKGN5Ru4r8wFKoP0tKO3TvMVfMZ8d48HwPHad1R6KQ=;
        b=LWNbNazuGZjPyiDtZsqczPQUx+omFv5O6a8fiCIQlnBCutJpT4WM3/rgyiFSGJ3DT9
         tPAacXCLBZ3vMHJ0hadymmeSMlO7Fi3aCfnmfhHqZ99DAmyZrUTlRWw5Bs9GdADMWRFh
         SYLCGG2uGiOWDDznR9eqJO9qFeDjGjX8u8gFhqVHbU7gpcurE357D8lg/D1GYpXKEITo
         yIex19Ex/mVHjoMFe86gKXJED/RUizWigADSrSDcIpRloMAkSQwqn7StUPQdG916rspM
         bu6uqYdl/HwQk2Gdbgbctwzb8jhva3kxQI8loC6nFHrzZF8H/+B0TOySeXog/cLV4FAS
         U54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CmKGN5Ru4r8wFKoP0tKO3TvMVfMZ8d48HwPHad1R6KQ=;
        b=LYlv4f6SIXrbKg22Y2MHuuYuYpaXpDdvs5pCa0fBUsNDFtxCRC37Klxqo/G91zqaZc
         u78XX30mJvhOF6JttM9M+WmCb02YxQfGQhDTItEguq9wFlKjcfutPktAlsYFbc98WYHW
         kMpg55w07EhTcMD3cW1V5YgCV230puIO4Cpdt4ettHtwjqwXt8W5LnQ3vkYrwSU4Jb/j
         /GahYLu5O2mezs4H5oWqqAkI0KAyx39p6THlaaPbmihdV40/WB3o2V1FLseCYMloL934
         f36Y79hjAv2/rF6W2A5p+9NG20z/mXsIilere1ACTTqufVYX/GL3f8YYEbObJoBRvlsb
         mZ9w==
X-Gm-Message-State: AOAM531DNXdO1l2DJDqFP5z209fPIZm9FQVAqOUqWPrivd6JqZ8toxu6
	X4rFp+yRPiYKFz1Y8VF7obnu2EBBqxyXw8jXNPM=
X-Google-Smtp-Source: ABdhPJwhgzeOD6xkxXZl2PfbeQm5g9GMIbXdGTipm6eazioZWSWwT3LA9uRAtTl7JTgZUPuRPMyETDeiH7aOKa+6KKQ=
X-Received: by 2002:a5d:8617:: with SMTP id f23mr18885087iol.90.1614066181402;
 Mon, 22 Feb 2021 23:43:01 -0800 (PST)
MIME-Version: 1.0
From: R Samudra arc <rivaldosetiawan135@gmail.com>
Date: Tue, 23 Feb 2021 14:42:49 +0700
Message-ID: <CAP08ep2FKrVJS+GvJsRi=LN8ZPvC-eq4wS4atAejiYDppsme0g@mail.gmail.com>
Subject: Re: [PATCH daxctl v2 5/5] daxctl/test: Add a test for daxctl-create
 with align
To: joao.m.martins@oracle.com
Message-ID-Hash: HTSPHQEAD23VONVS4NQORBIVOB7CMOGT
X-Message-ID-Hash: HTSPHQEAD23VONVS4NQORBIVOB7CMOGT
X-MailFrom: rivaldosetiawan135@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HTSPHQEAD23VONVS4NQORBIVOB7CMOGT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
