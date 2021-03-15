Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5435433C292
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Mar 2021 17:56:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 86511100EBBD9;
	Mon, 15 Mar 2021 09:55:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12f; helo=mail-lf1-x12f.google.com; envelope-from=mrganuserge@gmail.com; receiver=<UNKNOWN> 
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 074E7100EBBD7
	for <linux-nvdimm@lists.01.org>; Mon, 15 Mar 2021 09:55:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id e7so58028578lft.2
        for <linux-nvdimm@lists.01.org>; Mon, 15 Mar 2021 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=nn1W9Wc+k1CJYE8WxkSJGXK0N+qf/mcCb4Whw81sCBc=;
        b=NFIKK+nfxU1Bk+3WCrU9O3MGPlJFWuI8pQsA4NO+khcy4IfqkRAKK0AWxN7+EKZoLp
         ZJdTuC+bpEdcdWNQ48J87QTkicfcXwM5vDqZ8THerD1aG4Htzvz9a8JuF6RyJkH/0P/H
         YgO1aQNpeqjVVeUnRQEq3uywJyLa3nZEYCEBnu4oOP+0oHYiPqvxycfJjg+Miw3Su0Ly
         Onkizp0dFVpKsHJYeRS3jOJIv2iHgnLZCWQKktBFLeEPOJEkBM6YPDst3Txzn97hyyCo
         2L0z4aN/23aR2RV7uI7XCiWyNGs6jwGUBK0c+VJVf2SO//1QRq75v2XWVIep95A54pTN
         yPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=nn1W9Wc+k1CJYE8WxkSJGXK0N+qf/mcCb4Whw81sCBc=;
        b=CtwpVT4o7NyO9jhSFSs1M1zrYIKkkRc4mdTSiLNhFUxCaV53JIbXlfQdcnCG3Pj+Hc
         4naC6m5qP+uSkkB41glcN0o6h3aWX5T7+iaEwqpvcdTqOC5bIMNGl5IfyrnYmNPqwpL1
         oRUx6FUnMEiqqAEA8gW5o1HQrDP9Hx5spr3W+V27GfPvTHtf0ZqQ/a/PwFkY2hgiz7Hu
         jAg4g9MVAXRsfIDu5Fsf+TxF6o0+ZXal55grYxgdsGYV/qBFkzOoshbEgqPQHZXjMp/W
         3T8ziYvdmtbalwKji7HL3CaDxXV1keM8JE0Ac/mkzk9KklhgG5VARbMlifwavP2uzG0d
         DWog==
X-Gm-Message-State: AOAM531nDRkqVsDFL4weGZApSd2FGHCczBKOk/yrnB88fgsQS2+0PKqO
	jVLrqd/FrWnbNOnnD2VThzLX32Vhempj32Sn3rU=
X-Google-Smtp-Source: ABdhPJyti9j1xbG7VWGMZ7aPtd7Btkjs1GN0IVYGnPzacRUiAM0k8HHHlBfAb/Fiz24mX/Aiqm6jmarQAvIoeTz7Yr8=
X-Received: by 2002:a19:c309:: with SMTP id t9mr8176362lff.348.1615827353222;
 Mon, 15 Mar 2021 09:55:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:651c:1382:0:0:0:0 with HTTP; Mon, 15 Mar 2021 09:55:52
 -0700 (PDT)
From: "Mrs.Glenn" <mrganuserge@gmail.com>
Date: Mon, 15 Mar 2021 09:55:52 -0700
Message-ID: <CA+Wfa7YVrx0ws3646y2_O1kPsYemM7JwcJJmf2b35t-FLHsF1g@mail.gmail.com>
Subject: From Mrs.Glenn
To: undisclosed-recipients:;
Message-ID-Hash: VGD2YINY3XPUH2WVOVGQP5XY66DWXELG
X-Message-ID-Hash: VGD2YINY3XPUH2WVOVGQP5XY66DWXELG
X-MailFrom: mrganuserge@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: ezbtg22@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VGD2YINY3XPUH2WVOVGQP5XY66DWXELG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

-- 
Dear Beloved,

I am Mrs Elizabet Glenn from Israel. I am a missionary but right now
in a hospital bed in Israel. I am 59 years and childless; my husband
is dead. I was diagnosed with terminal cancer. And my doctor just
predicted that I have but very limited time to live due to damages in
my system and as a result of that I decided to dispose my 10.5 million
US dollars to a God-fearing one for the continuation of charitable
work. This is why I located you.My guess about you may not be accurate
because I came across your contact at the humanitarian calendar event
of the year but I believe in God who  divinely directed me to you for
this solemn proposal of charitable work. I wholeheartedly wish to
bequeath my fortune to you as a God-fearing person for the
continuation of charitable work anywhere around the world.

I shall be going in for a surgery operations soonest and desire this
money to be transferred to you as I do not wish to leave this money in
the bank because bankers might misuse it for their own interest after
my death. As soon as I receive your quick reply assuring me that you
will utilize the money as I instructed you for the benefit of the less
privilege, I shall give you more details and also instruct my bank to
release the money to you for the charity project. I hope you receive
this mail in good health.

Because I don t know what will be my situation in next minute,

I am waiting for your reply.

Yours sincerely,
Mrs Elizabet Glenn.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
