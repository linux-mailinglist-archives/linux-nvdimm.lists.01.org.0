Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D42D1A3EA9
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Apr 2020 05:20:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3823110113FDC;
	Thu,  9 Apr 2020 20:21:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6771010113FDB
	for <linux-nvdimm@lists.01.org>; Thu,  9 Apr 2020 20:21:24 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p6so826635edu.10
        for <linux-nvdimm@lists.01.org>; Thu, 09 Apr 2020 20:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAR1xKXQ/6gSUj0Ogzf2Ewl0mpmOIt6zamUooDlTX/g=;
        b=b/DDYohpx7pjLdjmFSs+Ea0BqLkMFG6eGE4j/+05FJpw2vI8hU1khQwdX8W1aWJJ24
         9pGNClqljEROXPEV3vnX58OfX4K2ArP0nkvjtB1Da1UnK5paVyJ9Y1YC28/324nHQdFQ
         BEqTXASLQ+v8vel62Q1MkreXIAL8WYdlZwsk3/LYCANONUlj30ublaG5hp/wiyTdxCQR
         /sRL3io+YLxdrAV5SCm3tAvkMBP0P2tVxSBFAAOtwYFqNAORSMSm95FPOeXIA91p2Vt0
         nvrvx7p8XqroCeIPxCcABnv5+pxadlQaMS3KGNp7D39l7DtIphnSOI3mDS6/mRxUyvl8
         OXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAR1xKXQ/6gSUj0Ogzf2Ewl0mpmOIt6zamUooDlTX/g=;
        b=IcerkeEEHJWi4dmqXSNq6/+qNcQSfF3ZLoTXjXran/ZtnbyBQNauOQE5YtHS5YmLAV
         XWhWOhgglYqVzPqCdUtXuG5Y9Ekr8/HB5vPw5CK2T2IvZCsYBPbBuxJk3QTromnHuTsi
         kpX4htTzj70jS1kGA+gTJSkXSxIdlDThLOARlpjxKh0Z+TCiNIzP2KWaawBLvq1wPyFP
         L5/Wk2EiHBTEzOxeQ/j9vIBRWLGDWMXqI8BtbY+jnufuuzHSS2r1+MHpU9uXcrVkZ+R6
         z9l+ztLTegZ+GP/5HCospta8I2XK4pWURnFqpCc/vs6aeRb81PW0yit4fNsFWKKREviC
         1L8g==
X-Gm-Message-State: AGi0PuYWMnKvQKZoQhu94/p4XrpTnJpJlpVMImAlg5C3Eb8Bc7Zvsn4j
	R0Ht8Myi/+Hx3YeVYpjdimCBWOZCsLyPyG5Qua4J1w==
X-Google-Smtp-Source: APiQypJPw8qHIPc9O+4f4o2G6xkzeYP/Kgh5ObTcLrol+xcWnB7GXfgQkcC8FRX30+ZniVaUVJ7eLLXOtpKBDhHGY/o=
X-Received: by 2002:a05:6402:22b7:: with SMTP id cx23mr2862095edb.383.1586488833479;
 Thu, 09 Apr 2020 20:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <c9f9975c-b4ae-1234-56ed-dce4b052080d@huawei.com>
In-Reply-To: <c9f9975c-b4ae-1234-56ed-dce4b052080d@huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 9 Apr 2020 20:20:22 -0700
Message-ID: <CAPcyv4hH7nO0_-pMckzWbKGckKy74KD7nWERB3q7TLrVTj+UXQ@mail.gmail.com>
Subject: Re: [PATCH] nvdimm: cleanup resources when the initialization fails
To: Wu Bo <wubo40@huawei.com>
Message-ID-Hash: TV7QM4T3CDGKMJAUMH3M2U4CSMKKHOMO
X-Message-ID-Hash: TV7QM4T3CDGKMJAUMH3M2U4CSMKKHOMO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, liuzhiqiang26@huawei.com, linfeilong@huawei.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TV7QM4T3CDGKMJAUMH3M2U4CSMKKHOMO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 9, 2020 at 8:16 PM Wu Bo <wubo40@huawei.com> wrote:
>
> From: Wu Bo <wubo40@huawei.com>
>
> When the initialization fails, add the cleanup resources
> in pmem_attach_disk() function

Are you familiar with devm?

devm routines take care of this automatically on driver probe error conditions.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
