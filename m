Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 711651A5333
	for <lists+linux-nvdimm@lfdr.de>; Sat, 11 Apr 2020 19:54:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A9A0100A3CD5;
	Sat, 11 Apr 2020 10:54:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=hbrown.mr@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B5B8B100A3CD3
	for <linux-nvdimm@lists.01.org>; Sat, 11 Apr 2020 10:54:48 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v2so5003436oto.2
        for <linux-nvdimm@lists.01.org>; Sat, 11 Apr 2020 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gitPbWeOnWxsIDdE5J+o8TimPLqNn6QenZQNK9KM6kI=;
        b=oUHOJHa2z9NMAkLF9W4zqR1GtBlmNQEnqSbPzNeDkQg5IpfD3GVUZMuiracsTTgRfU
         U5EXBu7dTKCfLutF73PmculWXp7DZxC9Mg1mmFaDd60c3tWU4ntJ11H/ZWwYPC/DVc+W
         R/HODdK8ZH/Hn4sHtWsNYG+fbwb6s03iTTip+QGAEgbJ6GH+4mK8XXjNfeDymV1rjFsd
         bONjgNVhhGtSV4Ev1jmSg8sAGaNx15In9crhEDlTIxgv8I0bTCVRUlRhRyJAwHL+DQSH
         /RGRXjYN3Oz1XzHtGAniUp51JbbLV/suAmUBsibt47DihUDKn7Cu4hZWQyMnAi9i6rN+
         zOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gitPbWeOnWxsIDdE5J+o8TimPLqNn6QenZQNK9KM6kI=;
        b=lEIpCHH/4s3AzAxGJTRfHA9J7Bsf49Cpq1WRbKuLazzHuU05VzUwVB4a3A5uAQu5+i
         cuQop174GepB20/DeHtWOfCKqObKSdXyS8bUa+I7gntsTRI9qH6tAKLbJtsED8tz3HRy
         wrv1U/uIaz5CUJ2KCuqqijbAFK6w/5zz7q4Dkr1T25pxa1VgvnAEoiQXnSHCcS37YvwZ
         vhMs/deVthRukp3lHEFlj7eV7+W7nI88JBa84Yq3jQI0sPQ9L6IWh1QwQxVn7MkgXcTP
         CCPSU25BmuQnI7SkWzbSXDWmyWCbAWdYt9fAZ2No6d/dIf5Rx45pRNAaIAJ2B74gDrEQ
         LhOg==
X-Gm-Message-State: AGi0PuZujkmsHmrlEoig2kr/qvLpTgi18VnYvaSu5UopFT/m+gq3QoTG
	x9PwCQwm1tdsbOoxEqWNxQYTsrJahMf3AurCrBA=
X-Google-Smtp-Source: APiQypI/i2QH8Fl8F1oPFwswx4azvUcMsw5DbhWrgkEMJkiIq/e/YT/NMlAF6jpzoXOZB1U9MIPxs8NJbfRIbD5gGA8=
X-Received: by 2002:a05:6830:1356:: with SMTP id r22mr8940195otq.209.1586627638561;
 Sat, 11 Apr 2020 10:53:58 -0700 (PDT)
MIME-Version: 1.0
From: PHILLIP BOUTA <phillipbouta@gmail.com>
Date: Sat, 11 Apr 2020 19:53:26 +0100
Message-ID: <CACP2PXvbNhyNoi3ddt19Lv2LamUVDVZTC80o8RjJo26VmYEGQg@mail.gmail.com>
Subject: INTEREST
To: undisclosed-recipients:;
Message-ID-Hash: 6FYL2E2XME6UAENGETVOJKCIUWNEK5VK
X-Message-ID-Hash: 6FYL2E2XME6UAENGETVOJKCIUWNEK5VK
X-MailFrom: hbrown.mr@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6FYL2E2XME6UAENGETVOJKCIUWNEK5VK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello dear,

I am keen investing in your country and I need your assistance and
co-operation to actualize it.

Can you receive and secure my fund for onward investment in your country if
I entrust it in your custody?

Your earnest reply expected.

Regards,

Phillip Bouta.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
