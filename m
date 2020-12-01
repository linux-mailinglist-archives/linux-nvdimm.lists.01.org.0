Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B722B2CA65E
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Dec 2020 15:56:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B59B100EC1EB;
	Tue,  1 Dec 2020 06:56:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::c47; helo=mail-oo1-xc47.google.com; envelope-from=3jlngxwwjdf8gbppq7ibvzyydj7fi.9ljifkru-ksafjjifpqp.xy.lod@trix.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-oo1-xc47.google.com (mail-oo1-xc47.google.com [IPv6:2607:f8b0:4864:20::c47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9B262100ED4AE
	for <linux-nvdimm@lists.01.org>; Tue,  1 Dec 2020 06:56:18 -0800 (PST)
Received: by mail-oo1-xc47.google.com with SMTP id y199so1042084ooa.19
        for <linux-nvdimm@lists.01.org>; Tue, 01 Dec 2020 06:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:message-id:date:subject:from:to;
        bh=xTtDjcjp/R/7luAT209wPI/igiGl2w2CywmaH4ueL7c=;
        b=ooskgFyrToNqKepa2VzntbtI45yPgz0C+xk7+ENBpZkm+7a4fzoms6TSpCIlLRGbx+
         ZvcLlotkKsjSHuVZIuTerlabiokzy301YogrvEcXQfVXEHxoyWhVEGauF0P0js53vPE5
         cjho2bhJ8MPD9Lnd2bcrRGF00B0SKwudi0/nU6aqkIpiQLi+5rpibIg1mNypjbsitU6w
         QPehwxX0Pu0ojL3Nrqw2tSD6MdGMRmU6Tz7AD8UrzMtZrGPG4PeLMdtRNlnGWdIZhA2h
         DQ/2G17bd+ajBi/mzeXrfvx3CVDDht4RqNbZesqWYzufHhhzYSbytde5QMFjv3XSvqrK
         MoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:message-id:date:subject
         :from:to;
        bh=xTtDjcjp/R/7luAT209wPI/igiGl2w2CywmaH4ueL7c=;
        b=lZxrQRMLyr3cIyoJjRNvR+oSUktf2Y1rwvEi/Ow9KDHXjjUmI4O6T5RpuT+OKoUYC5
         LoHfBzW8Wz3RPenFYKGlYXSlwfb0v45ji6fSw33KLXSEASf494b3io4r3EUEerkFHnoT
         iGZSdgxDyjIh6Y3VUhB4wWTttfHKsJvphTT89cZBWHjZT4L13Zag+LG663DqtKnbY3rr
         voZBwOYcQljBJM2B3sPaI10IzNMAYgAVZjw0/sdtYs4wOhq74CX0zO1bGmfZYwf9h4AK
         JjrwAovwTifq1eW5ZwK4xJB6r7VrA4vizdzg58F6JqYCRvbKgMqzsXI74Gbgti9eU1Hb
         ygBg==
X-Gm-Message-State: AOAM533CR1q7f213VQ8/MRwydxdVHrjcecfeAZxeyQi+0dEEAY0Hvs/3
	dby2DfQL9qLiLWPYa6yd5BLN+DTO1WbLXoMN4EJC
MIME-Version: 1.0
X-Received: by 2002:aca:3205:: with SMTP id y5mt2181324oiy.162.1606834574882;
 Tue, 01 Dec 2020 06:56:14 -0800 (PST)
X-No-Auto-Attachment: 1
Message-ID: <0000000000000ca34605b56854e4@google.com>
Date: Tue, 01 Dec 2020 14:56:17 +0000
Subject: DEAR FRIEND,
From: jesstaley211@gmail.com
To: linux-nvdimm@lists.01.org
Message-ID-Hash: J7H3DTPLUFZJGQD2MGN3W2RZ4ZKXDZXY
X-Message-ID-Hash: J7H3DTPLUFZJGQD2MGN3W2RZ4ZKXDZXY
X-MailFrom: 3jlnGXwwJDF8GBPPQ7IBVZYYDJ7FI.9LJIFKRU-KSAFJJIFPQP.XY.LOD@trix.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: jesstaley211@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J7H3DTPLUFZJGQD2MGN3W2RZ4ZKXDZXY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
Content-Transfer-Encoding: 7bit

I've invited you to fill in the following form:
Untitled form

To fill it in, visit:
https://docs.google.com/forms/d/e/1FAIpQLSfi2v_QwY_KtQFRSv66gKQXWIyn7sbvAx1_r8wjAat6yYUKUw/viewform?vc=0&amp;c=0&amp;w=1&amp;flr=0&amp;usp=mail_form_link

Dear,

I am Engr Uduak Walter Onnoghen, the son of the recently suspended Chief  
Justice of Nigeria. I write to make a plea to you as one of my father`s  
friends, who works with the Ministry of Finance under foreign Contractors  
payment Reconciliation Department , advised.

To be precise, my father`s case is still under investigation as such, there  
are some hidden funds which i want to keep in safer hands so that this  
Government will not get hold of it.

This is a secret. Even my father`s friends do not know i am communicating  
with you over this.

Please, if you are interested in helping me out by receiving the Fund,  
reply me (engrudukwalteronnoghen@yahoo.com ) for more details.

Thanks

Engr U.W Onnoghen.
engrudukwalteronnoghen@yahoo.com

Google Forms: Create and analyse surveys.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
