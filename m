Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEA71A013A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Apr 2020 00:46:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A729311001C9E;
	Mon,  6 Apr 2020 15:47:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::941; helo=mail-ua1-x941.google.com; envelope-from=moh.kon01@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B96AC10FEE307
	for <linux-nvdimm@lists.01.org>; Mon,  6 Apr 2020 15:47:19 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id v24so608310uak.0
        for <linux-nvdimm@lists.01.org>; Mon, 06 Apr 2020 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nXLd6oCPiQhzrINfT4cIGOCPyS0LtCS3FD98DuQPLb4=;
        b=Kj1sgUde+iav4/GYHdxFn99vwk5iqVii2P7CtoPekoBXwApwgroHDsz+wKBpswnV0n
         OmCCFjaRdSM006P+kVzsPwbnfyqSy9Ya8C4skc9fRIHLW2d85WvpK/SxGoXeGh3GmAPI
         HpZewf4iouY0fWk9jqvsiLoWwddDm9e15fuTe1sxLO8ZcCq6B200mUqLrk2w/Qf3MnBX
         ViBSJ2qtrfxLYnTEVzq2uvsRIGEwnlkBBQEis3XoF1o1sjDGgoEHnAwqeOSBbI/MzyTA
         KH0vq5zjGkK58SvPvOkZEkZgwORR0feRV5fTNwCcuNLIrKASN0K38MsyUzwSQjzAD/sv
         gfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nXLd6oCPiQhzrINfT4cIGOCPyS0LtCS3FD98DuQPLb4=;
        b=pMaNXgTP6dn4QX8vLiowvwC9ALlfg+LC8RR4qpSfzfuha5j/lPLcXVRjhkYUzm0fb/
         SAYlzxI3NQ0IFfSzJlV7MJDsFmxYuF5YQYB0dd0pjn2JTiO46E0dSMiqkrylUmUWAPln
         ciumULp8j2t3kh1qmu9pYo14XQBRqihHnJkANkAio/uQ1FqfTYuS0Gyjh9jM39VgOotu
         5wvplZ1tqjYHkQNijX5v9LdFZTGxow9nqdIYLlMTDPwa6VLL4Kvyy+EbqeO6d4bLNfn8
         Ru9oF4Ssua8n3aiANTFK93zGE60Z4W8VfxV0N4+VCG/1C1iNCJD8xuSmh3WZCRVbGjDU
         0JYA==
X-Gm-Message-State: AGi0PuaOKqYLJ6J3xO5UfaPUZwHfRXUWbo1aHtOLfAtslQccQGx7DTUZ
	bc0YREgwyF8OMVbElDKqk0kgjr+eXVmv/tOPYbs=
X-Google-Smtp-Source: APiQypJa1DJpTFfIjpoWAAvwiYF7DqOA23ikuZb3LR+An30bkKuCF4nPWtOjBd72be7Ip57VIGfCJtvXItACtRKPmUI=
X-Received: by 2002:ab0:45d3:: with SMTP id u77mr1513132uau.27.1586213188757;
 Mon, 06 Apr 2020 15:46:28 -0700 (PDT)
MIME-Version: 1.0
From: Mursan Mohamed <mur.moh001@gmail.com>
Date: Mon, 6 Apr 2020 15:46:17 -0700
Message-ID: <CAOkEvqxg_-iJCd-R-gyxT=u6e5cPd7-5E-=5NWnzqUCL8-u3+w@mail.gmail.com>
Subject: Waiting For Your Urgent Replay.........
To: undisclosed-recipients:;
Message-ID-Hash: FU4COK4ELGKTEBKK5LX3ATQ3N2LY3CYQ
X-Message-ID-Hash: FU4COK4ELGKTEBKK5LX3ATQ3N2LY3CYQ
X-MailFrom: moh.kon01@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FU4COK4ELGKTEBKK5LX3ATQ3N2LY3CYQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

My Dear,

How are you together with your family? I hope all is well. Considering the
fact, I did not know you in person or even have seen you before but due to
the true revelation that I should share this lucrative opportunity with
you, I have no choice other than to contact you. So, kindly consider this
message essential and confidential.

first and foremost I have to introduce myself to you I am Mr. Mursan
Mohamed,from Burkina Faso in west Africa, the Audit and Account Manager
BANK OF AFRICA(BOA) in Ouagadougou Burkina Faso west Africa.

I had the intent to contact you over transfer of fund worth the sum of Six
million two hundred thousand us dollars. (Us$6.2m) for the betterment of
our life, I agree that 40% of the total amount will be for you and 60% for
me.

I need your urgent response on assurance of trust that you will not deny my
share when once the fund is transfer to your personal bank account.

Your urgently responses is needed through this email address:
mur.moh001@gmail.com  reply with your information as I stated it bellow
once I receive your information I will give you more details as application
and how you will apply to our bank on how to transfer the fund into your
bank account.

(1) Full names:

(2) private phone number:

(3) occupation:

Make sure you keep this transaction as top secret and make it confidential
till we receive the fund into your bank account that you will provide to
our bank.Don't disclose it to anybody, because the secret of this
transaction is as well as the success of it.

I look forward to hear from you call me immediately as soon as you receive
this message or email me urgent.

In sincerity,
Mr.Mursan Mohamed
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
