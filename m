Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9127118CC49
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Mar 2020 12:08:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6BC4410FC340C;
	Fri, 20 Mar 2020 04:09:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=federabureauofinteligence@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CBEC910FC336D
	for <linux-nvdimm@lists.01.org>; Fri, 20 Mar 2020 04:09:14 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k8so6087803oik.2
        for <linux-nvdimm@lists.01.org>; Fri, 20 Mar 2020 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kuhba0bbR9oJup1oQ7P5tNPZ9FqBHXE57QqcfHgaIHo=;
        b=A60SjmFBNa4d1kwHvRw4bc9lj2jiNyAhDuqhjWo3cgAebNQqUJEnh/RoZdx7hfzsrp
         4SWQhn688QXBqYnglKKuLTjif0JDt0fbCcv1RHUlno7cqw3eMo57hxRetkNV0RbvyU25
         M3Jm200pLL3/1wwAtQ85SI+8PfMjYJLVzBJYLK/vQaegR5eqdknK9K4xDkTLKTPKubnA
         jGBcsvwmCzHJiZPplG796lErwiPd5PyUKcHhVXfFsJFFRLfDf/MjQ1z0m6oXKEAnHYyc
         EWcmpEoSaUnQlmPVU7PKje3QuaxL3J4usaauhIJ+Oh0CZo7E+79qWEUCq+sR+oQvF80l
         qZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kuhba0bbR9oJup1oQ7P5tNPZ9FqBHXE57QqcfHgaIHo=;
        b=pRYtgIdVuDvGyHsp4I1CV4dHfdIJtUtojsy3TuFXvebL+iRVo/59YXDvgF8RjUHyMk
         QecxK2K/6+iuie5jpxs1Aa4tqXlkzTPLWG+u1b4H4w70JaaJusCNg0KhNmboYuRW+FBw
         RsSPpGCA7vpAZfy7TDMDMjAC3zkCIfxb1X0FCo7NJgcVeEN+532xNbAV7iWlnFvxLnIh
         Pen8VxWjLWzFXN5Q9uS9C47qFKV+hiHIsVBhfFtsDCTnJVxyH7TO2tHAuMdt7txFXr5g
         mzd/cdxMFaqi0Zt+Uy6j/5DHxo+yS4zL2mAhQ6E+zF9XNYnFQtxKeIHLe1R+LyuLbOca
         y+UA==
X-Gm-Message-State: ANhLgQ0zQ+/kK/kNuFb0Iw8UHGHlpMHBZcAQMqjKxp3uhxiO6JmALpCM
	BYC2YWiBQNZni7/vyIgyjDjePIw1mb0HYyaDctA=
X-Google-Smtp-Source: ADFU+vt8k2nsikl8+F6zZy6KhM6oVL5vQUIBRP29fSYh+mzbePjgR8pd4xdQF9Q4z698VmxSff9iU79jql6v8FVByH8=
X-Received: by 2002:aca:4bc5:: with SMTP id y188mr6033676oia.9.1584702503363;
 Fri, 20 Mar 2020 04:08:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c897:0:0:0:0:0 with HTTP; Fri, 20 Mar 2020 04:08:22
 -0700 (PDT)
From: federa bureau of inteligence <federabureauofinteligence@gmail.com>
Date: Fri, 20 Mar 2020 11:08:22 +0000
Message-ID: <CAE9o6LCqCOnKQYMchcW8zWHww1Rv4p89mYY9EaPpi4XVZ-00Mg@mail.gmail.com>
Subject: HAPPY SURVIVAL OF CORONAVIRUS
To: undisclosed-recipients:;
Message-ID-Hash: GHKA6YZOQB4U42SFKW5MKDEJNIE2UHCJ
X-Message-ID-Hash: GHKA6YZOQB4U42SFKW5MKDEJNIE2UHCJ
X-MailFrom: federabureauofinteligence@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GHKA6YZOQB4U42SFKW5MKDEJNIE2UHCJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Sir,

HAPPY SURVIVAL OF CORONAVIRUS

We are reaching for a very interesting business transaction which we
feel will of great benefit.We the FBI unit in the western subregion of
Africa have a fund which we confiscated and lodge it in a bank

This fund is worth of $12.5 million dollars.We will need your
assistance to recieve this fund into your account for investment in
your country.

We will need your urgent response for details

Inspector Greg Adams,
For and on behalf of Cote D'Ivoire FBI
Tel 00225 6716 6756
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
