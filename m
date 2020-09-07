Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23E825F19A
	for <lists+linux-nvdimm@lfdr.de>; Mon,  7 Sep 2020 04:05:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E5A0D13E4C43F;
	Sun,  6 Sep 2020 19:04:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com; envelope-from=felixthombiano11@gmail.com; receiver=<UNKNOWN> 
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6EA9013E4C43C
	for <linux-nvdimm@lists.01.org>; Sun,  6 Sep 2020 19:04:54 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x77so6693053lfa.0
        for <linux-nvdimm@lists.01.org>; Sun, 06 Sep 2020 19:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=vAqJsj5SltyQ6U0RZiNyMlYvjmnJPN8uyTBx8eCwoAg=;
        b=fH9y/8i6TlYd4bneym3QFchxZMQ7XrgCpCFD8PSWo1L+Wz9XPJGKnoTlL7+4iqZwO9
         fg2NCQ+KEwdcdXh7AsXpSmsModrvMfxIdsoIr6YE8933VMBlW7/ZpSle4yw1q5MY2sXG
         BLKXz32y9+CbNJ4pU9XAgor2PehF4yKt7A0XUc/gLzLOZcBczaoA5frUKm4mjzGxnuaK
         iVCuLVEtgRxQ5SfLbcGTygC6/UsQ/e6auoysGiiCCIlTSM+dlJVzIoreuqHvwKYt+xrA
         sk7U2eQ5PIPgxbuapD4qxRe/xASzAKPf0cmJnJ8tWPzA6ECArUpi+fWpnayYUFVzKOYr
         8uAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=vAqJsj5SltyQ6U0RZiNyMlYvjmnJPN8uyTBx8eCwoAg=;
        b=T316H0eLZZIJqPLJzV1JqG3fwwl12T/+SSpDYz32lm3RDpAh+X6jdYIL11OzC+zSfr
         VHQgNbQVHDHD7Ru33dgx54J069RYmT3q+6k8OSWfpW41r6XVLIA5M59vbxCLw6GXEExH
         NJWA5Pkp1dc9qbXIHY6x6CxIUyD5NuoNg89K1krsqvdMz+nVHr7E7Ru1NiGTFaZzGXoI
         OkXbXc+6mURhgap6tdnpL35RlByVGtFgtwymll8LALhC9Yuq7aBv5tXtejCTNX+GIdPO
         6S+zbW/X3OkrvOdciVE2+FH1fhGZPrnBK3HotbEoSD3Eq8GlCpv9X61La+aIvGbUJME+
         Yfsg==
X-Gm-Message-State: AOAM533s0Inv8BSbLlUCNtKqwgmpiYzUcJgl/UYkFUX2wSjfLRZG1pKP
	bQeDntsDgcZLr7yHNBAbsWIQS1k+sBheQeMhIHM=
X-Google-Smtp-Source: ABdhPJySGGpcVRmhauRV20kLs9PSiV4n96CfnrndnTw+jdUU/+VKx8s0xyh8IlSH+dgMfikpqgW53k31PqHjfmcu4B4=
X-Received: by 2002:a19:48d2:: with SMTP id v201mr9034536lfa.96.1599444291518;
 Sun, 06 Sep 2020 19:04:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:2d6:0:0:0:0 with HTTP; Sun, 6 Sep 2020 19:04:51
 -0700 (PDT)
From: "Mr.John Mark" <felixthombiano11@gmail.com>
Date: Sun, 6 Sep 2020 19:04:51 -0700
Message-ID: <CA+umDt+nLEGOiShZz04MCkSt7dvwom5XrvkD7WiVzd4QZ6JcBA@mail.gmail.com>
Subject: Good Day My Good Friend
To: undisclosed-recipients:;
Message-ID-Hash: 6XI3EUKMILMF3SSGLARIQNIOVIECZIL7
X-Message-ID-Hash: 6XI3EUKMILMF3SSGLARIQNIOVIECZIL7
X-MailFrom: felixthombiano11@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: john_mark@mail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6XI3EUKMILMF3SSGLARIQNIOVIECZIL7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Good Day My Good Friend

Let me start by introducing myself I am Mr. John Mark from Burkina
Faso, I am writing you this letter based on latest development in my
bank which i we like to bring you in. The sum of Sex Million Five
Hundred Thousand United State Dollars ($ 6.5Million) this is
legitimate Transition after the transfer we will share it, 50% for me
and 50% for you. Let me know if your  interested in the deal kindly
Contact me for more details

Kind Regards

Mr.Mark John
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
