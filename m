Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B92D22AA57
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Jul 2020 10:07:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7FAE5124DA7A6;
	Thu, 23 Jul 2020 01:07:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=jackjoinsnapcard@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 38421124D9F58
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 01:07:47 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t18so3746334otq.5
        for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 01:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=NT09iQGGOwcZxIATkyfpEyFjPA4EJJ8PA1v8ZW9JTYY=;
        b=JOb8dr6iaO/OOb/ILimxlL7axfjdxivEFH8CD8yYx3Yfl+XFdPkzdx+GJvmbroate5
         lzVjOeEpOfz0f6lA64BIx7yxzC2mq9NtZDSdwntE6y6vn+0/6nRExUVI3MmhGijMOCSL
         +gTtBbyXGOaJHUPZqSY3u2xSjX/Rg5/6CViZzzqDNlUTQp+y3HBZWh4/EZ20w6ZjxgOF
         ZGZNV9GWqzYOr7SAHXn0NzedeVASfOOdJkNg4dLVwFiIEnFZtExU0bwHqoThYWK4sEgL
         IiaD4fiJU+2GmWIW3f08KoUvaohP7v+P7ZY/Tp3Zu4kYFPXJNPE3wk+qCNiTSFNlgd46
         vFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=NT09iQGGOwcZxIATkyfpEyFjPA4EJJ8PA1v8ZW9JTYY=;
        b=gMCTFMpC7CzwvQCRMxO4ntm6OVTQ/7P8tSqdU2Gy1+3LSPbBzTNZctMIn1YQ1BWiZG
         rnRgtDIBeAT/YpwJz04iv7iqATPnmEVej4mt60HKzkILBsTu3XY+EtApjPa34BwMQRte
         VcB/r/15B6ZXgIt1c3WjB8+TFDEH3l26ylv16jaC6Bd5B0ZMMaJUo7gMl5iT1O1XliOL
         iykgswE5eYPzYkwh/QgiA+e5/ojiBoqZGWxfnyjhJO5OpfJ0EWDOsJmCBKeaFcbhEEqi
         brnXjplU7ttV2XQzBsxaIMYftMJVFq+rOTmkphJhrTli4ZIXCugDdIE7QEnoit+vouF0
         dgrw==
X-Gm-Message-State: AOAM532XtDDpLQA4P1Tg8/X5OaQ7yH2JSomR98c5eR0C7JD0RjmbvZ1R
	xialrf/J5ZXWrZYLwARplvRbNoqYJzOnGpmb9b4=
X-Google-Smtp-Source: ABdhPJy/CXu++Dz55qBj34UH1j3KTE0XiHHh3HRemSeTvZSruUlz13x1gHROt1fISXUBhHpvlxY3bcL0FgRUeUCiXaQ=
X-Received: by 2002:a9d:4d9a:: with SMTP id u26mr3176658otk.277.1595491665819;
 Thu, 23 Jul 2020 01:07:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:36e9:0:0:0:0:0 with HTTP; Thu, 23 Jul 2020 01:07:45
 -0700 (PDT)
From: "DR. TIJANI IBRA" <jackjoinsnapcard@gmail.com>
Date: Thu, 23 Jul 2020 01:07:45 -0700
Message-ID: <CAPAPRtxx8UuggRU5kuptSvZWbNV=Xt3z9nVLqa9n0P7wimq1hw@mail.gmail.com>
Subject: Greetings
To: undisclosed-recipients:;
Message-ID-Hash: B2PL2KG756KHAIXBLAUUI6X766QFF6IT
X-Message-ID-Hash: B2PL2KG756KHAIXBLAUUI6X766QFF6IT
X-MailFrom: jackjoinsnapcard@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: tijanlibra87@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B2PL2KG756KHAIXBLAUUI6X766QFF6IT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Greetings,

I wonder why you continue neglecting my emails. Please, acknowledge
the receipt of this message in reference to the subject above as I
intend to send to you the details of the mail. Sometimes, try to check
your spam box because most of these correspondences fall out sometimes
in SPAM folder.

Best regards,

DR. TIJANI IBRA
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
