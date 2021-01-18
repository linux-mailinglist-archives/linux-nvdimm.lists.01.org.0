Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 046EE2FA848
	for <lists+linux-nvdimm@lfdr.de>; Mon, 18 Jan 2021 19:05:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 422D8100EBBBB;
	Mon, 18 Jan 2021 10:05:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com; envelope-from=wyasare@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C06B8100EBBBA
	for <linux-nvdimm@lists.01.org>; Mon, 18 Jan 2021 10:05:48 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id f6so7912473ots.9
        for <linux-nvdimm@lists.01.org>; Mon, 18 Jan 2021 10:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=gFKy1zCgtAtDIB32G/oIVZ2FiTBOLfrozfdxWbg5bDE=;
        b=f3b75IGwalDb7wGidNYd4E3nGQialyg/bAZ9aBZLgckyNsdgOhiJR7Y6ZTDEZphMyS
         rUAuoQV6Dj7VCCcDVB4OGYLAhYC7M2AfhP13dtsN7buI3CdM/5pvoV6JeVYB1UHtN2Wk
         wV3GENzrAV4P5HFBcWOZxlM2lB3mOKCt5+jrkpFmB3VUpSyhlg/Oc57DNKKCU2IArsUJ
         YNxk5PZJgPJUAYvpd06rfDw5DwilRuTEYPYSRRrFmKHbJ3m/sCrEwVXd1QpkgQJDk9ei
         8fnY5QeRxDvRtIEpmcvdywpXR2nlSc20+izMOQB39LUcHaTtEF5C9Z8+yYzKgExICkoc
         KeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=gFKy1zCgtAtDIB32G/oIVZ2FiTBOLfrozfdxWbg5bDE=;
        b=ITV05QaQVejEdpT5fser+b5KYGFbf7S/yPtV7RKDtO0zsfXJ2FBseMiGySYYwr6TKz
         JSo1sHLd9BxsAtPVgyzwquafS4rlv24W2x0Zd8w9/JcC/RjVp4Xw2ZJGBXbiki3y+7hA
         EMfQlmBI1YOkELsYzoiHL3ph4B9KuKbIr94oCMIrhNEGMQRyWCarOzrYECx8LD/OSvfk
         Kdd7qiKa+6g4iSogpjS2QBS3jyIEsxjlbiGzNY0jn7Rz8ORnKDp2AAFcesP9AuJrOHO2
         RnfdMMt6KaH0suYdfcuCDvsECFyZVSyeaC7C3AK/3iKw5KzjCheIj/G8bYEbvMmyDaaY
         cDOA==
X-Gm-Message-State: AOAM5322w2ZsI5yeq3J147kcjrJOz8Of7pJGyBNxIFUMsqX/q0J4BFb2
	Fsm6t5Mu9xFZv4nvf5e94r/NCnWYU7TznBsZuQ==
X-Google-Smtp-Source: ABdhPJxR6jg8VW367FZXGfhGI+gOKwBabyXB/g93gwBNKQGIOv+t43t0ogtGGn6/FAA7HFioBPmzWlj8RF5T/FxDNK4=
X-Received: by 2002:a05:6830:1482:: with SMTP id s2mr564790otq.296.1610993147267;
 Mon, 18 Jan 2021 10:05:47 -0800 (PST)
MIME-Version: 1.0
From: William Asare <wyasare@gmail.com>
Date: Mon, 18 Jan 2021 19:05:35 +0100
Message-ID: <CAA+vMpBpEJmATNmhD-tqJGYMDOh034wDDF3aS1ZXfHt=ThN4Mg@mail.gmail.com>
Subject: Greetings
To: undisclosed-recipients:;
Message-ID-Hash: AUZ454CU3BEKDEI5H2YNYOZZN4Z2L57U
X-Message-ID-Hash: AUZ454CU3BEKDEI5H2YNYOZZN4Z2L57U
X-MailFrom: wyasare@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: wlasare100@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AUZ454CU3BEKDEI5H2YNYOZZN4Z2L57U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

*FROM THE DESK OF MR.WILLIAMS.*

*Date: 18-01-21*

*Email: **wlasare100@gmail.com* <wlasare100@gmail.com>

*Greetings:*

*My name is Mr. William Asare, I am the Ashanti Regional manager of a bank
here in Ghana in West Africa. I am a Christian. I do not want problems but
I just hope you can assist me. I write you this letter in good faith.*

*I am in control of Seven million, Eight hundred and Fifty thousand US
dollars($7,850,000.00) and I Realized the excess profit from a contract
that was Awarded to a foreign company here in Ghana by the World Health
organization to supply ante-natal and Post-natal drugs to rural areas in
Ghana and other West African countries. This said money for the Supply of
drugs was first deposited to the Bank Where I work. With my position as the
manager, I trade with the Money in Ghana stock market before the
contractors withdrew the money for the said purpose. I deposited the profit
I made on Escrow call account and I did not declare this to my head
office.I am contacting you, to stand as the beneficiary of this fund
because as the regional manager I don't have to be involved with this kind
of amount. I can move this money to our offshore filtering center London
covering the region, but can I rely trust you to hold this money for me
until I arrive your country and pick it up you and myself deduct 50% of the
money as your commission. If you accept my offer you can contact me only on
my private email-address. If you do not accept you can forget to contact
me.*

* All I need is for you to get me a good current account in your bank where
I can move this money.*

*There are practically no risks involved, it will be a bank to bank
transfer. I hope you understand my situation.*

*Thank you and God bless.*

*Yours truly,*

*Williams. *
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
