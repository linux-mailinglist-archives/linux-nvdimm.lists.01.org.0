Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25DA2E868C
	for <lists+linux-nvdimm@lfdr.de>; Sat,  2 Jan 2021 07:04:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7FCDE100ED4AC;
	Fri,  1 Jan 2021 22:04:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::130; helo=mail-lf1-x130.google.com; envelope-from=kath.rafael2030@gmail.com; receiver=<UNKNOWN> 
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3B1D9100EF26A
	for <linux-nvdimm@lists.01.org>; Fri,  1 Jan 2021 22:04:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b26so52016178lff.9
        for <linux-nvdimm@lists.01.org>; Fri, 01 Jan 2021 22:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=07wP4+HPBVC2VHbUnFYsgWGMeRKZwcznPDaqHki/QJQ=;
        b=AwvEUT04dRZRxQb/2mz5Sa4Wndo/K1CL1umdComqMZUZlXVWSJQB7lcofjIcuC+ze6
         2alNCnxiPCMJPDiYt1yQ+KX0t1o1D4fbK34NcrIInky9lgUccS8ZCOHVJCVjsdOgk2rc
         V2OE/vo+XOF+2RNidBlnvzHq8G9xlV5R9h1SlVuRPoWSfJS/J4cLMAZQwzkamgi/oU0N
         8GfrtrxIsh/KuLLhPYul+wfUEXTNysSTB1RGEFIbj4BY61t+AwRmMIg/PrbOXDEWLTb2
         zLEX0d0HvAJ81vDBUOn/a4C6gYrNYwYZLfJ+g943MOR9enck0Kdy17h6xbVMDpWT8keu
         pv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=07wP4+HPBVC2VHbUnFYsgWGMeRKZwcznPDaqHki/QJQ=;
        b=fFneNA1fikkdc0fWFXgrI+yoeNNmvDeT/MwAZhFs0BSjHMAdoIEdx/m6qRzuBSWnsT
         1EjkyrbXsTEc6yf9QA1xdcmhKUn1ytb9jgCU24KJUTlqrvRaF+0INc6dyMeHyXZkCQbd
         xH3nalfr8aFLXcaisvXVeay+01KJ1oLvtXsdL/MNrMrDFTS//EmyAo5rAAW/oAg/TUR2
         O6xOGWfVKsHl8N+0A0u1ibFozy55zCrGpIZwDYAtDSAW7I5zk1DH6hzl0FkDRqQo9Fw6
         2/2eHnoQQ47UB9NIewCycvfXFVsCgs3rgwsdJAQyuQ1UhNF/r1XEzWRt+KjO0RT5yKR1
         IGeg==
X-Gm-Message-State: AOAM531vrl+hN4aCaDEiMyKqTigB8S1kKEmwGPZG197KxPozZ4c0/7Ah
	yD1KJhE8dsV+AHsOsNr0+BmHljhkXsFyENQTzeg=
X-Google-Smtp-Source: ABdhPJyv5+JjtiVK0j4T9nRqiANhDYU3/AjVCG+MhVVzT0KTsgGX9L+naGOo7ypYgP8i7Y8uQAGnjTRQFzJeJWShygY=
X-Received: by 2002:a2e:9246:: with SMTP id v6mr7657089ljg.221.1609567482716;
 Fri, 01 Jan 2021 22:04:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a19:6550:0:0:0:0:0 with HTTP; Fri, 1 Jan 2021 22:04:41 -0800 (PST)
From: Grace Obia <kath.rafael2030@gmail.com>
Date: Sat, 2 Jan 2021 06:04:41 +0000
Message-ID: <CADP0Tkc4zsTvGOR87UFbCtG0=7=DQyM=JTEBeeB9BzCQrL_XXA@mail.gmail.com>
Subject: Dearest in Mind,
To: undisclosed-recipients:;
Message-ID-Hash: XHQBNP5T6WJC4VMKFGEX42HJ2LJYXZYO
X-Message-ID-Hash: XHQBNP5T6WJC4VMKFGEX42HJ2LJYXZYO
X-MailFrom: kath.rafael2030@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: grace.graceobia@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XHQBNP5T6WJC4VMKFGEX42HJ2LJYXZYO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

-- 

Dearest in Mind,

My name is Mrs. Katherine Rafael, a business woman an Ivorian Citizen
and born in 1961. I have a mission for you worth $3 500, 000,00 (Three
Million Five Hundred Thousand United State Dollars) which I intend
using for CHARITY.

I am a breast cancer woman and have told by doctor that I will die in
no distance future, now and want to donate this money for charity
through you by transferring this money to your account, to enable
people in your area benefit from it.

Could you be the one I will use in this noble transaction before I
will go for my surgery?


Mrs.Katherine Rafael
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
