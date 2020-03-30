Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B1D1979C9
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Mar 2020 12:52:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E8CC910FC3795;
	Mon, 30 Mar 2020 03:53:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::e41; helo=mail-vs1-xe41.google.com; envelope-from=maryalicewilliams730@gmail.com; receiver=<UNKNOWN> 
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8D28510FC3792
	for <linux-nvdimm@lists.01.org>; Mon, 30 Mar 2020 03:53:35 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id u11so10711340vsg.2
        for <linux-nvdimm@lists.01.org>; Mon, 30 Mar 2020 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=82B0OONv9gwbZlPp43NzThDz2fRV+KRFwafOQ16joDw=;
        b=I2bZK+Edwp7f1bl38ZDsYZ8gkHoLOp7N+SgwKjOSdbsqnWhmYlKKFyWTTwwdBuA4Vg
         rwBHnP7ed1EksF/Uo6wi0daOtai1jA53B5b9RrMCwInP8fTj6xlf+N87Jxy7Sxa+QbUF
         l2GP0Lv6JzwuZiPJAzgKXNfvaR6mAHzPBfBvakflfZ8B4h5bL4zPFQy+qXgn4TFvbTXz
         A1ohkR077EumDiarvC1dhS/fXXyUHKbnnxfkdMVlwSlZiAQJvL50ZQklv05R+GT0yrBC
         3q/4vjuGZ1FGpK3Ogg0O4Ce18OqauZECfFoMpKCzkd0qt9LKtlmIkWUwZqPjuntycFFN
         I7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=82B0OONv9gwbZlPp43NzThDz2fRV+KRFwafOQ16joDw=;
        b=c9OmIwaIpJRhUPnA+zCPEUipJ2MUKbpxAGoUNJ6xjzrIirD1bDaLfjag+ufb86wMBV
         p9Wi+yXcfysTwwUrnkg54WAvWnW2D7ELR0mDL6corBJPb4WPcxiRRTuXUgiFETe8fuLs
         0G4/yetFfUxfle0hLnHwxckmGfZKb2wajWU7vVyxiwxt/k004S6ygerj2V3NxyB4TYVP
         TCemIc/Szc8br5CRFSe86kDeopH30hYzHGpI3SOoOcfbU1ZeTfXEuQOngsa0GLXGSGwn
         yrVKqR6VuCenaeFXg+gcS8W6b/5Q5Jw4w1W91/pp/r82gG+wNpCqReays6lw8guTSqML
         HbSw==
X-Gm-Message-State: AGi0Pua2+t+orx5TC1fFAWXCS7biyX0EYzK3z6g4XkmFUF2+eje7oJhN
	agPHJg4WJPdL2f4jRZELELmyNSNg1ua3IfwyZgQ=
X-Google-Smtp-Source: APiQypIWKERkhJyfw3nllppwlKx4Kg5tACX7YV91IKVmdYpKGJw8tan3l05zjbxOy64C+jzvYjD6e0YtF987t4KsIjw=
X-Received: by 2002:a67:e24c:: with SMTP id w12mr8442912vse.153.1585565563772;
 Mon, 30 Mar 2020 03:52:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:c005:0:0:0:0:0 with HTTP; Mon, 30 Mar 2020 03:52:43
 -0700 (PDT)
From: Maryalice Williams <maryalicewilliams730@gmail.com>
Date: Mon, 30 Mar 2020 08:52:43 -0200
Message-ID: <CAKwdjsr+YKgJk7z-UHX7Zo55cx5RUN3-bw03sWcArP4vbM2B5g@mail.gmail.com>
Subject: Reply For More Details.
To: undisclosed-recipients:;
Message-ID-Hash: I4QHTKUPFEQVJVOWXUIQX2SDKWCWNTCB
X-Message-ID-Hash: I4QHTKUPFEQVJVOWXUIQX2SDKWCWNTCB
X-MailFrom: maryalicewilliams730@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: maryalice00.12@postribe.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I4QHTKUPFEQVJVOWXUIQX2SDKWCWNTCB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

-- 
My dear,

I am Mrs Maryalice Williams, I want to send you donation of two
million seven hundred thousand Dollars ($2.7M) for volunteer projects
in your country due to my ill health that could not permit me. Kindly
reply for more details, and also send me the following details, as per
below, your full Name ..........,  Address...........,
Age...............,  Occupation ...............

Remain blessed,
Mrs. Maryalice Williams.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
