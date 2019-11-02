Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF8EECE9E
	for <lists+linux-nvdimm@lfdr.de>; Sat,  2 Nov 2019 13:15:30 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CDDDA100EA621;
	Sat,  2 Nov 2019 05:18:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::141; helo=mail-il1-x141.google.com; envelope-from=tarhouni805@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6F871100EA61E
	for <linux-nvdimm@lists.01.org>; Sat,  2 Nov 2019 05:18:32 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w1so2070312ilq.11
        for <linux-nvdimm@lists.01.org>; Sat, 02 Nov 2019 05:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9x0D56ZwARqyAJI59crbpwifItY15fznRZNu+zcNOLw=;
        b=PwuUxjImECErzT94hYnDlsyzLzptNOCG63YlO6xlP2wzX6FjpJrCDRhtSSCKT4x4Xx
         g9n6FpCzc3Mxxx4bKGVFYRSXpYAH0EiYDXk8a+QueKSpzmpRZaf7oGxhoGxsTLgg2Jmh
         rO23n7fT8pWa+dfMCv5nyKQc7Clz38UqnVJ86f6bdW3fQy+VCDufLXo9cyhMnH1vgIgh
         CA82GPCOjH2W/4RPuin0JNyEnvPQGRSNMCPvLZ3LBzGMjTzPsAAQOqoOu1j0mWEbBMJc
         P412uM+Nzd3Zr49Ocs01Z1jocb7ynvgLMmbze2j/i/9l7KjRPjWqmZmWF7UGWHqFcCpF
         7ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9x0D56ZwARqyAJI59crbpwifItY15fznRZNu+zcNOLw=;
        b=qdtF+hhJH4FEpPHdsRvHzgdPVtrcmqHwI++kYiQ0PPDPphBYIGuR9t5XSCNtT2SbZB
         LZKwSlBoyYNlCRA40jIyvULEIdtCudKXdm0rM/MLY8vtVN0EVlMxRQHz1nmJxaEhCJpI
         UN2km8+wt9sXH5eimNR79Xb7HYwNQi7Vb7XpK/lQJNIZJtC4FeEV2oIjcjUTTUXSiLmu
         n7is89Onlz7G1i4Q2I1qO9WoqiK589u3Ou1VPnD+ARcAXwaJw26R+ipUXWgZBAWEKpm6
         d0a70XQ4U/7S8hGhhtjCao/HuSOhGobY2F03HdoC7/VRkTcVFjyjetKu2ssFfo2q+Ekf
         0kXQ==
X-Gm-Message-State: APjAAAWMSty6z3ITBsGBJmAdWHxT1YoFmEE8vFTGhY4U+3i3ptHilrgI
	u01X2MIaaB3BNHv+zw3WWrnhECD1XrfAdW64ZUM=
X-Google-Smtp-Source: APXvYqxECQHOkIRQO19J5kwo/nJtSM/RZSTzQKY+2NNmWQ8lnw59itCApFh1vEE2yNo+imbxxfWlYapVjih/JcXudD0=
X-Received: by 2002:a92:6f0b:: with SMTP id k11mr7203448ilc.148.1572696924152;
 Sat, 02 Nov 2019 05:15:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:4a10:0:0:0:0:0 with HTTP; Sat, 2 Nov 2019 05:15:23 -0700 (PDT)
From: Miss Basirat Ibrahim <tarhouni805@gmail.com>
Date: Sat, 2 Nov 2019 13:15:23 +0100
Message-ID: <CAGD2OuYFSBx2YMbVrUmBWekNsZAjG4+00hKCrtjs8CDFrMQNbA@mail.gmail.com>
Subject: With due respect From Miss Basirat Ibrahim
To: undisclosed-recipients:;
Message-ID-Hash: SBKBNPLBT3CGAJURPLPL4G2EWCEZZBJZ
X-Message-ID-Hash: SBKBNPLBT3CGAJURPLPL4G2EWCEZZBJZ
X-MailFrom: tarhouni805@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SBKBNPLBT3CGAJURPLPL4G2EWCEZZBJZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

My Name is Miss.Basirat Ibrahim from Libya, am 23 years old, am
presently in St.Christopher's Parish for refugee in Burkina Faso under
United Nations High commission for Refugee,

 I lost my parents in the recent war in  Libya, right now I am in
Burkina Faso, please save my life i am in danger need your help in
transferring my inheritance, my father left behind for me in a Bank in
Burkina Faso here,

 i have every necessary document for the fund, all i needed is a
foreigner who will
stand as the foreign partner to my father and beneficiary of the fund.

The money deposited in the Bank is US10.5 MILLION UNITED STATES
DOLLAR) I just need this fund to be transfer to your bank account so
that i will come over to your country and complete my education as you
know that my country have been in deep crisis due to the war .And I
cannot go back there again because I have nobody again all of my
family were killed in the war. If you are interested to save me and
help me receive my inheritance fund into your bank account with utmost
good faith

Please get back to me.through my private Email    hm36813999@gmail.com



Miss.Basirat Ibrahim.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
