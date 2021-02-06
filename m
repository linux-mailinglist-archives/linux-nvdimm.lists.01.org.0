Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86974311DBD
	for <lists+linux-nvdimm@lfdr.de>; Sat,  6 Feb 2021 15:38:43 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 98A41100EBB81;
	Sat,  6 Feb 2021 06:38:41 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com; envelope-from=stephennbada@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2AE44100EF271
	for <linux-nvdimm@lists.01.org>; Sat,  6 Feb 2021 06:38:37 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id v1so9841454ott.10
        for <linux-nvdimm@lists.01.org>; Sat, 06 Feb 2021 06:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=k6g4h14QCOZxUuS0WtdOy5Cv/enfoTR1UoK0M3h8ZEcrHsx3vZ44qFuL7veaWNn9lj
         OLKNbz5IAYtLrBr8I5rQ5XUXP5RpE9ePifi5VYlcueXNltzLELCAG1hgh5HhRiemP7Zd
         us/ViSwfZDr++uFa/xe04YpZl6B2bh12HAKR5z6ExoSPJ66vrb3MLKOo9sYIkkT4rgU8
         Bes1o8LMnAqumSnd2YioV3Hb8n/krxj/6aElKh1IrYzQous3ZUJhjsdVo3nEooIVpihu
         IKSuzNUUFSw89UWMgkppKRD8zk4dcawcUSmUcqHZwKhbFSR+4O2jTJvmrcrH/c1T8LGw
         eePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=LS+IkiPXGRRTbT8KDxY5T/jhMn3gRAW7ja2IeGlHDjKj7t2Qbz2YD55k03Qlb4zXYd
         Nu6tnGR5ptMlPBs/tubawvzs49cP9aFU7Dkh6q1po2J+aStBW8FJxlDRBqHPGZyX2yyZ
         9E66PwdpaoZhC8KNwvsINVkDqin2kgFK8eEHgtanlxrOrNXP7MTRKHebvdYRezmJqTdM
         iR8I4xk8+O2T2k+fhSWpMe3ahPkjfyJlfsqZl1LlV5MKz4MzqrPgNuOZeSBJqZ1P98Em
         em7fb+tmhaYBbJ49q36Ct0OnrqtDC4rou3CSXcKhGma4eI7h1wma+uNzNJyfmw6A3OXE
         qbTQ==
X-Gm-Message-State: AOAM530bKcdirE6/A0qFj3BqcpgI5TyDtmvj0fEZ048gnaHIcqd3H94j
	8dBG+auHKgWGmTl3sxHh+gmuMLHAR9UzuNk/9lg=
X-Google-Smtp-Source: ABdhPJy50OWDS13imtA1XFGJzGjBXx0EQEZx8DuBWLPVcnuyiwHX/pGSFbInQDBq+ZPoUA762HXZDAYhvWRXue7Z66A=
X-Received: by 2002:a9d:69cf:: with SMTP id v15mr7280167oto.122.1612622315687;
 Sat, 06 Feb 2021 06:38:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:3e4c:0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:38:35 -0800 (PST)
From: Barrister Daven Bango <stephennbada@gmail.com>
Date: Sat, 6 Feb 2021 15:38:35 +0100
Message-ID: <CAO_fDi-7cZzW18vF3SsjEC8f8hjQR+6f2gZbxoRKNp4R3q+nXA@mail.gmail.com>
Subject: 
To: undisclosed-recipients:;
Message-ID-Hash: LX5RGVGFYSGPKEORF3W5WLJ4Y536YLXV
X-Message-ID-Hash: LX5RGVGFYSGPKEORF3W5WLJ4Y536YLXV
X-MailFrom: stephennbada@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: lawyer.nba@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LX5RGVGFYSGPKEORF3W5WLJ4Y536YLXV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

LS0gDQpLb3Jpc25payBmb25kYSDEjWVzdGl0YW5qYSwgVmHFoWEgc3JlZHN0dmEgemEgbmFrbmFk
dSBvZCA4NTAuMDAwLDAwDQphbWVyacSNa2loIGRvbGFyYSBvZG9icmlsYSBqZSBNZcSRdW5hcm9k
bmEgbW9uZXRhcm5hIG9yZ2FuaXphY2lqYSAoTU1GKQ0KdSBzdXJhZG5qaSBzIChGQkkpIG5ha29u
IG1ub2dvIGlzdHJhZ2EuIMSMZWthbW8gZGEgc2Ugb2JyYXRpbW8gemENCmRvZGF0bmUgaW5mb3Jt
YWNpamUNCg0KQWR2b2thdDogRGF2ZW4gQmFuZ28NClRlbGVmb246ICsyMjg5MTY2NzI3Ng0KKFVS
RUQgTU1GLWEgTE9NRSBUT0dPKQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0
cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVh
dmVAbGlzdHMuMDEub3JnCg==
