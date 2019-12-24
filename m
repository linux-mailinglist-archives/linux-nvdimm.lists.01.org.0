Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D13129F1B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Dec 2019 09:37:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 909AA10113667;
	Tue, 24 Dec 2019 00:40:41 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::142; helo=mail-il1-x142.google.com; envelope-from=am19040@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 26FCB10113667
	for <linux-nvdimm@lists.01.org>; Tue, 24 Dec 2019 00:40:40 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id z12so16044917iln.11
        for <linux-nvdimm@lists.01.org>; Tue, 24 Dec 2019 00:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=LcGU1mt+nAQIi3eKcWZpiy7DqrkNG23tK1MNYV9CB+M=;
        b=VlyE5hkjIlVtebFVtbJSUDG1nq6yxqsP+CXAAvK16kEDCa9/FIjqePwKOUOUFxUPGI
         IobnBKqUZtvWs9liflZ3kccv66QhBRcGlV0NLmY+Uo4N83fE4acq5fKevjm3GVqyORPq
         V25kDNfLb/u3NDc8qTILa6U172uqigqrULaJBwbLq67hwZ4izN64H1YClKD775qzZNF9
         0l4JMYDmF4urkgDiYDNvOqEpGdvq+E73I4yTDC9aWLwqkTeAHCJ4Ixn//xPq6JLVBBNn
         aamV2t3zoMGAP8AF+RdWv4cRolj9/iVR4FvRYYpwL/EkEZCm6WUSjJi89kMXjGu5nUwC
         ihKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=LcGU1mt+nAQIi3eKcWZpiy7DqrkNG23tK1MNYV9CB+M=;
        b=d5KCFPlrdZSid5fqCAybUFmyLYtDAXm0/eujgreHdkDpHGr/mqTOcXKhH1OuleIFX5
         +1koNyiSsC0bwVcheiMEU8qWWX3OcK9zLPpNZgw6PSo3U2uHSwkN7IKLFed33KtDqyFZ
         +ge1grD6dhALITStaEXOg2Inf3eiJLO4D1X0HsYzo2qJxC/tPwXifluIZHLcOcE315gH
         Fu+EkURsvzErVQ9zybngjrAlieducfXV/+5Fk6Y4db043KnMT97mo8ajCyarkrg7sVtu
         +zz5PNgknQ9x7MpLe+QJ+a4DiIM0PtIJ+afXy7nGC7cv2onXfkt7UWywkGEyYY1SKsO3
         Tjig==
X-Gm-Message-State: APjAAAVWWIIoHTesq5Fk9WZCzdDcDXO2CO22X4PxIvCe6FbeFOh3h3c0
	RMzQVgkh8UPiWjtb417Jju5xlbhl5P8vvmniVyM=
X-Google-Smtp-Source: APXvYqxLrvnOpR+O6ofXnSEOnwrvGziUPmMlJTtG0DR2NirldWli2cXJyiYqfAfUdIRDZDD83uetmfvXHC6vAEF7nxQ=
X-Received: by 2002:a92:c50e:: with SMTP id r14mr29396039ilg.52.1577176639205;
 Tue, 24 Dec 2019 00:37:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5e:c244:0:0:0:0:0 with HTTP; Tue, 24 Dec 2019 00:37:18
 -0800 (PST)
From: Beth Nat <am19040@gmail.com>
Date: Tue, 24 Dec 2019 08:37:18 +0000
Message-ID: <CAEgaL+akE_7uuR+QBv+=W5npZ3Bg=jguaB4zU63CGVjztQeQyg@mail.gmail.com>
Subject: 
To: undisclosed-recipients:;
Message-ID-Hash: RXGXQNJPJNK3GKBWCZU5SJT2PTTML4EL
X-Message-ID-Hash: RXGXQNJPJNK3GKBWCZU5SJT2PTTML4EL
X-MailFrom: am19040@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: bethnatividad9@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RXGXQNJPJNK3GKBWCZU5SJT2PTTML4EL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

How are you today my dear? i saw your profile and it interests me, i
am a Military nurse from USA. Can we be friend? I want to know more
about you.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
