Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A20E32268C
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Feb 2021 08:44:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 78F17100EB32D;
	Mon, 22 Feb 2021 23:44:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::d2c; helo=mail-io1-xd2c.google.com; envelope-from=rivaldosetiawan135@gmail.com; receiver=<UNKNOWN> 
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 734DF100EB829
	for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 23:44:08 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id q77so16149771iod.2
        for <linux-nvdimm@lists.01.org>; Mon, 22 Feb 2021 23:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oOjpQOVKfOytD3teonOuwoswL58gg0dEJ9w8KU55v1o=;
        b=lKT0LCRiGNtNRrNLp69EU1Tb/nL+pbTyh0GhaRlWJ3P66nLMEzXb4n6zsmcA/Nd8Uz
         wNMH8AeP246STsgF9ESm0LSiYEuhgiwYMzoJMKZuTGbx1h0MSXA0qkx46jGL/QoMDy+F
         8QjJbIO9hEW8rm/NG2J+49620mupsoGFMnMKcKq78T2YIk/Ngrovca8YN3aEqnegpE/e
         7nzevp3o+IHIfCvxG3cu8AG4AhqG2lEWiNjsO0WYTTaEj9sW1/StGIMpoWTs8KuoE9db
         q3hxPP9CqVgzb5dJtKKWVsyGSzVOEOkVxIg1GhuVWboEVJv2JQ/djE/J3W2WJqy2OhD2
         wNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oOjpQOVKfOytD3teonOuwoswL58gg0dEJ9w8KU55v1o=;
        b=QAr9ImFvDiLN82Xy1MyMVNpS1yRyxaZu1v45PE9PAiiUmtdbcGiwqhJN8wq9JJuYzm
         C13nYheaMbFuIFTSjmfbzc1hL78rV8VMT/eX/oVWPGxExPuFKojpirAc/MaCxE7XTohF
         KX8H4YMfaRBhYssQzy7o7HA9JtvLFYyUBQDbJtrJulRv+mOdusNqihYdWNg4l6I5+gby
         DTI/HvhK3gll9V0viwDsWWFJyOJyabLmQ/Q63p1xY7XQaQyL9U4ppMk5/sXSqk15SToj
         2FjeDIoHE4+uIdiTfyedstxetXLUODgZzhM63mNo2UIVcltw4hpzqslcOQQHpbJ3rWLg
         kn4Q==
X-Gm-Message-State: AOAM5332Z+i4jCrhNa6X2xGyMwfYVDMJYmpF2wq9LXNth//d7xMk8OCX
	tI7iSmCgdukQzwE35LHLu6yrLBb6iIVdMJsuh/E=
X-Google-Smtp-Source: ABdhPJx/nE794KfAD6RQZlHjZ9P4ybr33POj8sf5d+DzUO7ByBkPQRyfHLFQ3OmgO08c1otwhsxUcXOImgn9epvaJ9s=
X-Received: by 2002:a05:6602:26c6:: with SMTP id g6mr18608020ioo.150.1614066247876;
 Mon, 22 Feb 2021 23:44:07 -0800 (PST)
MIME-Version: 1.0
From: R Samudra arc <rivaldosetiawan135@gmail.com>
Date: Tue, 23 Feb 2021 14:43:56 +0700
Message-ID: <CAP08ep3Owi9WrQttisN4fq461K8y9cp3aARj=2mzaegxiHNiYg@mail.gmail.com>
Subject: Re: [PATCH daxctl v2 5/5] daxctl/test: Add a test for daxctl-create
 with align
To: joao.m.martins@oracle.com
Message-ID-Hash: DBR55YITRWVZPIABICA33PEIDOWMTU2V
X-Message-ID-Hash: DBR55YITRWVZPIABICA33PEIDOWMTU2V
X-MailFrom: rivaldosetiawan135@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DBR55YITRWVZPIABICA33PEIDOWMTU2V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

*In-Reply-To*
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
