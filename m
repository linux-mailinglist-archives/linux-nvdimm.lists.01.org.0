Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 030B326DEFF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Sep 2020 17:03:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 240F414DF4FAE;
	Thu, 17 Sep 2020 08:03:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f41; helo=mail-qv1-xf41.google.com; envelope-from=adrianhuang0701@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BD9B614DF4FAD
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 08:03:20 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cy2so1127549qvb.0
        for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+3nKTFg1j+gtogo3psrHR62C4JLO3RyVOfYLOEn6a4=;
        b=mylWO/60w7TdkycMsce2O5fJgIrfU+G8Id2ydH5apnAVHiTSxD93T8tjqWdSkTgxzP
         o+1IbNdP6/nzoDUmLhjWRTp6P+16cCQQsJ4kMvLwYsivf53XlSp722Mm1Dfz5Py9p0uj
         dN2s7oo1mQxojK5E9ktinL/TjM7BcrWF0uXzLsTwz4Ni2mtmhXXiorETr7deK9QUNARA
         Xha+fHBXlY/j63VvMbkbrhaN9vD4JHryjnv6QtdgBp57A1bBfnRMHCroRlMgdzKxMudc
         tx8/DVR255jNiP6WL0eum/STPYpEQhWmAIQEDVFYaxnGNkm1rsjtkVGBcmZGhvwpfLA1
         Pd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+3nKTFg1j+gtogo3psrHR62C4JLO3RyVOfYLOEn6a4=;
        b=HOZpd8B8FnKUKMcSOUHLT4h3XeILsePJlOYu3hkvOoxQbeeaPDBjpV+SXiwcGZweQ4
         KN6/CySe2kTaSXDReLuQV6h0pkyxeTdx29r2wN9od5w25GJaX/aLsqchYi5DtEs8yC6I
         CZC9hnwtphkTlkffqTB80jV0qi1kCcpxo27hYVCN+ROCgqS9+6F9XxPygDf+D2n0cW2m
         iWNX2VDTreCFx3acAO9VjdZHKz2PH9FYdlMkCqBoRtYh71cxBWSs+TqsTEUSxOPLpH4y
         zmfTu6pN7qVFl6Oup6EE+oZv+rNzDvD5BW1/f0QBQYhtlVCzu0OT/WOr4jl4OcrJFuIp
         gaQA==
X-Gm-Message-State: AOAM533CjXMJXOdbHNFttcpGhkxik2MUGP7ljSYLa2f4SNRXpuRofqMJ
	FK6F693IC3OcLitWj3dIm1RhLMYwpsi8ipCN+Lg=
X-Google-Smtp-Source: ABdhPJyeKnexOrJrhdGyvgR+y3G0LstfNMiP7txqGd6I9cFAZ3mwclmia0bGG/WEy/TXagWa/Jc6x6Ozue2XLBOI8jY=
X-Received: by 2002:a0c:abc5:: with SMTP id k5mr12387134qvb.40.1600354999528;
 Thu, 17 Sep 2020 08:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200916151445.450-1-jack@suse.cz> <CAPcyv4gfMY=k+SDsKWPPasZs9X=7schOgc=3VZSDj0kAbZcTTA@mail.gmail.com>
 <20200917104216.GB16097@quack2.suse.cz> <CAHKZfL0xC4OTe_HDg93HdinmxnpPVCAK3eweWCoo2CsbDTvNYA@mail.gmail.com>
In-Reply-To: <CAHKZfL0xC4OTe_HDg93HdinmxnpPVCAK3eweWCoo2CsbDTvNYA@mail.gmail.com>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Thu, 17 Sep 2020 23:03:08 +0800
Message-ID: <CAHKZfL2f233E6twOGLu9Kz9hb_-VPRdsh4Jdo2_g1WzfMg6z9A@mail.gmail.com>
Subject: Re: [PATCH] dm: Call proper helper to determine dax support
To: Jan Kara <jack@suse.cz>
Message-ID-Hash: B7STEZQE25VAMXHHO4OVXRSOX4N74P37
X-Message-ID-Hash: B7STEZQE25VAMXHHO4OVXRSOX4N74P37
X-MailFrom: adrianhuang0701@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Adrian Huang12 <ahuang12@lenovo.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B7STEZQE25VAMXHHO4OVXRSOX4N74P37/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 17, 2020 at 10:57 PM Huang Adrian <adrianhuang0701@gmail.com> wrote:
>
> Note: Still no lock after applying Dan's fixup. It shows the same call
> trace with/without Dan's fixup.

Sorry, fat-finger. Should be 'Still no *luck*'

-- Adrian
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
