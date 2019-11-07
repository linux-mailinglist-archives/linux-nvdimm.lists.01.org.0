Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB3F37B8
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 20:00:28 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C70F100EA622;
	Thu,  7 Nov 2019 11:02:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com; envelope-from=wkyo.choe@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 71963100EEB95
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 11:02:48 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id k7so2170470pll.1
        for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 11:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1h0qAmaBOMYVN8tpswJCgOXpJ6tYYHFZGKxooJ3aJco=;
        b=QWNtHFLSe7fZ3CjRXtEV9tnRMIno/yKY/u8A3NFeehYM07cHY+ofpVze6wf76R0pvF
         Kz4V1dpE46AbqLAGZ0In6k7Oshuns41T1UxcoApljbNNpC3ufZxgDfhKADHceeh+LRZW
         wAeMPK1bwwxJhK9KKpOs/8OI1Lf8xVoqUXI0U3c10YsXsHoaPavgvFfqs9EUrAryLEJR
         gNVhW/nPGr3PvAsh/v07iEnCsjipsrUci0+L3qV6YoJ8Whh4spjYwo72HfIjTrdT4vyA
         NeumJQTKfK/Ox51XZPLXCADRQ0sWq6PGs+qiZnWCSqSzNCPD86+bFq+e9z+QIJ4YQLOY
         VbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1h0qAmaBOMYVN8tpswJCgOXpJ6tYYHFZGKxooJ3aJco=;
        b=sblXDC2L0XJlSdMRVrc2O3ewXIA5bRMfIxJG8R92KeiX3vkvu3Th6egNwudZv4FMSf
         ZXYzun/AnOcYaW7qIXwYoMkCYCzoaHXcJ1LoOai/stSb6XTGM05LhceWwe66zbXu5UX0
         tmABMJ+h82t4Tm3A9CVgf56ARgbPd1zV9Rb8T2go63sgRYJ7d1tb8AxActvPvGo9En5y
         Wxt+WeAohlo4EotUaeHc0jCRDaaQYVRB8TjPuIfYqwxNTD68/99pZII4VBfnnugN2kTw
         U2uZp/LBKSfwK7OOtynikLnKTSOTrfS5bag+ud7fLBCGGIYLWRA7254xvAcmfOMgcb0E
         98Fg==
X-Gm-Message-State: APjAAAVjJa8SIJbO9FoEluwIbM9gR55XkdLoCl2xpJgnmSz8dGiWANOr
	pyTeEKgin45mgqXc6TCliNR8KM/X
X-Google-Smtp-Source: APXvYqy7SmRLBH7zSDBu34+ttA+3z3CnvKwB8KCHVLmu8OKcrqmhP1589a3oKoLQI11+peaKX4AL/A==
X-Received: by 2002:a17:90a:2662:: with SMTP id l89mr7527858pje.72.1573153223320;
        Thu, 07 Nov 2019 11:00:23 -0800 (PST)
Received: from swarm07 ([210.107.197.31])
        by smtp.gmail.com with ESMTPSA id v16sm3473167pje.1.2019.11.07.11.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Nov 2019 11:00:22 -0800 (PST)
Date: Fri, 8 Nov 2019 04:00:18 +0900
From: Won-Kyo Choe <wkyo.choe@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [QUESTION] Error on initializing dax by using different struct
 page size
Message-ID: <20191107190018.GB1912@swarm07>
References: <20191107152952.GA2053@swarm07>
 <CAPcyv4j-rSy-T5Qv6GbcDcmUerhQQYsMKbUY7EaGHz-GecKDtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4j-rSy-T5Qv6GbcDcmUerhQQYsMKbUY7EaGHz-GecKDtQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Message-ID-Hash: SYAMMARCBQIGFKXQAFDJ2X5G2IZNJAQ5
X-Message-ID-Hash: SYAMMARCBQIGFKXQAFDJ2X5G2IZNJAQ5
X-MailFrom: wkyo.choe@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SYAMMARCBQIGFKXQAFDJ2X5G2IZNJAQ5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 07, 2019 at 07:54:21AM -0800, Dan Williams wrote:
> On Thu, Nov 7, 2019 at 7:30 AM Won-Kyo Choe <wkyo.choe@gmail.com> wrote:
> >
> > Hi, there. I'm using Opatne DC memory to use it a volatile memory. Recently,
> > I found that if sizeof(struct page) is above 64 bytes (e.g. 128 byes),
> > `device_dax` cannot be initialized when system boots. I am aware that
> > for some reason there is a function, `__mm_zero_struct_page`, which limits
> > the size of struct page when it exceeds 80 bytes. However, due to the
> > research purpose, I do not use that constraint and I'm quite certain
> > that using different page size is usable in main memory. So, I'm
> > wondering why this is not possible in persistent memory and which
> > patches are related to this problem.
> >
> > I will attach the system log for clarification. The test is run in
> > linux-5.3.9 and linuxt-5.3-rc5
> 
> How did you manage to build the kernel with a 128byte struct page
> size? This build assert in drivers/nvdimm/pfn_devs.c
> 
>                 BUILD_BUG_ON(sizeof(struct page) > MAX_STRUCT_PAGE_SIZE);
> 
> ...will start to trigger in v5.4 to explicitly prevent this going
> forward. See commit e96f0bf2ec92 "libnvdimm/pfn_dev: Add a build check
> to make sure we notice when struct page size change" for more details.
> 
Thanks for the related commit. The kernel that I am using (5.3.9 / 5.3-rc5) does
not have the assert so that I was able to build it by little bit modifying lines
in include/linux/mm.h

        BUILD_BUG_ON(sizeof(struct page) > 80);
        ...

, which is quite similar with the assert you referred.

> In general 64-bytes per page is already expensive 128 bytes is a
> gigantic struct page.
Yes. I am aware that issue. I just wanted to add hot-page tracking
feature by inserting some data structure collecting it inside struct page
but the size is matter. I should find another way to get that stat :)

(Sorry, I should've put cc on this mail)

Thanks,

Won-Kyo
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
