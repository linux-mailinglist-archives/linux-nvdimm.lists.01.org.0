Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E91E9B04
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Jun 2020 02:35:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F0CC8100E2AED;
	Sun, 31 May 2020 17:30:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=neswgood@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9AC12100E2AEB
	for <linux-nvdimm@lists.01.org>; Sun, 31 May 2020 17:30:44 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id p70so2971560oic.12
        for <linux-nvdimm@lists.01.org>; Sun, 31 May 2020 17:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8m2vH21LtFNB+gS/asMONT60NFVaE2D+t/meLNqUYZA=;
        b=Cn5CAbNnRrXMO7iU8nEdKpGI/aWBRDz9yWneMp7yKF8xvQu6nhAhFCj3jf4dYLMp5Q
         E/WzEF2WpT1yaEPD0vGCC6ZwXLczV7nZH3CKJlBH2rhtm0uIvBV31931PZ8g7v0EeYlf
         UM0YWOCM6BJW8W/XyWqtpuWZkpPCr3Gr7613twbAv8w3DPWpbybMd/sTuHk876Da81BQ
         G3bFK/jR1c6YcPpkIwsraHKGrps71RP+RuyMFFa/VMkGOzu4Kd/23q0CwBeauBVrEMIb
         vN4qeVxzhCY5tFHv/XRzdpkV/si4xbDhwgy50fuG76m1HKcFecPgOBq0xjc/bCrRAMX7
         7l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8m2vH21LtFNB+gS/asMONT60NFVaE2D+t/meLNqUYZA=;
        b=A1LY10hF42u6QnVN522RKzIVG9i1ZBGpzKX3qptuQBsXQW5u4fWNjEu7AGPCmZw3wy
         qUjcpswrIh8/auUrqc5KLwOUN3YhNF3vqR+5VpjA+YZlTzaAr8yghxsMtssVqa70oQNS
         3dA/V0IBIaaqR53TdI+gP2cohbeMo+ngRN6udWfDbI3x/eJGDuIZWbBFKB6RvmFh0082
         +UsF6+XveC7rkGxEvxiy8GrAg/5ECxd/RK5s5vLvwOhK4L/QuFjgx6oM3R5dHMOB2VVv
         u/6WsLtju+XESjw7RPGRUbj8UxzQojSVCEFA3xn6BvKDV2ajaaN3zBqr9FdMJ1K+qYXO
         86hw==
X-Gm-Message-State: AOAM530bhtCaY1857ULA3SAVjZiIdiEavcEiP/NWxD6RUypxbEjd58bq
	LH7IaLOQSFXmCXMU7V1+vHx/OoBLhSZxvsL07DU=
X-Google-Smtp-Source: ABdhPJyqO5bGqcUXIM61kqppNWmtqvvr6yaVWGuxOzcypboBhdixrD8EoxlnkOGRa4zlBvHnSJOYOmrcdG4difKDQBo=
X-Received: by 2002:aca:3c82:: with SMTP id j124mr12825343oia.62.1590971724918;
 Sun, 31 May 2020 17:35:24 -0700 (PDT)
MIME-Version: 1.0
From: Marvella Kodji <marvellapatrick1@gmail.com>
Date: Mon, 1 Jun 2020 01:34:55 +0100
Message-ID: <CAF0CuhDT32pv_tG8dcoWJ3Fd8JW=X3dWQE5iKnojJPEJoL7qwA@mail.gmail.com>
Subject: 
To: undisclosed-recipients:;
Message-ID-Hash: MLSZ7JBZJIMQBAHB7ELIK7VKM6DPG27L
X-Message-ID-Hash: MLSZ7JBZJIMQBAHB7ELIK7VKM6DPG27L
X-MailFrom: neswgood@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MLSZ7JBZJIMQBAHB7ELIK7VKM6DPG27L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

How are you doing
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
