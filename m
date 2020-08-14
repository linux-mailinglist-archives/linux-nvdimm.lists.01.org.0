Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67487244D2B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Aug 2020 18:55:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 475231311C195;
	Fri, 14 Aug 2020 09:55:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com; envelope-from=aishagaddafi190@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 957A21311C195
	for <linux-nvdimm@lists.01.org>; Fri, 14 Aug 2020 09:55:25 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k12so8104003otr.1
        for <linux-nvdimm@lists.01.org>; Fri, 14 Aug 2020 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hEkR1aiV3FgqWifUDRZ/LnwAKRgtXp8YBx05IH2xt3I=;
        b=kk1JWl5YYEAPa8IFd0flSkIi3PY07S02goI3KJfK98OwVnYTST9pvRU3nQMaEw3wQi
         hGQr/IworGKkWgcKDcf01dWP93rJ608YqcUj5TJRZybPAn67RG+V8exnH0K5W1xm+q0F
         QIIcXI1nWTyTkpL3P9bCDr46mO9XJZkaAAQIM+0XpzL5sx9O0MnxrlfRBDy2mFwB1TjH
         FaiydaD3/dMAKRY6ZFgW/wS9bOMtn1WmrvoMLhp6MeF1WNc8EkOQFvUBR6tlv1nsoSJc
         KjaAr0WTMCo7FaBT6Sm8UcCq2a8q2NO4LPHTiMjUk8mYktNm2hKd3GU8p70ptHsYuMW6
         7zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hEkR1aiV3FgqWifUDRZ/LnwAKRgtXp8YBx05IH2xt3I=;
        b=FNqwIpyYJchzOkZRPen6LjdaQuk0kJZUPAjsSWlZnB41+z5wJg2Q3kufPRp14+Ayec
         1rC0KzJsDjeecpFSMVvJ1/4JkLxLnKWxTEgKgZdERFtVv22Z/l0Xx/DmzrG4KAcYRFL7
         FCnlVhif+vky2HBZ6hCFGZ5eGlfGnhTNKvKO8DQotjII4PdEISe8JjjDoaPiojFN6z0q
         3DuRycMruVS61delrMJPhF0Xd0mGrjaUVbuCUrs/4THm7oGjTQfvUEv/cJdL/4yuRprw
         uvHD0g2/xI5G3p93uNlEDdoBS+m6f6X5mo04P2IDtZ6hznHPpE1weUUqXyzLFkXiRusW
         1Ncw==
X-Gm-Message-State: AOAM532qlcZOxy7wEqKyZpiNFQ7Z4qDptTFhO2Ny6LtfYMNJp3X/0d9b
	1HEBht/K+rVnkWP7GETEGOXWPXiKrkfUZzlu35g=
X-Google-Smtp-Source: ABdhPJwcpnuNzeNJ4V0OdouQ8iglNwlSukh6Q1sN4L5kfWcSq8gO5cUx34ULz5zqzAYtjslvGhIeqC9iRb9Hrjesabs=
X-Received: by 2002:a9d:4b01:: with SMTP id q1mr1587943otf.15.1597424124293;
 Fri, 14 Aug 2020 09:55:24 -0700 (PDT)
MIME-Version: 1.0
From: Aisha Muammar Gaddafi <aishagaddafi190@gmail.com>
Date: Fri, 14 Aug 2020 16:55:09 +0100
Message-ID: <CAJVkJvmUc78HpBEOLJ0VmHngGiwnMx=f=fHCkzJz=Fii=w0_iQ@mail.gmail.com>
Subject: Dr Aisha Muammar Gaddafi       
To: undisclosed-recipients:;
Message-ID-Hash: KPOOCXT3BWDRK7I5I26D7R55T7X7AKL4
X-Message-ID-Hash: KPOOCXT3BWDRK7I5I26D7R55T7X7AKL4
X-MailFrom: aishagaddafi190@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KPOOCXT3BWDRK7I5I26D7R55T7X7AKL4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

As you know I'm Aisha Gaddafi the daughter of the former president of Libya
late president Muammar Gaddafi who was killed in the civil war which took
place in the year 2011 which ended up his life on the 20th October
2011.Before the death of my father the Late President of Libya he made a
deposit of 10 million US dollars with a security company there in Ghana .
That no one knows about except we the children and now my brother is in
prison for trial for war crime so i am the only one left out and i got an
mail from the security company , that i have to come for the funds but now
i can't because After the death of my father the UN and Libya Government
has been tracking all my father's wealth and money everywhere around the
globe my dear but, this was the last deposit my father made before he
died,so i am looking for a trust worthy person to stand as my foreign
beneficiary to help me claim the funds and i am ready to reward  whoever he
or she may be and i will also let the security company  know that i am
appointing the person as my beneficiary, and help me receive my funds from
the security company  so i can come out of my present ordeal and to go
somewhere to start a new good life somewhere my friend....Please i will
love to read from you and let me know if you will be able to help me with
this and i promise that this transaction will be smooth and free there is
no need to be afraid and please this must be a secret between  both of us
hope to hear from you soonest.

Best Regards.
Dr Aisha Muammar Gaddafi
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
