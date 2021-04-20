Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 453A7366040
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 21:33:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 69657100EBB81;
	Tue, 20 Apr 2021 12:32:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D436D100EF271
	for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 12:32:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id k17so6983916edr.7
        for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CeykSAZI90ujQ36EqZV5t9vjKLz3qOJxleoK2VZMDEQ=;
        b=h7ND65/2bTQV5sECygtsgHLlJLV6CmUcPs5PTFxMtc5gX0SgwqTfEoqiedHIt0PmaL
         VQL94Ost3SRLMDK71qcFPng5iVODZivCqLDGx8Cd+ylWX9slFJknB1Ijaz171uj1OHCu
         pIW9WhLsEPkYdDKaSs/LA4ZhyriN8Raan3BlYsRuk0qBxZEJabHxBqi+W/2cX1SKvVY8
         DyYYfziamSk0hUO64IbrT3cLjLdYrUaNa5UsGfqosGEo0BTCUPVW1h3wUr4qRafdqffj
         +KadtNdwcrceKfLLopkaXWiBtJzEnuazKo9hNpRiZrZwsBvxCxA3bF3Me7Lb7jB7E6UW
         nzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CeykSAZI90ujQ36EqZV5t9vjKLz3qOJxleoK2VZMDEQ=;
        b=Nu+enVM4f1qJUZ11s3Xpm2v6Ib5GeYsz7Om7a6Q5CG/crLCMiJ+EY73jkbI/2mtu79
         RBH7/xVbhELlUITSePe9ayK8xt5qDn7ZYkMZ43quZqT9o9gTw9vHUhHGhlCXsU6sNS+w
         cwZ+0aOl1RbUGVdZjGR9FpS6bzcDm2qhWdd089L53ZLZhXnev+kivlrtGQ8ugmRxa6rN
         F57QMAMr7btas58LbWPB1Fg3ddcMaof1/b4m13lWbxIjPrJvZegdiOnmR2V2wWNK24y5
         vbT0DuxWt1mqUKVP75uaiyOyOR0kKHsxvY9D1aK7pSuLNLADj89lxE9oOvwI2k3MhB+c
         QfrA==
X-Gm-Message-State: AOAM530gA6Sq83QjpOInUrAeBZhOZ+FmIMFvl29J2ID5JBky89jL1g2Q
	aD+WWm56yhxDgs0cAGP0/rTg6BztNJmVSO9KE73ePQ==
X-Google-Smtp-Source: ABdhPJwoHDKggO51DoyBf4DW1dLBL0p5lO7dSdRN5XmLDceKbF7ENZxcl1MKXX+InaL/b6kc++73caSq3OlYa/fsdSc=
X-Received: by 2002:a05:6402:35c8:: with SMTP id z8mr9829147edc.210.1618947172905;
 Tue, 20 Apr 2021 12:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210419112725.42145-1-wanjiabing@vivo.com> <20210419160411.GG1904484@iweiny-DESK2.sc.intel.com>
 <874kg1yt0o.fsf@fossix.org>
In-Reply-To: <874kg1yt0o.fsf@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 20 Apr 2021 12:32:43 -0700
Message-ID: <CAPcyv4hD8gGdT6LABSBHRG2Bb59Zp1MycdQjB-CF9QHY-VHepQ@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm.h: Remove duplicate struct declaration
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: ZY4R4RNBVOS6RYGJLXMTKNUQLKF2VVNB
X-Message-ID-Hash: ZY4R4RNBVOS6RYGJLXMTKNUQLKF2VVNB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Wan Jiabing <wanjiabing@vivo.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kael_w@yeah.net
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZY4R4RNBVOS6RYGJLXMTKNUQLKF2VVNB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 20, 2021 at 6:39 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> Hi Ira,
>
> Ira Weiny <ira.weiny@intel.com> writes:
>
> > On Mon, Apr 19, 2021 at 07:27:25PM +0800, Wan Jiabing wrote:
> >> struct device is declared at 133rd line.
> >> The declaration here is unnecessary. Remove it.
> >>
> >> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> >> ---
> >>  include/linux/libnvdimm.h | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> >> index 01f251b6e36c..89b69e645ac7 100644
> >> --- a/include/linux/libnvdimm.h
> >> +++ b/include/linux/libnvdimm.h
> >> @@ -141,7 +141,6 @@ static inline void __iomem *devm_nvdimm_ioremap(struct device *dev,
> >>
> >>  struct nvdimm_bus;
> >>  struct module;
> >> -struct device;
> >>  struct nd_blk_region;
> >
> > What is the coding style preference for pre-declarations like this?  Should
> > they be placed at the top of the file?
> >
> > The patch is reasonable but if the intent is to declare right before use for
> > clarity, both devm_nvdimm_memremap() and nd_blk_region_desc() use struct
> > device.  So perhaps this duplicate is on purpose?
>
> There are other struct device usage much later in the file, which doesn't have
> any pre-declarations for struct device. So I assume this might not be on
> purpose :-)

Yeah, I believe it was just code movement and the duplicate was
inadvertently introduced. Patch looks ok to me.

>
> On a side note, types.h can also be removed, since it's already included in
> kernel.h.

That I don't necessarily agree with, it just makes future header
reworks more fraught for not much benefit.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
