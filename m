Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A419289E25
	for <lists+linux-nvdimm@lfdr.de>; Sat, 10 Oct 2020 06:21:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6CE79159E941F;
	Fri,  9 Oct 2020 21:21:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::941; helo=mail-ua1-x941.google.com; envelope-from=mrszoungranamonica@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4A7991591C6C0
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 21:21:29 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id j15so3753356uaa.8
        for <linux-nvdimm@lists.01.org>; Fri, 09 Oct 2020 21:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=b2n08hWT/ZkiG3kRfl3LhwM36H2OEAfK5DryrSgIfII=;
        b=VBDufZ9MC7tyU4dTt77LErIx300dnEU73afd5b/yFuGYfVg0rbTcAT34EfvqgHt5kD
         9FOvSykmT0bhMaLPZ5Rp8YsuTgieKvSM8MzXKG/9kUGNufr7mqIaRBgSQdGBoVnWDXlT
         sXWqYOr4PPSBZKIe2C4qPPsF3phpHep/MiUe/UAcO5z+sbXemT66dD1TnTi+0jc30gij
         m9ZIIdiJPqqIiLg4kRGnLpLvkSa4xA5XWUmkzko519AFegC6fiCWX6CpKtdlE/RhvSjn
         wOSStgUnr8p1vn8KeS8uLG8n7qBTiK6jccXpeo8ahhPMi4sae331WlDd8KtdzpNuZ1mM
         HmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=b2n08hWT/ZkiG3kRfl3LhwM36H2OEAfK5DryrSgIfII=;
        b=qcgRhboy88Jv6Nt9xz7XveoUv+TX41ole1+MVxfPKrr9xbjJYfNxMQ9nFwL/NyEJwD
         brmdFqAM6uWsPJ7aYVZcAlRU8r9KpYrC+DT5YpOR7uBRjxFSA3izF/yEVgfxDfMAaKda
         Cz7JgkPfDWwUhqWG6LzBDambBMQEwpHO9Q8iIBRzE6kkUXkVxQ9vNk53Lu1sfuP3IB+n
         oDp8JdXlSiIR5E23yz9IIjOXJQOQfduMvA/ea9dmEluV2BNRb8j2oL7BEAdw74f9oXvp
         Msxpoi1EcyP95+OlcyyLowOmvQXi9OwTo/unb+yRVbi+3dAuhMr5kmu5KtdWzWVNCLsi
         cyjQ==
X-Gm-Message-State: AOAM5331fpcCnU6kKNOaTZL60UxeL+quAWRfQqToVMHnVsonOqPYOsrX
	5bsioPFqcv2nm/oS9OR/B0gsBBxqPRHKxU8tUlU=
X-Google-Smtp-Source: ABdhPJw+iIaAexNtUeOuqvzT318nHeJ+8GYLGg17KPshWWaqXheKnIpYS9eCkkpUdMkiQoANZ6sn0PHDT49uHyovSwk=
X-Received: by 2002:ab0:7718:: with SMTP id z24mr9581788uaq.92.1602303687534;
 Fri, 09 Oct 2020 21:21:27 -0700 (PDT)
MIME-Version: 1.0
Sender: mrszoungranamonica@gmail.com
Received: by 2002:ab0:70a1:0:0:0:0:0 with HTTP; Fri, 9 Oct 2020 21:21:26 -0700 (PDT)
From: Godwin Pete <godwinnpeter@gmail.com>
Date: Fri, 9 Oct 2020 21:21:26 -0700
X-Google-Sender-Auth: YDaKSUGnyChwks_x6t4pgIKjCeQ
Message-ID: <CAAB_EnjjqA5u=z8j2DYDresrNvk-bp58nV=JBzLXGR8dKG=K+A@mail.gmail.com>
Subject: I need your urgent response
To: undisclosed-recipients:;
Message-ID-Hash: DAYSQLJZDBQZRVXDI3XQ222YLKE7HR4L
X-Message-ID-Hash: DAYSQLJZDBQZRVXDI3XQ222YLKE7HR4L
X-MailFrom: mrszoungranamonica@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: godwii@hotmail.fr
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DAYSQLJZDBQZRVXDI3XQ222YLKE7HR4L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

My good friend,

I just want to know if you, can help me to transfer the amount of
($6Million). After the transfer we have to share it, 50% for me, and
50% for you. Please let me know if you can help me for more
information in regards with the transfer. I hope you can work with me
honestly?

Thanks.

Godwin Peter,
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
