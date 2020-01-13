Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C59138B3B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jan 2020 06:52:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6A3D610097E00;
	Sun, 12 Jan 2020 21:55:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=cathben72@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C6E6A10097E00
	for <linux-nvdimm@lists.01.org>; Sun, 12 Jan 2020 21:55:45 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id n16so7171395oie.12
        for <linux-nvdimm@lists.01.org>; Sun, 12 Jan 2020 21:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Rjbe3pVeMfYVPdmVklZ4b2stSqI32LIYp+bn/8NyJvk=;
        b=El5YZgtDEXJCHEtZrRB1ujEJT5GnrR9nqQvx3oNXkD1KXWKAy5lE4fahagwXmNRBuY
         Z373bCStdjZZAvrcMmyjZhqXNYKD7qS8gpQ1uKt4Zm/CJYofbOmd6y2KCfdaIf8lu4gx
         e04Qq2Wd5k0QzXhgODgXLh9+BTAbr7mIJG1kvrHD2cB5892G2QaMtoQjZ8YbwAsn/v/R
         qN1ulSwy8kLJzDOOwwvDkEa6g0paOaNUUW6lO8NcaOsOsQMTh2eV34LXY/bnRxfyDcL+
         OFIAYoYpyWTxvo4nB11oXa8J2BNLiFXnr18VfN4DCPOmpXqWPT8f/9GzmZX8VWLxs4VK
         s+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Rjbe3pVeMfYVPdmVklZ4b2stSqI32LIYp+bn/8NyJvk=;
        b=DYfjJOcmTxjrXBBUSvWpImu8NV4E2uBc7oxfPendBfTdm/oXmk/v5Rc8uPUopSI1uN
         gtK/yZteePmkA51FbT7GjA7IlIwJC+ibBiERVIjdHxEyZkvD21wKd0mCyPDqhlr/8Q6W
         7Tz3H2EhhFWK7w1CHr4ibmRosJ1Xmo1n6oUi4TDTfcgim2tLxqJ8pqby8rQ0YNG730nZ
         oBe4u/ZF2AN+GcLcCaCP8ytBfJXcpCfPMYtQ5jk41fM1SJm0ZMWaz2+szQgoTqgd1w4Q
         ns8l6/1a7ef5OfA6oU/fctwLY5X7yY/gmaUQyEbnJP/pkhQZa47RYyvlbkmiiK8Zy116
         Ku4w==
X-Gm-Message-State: APjAAAViqu/Ri07LqmrJUroQWczBKLy74IGa7++1V32MrdZvcPHirK8i
	ai+eW9A2h9AOC5gkSAmWb+uIFzL/kfyAL5GDo4U=
X-Google-Smtp-Source: APXvYqy7JhGBt0ZjJ/1t4CT74GIhTuvbOMnCynReBbsGRcTAfZPwoiLBCe9XiPA9xaK1JAPmy14eucUMWI9DLkbKsUo=
X-Received: by 2002:a54:4713:: with SMTP id k19mr11513430oik.113.1578894745174;
 Sun, 12 Jan 2020 21:52:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:41cb:0:0:0:0:0 with HTTP; Sun, 12 Jan 2020 21:52:24
 -0800 (PST)
From: Rick Schaech <cathben72@gmail.com>
Date: Mon, 13 Jan 2020 01:52:24 -0400
Message-ID: <CAEcBxO=TAnFn5LzizHa22hUC0Db5FuiZJF28m=yX3_9m--jRqg@mail.gmail.com>
Subject: I wait for your swift response,
To: undisclosed-recipients:;
Message-ID-Hash: YJIIMPIOLVLAW4GZWSZSFWY72EGX2BAQ
X-Message-ID-Hash: YJIIMPIOLVLAW4GZWSZSFWY72EGX2BAQ
X-MailFrom: cathben72@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: rickschaech@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YJIIMPIOLVLAW4GZWSZSFWY72EGX2BAQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear, I'm Mr Rick Schaech, I am the General Account Auditor, Though i
know we have not meet each other before but sometimes in life God have
a reason of bringing two people from two different countries together
as business partners or life partners.

My dear friend, I have the sum of 15.7 Million USD i wish to put in
your name due to the death of my late client who died several years
ago as his next of kin column still remain blank. Though the internet
medium is highly abuse these days but am assuring you that this
transaction is legitimate and I am contacting you that we may have a
deal, note for your cooperation and collaboration 40% of the sum will
be for you while the other 60% will be for me as well. I wait for your
swift response for more details. please forward your response to my
personal E-mail: rickschaech@gmail.com

Yours sincerely,
Rick Schaech.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
