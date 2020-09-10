Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AF0263BB3
	for <lists+linux-nvdimm@lfdr.de>; Thu, 10 Sep 2020 06:04:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0E27B140CEB00;
	Wed,  9 Sep 2020 21:04:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com; envelope-from=pf839192@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 991B61404C175
	for <linux-nvdimm@lists.01.org>; Wed,  9 Sep 2020 21:04:44 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v123so4717983qkd.9
        for <linux-nvdimm@lists.01.org>; Wed, 09 Sep 2020 21:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=60cylirg5hucOko/8kunNblJi1itqUec5sc0lfnmmkg=;
        b=VEQmz5Utg+cTC+siurJYRg/g/pxyKt2EWpzK7E0klxG+JXZo7B7JDF/Wd9rnP4dta6
         UbmfuBwevxZncRAWUaP/Piu3tFc69u6r8KXXbzB3IO6zeEi8u3Bp/elQN0xH8vKpRRHP
         nFJetPYYZam0iZm3eYxIYoIlXhmoZznzQ2zQeEcVQh5hEC+WZa05H4fRMYbpDcg6DH9o
         4w7xnfaREVo4yKy2Te7V57T8wtF3xdHGH64I80a650Xjh6c73Wr/Qd4pdkYpM7z/W7AJ
         PcjGE08hM6X4GAHnYLyLrtjBb2oZQc1CIx6C2OQ0FvbeLqZXkUb2UYAx+Lpr8hrVLoMw
         15Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=60cylirg5hucOko/8kunNblJi1itqUec5sc0lfnmmkg=;
        b=Qd6mSTqywSvARqiqB1BbGyAZiEyq9a+k3ju0P5THvk5DgvQ6jFWlFEL2EChUXItHoV
         G/pKs2DfFA8eDe29UGlm6BWG+ADgyurdrnwI22Fl4EEFwnnc+0OVV12um7ZHSA3yr34I
         Ik1XKgY3xhkREXN9dJ+tiR8mtKZFZuK65nKMyJKCotR5qj4p7L4TsEyi8d66zW4v/a1z
         jI8Zrh8tAoQh6f9LHOp989z/0AfSAxqK+2vXpd+YidAEwaax7F7XQnAx2D20jP5w1b0n
         cCCnBSp2XCrw0aAdzh7YUX8HUw1QZtr2e6YGHL8fplOggYVOF+0p98yenZPys3kE3qRr
         y7bw==
X-Gm-Message-State: AOAM532qeMk7yuyvv72m8yB/xcNFf3iJjZ/shQG/YvvBz6zZlRELuCQj
	WiTxJiUh+4LMRUz9RpKNQAe/bQEOXdhIixYqxsE=
X-Google-Smtp-Source: ABdhPJw05eNxN2HhZ/3+cEDSICebBhsBGgBd1FR7tZWNaCoQB8TiZi0TnX0pQDPP5XbydfJb4VOK8Fgm5O5w6qVV/Ik=
X-Received: by 2002:a37:6393:: with SMTP id x141mr6136614qkb.238.1599710683755;
 Wed, 09 Sep 2020 21:04:43 -0700 (PDT)
MIME-Version: 1.0
From: Fatima Rajab <fatimarajaba766@gmail.com>
Date: Thu, 10 Sep 2020 05:04:32 +0100
Message-ID: <CAGqfsL9xvWcCYZDPgi2GpugvJp4-dfe6cXr59TdAk7u3bJ0NDw@mail.gmail.com>
Subject: HI
To: undisclosed-recipients:;
Message-ID-Hash: JJW7SH6QBAMTO6OZ7J2GNBP2G5ZCIYCT
X-Message-ID-Hash: JJW7SH6QBAMTO6OZ7J2GNBP2G5ZCIYCT
X-MailFrom: pf839192@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: fatimarajaba766@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JJW7SH6QBAMTO6OZ7J2GNBP2G5ZCIYCT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

HI
Nice to meet you
My name is Miss Fatima
can we talk please
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
