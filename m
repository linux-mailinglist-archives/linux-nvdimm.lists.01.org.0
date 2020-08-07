Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F224823EFE5
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Aug 2020 17:20:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 03ADF12B716B3;
	Fri,  7 Aug 2020 08:20:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::c44; helo=mail-oo1-xc44.google.com; envelope-from=matoutinastella@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1603F12B716B2
	for <linux-nvdimm@lists.01.org>; Fri,  7 Aug 2020 08:20:36 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id y30so493591ooj.3
        for <linux-nvdimm@lists.01.org>; Fri, 07 Aug 2020 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=08vNShpdv6AsP5HmF3VtyS7DVG8FXitN2LOD3KFuJO8=;
        b=LJO9lCZMUOcCDsNWveViQ+YRiAIJciuSBEzf7f+yEi8DCTFW9dC7yxFCW0USM2pvBp
         NaNdjOBzgdPwWY/gv2kwobqGl6Rv8UqSZaKcxZiL6qLTnp655S7KxFS7oopSbIH7BvCL
         qzDMYSIh3jEHNGFWnxL/l+/x0hzjEqonQj9jqlsZZc0cihziPMIRxxiiTNkwFC2ZiKqR
         4aEcrwrWRbzFxpILW1KqgLEGs2qu/yXnO4SKg66S3DU8XO7oq1GuDnolrl7Qzkq46Vp8
         iDnYY4bGWAjkkTgH1OMrlcuIso2S/j4CCmsu9GX/aAwULtvFai3Y0LPRC3jZsCYrbSy3
         pHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=08vNShpdv6AsP5HmF3VtyS7DVG8FXitN2LOD3KFuJO8=;
        b=k75wjGoDn6zRg7OhZsUuvBF2J+QN151PSk/qkSOugQs11Gf62MWT+KkUA2wfC76WMM
         3NUQrV+xLL/dolMzhdGvS19VvShABaR8f671V4UTQWsmvKS23kiv4MM61XHN5x8tentL
         49cjAMZK99uP5ii7bk3ZU1PuMzTKuRTHueCqJPCLcpTTyC6+VFSnEyngh/gFi5yLDG8b
         UUOWRIuLqSm22zXhVAEPsXnNMxxefMSy5ijZNXXnUZqd4quT2bMT8rY74mlHbX+fywoq
         slvRPBP39tp2+vhchDjrUJzuUUhFoVVoUvlTnlaxRo8MtUe5Rz6G7Eu+Waoc1IwlxBqw
         3DRQ==
X-Gm-Message-State: AOAM531brK9K8AtiMHROJfNBTs8gNbbdJx6+RFPHD5K8XGSzECoQkhPK
	nSzId+XbXW+XNDW4zYsOCrSYEYG0DtapUO2gJMc=
X-Google-Smtp-Source: ABdhPJytmarAHmhVAnlJ/OZwigatBbHjkbPfQ7ouVytdATIKaxyyRYZgr0k5lwlgy20/yVt9LpEMBi8NHU2KnrgTwjk=
X-Received: by 2002:a4a:6252:: with SMTP id y18mr12995392oog.45.1596813635583;
 Fri, 07 Aug 2020 08:20:35 -0700 (PDT)
MIME-Version: 1.0
From: IsabellaWilliam Helmreich <matoutinastella@gmail.com>
Date: Fri, 7 Aug 2020 15:21:11 +0000
Message-ID: <CABjX5JvdSf-S9KDsn1KXmOVNU+FP30DY9DaWR6hhWY5jhtXpDA@mail.gmail.com>
Subject: Can you?
To: undisclosed-recipients:;
Message-ID-Hash: XBOWOV5KRQXMNR6YKC6Z5DDHK7CVN36P
X-Message-ID-Hash: XBOWOV5KRQXMNR6YKC6Z5DDHK7CVN36P
X-MailFrom: matoutinastella@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mrsisabellawilliamhelmreich20@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XBOWOV5KRQXMNR6YKC6Z5DDHK7CVN36P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Can you supply us??
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
