Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE151830C6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Mar 2020 14:02:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A98C910FC376C;
	Thu, 12 Mar 2020 06:03:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::243; helo=mail-lj1-x243.google.com; envelope-from=prremsubra@gmail.com; receiver=<UNKNOWN> 
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 587B410FC3411
	for <linux-nvdimm@lists.01.org>; Thu, 12 Mar 2020 06:03:24 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e18so6298488ljn.12
        for <linux-nvdimm@lists.01.org>; Thu, 12 Mar 2020 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=d8hWhAM6Jl9fVlXr0gVQJU0o6ClGuY7SAl1P9yYHdfI=;
        b=tu1/OYpvBS7ayZBJBvwgqnPy5YpIrxYcAEtYcvaT6j83dwo6gfvQOJpIerFNYld82V
         R62pXA0qSdAOP/GC9lc1TuI9e4KqqUQ8nQZMF+0u5Ded8LKm4N7+L9qwn2SR2QuHswWt
         hwJhZuki1JvkM6tfFHqqPdQag0yesOJ5JQ3vq94PX+I/8MmU7F0CCeTSZ7yET1geyz86
         7k3PNVhzpKWCz6SiCkCpVr4uH0EItutXreqwu8CTq+oT5IGfHgJRc4z29xO8zrZ0opbO
         Mv1BsjKin2lXMHGWOpisrJkHSZTbPcuopelzPdhhZkgzm5PVaL3z9mI96CWLaYqWQ5Aq
         jO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=d8hWhAM6Jl9fVlXr0gVQJU0o6ClGuY7SAl1P9yYHdfI=;
        b=MIroA+liFFhWB3BDlqYdOxJh1riYndYzT1Pan4vqLxnYT51yipWHz6osxKVnl1CV34
         swzl0XVsyDSkT3QFvENe9XuVb3mgWXfXHbEB4xCFT3qXX5jCHglP2TIzYgi1AYwe0p9Q
         r03HWvxSeYCTXkSvwdWdp2wpRZB9IGjBNzxx6HKJirkaAbBjCloJTN9MWgeBt+3E/aun
         pJhCfRfiN4LnJLh4ajwUBSdIZ75vxJNr6064RlWqkhgcCyV8zSkDFWNRxLstJzDrMN7r
         xUkHB/Dmb5J1z6r8zIofJDviSqrVY7SsOl/+eQwZCBTTv3mJxrvMjKBlF9ouDoQ/0txB
         tHsQ==
X-Gm-Message-State: ANhLgQ19ZEmdbVw1G706BX1p9qz5GeqRo4IJ2sku+1d/ah7JBeMsdSV8
	E05eqTBdMkl7R0aWPmBCkhJHeHXK2wMrQFAA1f4=
X-Google-Smtp-Source: ADFU+vurIxQ6mO/DvXu2AXNx24PDuoHxMAEx+5KLLV4IsfD1+V63c0TlnmQ5KBqh7iTgW9ig1nuaS/wvAqU4BAVSaKs=
X-Received: by 2002:a2e:240e:: with SMTP id k14mr5467657ljk.178.1584018150816;
 Thu, 12 Mar 2020 06:02:30 -0700 (PDT)
MIME-Version: 1.0
From: Amber-Louise Saeedi <prremsubra@gmail.com>
Date: Thu, 12 Mar 2020 21:02:18 +0800
Message-ID: <CADQAna8VFBS5wr-hcXbXTkYCKA+vpiVk8SkUT4o4qen=pJUaHQ@mail.gmail.com>
Subject: Re:
To: undisclosed-recipients:;
Message-ID-Hash: SJ6VQOXRM3JLEQOYDNFZ57YEEKKPGDXC
X-Message-ID-Hash: SJ6VQOXRM3JLEQOYDNFZ57YEEKKPGDXC
X-MailFrom: prremsubra@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: amberlouisesaeedi@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SJ6VQOXRM3JLEQOYDNFZ57YEEKKPGDXC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Dear,

Did you receive the last email I sent to you. I am contacting you again
prior to my previous email which you did not respond.  I am really sorry to
have approached you in this manner through your company email but I have a
very crucial discussion which you may likely have interest on. Please
kindly confirm when you receive this message for more details.

Thanks
Amber-Louise
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
