Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799A92308E7
	for <lists+linux-nvdimm@lfdr.de>; Tue, 28 Jul 2020 13:38:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9625912680708;
	Tue, 28 Jul 2020 04:38:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com; envelope-from=pdlarsen550@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A39B212664311
	for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 04:38:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r2so12874464wrs.8
        for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 04:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=z88eUg589kIPbwfcJkBbHKFa4QR0wOZWGk2diK1jFPM=;
        b=b8/14qSmtpua6DExDbiZQujm3FVCJQWOEnGYc8m39CT4QhCFHb7H/8m/Mr+GJhki5y
         D26KeL8e5wwIhpqswED7Iyj8LNXjLx29RYfhZ1pPRjvkmM3zHNDeTF1tCFcQE9cmRh/R
         raunFxUrBwUmVbHiIcNmDsAsXlg0feXUzfnq5cUO9m3PCR65DPFX0ENqSsff92XlzdML
         2lZ1DHEdMBJRJ7G/JmLQNbN9a0xCfCCdIavasCRbfc1GMLbxrWB9YQiD4Jx827i+wgQH
         uvPy2fXgy98qEeiaY5zYJY4YAm1gQLhdwyYSQS3qfKNnqXIVHUgDrgxJy+XFocnlCNnt
         WweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=z88eUg589kIPbwfcJkBbHKFa4QR0wOZWGk2diK1jFPM=;
        b=Ue/SIBhG4awS8RZV81Igd2HFeeAAmnzRXpdej9IAXHZyA/aUwEh3VXnwA3BmIwlO6g
         TtG3dLWToXnMMg1YFRSsEG6msWYfsqgShBYjVberm3fzfAyYjUWAAwB3Olh5q2KPZpJl
         iDM3xSpZBZggipF5uxtLCvauAXYLtejNVDQvfXHOvIXoCvYrQxJs9BxBOmQGt5AY362l
         bI08a8EpLgsDXJJQ+nxYaSssQKWPlrovGIlvJwJTFy2SL8dtad9Tz5udD7l8pcm5PrDO
         C9Q9vddMYMMJixF5DpKBNKqqXc1k21P9a6z51b21pbMqhgAPm5SghEJmF1Di615YybjO
         ny4g==
X-Gm-Message-State: AOAM530TCLOJgF7Vsac9YStxivTpWLkT4VasbvYk3uwyrh9d7buGijNt
	OJCvDs5ikWy23ZBH7NXI9LfIW7L7lg53Ti/lR04=
X-Google-Smtp-Source: ABdhPJxf3Z6j28ZJZ91yE+38HygJgiTtZMyB/VSeYng0agg0J+nv4s0qzz48SwEN7D8BizofBLS128ELYqeZWTC2zc4=
X-Received: by 2002:a5d:5746:: with SMTP id q6mr24649773wrw.59.1595936294234;
 Tue, 28 Jul 2020 04:38:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:65cb:0:0:0:0:0 with HTTP; Tue, 28 Jul 2020 04:38:13
 -0700 (PDT)
From: Rashid Al-Wahaibi <pdlarsen550@gmail.com>
Date: Tue, 28 Jul 2020 12:38:13 +0100
Message-ID: <CAE00X2F5SUiQf0qCZYq3Yx353S0Esu1hA3RH4THqOM0WZMKHFQ@mail.gmail.com>
Subject: Your Partnership
To: undisclosed-recipients:;
Message-ID-Hash: SZS2EI3LXKZK5MS7M735GT3BR67QMLKS
X-Message-ID-Hash: SZS2EI3LXKZK5MS7M735GT3BR67QMLKS
X-MailFrom: pdlarsen550@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SZS2EI3LXKZK5MS7M735GT3BR67QMLKS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

-- 
Good day,
My name is Rashid Al-Wahaibi, I am from Oman but base here in the UK
and a Managing Partner of BP Partnership Ltd, a Financial Consultancy
Firm with office in the United Kingdom. I am contacting you based on
the request of Ms Rosmah Mansor Najib Razak, wife of Najib Razak, the
immediate past Malaysian Prime Minister.

I found your profile satisfying and decided to contact you based on Ms
Rosmah Mansor Najib Razak desire to invest in any viable project in
your region.

I need you to guide me on the type of investment that will be of best
interest and provide good return on investment in your country and
also act as her investment manager. She is ready to invest $25m to
$50m USD

I will explain further detail of this business proposal when you reply
to this email indicating your interest.


Regards,

Rashid Al-Wahaibi,
Bp Partnership Ltd
60 Raglan Road
Reigate, ENG RH2 0HN,
United Kingdom
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
